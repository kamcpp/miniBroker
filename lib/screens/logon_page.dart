import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../widgets/fix_message_form.dart';
import '../services/fix_client_service.dart';
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

    // Prepare FIX field values for logon message
    final fixFields = <String, String>{
      '35': 'A', // MsgType=Logon
    };
    
    // Start with defaults from Config.json
    final defaultValues = EnvironmentConfig.getMessageDefaults('Logon');
    
    // Merge with user-configured fields (user input overrides defaults)
    final allValues = <String, String>{...defaultValues, ..._fieldValues};
    
    // Add all fields (defaults + user input)
    for (final entry in allValues.entries) {
      if (entry.value.isNotEmpty) {
        // Map display names to FIX field tags if needed
        switch (entry.key) {
          case 'EncryptMethod':
            fixFields['98'] = entry.value;
            break;
          case 'HeartBtInt':
            fixFields['108'] = entry.value;
            break;
          case 'ResetSeqNumFlag':
            fixFields['141'] = entry.value;
            break;
          case 'Username':
            fixFields['553'] = entry.value;
            break;
          case 'Password':
            fixFields['554'] = entry.value;
            break;
          case 'RawData':
            fixFields['96'] = entry.value;
            // Automatically set RawDataLength when RawData is present
            fixFields['95'] = entry.value.length.toString();
            break;
          case 'SecureDataLen':
            fixFields['90'] = entry.value;
            break;
          case 'SecureData':
            fixFields['91'] = entry.value;
            break;
          default:
            // If it's already a numeric field tag, use as is
            if (RegExp(r'^\d+$').hasMatch(entry.key)) {
              fixFields[entry.key] = entry.value;
            }
            break;
        }
      }
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
                
                // Send actual logon message
                try {
                  final success = await _fixClientService.sendMessage(fixFields);
                  
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
