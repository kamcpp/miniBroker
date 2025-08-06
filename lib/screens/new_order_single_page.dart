import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../widgets/fix_message_form.dart';
import '../services/fix_client_service.dart';
import '../services/fix_message_service.dart';
import '../config/environment_config.dart';

class NewOrderSinglePage extends StatefulWidget {
  final String selectedEnvironment;
  
  const NewOrderSinglePage({
    super.key,
    required this.selectedEnvironment,
  });

  @override
  State<NewOrderSinglePage> createState() => _NewOrderSinglePageState();
}

class _NewOrderSinglePageState extends State<NewOrderSinglePage> {
  Map<String, String> _fieldValues = {};
  // Use a singleton instance to share connection across screens
  FixClientService get _fixClientService => FixClientService.instance;

  @override
  Widget build(BuildContext context) {
    final dictionaryProvider = Provider.of<FixDictionaryProvider>(context);
    final messageDefinition = dictionaryProvider.getMessageDefinition('D');

    if (messageDefinition == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('New Order Single'),
        ),
        body: const Center(
          child: Text('New Order Single message definition not found in dictionary'),
        ),
      );
    }

    // Get account value based on selected environment
    final configs = EnvironmentConfig.getConfigs();
    final currentConfig = configs[widget.selectedEnvironment]!;
    final environmentAccount = currentConfig.account;

    // Get defaults from Config.json and merge with environment-specific values
    final messageDefaults = EnvironmentConfig.getMessageDefaults('NewOrderSingle');
    final defaultValues = Map<String, String>.from(messageDefaults);
    
    // Add environment-specific and dynamic values
    defaultValues.addAll({
      'ClOrdID': DateTime.now().millisecondsSinceEpoch.toString(),
      'Account': environmentAccount,
      'TransactTime': FixMessageService.getCurrentTimestamp(),
      'EffectiveTime': FixMessageService.getCurrentTimestamp(),
      'ExpireTime': FixMessageService.getExpireTimestamp(),
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Order Single'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FixMessageForm(
        messageDefinition: messageDefinition,
        allowedFields: const [
          'ClOrdID',
          'Account', 
          'HandlInst',
          'Symbol',
          'Side',
          'TimeInForce',
          'TransactTime',
          'OrdType',
          'Price',
          'OrderQty',
          'Currency',
          'EffectiveTime',
          'ExpireTime',
          'Text',
        ],
        initialValues: defaultValues,
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

    // Convert field names to FIX tags and display preview
    final convertedFields = FixMessageService.convertFieldNamesToTags(_fieldValues);
    final fixFields = <String, String>{'35': 'D', ...convertedFields};

    final messageData = StringBuffer();
    messageData.writeln('New Order Single (MsgType=D)');
    messageData.writeln('============================');
    for (final entry in fixFields.entries) {
      messageData.writeln('Field ${entry.key}: ${entry.value}');
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Send New Order Single'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ready to send New Order Single:'),
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
                // Send actual new order single using centralized service
                try {
                  final success = await FixMessageService.sendNewOrderSingleMessage(_fieldValues, widget.selectedEnvironment);
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('New Order Single sent successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Failed to send New Order Single'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error sending New Order Single: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Send Order'),
            ),
          ],
        );
      },
    );
  }
}
