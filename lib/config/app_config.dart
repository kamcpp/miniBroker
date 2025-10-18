/// Application-wide configuration
///
/// This file contains all configuration settings for the mini-broker app.
/// To change server settings, update the values in this file only.
class AppConfig {
  // Private constructor to prevent instantiation
  AppConfig._();

  // ============================================================================
  // Server Configuration
  // ============================================================================

  /// gRPC server host
  /// Change this to your server's hostname or IP address
  static const String grpcHost = 'localhost';

  /// gRPC server port
  /// Change this to your server's port number
  static const int grpcPort = 50051;

  /// Full server address (computed from host and port)
  static String get grpcServerAddress => '$grpcHost:$grpcPort';

  // ============================================================================
  // App Information
  // ============================================================================

  /// Application name
  static const String appName = 'mini-broker';

  /// Application version
  static const String appVersion = '1.0.0';

  // ============================================================================
  // UI Configuration
  // ============================================================================

  /// Default page size for paginated lists
  static const int defaultPageSize = 50;

  /// Maximum page size allowed
  static const int maxPageSize = 200;

  // ============================================================================
  // Network Configuration
  // ============================================================================

  /// Default timeout for network requests (in seconds)
  static const int defaultTimeoutSeconds = 30;

  /// Connectivity check timeout (in milliseconds)
  static const int connectivityTimeoutMs = 3000;

  // ============================================================================
  // Feature Flags
  // ============================================================================

  /// Enable debug logging
  static const bool enableDebugLogging = true;

  /// Enable server connectivity checks
  static const bool enableConnectivityChecks = true;

  // ============================================================================
  // Runtime Configuration
  // ============================================================================

  /// Selected broker name (set at startup from config file)
  static String? selectedBrokerName;
}
