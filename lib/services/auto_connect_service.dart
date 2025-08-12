import 'dart:async';
import '../config/environment_config.dart';
import '../services/fix_client_service.dart';
import '../models/config_model.dart';

class AutoConnectService {
  static final AutoConnectService _instance = AutoConnectService._internal();
  factory AutoConnectService() => _instance;
  AutoConnectService._internal();

  static const String STAGING_ENVIRONMENT_SUFFIX = 'staging';
  
  // Stream to notify about current environment when auto-connected
  final StreamController<String> _currentEnvironmentController = StreamController<String>.broadcast();
  Stream<String> get currentEnvironmentStream => _currentEnvironmentController.stream;
  
  String? _currentStagingEnvironment;
  
  Future<bool> connectToStagingAndLogon() async {
    try {
      print('🔄 Starting auto-connect to staging environment...');
      
      // Ensure configurations are loaded
      await EnvironmentConfig.loadConfigurations();
      
      // Get available configurations
      final configs = EnvironmentConfig.getConfigs();
      
      ConfigModel? stagingConfig;
      String? stagingEnvKey;
      
      if (configs.isNotEmpty) {
        // Look for staging environment from loaded configurations
        // Check for exact "Staging" environment names in any FIX version
        for (String envKey in configs.keys) {
          final parts = envKey.split('-');
          if (parts.length >= 2) {
            final envName = parts[1].toLowerCase();
            if (envName == 'staging') {
              stagingEnvKey = envKey;
              stagingConfig = configs[envKey]!;
              break;
            }
          }
        }
        
        if (stagingConfig != null) {
          print('✅ Found staging environment: $stagingEnvKey');
        } else {
          print('⚠️ No staging environment found in Config.json');
          print('Available environments: ${configs.keys.toList()}');
          print('💡 Please add a "Staging" environment to your Config.json for auto-connect');
          return false;
        }
      } else {
        print('⚠️ No configurations loaded from Config.json');
        print('💡 Please ensure Config.json is placed beside the app for auto-connect to work');
        return false;
      }
      
      if (stagingConfig == null) {
        print('❌ No staging configuration available for auto-connect');
        print('💡 Available configurations: ${configs.keys.toList()}');
        return false;
      }
      
      print('📋 Using staging config: ${stagingConfig.ipAddress}:${stagingConfig.port}');
      
      // Get FIX client service
      final fixClient = FixClientService.instance;
      
      // Disconnect any existing connection first
      if (fixClient.isConnected) {
        print('🔄 Disconnecting existing connection...');
        await fixClient.disconnect();
        await Future.delayed(const Duration(milliseconds: 500));
      }
      
      // Try to connect with retry logic (but only a few quick attempts for auto-connect)
      bool connected = false;
      int retryCount = 0;
      const maxRetries = 2; // Reduced retries for auto-connect
      
      while (!connected && retryCount < maxRetries) {
        retryCount++;
        print('🔗 Auto-connect attempt $retryCount/$maxRetries to staging: ${stagingConfig.ipAddress}:${stagingConfig.port}');
        
        connected = await fixClient.connect(
          stagingConfig.ipAddress,
          stagingConfig.port,
          stagingConfig.senderCompID,
          stagingConfig.targetCompID,
        );
        
        if (!connected && retryCount < maxRetries) {
          print('⚠️ Auto-connect attempt $retryCount failed, retrying...');
          await Future.delayed(const Duration(seconds: 1));
        }
      }
      
      if (!connected) {
        print('❌ Auto-connect to staging failed after $maxRetries attempts');
        print('💡 You can connect manually using the FIX Client page');
        return false;
      }
      
      print('✅ Auto-connected to staging successfully');
      
      // Wait for connection to stabilize
      await Future.delayed(const Duration(milliseconds: 1000));
      
      // Verify connection is still active
      if (!fixClient.isConnected) {
        print('❌ Auto-connection lost immediately after connecting');
        return false;
      }
      
      // Send logon message with authentication data from Config.json
      print('📨 Sending auto-logon message with staging authentication...');
      
      // Get logon defaults from Config.json
      final logonDefaults = EnvironmentConfig.getMessageDefaults('Logon');
      print('🔐 Using logon defaults: ${logonDefaults.keys.join(', ')}');
      
      final logonSent = await fixClient.sendLogon(logonDefaults);
      
      if (!logonSent) {
        print('❌ Failed to send auto-logon message');
        return false;
      }
      
      print('✅ Auto-logon message sent successfully with staging authentication');
      
      // Wait for logon response with shorter timeout for auto-connect
      for (int i = 0; i < 6; i++) { // Reduced to 3 seconds total
        await Future.delayed(const Duration(milliseconds: 500));
        
        if (!fixClient.isConnected) {
          print('❌ Auto-connection lost during logon process');
          return false;
        }
        
        if (fixClient.isLoggedOn) {
          print('✅ Auto-logon successful and connection stable');
          print('🎉 Ready to trade! FIX session established automatically.');
          
          // Store and broadcast the staging environment that was connected
          _currentStagingEnvironment = stagingEnvKey;
          _currentEnvironmentController.add(stagingEnvKey!);
          print('📡 Broadcasting staging environment: $stagingEnvKey');
          
          return true;
        }
        
        if (i == 0) print('⏳ Waiting for auto-logon response...');
      }
      
      // Connection is still active but logon might be pending
      if (fixClient.isConnected) {
        print('✅ Auto-connect successful - logon response pending');
        print('📊 Connection status: Connected=${fixClient.isConnected}, LoggedOn=${fixClient.isLoggedOn}');
        
        // Store and broadcast the staging environment that was connected
        _currentStagingEnvironment = stagingEnvKey;
        _currentEnvironmentController.add(stagingEnvKey!);
        print('📡 Broadcasting staging environment: $stagingEnvKey');
        
        return true;
      } else {
        print('❌ Auto-connection lost during logon wait period');
        return false;
      }
      
    } catch (e) {
      print('❌ Error during auto-connect to staging: $e');
      print('💡 Auto-connect failed - you can connect manually via FIX Client page');
      return false;
    }
  }
  
  Future<bool> isConnectedToStaging() async {
    final fixClient = FixClientService.instance;
    return fixClient.isConnected && fixClient.isLoggedOn;
  }
  
  String? get currentStagingEnvironment => _currentStagingEnvironment;
  
  Future<void> disconnect() async {
    try {
      final fixClient = FixClientService.instance;
      if (fixClient.isConnected) {
        await fixClient.disconnect();
        print('📤 Disconnected from staging environment');
      }
    } catch (e) {
      print('❌ Error disconnecting from staging: $e');
    }
  }
}
