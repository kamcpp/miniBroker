import '../config/environment_config.dart';
import 'fix_client_service.dart';

class FixMessageService {
  static final FixClientService _fixClientService = FixClientService.instance;

  // Centralized field mapping - single source of truth
  static const Map<String, String> fieldMapping = {
    'EncryptMethod': '98',
    'HeartBtInt': '108', 
    'RawDataLength': '95',
    'RawData': '96',
    'ResetSeqNumFlag': '141',
    'Username': '553',
    'Password': '554',
    'SecureDataLen': '90',
    'SecureData': '91',
    'HandlInst': '21',
    'Symbol': '55',
    'Side': '54',
    'OrderQty': '38',
    'OrdType': '40',
    'Price': '44',
    'Currency': '15',
    'TimeInForce': '59',
    'Text': '58',
    'SecurityRequestType': '321',
    'SecurityReqID': '320',
    'NoRelatedSym': '146',
    'Account': '1',
    'ClOrdID': '11',
    'OrigClOrdID': '41',
    'TransactTime': '60',
    'EffectiveTime': '168',
    'ExpireTime': '126',
  };

  // Convert field names to FIX tag numbers
  static Map<String, String> convertFieldNamesToTags(Map<String, String> fieldDefaults) {
    Map<String, String> convertedFields = {};
    
    fieldDefaults.forEach((fieldName, value) {
      String? tagNumber = fieldMapping[fieldName];
      if (tagNumber != null) {
        convertedFields[tagNumber] = value;
      } else if (RegExp(r'^\d+$').hasMatch(fieldName)) {
        // If it's already a numeric field tag, use as is
        convertedFields[fieldName] = value;
      }
    });

    return convertedFields;
  }

  // Generate current timestamp in FIX format
  static String getCurrentTimestamp() {
    final now = DateTime.now().toUtc();
    return '${now.year.toString().padLeft(4, '0')}'
           '${now.month.toString().padLeft(2, '0')}'
           '${now.day.toString().padLeft(2, '0')}-'
           '${now.hour.toString().padLeft(2, '0')}:'
           '${now.minute.toString().padLeft(2, '0')}:'
           '${now.second.toString().padLeft(2, '0')}';
  }

  // Generate expire timestamp (1 day from now) in FIX format
  static String getExpireTimestamp() {
    final expireTime = DateTime.now().add(const Duration(days: 1)).toUtc();
    return '${expireTime.year.toString().padLeft(4, '0')}'
           '${expireTime.month.toString().padLeft(2, '0')}'
           '${expireTime.day.toString().padLeft(2, '0')}-'
           '${expireTime.hour.toString().padLeft(2, '0')}:'
           '${expireTime.minute.toString().padLeft(2, '0')}:'
           '${expireTime.second.toString().padLeft(2, '0')}';
  }

  // Send Logon Message
  static Future<bool> sendLogonMessage(Map<String, String> fieldValues) async {
    final fixFields = <String, String>{'35': 'A'}; // MsgType=Logon
    
    // Get defaults from Config.json
    final defaultValues = EnvironmentConfig.getMessageDefaults('Logon');
    
    // Merge with user input (user input overrides defaults)
    final allValues = <String, String>{...defaultValues, ...fieldValues};
    
    // Convert field names to tag numbers
    final convertedFields = convertFieldNamesToTags(allValues);
    fixFields.addAll(convertedFields);
    
    // Auto-calculate RawDataLength if RawData is present
    if (convertedFields.containsKey('96')) {
      fixFields['95'] = convertedFields['96']!.length.toString();
    }
    
    return await _fixClientService.sendMessage(fixFields);
  }

  // Send New Order Single Message
  static Future<bool> sendNewOrderSingleMessage(Map<String, String> fieldValues, String selectedEnvironment) async {
    final fixFields = <String, String>{'35': 'D'}; // MsgType=New Order Single
    
    // Get account value based on selected environment
    final configs = EnvironmentConfig.getConfigs();
    final currentConfig = configs[selectedEnvironment];
    if (currentConfig == null) return false;
    
    // Convert field names to tag numbers
    final convertedFields = convertFieldNamesToTags(fieldValues);
    fixFields.addAll(convertedFields);
    
    return await _fixClientService.sendMessage(fixFields);
  }

