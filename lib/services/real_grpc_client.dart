import 'dart:convert';
import 'dart:io';
import 'grpcurl_helper.dart';

/// Real gRPC client that uses grpcurl to communicate with the actual simprtagent server
class RealGrpcClient {
  
  /// Convert DateTime to Unix timestamp (seconds since epoch)
  static int _toUnixTimestamp(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch ~/ 1000;
  }
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
          'proposed_execution_id': 'ping_${DateTime.now().millisecondsSinceEpoch}',
          'string_to_be_ponged': stringToBePonged,
        },
        'output': {
          'error': 'Server not reachable',
          'message': 'Cannot connect to the gRPC server at $_host:$_port. Please check if the server is running.',
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
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
              'proposed_execution_id': 'ping_${DateTime.now().millisecondsSinceEpoch}',
              'string_to_be_ponged': stringToBePonged,
            },
            'output': {
              'error': 'Request timed out',
              'message': 'The ping request timed out after 5 seconds. Check if server is running properly.',
            },
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
            'serverType': 'timeout',
            'success': false,
          };
        },
      ).catchError((error) {
        print('❌ Ping error caught: $error');
        return {
          'input': {
            'proposed_execution_id': 'ping_${DateTime.now().millisecondsSinceEpoch}',
            'string_to_be_ponged': stringToBePonged,
          },
          'output': {
            'error': 'Ping execution failed',
            'message': 'Failed to execute ping: ${error.toString()}',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
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
          'proposed_execution_id': 'ping_${DateTime.now().millisecondsSinceEpoch}',
          'string_to_be_ponged': stringToBePonged,
        },
        'output': {
          'error': 'Critical ping error',
          'message': 'A critical error occurred during ping: ${e.toString()}',
          'details': stackTrace.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
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
          'proposed_execution_id': 'new_account_${DateTime.now().millisecondsSinceEpoch}',
          'external_account_id': externalAccountId,
          'aux_data': auxData ?? '',
        },
        'output': {
          'error': 'Server not reachable',
          'message': 'Cannot connect to the gRPC server at $_host:$_port. Please check if the server is running.',
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
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
        'proposed_execution_id': requestId,
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
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
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
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
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
          'proposed_execution_id': 'new_account_${DateTime.now().millisecondsSinceEpoch}',
          'external_account_id': externalAccountId,
          'aux_data': auxData ?? '',
        },
        'output': {
          'error': 'Critical NewAccount error',
          'message': 'A critical error occurred during NewAccount: ${e.toString()}',
          'details': stackTrace.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'critical-error',
        'success': false,
      };
    }
  }

  /// Real GetAccountList call to AccountService.GetAccountList using grpcurl
  Future<Map<String, dynamic>> getAccountList({
    int pageNumber = 0,
    int pageSize = 0,
    String? accountIdRegex,
    Map<String, String>? auxData,
    Duration? timeout,
  }) async {
    // Always test connectivity first to prevent crashes
    print('🔍 Testing server connectivity before GetAccountList...');
    final isServerReachable = await testServerConnectivity();
    
    if (!isServerReachable) {
      _isConnected = false; // Update connection state
      return {
        'input': {
          'proposed_execution_id': 'get_account_list_${DateTime.now().millisecondsSinceEpoch}',
          'pagination': {
            'page_nr': pageNumber,
            'page_size': pageSize,
            'page_token': '',
          },
          if (accountIdRegex != null && accountIdRegex.isNotEmpty)
            'account_iid_or_external_id_regex': accountIdRegex,
          if (auxData != null && auxData.isNotEmpty)
            'aux_data': auxData,
        },
        'output': {
          'error': 'Server not reachable',
          'message': 'Cannot connect to the gRPC server at $_host:$_port. Please check if the server is running.',
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
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
      final response = await GrpcurlHelper.getAccountList(
        pageNumber: pageNumber,
        pageSize: pageSize,
        accountIdRegex: accountIdRegex,
        auxData: auxData,
      ).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          print('⏰ GetAccountList request timed out');
          return {
            'input': {
              'proposed_execution_id': 'get_account_list_${DateTime.now().millisecondsSinceEpoch}',
              'pagination': {
                'page_nr': pageNumber,
                'page_size': pageSize,
                'page_token': '',
              },
              if (accountIdRegex != null && accountIdRegex.isNotEmpty)
                'account_iid_or_external_id_regex': accountIdRegex,
              if (auxData != null && auxData.isNotEmpty)
                'aux_data': auxData,
            },
            'output': {
              'error': 'Request timed out',
              'message': 'The account list request timed out after 5 seconds. Check if server is running properly.',
            },
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
            'serverType': 'timeout',
            'success': false,
          };
        },
      ).catchError((error) {
        print('❌ GetAccountList error caught: $error');
        return {
          'input': {
            'proposed_execution_id': 'get_account_list_${DateTime.now().millisecondsSinceEpoch}',
            'pagination': {
              'page_nr': pageNumber,
              'page_size': pageSize,
              'page_token': '',
            },
            if (accountIdRegex != null && accountIdRegex.isNotEmpty)
              'account_iid_or_external_id_regex': accountIdRegex,
            if (auxData != null && auxData.isNotEmpty)
              'aux_data': auxData,
          },
          'output': {
            'error': 'GetAccountList execution failed',
            'message': 'Failed to execute GetAccountList: ${error.toString()}',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
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
          'proposed_execution_id': 'get_account_list_${DateTime.now().millisecondsSinceEpoch}',
        },
        'output': {
          'error': 'Critical GetAccountList error',
          'message': 'A critical error occurred during GetAccountList: ${e.toString()}',
          'details': stackTrace.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'critical-error',
        'success': false,
      };
    }
  }

  /// Real GetAccountInstrumentHoldings call to AccountService.GetAccountInstrumentHoldings using grpcurl
  Future<Map<String, dynamic>> getAccountMarketPortfolio({
    required String accountId,
    String? marketId,
    List<String>? assetIds,
    Duration? timeout,
  }) async {
    // Always test connectivity first to prevent crashes
    print('🔍 Testing server connectivity before GetAccountInstrumentHoldings...');
    final isServerReachable = await testServerConnectivity();
    
    if (!isServerReachable) {
      _isConnected = false; // Update connection state
      return {
        'input': {
          'proposed_execution_id': 'get_account_instrument_holdings_${DateTime.now().millisecondsSinceEpoch}',
          'account_iid': accountId,
        },
        'output': {
          'error': 'Server not reachable',
          'message': 'Cannot connect to the gRPC server at $_host:$_port. Please check if the server is running.',
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
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
      print('📊 GetAccountInstrumentHoldings called - attempting to get instrument holdings for account $accountId');
      
      // Try to call the real server with grpcurl, with comprehensive crash protection
      final response = await GrpcurlHelper.getAccountMarketPortfolio(
        accountId: accountId,
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print('⏰ GetAccountInstrumentHoldings request timed out');
          return {
            'input': {
              'proposed_execution_id': 'get_account_instrument_holdings_${DateTime.now().millisecondsSinceEpoch}',
              'account_iid': accountId,
            },
            'output': {
              'error': 'Request timed out',
              'message': 'The account instrument holdings request timed out after 10 seconds. Check if server is running properly.',
            },
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
            'serverType': 'timeout',
            'success': false,
          };
        },
      ).catchError((error) {
        print('❌ GetAccountInstrumentHoldings error caught: $error');
        return {
          'input': {
            'proposed_execution_id': 'get_account_instrument_holdings_${DateTime.now().millisecondsSinceEpoch}',
            'account_iid': accountId,
          },
          'output': {
            'error': 'GetAccountInstrumentHoldings execution failed',
            'message': 'Failed to execute GetAccountInstrumentHoldings: ${error.toString()}',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'execution-error',
          'success': false,
        };
      });

      print('📬 Real Server GetAccountInstrumentHoldings Response: ${response['output']}');
      print('✅ Real GetAccountInstrumentHoldings completed');

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
      print('❌ Critical error in GetAccountInstrumentHoldings: $e');
      print('❌ Stack trace: $stackTrace');
      
      // Test connectivity to update state
      final stillReachable = await testServerConnectivity();
      _isConnected = stillReachable;
      
      // Return error response instead of throwing exception to prevent app crash
      return {
        'input': {
          'proposed_execution_id': 'get_account_instrument_holdings_${DateTime.now().millisecondsSinceEpoch}',
          'account_iid': accountId,
        },
        'output': {
          'error': 'Critical GetAccountInstrumentHoldings error',
          'message': 'A critical error occurred during GetAccountInstrumentHoldings: ${e.toString()}',
          'details': stackTrace.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'critical-error',
        'success': false,
      };
    }
  }

  /// Real GetAccountCashHoldings call to AccountService.GetAccountCashHoldings using grpcurl
  Future<Map<String, dynamic>> getAccountCashHoldings({
    required String accountId,
    List<String>? cashAssetIds,
    Duration? timeout,
  }) async {
    // Always test connectivity first to prevent crashes
    print('🔍 Testing server connectivity before GetAccountCashHoldings...');
    final isServerReachable = await testServerConnectivity();
    
    if (!isServerReachable) {
      _isConnected = false; // Update connection state
      return {
        'input': {
          'proposed_execution_id': 'get_account_cash_holdings_${DateTime.now().millisecondsSinceEpoch}',
          'account_iid': accountId,
          'currency_codes': cashAssetIds ?? [],
        },
        'output': {
          'error': 'Server not reachable',
          'message': 'Cannot connect to the gRPC server at $_host:$_port. Please check if the server is running.',
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
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
      print('💰 GetAccountCashHoldings called - attempting to get cash holdings for account $accountId');
      
      // Try to call the real server with grpcurl, with comprehensive crash protection
      final response = await GrpcurlHelper.getAccountCashHoldings(
        accountId: accountId,
        cashAssetIds: cashAssetIds,
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print('⏰ GetAccountCashHoldings request timed out');
          return {
            'input': {
              'proposed_execution_id': 'get_account_cash_holdings_${DateTime.now().millisecondsSinceEpoch}',
              'account_iid': accountId,
              'currency_codes': cashAssetIds ?? [],
            },
            'output': {
              'error': 'Request timed out',
              'message': 'The account cash holdings request timed out after 10 seconds. Check if server is running properly.',
            },
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
            'serverType': 'timeout',
            'success': false,
          };
        },
      ).catchError((error) {
        print('❌ GetAccountCashHoldings error caught: $error');
        return {
          'input': {
            'proposed_execution_id': 'get_account_cash_holdings_${DateTime.now().millisecondsSinceEpoch}',
            'account_iid': accountId,
            'currency_codes': cashAssetIds ?? [],
          },
          'output': {
            'error': 'GetAccountCashHoldings execution failed',
            'message': 'Failed to execute GetAccountCashHoldings: ${error.toString()}',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'execution-error',
          'success': false,
        };
      });

      print('📬 Real Server GetAccountCashHoldings Response: ${response['output']}');
      print('✅ Real GetAccountCashHoldings completed');

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
      print('❌ Critical error in GetAccountCashHoldings: $e');
      print('❌ Stack trace: $stackTrace');
      
      // Test connectivity to update state
      final stillReachable = await testServerConnectivity();
      _isConnected = stillReachable;
      
      // Return error response instead of throwing exception to prevent app crash
      return {
        'input': {
          'proposed_execution_id': 'get_account_cash_holdings_${DateTime.now().millisecondsSinceEpoch}',
          'account_iid': accountId,
          'currency_codes': cashAssetIds ?? [],
        },
        'output': {
          'error': 'Critical GetAccountCashHoldings error',
          'message': 'A critical error occurred during GetAccountCashHoldings: ${e.toString()}',
          'details': stackTrace.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
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
          'proposed_execution_id': generateRequestId(prefix: 'get_participant_info'),
        },
        'output': {
          'identifier': 'real_server_connection_${DateTime.now().millisecondsSinceEpoch}',
          'name': 'Real Simprtagent Server Connection',
          'status': 'ACTIVE',
          'server_info': serverInfo,
          'connected_to_real_server': true,
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
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
        'timestamp': _toUnixTimestamp(DateTime.now()).toString(),
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

  /// Real GetAccountOrders call to PortfolioService.GetAccountOrders using grpcurl
  Future<Map<String, dynamic>> getAccountOrders({
    required String accountId,
    List<String>? marketIdOrNameRegexes,
    Map<String, dynamic>? pagination,
    String? fromTime,
    String? toTime,
    String? side,
    List<bool>? statusFilters,
    List<String>? instrumentIdOrSymbolRegexes,
  }) async {
    if (!_isConnected) {
      return {
        'input': {'account_iid': accountId},
        'output': {'error': 'Not connected to server'},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'disconnected',
        'success': false,
      };
    }

    try {
      print('📋 Fetching orders for account: $accountId');

      final response = await Future.any([
        GrpcurlHelper.getAccountOrders(
          accountId: accountId,
          refRequestId: generateRequestId(prefix: 'get_orders'),
          marketIdOrNameRegexes: marketIdOrNameRegexes,
          pagination: pagination,
          fromTime: fromTime,
          toTime: toTime,
          side: side,
          statusFilters: statusFilters,
          instrumentIdOrSymbolRegexes: instrumentIdOrSymbolRegexes,
        ),
      ]).catchError((error) {
        print('❌ GetAccountOrders execution error: $error');
        return {
          'input': {'account_iid': accountId},
          'output': {
            'error': 'GetAccountOrders execution error',
            'message': error.toString(),
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'execution-error',
          'success': false,
        };
      });

      print('📬 Real Server GetAccountOrders Response: ${response['output']}');
      print('✅ Real get account orders completed');

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
      print('❌ Critical error in GetAccountOrders: $e');
      print('❌ Stack trace: $stackTrace');
      
      // Test connectivity to update state
      final stillReachable = await testServerConnectivity();
      _isConnected = stillReachable;
      
      // Return error response instead of throwing exception to prevent app crash
      return {
        'input': {'account_iid': accountId},
        'output': {
          'error': 'Critical GetAccountOrders error',
          'message': 'A critical error occurred during GetAccountOrders: ${e.toString()}',
          'details': stackTrace.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'critical-error',
        'success': false,
      };
    }
  }

  /// Real GetAccountTrades call to PortfolioService.GetAccountTrades using grpcurl
  Future<Map<String, dynamic>> getAccountTrades({
    required String accountId,
    List<String>? marketIdOrNameRegexes,
    Map<String, dynamic>? pagination,
    String? fromTime,
    String? toTime,
    String? side,
    List<String>? instrumentIdOrSymbolRegexes,
  }) async {
    if (!_isConnected) {
      return {
        'input': {'account_iid': accountId},
        'output': {'error': 'Not connected to server'},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'disconnected',
        'success': false,
      };
    }

    try {
      print('📋 Fetching trades for account: $accountId');

      final response = await Future.any([
        GrpcurlHelper.getAccountTrades(
          accountId: accountId,
          refRequestId: generateRequestId(prefix: 'get_trades'),
          marketIdOrNameRegexes: marketIdOrNameRegexes,
          pagination: pagination,
          fromTime: fromTime,
          toTime: toTime,
          side: side,
          instrumentIdOrSymbolRegexes: instrumentIdOrSymbolRegexes,
        ),
      ]).catchError((error) {
        print('❌ GetAccountTrades execution error: $error');
        return {
          'input': {'account_iid': accountId},
          'output': {
            'error': 'GetAccountTrades execution error',
            'message': error.toString(),
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'execution-error',
          'success': false,
        };
      });

      print('📬 Real Server GetAccountTrades Response: ${response['output']}');
      print('✅ Real get account trades completed');

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
      print('❌ Critical error in GetAccountTrades: $e');
      print('❌ Stack trace: $stackTrace');
      
      // Test connectivity to update state
      final stillReachable = await testServerConnectivity();
      _isConnected = stillReachable;
      
      // Return error response instead of throwing exception to prevent app crash
      return {
        'input': {'account_iid': accountId},
        'output': {
          'error': 'Critical GetAccountTrades error',
          'message': 'A critical error occurred during GetAccountTrades: ${e.toString()}',
          'details': stackTrace.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'critical-error',
        'success': false,
      };
    }
  }

  /// Real GetMarketList call to MarketService.GetMarketList using grpcurl
  Future<Map<String, dynamic>> getMarketList({Duration? timeout}) async {
    if (!_isConnected) {
      return {
        'input': {},
        'output': {'error': 'Not connected to server'},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'disconnected',
        'success': false,
      };
    }

    try {
      print('📋 Getting market list from real server...');

      final inputParams = {
        'proposed_execution_id': 'get_markets_${DateTime.now().millisecondsSinceEpoch}',
      };

      final result = await GrpcurlHelper.getMarketList();

      print('📤 GetMarketList OUTPUT: ${result.toString()}');
      return {
        'input': inputParams,
        'output': result['success'] ? result['output'] : {'error': result['error'] ?? 'Unknown error'},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'real_grpc',
        'success': result['success'] ?? false,
      };
    } catch (e) {
      print('❌ Critical error in getMarketList: $e');
      return {
        'input': {},
        'output': {'error': 'Critical error: $e'},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'critical-error',
        'success': false,
      };
    }
  }

  /// Real GetMarketInstrumentList call to MarketService.GetMarketInstrumentList using grpcurl
  Future<Map<String, dynamic>> getMarketInstrumentList({
    required String marketId,
    int pageNumber = 0,
    int pageSize = 0,
    Duration? timeout,
  }) async {
    if (!_isConnected) {
      return {
        'input': {'market_id': marketId},
        'output': {'error': 'Not connected to server'},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'disconnected',
        'success': false,
      };
    }

    try {
      print('📋 Getting market instrument list for market: $marketId from real server...');

      final inputParams = {
        'proposed_execution_id': 'get_instrument_list_${DateTime.now().millisecondsSinceEpoch}',
        'market_id': marketId,
      };

      final result = await GrpcurlHelper.getMarketInstrumentList(
        marketId: marketId,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );

      print('📤 GetMarketInstrumentList OUTPUT: ${result.toString()}');
      return {
        'input': inputParams,
        'output': result['success'] ? result['output'] : {'error': result['error'] ?? 'Unknown error'},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'real_grpc',
        'success': result['success'] ?? false,
      };
    } catch (e) {
      print('❌ Critical error in getMarketInstrumentList: $e');
      return {
        'input': {'market_id': marketId},
        'output': {'error': 'Critical error: $e'},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'critical-error',
        'success': false,
      };
    }
  }

  /// Get supported currencies using the real gRPC server
  Future<Map<String, dynamic>> getSupportedCurrencies({
    int pageNumber = 0,
    int pageSize = 0,
  }) async {
    try {
      print('🏦 Getting supported currencies...');

      final result = await GrpcurlHelper.getSupportedCurrencies(
        pageNumber: pageNumber,
        pageSize: pageSize,
      );

      return result;
    } catch (e) {
      print('❌ Critical error in getSupportedCurrencies: $e');
      return {
        'input': {
          'page_nr': pageNumber,
          'page_size': pageSize,
        },
        'output': {'error': 'Critical error: $e'},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'critical-error',
        'success': false,
      };
    }
  }

  /// Get market supported currencies using the real gRPC server
  Future<Map<String, dynamic>> getMarketSupportedCurrencies({
    required String marketId,
    int pageNumber = 0,
    int pageSize = 0,
  }) async {
    try {
      print('🏦 Getting market supported currencies for market: $marketId');
      final result = await GrpcurlHelper.getMarketSupportedCurrencies(
        marketId: marketId,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      print('📤 GetMarketSupportedCurrencies OUTPUT: ${result.toString()}');
      return {
        'input': {
          'market_id': marketId,
          'page_nr': pageNumber,
          'page_size': pageSize,
        },
        'output': result['success'] ? result['output'] : {'error': result['output']?['error'] ?? 'Unknown error'},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'real_grpc',
        'success': result['success'] ?? false,
      };
    } catch (e) {
      print('❌ Critical error in getMarketSupportedCurrencies: $e');
      return {
        'input': {
          'market_id': marketId,
          'page_nr': pageNumber,
          'page_size': pageSize,
        },
        'output': {'error': 'Critical error: $e'},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'critical-error',
        'success': false,
      };
    }
  }

  /// Get order fees using the real gRPC server
  Future<Map<String, dynamic>> getOrderFees({
    required String accountId,
    required String feePayerAccountId,
    required String instrumentId,
    required String orderType, // "LIMIT" or "MARKET"
    required String side, // "BUY" or "SELL"
    required String quantity,
    String? price, // Required for LIMIT orders
    String timeInForce = "0", // Always 0 according to requirements
  }) async {
    try {
      print('💰 Getting order fees...');

      final result = await GrpcurlHelper.getOrderFees(
        accountId: accountId,
        feePayerAccountId: feePayerAccountId,
        instrumentId: instrumentId,
        orderType: orderType,
        side: side,
        quantity: quantity,
        price: price,
        timeInForce: timeInForce,
      );

      print('📤 GetOrderFees OUTPUT: ${result.toString()}');
      return {
        'input': {
          'account_iid': accountId,
          'fee_payer_account_iid': feePayerAccountId,
          'instrument_listing_iid': instrumentId,
          'order_type': orderType,
          'side': side,
          'quantity': quantity,
          'price': price,
          'time_in_force': timeInForce,
        },
        'output': result['success'] ? result['output'] : {'error': result['error'] ?? 'Unknown error'},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'real_grpc',
        'success': result['success'] ?? false,
      };
    } catch (e) {
      print('❌ Critical error in getOrderFees: $e');
      return {
        'input': {
          'account_iid': accountId,
          'fee_payer_account_iid': feePayerAccountId,
          'instrument_listing_iid': instrumentId,
          'order_type': orderType,
          'side': side,
          'quantity': quantity,
          'price': price,
          'time_in_force': timeInForce,
        },
        'output': {'error': 'Critical error: $e'},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'critical-error',
        'success': false,
      };
    }
  }

  Future<Map<String, dynamic>> createOrder({
    required String accountId,
    required String feePayerAccountId,
    required String instrumentId,
    required String orderType, // "LIMIT" or "MARKET"
    required String side, // "BUY" or "SELL"
    required String quantity,
    required String price, // Must be zero for MARKET orders
    String timeInForce = "0", // "0" for GTC, "1" for IOC, "2" for FOK, "3" for DAY
    DateTime? expireTime,
    required String participantOrderId,
    String? metadata,
    String? auxData,
  }) async {
    try {
      // Ensure connection
      if (!isConnected) {
        await connect(host: _host ?? 'localhost', port: _port ?? 50051);
      }

      final result = await GrpcurlHelper.createOrder(
        accountId: accountId,
        feePayerAccountId: feePayerAccountId,
        instrumentId: instrumentId,
        orderType: orderType,
        side: side,
        quantity: quantity,
        price: price,
        timeInForce: timeInForce,
        expireTime: expireTime,
        participantOrderId: participantOrderId,
        metadata: metadata,
        auxData: auxData,
      );

      return result;
    } catch (e) {
      print('❌ Critical error in createOrder: $e');
      return {
        'request': {
          'account_iid': accountId,
          'fee_payer_account_iid': feePayerAccountId,
          'instrument_listing_iid': instrumentId,
          'order_type': orderType,
          'side': side,
          'quantity': quantity,
          'price': price,
          'time_in_force': timeInForce,
          'participant_order_iid': participantOrderId,
        },
        'output': {'error': 'Critical error: $e'},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'critical-error',
        'success': false,
      };
    }
  }

  /// Dispose and clean up resources
  void dispose() {
    disconnect();
  }
}

// Singleton instance for easy access throughout the app
final realGrpcClient = RealGrpcClient();