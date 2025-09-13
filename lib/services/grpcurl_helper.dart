import 'dart:async';
import 'dart:convert';
import 'dart:io';

/// Helper class to make gRPC calls using system grpcurl command
/// This ensures we get real responses from your server
class GrpcurlHelper {
  
  /// Convert DateTime to Unix timestamp (seconds since epoch)
  static int _toUnixTimestamp(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch ~/ 1000;
  }
  static const String _host = 'localhost';
  static const int _port = 50051;
  
  // Prevent concurrent operations to avoid race conditions and crashes
  static bool _isPingInProgress = false;
  static bool _isAccountListInProgress = false;
  
  // Try common grpcurl installation paths - absolute paths first for sandbox compatibility
  static const List<String> _grpcurlPaths = [
    '/usr/local/bin/grpcurl', // Most common location - try first
    '/opt/homebrew/bin/grpcurl', // Apple Silicon
    '/usr/local/Cellar/grpcurl/1.9.3/bin/grpcurl', // Direct path for current version
    '/opt/homebrew/Cellar/grpcurl/1.9.3/bin/grpcurl', // Direct path for Apple Silicon
    'grpcurl', // PATH lookup - last resort for sandbox issues
  ];

  // Cache the found grpcurl path to avoid repeated lookups
  static String? _cachedGrpcurlPath;