  // Send Security Definition Request Message
  static Future<bool> sendSecurityDefinitionRequestMessage(Map<String, String> fieldValues) async {
    final fixFields = <String, String>{'35': 'c'}; // MsgType=Security Definition Request
    
    // Convert field names to tag numbers
    final convertedFields = convertFieldNamesToTags(fieldValues);
    fixFields.addAll(convertedFields);
    
    return await _fixClientService.sendMessage(fixFields);
  }

  // Send Order Cancel Request Message
  static Future<bool> sendOrderCancelRequestMessage(Map<String, String> fieldValues, String selectedEnvironment) async {
    final fixFields = <String, String>{'35': 'F'}; // MsgType=Order Cancel Request
    
    // Get account value based on selected environment
    final configs = EnvironmentConfig.getConfigs();
    final currentConfig = configs[selectedEnvironment];
    if (currentConfig == null) return false;
    
    // Convert field names to tag numbers
    final convertedFields = convertFieldNamesToTags(fieldValues);
    fixFields.addAll(convertedFields);
    
    return await _fixClientService.sendMessage(fixFields);
  }

  // Send Logout Message  
  static Future<bool> sendLogoutMessage(Map<String, String> fieldValues) async {
    final fixFields = <String, String>{'35': '5'}; // MsgType=Logout
    
    // Convert field names to tag numbers
    final convertedFields = convertFieldNamesToTags(fieldValues);
    fixFields.addAll(convertedFields);
    
    return await _fixClientService.sendMessage(fixFields);
  }

  // Quick send methods for home page (with defaults)
  static Future<bool> sendQuickLogon() async {
    final logonDefaults = EnvironmentConfig.getMessageDefaults('Logon');
    return await sendLogonMessage(logonDefaults);
  }

  static Future<bool> sendQuickNewOrderSingle(String selectedEnvironment) async {
    final orderDefaults = EnvironmentConfig.getMessageDefaults('NewOrderSingle');
    final configs = EnvironmentConfig.getConfigs();
    final currentConfig = configs[selectedEnvironment];
    if (currentConfig == null) return false;
    
    // Add dynamic values
    final dynamicValues = <String, String>{
      ...orderDefaults,
      'ClOrdID': DateTime.now().millisecondsSinceEpoch.toString(),
      'Account': currentConfig.account,
      'TransactTime': getCurrentTimestamp(),
      'EffectiveTime': getCurrentTimestamp(),
      'ExpireTime': getExpireTimestamp(),
    };
    
    return await sendNewOrderSingleMessage(dynamicValues, selectedEnvironment);
  }

  static Future<bool> sendQuickSecurityDefinitionRequest() async {
    final secDefDefaults = EnvironmentConfig.getMessageDefaults('SecurityDefinitionRequest');
    // Add dynamic SecurityReqID
    final dynamicValues = <String, String>{
      ...secDefDefaults,
      'SecurityReqID': DateTime.now().millisecondsSinceEpoch.toString(),
    };
    
    return await sendSecurityDefinitionRequestMessage(dynamicValues);
  }

  static Future<bool> sendQuickOrderCancelRequest(String selectedEnvironment) async {
    final cancelDefaults = EnvironmentConfig.getMessageDefaults('OrderCancelRequest');
    final configs = EnvironmentConfig.getConfigs();
    final currentConfig = configs[selectedEnvironment];
    if (currentConfig == null) return false;
    
    // Add dynamic values
    final dynamicValues = <String, String>{
      ...cancelDefaults,
      'ClOrdID': 'ClOrdID',
      'OrigClOrdID': 'Enter the Order Id you want to cancel',
      'Account': currentConfig.account,
      'TransactTime': getCurrentTimestamp(),
    };
    
    return await sendOrderCancelRequestMessage(dynamicValues, selectedEnvironment);
  }

  static Future<bool> sendQuickLogout() async {
    return await sendLogoutMessage({'Text': 'User requested logout'});
  }
}
