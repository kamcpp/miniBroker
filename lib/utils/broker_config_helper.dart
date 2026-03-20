import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;
import 'config_rc_manager.dart';
import '../config/app_config.dart';

/// Helper for managing broker configuration files
class BrokerConfigHelper {
  /// Regex pattern for valid broker names: [A-Za-z0-9_-]{5,32}
  static final RegExp brokerNamePattern = RegExp(r'^[A-Za-z0-9_-]{5,32}$');

  /// Config file pattern: broker-{brokerName}.config.json
  static String getConfigFileName(String brokerName) {
    return 'broker-$brokerName.config.json';
  }

  /// Extract broker name from config filename
  /// Returns null if filename doesn't match pattern
  static String? getBrokerNameFromFileName(String fileName) {
    final pattern = RegExp(r'^broker-([A-Za-z0-9_-]{5,32})\.config\.json$');
    final match = pattern.firstMatch(fileName);
    return match?.group(1);
  }

  /// Validate broker name
  static bool isValidBrokerName(String name) {
    return brokerNamePattern.hasMatch(name);
  }

  /// Find all broker config files in the config directory
  /// Files are sorted by last modified time (most recent first)
  static List<String> findAllConfigFiles({String? configDir}) {
    try {
      final dir = configDir ?? ConfigRcManager.getCurrentConfigDir();
      final directory = Directory(dir);

      if (!directory.existsSync()) {
        print('⚠️ Config directory does not exist: $dir');
        return [];
      }

      final fileEntities = directory
          .listSync()
          .whereType<File>()
          .where((file) {
            final fileName = path.basename(file.path);
            return getBrokerNameFromFileName(fileName) != null;
          })
          .toList();

      // Sort by last modified time (most recent first)
      fileEntities.sort((a, b) {
        final aModified = a.lastModifiedSync();
        final bModified = b.lastModifiedSync();
        return bModified.compareTo(aModified); // Descending order
      });

      final files = fileEntities
          .map((file) => path.basename(file.path))
          .toList();

      print('✅ Found ${files.length} config file(s) in $dir (sorted by last usage)');
      return files;
    } catch (e) {
      print('❌ Error finding config files: $e');
      return [];
    }
  }

  /// Get full path to a config file
  static String getConfigFilePath(String fileName, {String? configDir}) {
    final dir = configDir ?? ConfigRcManager.getCurrentConfigDir();
    return path.join(dir, fileName);
  }

  /// Check if a config file exists
  static bool configFileExists(String fileName, {String? configDir}) {
    final filePath = getConfigFilePath(fileName, configDir: configDir);
    return File(filePath).existsSync();
  }

  /// Update the last modified time of a config file
  /// This is used to track last usage and sort configs by recency
  static void touchConfigFile(String fileName, {String? configDir}) {
    try {
      final filePath = getConfigFilePath(fileName, configDir: configDir);
      final file = File(filePath);

      if (!file.existsSync()) {
        print('⚠️ Cannot touch non-existent config file: $filePath');
        return;
      }

      // Update last modified time to now
      file.setLastModifiedSync(DateTime.now());
      print('✅ Updated last usage time for: $fileName');
    } catch (e) {
      print('❌ Error touching config file $fileName: $e');
    }
  }

  /// Read and parse a config file
  static Map<String, dynamic>? readConfigFile(String fileName, {String? configDir}) {
    try {
      final filePath = getConfigFilePath(fileName, configDir: configDir);
      final file = File(filePath);

      if (!file.existsSync()) {
        print('⚠️ Config file not found: $filePath');
        return null;
      }

      final contents = file.readAsStringSync();
      final config = jsonDecode(contents) as Map<String, dynamic>;
      print('✅ Read config file: $fileName');
      return config;
    } catch (e) {
      print('❌ Error reading config file $fileName: $e');
      return null;
    }
  }

