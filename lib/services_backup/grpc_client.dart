import 'package:grpc/grpc.dart';
import 'package:mini_broker/generated/qomet/agora/daemons/prtagent/v1/account.pbgrpc.dart';
import 'package:mini_broker/generated/qomet/agora/daemons/prtagent/v1/agent.pbgrpc.dart';
import 'package:mini_broker/generated/qomet/agora/daemons/prtagent/v1/instrument.pbgrpc.dart';
import 'package:mini_broker/generated/qomet/agora/daemons/prtagent/v1/market.pbgrpc.dart';

class TradingGrpcClient {
  late ClientChannel _channel;
  late AccountServiceClient _accountService;
  late AgentServiceClient _agentService;
  late InstrumentServiceClient _instrumentService;
  late MarketServiceClient _marketService;

  String? _host;
  int? _port;
  bool _isConnected = false;

  // Getters for service clients
  AccountServiceClient get accountService => _accountService;
  AgentServiceClient get agentService => _agentService;
  InstrumentServiceClient get instrumentService => _instrumentService;
  MarketServiceClient get marketService => _marketService;

  bool get isConnected => _isConnected;
  String? get currentHost => _host;
  int? get currentPort => _port;

  /// Connect to the gRPC server
  Future<void> connect({
    required String host,
    required int port,
    bool useSecure = false,
    Duration? timeout,
  }) async {
    try {
      // Close existing connection if any
      await disconnect();

      // Create channel options
      final channelOptions = ChannelOptions(
        credentials: useSecure 
            ? const ChannelCredentials.secure() 
            : const ChannelCredentials.insecure(),
        keepAlive: const ClientKeepAliveOptions(
          permitWithoutCalls: true,
          timeout: Duration(seconds: 30),
        ),
      );

      // Create the gRPC channel
      _channel = ClientChannel(
        host,
        port: port,
        options: channelOptions,
      );

      // Initialize service clients
      _accountService = AccountServiceClient(_channel);
      _agentService = AgentServiceClient(_channel);
      _instrumentService = InstrumentServiceClient(_channel);
      _marketService = MarketServiceClient(_channel);

      // Test connection with a ping
      await _testConnection(timeout: timeout);

      _host = host;
      _port = port;
      _isConnected = true;
      
      print('✅ Connected to gRPC server at $host:$port');
    } catch (e) {
      _isConnected = false;
      throw Exception('Failed to connect to gRPC server: $e');
    }
  }

  /// Test the connection by sending a ping
  Future<void> _testConnection({Duration? timeout}) async {
    try {
      final request = PingRequest()
        ..refRequestId = 'connection_test_${DateTime.now().millisecondsSinceEpoch}'
        ..stringToBePonged = 'Hello from Flutter!';

      final response = await _agentService.ping(
        request,
        options: timeout != null 
            ? CallOptions(timeout: timeout)
            : null,
      );

      if (response.pongString != 'Hello from Flutter!') {
        throw Exception('Unexpected ping response');
      }
    } catch (e) {
      throw Exception('Connection test failed: $e');
    }
  }

  /// Disconnect from the gRPC server
  Future<void> disconnect() async {
    if (_isConnected) {
      await _channel.shutdown();
      _isConnected = false;
      _host = null;
      _port = null;
      print('🔌 Disconnected from gRPC server');
    }
  }

  /// Create a unique request ID
  String generateRequestId({String? prefix}) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final prefixStr = prefix != null ? '${prefix}_' : '';
    return '${prefixStr}${timestamp}';
  }

  /// Handle gRPC errors and convert them to user-friendly messages
  String handleGrpcError(GrpcError error) {
    switch (error.code) {
      case StatusCode.unavailable:
        return 'Server is unavailable. Please check your connection.';
      case StatusCode.deadlineExceeded:
        return 'Request timed out. Please try again.';
      case StatusCode.unauthenticated:
        return 'Authentication failed. Please check your credentials.';
      case StatusCode.permissionDenied:
        return 'Permission denied. You don\'t have access to this resource.';
      case StatusCode.notFound:
        return 'Resource not found.';
      case StatusCode.invalidArgument:
        return 'Invalid request parameters.';
      case StatusCode.internal:
        return 'Internal server error. Please try again later.';
      default:
        return 'Network error: ${error.message}';
    }
  }

  /// Dispose and clean up resources
  void dispose() {
    disconnect();
  }
}

// Singleton instance for easy access throughout the app
final grpcClient = TradingGrpcClient();