import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../widgets/fix_message_form.dart';
import '../services/fix_client_service.dart';
import '../services/fix_message_service.dart';
import '../config/environment_config.dart';

class SecurityDefinitionRequestPage extends StatefulWidget {
  const SecurityDefinitionRequestPage({super.key});

  @override
  State<SecurityDefinitionRequestPage> createState() => _SecurityDefinitionRequestPageState();
}

class _SecurityDefinitionRequestPageState extends State<SecurityDefinitionRequestPage> {
  Map<String, String> _fieldValues = {};
  // Use a singleton instance to share connection across screens
  FixClientService get _fixClientService => FixClientService.instance;

  @override
  void initState() {
    super.initState();
    // Get defaults from Config.json and add dynamic values
    final messageDefaults = EnvironmentConfig.getMessageDefaults('SecurityDefinitionRequest');
    _fieldValues = Map<String, String>.from(messageDefaults);
    _fieldValues['SecurityReqID'] = DateTime.now().millisecondsSinceEpoch.toString();
    print('DEBUG: Initial _fieldValues: $_fieldValues');
  }

  @override
  Widget build(BuildContext context) {
    final dictionaryProvider = Provider.of<FixDictionaryProvider>(context);
    final messageDefinition = dictionaryProvider.getMessageDefinition('c');

    if (messageDefinition == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Security Definition Request'),
        ),
        body: const Center(
          child: Text('Security Definition Request message definition not found in dictionary'),
        ),
      );
    }

    // Ensure initial values match _fieldValues
    final initialValues = Map<String, String>.from(_fieldValues);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Definition Request'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FixMessageForm(
        messageDefinition: messageDefinition,
        allowedFields: const ['SecurityReqID', 'SecurityRequestType'], // Only show these two fields
        initialValues: initialValues,
        onFieldChanged: (values) {
          print('DEBUG: Form field values changed: $values');
          setState(() {
            _fieldValues = values;
          });
          print('DEBUG: Updated _fieldValues: $_fieldValues');
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

    // Convert field names to FIX tags and display preview
    final convertedFields = FixMessageService.convertFieldNamesToTags(_fieldValues);
    final fixFields = <String, String>{'35': 'c', ...convertedFields};
    
    // Debug: Print final fixFields
    print('DEBUG: Final fixFields = $fixFields');
    
    final messageData = StringBuffer();
    messageData.writeln('Security Definition Request (MsgType=c)');
    messageData.writeln('======================================');
    
    for (final entry in fixFields.entries) {
      messageData.writeln('Field ${entry.key}: ${entry.value}');
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Send Security Definition Request'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ready to send Security Definition Request:'),
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
                
                // Send actual security definition request using centralized service
                try {
                  final success = await FixMessageService.sendSecurityDefinitionRequestMessage(_fieldValues);
                  
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Security definition request sent successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Failed to send security definition request'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error sending request: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Send Request'),
            ),
          ],
        );
      },
    );
  }
}
