import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart';
import '../models/config_model.dart';

class EnvironmentConfig {
  static Map<String, ConfigModel> _configs = {};
  static Map<String, Map<String, String>> _messageDefaults = {};
  static bool _isLoaded = false;

  static Future<void> loadConfigurations() async {
    // Prevent multiple simultaneous loads
    if (_isLoaded) {
      return;
    }
    
    try {
      // Calculate the path to Config.json beside the mini Broker.app
      final String executablePath = Platform.resolvedExecutable;
      print('Executable path: $executablePath');
      
      // For macOS app bundle: executable is at mini Broker.app/Contents/MacOS/mini Broker
      // We want Config.json beside mini Broker.app
      final String macOSDir = path.dirname(executablePath);        // Contents/MacOS
      final String contentsDir = path.dirname(macOSDir);          // Contents  
      final String appBundlePath = path.dirname(contentsDir);     // mini Broker.app
      final String appDirectory = path.dirname(appBundlePath);    // Directory containing the app
      final String externalConfigPath = path.join(appDirectory, 'Config.json');
      
      print('External Config.json path: $externalConfigPath');
      
      String jsonString;
      
      try {
        // Try to read from external Config.json
        jsonString = await File(externalConfigPath).readAsString();
        print('✅ SUCCESS: Reading from external Config.json');
      } catch (e) {
        print('❌ Cannot read Config.json: $e');
        print('💡 Using fallback configuration instead');
        
        // Use fallback configuration when Config.json is not found
        jsonString = _getFallbackConfig();
      }
      
      print('📋 Config.json content preview: ${jsonString.substring(0, jsonString.length > 200 ? 200 : jsonString.length)}...');
      
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      
      // Extract configurations object with new FIX version structure
      final Map<String, dynamic> configurations = jsonData['configurations'];
      
      _configs = <String, ConfigModel>{};
      _messageDefaults = <String, Map<String, String>>{};
      
      // Parse the new structure: FIX version -> environments -> configs
      configurations.forEach((fixVersion, fixConfig) {
        final String fixVersionValue = fixConfig['fixVersion'];
        final String dictionaryLocation = fixConfig['dictionaryLocation'];
        final Map<String, dynamic> environments = fixConfig['environments'];
        
        // Load message defaults if they exist
        if (fixConfig.containsKey('messageDefaults')) {
          final Map<String, dynamic> messageDefaultsData = fixConfig['messageDefaults'];
          messageDefaultsData.forEach((messageName, defaultValues) {
            _messageDefaults[messageName] = Map<String, String>.from(defaultValues);
          });
        }
        
        environments.forEach((envName, envConfig) {
          // Create a unique key combining FIX version and environment
          final String configKey = '$fixVersion-$envName';
          
          _configs[configKey] = ConfigModel(
            name: envConfig['name'],
            ipAddress: envConfig['ipAddress'],
            port: envConfig['port'],
            hbInterval: envConfig['hbInterval'],
            senderCompID: envConfig['senderCompID'],
            targetCompID: envConfig['targetCompID'],
            fixVersion: fixVersionValue,
            dictionaryLocation: dictionaryLocation,
            account: envConfig['account'],
          );
        });
      });
      
      print('✅ SUCCESS: Loaded ${_configs.length} configurations');
      print('📝 Available configurations: ${_configs.keys.join(', ')}');
      print('🎯 Loaded message defaults: ${_messageDefaults.keys.join(', ')}');
      if (_configs.containsKey('fix42-development')) {
        print('🔧 fix42-development config loaded successfully');
      }
      _isLoaded = true;
    } catch (e) {
      print('❌ Failed to load configurations: $e');
      print('💡 Using minimal fallback configuration');
      
      // Set minimal fallback configuration
      _configs = _getDefaultConfigs();
      _messageDefaults = _getDefaultMessageDefaults();
      _isLoaded = true;
    }
  }

  static Map<String, ConfigModel> getConfigs() {
    if (!_isLoaded) {
      throw StateError('Configurations not loaded. Call loadConfigurations() first.');
    }
    return Map.from(_configs);
  }

  static Map<String, String> getMessageDefaults(String messageName) {
    if (!_isLoaded) {
      throw StateError('Configurations not loaded. Call loadConfigurations() first.');
    }
    return Map.from(_messageDefaults[messageName] ?? {});
  }

  static Map<String, Map<String, String>> getAllMessageDefaults() {
    if (!_isLoaded) {
      throw StateError('Configurations not loaded. Call loadConfigurations() first.');
    }
    return Map.from(_messageDefaults);
  }

  static Future<void> updateConfig(String environment, ConfigModel newConfig) async {
    if (!_isLoaded) {
      throw StateError('Configurations not loaded. Call loadConfigurations() first.');
    }
    
    // Update in memory only - do not save to Config.json (read-only behavior)
    _configs[environment] = newConfig;
    
    print('Configuration updated in memory for environment: $environment');
    print('Note: Changes are temporary and will be reset when app restarts');
  }

  static String _getFallbackConfig() {
    return '''
{
  "Environments": {
    "fix42-development": {
      "name": "fix42-development",
      "ipAddress": "localhost",
      "port": "9878",
      "hbInterval": "30",
      "senderCompID": "MINIBROKER",
      "targetCompID": "TOKENISE",
      "fixVersion": "4.2",
      "dictionaryLocation": "assets/FIX42.xml",
      "account": "test"
    }
  },
  "MessageDefaults": {
    "NewOrderSingle": {
      "Side": "1",
      "TimeInForce": "0",
      "HandlInst": "1",
      "Symbol": "AC1",
      "OrdType": "2",
      "OrderQty": "1",
      "Price": "1.0",
      "Currency": "USD"
    }
  }
}
    ''';
  }

  static Map<String, ConfigModel> _getDefaultConfigs() {
    return {
      'fix42-development': ConfigModel(
        name: 'fix42-development',
        ipAddress: 'localhost',
        port: 9878,
        hbInterval: 30,
        senderCompID: 'MINIBROKER',
        targetCompID: 'TOKENISE',
        fixVersion: '4.2',
        dictionaryLocation: 'assets/FIX42.xml',
        account: 'test',
      ),
    };
  }

  static Map<String, Map<String, String>> _getDefaultMessageDefaults() {
    return {
      'NewOrderSingle': {
        'Side': '1',
        'TimeInForce': '0',
        'HandlInst': '1',
        'Symbol': 'AC1',
        'OrdType': '2',
        'OrderQty': '1',
        'Price': '1.0',
        'Currency': 'USD',
      },
    };
  }
}
