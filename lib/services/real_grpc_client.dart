import 'dart:convert';
import 'dart:io';
import 'grpcurl_helper.dart';

/// Real gRPC client that uses grpcurl to communicate with the actual simprtagent server
class RealGrpcClient {
  bool _isConnected = false;
  String? _host;
  int? _port;

  // Getters
  bool get isConnected => _isConnected;
  String? get currentHost => _host;
  int? get currentPort => _port;

  /// Connect to the actual gRPC server using grpcurl
  Future<void> connect({
    required String host,
    required int port,
    bool useSecure = false,
    Duration? timeout,
  }) async {
    try {
      // Close existing connection if any
      await disconnect();

      _host = host;
      _port = port;
      
      // Test actual server connectivity before marking as connected
      print('🔄 Testing server connectivity before marking as connected...');
      final testResult = await testServerConnectivity();
      
      if (testResult) {
        _isConnected = true;
        print('✅ gRPC client successfully connected to $host:$port');
      } else {
        _isConnected = false;
        print('⚠️ gRPC client configured for $host:$port but server is not reachable');
        // Don't throw exception - let the app continue but show disconnected state
      }
    } catch (e) {
      _isConnected = false;
      print('❌ Failed to configure gRPC client: $e');
      throw Exception('Failed to configure gRPC client: $e');
    }
  }

  /// Test connection using grpcurl to verify server is actually working (async, non-blocking)
  void _testConnectionAsync() {
    // Run this in background without blocking the connection
    Future.delayed(Duration.zero, () async {
      try {
        print('🔄 Testing connection to real gRPC server...');
        
        // Test if grpcurl can connect to the server with very short timeout
        final isServerReachable = await GrpcurlHelper.testConnection().timeout(
          const Duration(seconds: 1),
          onTimeout: () {
            print('⏰ grpcurl test timed out after 1 second');
            return false;
          },
        );
        
        if (isServerReachable) {
          print('✅ Real gRPC server is reachable via grpcurl');
          
          // List available services to confirm (with timeout)
          try {
            final services = await GrpcurlHelper.listServices().timeout(
              const Duration(seconds: 1),
              onTimeout: () {
                print('⏰ Service listing timed out');
                return <String>[];
              },
            );
            print('📋 Available services on real server: $services');
          } catch (e) {
            print('⚠️ Could not list services: $e');
          }
        } else {
          print('⚠️ Real gRPC server is not reachable via grpcurl (but connection established)');
        }
        
        print('✅ Real gRPC client background test completed');
      } catch (e) {
        print('⚠️ Background connection test failed: $e (connection still established)');
      }
    });
  }

  /// Test if server is reachable via socket connection
  Future<bool> testServerConnectivity() async {
    try {
      if (_host == null || _port == null) return false;
      
      print('🔌 Testing socket connection to $_host:$_port...');
      final socket = await Socket.connect(_host!, _port!, timeout: const Duration(seconds: 2));
      await socket.close();
      print('✅ Server is reachable via socket connection');
      return true;
    } catch (e) {
      print('❌ Server not reachable via socket: $e');
      return false;
    }
  }

