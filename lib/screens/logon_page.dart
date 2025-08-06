import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../widgets/fix_message_form.dart';
import '../services/fix_client_service.dart';
import '../services/fix_message_service.dart';
import '../config/environment_config.dart';

class LogonPage extends StatefulWidget {
  const LogonPage({super.key});

  @override
  State<LogonPage> createState() => _LogonPageState();
}

class _LogonPageState extends State<LogonPage> {
  Map<String, String> _fieldValues = {};
  // Use a singleton instance to share connection across screens
  FixClientService get _fixClientService => FixClientService.instance;

  @override
  Widget build(BuildContext context) {
    final dictionaryProvider = Provider.of<FixDictionaryProvider>(context);
    final messageDefinition = dictionaryProvider.getMessageDefinition('A');

    if (messageDefinition == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Logon Message'),
        ),
        body: const Center(
          child: Text('Logon message definition not found in dictionary'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Logon Message'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FixMessageForm(
        messageDefinition: messageDefinition,
        initialValues: EnvironmentConfig.getMessageDefaults('Logon'),
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
    // Check if we have a FIX connection
    if (!_fixClientService.isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not connected to FIX server. Please connect first.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Start with defaults from Config.json
    final defaultValues = EnvironmentConfig.getMessageDefaults('Logon');
    
    // Merge with user-configured fields (user input overrides defaults)
    final allValues = <String, String>{...defaultValues, ..._fieldValues};
    
    // Convert to FIX fields and display preview
    final convertedFields = FixMessageService.convertFieldNamesToTags(allValues);
    final fixFields = <String, String>{'35': 'A', ...convertedFields};
    
    // Auto-calculate RawDataLength if RawData is present
    if (convertedFields.containsKey('96')) {
      fixFields['95'] = convertedFields['96']!.length.toString();
    }
    
    final messageData = StringBuffer();
    messageData.writeln('Logon Message (MsgType=A)');
    messageData.writeln('========================');
    
    for (final entry in fixFields.entries) {
      messageData.writeln('Field ${entry.key}: ${entry.value}');
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Send Logon Message'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ready to send Logon message:'),
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
                
                // Send actual logon message using centralized service
                try {
                  final success = await FixMessageService.sendLogonMessage(_fieldValues);
                  
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Logon message sent successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Failed to send logon message'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error sending logon: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Send Logon'),
            ),
          ],
        );
      },
    );
  }
}
