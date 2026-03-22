import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/ui_constants.dart';

/// A reusable modal dialog that displays a list of label-value fields.
/// Each field row is click-to-copy. Empty values are hidden.
class DetailModal extends StatelessWidget {
  final String title;
  final Map<String, String> fields;
  final bool isDarkTheme;

  const DetailModal({
    super.key,
    required this.title,
    required this.fields,
    required this.isDarkTheme,
  });

  /// Show the modal as a dialog.
  static void show(BuildContext context, {
    required String title,
    required Map<String, String> fields,
    required bool isDarkTheme,
  }) {
    showDialog(
      context: context,
      builder: (_) => DetailModal(
        title: title,
        fields: fields,
        isDarkTheme: isDarkTheme,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nonEmptyFields = fields.entries.where((e) => e.value.isNotEmpty).toList();

    return Dialog(
      backgroundColor: UIConstants.pageBackground(isDarkTheme),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: UIConstants.tableHeaderBackground(isDarkTheme),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: UIConstants.fontSizeMd,
                        fontWeight: UIConstants.fontWeightMedium,
                        color: UIConstants.textPrimary(isDarkTheme),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: UIConstants.textSecondary(isDarkTheme), size: 18),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            // Fields
            Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                itemCount: nonEmptyFields.length,
                itemBuilder: (context, index) {
                  final entry = nonEmptyFields[index];
                  return _CopyableField(
                    label: entry.key,
                    value: entry.value,
                    isDarkTheme: isDarkTheme,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CopyableField extends StatelessWidget {
  final String label;
  final String value;
  final bool isDarkTheme;

  const _CopyableField({
    required this.label,
    required this.value,
    required this.isDarkTheme,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: value));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Copied: $value'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 160,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: UIConstants.fontSizeSm,
                  color: UIConstants.textSecondary(isDarkTheme),
                ),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: UIConstants.fontSizeSm,
                  color: UIConstants.textPrimary(isDarkTheme),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