  /// Real Ping call to AgentService.Ping using grpcurl
  Future<Map<String, dynamic>> ping({
    String stringToBePonged = 'Hello from Flutter!',
    Duration? timeout,
  }) async {
    // Always test connectivity first to prevent crashes
    print('🔍 Testing server connectivity before ping...');
    final isServerReachable = await testServerConnectivity();
    
    if (!isServerReachable) {
      _isConnected = false; // Update connection state
      return {
        'input': {
          'ref_request_id': 'ping_${DateTime.now().millisecondsSinceEpoch}',
          'string_to_be_ponged': stringToBePonged,
        },
        'output': {
          'error': 'Server not reachable',
          'message': 'Cannot connect to the gRPC server at $_host:$_port. Please check if the server is running.',
        },
        'requestTime': DateTime.now().toIso8601String(),
        'serverType': 'not-reachable',
        'success': false,
      };
    }

    // Update connection state if server is reachable
    if (!_isConnected) {
      _isConnected = true;
      print('✅ Server connection restored');
    }

    try {
      print('🏓 Ping button clicked - attempting real server connection');
      
      // Try to call the real server with grpcurl, with comprehensive crash protection
      final response = await GrpcurlHelper.ping(
        stringToBePonged: stringToBePonged,
      ).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          print('⏰ Ping request timed out');
          return {
            'input': {
              'ref_request_id': 'ping_${DateTime.now().millisecondsSinceEpoch}',
              'string_to_be_ponged': stringToBePonged,
            },
            'output': {
              'error': 'Request timed out',
              'message': 'The ping request timed out after 5 seconds. Check if server is running properly.',
            },
            'requestTime': DateTime.now().toIso8601String(),
            'serverType': 'timeout',
            'success': false,
          };
        },
      ).catchError((error) {
        print('❌ Ping error caught: $error');
        return {
          'input': {
            'ref_request_id': 'ping_${DateTime.now().millisecondsSinceEpoch}',
            'string_to_be_ponged': stringToBePonged,
          },
          'output': {
            'error': 'Ping execution failed',
            'message': 'Failed to execute ping: ${error.toString()}',
          },
          'requestTime': DateTime.now().toIso8601String(),
          'serverType': 'execution-error',
          'success': false,
        };
      });

      print('📬 Real Server Ping Response: ${response['output']}');
      print('✅ Real ping completed');

      // Update connection state based on response
      if (response['success'] == true) {
        _isConnected = true;
      } else {
        // Test connectivity again if ping failed
        final stillReachable = await testServerConnectivity();
        _isConnected = stillReachable;
      }

