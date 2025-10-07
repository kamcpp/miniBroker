import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;

/// Validates the presence of required configuration files
class ConfigValidator {
  /// The name of the required configuration file
  static const String configFileName = 'mini Broker Config.json';

  /// Get the directory where the app executable is located
  static String getAppDirectory() {
    // Get the path to the current executable
    final executablePath = Platform.resolvedExecutable;

    // On macOS, the executable is inside "mini Broker.app/Contents/MacOS/mini Broker"
    // We need to navigate up to the parent directory of the .app bundle
    String appDir = path.dirname(executablePath);

    // Check if we're inside a .app bundle
    if (Platform.isMacOS && appDir.contains('.app/Contents/MacOS')) {
      // Navigate up from: /path/to/mini Broker.app/Contents/MacOS
      // to: /path/to (the directory containing the .app)
      appDir = path.dirname(executablePath); // MacOS directory
      appDir = path.dirname(appDir);          // Contents directory
      appDir = path.dirname(appDir);          // mini Broker.app directory
      appDir = path.dirname(appDir);          // Parent directory of .app
    }

    return appDir;
  }

  /// Get the expected path to the config file
  static String getConfigFilePath() {
    final appDir = getAppDirectory();
    return path.join(appDir, configFileName);
  }

  /// Check if the config file exists
  static bool configFileExists() {
    final configPath = getConfigFilePath();
    final file = File(configPath);
    return file.existsSync();
  }

  /// Read and parse the config file
  static Map<String, dynamic>? readConfigFile() {
    try {
      final configPath = getConfigFilePath();
      final file = File(configPath);

      if (!file.existsSync()) {
        return null;
      }

      final contents = file.readAsStringSync();
      final config = jsonDecode(contents) as Map<String, dynamic>;
      return config;
    } catch (e) {
      print('❌ Error reading config file: $e');
      return null;
    }
  }

  /// Extract API key from config
  static String? getApiKey(Map<String, dynamic>? config) {
    try {
      if (config == null) return null;

      final configurations = config['configurations'] as Map<String, dynamic>?;
      if (configurations == null) return null;

      final participant = configurations['participant'] as Map<String, dynamic>?;
      if (participant == null) return null;

      return participant['apiKey'] as String?;
    } catch (e) {
      print('❌ Error extracting API key: $e');
      return null;
    }
  }

  /// Validate config file and return validation result
  static ConfigValidationResult validateConfig() {
    try {
      final configPath = getConfigFilePath();
      final appDir = getAppDirectory();

      print('🔍 Checking for config file at: $configPath');
      print('📁 App directory: $appDir');

      if (!configFileExists()) {
        print('❌ Config file not found: $configFileName');
        return ConfigValidationResult(
          isValid: false,
          errorMessage: '$configFileName does not exist at the mini Broker app directory.\n\nExpected location: $configPath',
          configPath: configPath,
        );
      }

      print('✅ Config file found: $configFileName');

      // Read the config file
      final config = readConfigFile();
      if (config == null) {
        print('⚠️ Warning: Could not read or parse config file');
        return ConfigValidationResult(
          isValid: false,
          errorMessage: 'Config file exists but could not be read or parsed as JSON.',
          configPath: configPath,
        );
      }

      // Extract and print the API key
      final apiKey = getApiKey(config);
      if (apiKey != null) {
        print('🔑 API Key: $apiKey');
      } else {
        print('⚠️ Warning: API key not found in config file');
      }

      return ConfigValidationResult(
        isValid: true,
        configPath: configPath,
        apiKey: apiKey,
      );
    } catch (e) {
      print('❌ Error validating config: $e');
      return ConfigValidationResult(
        isValid: false,
        errorMessage: 'Error checking for config file: ${e.toString()}',
      );
    }
  }
}

/// Result of configuration validation
class ConfigValidationResult {
  final bool isValid;
  final String? errorMessage;
  final String? configPath;
  final String? apiKey;

  ConfigValidationResult({
    required this.isValid,
    this.errorMessage,
    this.configPath,
    this.apiKey,
  });
}
