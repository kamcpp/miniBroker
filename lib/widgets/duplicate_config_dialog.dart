import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/theme_service.dart';
import '../utils/broker_config_helper.dart';

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
        width: 450,
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
                  Icon(Icons.content_copy, color: primaryColor, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Duplicate Configuration',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: textColor),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Duplicating: ${widget.originalName}',
                style: TextStyle(color: hintColor, fontSize: 14),
              ),
              const SizedBox(height: 24),

              // Broker Name field
              Text(
                'New Broker Name *',
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _brokerNameController,
                autofocus: true,
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  hintText: 'e.g., my-broker-2',
                  hintStyle: TextStyle(color: hintColor),
                  filled: true,
                  fillColor: surfaceColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
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
              const SizedBox(height: 24),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      foregroundColor: hintColor,
                    ),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pop(_brokerNameController.text.trim());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Duplicate',
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
