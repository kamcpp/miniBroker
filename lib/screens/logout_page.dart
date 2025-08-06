import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../widgets/fix_message_form.dart';
import '../services/fix_client_service.dart';
import '../services/fix_message_service.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  Map<String, String> _fieldValues = {};
  // Use a singleton instance to share connection across screens
  FixClientService get _fixClientService => FixClientService.instance;

  @override
  Widget build(BuildContext context) {
    final dictionaryProvider = Provider.of<FixDictionaryProvider>(context);
    final messageDefinition = dictionaryProvider.getMessageDefinition('5');

    if (messageDefinition == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Logout Message'),
        ),
        body: const Center(
          child: Text('Logout message definition not found in dictionary'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Logout Message'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FixMessageForm(
        messageDefinition: messageDefinition,
        initialValues: const {}, // No default values for logout
        onFieldChanged: (values) {
          setState(() {
            _fieldValues = values;
          });
        },
        onSend: () => _sendMessage(context),
      ),
    );
  }

  void _sendMessage(BuildContext context) async {
    // Convert field names to FIX tags and display preview
    final convertedFields = FixMessageService.convertFieldNamesToTags(_fieldValues);
    final fixFields = <String, String>{'35': '5', ...convertedFields};
    
    final messageData = StringBuffer();
    messageData.writeln('Logout Message (MsgType=5)');
    messageData.writeln('=========================');
    
    for (final entry in fixFields.entries) {
      messageData.writeln('Field ${entry.key}: ${entry.value}');
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Send Logout Message'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ready to send Logout message:'),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    child: Text(
                      messageData.toString(),
                      style: const TextStyle(fontFamily: 'monospace'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                
                try {
                  // Send using centralized service
                  final success = await FixMessageService.sendLogoutMessage(_fieldValues);
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        success 
                          ? 'Logout message sent successfully!' 
                          : 'Failed to send logout message'
                      ),
                      backgroundColor: success ? Colors.green : Colors.red,
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error sending logout: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Send Logout'),
            ),
          ],
        );
      },
    );
  }
}
