import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/theme_service.dart';
import '../utils/broker_config_helper.dart';

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
  final _grpcHostController = TextEditingController(text: 'localhost');
  final _grpcPortController = TextEditingController(text: '50051');
  final _apiKeyController = TextEditingController();
  final _participantIdController = TextEditingController();
  final _participantNameController = TextEditingController();

  bool _isCreating = false;
  String? _errorMessage;

  @override
  void dispose() {
    _brokerNameController.dispose();
    _grpcHostController.dispose();
    _grpcPortController.dispose();
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
      final grpcHost = _grpcHostController.text.trim();
      final grpcPort = int.parse(_grpcPortController.text.trim());
      final apiKey = _apiKeyController.text.trim();
      final participantId = _participantIdController.text.trim();
      final participantName = _participantNameController.text.trim();

      final success = BrokerConfigHelper.createConfigFile(
        brokerName: brokerName,
        grpcHost: grpcHost,
        grpcPort: grpcPort,
        apiKey: apiKey,
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

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final isDarkTheme = themeService.isDarkTheme;

    final backgroundColor = isDarkTheme ? const Color(0xFF2A2A2A) : Colors.white;
    final surfaceColor = isDarkTheme ? const Color(0xFF1e1e1e) : Colors.grey[100]!;
    final textColor = isDarkTheme ? Colors.white : Colors.black;
    final hintColor = isDarkTheme ? Colors.grey[400] : Colors.grey[600];
    final primaryColor = isDarkTheme ? const Color(0xFF6b9eff) : const Color(0xFF1a1754);

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
                          contentPadding: UIConstants.textFieldPadding,
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

                      // gRPC Server Section
                      Text(
                        'gRPC Server',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: UIConstants.fontWeightMedium,
                          fontSize: UIConstants.textFieldFontSize,
                        ),
                      ),
                      const SizedBox(height: UIConstants.spacingSm),

                      // gRPC Host
                      Text(
                        'Host *',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: UIConstants.fontWeightMedium,
                          fontSize: UIConstants.textFieldFontSize,
                        ),
                      ),
                      const SizedBox(height: UIConstants.spacingSm),
                      TextFormField(
                        controller: _grpcHostController,
                        style: TextStyle(color: textColor, fontSize: UIConstants.textFieldFontSize),
                        decoration: InputDecoration(
                          hintText: 'localhost or IP address',
                          hintStyle: TextStyle(color: hintColor, fontSize: UIConstants.textFieldFontSize),
                          filled: true,
                          fillColor: surfaceColor,
                          contentPadding: UIConstants.textFieldPadding,
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Host is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: UIConstants.spacingMd),

                      // gRPC Port
                      Text(
                        'Port *',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: UIConstants.fontWeightMedium,
                          fontSize: UIConstants.textFieldFontSize,
                        ),
                      ),
                      const SizedBox(height: UIConstants.spacingSm),
                      TextFormField(
                        controller: _grpcPortController,
                        style: TextStyle(color: textColor, fontSize: UIConstants.textFieldFontSize),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '50051',
                          hintStyle: TextStyle(color: hintColor, fontSize: UIConstants.textFieldFontSize),
                          filled: true,
                          fillColor: surfaceColor,
                          contentPadding: UIConstants.textFieldPadding,
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Port is required';
                          }
                          final port = int.tryParse(value.trim());
                          if (port == null || port < 1 || port > 65535) {
                            return 'Invalid port number (1-65535)';
                          }
                          return null;
                        },
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
                          contentPadding: UIConstants.textFieldPadding,
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
                          contentPadding: UIConstants.textFieldPadding,
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
                          contentPadding: UIConstants.textFieldPadding,
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
                    ),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: UIConstants.spacingSm),
                  ElevatedButton(
                    onPressed: _isCreating ? null : _createConfig,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                      ),
                    ),
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
