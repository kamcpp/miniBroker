import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grpc/grpc.dart';
import '../services/theme_service.dart';
import '../utils/broker_config_helper.dart';
import '../generated/prtagent/v1/agent.pbgrpc.dart';

/// Dialog for creating a new broker configuration
import '../config/ui_constants.dart';
class CreateBrokerConfigDialog extends StatefulWidget {
  final String configDir;

  const CreateBrokerConfigDialog({
    super.key,
    required this.configDir,
  });

  @override
  State<CreateBrokerConfigDialog> createState() =>
      _CreateBrokerConfigDialogState();
}

class _CreateBrokerConfigDialogState extends State<CreateBrokerConfigDialog> {
  final _formKey = GlobalKey<FormState>();
  final _brokerNameController = TextEditingController();
  final _grpcEndpointController = TextEditingController(text: 'localhost:50051');
  final _apiKeyController = TextEditingController();
  final _participantIdController = TextEditingController();
  final _participantNameController = TextEditingController();

  bool _isCreating = false;
  bool _isTesting = false;
  String? _errorMessage;
  String? _testMessage;

  @override
  void dispose() {
    _brokerNameController.dispose();
    _grpcEndpointController.dispose();
    _apiKeyController.dispose();
    _participantIdController.dispose();
    _participantNameController.dispose();
    super.dispose();
  }

  Future<void> _createConfig() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isCreating = true;
      _errorMessage = null;
    });

    try {
      final brokerName = _brokerNameController.text.trim();

      // Parse endpoint
      final endpoint = _grpcEndpointController.text.trim();
      final parsed = BrokerConfigHelper.parseEndpoint(endpoint);

      final apiKey = _apiKeyController.text.trim();
      final participantId = _participantIdController.text.trim();
      final participantName = _participantNameController.text.trim();

      final success = BrokerConfigHelper.createConfigFile(
        brokerName: brokerName,
        grpcHost: parsed.host,
        grpcPort: parsed.port,
        apiKey: apiKey,
        useSecure: parsed.useSecure,
        participantId: participantId.isEmpty ? null : participantId,
        participantName: participantName.isEmpty ? null : participantName,
        configDir: widget.configDir,
      );

      if (success) {
        if (mounted) {
          Navigator.of(context).pop({
            'brokerName': brokerName,
            'fileName': BrokerConfigHelper.getConfigFileName(brokerName),
          });
        }
      } else {
        setState(() {
          _errorMessage =
              'Failed to create config file. A broker with this name may already exist.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: ${e.toString()}';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isCreating = false;
        });
      }
    }
  }

  Future<void> _testConnection() async {
    // First validate endpoint field only
    final endpoint = _grpcEndpointController.text.trim();
    if (endpoint.isEmpty) {
      setState(() {
        _errorMessage = 'Endpoint is required for testing';
      });
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

    final backgroundColor = isDarkTheme ? const Color(0xFF2A2A2A) : Colors.white;
    final surfaceColor = isDarkTheme ? const Color(0xFF1e1e1e) : Colors.grey[100]!;
    final textColor = isDarkTheme ? Colors.white : Colors.black;
    final hintColor = isDarkTheme ? Colors.grey[400] : Colors.grey[600];
    final primaryColor = isDarkTheme ? const Color(0xFF6b9eff) : UIConstants.colorCommand;

    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UIConstants.borderRadiusLg),
      ),
      child: Container(
        width: 600,
        constraints: const BoxConstraints(maxHeight: 700),
        padding: UIConstants.paddingComfortable,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Icon(Icons.add_circle_outline, color: primaryColor, size: 32),
                  const SizedBox(width: UIConstants.spacingSm),
                  Expanded(
                    child: Text(
                      'Create Broker Configuration',
                      style: TextStyle(
                        color: textColor,
                        fontSize: UIConstants.fontSizeMd,
                        fontWeight: UIConstants.fontWeightMedium,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: textColor),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: UIConstants.spacingSm),
              Text(
                'Create a new broker instance configuration',
                style: TextStyle(color: hintColor, fontSize: 14),
              ),
              const SizedBox(height: UIConstants.spacingLg),

              // Scrollable form
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Broker Name (Required first)
                      Text(
                        'Broker Name *',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: UIConstants.fontWeightMedium,
                          fontSize: UIConstants.textFieldFontSize,
                        ),
                      ),
                      const SizedBox(height: UIConstants.spacingSm),
                      TextFormField(
                        controller: _brokerNameController,
                        autofocus: true,
                        style: TextStyle(color: textColor, fontSize: UIConstants.textFieldFontSize),
                        decoration: InputDecoration(
                          hintText: 'e.g., my-broker, test_broker_01',
                          hintStyle: TextStyle(color: hintColor, fontSize: UIConstants.textFieldFontSize),
                          filled: true,
                          fillColor: surfaceColor,
                          contentPadding: UIConstants.textFieldContentPadding,
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                            borderSide: BorderSide.none,
                          ),
                          helperText:
                              '5-32 characters: letters, numbers, dash, underscore',
                          helperStyle: TextStyle(color: hintColor, fontSize: 12),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Broker name is required';
                          }
                          if (!BrokerConfigHelper.isValidBrokerName(
                              value.trim())) {
                            return 'Invalid name. Use 5-32 characters: A-Z, a-z, 0-9, -, _';
                          }
                          return null;
                        },
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
                    onPressed: _isCreating
                        ? null
                        : () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      foregroundColor: hintColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(UIConstants.borderRadiusSm),
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: UIConstants.spacingSm),
                  ElevatedButton(
                    onPressed: _isCreating ? null : _createConfig,
                    style: UIConstants.buttonStyle(primaryColor),
                    child: _isCreating
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Create Configuration',
                            style: TextStyle(fontWeight: UIConstants.fontWeightMedium),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
