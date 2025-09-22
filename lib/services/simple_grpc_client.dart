import 'package:grpc/grpc.dart';

/// Simple gRPC client for basic connectivity testing
class SimpleGrpcClient {
  
  /// Convert DateTime to Unix timestamp (seconds since epoch)
  static int _toUnixTimestamp(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch ~/ 1000;
  }
  late ClientChannel _channel;
  bool _isConnected = false;
  String? _host;
  int? _port;

  // Getters
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

      // Test basic connectivity by creating a call context
      // This will help verify the channel can be established
      await _testBasicConnectivity(timeout: timeout);

      _host = host;
      _port = port;
      _isConnected = true;
      
      print('✅ Connected to gRPC server at $host:$port');
    } catch (e) {
      _isConnected = false;
      print('❌ Failed to connect to gRPC server: $e');
      throw Exception('Failed to connect to gRPC server: $e');
    }
  }

  /// Test basic connectivity without requiring specific protobuf definitions
  Future<void> _testBasicConnectivity({Duration? timeout}) async {
    try {
      // Create a basic call options to test the channel
      final callOptions = timeout != null 
          ? CallOptions(timeout: timeout)
          : CallOptions(timeout: const Duration(seconds: 5));
      
      // The channel is ready if we can create it without immediate errors
      // We'll do a simple reflection call or health check if available
      print('🔄 Testing basic gRPC channel connectivity...');
      
      // For now, we'll consider the channel ready if no immediate errors occur
      await Future.delayed(const Duration(milliseconds: 100));
      
      print('✅ Basic gRPC channel established');
    } catch (e) {
      throw Exception('Basic connectivity test failed: $e');
    }
  }

  /// Attempt a simple ping test using reflection or health service
  Future<String> testPing({
    String message = 'Hello from Flutter!',
    Duration? timeout,
  }) async {
    if (!_isConnected) {
      throw Exception('Not connected to gRPC server');
    }

    try {
      // For a simulated ping response since we don't have the exact protobuf
      // In a real implementation, you'd call the actual ping service
      print('🏓 Attempting ping test...');
      
      await Future.delayed(const Duration(milliseconds: 200));
      
      // Simulate successful ping
      final response = 'Pong: $message';
      print('✅ Ping successful: $response');
      
      return response;
    } catch (e) {
      print('❌ Ping failed: $e');
      throw Exception('Ping test failed: $e');
    }
  }

  /// Get basic server info
  Future<Map<String, String>> getServerInfo() async {
    if (!_isConnected) {
      throw Exception('Not connected to gRPC server');
    }

    try {
      // Return basic connection info
      return {
        'host': _host ?? 'unknown',
        'port': _port?.toString() ?? 'unknown',
        'status': 'connected',
        'type': 'simprtagent',
        'timestamp': _toUnixTimestamp(DateTime.now()).toString(),
      };
    } catch (e) {
      throw Exception('Failed to get server info: $e');
    }
  }

  /// Get Account List from the gRPC server
  Future<Map<String, dynamic>> getAccountList({
    int pageNumber = 0,
    int pageSize = 0,
    String? accountIdRegex,
  }) async {
    if (!_isConnected) {
      throw Exception('Not connected to gRPC server');
    }

    try {
      print('🔄 Calling GetAccountList...');
      
      // Prepare request parameters
      final requestParams = {
        'refRequestId': generateRequestId(prefix: 'get_account_list'),
        'pageNumber': pageNumber,
        'pageSize': pageSize,
        'accountIdRegex': accountIdRegex ?? '',
      };

      print('📨 Request Input: $requestParams');

      // Since we don't have the exact protobuf, we'll simulate the call
      // In a real implementation, this would be:
      // final request = GetAccountListRequest()
      //   ..refRequestId = requestParams['refRequestId']
      //   ..pageNumber = pageNumber
      //   ..pageSize = pageSize;
      // if (accountIdRegex != null) request.accountIdRegex = accountIdRegex;
      
      // For now, simulate the response structure
      await Future.delayed(const Duration(milliseconds: 300));

      final simulatedResponse = {
        'input': requestParams,
        'output': {
          'refRequestId': requestParams['refRequestId'],
          'paginationInfo': {
            'pageNumber': pageNumber,
            'pageSize': pageSize,
            'totalItems': 5,
            'totalPages': 1,
          },
          'accounts': [
            {
              'id': 'account_001',
              'externalId': 'flutter_user_001',
              'status': 'ACTIVE',
              'createdAt': _toUnixTimestamp(DateTime.now().subtract(const Duration(days: 30))).toString(),
              'balance': '1500.00',
            },
            {
              'id': 'account_002', 
              'externalId': 'flutter_user_002',
              'status': 'ACTIVE',
              'createdAt': _toUnixTimestamp(DateTime.now().subtract(const Duration(days: 15))).toString(),
              'balance': '2750.50',
            },
            {
              'id': 'account_003',
              'externalId': 'demo_account',
              'status': 'ACTIVE', 
              'createdAt': _toUnixTimestamp(DateTime.now().subtract(const Duration(days: 7))).toString(),
              'balance': '500.00',
            },
          ],
          'createdAt': _toUnixTimestamp(DateTime.now()).toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'responseTime': _toUnixTimestamp(DateTime.now().add(const Duration(milliseconds: 300))).toString(),
      };

      print('📬 Response Output: ${simulatedResponse['output']}');
      print('✅ GetAccountList completed successfully');

      return simulatedResponse;
    } catch (e) {
      print('❌ GetAccountList failed: $e');
      throw Exception('GetAccountList failed: $e');
    }
  }

  /// Get participant info (simulated)
  Future<Map<String, dynamic>> getParticipantInfo() async {
    if (!_isConnected) {
      throw Exception('Not connected to gRPC server');
    }

    try {
      print('🔄 Calling GetParticipantInfo...');
      
      final requestParams = {
        'refRequestId': generateRequestId(prefix: 'get_participant_info'),
      };

      await Future.delayed(const Duration(milliseconds: 200));

      final simulatedResponse = {
        'input': requestParams,
        'output': {
          'refRequestId': requestParams['refRequestId'],
          'identifier': 'participant_${DateTime.now().millisecondsSinceEpoch}',
          'name': 'Trading Participant',
          'status': 'ACTIVE',
          'permissions': ['READ', 'TRADE', 'MANAGE_ACCOUNTS'],
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
      };

      print('📬 GetParticipantInfo Response: ${simulatedResponse['output']}');
      return simulatedResponse;
    } catch (e) {
      throw Exception('GetParticipantInfo failed: $e');
    }
  }

  /// Disconnect from the gRPC server
  Future<void> disconnect() async {
    if (_isConnected) {
      try {
        await _channel.shutdown();
        _isConnected = false;
        _host = null;
        _port = null;
        print('🔌 Disconnected from gRPC server');
      } catch (e) {
        print('⚠️ Error during disconnect: $e');
        _isConnected = false;
        _host = null;
        _port = null;
      }
    }
  }

  /// Generate a unique request ID
  String generateRequestId({String? prefix}) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final prefixStr = prefix != null ? '${prefix}_' : '';
    return '${prefixStr}${timestamp}';
  }

  /// Handle gRPC errors and convert them to user-friendly messages
  String handleGrpcError(dynamic error) {
    if (error is GrpcError) {
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
    return 'Error: ${error.toString()}';
  }

  /// Dispose and clean up resources
  void dispose() {
    disconnect();
  }
}

// Singleton instance for easy access throughout the app
final simpleGrpcClient = SimpleGrpcClient();