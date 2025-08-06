import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../services/fix_client_service.dart';
import '../services/fix_message_service.dart';
import '../widgets/fix_message_form.dart';
import '../config/environment_config.dart';

class OrderCancelRequestPage extends StatefulWidget {
  final String selectedEnvironment;
  
  const OrderCancelRequestPage({
    super.key,
    required this.selectedEnvironment,
  });

  @override
  State<OrderCancelRequestPage> createState() => _OrderCancelRequestPageState();
}

class _OrderCancelRequestPageState extends State<OrderCancelRequestPage> {
  final Map<String, String> _fieldValues = {};
  final FixClientService _fixClientService = FixClientService.instance;

  @override
  Widget build(BuildContext context) {
    final dictionaryProvider = Provider.of<FixDictionaryProvider>(context);
    final messageDefinition = dictionaryProvider.getMessageDefinition('F');

    if (messageDefinition == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Order Cancel Request'),
        ),
        body: const Center(
          child: Text('Order Cancel Request message definition not found in dictionary'),
        ),
      );
    }

    // Get account value based on selected environment
    final configs = EnvironmentConfig.getConfigs();
    final currentConfig = configs[widget.selectedEnvironment]!;
    final environmentAccount = currentConfig.account;

    // Get defaults from Config.json and merge with environment-specific values
    final messageDefaults = EnvironmentConfig.getMessageDefaults('OrderCancelRequest');
    final defaultValues = Map<String, String>.from(messageDefaults);
    
    // Add environment-specific and dynamic values
    defaultValues.addAll({
      'ClOrdID': _fieldValues['ClOrdID'] ?? 'ClOrdID',
      'OrigClOrdID': _fieldValues['OrigClOrdID'] ?? 'Enter the Order Id you want to cancel',
      'Account': _fieldValues['Account'] ?? environmentAccount,
      'TransactTime': _fieldValues['TransactTime'] ?? FixMessageService.getCurrentTimestamp(),
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Cancel Request'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FixMessageForm(
        messageDefinition: messageDefinition,
        allowedFields: const ['ClOrdID', 'OrigClOrdID', 'Account', 'Symbol', 'Side', 'TransactTime'],
        initialValues: defaultValues,
        onFieldChanged: (values) {
          print('DEBUG: Form field values changed: $values');
          setState(() {
            _fieldValues.clear();
            _fieldValues.addAll(values);
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

    // Use the current field values (which include the defaults)
    final allValues = Map<String, String>.from(_fieldValues);
    
    // Get account value based on selected environment
    final configs = EnvironmentConfig.getConfigs();
    final currentConfig = configs[widget.selectedEnvironment]!;
    final environmentAccount = currentConfig.account;
    
    // Ensure Account field is included if not present in _fieldValues
    if (!allValues.containsKey('Account') || allValues['Account']?.isEmpty == true) {
      allValues['Account'] = environmentAccount;
    }

    // Debug: Print the values being used
    print('DEBUG: allValues = $allValues');
    
    // Convert field names to FIX tags and display preview
    final convertedFields = FixMessageService.convertFieldNamesToTags(allValues);
    final fixFields = <String, String>{'35': 'F', ...convertedFields};
    
    // Debug: Print final fixFields
    print('DEBUG: Final fixFields = $fixFields');

    final messageData = StringBuffer();
    messageData.writeln('Order Cancel Request (MsgType=F)');
    messageData.writeln('==================================');
    for (final entry in fixFields.entries) {
      messageData.writeln('Field ${entry.key}: ${entry.value}');
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Send Order Cancel Request'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ready to send Order Cancel Request:'),
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
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
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
                  final success = await FixMessageService.sendOrderCancelRequestMessage(allValues, widget.selectedEnvironment);
                  
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          success 
                            ? 'Order Cancel Request sent successfully!' 
                            : 'Failed to send Order Cancel Request'
                        ),
                        backgroundColor: success ? Colors.green : Colors.red,
                      ),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error sending Order Cancel Request: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: const Text('Send'),
            ),
          ],
        );
      },
    );
}
}
