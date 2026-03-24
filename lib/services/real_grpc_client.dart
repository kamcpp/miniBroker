import 'dart:convert';
import 'dart:io';
import 'grpc_helper.dart';
import '../config/app_config.dart';

/// Real gRPC client that uses native Dart gRPC to communicate with the simprtagent server
class RealGrpcClient {

  /// Convert DateTime to Unix timestamp (seconds since epoch)
  static int _toUnixTimestamp(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch ~/ 1000;
  }
  bool _isConnected = false;
  String _host = AppConfig.grpcHost;
  int _port = AppConfig.grpcPort;

  // Getters
  bool get isConnected => _isConnected;
  String get currentHost => _host;
  int get currentPort => _port;

  /// Connect to the actual gRPC server via native gRPC
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

  /// Test connection via native gRPC to verify server is actually working (async, non-blocking)
  void _testConnectionAsync() {
    // Run this in background without blocking the connection
    Future.delayed(Duration.zero, () async {
      try {
        print('🔄 Testing connection to real gRPC server...');
        
        // Test if gRPC server is reachable with very short timeout
        final isServerReachable = await GrpcHelper.testConnection().timeout(
          const Duration(seconds: 1),
          onTimeout: () {
            print('⏰ gRPC test timed out after 1 second');
            return false;
          },
        );
        
        if (isServerReachable) {
          print('✅ Real gRPC server is reachable');
          
          // List available services to confirm (with timeout)
          try {
            final services = await GrpcHelper.listServices().timeout(
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
          print('⚠️ Real gRPC server is not reachable (but connection established)');
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
      print('🔌 Testing socket connection to $_host:$_port...');
      final socket = await Socket.connect(_host, _port, timeout: const Duration(seconds: 2));
      await socket.close();
      print('✅ Server is reachable via socket connection');
      return true;
    } catch (e) {
      print('❌ Server not reachable via socket: $e');
      return false;
    }
  }

  /// Real Ping call to AgentService.Ping via native gRPC
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
      
      // Try to call the real server via native gRPC, with comprehensive crash protection
      final response = await GrpcHelper.ping(
        stringToBePonged: stringToBePonged,
      ).timeout(
        const Duration(minutes: 5),
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

  /// Real NewInvestor call to InvestorService.NewInvestor via native gRPC
  Future<Map<String, dynamic>> newInvestor({
    required String externalInvestorId,
    String? auxData,
    Duration? timeout,
  }) async {
    // Always test connectivity first to prevent crashes
    print('🔍 Testing server connectivity before NewInvestor...');
    final isServerReachable = await testServerConnectivity();

    if (!isServerReachable) {
      _isConnected = false; // Update connection state
      return {
        'input': {
          'proposed_execution_id': 'new_investor_${DateTime.now().millisecondsSinceEpoch}',
          'external_investor_id': externalInvestorId,
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
      print('👤 NewInvestor called - attempting to create investor for $externalInvestorId');

      final requestId = 'new_investor_${DateTime.now().millisecondsSinceEpoch}';
      final request = {
        'proposed_execution_id': requestId,
        'external_investor_id': externalInvestorId,
        'aux_data': auxData ?? 'Created from Flutter signup',
      };

      // Try to call the real server via native gRPC, with comprehensive crash protection
      final response = await GrpcHelper.newInvestor(
        externalInvestorId: externalInvestorId,
        auxData: auxData,
      ).timeout(
        const Duration(minutes: 5),
        onTimeout: () {
          print('⏰ NewInvestor request timed out');
          return {
            'input': request,
            'output': {
              'error': 'Request timed out',
              'message': 'The new investor request timed out after 5 minutes. Check if server is running properly.',
            },
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
            'serverType': 'timeout',
            'success': false,
          };
        },
      ).catchError((error) {
        print('❌ NewInvestor error caught: $error');
        return {
          'input': request,
          'output': {
            'error': 'NewInvestor execution failed',
            'message': 'Failed to execute NewInvestor: ${error.toString()}',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'execution-error',
          'success': false,
        };
      });

      print('📬 Real Server NewInvestor Response: ${response['output']}');
      print('✅ Real NewInvestor completed');

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
      print('❌ Critical error in NewInvestor: $e');
      print('❌ Stack trace: $stackTrace');

      // Test connectivity to update state
      final stillReachable = await testServerConnectivity();
      _isConnected = stillReachable;

      // Return error response instead of throwing exception to prevent app crash
      return {
        'input': {
          'proposed_execution_id': 'new_investor_${DateTime.now().millisecondsSinceEpoch}',
          'external_investor_id': externalInvestorId,
          'aux_data': auxData ?? '',
        },
        'output': {
          'error': 'Critical NewInvestor error',
          'message': 'A critical error occurred during NewInvestor: ${e.toString()}',
          'details': stackTrace.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'critical-error',
        'success': false,
      };
    }
  }

  /// Real GetInvestorList call to InvestorService.GetInvestorList via native gRPC
  Future<Map<String, dynamic>> getInvestorList({
    int pageNumber = 0,
    int pageSize = 0,
    String? accountIdRegex,
    Map<String, String>? auxData,
    Duration? timeout,
  }) async {
    // Always test connectivity first to prevent crashes
    print('🔍 Testing server connectivity before GetInvestorList...');
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
      print('🔄 GetInvestorList button clicked - attempting real server connection');
      
      // Try to call the real server via native gRPC, with comprehensive crash protection
      final response = await GrpcHelper.getInvestorList(
        pageNumber: pageNumber,
        pageSize: pageSize,
        investorIdRegex: accountIdRegex,
        auxData: auxData,
      ).timeout(
        const Duration(minutes: 5),
        onTimeout: () {
          print('⏰ GetInvestorList request timed out');
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
        print('❌ GetInvestorList error caught: $error');
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
            'error': 'GetInvestorList execution failed',
            'message': 'Failed to execute GetInvestorList: ${error.toString()}',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'execution-error',
          'success': false,
        };
      });

      print('📬 Real Server GetInvestorList Response: ${response['output']}');
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
      print('❌ Critical error in GetInvestorList: $e');
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
          'error': 'Critical GetInvestorList error',
          'message': 'A critical error occurred during GetInvestorList: ${e.toString()}',
          'details': stackTrace.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'critical-error',
        'success': false,
      };
    }
  }

  /// Real GetInvestorSecurityHoldings call to AccountService.GetInvestorSecurityHoldings via native gRPC
  Future<Map<String, dynamic>> getInvestorSecurityHoldings({
    required String accountId,
    String? marketId,
    List<String>? securityIds,
    Duration? timeout,
  }) async {
    // Always test connectivity first to prevent crashes
    print('🔍 Testing server connectivity before GetInvestorSecurityHoldings...');
    final isServerReachable = await testServerConnectivity();
    
    if (!isServerReachable) {
      _isConnected = false; // Update connection state
      return {
        'input': {
          'proposed_execution_id': 'get_account_security_holdings_${DateTime.now().millisecondsSinceEpoch}',
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
      print('📊 GetInvestorSecurityHoldings called - attempting to get security holdings for account $accountId');

      // Try to call the real server via native gRPC, with comprehensive crash protection
      final response = await GrpcHelper.getInvestorSecurityHoldings(
        investorId: accountId,
      ).timeout(
        const Duration(minutes: 5),
        onTimeout: () {
          print('⏰ GetInvestorSecurityHoldings request timed out');
          return {
            'input': {
              'proposed_execution_id': 'get_account_security_holdings_${DateTime.now().millisecondsSinceEpoch}',
              'account_iid': accountId,
            },
            'output': {
              'error': 'Request timed out',
              'message': 'The account security holdings request timed out after 10 seconds. Check if server is running properly.',
            },
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
            'serverType': 'timeout',
            'success': false,
          };
        },
      ).catchError((error) {
        print('❌ GetInvestorSecurityHoldings error caught: $error');
        return {
          'input': {
            'proposed_execution_id': 'get_account_security_holdings_${DateTime.now().millisecondsSinceEpoch}',
            'account_iid': accountId,
          },
          'output': {
            'error': 'GetInvestorSecurityHoldings execution failed',
            'message': 'Failed to execute GetInvestorSecurityHoldings: ${error.toString()}',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'execution-error',
          'success': false,
        };
      });

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
      print('❌ Critical error in GetInvestorSecurityHoldings: $e');
      print('❌ Stack trace: $stackTrace');

      // Test connectivity to update state
      final stillReachable = await testServerConnectivity();
      _isConnected = stillReachable;

      // Return error response instead of throwing exception to prevent app crash
      return {
        'input': {
          'proposed_execution_id': 'get_account_security_holdings_${DateTime.now().millisecondsSinceEpoch}',
          'account_iid': accountId,
        },
        'output': {
          'error': 'Critical GetInvestorSecurityHoldings error',
          'message': 'A critical error occurred during GetInvestorSecurityHoldings: ${e.toString()}',
          'details': stackTrace.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'critical-error',
        'success': false,
      };
    }
  }

  /// Real GetInvestorCashHoldings call to InvestorService.GetInvestorCashHoldings via native gRPC
  Future<Map<String, dynamic>> getInvestorCashHoldings({
    required String investorId,
    List<String>? currencyCodes,
    Duration? timeout,
  }) async {
    // Always test connectivity first to prevent crashes
    print('🔍 Testing server connectivity before GetInvestorCashHoldings...');
    final isServerReachable = await testServerConnectivity();

    if (!isServerReachable) {
      _isConnected = false; // Update connection state
      return {
        'input': {
          'proposed_execution_id': 'get_investor_cash_holdings_${DateTime.now().millisecondsSinceEpoch}',
          'investor_iid': investorId,
          'currency_codes': currencyCodes ?? [],
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
      print('💰 GetInvestorCashHoldings called - attempting to get cash holdings for investor $investorId');

      // Try to call the real server via native gRPC, with comprehensive crash protection
      final response = await GrpcHelper.getInvestorCashHoldings(
        investorId: investorId,
        currencyCodes: currencyCodes,
      ).timeout(
        const Duration(minutes: 5),
        onTimeout: () {
          print('⏰ GetInvestorCashHoldings request timed out');
          return {
            'input': {
              'proposed_execution_id': 'get_investor_cash_holdings_${DateTime.now().millisecondsSinceEpoch}',
              'investor_iid': investorId,
              'currency_codes': currencyCodes ?? [],
            },
            'output': {
              'error': 'Request timed out',
              'message': 'The investor cash holdings request timed out after 10 seconds. Check if server is running properly.',
            },
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
            'serverType': 'timeout',
            'success': false,
          };
        },
      ).catchError((error) {
        print('❌ GetInvestorCashHoldings error caught: $error');
        return {
          'input': {
            'proposed_execution_id': 'get_investor_cash_holdings_${DateTime.now().millisecondsSinceEpoch}',
            'investor_iid': investorId,
            'currency_codes': currencyCodes ?? [],
          },
          'output': {
            'error': 'GetInvestorCashHoldings execution failed',
            'message': 'Failed to execute GetInvestorCashHoldings: ${error.toString()}',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'execution-error',
          'success': false,
        };
      });

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
      print('❌ Critical error in GetInvestorCashHoldings: $e');
      print('❌ Stack trace: $stackTrace');

      // Test connectivity to update state
      final stillReachable = await testServerConnectivity();
      _isConnected = stillReachable;

      // Return error response instead of throwing exception to prevent app crash
      return {
        'input': {
          'proposed_execution_id': 'get_investor_cash_holdings_${DateTime.now().millisecondsSinceEpoch}',
          'investor_iid': investorId,
          'currency_codes': currencyCodes ?? [],
        },
        'output': {
          'error': 'Critical GetInvestorCashHoldings error',
          'message': 'A critical error occurred during GetInvestorCashHoldings: ${e.toString()}',
          'details': stackTrace.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'critical-error',
        'success': false,
      };
    }
  }

  /// Deposit cash to an investor
  Future<Map<String, dynamic>> depositCash({
    required String investorId,
    required String currencyCode,
    required String amount,
    Map<String, String>? auxData,
    Duration? timeout,
  }) async {
    // Always test connectivity first to prevent crashes
    print('🔍 Testing server connectivity before DepositCash...');
    final isServerReachable = await testServerConnectivity();

    if (!isServerReachable) {
      _isConnected = false; // Update connection state
      return {
        'input': {
          'proposed_execution_id': 'deposit_cash_${DateTime.now().millisecondsSinceEpoch}',
          'investor_iid': investorId,
          'currency_code': currencyCode,
          'amount': amount,
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
      print('💰 DepositCash called - attempting to deposit $amount $currencyCode to investor $investorId');

      // Try to call the real server via native gRPC, with comprehensive crash protection
      final response = await GrpcHelper.depositCash(
        investorId: investorId,
        currencyCode: currencyCode,
        amount: amount,
        auxData: auxData,
      ).timeout(
        const Duration(minutes: 5),
        onTimeout: () {
          print('⏰ DepositCash request timed out');
          return {
            'input': {
              'proposed_execution_id': 'deposit_cash_${DateTime.now().millisecondsSinceEpoch}',
              'investor_iid': investorId,
              'currency_code': currencyCode,
              'amount': amount,
            },
            'output': {
              'error': 'Request timed out',
              'message': 'The deposit cash request timed out after 15 seconds. Check if server is running properly.',
            },
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
            'serverType': 'timeout',
            'success': false,
          };
        },
      ).catchError((error) {
        print('❌ DepositCash error caught: $error');
        return {
          'input': {
            'proposed_execution_id': 'deposit_cash_${DateTime.now().millisecondsSinceEpoch}',
            'investor_iid': investorId,
            'currency_code': currencyCode,
            'amount': amount,
          },
          'output': {
            'error': 'DepositCash execution failed',
            'message': 'Failed to execute DepositCash: ${error.toString()}',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'execution-error',
          'success': false,
        };
      });

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
      print('❌ Critical error in DepositCash: $e');
      print('❌ Stack trace: $stackTrace');

      // Test connectivity to update state
      final stillReachable = await testServerConnectivity();
      _isConnected = stillReachable;

      // Return error response instead of throwing exception to prevent app crash
      return {
        'input': {
          'proposed_execution_id': 'deposit_cash_${DateTime.now().millisecondsSinceEpoch}',
          'investor_iid': investorId,
          'currency_code': currencyCode,
          'amount': amount,
        },
        'output': {
          'error': 'Critical DepositCash error',
          'message': 'A critical error occurred during DepositCash: ${e.toString()}',
          'details': stackTrace.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'critical-error',
        'success': false,
      };
    }
  }

  /// Withdraw cash from an investor
  Future<Map<String, dynamic>> withdrawCash({
    required String investorId,
    required String currencyCode,
    required String amount,
    Map<String, String>? auxData,
    Duration? timeout,
  }) async {
    // Always test connectivity first to prevent crashes
    print('🔍 Testing server connectivity before WithdrawCash...');
    final isServerReachable = await testServerConnectivity();

    if (!isServerReachable) {
      _isConnected = false; // Update connection state
      return {
        'input': {
          'proposed_execution_id': 'withdraw_cash_${DateTime.now().millisecondsSinceEpoch}',
          'investor_iid': investorId,
          'currency_code': currencyCode,
          'amount': amount,
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
      print('💰 WithdrawCash called - attempting to withdraw $amount $currencyCode from investor $investorId');

      // Try to call the real server via native gRPC, with comprehensive crash protection
      final response = await GrpcHelper.withdrawCash(
        investorId: investorId,
        currencyCode: currencyCode,
        amount: amount,
        auxData: auxData,
      ).timeout(
        const Duration(minutes: 5),
        onTimeout: () {
          print('⏰ WithdrawCash request timed out');
          return {
            'input': {
              'proposed_execution_id': 'withdraw_cash_${DateTime.now().millisecondsSinceEpoch}',
              'investor_iid': investorId,
              'currency_code': currencyCode,
              'amount': amount,
            },
            'output': {
              'error': 'Request timed out',
              'message': 'The withdraw cash request timed out after 15 seconds. Check if server is running properly.',
            },
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
            'serverType': 'timeout',
            'success': false,
          };
        },
      ).catchError((error) {
        print('❌ WithdrawCash error caught: $error');
        return {
          'input': {
            'proposed_execution_id': 'withdraw_cash_${DateTime.now().millisecondsSinceEpoch}',
            'investor_iid': investorId,
            'currency_code': currencyCode,
            'amount': amount,
          },
          'output': {
            'error': 'WithdrawCash execution failed',
            'message': 'Failed to execute WithdrawCash: ${error.toString()}',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'execution-error',
          'success': false,
        };
      });

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
      print('❌ Critical error in WithdrawCash: $e');
      print('❌ Stack trace: $stackTrace');

      // Test connectivity to update state
      final stillReachable = await testServerConnectivity();
      _isConnected = stillReachable;

      // Return error response instead of throwing exception to prevent app crash
      return {
        'input': {
          'proposed_execution_id': 'withdraw_cash_${DateTime.now().millisecondsSinceEpoch}',
          'investor_iid': investorId,
          'currency_code': currencyCode,
          'amount': amount,
        },
        'output': {
          'error': 'Critical WithdrawCash error',
          'message': 'A critical error occurred during WithdrawCash: ${e.toString()}',
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
        'services': 'AgentService, AccountService, MarketService, SecurityListingService',
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
        _host = AppConfig.grpcHost;
        _port = AppConfig.grpcPort;
        print('🔌 Disconnected from real gRPC server');
      } catch (e) {
        print('⚠️ Error during disconnect: $e');
        _isConnected = false;
        _host = AppConfig.grpcHost;
        _port = AppConfig.grpcPort;
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

  /// Real GetInvestorOrders call to PortfolioService.GetInvestorOrders via native gRPC
  Future<Map<String, dynamic>> getInvestorOrders({
    required String accountId,
    List<String>? venueIids,
    Map<String, dynamic>? pagination,
    String? fromTime,
    String? toTime,
    String? side,
    List<bool>? statusFilters,
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
        GrpcHelper.getInvestorOrders(
          investorId: accountId,
          refRequestId: generateRequestId(prefix: 'get_orders'),
          venueIids: venueIids,
          pagination: pagination,
          fromTime: fromTime,
          toTime: toTime,
          side: side,
          statusFilters: statusFilters,
        ),
      ]).catchError((error) {
        print('❌ GetInvestorOrders execution error: $error');
        return {
          'input': {'account_iid': accountId},
          'output': {
            'error': 'GetInvestorOrders execution error',
            'message': error.toString(),
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'execution-error',
          'success': false,
        };
      });

      print('📬 Real Server GetInvestorOrders Response: ${response['output']}');
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
      print('❌ Critical error in GetInvestorOrders: $e');
      print('❌ Stack trace: $stackTrace');
      
      // Test connectivity to update state
      final stillReachable = await testServerConnectivity();
      _isConnected = stillReachable;
      
      // Return error response instead of throwing exception to prevent app crash
      return {
        'input': {'account_iid': accountId},
        'output': {
          'error': 'Critical GetInvestorOrders error',
          'message': 'A critical error occurred during GetInvestorOrders: ${e.toString()}',
          'details': stackTrace.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'critical-error',
        'success': false,
      };
    }
  }

  /// Real GetInvestorTrades call to PortfolioService.GetInvestorTrades via native gRPC
  Future<Map<String, dynamic>> getInvestorTrades({
    required String accountId,
    List<String>? marketIids,
    Map<String, dynamic>? pagination,
    String? fromTime,
    String? toTime,
    String? side,
    List<String>? securityListingIids,
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
        GrpcHelper.getInvestorTrades(
          investorId: accountId,
          refRequestId: generateRequestId(prefix: 'get_trades'),
          marketIids: marketIids,
          pagination: pagination,
          fromTime: fromTime,
          toTime: toTime,
          side: side,
          securityListingIids: securityListingIids,
        ),
      ]).catchError((error) {
        print('❌ GetInvestorTrades execution error: $error');
        return {
          'input': {'account_iid': accountId},
          'output': {
            'error': 'GetInvestorTrades execution error',
            'message': error.toString(),
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'execution-error',
          'success': false,
        };
      });

      print('📬 Real Server GetInvestorTrades Response: ${response['output']}');
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
      print('❌ Critical error in GetInvestorTrades: $e');
      print('❌ Stack trace: $stackTrace');
      
      // Test connectivity to update state
      final stillReachable = await testServerConnectivity();
      _isConnected = stillReachable;
      
      // Return error response instead of throwing exception to prevent app crash
      return {
        'input': {'account_iid': accountId},
        'output': {
          'error': 'Critical GetInvestorTrades error',
          'message': 'A critical error occurred during GetInvestorTrades: ${e.toString()}',
          'details': stackTrace.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'critical-error',
        'success': false,
      };
    }
  }

  /// Real GetMarketList call to MarketService.GetMarketList via native gRPC
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
      return await GrpcHelper.getMarketList();
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

  /// Get security listings for a market using SecurityListingService
  Future<Map<String, dynamic>> getMarketSecurityList({
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
      print('📋 Getting security listings from real server (market: $marketId)...');

      // Fetch all security listings — the SecurityListingListRequest has no market filter field
      return await GrpcHelper.getSecurityListingList(
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
    } catch (e) {
      print('❌ Critical error in getMarketSecurityList: $e');
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
    // AgentService only supports Ping - getSupportedCurrencies not available
    print('⚠️ getSupportedCurrencies not available - using CashTokenService instead');
    return GrpcHelper.getCashTokenList(
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
  }

  /// Get market supported currencies using the real gRPC server
  Future<Map<String, dynamic>> getMarketSupportedCurrencies({
    required String marketId,
    int pageNumber = 0,
    int pageSize = 0,
  }) async {
    // AgentService only supports Ping - getMarketSupportedCurrencies not available
    // Using CashTokenService.GetCashTokenList as fallback
    print('⚠️ getMarketSupportedCurrencies not available - using CashTokenService instead');
    return GrpcHelper.getCashTokenList(
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
  }

  /// Get order fees using the real gRPC server
  /// NOTE: TradingService not available on current server
  Future<Map<String, dynamic>> getOrderFees({
    required String accountId,
    required String feePayerAccountId,
    required String securityId,
    required String orderType,
    required String side,
    required String quantity,
    String? price,
    String timeInForce = "0",
  }) async {
    print('⚠️ getOrderFees: TradingService not available on server');
    return {
      'input': {
        'account_iid': accountId,
        'fee_payer_account_iid': feePayerAccountId,
        'security_listing_iid': securityId,
        'order_type': orderType,
        'side': side,
        'quantity': quantity,
        'price': price,
        'time_in_force': timeInForce,
      },
      'output': {'error': 'TradingService not available on server'},
      'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
      'serverType': 'service-unavailable',
      'success': false,
    };
  }

  /// Create order using the real gRPC server via TradingService.CreateOrderAsync
  Future<Map<String, dynamic>> createOrder({
    required String accountId,
    required String feePayerAccountId,
    required String securityId,
    required String orderType,
    required String side,
    required String quantity,
    required String price,
    String timeInForce = "0",
    DateTime? expireTime,
    required String investorOrderId,
    String? currency,
    String? feeAmount,
    String? metadata,
    Map<String, String>? auxData,
  }) async {
    print('📝 createOrder called: side=$side, type=$orderType, qty=$quantity, price=$price, isConnected=$_isConnected');
    if (!_isConnected) {
      return {
        'input': {
          'account_iid': accountId,
          'security_listing_iid': securityId,
          'side': side,
        },
        'output': {'error': 'Not connected to server'},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'disconnected',
        'success': false,
      };
    }

    try {
      final result = await GrpcHelper.createOrderAsync(
        externalInvestorId: accountId,
        feePayerAccountIid: feePayerAccountId,
        securityListingIid: securityId,
        orderType: orderType,
        side: side,
        quantity: quantity,
        price: price,
        timeInForce: timeInForce,
        investorOrderId: investorOrderId,
        expireTime: expireTime,
        currency: currency,
        feeAmount: feeAmount,
        auxData: auxData,
      );
      print('📝 createOrder result: success=${result['success']}');
      return result;
    } catch (e) {
      print('❌ Critical error in createOrder: $e');
      return {
        'input': {
          'account_iid': accountId,
          'security_listing_iid': securityId,
          'side': side,
        },
        'output': {'error': 'Critical error: $e'},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'critical-error',
        'success': false,
      };
    }
  }

  /// Get execution reports for an order via TradingService.GetOrderExecutionReports
  Future<Map<String, dynamic>> getOrderExecutionReports({
    required String requestId,
    int pageNumber = 1,
    int pageSize = 20,
    String? symbolFilter,
    String? currencyFilter,
    String? execTypeFilter,
    String? fromDate,
    String? toDate,
    String? sortBy,
    String? sortDirection,
  }) async {
    print('📋 getOrderExecutionReports called: requestId=$requestId, isConnected=$_isConnected');
    if (!_isConnected) {
      return {
        'input': {'request_id': requestId},
        'output': {'error': 'Not connected to server'},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'disconnected',
        'success': false,
      };
    }

    try {
      final result = await GrpcHelper.getOrderExecutionReports(
        requestId: requestId,
        pageNumber: pageNumber,
        pageSize: pageSize,
        symbolFilter: symbolFilter,
        currencyFilter: currencyFilter,
        execTypeFilter: execTypeFilter,
        fromDate: fromDate,
        toDate: toDate,
        sortBy: sortBy,
        sortDirection: sortDirection,
      );
      print('📋 getOrderExecutionReports result: success=${result['success']}');
      return result;
    } catch (e) {
      print('❌ Critical error in getOrderExecutionReports: $e');
      return {
        'input': {'request_id': requestId},
        'output': {'error': 'Critical error: $e'},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'critical-error',
        'success': false,
      };
    }
  }

  /// Get execution reports via ReportingService.GetExecutionReports
  Future<Map<String, dynamic>> getExecutionReports({
    int pageNumber = 1,
    int pageSize = 20,
    String? requestId,
    String? symbol,
    String? currency,
    String? execType,
    String? side,
    String? venueIid,
    String? fromDate,
    String? toDate,
    String? sortBy,
    String? sortDirection,
    String? search,
  }) async {
    print('📋 getExecutionReports called: isConnected=$_isConnected');
    if (!_isConnected) {
      return {
        'input': {},
        'output': {'error': 'Not connected to server'},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'not-connected',
        'success': false,
      };
    }

    try {
      final result = await GrpcHelper.getExecutionReports(
        pageNumber: pageNumber,
        pageSize: pageSize,
        requestId: requestId,
        symbol: symbol,
        currency: currency,
        execType: execType,
        side: side,
        venueIid: venueIid,
        fromDate: fromDate,
        toDate: toDate,
        sortBy: sortBy,
        sortDirection: sortDirection,
        search: search,
      );
      print('📋 getExecutionReports result: success=${result['success']}');
      return result;
    } catch (e) {
      print('❌ Critical error in getExecutionReports: $e');
      return {
        'input': {},
        'output': {'error': 'Critical error: $e'},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'critical-error',
        'success': false,
      };
    }
  }

  /// Real GetVenueList call to VenueService.GetVenueList via native gRPC
  Future<Map<String, dynamic>> getVenueList({
    String? marketId,
    Duration? timeout,
  }) async {
    print('🏟️ getVenueList called: marketId=$marketId, isConnected=$_isConnected');
    if (!_isConnected) {
      print('🏟️ getVenueList: NOT CONNECTED - returning early');
      return {
        'input': {'market_id': marketId},
        'output': {'error': 'Not connected to server'},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'disconnected',
        'success': false,
      };
    }

    try {
      print('📋 Getting venue list from real server (marketId=$marketId)...');
      final result = await GrpcHelper.getVenueList(
        marketIid: marketId,
      );
      print('🏟️ getVenueList result: success=${result['success']}, output=${result['output']}');
      return result;
    } catch (e) {
      print('❌ Critical error in getVenueList: $e');
      return {
        'input': {'market_id': marketId},
        'output': {'error': 'Critical error: $e'},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'critical-error',
        'success': false,
      };
    }
  }

  /// Get security listing list using SecurityListingService
  Future<Map<String, dynamic>> getSecurityList({
    int pageNumber = 0,
    int pageSize = 0,
  }) async {
    try {
      print('📋 Getting security listing list...');

      return await GrpcHelper.getSecurityListingList(
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
    } catch (e) {
      print('❌ Critical error in getSecurityList: $e');
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

  /// Get account transactions using the real gRPC server
  Future<Map<String, dynamic>> getInvestorTransactions({
    required String accountId,
    Map<String, dynamic>? pagination,
    String? fromTime,
    String? toTime,
    List<String>? transactionTypes,
    List<String>? assetIds,
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
      final refRequestId = generateRequestId(prefix: 'get_transactions');

      // Build the request params that will actually be sent
      final requestParams = <String, dynamic>{
        'proposed_execution_id': refRequestId,
        'account_iid': accountId,
      };

      if (pagination != null) {
        requestParams['pagination'] = pagination;
      }
      if (fromTime != null) {
        requestParams['from_dt'] = fromTime;
      }
      if (toTime != null) {
        requestParams['to_dt'] = toTime;
      }
      if (transactionTypes != null && transactionTypes.isNotEmpty) {
        requestParams['transaction_types'] = transactionTypes;
      }
      if (assetIds != null && assetIds.isNotEmpty) {
        requestParams['asset_id_or_name_regexes'] = assetIds;
      }

      print('📤 GetInvestorTransactions Request: $requestParams');

      final response = await GrpcHelper.getInvestorTransactions(
        investorId: accountId,
        refRequestId: refRequestId,
        pagination: pagination,
        fromTime: fromTime,
        toTime: toTime,
        transactionTypes: transactionTypes,
        assetIds: assetIds,
      ).catchError((error) {
        print('❌ GetInvestorTransactions execution error: $error');
        return <String, dynamic>{
          'input': {'account_iid': accountId},
          'output': {
            'error': 'GetInvestorTransactions execution error',
            'message': error.toString(),
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'execution-error',
          'success': false,
        };
      });

      print('📬 Real Server GetInvestorTransactions Response: ${response['output']}');

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
      print('❌ Critical error in GetInvestorTransactions: $e');
      print('❌ Stack trace: $stackTrace');

      // Test connectivity to update state
      final stillReachable = await testServerConnectivity();
      _isConnected = stillReachable;

      // Return error response instead of throwing exception to prevent app crash
      return {
        'input': {'account_iid': accountId},
        'output': {
          'error': 'Critical GetInvestorTransactions error',
          'message': 'A critical error occurred during GetInvestorTransactions: ${e.toString()}',
          'details': stackTrace.toString(),
        },
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