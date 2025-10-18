import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import '../services/theme_service.dart';
import '../utils/broker_config_helper.dart';

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
  late final TextEditingController _grpcHostController;
  late final TextEditingController _grpcPortController;
  late final TextEditingController _apiKeyController;
  late final TextEditingController _participantIdController;
  late final TextEditingController _participantNameController;

  bool _isSaving = false;
  String? _errorMessage;

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
    _grpcHostController = TextEditingController(
      text: grpc?['host'] as String? ?? 'localhost',
    );
    _grpcPortController = TextEditingController(
      text: (grpc?['port'] as int?)?.toString() ?? '50051',
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
    _grpcHostController.dispose();
    _grpcPortController.dispose();
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

      // Update grpc settings
      (updatedConfig['grpc'] as Map<String, dynamic>?)?['host'] =
          _grpcHostController.text.trim();
      (updatedConfig['grpc'] as Map<String, dynamic>?)?['port'] =
          int.parse(_grpcPortController.text.trim());

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
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 600,
        constraints: const BoxConstraints(maxHeight: 700),
        padding: const EdgeInsets.all(24),
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
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Edit Broker Configuration',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: textColor),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Edit configuration settings (broker name cannot be changed)',
                style: TextStyle(color: hintColor, fontSize: 14),
              ),
              const SizedBox(height: 24),

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
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _brokerNameController,
                        enabled: false,
                        style: TextStyle(color: hintColor),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: surfaceColor.withOpacity(0.5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          helperText: 'Broker name cannot be changed',
                          helperStyle: TextStyle(color: hintColor, fontSize: 12),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // gRPC Server Section
                      Text(
                        'gRPC Server',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // gRPC Host
                      Text(
                        'Host *',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _grpcHostController,
                        style: TextStyle(color: textColor),
                        decoration: InputDecoration(
                          hintText: 'localhost or IP address',
                          hintStyle: TextStyle(color: hintColor),
                          filled: true,
                          fillColor: surfaceColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
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
                      const SizedBox(height: 16),

                      // gRPC Port
                      Text(
                        'Port *',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _grpcPortController,
                        style: TextStyle(color: textColor),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '50051',
                          hintStyle: TextStyle(color: hintColor),
                          filled: true,
                          fillColor: surfaceColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
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
                      const SizedBox(height: 20),

                      // Participant Section
                      Text(
                        'Participant',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // API Key
                      Text(
                        'API Key *',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _apiKeyController,
                        style: TextStyle(color: textColor),
                        decoration: InputDecoration(
                          hintText: 'Your API key',
                          hintStyle: TextStyle(color: hintColor),
                          filled: true,
                          fillColor: surfaceColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
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
                      const SizedBox(height: 16),

                      // Participant ID (optional)
                      Text(
                        'Participant ID (optional)',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _participantIdController,
                        style: TextStyle(color: textColor),
                        decoration: InputDecoration(
                          hintText: 'Auto-generated if empty',
                          hintStyle: TextStyle(color: hintColor),
                          filled: true,
                          fillColor: surfaceColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Participant Name (optional)
                      Text(
                        'Participant Name (optional)',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _participantNameController,
                        style: TextStyle(color: textColor),
                        decoration: InputDecoration(
                          hintText: 'Display name',
                          hintStyle: TextStyle(color: hintColor),
                          filled: true,
                          fillColor: surfaceColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
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
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red[400], size: 20),
                      const SizedBox(width: 8),
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

              const SizedBox(height: 24),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSaving ? null : () => Navigator.of(context).pop(false),
                    style: TextButton.styleFrom(
                      foregroundColor: hintColor,
                    ),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _isSaving ? null : _saveConfig,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
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
                            style: TextStyle(fontWeight: FontWeight.bold),
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