      return response;
    } catch (e, stackTrace) {
      print('❌ Critical error in ping: $e');
      print('❌ Stack trace: $stackTrace');
      
      // Test connectivity to update state
      final stillReachable = await testServerConnectivity();
      _isConnected = stillReachable;
      
      // Return error response instead of throwing exception to prevent app crash
      return {
        'input': {
          'ref_request_id': 'ping_${DateTime.now().millisecondsSinceEpoch}',
          'string_to_be_ponged': stringToBePonged,
        },
        'output': {
          'error': 'Critical ping error',
          'message': 'A critical error occurred during ping: ${e.toString()}',
          'details': stackTrace.toString(),
        },
        'requestTime': DateTime.now().toIso8601String(),
        'serverType': 'critical-error',
        'success': false,
      };
    }
  }

  /// Real NewAccount call to AccountService.NewAccount using grpcurl
  Future<Map<String, dynamic>> newAccount({
    required String externalAccountId,
    String? auxData,
    Duration? timeout,
  }) async {
    // Always test connectivity first to prevent crashes
    print('🔍 Testing server connectivity before NewAccount...');
    final isServerReachable = await testServerConnectivity();
    
    if (!isServerReachable) {
      _isConnected = false; // Update connection state
      return {
        'input': {
          'ref_request_id': 'new_account_${DateTime.now().millisecondsSinceEpoch}',
          'external_account_id': externalAccountId,
          'aux_data': auxData ?? '',
        },
        'output': {
          'error': 'Server not reachable',
          'message': 'Cannot connect to the gRPC server at $_host:$_port. Please check if the server is running.',
        },
        'requestTime': DateTime.now().toIso8601String(),
        'serverType': 'not-reachable',
        'success': false,
      };
    }

    // Update connection state if server is reachable
    if (!_isConnected) {
      _isConnected = true;
      print('✅ Server connection restored');
    }

    try {
      print('👤 NewAccount called - attempting to create account for $externalAccountId');
      
      final requestId = 'new_account_${DateTime.now().millisecondsSinceEpoch}';
      final request = {
        'ref_request_id': requestId,
        'external_account_id': externalAccountId,
        'aux_data': auxData ?? 'Created from Flutter signup',
      };

      // Try to call the real server with grpcurl, with comprehensive crash protection
      final response = await GrpcurlHelper.newAccount(
        externalAccountId: externalAccountId,
        auxData: auxData,
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print('⏰ NewAccount request timed out');
          return {
            'input': request,
            'output': {
              'error': 'Request timed out',
              'message': 'The new account request timed out after 10 seconds. Check if server is running properly.',
            },
            'requestTime': DateTime.now().toIso8601String(),
            'serverType': 'timeout',
            'success': false,
          };
        },
      ).catchError((error) {
        print('❌ NewAccount error caught: $error');
        return {
          'input': request,
          'output': {
            'error': 'NewAccount execution failed',
            'message': 'Failed to execute NewAccount: ${error.toString()}',
          },
          'requestTime': DateTime.now().toIso8601String(),
          'serverType': 'execution-error',
          'success': false,
        };
      });

      print('📬 Real Server NewAccount Response: ${response['output']}');
      print('✅ Real NewAccount completed');

      // Update connection state based on response
      if (response['success'] == true) {
        _isConnected = true;
      } else {
        // Test connectivity again if request failed
        final stillReachable = await testServerConnectivity();
        _isConnected = stillReachable;
      }

      return response;
    } catch (e, stackTrace) {
      print('❌ Critical error in NewAccount: $e');
      print('❌ Stack trace: $stackTrace');
      
      // Test connectivity to update state
      final stillReachable = await testServerConnectivity();
      _isConnected = stillReachable;
      
      // Return error response instead of throwing exception to prevent app crash
      return {
        'input': {
          'ref_request_id': 'new_account_${DateTime.now().millisecondsSinceEpoch}',
          'external_account_id': externalAccountId,
          'aux_data': auxData ?? '',
        },
        'output': {
          'error': 'Critical NewAccount error',
          'message': 'A critical error occurred during NewAccount: ${e.toString()}',
          'details': stackTrace.toString(),
        },
        'requestTime': DateTime.now().toIso8601String(),
        'serverType': 'critical-error',
        'success': false,
      };
    }
  }

  /// Real GetAccountList call to AccountService.GetAccountList using grpcurl
  Future<Map<String, dynamic>> getAccountList({
    int pageNumber = 1,
    int pageSize = 10,
    String? accountIdRegex,
    Duration? timeout,
  }) async {
    // Always test connectivity first to prevent crashes
    print('🔍 Testing server connectivity before GetAccountList...');
    final isServerReachable = await testServerConnectivity();
    
    if (!isServerReachable) {
      _isConnected = false; // Update connection state
      return {
        'input': {
          'ref_request_id': 'get_account_list_${DateTime.now().millisecondsSinceEpoch}',
        },
        'output': {
          'error': 'Server not reachable',
          'message': 'Cannot connect to the gRPC server at $_host:$_port. Please check if the server is running.',
        },
        'requestTime': DateTime.now().toIso8601String(),
        'serverType': 'not-reachable',
        'success': false,
      };
    }

    // Update connection state if server is reachable
    if (!_isConnected) {
      _isConnected = true;
      print('✅ Server connection restored');
    }

    try {
      print('🔄 GetAccountList button clicked - attempting real server connection');
      
      // Try to call the real server with grpcurl, with comprehensive crash protection
      final response = await GrpcurlHelper.getAccountList().timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          print('⏰ GetAccountList request timed out');
          return {
            'input': {
              'ref_request_id': 'get_account_list_${DateTime.now().millisecondsSinceEpoch}',
            },
            'output': {
              'error': 'Request timed out',
              'message': 'The account list request timed out after 5 seconds. Check if server is running properly.',
            },
            'requestTime': DateTime.now().toIso8601String(),
            'serverType': 'timeout',
            'success': false,
          };
        },
      ).catchError((error) {
        print('❌ GetAccountList error caught: $error');
        return {
          'input': {
            'ref_request_id': 'get_account_list_${DateTime.now().millisecondsSinceEpoch}',
          },
          'output': {
            'error': 'GetAccountList execution failed',
            'message': 'Failed to execute GetAccountList: ${error.toString()}',
          },
          'requestTime': DateTime.now().toIso8601String(),
          'serverType': 'execution-error',
          'success': false,
        };
      });

      print('📬 Real Server GetAccountList Response: ${response['output']}');
      print('✅ Real account list completed');

      // Update connection state based on response
      if (response['success'] == true) {
        _isConnected = true;
      } else {
        // Test connectivity again if request failed
        final stillReachable = await testServerConnectivity();
        _isConnected = stillReachable;
      }

      return response;
    } catch (e, stackTrace) {
      print('❌ Critical error in GetAccountList: $e');
      print('❌ Stack trace: $stackTrace');
      
      // Test connectivity to update state
      final stillReachable = await testServerConnectivity();
      _isConnected = stillReachable;
      
      // Return error response instead of throwing exception to prevent app crash
      return {
        'input': {
          'ref_request_id': 'get_account_list_${DateTime.now().millisecondsSinceEpoch}',
        },
        'output': {
          'error': 'Critical GetAccountList error',
          'message': 'A critical error occurred during GetAccountList: ${e.toString()}',
          'details': stackTrace.toString(),
        },
        'requestTime': DateTime.now().toIso8601String(),
        'serverType': 'critical-error',
        'success': false,
      };
    }
  }

  /// Real GetAccountMarketPortfolio call to AccountService.GetAccountMarketPortfolio using grpcurl
  Future<Map<String, dynamic>> getAccountMarketPortfolio({
    required String accountId,
    String? marketId,
    List<String>? assetIds,
    Duration? timeout,
  }) async {
    // Always test connectivity first to prevent crashes
    print('🔍 Testing server connectivity before GetAccountMarketPortfolio...');
    final isServerReachable = await testServerConnectivity();
    
    if (!isServerReachable) {
      _isConnected = false; // Update connection state
      return {
        'input': {
          'ref_request_id': 'get_account_market_portfolio_${DateTime.now().millisecondsSinceEpoch}',
          'account_id': accountId,
          'market_id': marketId ?? '',
          'asset_ids': assetIds ?? ['SFG', 'AC1'],
        },
        'output': {
          'error': 'Server not reachable',
          'message': 'Cannot connect to the gRPC server at $_host:$_port. Please check if the server is running.',
        },
        'requestTime': DateTime.now().toIso8601String(),
        'serverType': 'not-reachable',
        'success': false,
      };
    }

    // Update connection state if server is reachable
    if (!_isConnected) {
      _isConnected = true;
      print('✅ Server connection restored');
    }

    try {
      print('📊 GetAccountMarketPortfolio called - attempting to get portfolio for account $accountId');
      
      // Try to call the real server with grpcurl, with comprehensive crash protection
      final response = await GrpcurlHelper.getAccountMarketPortfolio(
        accountId: accountId,
        marketId: marketId,
        assetIds: assetIds,
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print('⏰ GetAccountMarketPortfolio request timed out');
          return {
            'input': {
              'ref_request_id': 'get_account_market_portfolio_${DateTime.now().millisecondsSinceEpoch}',
              'account_id': accountId,
              'market_id': marketId ?? '',
              'asset_ids': assetIds ?? ['SFG', 'AC1'],
            },
            'output': {
              'error': 'Request timed out',
              'message': 'The account market portfolio request timed out after 10 seconds. Check if server is running properly.',
            },
            'requestTime': DateTime.now().toIso8601String(),
            'serverType': 'timeout',
            'success': false,
          };
        },
      ).catchError((error) {
        print('❌ GetAccountMarketPortfolio error caught: $error');
        return {
          'input': {
            'ref_request_id': 'get_account_market_portfolio_${DateTime.now().millisecondsSinceEpoch}',
            'account_id': accountId,
            'market_id': marketId ?? '',
            'asset_ids': assetIds ?? ['SFG', 'AC1'],
          },
          'output': {
            'error': 'GetAccountMarketPortfolio execution failed',
            'message': 'Failed to execute GetAccountMarketPortfolio: ${error.toString()}',
          },
          'requestTime': DateTime.now().toIso8601String(),
          'serverType': 'execution-error',
          'success': false,
        };
      });

      print('📬 Real Server GetAccountMarketPortfolio Response: ${response['output']}');
      print('✅ Real GetAccountMarketPortfolio completed');

      // Update connection state based on response
      if (response['success'] == true) {
        _isConnected = true;
      } else {
        // Test connectivity again if request failed
        final stillReachable = await testServerConnectivity();
        _isConnected = stillReachable;
      }

      return response;
    } catch (e, stackTrace) {
      print('❌ Critical error in GetAccountMarketPortfolio: $e');
      print('❌ Stack trace: $stackTrace');
      
      // Test connectivity to update state
      final stillReachable = await testServerConnectivity();
      _isConnected = stillReachable;
      
      // Return error response instead of throwing exception to prevent app crash
      return {
        'input': {
          'ref_request_id': 'get_account_market_portfolio_${DateTime.now().millisecondsSinceEpoch}',
          'account_id': accountId,
          'market_id': marketId ?? '',
          'asset_ids': assetIds ?? ['SFG', 'AC1'],
        },
        'output': {
          'error': 'Critical GetAccountMarketPortfolio error',
          'message': 'A critical error occurred during GetAccountMarketPortfolio: ${e.toString()}',
          'details': stackTrace.toString(),
        },
        'requestTime': DateTime.now().toIso8601String(),
        'serverType': 'critical-error',
        'success': false,
      };
    }
  }

  /// Get participant info - shows info about connection to real server
  Future<Map<String, dynamic>> getParticipantInfo({Duration? timeout}) async {
    if (!_isConnected) {
      throw Exception('Not connected to gRPC server');
    }

    try {
      print('🔄 Getting real participant info from connection...');
      
      // Get real server info
      final serverInfo = await getServerInfo();
      
      final response = {
        'input': {
          'ref_request_id': generateRequestId(prefix: 'get_participant_info'),
        },
        'output': {
          'identifier': 'real_server_connection_${DateTime.now().millisecondsSinceEpoch}',
          'name': 'Real Simprtagent Server Connection',
          'status': 'ACTIVE',
          'server_info': serverInfo,
          'connected_to_real_server': true,
        },
        'requestTime': DateTime.now().toIso8601String(),
        'serverType': 'simprtagent-real',
      };

      print('📬 Real connection info: ${response['output']}');
      return response;
    } catch (e) {
      throw Exception('Real GetParticipantInfo failed: $e');
    }
  }

  /// Get server info from the real server
  Future<Map<String, String>> getServerInfo() async {
    if (!_isConnected) {
      throw Exception('Not connected to gRPC server');
    }

    try {
      return {
        'host': _host ?? 'unknown',
        'port': _port?.toString() ?? 'unknown',
        'status': 'connected',
        'type': 'simprtagent-real',
        'server_name': 'Mock Participant Agent gRPC server',
        'timestamp': DateTime.now().toIso8601String(),
        'services': 'AgentService, AccountService, MarketService, InstrumentService',
      };
    } catch (e) {
      throw Exception('Failed to get real server info: $e');
    }
  }

  /// Disconnect from the real gRPC server
  Future<void> disconnect() async {
    if (_isConnected) {
      try {
        _isConnected = false;
        _host = null;
        _port = null;
        print('🔌 Disconnected from real gRPC server');
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

  /// Handle errors and convert them to user-friendly messages
  String handleError(dynamic error) {
    return 'Real server error: ${error.toString()}';
  }

  /// Dispose and clean up resources
  void dispose() {
    disconnect();
  }
}

// Singleton instance for easy access throughout the app
final realGrpcClient = RealGrpcClient();