  /// Test if the gRPC server is reachable using a simple socket connection
  /// This is safe in sandboxed apps and doesn't require external processes
  static Future<bool> _isServerReachable() async {
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

  /// Find the working grpcurl executable path (cached for performance) 
  /// Enhanced for macOS sandbox compatibility with smart server detection
  static Future<String?> _findGrpcurlPath() async {
    print('🔍 Searching for grpcurl in sandbox-compatible paths...');
    
    // Smart approach: First check if server is reachable
    // Only bypass grpcurl if server is NOT reachable (to prevent crashes)
    final serverReachable = await _isServerReachable();
    if (!serverReachable) {
      print('⚠️ Server not reachable - skipping grpcurl search to prevent crashes');
      return null;
    }
    
    print('✅ Server is reachable - proceeding with grpcurl search');
    
    for (final path in _grpcurlPaths) {
      try {
        print('🧪 Testing grpcurl at: $path');
        
        // First check if the file exists for absolute paths
        if (path.startsWith('/')) {
          try {
            final file = File(path);
            if (!await file.exists()) {
              print('📂 File does not exist at: $path');
              continue;
            }
          } catch (e) {
            print('📂 Cannot check file existence at $path: $e');
            continue;
          }
        }
        
        // Use a very short timeout to avoid hanging during initialization
        ProcessResult? result;
        try {
          result = await Process.run(
            path, 
            ['-plaintext', '$_host:$_port', 'list'],
          ).timeout(
            const Duration(milliseconds: 1000), // Slightly longer timeout for file system access
            onTimeout: () {
              print('⏰ Timeout testing $path');
              throw TimeoutException('Command timed out', const Duration(milliseconds: 1000));
            }
          );
        } on TimeoutException catch (e) {
          print('⏰ Timeout testing $path: ${e.message}');
          continue; // Skip to next path
        } catch (e) {
          // Catch ANY other exception that might occur in sandboxed environment
          print('❌ Process.run failed for $path in sandboxed app: ${e.runtimeType}: ${e.toString()}');
          continue; // Skip to next path
        }
        
        if (result.exitCode == 0) {
          print('✅ Found working grpcurl at: $path');
          _cachedGrpcurlPath = path;
          return path;
        } else {
          print('⚠️ grpcurl at $path returned exit code ${result.exitCode}: ${result.stderr}');
        }
      } catch (e) {
        // Try next path quickly, but log the specific error
        print('❌ Error testing grpcurl at $path: ${e.runtimeType}: ${e.toString()}');
        continue;
      }
    }
    print('❌ No working grpcurl found in any of the paths: $_grpcurlPaths');
    print('💡 This might be due to macOS app sandbox restrictions');
    return null;
  }

  /// Test if grpcurl is available and server is reachable
  static Future<bool> testConnection() async {
    try {
      // Find the working grpcurl path
      final grpcurlPath = await _findGrpcurlPath();
      if (grpcurlPath == null) {
        return false;
      }
      
      print('✅ grpcurl is available and server is reachable');
      return true;
    } catch (e) {
      print('⚠️ grpcurl not available or server not reachable: $e');
      return false;
    }
  }

  /// Make a real ping call using grpcurl
  static Future<Map<String, dynamic>> ping({
    required String stringToBePonged,
  }) async {
    // Prevent concurrent ping calls to avoid crashes
    if (_isPingInProgress) {
      print('⚠️ Ping already in progress, returning cached response');
      return {
        'input': {
          'ref_request_id': 'ping_${DateTime.now().millisecondsSinceEpoch}',
          'string_to_be_ponged': stringToBePonged,
        },
        'output': {
          'error': 'Operation already in progress',
          'message': 'A ping operation is already in progress. Please wait for it to complete.',
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'concurrent-blocked',
        'success': false,
      };
    }

    _isPingInProgress = true;
    try {
      return await _pingInternal(stringToBePonged: stringToBePonged);
    } catch (error, stack) {
      print('❌ CRITICAL: Unhandled exception in ping: $error');
      print('❌ CRITICAL: Stack: $stack');
      return {
        'input': {
          'ref_request_id': 'ping_${DateTime.now().millisecondsSinceEpoch}',
          'string_to_be_ponged': stringToBePonged,
        },
        'output': {
          'error': 'Critical unhandled exception in ping',
          'message': 'An unhandled exception occurred: ${error.toString()}',
          'details': stack.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'critical-error',
        'success': false,
      };
    } finally {
      _isPingInProgress = false;
    }
  }

  /// Internal ping implementation
  static Future<Map<String, dynamic>> _pingInternal({
    required String stringToBePonged,
  }) async {
    final requestId = 'ping_${DateTime.now().millisecondsSinceEpoch}';
    
    final request = {
      'ref_request_id': requestId,
      'string_to_be_ponged': stringToBePonged,
    };

    try {
      // Find the working grpcurl path with aggressive timeout to prevent hanging
      print('🔍 Looking for grpcurl executable...');
      final grpcurlPath = await _findGrpcurlPath().timeout(
        const Duration(milliseconds: 500),
        onTimeout: () {
          print('⏰ grpcurl path finder timed out');
          return null;
        },
      );
      
      if (grpcurlPath == null) {
        print('❌ No grpcurl path found');
        return {
          'input': request,
          'output': {
            'error': 'grpcurl command not available in standalone app',
            'message': 'The standalone macOS app cannot access grpcurl due to sandbox restrictions. This feature works when running with "flutter run --debug" but not in built apps. The server connection requires external process execution which is restricted in sandboxed macOS applications.',
            'suggestion': 'Use "echo "1" | flutter run --debug" to test this functionality',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'grpcurl-sandbox-restricted',
          'success': false,
        };
      }

      print('🔄 Making real grpcurl call to AgentService.Ping using $grpcurlPath');
      print('📨 Request: $request');

      ProcessResult? result;
      try {
        result = await Process.run(
          grpcurlPath, 
          ['-plaintext', '-d', jsonEncode(request), '$_host:$_port', 'qomet.agora.daemons.prtagent.v1.AgentService.Ping'],
        ).timeout(
          const Duration(seconds: 3),
          onTimeout: () {
            print('⏰ grpcurl Process.run timed out after 3 seconds');
            throw TimeoutException('grpcurl ping timed out', const Duration(seconds: 3));
          },
        );
      } on TimeoutException catch (e) {
        print('⏰ Ping timeout: ${e.message}');
        return {
          'input': request,
          'output': {
            'error': 'Request timed out',
            'message': 'The ping request timed out after 3 seconds. Check if server is running on localhost:50051.',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'timeout',
          'success': false,
        };
      } catch (e) {
        // Catch ANY other exception that might occur in sandboxed environment
        print('❌ Process.run failed for ping in sandboxed app: ${e.runtimeType}: ${e.toString()}');
        return {
          'input': request,
          'output': {
            'error': 'Process execution failed in sandboxed app',
            'message': 'The macOS app sandbox prevents external process execution. This is a security restriction.',
            'details': e.toString(),
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'sandbox-restricted',
          'success': false,
        };
      }

      if (result.exitCode == 0) {
        final responseJson = result.stdout.toString().trim();
        print('📬 Raw server response: $responseJson');
        
        try {
          final parsedResponse = jsonDecode(responseJson) as Map<String, dynamic>;
          return {
            'input': request,
            'output': parsedResponse,
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
            'serverType': 'simprtagent-real-grpcurl',
            'success': true,
          };
        } catch (e) {
          return {
            'input': request,
            'output': {
              'raw_response': responseJson,
              'parse_error': e.toString(),
            },
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
            'serverType': 'simprtagent-real-grpcurl',
            'success': false,
          };
        }
      } else {
        final error = result.stderr.toString();
        print('❌ grpcurl error: $error');
        
        return {
          'input': request,
          'output': {
            'error': error,
            'exit_code': result.exitCode,
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'simprtagent-real-grpcurl',
          'success': false,
        };
      }
    } catch (e) {
      print('❌ Failed to execute grpcurl: $e');
      return {
        'input': request,
        'output': {
          'error': 'grpcurl command execution failed in standalone app',
          'message': 'The standalone macOS app cannot execute grpcurl due to sandbox restrictions. This feature works when running with "flutter run --debug" but may fail in built apps.',
          'suggestion': 'Use "echo "1" | flutter run --debug" to test this functionality',
          'details': e.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'grpcurl-unavailable',
        'success': false,
      };
    }
  }

  /// Make a real NewAccount call using grpcurl
  static Future<Map<String, dynamic>> newAccount({
    required String externalAccountId,
    String? auxData,
  }) async {
    // Prevent concurrent newAccount calls to avoid crashes
    if (_isAccountListInProgress) {
      print('⚠️ NewAccount blocked - another account operation in progress');
      return {
        'input': {
          'ref_request_id': 'new_account_${DateTime.now().millisecondsSinceEpoch}',
          'external_account_id': externalAccountId,
        },
        'output': {
          'error': 'Operation already in progress',
          'message': 'Another account operation is already in progress. Please wait for it to complete.',
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'concurrent-blocked',
        'success': false,
      };
    }

    _isAccountListInProgress = true;
    try {
      return await _newAccountInternal(
        externalAccountId: externalAccountId,
        auxData: auxData,
      );
    } catch (error, stack) {
      print('❌ CRITICAL: Unhandled exception in newAccount: $error');
      print('❌ CRITICAL: Stack: $stack');
      return {
        'input': {
          'ref_request_id': 'new_account_${DateTime.now().millisecondsSinceEpoch}',
          'external_account_id': externalAccountId,
        },
        'output': {
          'error': 'Critical unhandled exception in newAccount',
          'message': 'An unhandled exception occurred: ${error.toString()}',
          'details': stack.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'critical-error',
        'success': false,
      };
    } finally {
      _isAccountListInProgress = false;
    }
  }

  /// Internal newAccount implementation
  static Future<Map<String, dynamic>> _newAccountInternal({
    required String externalAccountId,
    String? auxData,
  }) async {
    final requestId = 'new_account_${DateTime.now().millisecondsSinceEpoch}';
    
    final request = {
      'ref_request_id': requestId,
      'external_account_id': externalAccountId,
      'aux_data': auxData ?? 'Created from Flutter signup',
    };

    try {
      // Find the working grpcurl path with aggressive timeout to prevent hanging
      print('🔍 Looking for grpcurl executable for NewAccount...');
      final grpcurlPath = await _findGrpcurlPath().timeout(
        const Duration(milliseconds: 500),
        onTimeout: () {
          print('⏰ grpcurl path finder timed out for NewAccount');
          return null;
        },
      );
      
      if (grpcurlPath == null) {
        print('❌ No grpcurl path found for NewAccount');
        return {
          'input': request,
          'output': {
            'error': 'grpcurl command not available in standalone app',
            'message': 'The standalone macOS app cannot access grpcurl due to sandbox restrictions. This feature works when running with "flutter run --debug" but not in built apps. The server connection requires external process execution which is restricted in sandboxed macOS applications.',
            'suggestion': 'Use "echo "1" | flutter run --debug" to test this functionality',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'grpcurl-sandbox-restricted',
          'success': false,
        };
      }

      print('🔄 Making real grpcurl call to AccountService.NewAccount using $grpcurlPath');
      print('📨 Request: $request');

      ProcessResult? result;
      try {
        result = await Process.run(
          grpcurlPath,
          ['-plaintext', '-d', jsonEncode(request), '$_host:$_port', 'qomet.agora.daemons.prtagent.v1.AccountService.NewAccount'],
        ).timeout(
          const Duration(seconds: 10),
          onTimeout: () {
            print('⏰ grpcurl NewAccount Process.run timed out after 10 seconds');
            throw TimeoutException('grpcurl newAccount timed out', const Duration(seconds: 10));
          },
        );
      } on TimeoutException catch (e) {
        print('⏰ NewAccount timeout: ${e.message}');
        return {
          'input': request,
          'output': {
            'error': 'Request timed out',
            'message': 'The new account request timed out after 10 seconds. Check if server is running on localhost:50051.',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'timeout',
          'success': false,
        };
      } catch (e) {
        // Catch ANY other exception that might occur in sandboxed environment
        print('❌ Process.run failed for newAccount in sandboxed app: ${e.runtimeType}: ${e.toString()}');
        return {
          'input': request,
          'output': {
            'error': 'Process execution failed in sandboxed app',
            'message': 'The macOS app sandbox prevents external process execution. This is a security restriction.',
            'details': e.toString(),
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'sandbox-restricted',
          'success': false,
        };
      }

      if (result.exitCode == 0) {
        final responseJson = result.stdout.toString().trim();
        print('📬 Raw server response: $responseJson');
        
        try {
          final parsedResponse = jsonDecode(responseJson) as Map<String, dynamic>;
          return {
            'input': request,
            'output': parsedResponse,
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
            'serverType': 'simprtagent-real-grpcurl',
            'success': true,
          };
        } catch (e) {
          return {
            'input': request,
            'output': {
              'raw_response': responseJson,
              'parse_error': e.toString(),
            },
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
            'serverType': 'simprtagent-real-grpcurl',
            'success': false,
          };
        }
      } else {
        final error = result.stderr.toString();
        print('❌ grpcurl error: $error');
        
        return {
          'input': request,
          'output': {
            'error': error,
            'exit_code': result.exitCode,
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'simprtagent-real-grpcurl',
          'success': false,
        };
      }
    } catch (e) {
      print('❌ Failed to execute grpcurl: $e');
      return {
        'input': request,
        'output': {
          'error': 'grpcurl command execution failed in standalone app',
          'message': 'The standalone macOS app cannot execute grpcurl due to sandbox restrictions. This feature works when running with "flutter run --debug" but may fail in built apps.',
          'suggestion': 'Use "echo "1" | flutter run --debug" to test this functionality',
          'details': e.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'grpcurl-unavailable',
        'success': false,
      };
    }
  }

  /// Make a real GetAccountList call using grpcurl
  static Future<Map<String, dynamic>> getAccountList() async {
    // Prevent concurrent account list calls to avoid crashes
    if (_isAccountListInProgress) {
      print('⚠️ GetAccountList already in progress, returning cached response');
      return {
        'input': {
          'ref_request_id': 'get_account_list_${DateTime.now().millisecondsSinceEpoch}',
        },
        'output': {
          'error': 'Operation already in progress',
          'message': 'A getAccountList operation is already in progress. Please wait for it to complete.',
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'concurrent-blocked',
        'success': false,
      };
    }

    _isAccountListInProgress = true;
    try {
      return await _getAccountListInternal();
    } catch (error, stack) {
      print('❌ CRITICAL: Unhandled exception in getAccountList: $error');
      print('❌ CRITICAL: Stack: $stack');
      return {
        'input': {
          'ref_request_id': 'get_account_list_${DateTime.now().millisecondsSinceEpoch}',
        },
        'output': {
          'error': 'Critical unhandled exception in getAccountList',
          'message': 'An unhandled exception occurred: ${error.toString()}',
          'details': stack.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'critical-error',
        'success': false,
      };
    } finally {
      _isAccountListInProgress = false;
    }
  }

  /// Internal getAccountList implementation
  static Future<Map<String, dynamic>> _getAccountListInternal() async {
    final requestId = 'get_account_list_${DateTime.now().millisecondsSinceEpoch}';
    
    final request = {
      'ref_request_id': requestId,
    };

    try {
      // Find the working grpcurl path with aggressive timeout to prevent hanging
      print('🔍 Looking for grpcurl executable for GetAccountList...');
      final grpcurlPath = await _findGrpcurlPath().timeout(
        const Duration(milliseconds: 500),
        onTimeout: () {
          print('⏰ grpcurl path finder timed out for GetAccountList');
          return null;
        },
      );
      
      if (grpcurlPath == null) {
        print('❌ No grpcurl path found for GetAccountList');
        return {
          'input': request,
          'output': {
            'error': 'grpcurl command not available in standalone app',
            'message': 'The standalone macOS app cannot access grpcurl due to sandbox restrictions. This feature works when running with "flutter run --debug" but not in built apps. The server connection requires external process execution which is restricted in sandboxed macOS applications.',
            'suggestion': 'Use "echo "1" | flutter run --debug" to test this functionality',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'grpcurl-sandbox-restricted',
          'success': false,
        };
      }

      print('🔄 Making real grpcurl call to AccountService.GetAccountList using $grpcurlPath');
      print('📨 Request: $request');

      ProcessResult? result;
      try {
        result = await Process.run(
          grpcurlPath,
          ['-plaintext', '-d', jsonEncode(request), '$_host:$_port', 'qomet.agora.daemons.prtagent.v1.AccountService.GetAccountList'],
        ).timeout(
          const Duration(seconds: 3),
          onTimeout: () {
            print('⏰ grpcurl GetAccountList Process.run timed out after 3 seconds');
            throw TimeoutException('grpcurl getAccountList timed out', const Duration(seconds: 3));
          },
        );
      } on TimeoutException catch (e) {
        print('⏰ GetAccountList timeout: ${e.message}');
        return {
          'input': request,
          'output': {
            'error': 'Request timed out',
            'message': 'The account list request timed out after 3 seconds. Check if server is running on localhost:50051.',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'timeout',
          'success': false,
        };
      } catch (e) {
        // Catch ANY other exception that might occur in sandboxed environment
        print('❌ Process.run failed for getAccountList in sandboxed app: ${e.runtimeType}: ${e.toString()}');
        return {
          'input': request,
          'output': {
            'error': 'Process execution failed in sandboxed app',
            'message': 'The macOS app sandbox prevents external process execution. This is a security restriction.',
            'details': e.toString(),
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'sandbox-restricted',
          'success': false,
        };
      }

      if (result.exitCode == 0) {
        final responseJson = result.stdout.toString().trim();
        print('📬 Raw server response: $responseJson');
        
        try {
          final parsedResponse = jsonDecode(responseJson) as Map<String, dynamic>;
          return {
            'input': request,
            'output': parsedResponse,
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
            'serverType': 'simprtagent-real-grpcurl',
            'success': true,
          };
        } catch (e) {
          return {
            'input': request,
            'output': {
              'raw_response': responseJson,
              'parse_error': e.toString(),
            },
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
            'serverType': 'simprtagent-real-grpcurl',
            'success': false,
          };
        }
      } else {
        final error = result.stderr.toString();
        print('❌ grpcurl error: $error');
        
        return {
          'input': request,
          'output': {
            'error': error,
            'exit_code': result.exitCode,
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'simprtagent-real-grpcurl',
          'success': false,
        };
      }
    } catch (e) {
      print('❌ Failed to execute grpcurl: $e');
      return {
        'input': request,
        'output': {
          'error': 'grpcurl command execution failed in standalone app',
          'message': 'The standalone macOS app cannot execute grpcurl due to sandbox restrictions. This feature works when running with "flutter run --debug" but may fail in built apps.',
          'suggestion': 'Use "echo "1" | flutter run --debug" to test this functionality',
          'details': e.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'grpcurl-unavailable',
        'success': false,
      };
    }
  }

  /// Make a real GetAccountMarketPortfolio call using grpcurl
  static Future<Map<String, dynamic>> getAccountMarketPortfolio({
    required String accountId,
    String? marketId,
    List<String>? assetIds,
  }) async {
    final requestId = 'get_account_market_portfolio_${DateTime.now().millisecondsSinceEpoch}';
    
    final request = {
      'ref_request_id': requestId,
      'account_id': accountId,
      'market_id': marketId ?? '',
      'asset_ids': assetIds ?? ['ETH', 'OXC', 'XRP'],
    };

    try {
      // Find the working grpcurl path with aggressive timeout to prevent hanging
      print('🔍 Looking for grpcurl executable for GetAccountMarketPortfolio...');
      final grpcurlPath = await _findGrpcurlPath().timeout(
        const Duration(milliseconds: 500),
        onTimeout: () {
          print('⏰ grpcurl path finder timed out for GetAccountMarketPortfolio');
          return null;
        },
      );
      
      if (grpcurlPath == null) {
        print('❌ No grpcurl path found for GetAccountMarketPortfolio');
        return {
          'input': request,
          'output': {
            'error': 'grpcurl command not available in standalone app',
            'message': 'The standalone macOS app cannot access grpcurl due to sandbox restrictions. This feature works when running with "flutter run --debug" but not in built apps. The server connection requires external process execution which is restricted in sandboxed macOS applications.',
            'suggestion': 'Use "echo "1" | flutter run --debug" to test this functionality',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'grpcurl-sandbox-restricted',
          'success': false,
        };
      }

      print('🔄 Making real grpcurl call to AccountService.GetAccountMarketPortfolio using $grpcurlPath');
      print('📨 Request: $request');

      ProcessResult? result;
      try {
        result = await Process.run(
          grpcurlPath,
          ['-plaintext', '-d', jsonEncode(request), '$_host:$_port', 'qomet.agora.daemons.prtagent.v1.AccountService.GetAccountMarketPortfolio'],
        ).timeout(
          const Duration(seconds: 5),
          onTimeout: () {
            print('⏰ grpcurl GetAccountMarketPortfolio Process.run timed out after 5 seconds');
            throw TimeoutException('grpcurl getAccountMarketPortfolio timed out', const Duration(seconds: 5));
          },
        );
      } on TimeoutException catch (e) {
        print('⏰ GetAccountMarketPortfolio timeout: ${e.message}');
        return {
          'input': request,
          'output': {
            'error': 'Request timed out',
            'message': 'The account market portfolio request timed out after 5 seconds. Check if server is running on localhost:50051.',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'timeout',
          'success': false,
        };
      } catch (e) {
        // Catch ANY other exception that might occur in sandboxed environment
        print('❌ Process.run failed for getAccountMarketPortfolio in sandboxed app: ${e.runtimeType}: ${e.toString()}');
        return {
          'input': request,
          'output': {
            'error': 'Process execution failed in sandboxed app',
            'message': 'The macOS app sandbox prevents external process execution. This is a security restriction.',
            'details': e.toString(),
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'sandbox-restricted',
          'success': false,
        };
      }

      if (result.exitCode == 0) {
        final responseJson = result.stdout.toString().trim();
        print('📬 Raw server response: $responseJson');
        
        try {
          final parsedResponse = jsonDecode(responseJson) as Map<String, dynamic>;
          return {
            'input': request,
            'output': parsedResponse,
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
            'serverType': 'simprtagent-real-grpcurl',
            'success': true,
          };
        } catch (e) {
          return {
            'input': request,
            'output': {
              'raw_response': responseJson,
              'parse_error': e.toString(),
            },
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
            'serverType': 'simprtagent-real-grpcurl',
            'success': false,
          };
        }
      } else {
        final error = result.stderr.toString();
        print('❌ grpcurl error: $error');
        
        return {
          'input': request,
          'output': {
            'error': error,
            'exit_code': result.exitCode,
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'simprtagent-real-grpcurl',
          'success': false,
        };
      }
    } catch (e) {
      print('❌ Failed to execute grpcurl: $e');
      return {
        'input': request,
        'output': {
          'error': 'grpcurl command execution failed in standalone app',
          'message': 'The standalone macOS app cannot execute grpcurl due to sandbox restrictions. This feature works when running with "flutter run --debug" but may fail in built apps.',
          'suggestion': 'Use "echo "1" | flutter run --debug" to test this functionality',
          'details': e.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'grpcurl-unavailable',
        'success': false,
      };
    }
  }

  /// Make a real GetAccountCashHoldings call using grpcurl
  static Future<Map<String, dynamic>> getAccountCashHoldings({
    required String accountId,
    List<String>? cashAssetIds,
  }) async {
    final requestId = 'get_account_cash_holdings_${DateTime.now().millisecondsSinceEpoch}';
    
    final request = {
      'ref_request_id': requestId,
      'account_id': accountId,
      'cash_asset_ids': cashAssetIds ?? ['USD'],
    };

    try {
      // Find the working grpcurl path with aggressive timeout to prevent hanging
      print('🔍 Looking for grpcurl executable for GetAccountCashHoldings...');
      final grpcurlPath = await _findGrpcurlPath().timeout(
        const Duration(milliseconds: 500),
        onTimeout: () {
          print('⏰ grpcurl path finder timed out for GetAccountCashHoldings');
          return null;
        },
      );
      
      if (grpcurlPath == null) {
        print('❌ No grpcurl path found for GetAccountCashHoldings');
        return {
          'input': request,
          'output': {
            'error': 'grpcurl command not available in standalone app',
            'message': 'The standalone macOS app cannot access grpcurl due to sandbox restrictions. This feature works when running with "flutter run --debug" but not in built apps. The server connection requires external process execution which is restricted in sandboxed macOS applications.',
            'suggestion': 'Use "echo "1" | flutter run --debug" to test this functionality',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'grpcurl-sandbox-restricted',
          'success': false,
        };
      }

      print('🔄 Making real grpcurl call to AccountService.GetAccountCashHoldings using $grpcurlPath');
      print('📨 Request: $request');

      ProcessResult? result;
      try {
        result = await Process.run(
          grpcurlPath,
          ['-plaintext', '-d', jsonEncode(request), '$_host:$_port', 'qomet.agora.daemons.prtagent.v1.AccountService.GetAccountCashHoldings'],
        ).timeout(
          const Duration(seconds: 5),
          onTimeout: () {
            print('⏰ grpcurl GetAccountCashHoldings Process.run timed out after 5 seconds');
            throw TimeoutException('grpcurl getAccountCashHoldings timed out', const Duration(seconds: 5));
          },
        );
      } on TimeoutException catch (e) {
        print('⏰ GetAccountCashHoldings timeout: ${e.message}');
        return {
          'input': request,
          'output': {
            'error': 'Request timed out',
            'message': 'The account cash holdings request timed out after 5 seconds. Check if server is running on localhost:50051.',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'timeout',
          'success': false,
        };
      } catch (e) {
        // Catch ANY other exception that might occur in sandboxed environment
        print('❌ Process.run failed for getAccountCashHoldings in sandboxed app: ${e.runtimeType}: ${e.toString()}');
        return {
          'input': request,
          'output': {
            'error': 'Process execution failed in sandboxed app',
            'message': 'The macOS app sandbox prevents external process execution. This is a security restriction.',
            'details': e.toString(),
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'sandbox-restricted',
          'success': false,
        };
      }

      if (result.exitCode == 0) {
        final responseJson = result.stdout.toString().trim();
        print('📬 Raw server response: $responseJson');
        
        try {
          final parsedResponse = jsonDecode(responseJson) as Map<String, dynamic>;
          return {
            'input': request,
            'output': parsedResponse,
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
            'serverType': 'simprtagent-real-grpcurl',
            'success': true,
          };
        } catch (e) {
          return {
            'input': request,
            'output': {
              'raw_response': responseJson,
              'parse_error': e.toString(),
            },
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
            'serverType': 'simprtagent-real-grpcurl',
            'success': false,
          };
        }
      } else {
        final error = result.stderr.toString();
        print('❌ grpcurl error: $error');
        
        return {
          'input': request,
          'output': {
            'error': error,
            'exit_code': result.exitCode,
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'simprtagent-real-grpcurl',
          'success': false,
        };
      }
    } catch (e) {
      print('❌ Failed to execute grpcurl: $e');
      return {
        'input': request,
        'output': {
          'error': 'grpcurl command execution failed in standalone app',
          'message': 'The standalone macOS app cannot execute grpcurl due to sandbox restrictions. This feature works when running with "flutter run --debug" but may fail in built apps.',
          'suggestion': 'Use "echo "1" | flutter run --debug" to test this functionality',
          'details': e.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'grpcurl-unavailable',
        'success': false,
      };
    }
  }

  /// List available services using grpcurl
  static Future<List<String>> listServices() async {
    try {
      // Find the working grpcurl path
      final grpcurlPath = await _findGrpcurlPath();
      if (grpcurlPath == null) {
        return [];
      }

      ProcessResult result;
      try {
        result = await Process.run(
          grpcurlPath,
          ['-plaintext', '$_host:$_port', 'list'],
        ).timeout(const Duration(seconds: 5));
      } catch (e) {
        print('❌ Process.run failed for listServices in sandboxed app: ${e.runtimeType}: ${e.toString()}');
        return [];
      }

      if (result.exitCode == 0) {
        final services = result.stdout.toString()
            .split('\n')
            .where((line) => line.trim().isNotEmpty)
            .toList();
        
        print('📋 Available services: $services');
        return services;
      } else {
        print('❌ Failed to list services: ${result.stderr}');
        return [];
      }
    } catch (e) {
      print('❌ Failed to list services: $e');
      return [];
    }
  }

  /// Get account orders using GetAccountOrders gRPC method
  static Future<Map<String, dynamic>> getAccountOrders({
    required String accountId,
    String refRequestId = 'flutter-get-orders',
    List<String>? marketIdOrNameRegexes,
    Map<String, dynamic>? pagination,
    String? fromTime,
    String? toTime,
    String? side, // "BUY" or "SELL"
    List<bool>? statusFilters, // [is_filled, is_cancelled, is_expired]
    List<String>? instrumentIdOrSymbolRegexes,
  }) async {
    try {
      print('📋 Getting orders for account: $accountId');
      
      // Find the working grpcurl path
      final grpcurlPath = await _findGrpcurlPath();
      if (grpcurlPath == null) {
        return {
          'success': false,
          'output': {'error': 'grpcurl not available'},
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'grpcurl_unavailable',
        };
      }

      // Prepare request payload with all optional parameters
      final requestPayload = <String, dynamic>{
        'ref_request_id': refRequestId,
        'account_id': accountId,
      };

      // Add optional parameters if provided
      if (marketIdOrNameRegexes != null && marketIdOrNameRegexes.isNotEmpty) {
        requestPayload['market_id_or_name_regexes'] = marketIdOrNameRegexes;
      }
      
      if (pagination != null) {
        requestPayload['pagination'] = pagination;
      }
      
      if (fromTime != null) {
        // Check if fromTime is a JSON string containing a timestamp object
        try {
          final parsedFromTime = jsonDecode(fromTime);
          if (parsedFromTime is Map<String, dynamic> && parsedFromTime.containsKey('ts')) {
            requestPayload['from_time'] = parsedFromTime;
          } else {
            requestPayload['from_time'] = fromTime;
          }
        } catch (e) {
          // If not valid JSON, treat as regular string
          requestPayload['from_time'] = fromTime;
        }
      }
      
      if (toTime != null) {
        // Check if toTime is a JSON string containing a timestamp object
        try {
          final parsedToTime = jsonDecode(toTime);
          if (parsedToTime is Map<String, dynamic> && parsedToTime.containsKey('ts')) {
            requestPayload['to_time'] = parsedToTime;
          } else {
            requestPayload['to_time'] = toTime;
          }
        } catch (e) {
          // If not valid JSON, treat as regular string
          requestPayload['to_time'] = toTime;
        }
      }
      
      if (side != null) {
        requestPayload['side'] = side;
      }
      
      if (statusFilters != null) {
        requestPayload['status_filters'] = statusFilters;
      }
      
      if (instrumentIdOrSymbolRegexes != null && instrumentIdOrSymbolRegexes.isNotEmpty) {
        requestPayload['instrument_id_or_symbol_regexes'] = instrumentIdOrSymbolRegexes;
      }

      final jsonPayload = jsonEncode(requestPayload);
      
      ProcessResult result;
      try {
        result = await Process.run(
          grpcurlPath,
          [
            '-plaintext',
            '-d', jsonPayload,
            '$_host:$_port',
            'qomet.agora.daemons.prtagent.v1.AccountService/GetAccountOrders'
          ],
        ).timeout(const Duration(seconds: 10));
      } catch (e) {
        print('❌ Process.run failed for GetAccountOrders: ${e.runtimeType}: ${e.toString()}');
        return {
          'success': false,
          'output': {'error': 'Process execution failed', 'details': e.toString()},
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'process_error',
        };
      }

      final responseData = {
        'input': requestPayload,
        'output': {},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'real_grpc',
        'success': false,
      };

      if (result.exitCode == 0) {
        try {
          final outputData = jsonDecode(result.stdout.toString());
          responseData['output'] = outputData;
          responseData['success'] = true;
          print('✅ GetAccountOrders successful for account: $accountId');
        } catch (e) {
          responseData['output'] = {
            'error': 'Invalid JSON response',
            'raw_output': result.stdout.toString(),
            'details': e.toString(),
          };
          print('❌ GetAccountOrders JSON parse error: $e');
        }
      } else {
        responseData['output'] = {
          'error': 'gRPC call failed',
          'stderr': result.stderr.toString(),
          'stdout': result.stdout.toString(),
          'exit_code': result.exitCode,
        };
        print('❌ GetAccountOrders failed: ${result.stderr}');
      }

      return responseData;
    } catch (e) {
      print('❌ GetAccountOrders exception: $e');
      return {
        'success': false,
        'output': {'error': 'Exception occurred', 'details': e.toString()},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'exception',
      };
    }
  }

  /// Get account trades using GetAccountTrades gRPC method
  static Future<Map<String, dynamic>> getAccountTrades({
    required String accountId,
    String refRequestId = 'flutter-get-trades',
    List<String>? marketIdOrNameRegexes,
    Map<String, dynamic>? pagination,
    String? fromTime,
    String? toTime,
    String? side,
    List<String>? instrumentIdOrSymbolRegexes,
  }) async {
    try {
      print('📋 Getting trades for account: $accountId');
      
      // Find the working grpcurl path
      final grpcurlPath = await _findGrpcurlPath();
      if (grpcurlPath == null) {
        return {
          'success': false,
          'output': {'error': 'grpcurl not available'},
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'grpcurl_unavailable',
        };
      }

      // Prepare request payload with all optional parameters
      final requestPayload = <String, dynamic>{
        'ref_request_id': refRequestId,
        'account_id': accountId,
      };

      // Add optional parameters if provided
      if (marketIdOrNameRegexes != null && marketIdOrNameRegexes.isNotEmpty) {
        requestPayload['market_id_or_name_regexes'] = marketIdOrNameRegexes;
      }
      
      if (pagination != null) {
        requestPayload['pagination'] = pagination;
      }
      
      if (fromTime != null) {
        // Check if fromTime is a JSON string containing a timestamp object
        try {
          final parsedFromTime = jsonDecode(fromTime);
          if (parsedFromTime is Map<String, dynamic> && parsedFromTime.containsKey('ts')) {
            requestPayload['from_time'] = parsedFromTime;
          } else {
            requestPayload['from_time'] = fromTime;
          }
        } catch (e) {
          // If not valid JSON, treat as regular string
          requestPayload['from_time'] = fromTime;
        }
      }
      
      if (toTime != null) {
        // Check if toTime is a JSON string containing a timestamp object
        try {
          final parsedToTime = jsonDecode(toTime);
          if (parsedToTime is Map<String, dynamic> && parsedToTime.containsKey('ts')) {
            requestPayload['to_time'] = parsedToTime;
          } else {
            requestPayload['to_time'] = toTime;
          }
        } catch (e) {
          // If not valid JSON, treat as regular string
          requestPayload['to_time'] = toTime;
        }
      }
      
      if (side != null) {
        requestPayload['side'] = side;
      }
      
      if (instrumentIdOrSymbolRegexes != null && instrumentIdOrSymbolRegexes.isNotEmpty) {
        requestPayload['instrument_id_or_symbol_regexes'] = instrumentIdOrSymbolRegexes;
      }

      final jsonPayload = jsonEncode(requestPayload);
      
      ProcessResult result;
      try {
        result = await Process.run(
          grpcurlPath,
          [
            '-plaintext',
            '-d', jsonPayload,
            '$_host:$_port',
            'qomet.agora.daemons.prtagent.v1.AccountService/GetAccountTrades'
          ],
        ).timeout(const Duration(seconds: 10));
      } catch (e) {
        print('❌ Process.run failed for GetAccountTrades: ${e.runtimeType}: ${e.toString()}');
        return {
          'success': false,
          'output': {'error': 'Process execution failed', 'details': e.toString()},
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'process_error',
        };
      }

      final responseData = {
        'input': requestPayload,
        'output': {},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'real_grpc',
        'success': false,
      };

      if (result.exitCode == 0) {
        try {
          final outputData = jsonDecode(result.stdout.toString());
          responseData['output'] = outputData;
          responseData['success'] = true;
          print('✅ GetAccountTrades successful for account: $accountId');
        } catch (e) {
          responseData['output'] = {
            'error': 'Invalid JSON response',
            'raw_output': result.stdout.toString(),
            'details': e.toString(),
          };
          print('❌ GetAccountTrades JSON parse error: $e');
        }
      } else {
        responseData['output'] = {
          'error': 'gRPC call failed',
          'stderr': result.stderr.toString(),
          'stdout': result.stdout.toString(),
          'exit_code': result.exitCode,
        };
        print('❌ GetAccountTrades failed: ${result.stderr}');
      }

      return responseData;
    } catch (e) {
      print('❌ GetAccountTrades exception: $e');
      return {
        'success': false,
        'output': {'error': 'Exception occurred', 'details': e.toString()},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'exception',
      };
    }
  }

  /// Get Market List using grpcurl
  static Future<Map<String, dynamic>> getMarketList() async {
    final responseData = <String, dynamic>{
      'success': false,
      'output': {},
      'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
      'serverType': 'real_grpc',
    };

    try {
      print('📋 Getting market list from real server...');

      // Check server reachability first
      if (!await _isServerReachable()) {
        responseData['output'] = {'error': 'Server not reachable'};
        responseData['serverType'] = 'unreachable';
        return responseData;
      }

      final grpcurlPath = await _findGrpcurlPath();
      if (grpcurlPath == null) {
        responseData['output'] = {'error': 'grpcurl not found'};
        responseData['serverType'] = 'grpcurl-not-found';
        return responseData;
      }

      final inputParams = {
        'ref_request_id': 'get_markets_${DateTime.now().millisecondsSinceEpoch}',
      };

      final result = await Process.run(
        grpcurlPath,
        [
          '-plaintext',
          '-d', jsonEncode(inputParams),
          '$_host:$_port',
          'qomet.agora.daemons.prtagent.v1.MarketService/GetMarketList'
        ],
        environment: {'PATH': '/usr/local/bin:/opt/homebrew/bin:${Platform.environment['PATH']}'},
      ).timeout(const Duration(seconds: 10));

      if (result.exitCode == 0) {
        final responseJson = jsonDecode(result.stdout);
        responseData['success'] = true;
        responseData['output'] = responseJson;
        print('✅ GetMarketList successful');
      } else {
        responseData['output'] = {
          'error': 'gRPC call failed',
          'stderr': result.stderr.toString(),
          'stdout': result.stdout.toString(),
          'exit_code': result.exitCode,
        };
        print('❌ GetMarketList failed: ${result.stderr}');
      }

      return responseData;
    } catch (e) {
      print('❌ GetMarketList exception: $e');
      return {
        'success': false,
        'output': {'error': 'Exception occurred', 'details': e.toString()},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'exception',
      };
    }
  }

  /// Get Market Instrument List using grpcurl
  static Future<Map<String, dynamic>> getMarketInstrumentList({
    required String marketId,
  }) async {
    final responseData = <String, dynamic>{
      'success': false,
      'output': {},
      'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
      'serverType': 'real_grpc',
    };

    try {
      print('📋 Getting market instrument list for market: $marketId from real server...');

      // Check server reachability first
      if (!await _isServerReachable()) {
        responseData['output'] = {'error': 'Server not reachable'};
        responseData['serverType'] = 'unreachable';
        return responseData;
      }

      final grpcurlPath = await _findGrpcurlPath();
      if (grpcurlPath == null) {
        responseData['output'] = {'error': 'grpcurl not found'};
        responseData['serverType'] = 'grpcurl-not-found';
        return responseData;
      }

      final inputParams = {
        'ref_request_id': 'get_market_instrument_list_${DateTime.now().millisecondsSinceEpoch}',
        'market_id': marketId,
      };

      final result = await Process.run(
        grpcurlPath,
        [
          '-plaintext',
          '-d', jsonEncode(inputParams),
          '$_host:$_port',
          'qomet.agora.daemons.prtagent.v1.MarketService/GetMarketInstrumentList'
        ],
        environment: {'PATH': '/usr/local/bin:/opt/homebrew/bin:${Platform.environment['PATH']}'},
      ).timeout(const Duration(seconds: 10));

      if (result.exitCode == 0) {
        final responseJson = jsonDecode(result.stdout);
        responseData['success'] = true;
        responseData['output'] = responseJson;
        print('✅ GetMarketInstrumentList successful');
      } else {
        responseData['output'] = {
          'error': 'gRPC call failed',
          'stderr': result.stderr.toString(),
          'stdout': result.stdout.toString(),
          'exit_code': result.exitCode,
        };
        print('❌ GetMarketInstrumentList failed: ${result.stderr}');
      }

      return responseData;
    } catch (e) {
      print('❌ GetMarketInstrumentList exception: $e');
      return {
        'success': false,
        'output': {'error': 'Exception occurred', 'details': e.toString()},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'exception',
      };
    }
  }

  /// Make a real GetSupportedCurrencies call using grpcurl
  static Future<Map<String, dynamic>> getSupportedCurrencies({
    int pageNumber = 1,
    int pageSize = 100,
  }) async {
    Map<String, dynamic> responseData = {
      'success': false,
      'output': {},
      'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
      'serverType': 'simprtagent-real-grpcurl',
    };

    try {
      final grpcurlPath = await _findGrpcurlPath();
      if (grpcurlPath == null) {
        responseData['output'] = {'error': 'grpcurl not found'};
        responseData['serverType'] = 'grpcurl-not-found';
        return responseData;
      }

      final inputParams = {
        'ref_request_id': 'get_supported_currencies_${DateTime.now().millisecondsSinceEpoch}',
        'pagination': {
          'page_nr': pageNumber,
          'page_size': pageSize,
        },
      };

      print('📨 GetSupportedCurrencies Request: $inputParams');

      final result = await Process.run(
        grpcurlPath,
        [
          '-plaintext',
          '-d', jsonEncode(inputParams),
          '$_host:$_port',
          'qomet.agora.daemons.prtagent.v1.AgentService/GetSupportedCurrencies'
        ],
        environment: {'PATH': '/usr/local/bin:/opt/homebrew/bin:${Platform.environment['PATH']}'},
      ).timeout(const Duration(seconds: 10));

      if (result.exitCode == 0) {
        final responseJson = jsonDecode(result.stdout);
        responseData['success'] = true;
        responseData['output'] = responseJson;
        print('✅ GetSupportedCurrencies successful');
        print('📬 GetSupportedCurrencies Response: $responseJson');
      } else {
        responseData['output'] = {
          'error': 'gRPC call failed',
          'stderr': result.stderr.toString(),
          'stdout': result.stdout.toString(),
          'exit_code': result.exitCode,
        };
        print('❌ GetSupportedCurrencies failed: ${result.stderr}');
      }

      return responseData;
    } catch (e) {
      print('❌ GetSupportedCurrencies exception: $e');
      return {
        'success': false,
        'output': {'error': 'Exception occurred', 'details': e.toString()},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'exception',
      };
    }
  }
}