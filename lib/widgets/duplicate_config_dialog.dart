import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/theme_service.dart';
import '../utils/broker_config_helper.dart';
import '../config/ui_constants.dart';

/// Simple dialog to get new broker name for duplication
class DuplicateConfigDialog extends StatefulWidget {
  final String originalName;

  const DuplicateConfigDialog({
    super.key,
    required this.originalName,
  });

  @override
  State<DuplicateConfigDialog> createState() => _DuplicateConfigDialogState();
}

class _DuplicateConfigDialogState extends State<DuplicateConfigDialog> {
  final _formKey = GlobalKey<FormState>();
  final _brokerNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill with original name + "-copy"
    _brokerNameController.text = '${widget.originalName}-copy';
  }

  @override
  void dispose() {
    _brokerNameController.dispose();
    super.dispose();
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
        width: 450,
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
                  Icon(Icons.content_copy, color: primaryColor, size: 28),
                  const SizedBox(width: UIConstants.spacingSm),
                  Expanded(
                    child: Text(
                      'Duplicate Configuration',
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
                'Duplicating: ${widget.originalName}',
                style: TextStyle(color: hintColor, fontSize: 14),
              ),
              const SizedBox(height: UIConstants.spacingLg),

              // Broker Name field
              Text(
                'New Broker Name *',
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
                  hintText: 'e.g., my-broker-2',
                  hintStyle: TextStyle(color: hintColor, fontSize: UIConstants.textFieldFontSize),
                  filled: true,
                  fillColor: surfaceColor,
                          contentPadding: UIConstants.textFieldContentPadding,
                          isDense: true,
                          border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                    borderSide: BorderSide.none,
                  ),
                  helperText: '5-32 characters: letters, numbers, dash, underscore',
                  helperStyle: TextStyle(color: hintColor, fontSize: 12),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Broker name is required';
                  }
                  if (!BrokerConfigHelper.isValidBrokerName(value.trim())) {
                    return 'Invalid name. Use 5-32 characters: A-Z, a-z, 0-9, -, _';
                  }
                  return null;
                },
              ),
              const SizedBox(height: UIConstants.spacingLg),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: UIConstants.cancelTextButtonStyle(isDarkTheme),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: UIConstants.spacingSm),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pop(_brokerNameController.text.trim());
                      }
                    },
                    style: UIConstants.buttonStyle(primaryColor),
                    child: const Text(
                      'Duplicate',
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
