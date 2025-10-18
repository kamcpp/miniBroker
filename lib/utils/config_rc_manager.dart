import 'dart:io';
import 'package:path/path.dart' as path;

/// Manages the .minibroker.rc file that stores the config directory path
class ConfigRcManager {
  /// RC file name
  static const String rcFileName = '.minibroker.rc';

  /// Default config directory name
  static const String defaultConfigDirName = '.minibroker';

  /// Get the RC file path (always in user's home directory)
  static String getRcFilePath() {
    final home = Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'] ?? '';
    if (home.isEmpty) {
      throw Exception('Could not determine user home directory');
    }
    return path.join(home, rcFileName);
  }

  /// Get the default config directory path
  static String getDefaultConfigDir() {
    final home = Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'] ?? '';
    if (home.isEmpty) {
      throw Exception('Could not determine user home directory');
    }
    return path.join(home, defaultConfigDirName);
  }

  /// Read the config directory from RC file
  /// Returns null if file doesn't exist or can't be read
  static String? readConfigDir() {
    try {
      final rcPath = getRcFilePath();
      final file = File(rcPath);

      if (!file.existsSync()) {
        print('📄 RC file not found: $rcPath');
        return null;
      }

      final configDir = file.readAsStringSync().trim();

      if (configDir.isEmpty) {
        print('⚠️ RC file is empty');
        return null;
      }

      print('✅ Read config directory from RC: $configDir');
      return configDir;
    } catch (e) {
      print('❌ Error reading RC file: $e');
      return null;
    }
  }

  /// Write the config directory to RC file
  static bool writeConfigDir(String configDir) {
    try {
      final rcPath = getRcFilePath();
      final file = File(rcPath);

      // Write the config directory path
      file.writeAsStringSync(configDir);

      print('✅ Wrote config directory to RC: $configDir');
      return true;
    } catch (e) {
      print('❌ Error writing RC file: $e');
      return false;
    }
  }

  /// Get the current config directory (from RC or default)
  static String getCurrentConfigDir() {
    // Try to read from RC file first
    final configDir = readConfigDir();

    if (configDir != null && configDir.isNotEmpty) {
      return configDir;
    }

    // Return default if RC file doesn't exist or is invalid
    return getDefaultConfigDir();
  }

  /// Initialize RC file with default config directory if it doesn't exist
  static String initializeRcFile() {
    final rcPath = getRcFilePath();
    final file = File(rcPath);

    if (file.existsSync()) {
      // RC file exists, read and return config dir
      final configDir = readConfigDir();
      if (configDir != null && configDir.isNotEmpty) {
        print('✅ RC file already exists: $rcPath');
        return configDir;
      }
    }

    // Create RC file with default config directory
    final defaultDir = getDefaultConfigDir();
    writeConfigDir(defaultDir);

    // Create the config directory if it doesn't exist
    final configDirectory = Directory(defaultDir);
    if (!configDirectory.existsSync()) {
      configDirectory.createSync(recursive: true);
      print('✅ Created config directory: $defaultDir');
    }

    print('✅ Initialized RC file: $rcPath');
    return defaultDir;
  }

  /// Update config directory and write to RC file
  /// Returns true if successful
  static bool updateConfigDir(String newConfigDir) {
    try {
      // Ensure the directory exists
      final directory = Directory(newConfigDir);
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
        print('✅ Created new config directory: $newConfigDir');
      }

      // Write to RC file
      return writeConfigDir(newConfigDir);
    } catch (e) {
      print('❌ Error updating config directory: $e');
      return false;
    }
  }

  /// Check if RC file exists
  static bool rcFileExists() {
    final rcPath = getRcFilePath();
    return File(rcPath).existsSync();
  }
}