  /// Create a new broker config file with template
  static bool createConfigFile({
    required String brokerName,
    required String grpcHost,
    required int grpcPort,
    required String apiKey,
    bool useSecure = false,
    String? participantId,
    String? participantName,
    String? configDir,
  }) {
    try {
      if (!isValidBrokerName(brokerName)) {
        print('❌ Invalid broker name: $brokerName');
        return false;
      }

      final dir = configDir ?? ConfigRcManager.getCurrentConfigDir();
      final fileName = getConfigFileName(brokerName);
      final filePath = path.join(dir, fileName);

      // Ensure config directory exists
      final directory = Directory(dir);
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
        print('✅ Created config directory: $dir');
      }

      // Check if file already exists
      if (File(filePath).existsSync()) {
        print('⚠️ Config file already exists: $fileName');
        return false;
      }

      // Create config structure
      final config = {
        'broker': {
          'name': brokerName,
          'createdAt': DateTime.now().toIso8601String(),
        },
        'grpc': {
          'host': grpcHost,
          'port': grpcPort,
          'useSecure': useSecure,
        },
        'participant': {
          'apiKey': apiKey,
          'participantId': participantId ?? 'participant-$brokerName',
          'name': participantName ?? brokerName,
        },
        'app': {
          'name': AppConfig.appName,
          'version': AppConfig.appVersion,
          'environment': 'development',
        },
        'network': {
          'defaultTimeoutSeconds': 30,
          'connectivityCheckIntervalMs': 3000,
          'enableDebugLogging': true,
        },
        'ui': {
          'defaultPageSize': 50,
          'maxPageSize': 200,
          'refreshIntervalMs': 2000,
        },
      };

      // Write to file with pretty formatting
      final file = File(filePath);
      final encoder = JsonEncoder.withIndent('  ');
      file.writeAsStringSync(encoder.convert(config));

      print('✅ Created config file: $fileName at $dir');
      return true;
    } catch (e) {
      print('❌ Error creating config file: $e');
      return false;
    }
  }

  /// Parse a gRPC endpoint string into host, port, and useSecure.
  /// Supports formats:
  ///   - host:port (e.g., localhost:50051)
  ///   - https://host (defaults to port 443)
  ///   - https://host:port
  ///   - http://host (defaults to port 80)
  ///   - http://host:port
  static ({String host, int port, bool useSecure}) parseEndpoint(String endpoint) {
    final trimmed = endpoint.trim();

    if (trimmed.startsWith('https://') || trimmed.startsWith('http://')) {
      final uri = Uri.parse(trimmed);
      final useSecure = uri.scheme == 'https';
      final defaultPort = useSecure ? 443 : 80;
      final host = uri.host;
      final port = uri.hasPort ? uri.port : defaultPort;
      if (host.isEmpty) {
        throw FormatException('Invalid URL: missing host');
      }
      return (host: host, port: port, useSecure: useSecure);
    }

    // Legacy host:port format
    final parts = trimmed.split(':');
    if (parts.length != 2) {
      throw FormatException('Invalid endpoint format. Expected host:port or https://host');
    }
    final host = parts[0];
    final port = int.tryParse(parts[1]);
    if (port == null || port < 1 || port > 65535) {
      throw FormatException('Invalid port number (1-65535)');
    }
    return (host: host, port: port, useSecure: false);
  }

  /// Validate a gRPC endpoint string.
  /// Returns null if valid, or an error message string if invalid.
  static String? validateEndpoint(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Endpoint is required';
    }
    try {
      parseEndpoint(value);
      return null;
    } on FormatException catch (e) {
      return e.message;
    }
  }

  /// Format an endpoint for display from config values.
  static String formatEndpoint({required String host, required int port, required bool useSecure}) {
    if (useSecure) {
      if (port == 443) return 'https://$host';
      return 'https://$host:$port';
    }
    return '$host:$port';
  }

  /// Extract API key from config
  static String? getApiKey(Map<String, dynamic>? config) {
    try {
      if (config == null) return null;
      final participant = config['participant'] as Map<String, dynamic>?;
      return participant?['apiKey'] as String?;
    } catch (e) {
      print('❌ Error extracting API key: $e');
      return null;
    }
  }

  /// Get broker name from config
  static String? getBrokerName(Map<String, dynamic>? config) {
    try {
      if (config == null) return null;
      final broker = config['broker'] as Map<String, dynamic>?;
      return broker?['name'] as String?;
    } catch (e) {
      print('❌ Error extracting broker name: $e');
      return null;
    }
  }
}