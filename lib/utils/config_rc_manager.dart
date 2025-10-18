import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;

/// Manages the global.json file that stores the config directory path
class ConfigRcManager {
  /// Global config file name
  static const String globalConfigFileName = 'global.json';

  /// Default config directory name
  static const String defaultConfigDirName = '.minibroker';

  /// JSON field name for config directory path
  static const String configDirPathField = 'config_dir_path';

  /// Get the global config file path (${HOME}/.minibroker/global.json)
  static String getGlobalConfigFilePath() {
    final home = Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'] ?? '';
    if (home.isEmpty) {
      throw Exception('Could not determine user home directory');
    }
    return path.join(home, defaultConfigDirName, globalConfigFileName);
  }

  /// Get the default config directory path
  static String getDefaultConfigDir() {
    final home = Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'] ?? '';
    if (home.isEmpty) {
      throw Exception('Could not determine user home directory');
    }
    return path.join(home, defaultConfigDirName);
  }

  /// Read the config directory from global.json file
  /// Returns null if file doesn't exist or can't be read
  static String? readConfigDir() {
    try {
      final globalConfigPath = getGlobalConfigFilePath();
      final file = File(globalConfigPath);

      if (!file.existsSync()) {
        print('📄 Global config file not found: $globalConfigPath');
        return null;
      }

      final contents = file.readAsStringSync().trim();

      if (contents.isEmpty) {
        print('⚠️ Global config file is empty');
        return null;
      }

      // Parse JSON
      final json = jsonDecode(contents) as Map<String, dynamic>;
      final configDir = json[configDirPathField] as String?;

      if (configDir == null || configDir.isEmpty) {
        print('⚠️ Global config file missing or empty "$configDirPathField" field');
        return null;
      }

      print('✅ Read config directory from global.json: $configDir');
      return configDir;
    } catch (e) {
      print('❌ Error reading global config file: $e');
      return null;
    }
  }

  /// Write the config directory to global.json file
  static bool writeConfigDir(String configDir) {
    try {
      final globalConfigPath = getGlobalConfigFilePath();
      final file = File(globalConfigPath);

      // Ensure parent directory exists
      final directory = file.parent;
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
        print('✅ Created directory: ${directory.path}');
      }

      // Create JSON structure
      final json = {
        configDirPathField: configDir,
      };

      // Write with pretty formatting
      final encoder = JsonEncoder.withIndent('  ');
      file.writeAsStringSync(encoder.convert(json));

      print('✅ Wrote config directory to global.json: $configDir');
      return true;
    } catch (e) {
      print('❌ Error writing global config file: $e');
      return false;
    }
  }

  /// Get the current config directory (from global.json or default)
  static String getCurrentConfigDir() {
    // Try to read from global.json file first
    final configDir = readConfigDir();

    if (configDir != null && configDir.isNotEmpty) {
      return configDir;
    }

    // Return default if global.json doesn't exist or is invalid
    return getDefaultConfigDir();
  }

  /// Initialize global.json file with default config directory if it doesn't exist
  static String initializeRcFile() {
    final globalConfigPath = getGlobalConfigFilePath();
    final file = File(globalConfigPath);

    if (file.existsSync()) {
      // global.json file exists, read and return config dir
      final configDir = readConfigDir();
      if (configDir != null && configDir.isNotEmpty) {
        print('✅ Global config file already exists: $globalConfigPath');
        return configDir;
      }
    }

    // Create global.json file with default config directory
    final defaultDir = getDefaultConfigDir();
    writeConfigDir(defaultDir);

    // Create the config directory if it doesn't exist
    final configDirectory = Directory(defaultDir);
    if (!configDirectory.existsSync()) {
      configDirectory.createSync(recursive: true);
      print('✅ Created config directory: $defaultDir');
    }

    print('✅ Initialized global config file: $globalConfigPath');
    return defaultDir;
  }

  /// Update config directory and write to global.json file
  /// Returns true if successful
  static bool updateConfigDir(String newConfigDir) {
    try {
      // Ensure the directory exists
      final directory = Directory(newConfigDir);
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
        print('✅ Created new config directory: $newConfigDir');
      }

      // Write to global.json file
      return writeConfigDir(newConfigDir);
    } catch (e) {
      print('❌ Error updating config directory: $e');
      return false;
    }
  }

  /// Check if global.json file exists
  static bool globalConfigExists() {
    final globalConfigPath = getGlobalConfigFilePath();
    return File(globalConfigPath).existsSync();
  }
}