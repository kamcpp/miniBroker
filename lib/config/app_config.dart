/// Application-wide configuration
///
/// This file contains all configuration settings for the miniBroker app.
/// To change server settings, update the values in this file only.
class AppConfig {
  // Private constructor to prevent instantiation
  AppConfig._();

  // ============================================================================
  // Server Configuration
  // ============================================================================

  /// gRPC server host (loaded from config file at runtime)
  /// Default fallback value if config file doesn't specify
  static String grpcHost = 'localhost';

  /// gRPC server port (loaded from config file at runtime)
  /// Default fallback value if config file doesn't specify
  static int grpcPort = 50051;

  /// API key for authenticating with the gRPC server (loaded from config file at runtime)
  /// This is sent as the X-Agora-Participant-Api-Key header
  static String? grpcApiKey;

  /// Full server address (computed from host and port)
  static String get grpcServerAddress => '$grpcHost:$grpcPort';

  // ============================================================================
  // App Information
  // ============================================================================

  /// Application name
  static const String appName = 'miniBroker';

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
