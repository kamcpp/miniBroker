import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:grpc/grpc.dart';
import '../services/theme_service.dart';
import '../config/ui_constants.dart';
import '../utils/broker_config_helper.dart';
import '../generated/prtagent/v1/agent.pbgrpc.dart';

/// Dialog for editing an existing broker configuration (except broker name)
class EditBrokerConfigDialog extends StatefulWidget {
  final String configDir;
  final String fileName;
  final Map<String, dynamic> existingConfig;

  const EditBrokerConfigDialog({
    super.key,
    required this.configDir,
    required this.fileName,
    required this.existingConfig,
  });

  @override
  State<EditBrokerConfigDialog> createState() => _EditBrokerConfigDialogState();
}

class _EditBrokerConfigDialogState extends State<EditBrokerConfigDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _brokerNameController;
  late final TextEditingController _grpcEndpointController;
  late final TextEditingController _apiKeyController;
  late final TextEditingController _participantIdController;
  late final TextEditingController _participantNameController;

  bool _isSaving = false;
  bool _isTesting = false;
  String? _errorMessage;
  String? _testMessage;

  @override
  void initState() {
    super.initState();

    // Extract existing values
    final broker = widget.existingConfig['broker'] as Map<String, dynamic>?;
    final grpc = widget.existingConfig['grpc'] as Map<String, dynamic>?;
    final participant = widget.existingConfig['participant'] as Map<String, dynamic>?;

    _brokerNameController = TextEditingController(
      text: broker?['name'] as String? ?? '',
    );

    // Combine host, port, and useSecure into endpoint display
    final host = grpc?['host'] as String? ?? 'localhost';
    final port = grpc?['port'] as int? ?? 50051;
    final useSecure = grpc?['useSecure'] as bool? ?? false;
    _grpcEndpointController = TextEditingController(
      text: BrokerConfigHelper.formatEndpoint(host: host, port: port, useSecure: useSecure),
    );

    _apiKeyController = TextEditingController(
      text: participant?['apiKey'] as String? ?? '',
    );
    _participantIdController = TextEditingController(
      text: participant?['participantId'] as String? ?? '',
    );
    _participantNameController = TextEditingController(
      text: participant?['name'] as String? ?? '',
    );
  }

  @override
  void dispose() {
    _brokerNameController.dispose();
    _grpcEndpointController.dispose();
    _apiKeyController.dispose();
    _participantIdController.dispose();
    _participantNameController.dispose();
    super.dispose();
  }

  Future<void> _saveConfig() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      // Update the config with new values
      final updatedConfig = Map<String, dynamic>.from(widget.existingConfig);

      // Parse endpoint
      final endpoint = _grpcEndpointController.text.trim();
      final parsed = BrokerConfigHelper.parseEndpoint(endpoint);

      // Update grpc settings
      (updatedConfig['grpc'] as Map<String, dynamic>?)?['host'] = parsed.host;
      (updatedConfig['grpc'] as Map<String, dynamic>?)?['port'] = parsed.port;
      (updatedConfig['grpc'] as Map<String, dynamic>?)?['useSecure'] = parsed.useSecure;

      // Update participant settings
      (updatedConfig['participant'] as Map<String, dynamic>?)?['apiKey'] =
          _apiKeyController.text.trim();
      (updatedConfig['participant'] as Map<String, dynamic>?)?['participantId'] =
          _participantIdController.text.trim();
      (updatedConfig['participant'] as Map<String, dynamic>?)?['name'] =
          _participantNameController.text.trim();

      // Write back to file
      final filePath = path.join(widget.configDir, widget.fileName);
      final file = File(filePath);
      final encoder = JsonEncoder.withIndent('  ');
      file.writeAsStringSync(encoder.convert(updatedConfig));

      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: ${e.toString()}';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Future<void> _testConnection() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isTesting = true;
      _testMessage = null;
      _errorMessage = null;
    });

    ClientChannel? channel;
    StreamController<PingRequest>? requestController;

    try {
      // Parse endpoint
      final endpoint = _grpcEndpointController.text.trim();
      final parsed = BrokerConfigHelper.parseEndpoint(endpoint);

      // Create gRPC channel
      channel = ClientChannel(
        parsed.host,
        port: parsed.port,
        options: ChannelOptions(
          credentials: parsed.useSecure
              ? const ChannelCredentials.secure()
              : const ChannelCredentials.insecure(),
        ),
      );

      // Create client
      final client = AgentServiceClient(channel);

      // Test bidirectional streaming ping
      requestController = StreamController<PingRequest>();
      final responseStream = client.biDirStreamPing(requestController.stream);

      // Send a ping request
      final testRequest = PingRequest()
        ..stringToBePonged = 'Connection test from miniBroker';
      requestController.add(testRequest);

      // Wait for response with timeout
      final response = await responseStream.first.timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw TimeoutException('Connection test timed out after 5 seconds');
        },
      );

      // Close the request stream
      await requestController.close();

      if (mounted) {
        setState(() {
          _testMessage = 'Connection successful! Response: ${response.pongString}';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Connection failed: ${e.toString()}';
        });
      }
    } finally {
      await requestController?.close();
      await channel?.shutdown();
      if (mounted) {
        setState(() {
          _isTesting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final isDarkTheme = themeService.isDarkTheme;

    final surfaceColor = isDarkTheme ? const Color(0xFF1e1e1e) : Colors.grey[100]!;
    final textColor = Colors.white;
    final hintColor = Colors.grey[400]!;
    final primaryColor = isDarkTheme ? const Color(0xFF6b9eff) : UIConstants.colorCommand;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(UIConstants.borderRadiusLg),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: UIConstants.glassBlurSigma,
            sigmaY: UIConstants.glassBlurSigma,
          ),
          child: Container(
        width: 600,
        constraints: const BoxConstraints(maxHeight: 700),
        padding: UIConstants.paddingComfortable,
        decoration: UIConstants.glassCardDecoration(),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Icon(Icons.edit_outlined, color: primaryColor, size: 32),
                  const SizedBox(width: UIConstants.spacingSm),
                  Expanded(
                    child: Text(
                      'Edit Broker Configuration',
                      style: TextStyle(
                        color: textColor,
                        fontSize: UIConstants.fontSizeMd,
                        fontWeight: UIConstants.fontWeightMedium,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: textColor),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ],
              ),
              const SizedBox(height: UIConstants.spacingSm),
              Text(
                'Edit configuration settings (broker name cannot be changed)',
                style: TextStyle(color: hintColor, fontSize: 14),
              ),
              const SizedBox(height: UIConstants.spacingLg),

              // Scrollable form
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Broker Name (Disabled)
                      Text(
                        'Broker Name',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: UIConstants.fontWeightMedium,
                          fontSize: UIConstants.textFieldFontSize,
                        ),
                      ),
                      const SizedBox(height: UIConstants.spacingSm),
                      TextFormField(
                        controller: _brokerNameController,
                        enabled: false,
                        style: TextStyle(color: hintColor, fontSize: UIConstants.textFieldFontSize),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: surfaceColor.withOpacity(0.5),
                          contentPadding: UIConstants.textFieldContentPadding,
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                            borderSide: BorderSide.none,
                          ),
                          helperText: 'Broker name cannot be changed',
                          helperStyle: TextStyle(color: hintColor, fontSize: 12),
                        ),
                      ),
                      const SizedBox(height: UIConstants.spacingMd),

                      // Participant Agent gRPC Endpoint Section
                      Text(
                        'Participant Agent gRPC Endpoint',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: UIConstants.fontWeightMedium,
                          fontSize: UIConstants.textFieldFontSize,
                        ),
                      ),
                      const SizedBox(height: UIConstants.spacingSm),

                      // gRPC Endpoint (host:port)
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _grpcEndpointController,
                              style: TextStyle(color: textColor, fontSize: UIConstants.textFieldFontSize),
                              decoration: InputDecoration(
                                hintText: 'host:port or https://host',
                                hintStyle: TextStyle(color: hintColor, fontSize: UIConstants.textFieldFontSize),
                                filled: true,
                                fillColor: surfaceColor,
                                contentPadding: UIConstants.textFieldContentPadding,
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: BrokerConfigHelper.validateEndpoint,
                            ),
                          ),
                          const SizedBox(width: UIConstants.spacingSm),
                          ElevatedButton.icon(
                            onPressed: _isTesting ? null : _testConnection,
                            icon: _isTesting
                                ? SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                : Icon(Icons.network_ping, size: 18),
                            label: Text('Test'),
                            style: UIConstants.buttonStyle(primaryColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: UIConstants.spacingMd),

                      // Participant Section
                      Text(
                        'Participant',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: UIConstants.fontWeightMedium,
                          fontSize: UIConstants.textFieldFontSize,
                        ),
                      ),
                      const SizedBox(height: UIConstants.spacingSm),

                      // API Key
                      Text(
                        'API Key *',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: UIConstants.fontWeightMedium,
                          fontSize: UIConstants.textFieldFontSize,
                        ),
                      ),
                      const SizedBox(height: UIConstants.spacingSm),
                      TextFormField(
                        controller: _apiKeyController,
                        style: TextStyle(color: textColor, fontSize: UIConstants.textFieldFontSize),
                        decoration: InputDecoration(
                          hintText: 'Your API key',
                          hintStyle: TextStyle(color: hintColor, fontSize: UIConstants.textFieldFontSize),
                          filled: true,
                          fillColor: surfaceColor,
                          contentPadding: UIConstants.textFieldContentPadding,
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'API key is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: UIConstants.spacingMd),

                      // Participant ID (optional)
                      Text(
                        'Participant ID (optional)',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: UIConstants.fontWeightMedium,
                          fontSize: UIConstants.textFieldFontSize,
                        ),
                      ),
                      const SizedBox(height: UIConstants.spacingSm),
                      TextFormField(
                        controller: _participantIdController,
                        style: TextStyle(color: textColor, fontSize: UIConstants.textFieldFontSize),
                        decoration: InputDecoration(
                          hintText: 'Auto-generated if empty',
                          hintStyle: TextStyle(color: hintColor, fontSize: UIConstants.textFieldFontSize),
                          filled: true,
                          fillColor: surfaceColor,
                          contentPadding: UIConstants.textFieldContentPadding,
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: UIConstants.spacingMd),

                      // Participant Name (optional)
                      Text(
                        'Participant Name (optional)',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: UIConstants.fontWeightMedium,
                          fontSize: UIConstants.textFieldFontSize,
                        ),
                      ),
                      const SizedBox(height: UIConstants.spacingSm),
                      TextFormField(
                        controller: _participantNameController,
                        style: TextStyle(color: textColor, fontSize: UIConstants.textFieldFontSize),
                        decoration: InputDecoration(
                          hintText: 'Display name',
                          hintStyle: TextStyle(color: hintColor, fontSize: UIConstants.textFieldFontSize),
                          filled: true,
                          fillColor: surfaceColor,
                          contentPadding: UIConstants.textFieldContentPadding,
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Test success message
              if (_testMessage != null) ...[
                const SizedBox(height: UIConstants.spacingMd),
                Container(
                  padding: UIConstants.paddingStandard,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                    border: Border.all(color: Colors.green.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle_outline, color: Colors.green[400], size: 20),
                      const SizedBox(width: UIConstants.spacingSm),
                      Expanded(
                        child: Text(
                          _testMessage!,
                          style: TextStyle(color: Colors.green[400], fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Error message
              if (_errorMessage != null) ...[
                const SizedBox(height: UIConstants.spacingMd),
                Container(
                  padding: UIConstants.paddingStandard,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                    border: Border.all(color: Colors.red.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red[400], size: 20),
                      const SizedBox(width: UIConstants.spacingSm),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(color: Colors.red[400], fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: UIConstants.spacingLg),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSaving ? null : () => Navigator.of(context).pop(false),
                    style: UIConstants.cancelTextButtonStyle(isDarkTheme),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: UIConstants.spacingSm),
                  ElevatedButton(
                    onPressed: _isSaving ? null : _saveConfig,
                    style: UIConstants.buttonStyle(primaryColor),
                    child: _isSaving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Save Changes',
                            style: TextStyle(fontWeight: UIConstants.fontWeightMedium),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
        ),
      ),
    );
  }
}
