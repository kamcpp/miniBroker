import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../config/app_config.dart';

/// Helper class to make gRPC calls using system grpcurl command
/// This ensures we get real responses from your server
class GrpcurlHelper {

  /// Convert DateTime to Unix timestamp (seconds since epoch)
  static int _toUnixTimestamp(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch ~/ 1000;
  }
  static String get _host => AppConfig.grpcHost;
  static int get _port => AppConfig.grpcPort;
  
  // Prevent concurrent operations to avoid race conditions and crashes
  static bool _isPingInProgress = false;
  static bool _isAccountListInProgress = false;
  static bool _isFindingGrpcurlPath = false;

  // ============================================================================
  // Detailed Logging Helpers
  // ============================================================================

  /// Log a grpcurl request with headers and body
  static void _logRequest({
    required String method,
    required String endpoint,
    required List<String> args,
    required String body,
    Map<String, String>? headers,
  }) {
    final buffer = StringBuffer();
    buffer.writeln('');
    buffer.writeln('╔══════════════════════════════════════════════════════════════');
    buffer.writeln('║ 📤 GRPCURL REQUEST');
    buffer.writeln('╠══════════════════════════════════════════════════════════════');
    buffer.writeln('║ Method:   $method');
    buffer.writeln('║ Endpoint: $endpoint');
    buffer.writeln('║ Target:   $_host:$_port');
    buffer.writeln('╠──────────────────────────────────────────────────────────────');
    buffer.writeln('║ Headers:');
    if (headers != null && headers.isNotEmpty) {
      for (final entry in headers.entries) {
        // Mask API key value for security
        final value = entry.key.toLowerCase().contains('api-key')
            ? '${entry.value.substring(0, 4)}...${entry.value.substring(entry.value.length - 4)}'
            : entry.value;
        buffer.writeln('║   ${entry.key}: $value');
      }
    } else {
      buffer.writeln('║   (none)');
    }
    buffer.writeln('╠──────────────────────────────────────────────────────────────');
    buffer.writeln('║ Body (JSON):');
    try {
      // Pretty print JSON body
      final decoded = jsonDecode(body);
      final prettyJson = const JsonEncoder.withIndent('  ').convert(decoded);
      for (final line in prettyJson.split('\n')) {
        buffer.writeln('║   $line');
      }
    } catch (_) {
      buffer.writeln('║   $body');
    }
    buffer.writeln('╠──────────────────────────────────────────────────────────────');
    buffer.writeln('║ Full command:');
    buffer.writeln('║   grpcurl ${args.map((a) => a.contains(' ') ? '"$a"' : a).join(' ')}');
    buffer.writeln('╚══════════════════════════════════════════════════════════════');
    print(buffer.toString());
  }

  /// Log a grpcurl response with status and body
  static void _logResponse({
    required String method,
    required int exitCode,
    required String stdout,
    required String stderr,
    required Duration duration,
  }) {
    final buffer = StringBuffer();
    final isSuccess = exitCode == 0;
    final statusIcon = isSuccess ? '✅' : '❌';
    final statusText = isSuccess ? 'SUCCESS' : 'ERROR';

    buffer.writeln('');
    buffer.writeln('╔══════════════════════════════════════════════════════════════');
    buffer.writeln('║ 📥 GRPCURL RESPONSE - $statusIcon $statusText');
    buffer.writeln('╠══════════════════════════════════════════════════════════════');
    buffer.writeln('║ Method:    $method');
    buffer.writeln('║ Exit Code: $exitCode');
    buffer.writeln('║ Duration:  ${duration.inMilliseconds}ms');
    buffer.writeln('╠──────────────────────────────────────────────────────────────');

    if (isSuccess && stdout.isNotEmpty) {
      buffer.writeln('║ Response Body:');
      try {
        // Pretty print JSON response
        final decoded = jsonDecode(stdout.trim());
        final prettyJson = const JsonEncoder.withIndent('  ').convert(decoded);
        for (final line in prettyJson.split('\n')) {
          buffer.writeln('║   $line');
        }
      } catch (_) {
        // Not JSON, print as-is
        for (final line in stdout.trim().split('\n')) {
          buffer.writeln('║   $line');
        }
      }
    } else if (!isSuccess && stderr.isNotEmpty) {
      buffer.writeln('║ Error Output:');
      for (final line in stderr.trim().split('\n')) {
        buffer.writeln('║   $line');
      }
    } else {
      buffer.writeln('║ (empty response)');
    }

    buffer.writeln('╚══════════════════════════════════════════════════════════════');
    print(buffer.toString());
  }


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
    // Return cached path if available
    if (_cachedGrpcurlPath != null) {
      print('✅ Using cached grpcurl path: $_cachedGrpcurlPath');
      return _cachedGrpcurlPath;
    }

    // Prevent concurrent searches
    if (_isFindingGrpcurlPath) {
      print('⏳ Grpcurl path search already in progress, waiting...');
      // Wait a bit and check again
      await Future.delayed(const Duration(milliseconds: 500));
      return _cachedGrpcurlPath;
    }

    _isFindingGrpcurlPath = true;

    try {
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

        // CRITICAL: For non-absolute paths (like "grpcurl"), check if it's in PATH
        // before attempting to run it to prevent segfaults/crashes
        if (!path.startsWith('/')) {
          // For PATH executables, try to find the actual path first
          try {
            print('🔍 Checking if "$path" is in PATH...');
            final whichResult = await Process.run('which', [path]).timeout(
              const Duration(milliseconds: 500),
              onTimeout: () => ProcessResult(0, 1, '', 'timeout'),
            );

            if (whichResult.exitCode != 0) {
              print('❌ "$path" not found in PATH');
              continue; // Skip this path
            }

            final actualPath = (whichResult.stdout as String).trim();
            print('✅ Found "$path" in PATH at: $actualPath');
          } catch (e) {
            print('❌ Failed to check PATH for "$path": $e');
            continue; // Skip this path if we can't verify it exists
          }
        } else {
          // For absolute paths, check if file exists
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

        // Now it's safer to run Process.run since we verified the executable exists
        ProcessResult? result;
        try {
          print('▶️ Running grpcurl at $path...');
          result = await Process.run(
            path,
            ['-plaintext', '$_host:$_port', 'list'],
          ).timeout(
            const Duration(seconds: 30), // 30 second timeout for network operations
            onTimeout: () {
              print('⏰ Timeout testing $path');
              throw TimeoutException('Command timed out', const Duration(seconds: 30));
            }
          );
        } on TimeoutException catch (e) {
          print('⏰ Timeout testing $path: ${e.message}');
          continue; // Skip to next path
        } on ProcessException catch (e) {
          // Specifically catch ProcessException when executable not found
          print('❌ grpcurl not found at $path: ${e.message}');
          continue; // Skip to next path
        } catch (e, stackTrace) {
          // Catch ANY other exception that might occur in sandboxed environment
          print('❌ Process.run failed for $path in sandboxed app: ${e.runtimeType}: ${e.toString()}');
          print('❌ Stack trace: $stackTrace');
          continue; // Skip to next path
        }

        if (result.exitCode == 0) {
          print('✅ Found working grpcurl at: $path');
          _cachedGrpcurlPath = path;
          return path;
        } else {
          final stderr = result.stderr.toString().trim();
          if (stderr.contains('does not support the reflection API')) {
            print('❌ gRPC Reflection API not enabled on server $_host:$_port');
            print('💡 Server must enable reflection or use -proto files with grpcurl');
            // Don't try other paths if we know the server doesn't support reflection
            break;
          } else {
            print('⚠️ grpcurl failed (exit ${result.exitCode}): ${stderr.length > 80 ? stderr.substring(0, 80) + "..." : stderr}');
          }
        }
      } catch (e) {
        // Try next path quickly, but log the specific error
        print('❌ Error testing grpcurl at $path: ${e.runtimeType}: ${e.toString()}');
        continue;
      }
    }

    // Provide more specific error message
    if (_cachedGrpcurlPath == null) {
      print('❌ grpcurl unavailable: Server reflection API disabled or grpcurl not accessible');
      print('💡 Ensure $_host:$_port has gRPC reflection enabled');
    }
    return null;
    } finally {
      _isFindingGrpcurlPath = false;
    }
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
          'proposed_execution_id': 'ping_${DateTime.now().millisecondsSinceEpoch}',
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
          'proposed_execution_id': 'ping_${DateTime.now().millisecondsSinceEpoch}',
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
      'proposed_execution_id': requestId,
      'string_to_be_ponged': stringToBePonged,
    };

    try {
      // Find the working grpcurl path with timeout that accounts for socket check (2s) plus path testing
      print('🔍 Looking for grpcurl executable...');
      final grpcurlPath = await _findGrpcurlPath().timeout(
        const Duration(seconds: 20),
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

      const methodName = 'AgentService.Ping';
      const endpoint = 'tech.qomet.agora.api.grpc.prtagent.v1.AgentService.Ping';

      ProcessResult? result;
      try {
        final jsonRequest = jsonEncode(request);
        final args = ['-plaintext', '-d', jsonRequest, '$_host:$_port', endpoint];

        // Log the request with detailed formatting
        _logRequest(
          method: methodName,
          endpoint: endpoint,
          args: args,
          body: jsonRequest,
        );

        final stopwatch = Stopwatch()..start();
        result = await Process.run(
          grpcurlPath,
          args,
        ).timeout(
          const Duration(seconds: 3),
          onTimeout: () {
            stopwatch.stop();
            print('⏰ grpcurl Process.run timed out after 3 seconds');
            throw TimeoutException('grpcurl ping timed out', const Duration(seconds: 3));
          },
        );
        stopwatch.stop();

        // Log the response with detailed formatting
        _logResponse(
          method: methodName,
          exitCode: result.exitCode,
          stdout: result.stdout.toString(),
          stderr: result.stderr.toString(),
          duration: stopwatch.elapsed,
        );
      } on TimeoutException catch (e) {
        print('⏰ Ping timeout: ${e.message}');
        return {
          'input': request,
          'output': {
            'error': 'Request timed out',
            'message': 'The ping request timed out after 3 seconds. Check if server is running on ${AppConfig.grpcServerAddress}.',
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

  /// Make a real NewInvestor call using grpcurl
  static Future<Map<String, dynamic>> newInvestor({
    required String externalInvestorId,
    String? auxData,
  }) async {
    // Prevent concurrent newInvestor calls to avoid crashes
    if (_isAccountListInProgress) {
      print('⚠️ NewInvestor blocked - another investor operation in progress');
      return {
        'input': {
          'proposed_execution_id': 'new_investor_${DateTime.now().millisecondsSinceEpoch}',
          'external_investor_id': externalInvestorId,
        },
        'output': {
          'error': 'Operation already in progress',
          'message': 'Another investor operation is already in progress. Please wait for it to complete.',
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'concurrent-blocked',
        'success': false,
      };
    }

    _isAccountListInProgress = true;
    try {
      // Retry logic with exponential backoff for connection refused errors
      const maxRetries = 3;
      const retryDelays = [Duration(seconds: 2), Duration(seconds: 4), Duration(seconds: 8)];

      for (var attempt = 0; attempt <= maxRetries; attempt++) {
        final result = await _newInvestorInternal(
          externalInvestorId: externalInvestorId,
          auxData: auxData,
        );

        // Check if this is a connection refused error that should trigger retry
        if (result['success'] != true && attempt < maxRetries) {
          final errorOutput = result['output'];
          final errorStr = errorOutput?.toString().toLowerCase() ?? '';

          // Check for connection refused or similar connection errors
          if (errorStr.contains('connection refused') ||
              errorStr.contains('connection error') ||
              errorStr.contains('failed to dial') ||
              errorStr.contains('transport: error while dialing')) {
            print('🔄 Connection refused on attempt ${attempt + 1}/${maxRetries + 1}, waiting before retry...');

            // Clear the cached grpcurl path to force re-discovery on next attempt
            _cachedGrpcurlPath = null;

            // Wait before retrying with exponential backoff
            await Future.delayed(retryDelays[attempt]);

            // Check if server is reachable before retry
            print('🔌 Checking if server is reachable before retry...');
            final serverReachable = await _isServerReachable();
            if (!serverReachable) {
              print('⚠️ Server still not reachable, will retry anyway...');
            } else {
              print('✅ Server is now reachable, retrying...');
            }

            continue; // Retry
          }
        }

        // Either success or non-retryable error
        return result;
      }

      // Should not reach here, but return last error
      return {
        'input': {
          'proposed_execution_id': 'new_investor_${DateTime.now().millisecondsSinceEpoch}',
          'external_investor_id': externalInvestorId,
        },
        'output': {
          'error': 'Max retries exceeded',
          'message': 'Failed to connect to server after ${maxRetries + 1} attempts. Please check if the server is running.',
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'retry-exhausted',
        'success': false,
      };
    } catch (error, stack) {
      print('❌ CRITICAL: Unhandled exception in newInvestor: $error');
      print('❌ CRITICAL: Stack: $stack');
      return {
        'input': {
          'proposed_execution_id': 'new_investor_${DateTime.now().millisecondsSinceEpoch}',
          'external_investor_id': externalInvestorId,
        },
        'output': {
          'error': 'Critical unhandled exception in newInvestor',
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

  /// Legacy alias for newInvestor (backwards compatibility)
  static Future<Map<String, dynamic>> newAccount({
    required String externalAccountId,
    String? auxData,
  }) => newInvestor(
    externalInvestorId: externalAccountId,
    auxData: auxData,
  );

  /// Internal newInvestor implementation
  static Future<Map<String, dynamic>> _newInvestorInternal({
    required String externalInvestorId,
    String? auxData,
  }) async {
    final requestId = 'new_investor_${DateTime.now().millisecondsSinceEpoch}';

    final request = {
      'proposed_execution_id': requestId,
      'external_investor_id': externalInvestorId,
      'aux_data': {
        'source': 'flutter_app',
        'created_at': auxData ?? 'Created from Flutter signup',
      },
    };

    try {
      // Find the working grpcurl path with timeout that accounts for socket check plus path testing
      print('🔍 Looking for grpcurl executable for NewInvestor...');
      final grpcurlPath = await _findGrpcurlPath().timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          print('⏰ grpcurl path finder timed out for NewInvestor');
          return null;
        },
      );

      if (grpcurlPath == null) {
        print('❌ No grpcurl path found for NewInvestor');
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

      const methodName = 'InvestorService.NewInvestor';
      const endpoint = 'tech.qomet.agora.api.grpc.prtagent.v1.InvestorService/NewInvestor';

      ProcessResult? result;
      try {
        final jsonRequest = jsonEncode(request);

        // Build grpcurl arguments with API key header if available
        final args = <String>['-plaintext'];
        final headers = <String, String>{};
        final apiKey = AppConfig.grpcApiKey;
        if (apiKey != null && apiKey.isNotEmpty) {
          args.addAll(['-H', 'x-agora-participant-api-key: $apiKey']);
          headers['x-agora-participant-api-key'] = apiKey;
        }
        args.addAll(['-d', jsonRequest, '$_host:$_port', endpoint]);

        // Log the request with detailed formatting
        _logRequest(
          method: methodName,
          endpoint: endpoint,
          args: args,
          body: jsonRequest,
          headers: headers,
        );

        final stopwatch = Stopwatch()..start();
        result = await Process.run(
          grpcurlPath,
          args,
        ).timeout(
          const Duration(seconds: 10),
          onTimeout: () {
            stopwatch.stop();
            print('⏰ grpcurl NewInvestor Process.run timed out after 10 seconds');
            throw TimeoutException('grpcurl newInvestor timed out', const Duration(seconds: 10));
          },
        );
        stopwatch.stop();

        // Log the response with detailed formatting
        _logResponse(
          method: methodName,
          exitCode: result.exitCode,
          stdout: result.stdout.toString(),
          stderr: result.stderr.toString(),
          duration: stopwatch.elapsed,
        );
      } on TimeoutException catch (e) {
        print('⏰ NewInvestor timeout: ${e.message}');
        return {
          'input': request,
          'output': {
            'error': 'Request timed out',
            'message': 'The new investor request timed out after 10 seconds. Check if server is running on ${AppConfig.grpcServerAddress}.',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'timeout',
          'success': false,
        };
      } catch (e) {
        // Catch ANY other exception that might occur in sandboxed environment
        print('❌ Process.run failed for newInvestor in sandboxed app: ${e.runtimeType}: ${e.toString()}');
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
  static Future<Map<String, dynamic>> getAccountList({
    int pageNumber = 0,
    int pageSize = 0,
    String? accountIdRegex,
    Map<String, String>? auxData,
  }) async {
    // Prevent concurrent account list calls to avoid crashes
    if (_isAccountListInProgress) {
      print('⚠️ GetAccountList already in progress, returning cached response');
      return {
        'input': {
          'proposed_execution_id': 'get_account_list_${DateTime.now().millisecondsSinceEpoch}',
          'pagination': {
            'page_nr': pageNumber,
            'page_size': pageSize,
          },
          if (accountIdRegex != null && accountIdRegex.isNotEmpty)
            'account_iid_or_external_id_regex': accountIdRegex,
          if (auxData != null && auxData.isNotEmpty)
            'aux_data': auxData,
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
      return await _getAccountListInternal(
        pageNumber: pageNumber,
        pageSize: pageSize,
        accountIdRegex: accountIdRegex,
        auxData: auxData,
      );
    } catch (error, stack) {
      print('❌ CRITICAL: Unhandled exception in getAccountList: $error');
      print('❌ CRITICAL: Stack: $stack');
      return {
        'input': {
          'proposed_execution_id': 'get_account_list_${DateTime.now().millisecondsSinceEpoch}',
          'pagination': {
            'page_nr': pageNumber,
            'page_size': pageSize,
          },
          if (accountIdRegex != null && accountIdRegex.isNotEmpty)
            'account_iid_or_external_id_regex': accountIdRegex,
          if (auxData != null && auxData.isNotEmpty)
            'aux_data': auxData,
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
  static Future<Map<String, dynamic>> _getAccountListInternal({
    int pageNumber = 0,
    int pageSize = 0,
    String? accountIdRegex,
    Map<String, String>? auxData,
  }) async {
    final requestId = 'get_account_list_${DateTime.now().millisecondsSinceEpoch}';
    
    // Build the proper request structure according to the proto definition
    final request = {
      'proposed_execution_id': requestId,
      'pagination': {
        'page_nr': pageNumber,
        'page_size': pageSize,
      },
      if (accountIdRegex != null && accountIdRegex.isNotEmpty)
        'account_iid_or_external_id_regex': accountIdRegex,
      if (auxData != null && auxData.isNotEmpty)
        'aux_data': auxData,
    };

    try {
      // Find the working grpcurl path with timeout that accounts for socket check plus path testing
      print('🔍 Looking for grpcurl executable for GetAccountList...');
      final grpcurlPath = await _findGrpcurlPath().timeout(
        const Duration(seconds: 20),
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
          ['-plaintext', '-d', jsonEncode(request), '$_host:$_port', 'tech.qomet.agora.api.grpc.prtagent.v1.AccountService.GetAccountList'],
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
            'message': 'The account list request timed out after 3 seconds. Check if server is running on ${AppConfig.grpcServerAddress}.',
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

  /// Make a real GetAccountSecurityHoldings call using grpcurl
  static Future<Map<String, dynamic>> getAccountMarketPortfolio({
    required String accountId,
    String? marketId,
    List<String>? assetIds,
  }) async {
    final requestId = 'get_account_security_holdings_${DateTime.now().millisecondsSinceEpoch}';

    final request = {
      'proposed_execution_id': requestId,
      'account_iid': accountId,
      'venue_iid': '',
    };

    try {
      // Find the working grpcurl path with timeout that accounts for socket check plus path testing
      print('🔍 Looking for grpcurl executable for GetAccountSecurityHoldings...');
      final grpcurlPath = await _findGrpcurlPath().timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          print('⏰ grpcurl path finder timed out for GetAccountSecurityHoldings');
          return null;
        },
      );

      if (grpcurlPath == null) {
        print('❌ No grpcurl path found for GetAccountSecurityHoldings');
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

      // Log the full request
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      print('📤 GetAccountSecurityHoldings REQUEST:');
      print('Service: tech.qomet.agora.api.grpc.prtagent.v1.AccountService.GetAccountSecurityHoldings');
      print('Host: $_host:$_port');
      print('Request Body:');
      print(const JsonEncoder.withIndent('  ').convert(request));
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

      ProcessResult? result;
      try {
        result = await Process.run(
          grpcurlPath,
          ['-plaintext', '-d', jsonEncode(request), '$_host:$_port', 'tech.qomet.agora.api.grpc.prtagent.v1.AccountService.GetAccountSecurityHoldings'],
        ).timeout(
          const Duration(seconds: 5),
          onTimeout: () {
            print('⏰ grpcurl GetAccountSecurityHoldings Process.run timed out after 5 seconds');
            throw TimeoutException('grpcurl getAccountSecurityHoldings timed out', const Duration(seconds: 5));
          },
        );
      } on TimeoutException catch (e) {
        print('⏰ GetAccountSecurityHoldings timeout: ${e.message}');
        return {
          'input': request,
          'output': {
            'error': 'Request timed out',
            'message': 'The account security holdings request timed out after 5 seconds. Check if server is running on ${AppConfig.grpcServerAddress}.',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'timeout',
          'success': false,
        };
      } catch (e) {
        // Catch ANY other exception that might occur in sandboxed environment
        print('❌ Process.run failed for getAccountSecurityHoldings in sandboxed app: ${e.runtimeType}: ${e.toString()}');
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

        try {
          final parsedResponse = jsonDecode(responseJson) as Map<String, dynamic>;

          // Log the full response
          print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
          print('📥 GetAccountSecurityHoldings RESPONSE:');
          print('Status: SUCCESS');
          print('Response Body:');
          print(const JsonEncoder.withIndent('  ').convert(parsedResponse));
          print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

          return {
            'input': request,
            'output': parsedResponse,
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
            'serverType': 'simprtagent-real-grpcurl',
            'success': true,
          };
        } catch (e) {
          print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
          print('📥 GetAccountSecurityHoldings RESPONSE:');
          print('Status: JSON PARSE ERROR');
          print('Raw Response: $responseJson');
          print('Error: $e');
          print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

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

        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('📥 GetAccountSecurityHoldings RESPONSE:');
        print('Status: FAILED');
        print('Exit Code: ${result.exitCode}');
        print('STDERR: $error');
        print('STDOUT: ${result.stdout}');
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

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
      'proposed_execution_id': requestId,
      'account_iid': accountId,
      'currency_codes': cashAssetIds ?? [],
    };

    try {
      // Find the working grpcurl path with timeout that accounts for socket check plus path testing
      print('🔍 Looking for grpcurl executable for GetAccountCashHoldings...');
      final grpcurlPath = await _findGrpcurlPath().timeout(
        const Duration(seconds: 20),
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

      // Log the full request
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      print('📤 GetAccountCashHoldings REQUEST:');
      print('Service: tech.qomet.agora.api.grpc.prtagent.v1.AccountService.GetAccountCashHoldings');
      print('Host: $_host:$_port');
      print('Request Body:');
      print(const JsonEncoder.withIndent('  ').convert(request));
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

      ProcessResult? result;
      try {
        result = await Process.run(
          grpcurlPath,
          ['-plaintext', '-d', jsonEncode(request), '$_host:$_port', 'tech.qomet.agora.api.grpc.prtagent.v1.AccountService.GetAccountCashHoldings'],
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
            'message': 'The account cash holdings request timed out after 5 seconds. Check if server is running on ${AppConfig.grpcServerAddress}.',
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

        try {
          final parsedResponse = jsonDecode(responseJson) as Map<String, dynamic>;

          // Log the full response
          print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
          print('📥 GetAccountCashHoldings RESPONSE:');
          print('Status: SUCCESS');
          print('Response Body:');
          print(const JsonEncoder.withIndent('  ').convert(parsedResponse));
          print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

          return {
            'input': request,
            'output': parsedResponse,
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
            'serverType': 'simprtagent-real-grpcurl',
            'success': true,
          };
        } catch (e) {
          print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
          print('📥 GetAccountCashHoldings RESPONSE:');
          print('Status: JSON PARSE ERROR');
          print('Raw Response: $responseJson');
          print('Error: $e');
          print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

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

        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('📥 GetAccountCashHoldings RESPONSE:');
        print('Status: FAILED');
        print('Exit Code: ${result.exitCode}');
        print('STDERR: $error');
        print('STDOUT: ${result.stdout}');
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

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

  /// Deposit cash to an account using grpcurl
  static Future<Map<String, dynamic>> depositCash({
    required String accountId,
    required String currencyCode,
    required String amount,
    Map<String, String>? auxData,
  }) async {
    final requestId = 'deposit_cash_${DateTime.now().millisecondsSinceEpoch}';

    final request = {
      'proposed_execution_id': requestId,
      'account_iid': accountId,
      'currency_code': currencyCode,
      'amount': amount,
      'aux_data': auxData ?? {
        'source': 'flutter_app',
        'transaction_type': 'deposit',
      },
    };

    try {
      // Find the working grpcurl path with timeout that accounts for socket check plus path testing
      print('🔍 Looking for grpcurl executable for DepositCash...');
      final grpcurlPath = await _findGrpcurlPath().timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          print('⏰ grpcurl path finder timed out for DepositCash');
          return null;
        },
      );

      if (grpcurlPath == null) {
        print('❌ No grpcurl path found for DepositCash');
        return {
          'input': request,
          'output': {
            'error': 'grpcurl command not available in standalone app',
            'message': 'The standalone macOS app cannot access grpcurl due to sandbox restrictions. This feature works when running with "flutter run --debug" but not in built apps.',
            'suggestion': 'Use "echo "1" | flutter run --debug" to test this functionality',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'grpcurl-sandbox-restricted',
          'success': false,
        };
      }

      // Log the full request
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      print('📤 DepositCash REQUEST:');
      print('Service: tech.qomet.agora.api.grpc.prtagent.v1.AccountService.DepositCash');
      print('Host: $_host:$_port');
      print('Request Body:');
      print(const JsonEncoder.withIndent('  ').convert(request));
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

      ProcessResult? result;
      try {
        result = await Process.run(
          grpcurlPath,
          ['-plaintext', '-d', jsonEncode(request), '$_host:$_port', 'tech.qomet.agora.api.grpc.prtagent.v1.AccountService.DepositCash'],
        ).timeout(
          const Duration(seconds: 10),
          onTimeout: () {
            print('⏰ grpcurl DepositCash Process.run timed out after 10 seconds');
            throw TimeoutException('grpcurl depositCash timed out', const Duration(seconds: 10));
          },
        );
      } on TimeoutException catch (e) {
        print('⏰ DepositCash timeout: ${e.message}');
        return {
          'input': request,
          'output': {
            'error': 'Request timed out',
            'message': 'The deposit cash request timed out after 10 seconds. Check if server is running on ${AppConfig.grpcServerAddress}.',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'timeout',
          'success': false,
        };
      } catch (e) {
        print('❌ Process.run failed for depositCash in sandboxed app: ${e.runtimeType}: ${e.toString()}');
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

        try {
          final parsedResponse = jsonDecode(responseJson) as Map<String, dynamic>;

          // Log the full response
          print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
          print('📥 DepositCash RESPONSE:');
          print('Status: SUCCESS');
          print('Response Body:');
          print(const JsonEncoder.withIndent('  ').convert(parsedResponse));
          print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

          return {
            'input': request,
            'output': parsedResponse,
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
            'serverType': 'simprtagent-real-grpcurl',
            'success': true,
          };
        } catch (e) {
          print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
          print('📥 DepositCash RESPONSE:');
          print('Status: JSON PARSE ERROR');
          print('Raw Response: $responseJson');
          print('Error: $e');
          print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

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

        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('📥 DepositCash RESPONSE:');
        print('Status: FAILED');
        print('Exit Code: ${result.exitCode}');
        print('STDERR: $error');
        print('STDOUT: ${result.stdout}');
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

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
      print('❌ Failed to execute grpcurl for depositCash: $e');
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

  /// Withdraw cash from an account using grpcurl
  static Future<Map<String, dynamic>> withdrawCash({
    required String accountId,
    required String currencyCode,
    required String amount,
    Map<String, String>? auxData,
  }) async {
    final requestId = 'withdraw_cash_${DateTime.now().millisecondsSinceEpoch}';

    final request = {
      'proposed_execution_id': requestId,
      'account_iid': accountId,
      'currency_code': currencyCode,
      'amount': amount,
      'aux_data': auxData ?? {
        'source': 'flutter_app',
        'transaction_type': 'withdrawal',
      },
    };

    try {
      // Find the working grpcurl path with timeout that accounts for socket check plus path testing
      print('🔍 Looking for grpcurl executable for WithdrawCash...');
      final grpcurlPath = await _findGrpcurlPath().timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          print('⏰ grpcurl path finder timed out for WithdrawCash');
          return null;
        },
      );

      if (grpcurlPath == null) {
        print('❌ No grpcurl path found for WithdrawCash');
        return {
          'input': request,
          'output': {
            'error': 'grpcurl command not available in standalone app',
            'message': 'The standalone macOS app cannot access grpcurl due to sandbox restrictions. This feature works when running with "flutter run --debug" but not in built apps.',
            'suggestion': 'Use "echo "1" | flutter run --debug" to test this functionality',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'grpcurl-sandbox-restricted',
          'success': false,
        };
      }

      // Log the full request
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      print('📤 WithdrawCash REQUEST:');
      print('Service: tech.qomet.agora.api.grpc.prtagent.v1.AccountService.WithdrawCash');
      print('Host: $_host:$_port');
      print('Request Body:');
      print(const JsonEncoder.withIndent('  ').convert(request));
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

      ProcessResult? result;
      try {
        result = await Process.run(
          grpcurlPath,
          ['-plaintext', '-d', jsonEncode(request), '$_host:$_port', 'tech.qomet.agora.api.grpc.prtagent.v1.AccountService.WithdrawCash'],
        ).timeout(
          const Duration(seconds: 10),
          onTimeout: () {
            print('⏰ grpcurl WithdrawCash Process.run timed out after 10 seconds');
            throw TimeoutException('grpcurl withdrawCash timed out', const Duration(seconds: 10));
          },
        );
      } on TimeoutException catch (e) {
        print('⏰ WithdrawCash timeout: ${e.message}');
        return {
          'input': request,
          'output': {
            'error': 'Request timed out',
            'message': 'The withdraw cash request timed out after 10 seconds. Check if server is running on ${AppConfig.grpcServerAddress}.',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'timeout',
          'success': false,
        };
      } catch (e) {
        print('❌ Process.run failed for withdrawCash in sandboxed app: ${e.runtimeType}: ${e.toString()}');
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

        try {
          final parsedResponse = jsonDecode(responseJson) as Map<String, dynamic>;

          // Log the full response
          print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
          print('📥 WithdrawCash RESPONSE:');
          print('Status: SUCCESS');
          print('Response Body:');
          print(const JsonEncoder.withIndent('  ').convert(parsedResponse));
          print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

          return {
            'input': request,
            'output': parsedResponse,
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
            'serverType': 'simprtagent-real-grpcurl',
            'success': true,
          };
        } catch (e) {
          print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
          print('📥 WithdrawCash RESPONSE:');
          print('Status: JSON PARSE ERROR');
          print('Raw Response: $responseJson');
          print('Error: $e');
          print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

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

        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('📥 WithdrawCash RESPONSE:');
        print('Status: FAILED');
        print('Exit Code: ${result.exitCode}');
        print('STDERR: $error');
        print('STDOUT: ${result.stdout}');
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

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
      print('❌ Failed to execute grpcurl for withdrawCash: $e');
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
        'proposed_execution_id': refRequestId,
        'account_iid': accountId,
      };

      // Add optional parameters if provided
      if (marketIdOrNameRegexes != null && marketIdOrNameRegexes.isNotEmpty) {
        requestPayload['venue_id_or_symbol_regexes'] = marketIdOrNameRegexes;
      }
      
      if (pagination != null) {
        requestPayload['pagination'] = pagination;
      }
      
      // Build order_query_filter if we have any filter parameters
      final orderQueryFilter = <String, dynamic>{};
      bool hasOrderFilter = false;
      
      if (fromTime != null) {
        // Parse fromTime as JSON and add to order_query_filter
        try {
          final parsedFromTime = jsonDecode(fromTime);
          if (parsedFromTime is Map<String, dynamic>) {
            orderQueryFilter['from_dt'] = parsedFromTime;
            hasOrderFilter = true;
          }
        } catch (e) {
          // If not valid JSON, skip it
          print('⚠️ Could not parse fromTime: $fromTime');
        }
      }
      
      if (toTime != null) {
        // Parse toTime as JSON and add to order_query_filter
        try {
          final parsedToTime = jsonDecode(toTime);
          if (parsedToTime is Map<String, dynamic>) {
            orderQueryFilter['to_dt'] = parsedToTime;
            hasOrderFilter = true;
          }
        } catch (e) {
          // If not valid JSON, skip it
          print('⚠️ Could not parse toTime: $toTime');
        }
      }
      
      if (side != null) {
        orderQueryFilter['side'] = side;
        hasOrderFilter = true;
      }
      
      if (statusFilters != null) {
        orderQueryFilter['status_filters'] = statusFilters;
        hasOrderFilter = true;
      }
      
      // Only add order_query_filter if it has any parameters
      if (hasOrderFilter) {
        requestPayload['order_query_filter'] = orderQueryFilter;
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
            'tech.qomet.agora.api.grpc.prtagent.v1.AccountService/GetAccountOrders'
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
    List<String>? securityIdOrSymbolRegexes,
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
        'proposed_execution_id': refRequestId,
        'account_iid': accountId,
      };

      // Add optional parameters if provided
      if (marketIdOrNameRegexes != null && marketIdOrNameRegexes.isNotEmpty) {
        requestPayload['venue_id_or_symbol_regexes'] = marketIdOrNameRegexes;
      }

      if (pagination != null) {
        requestPayload['pagination'] = pagination;
      }

      if (fromTime != null) {
        // Parse fromTime as JSON and add directly to request
        try {
          final parsedFromTime = jsonDecode(fromTime);
          if (parsedFromTime is Map<String, dynamic>) {
            requestPayload['from_dt'] = parsedFromTime;
          }
        } catch (e) {
          // If not valid JSON, skip it
          print('⚠️ Could not parse fromTime: $fromTime');
        }
      }

      if (toTime != null) {
        // Parse toTime as JSON and add directly to request
        try {
          final parsedToTime = jsonDecode(toTime);
          if (parsedToTime is Map<String, dynamic>) {
            requestPayload['to_dt'] = parsedToTime;
          }
        } catch (e) {
          // If not valid JSON, skip it
          print('⚠️ Could not parse toTime: $toTime');
        }
      }

      if (side != null) {
        requestPayload['side'] = side;
      }

      if (securityIdOrSymbolRegexes != null && securityIdOrSymbolRegexes.isNotEmpty) {
        requestPayload['security_id_or_symbol_regexes'] = securityIdOrSymbolRegexes;
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
            'tech.qomet.agora.api.grpc.prtagent.v1.AccountService/GetAccountTrades'
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

  /// Get account settlements using GetAccountSettlements gRPC method
  static Future<Map<String, dynamic>> getAccountSettlements({
    required String accountId,
    String refRequestId = 'flutter-get-settlements',
    List<String>? marketIdOrNameRegexes,
    Map<String, dynamic>? pagination,
    String? fromTime,
    String? toTime,
    String? status,
    List<String>? assetIdOrNameRegexes,
  }) async {
    try {
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
        'proposed_execution_id': refRequestId,
        'account_iid': accountId,
      };

      // Add optional parameters if provided
      if (marketIdOrNameRegexes != null && marketIdOrNameRegexes.isNotEmpty) {
        requestPayload['market_id_or_name_regexes'] = marketIdOrNameRegexes;
      }

      if (pagination != null) {
        requestPayload['pagination'] = pagination;
      }

      if (fromTime != null) {
        // Parse fromTime as JSON and add directly to request
        try {
          final parsedFromTime = jsonDecode(fromTime);
          if (parsedFromTime is Map<String, dynamic>) {
            requestPayload['from_dt'] = parsedFromTime;
          }
        } catch (e) {
          // If not valid JSON, skip it
          print('⚠️ Could not parse fromTime: $fromTime');
        }
      }

      if (toTime != null) {
        // Parse toTime as JSON and add directly to request
        try {
          final parsedToTime = jsonDecode(toTime);
          if (parsedToTime is Map<String, dynamic>) {
            requestPayload['to_dt'] = parsedToTime;
          }
        } catch (e) {
          // If not valid JSON, skip it
          print('⚠️ Could not parse toTime: $toTime');
        }
      }

      if (status != null) {
        requestPayload['status'] = status;
      }

      if (assetIdOrNameRegexes != null && assetIdOrNameRegexes.isNotEmpty) {
        requestPayload['asset_id_or_name_regexes'] = assetIdOrNameRegexes;
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
            'tech.qomet.agora.api.grpc.prtagent.v1.AccountService/GetAccountSettlements'
          ],
        ).timeout(const Duration(seconds: 10));
      } catch (e) {
        print('❌ Process.run failed for GetAccountSettlements: ${e.runtimeType}: ${e.toString()}');
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
        } catch (e) {
          responseData['output'] = {
            'error': 'Invalid JSON response',
            'raw_output': result.stdout.toString(),
            'details': e.toString(),
          };
          print('❌ GetAccountSettlements JSON parse error: $e');
        }
      } else {
        responseData['output'] = {
          'error': 'gRPC call failed',
          'stderr': result.stderr.toString(),
          'stdout': result.stdout.toString(),
          'exit_code': result.exitCode,
        };
        print('❌ GetAccountSettlements failed: ${result.stderr}');
      }

      return responseData;
    } catch (e) {
      print('❌ GetAccountSettlements exception: $e');
      return {
        'success': false,
        'output': {'error': 'Exception occurred', 'details': e.toString()},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'exception',
      };
    }
  }

  /// Get account transactions using GetAccountTransactions gRPC method
  static Future<Map<String, dynamic>> getInvestorTransactions({
    required String accountId,
    String refRequestId = 'flutter-get-transactions',
    Map<String, dynamic>? pagination,
    String? fromTime,
    String? toTime,
    List<String>? transactionTypes,
    List<String>? assetIdOrNameRegexes,
  }) async {
    try {
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

      // Prepare request payload
      final requestPayload = <String, dynamic>{
        'proposed_execution_id': refRequestId,
        'account_iid': accountId,
      };

      // Add optional parameters if provided
      if (pagination != null) {
        requestPayload['pagination'] = pagination;
      }

      if (fromTime != null) {
        // Parse fromTime as JSON and add directly to request
        try {
          final parsedFromTime = jsonDecode(fromTime);
          if (parsedFromTime is Map<String, dynamic>) {
            requestPayload['from_dt'] = parsedFromTime;
          }
        } catch (e) {
          print('⚠️ Could not parse fromTime: $fromTime');
        }
      }

      if (toTime != null) {
        // Parse toTime as JSON and add directly to request
        try {
          final parsedToTime = jsonDecode(toTime);
          if (parsedToTime is Map<String, dynamic>) {
            requestPayload['to_dt'] = parsedToTime;
          }
        } catch (e) {
          print('⚠️ Could not parse toTime: $toTime');
        }
      }

      if (transactionTypes != null && transactionTypes.isNotEmpty) {
        requestPayload['transaction_types'] = transactionTypes;
      }

      if (assetIdOrNameRegexes != null && assetIdOrNameRegexes.isNotEmpty) {
        requestPayload['asset_id_or_name_regexes'] = assetIdOrNameRegexes;
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
            'tech.qomet.agora.api.grpc.prtagent.v1.AccountService/GetAccountTransactions'
          ],
        ).timeout(const Duration(seconds: 10));
      } catch (e) {
        print('❌ Process.run failed for GetAccountTransactions: ${e.runtimeType}: ${e.toString()}');
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
        } catch (e) {
          responseData['output'] = {
            'error': 'Invalid JSON response',
            'raw_output': result.stdout.toString(),
            'details': e.toString(),
          };
          print('❌ GetAccountTransactions JSON parse error: $e');
        }
      } else {
        responseData['output'] = {
          'error': 'gRPC call failed',
          'stderr': result.stderr.toString(),
          'stdout': result.stdout.toString(),
          'exit_code': result.exitCode,
        };
        print('❌ GetAccountTransactions failed: ${result.stderr}');
      }

      return responseData;
    } catch (e) {
      print('❌ GetAccountTransactions exception: $e');
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
        'proposed_execution_id': 'get_markets_${DateTime.now().millisecondsSinceEpoch}',
        'pagination': {
          'page_nr': 0,
          'page_size': 0,
        },
      };

      final result = await Process.run(
        grpcurlPath,
        [
          '-plaintext',
          '-d', jsonEncode(inputParams),
          '$_host:$_port',
          'tech.qomet.agora.api.grpc.prtagent.v1.MarketService/GetMarketList'
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

  /// Get Security List using grpcurl (without market filter)
  static Future<Map<String, dynamic>> getSecurityList({
    int pageNumber = 0,
    int pageSize = 0,
  }) async {
    final responseData = <String, dynamic>{
      'success': false,
      'output': {},
      'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
      'serverType': 'real_grpc',
    };

    try {
      print('📋 Getting security list from real server...');

      // Check server reachability first
      if (!await _isServerReachable()) {
        responseData['output'] = {'error': 'Server not reachable'};
        responseData['serverType'] = 'unreachable';
        return responseData;
      }

      final grpcurlPath = await _findGrpcurlPath();
      if (grpcurlPath == null) {
        responseData['output'] = {
          'error': 'gRPC Reflection API not enabled',
          'details': 'Server $_host:$_port must enable gRPC reflection for grpcurl to work',
          'suggestion': 'Enable reflection on your gRPC server or provide .proto files'
        };
        responseData['serverType'] = 'reflection-disabled';
        return responseData;
      }

      final inputParams = {
        'proposed_execution_id': 'get_security_list_${DateTime.now().millisecondsSinceEpoch}',
        'pagination': {
          'page_nr': pageNumber,
          'page_size': pageSize,
        },
        'security_iid_or_identifier_regex': '', // Empty filter - returns all securities
      };

      // Log the full request
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      print('📤 GetSecurityList REQUEST:');
      print('Service: tech.qomet.agora.api.grpc.prtagent.v1.SecurityService/GetSecurityList');
      print('Host: $_host:$_port');
      print('Request Body:');
      print(const JsonEncoder.withIndent('  ').convert(inputParams));
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

      final result = await Process.run(
        grpcurlPath,
        [
          '-plaintext',
          '-d', jsonEncode(inputParams),
          '$_host:$_port',
          'tech.qomet.agora.api.grpc.prtagent.v1.SecurityService/GetSecurityList'
        ],
        environment: {'PATH': '/usr/local/bin:/opt/homebrew/bin:${Platform.environment['PATH']}'},
      ).timeout(const Duration(seconds: 10));

      if (result.exitCode == 0) {
        final responseJson = jsonDecode(result.stdout);
        responseData['success'] = true;
        responseData['output'] = responseJson;

        // Log the full response
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('📥 GetSecurityList RESPONSE:');
        print('Status: SUCCESS');
        print('Response Body:');
        print(const JsonEncoder.withIndent('  ').convert(responseJson));
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('✅ GetSecurityList successful');
      } else {
        responseData['output'] = {
          'error': 'gRPC call failed',
          'stderr': result.stderr.toString(),
          'stdout': result.stdout.toString(),
          'exit_code': result.exitCode,
        };

        // Log the error response
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('📥 GetSecurityList RESPONSE:');
        print('Status: FAILED');
        print('Exit Code: ${result.exitCode}');
        print('STDERR: ${result.stderr}');
        print('STDOUT: ${result.stdout}');
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('❌ GetSecurityList failed: ${result.stderr}');
      }

      return responseData;
    } catch (e) {
      print('❌ GetSecurityList exception: $e');
      return {
        'success': false,
        'output': {'error': 'Exception occurred', 'details': e.toString()},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'exception',
      };
    }
  }

  /// Get Market Security List using grpcurl
  static Future<Map<String, dynamic>> getMarketSecurityList({
    required String marketId,
    int pageNumber = 0,
    int pageSize = 0,
  }) async {
    final responseData = <String, dynamic>{
      'success': false,
      'output': {},
      'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
      'serverType': 'real_grpc',
    };

    try {
      print('📋 Getting market security list for market: $marketId from real server...');

      // Check server reachability first
      if (!await _isServerReachable()) {
        responseData['output'] = {'error': 'Server not reachable'};
        responseData['serverType'] = 'unreachable';
        return responseData;
      }

      final grpcurlPath = await _findGrpcurlPath();
      if (grpcurlPath == null) {
        responseData['output'] = {
          'error': 'gRPC Reflection API not enabled',
          'details': 'Server $_host:$_port must enable gRPC reflection for grpcurl to work',
          'suggestion': 'Enable reflection on your gRPC server or provide .proto files'
        };
        responseData['serverType'] = 'reflection-disabled';
        return responseData;
      }

      final inputParams = {
        'proposed_execution_id': 'get_security_list_${DateTime.now().millisecondsSinceEpoch}',
        'pagination': {
          'page_nr': pageNumber,
          'page_size': pageSize,
        },
        'security_iid_or_identifier_regex': marketId,
      };

      // Log the full request
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      print('📤 GetMarketSecurityList REQUEST:');
      print('Service: tech.qomet.agora.api.grpc.prtagent.v1.SecurityService/GetSecurityList');
      print('Host: $_host:$_port');
      print('Request Body:');
      print(const JsonEncoder.withIndent('  ').convert(inputParams));
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

      final result = await Process.run(
        grpcurlPath,
        [
          '-plaintext',
          '-d', jsonEncode(inputParams),
          '$_host:$_port',
          'tech.qomet.agora.api.grpc.prtagent.v1.SecurityService/GetSecurityList'
        ],
        environment: {'PATH': '/usr/local/bin:/opt/homebrew/bin:${Platform.environment['PATH']}'},
      ).timeout(const Duration(seconds: 10));

      if (result.exitCode == 0) {
        final responseJson = jsonDecode(result.stdout);
        responseData['success'] = true;
        responseData['output'] = responseJson;

        // Log the full response
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('📥 GetSecurityList RESPONSE:');
        print('Status: SUCCESS');
        print('Response Body:');
        print(const JsonEncoder.withIndent('  ').convert(responseJson));
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('✅ GetMarketSecurityList successful');
      } else {
        responseData['output'] = {
          'error': 'gRPC call failed',
          'stderr': result.stderr.toString(),
          'stdout': result.stdout.toString(),
          'exit_code': result.exitCode,
        };

        // Log the error response
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('📥 GetSecurityList RESPONSE:');
        print('Status: FAILED');
        print('Exit Code: ${result.exitCode}');
        print('STDERR: ${result.stderr}');
        print('STDOUT: ${result.stdout}');
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('❌ GetMarketSecurityList failed: ${result.stderr}');
      }

      return responseData;
    } catch (e) {
      print('❌ GetMarketSecurityList exception: $e');
      return {
        'success': false,
        'output': {'error': 'Exception occurred', 'details': e.toString()},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'exception',
      };
    }
  }

  /// Make a real GetMarketSupportedCurrencies call using grpcurl
  static Future<Map<String, dynamic>> getMarketSupportedCurrencies({
    required String marketId,
    int pageNumber = 0,
    int pageSize = 0,
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
        print('❌ No grpcurl path found');
        return {
          'success': false,
          'output': {
            'error': 'grpcurl command not available in standalone app',
            'message': 'The standalone macOS app cannot access grpcurl due to sandbox restrictions. This feature works when running with "flutter run --debug" but not in built apps.',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'grpcurl-sandbox-restricted',
        };
      }

      final request = {
        'proposed_execution_id': 'get_supported_currencies_${DateTime.now().millisecondsSinceEpoch}',
        'pagination': {
          'page_nr': pageNumber,
          'page_size': pageSize,
        },
        // Removed aux_data completely to avoid server marshaling issues
      };

      print('🔄 Making real grpcurl call to AgentService/GetSupportedCurrencies using $grpcurlPath');
      print('📨 Request: $request');

      final result = await Process.run(
        grpcurlPath,
        ['-plaintext', '-d', jsonEncode(request), '$_host:$_port', 'tech.qomet.agora.api.grpc.prtagent.v1.AgentService/GetSupportedCurrencies'],
      ).timeout(const Duration(seconds: 10));

      print('📤 GetSupportedCurrencies gRPC exit code: ${result.exitCode}');
      print('📤 GetSupportedCurrencies gRPC stdout: ${result.stdout}');
      if (result.stderr.isNotEmpty) {
        print('📤 GetSupportedCurrencies gRPC stderr: ${result.stderr}');
      }

      if (result.exitCode == 0 && result.stdout.isNotEmpty) {
        final responseJson = jsonDecode(result.stdout);
        responseData['success'] = true;
        responseData['output'] = responseJson;
        print('✅ GetSupportedCurrencies successful');
      } else {
        responseData['output'] = {
          'error': 'gRPC call failed',
          'stderr': result.stderr.toString(),
          'stdout': result.stdout.toString(),
          'exit_code': result.exitCode,
        };
        print('❌ GetSupportedCurrencies failed: ${result.stderr}');
        print('📤 GetSupportedCurrencies Error Details: Exit Code ${result.exitCode}');
        print('📤 GetSupportedCurrencies stdout: ${result.stdout}');
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

  /// Make a real GetSupportedCurrencies call using grpcurl
  static Future<Map<String, dynamic>> getSupportedCurrencies({
    int pageNumber = 0,
    int pageSize = 0,
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
        'proposed_execution_id': 'get_supported_currencies_${DateTime.now().millisecondsSinceEpoch}',
        'pagination': {
          'page_nr': pageNumber,
          'page_size': pageSize,
        },
        // Removed aux_data completely to avoid server marshaling issues
      };

      print('📨 GetSupportedCurrencies Request: $inputParams');
      print('🔗 Calling: tech.qomet.agora.api.grpc.prtagent.v1.AgentService/GetSupportedCurrencies');
      print('🌐 Server: $_host:$_port');
      print('🔧 Full grpcurl command: $grpcurlPath -plaintext -d \'${jsonEncode(inputParams)}\' $_host:$_port tech.qomet.agora.api.grpc.prtagent.v1.AgentService/GetSupportedCurrencies');

      final result = await Process.run(
        grpcurlPath,
        [
          '-plaintext',
          '-d', jsonEncode(inputParams),
          '$_host:$_port',
          'tech.qomet.agora.api.grpc.prtagent.v1.AgentService/GetSupportedCurrencies'
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
        print('📤 GetSupportedCurrencies Error Details: Exit Code ${result.exitCode}');
        print('📤 GetSupportedCurrencies stdout: ${result.stdout}');
        print('📤 GetSupportedCurrencies REQUEST SENT: ${jsonEncode(inputParams)}');
        print('📤 GetSupportedCurrencies FULL RESPONSE: stdout="${result.stdout}" stderr="${result.stderr}" exitCode=${result.exitCode}');
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

  /// Get order fees using grpcurl
  static Future<Map<String, dynamic>> getOrderFees({
    required String accountId,
    required String feePayerAccountId,
    required String securityId,
    required String orderType, // "LIMIT" or "MARKET"
    required String side, // "BUY" or "SELL"
    required String quantity,
    String? price, // Required for LIMIT orders
    String timeInForce = "0", // Always 0 according to requirements
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
        'proposed_execution_id': 'get_order_fees_${DateTime.now().millisecondsSinceEpoch}',
        'account_iid': accountId,
        'fee_payer_account_iid': feePayerAccountId,
        'security_listing_iid': securityId,
        'order_type': orderType,
        'side': side == "BUY" ? "ORDER_SIDE__BUY" : "ORDER_SIDE__SELL",
        'quantity': quantity,
        'time_in_force': timeInForce,
      };

      // Add price for LIMIT orders
      if (price != null) {
        inputParams['price'] = price;
      }

      print('📨 GetOrderFees Request: $inputParams');

      final result = await Process.run(
        grpcurlPath,
        [
          '-plaintext',
          '-d', jsonEncode(inputParams),
          '$_host:$_port',
          'tech.qomet.agora.api.grpc.prtagent.v1.TradingService/GetOrderFees'
        ],
        environment: {'PATH': '/usr/local/bin:/opt/homebrew/bin:${Platform.environment['PATH']}'},
      ).timeout(const Duration(seconds: 10));

      if (result.exitCode == 0) {
        final responseJson = jsonDecode(result.stdout);
        responseData['success'] = true;
        responseData['output'] = responseJson;
        print('✅ GetOrderFees successful');
        print('📬 GetOrderFees Response: $responseJson');
      } else {
        responseData['output'] = {
          'error': 'gRPC call failed',
          'stderr': result.stderr.toString(),
          'stdout': result.stdout.toString(),
          'exit_code': result.exitCode,
        };
        print('❌ GetOrderFees failed: ${result.stderr}');
      }

      return responseData;
    } catch (e) {
      print('❌ GetOrderFees exception: $e');
      return {
        'success': false,
        'output': {'error': 'Exception occurred', 'details': e.toString()},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'exception',
      };
    }
  }

  static Future<Map<String, dynamic>> createOrder({
    required String accountId,
    required String feePayerAccountId,
    required String securityId,
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
      // Find the working grpcurl path with timeout that accounts for socket check plus path testing
      print('🔍 Looking for grpcurl executable for CreateOrderAsync...');
      final grpcurlPath = await _findGrpcurlPath().timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          print('⏰ grpcurl path finder timed out for CreateOrderAsync');
          return null;
        },
      );

      if (grpcurlPath == null) {
        print('❌ grpcurl not found for CreateOrderAsync');
        return {
          'input': null,
          'output': {
            'error': 'grpcurl executable not found',
            'message': 'Unable to locate grpcurl in standard paths',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'grpcurl-not-found',
          'success': false,
        };
      }

      print('✅ Using grpcurl path: $grpcurlPath');

      // Convert order side to the required enum value
      String orderSideValue;
      switch (side.toUpperCase()) {
        case 'BUY':
          orderSideValue = '1';
          break;
        case 'SELL':
          orderSideValue = '2';
          break;
        default:
          throw ArgumentError('Invalid side: $side. Must be BUY or SELL');
      }

      // Build the JSON request
      final Map<String, dynamic> request = {
        'proposed_execution_id': 'create_order_${DateTime.now().millisecondsSinceEpoch}',
        'account_iid': accountId,
        'fee_payer_account_iid': feePayerAccountId,
        'security_listing_iid': securityId,
        'order_type': orderType,
        'side': orderSideValue,
        'quantity': quantity,
        'price': price,
        'time_in_force': timeInForce,
        'participant_order_iid': participantOrderId,
      };

      // Add optional fields
      if (expireTime != null) {
        request['expire_time'] = {
          'ts': expireTime.toUtc().toIso8601String(),
        };
      }

      if (metadata != null) {
        request['metadata'] = metadata;
      }

      if (auxData != null) {
        request['aux_data'] = auxData;
      }

      final jsonRequest = json.encode(request);
      print('🚀 CreateOrderAsync Request: $jsonRequest');

      final result = await Process.run(
        grpcurlPath,
        [
          '-plaintext',
          '-d',
          jsonRequest,
          '$_host:$_port',
          'tech.qomet.agora.api.grpc.prtagent.v1.TradingService/CreateOrderAsync',
        ],
      );

      print('📬 CreateOrderAsync Response (stdout): ${result.stdout}');
      print('📬 CreateOrderAsync Response (stderr): ${result.stderr}');
      print('📬 CreateOrderAsync Exit code: ${result.exitCode}');

      if (result.exitCode == 0 && result.stdout.toString().trim().isNotEmpty) {
        try {
          final Map<String, dynamic> output = json.decode(result.stdout);
          print('📬 CreateOrderAsync Response: $output');
          return {
            'success': true,
            'output': output,
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
            'serverType': 'grpcurl',
          };
        } catch (e) {
          print('❌ Error parsing CreateOrderAsync JSON response: $e');
          print('❌ Raw response: ${result.stdout}');
          return {
            'success': false,
            'output': {
              'error': 'Failed to parse response JSON',
              'rawResponse': result.stdout.toString(),
              'parseError': e.toString()
            },
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
            'serverType': 'grpcurl',
          };
        }
      } else {
        print('❌ CreateOrderAsync grpcurl command failed');
        print('❌ Exit code: ${result.exitCode}');
        print('❌ Stderr: ${result.stderr}');
        return {
          'success': false,
          'output': {
            'error': 'grpcurl command failed',
            'exitCode': result.exitCode,
            'stderr': result.stderr.toString(),
            'stdout': result.stdout.toString(),
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'grpcurl',
        };
      }
    } catch (e) {
      print('❌ Exception in createOrder: $e');
      return {
        'success': false,
        'output': {'error': 'Exception occurred', 'details': e.toString()},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'exception',
      };
    }
  }

  /// Replace an existing order using ReplaceOrderAsync gRPC method
  static Future<Map<String, dynamic>> replaceOrderAsync({
    required String oldParticipantOrderId,
    required String newParticipantOrderId,
    String? newQuantity,
    String? newPrice,
    DateTime? newExpireTime,
    String? reason,
    String refRequestId = 'flutter-replace-order',
  }) async {
    try {
      print('📋 Replacing order: $oldParticipantOrderId -> $newParticipantOrderId');

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

      // Prepare request payload
      final requestPayload = <String, dynamic>{
        'proposed_execution_id': refRequestId,
        'old_participant_order_id': oldParticipantOrderId,
        'new_participant_order_id': newParticipantOrderId,
      };

      // Add optional parameters if provided
      if (newQuantity != null && newQuantity.isNotEmpty) {
        requestPayload['new_quantity'] = newQuantity;
      }

      if (newPrice != null && newPrice.isNotEmpty) {
        requestPayload['new_price'] = newPrice;
      }

      if (reason != null && reason.isNotEmpty) {
        requestPayload['reason'] = reason;
      }

      if (newExpireTime != null) {
        // Format DateTime to Unix timestamp (seconds since epoch) for proto Time message
        final timestamp = _toUnixTimestamp(newExpireTime);
        requestPayload['new_expire_time'] = {'ts': timestamp};
      }

      final jsonPayload = jsonEncode(requestPayload);

      // Print request details
      print('📤 ReplaceOrderAsync Request:');
      print('   Old Order ID: $oldParticipantOrderId');
      print('   New Order ID: $newParticipantOrderId');
      print('   Payload: $jsonPayload');

      ProcessResult result;
      try {
        result = await Process.run(
          grpcurlPath,
          [
            '-plaintext',
            '-d', jsonPayload,
            '$_host:$_port',
            'tech.qomet.agora.api.grpc.prtagent.v1.TradingService/ReplaceOrderAsync'
          ],
        ).timeout(const Duration(seconds: 10));
      } catch (e) {
        print('❌ Process.run failed for ReplaceOrderAsync: ${e.runtimeType}: ${e.toString()}');
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
          print('✅ ReplaceOrderAsync successful for order: $oldParticipantOrderId');
        } catch (e) {
          responseData['output'] = {
            'error': 'Invalid JSON response',
            'raw_output': result.stdout.toString(),
            'details': e.toString(),
          };
          print('❌ ReplaceOrderAsync JSON parse error: $e');
        }
      } else {
        responseData['output'] = {
          'error': 'gRPC call failed',
          'stderr': result.stderr.toString(),
          'stdout': result.stdout.toString(),
          'exitCode': result.exitCode,
        };
        print('❌ ReplaceOrderAsync failed: ${result.stderr}');
      }

      return responseData;
    } catch (e) {
      print('❌ Exception in replaceOrderAsync: $e');
      return {
        'success': false,
        'output': {'error': 'Exception occurred', 'details': e.toString()},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'exception',
      };
    }
  }

  /// Cancel an existing order using CancelOrderAsync gRPC method
  static Future<Map<String, dynamic>> cancelOrderAsync({
    required String participantOrderId,
    String? reason,
    String refRequestId = 'flutter-cancel-order',
  }) async {
    try {
      print('📋 Cancelling order: $participantOrderId');

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

      // Prepare request payload
      final requestPayload = <String, dynamic>{
        'proposed_execution_id': refRequestId,
        'participant_order_id': participantOrderId,
      };

      // Add optional reason if provided
      if (reason != null && reason.isNotEmpty) {
        requestPayload['reason'] = reason;
      }

      final jsonPayload = jsonEncode(requestPayload);

      // Print request details
      print('📤 CancelOrderAsync Request:');
      print('   Order ID: $participantOrderId');
      print('   Payload: $jsonPayload');

      ProcessResult result;
      try {
        result = await Process.run(
          grpcurlPath,
          [
            '-plaintext',
            '-d', jsonPayload,
            '$_host:$_port',
            'tech.qomet.agora.api.grpc.prtagent.v1.TradingService/CancelOrderAsync'
          ],
        ).timeout(const Duration(seconds: 10));
      } catch (e) {
        print('❌ Process.run failed for CancelOrderAsync: ${e.runtimeType}: ${e.toString()}');
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
          print('✅ CancelOrderAsync successful for order: $participantOrderId');
        } catch (e) {
          responseData['output'] = {
            'error': 'Invalid JSON response',
            'raw_output': result.stdout.toString(),
            'details': e.toString(),
          };
          print('❌ CancelOrderAsync JSON parse error: $e');
        }
      } else {
        responseData['output'] = {
          'error': 'gRPC call failed',
          'stderr': result.stderr.toString(),
          'stdout': result.stdout.toString(),
          'exitCode': result.exitCode,
        };
        print('❌ CancelOrderAsync failed: ${result.stderr}');
      }

      return responseData;
    } catch (e) {
      print('❌ Exception in cancelOrderAsync: $e');
      return {
        'success': false,
        'output': {'error': 'Exception occurred', 'details': e.toString()},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'exception',
      };
    }
  }

  /// Get Orderbook using grpcurl
  static Future<Map<String, dynamic>> getOrderbook({
    required String securityIid,
    required String side, // "ORDER_SIDE__BUY" or "ORDER_SIDE__SELL"
    int pageNumber = 1,
    int pageSize = 5,
  }) async {
    final responseData = <String, dynamic>{
      'success': false,
      'output': {},
      'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
      'serverType': 'real_grpc',
    };

    try {
      print('📊 Getting orderbook for security: $securityIid, side: $side from real server...');

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
        'proposed_execution_id': 'get_orderbook_${DateTime.now().millisecondsSinceEpoch}',
        'pagination': {
          'page_nr': pageNumber,
          'page_size': pageSize,
        },
        'security_iid': securityIid,
        'orderbook_query_filter': {
          'aggregated': false,
          'side': side,
          'include_my_orders': true,
        },
        'aux_data': {
          'request_source': 'mini-Broker',
          'user_timezone': 'UTC',
        },
      };

      print('📨 GetOrderbook request: ${jsonEncode(inputParams)}');

      final result = await Process.run(
        grpcurlPath,
        [
          '-plaintext',
          '-d', jsonEncode(inputParams),
          '$_host:$_port',
          'tech.qomet.agora.api.grpc.prtagent.v1.TradingService/GetOrderbook'
        ],
        environment: {'PATH': '/usr/local/bin:/opt/homebrew/bin:${Platform.environment['PATH']}'},
      ).timeout(const Duration(seconds: 10));

      if (result.exitCode == 0) {
        final responseJson = jsonDecode(result.stdout);
        responseData['success'] = true;
        responseData['output'] = responseJson;
        print('✅ GetOrderbook successful');
      } else {
        responseData['output'] = {
          'error': 'gRPC call failed',
          'stderr': result.stderr.toString(),
          'stdout': result.stdout.toString(),
          'exit_code': result.exitCode,
        };
        print('❌ GetOrderbook failed: ${result.stderr}');
      }

      return responseData;
    } catch (e) {
      print('❌ GetOrderbook exception: $e');
      return {
        'success': false,
        'output': {'error': 'Exception occurred', 'details': e.toString()},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'exception',
      };
    }
  }

  /// Get Security Trades using grpcurl
  static Future<Map<String, dynamic>> getSecurityTrades({
    required String securityId,
    int pageNumber = 1,
    int pageSize = 15,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    final responseData = <String, dynamic>{
      'success': false,
      'output': {},
      'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
      'serverType': 'real_grpc',
    };

    try {
      print('📊 Getting security trades for: $securityId from real server...');

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
        'proposed_execution_id': 'get_trades_${DateTime.now().millisecondsSinceEpoch}',
        'pagination': {
          'page_nr': pageNumber,
          'page_size': pageSize,
        },
        'security_id_and_symbol_regexes': [securityId],
        'trade_query_filter': {
          'side': 'ORDER_SIDE__BOTH',
        },
        'aux_data': {
          'client_version': '1.0.0',
          'request_source': 'mini-Broker',
          'user_timezone': 'UTC',
        },
      };

      print('📨 GetSecurityTrades request: ${jsonEncode(inputParams)}');

      final result = await Process.run(
        grpcurlPath,
        [
          '-plaintext',
          '-d', jsonEncode(inputParams),
          '$_host:$_port',
          'tech.qomet.agora.api.grpc.prtagent.v1.SecurityService/GetSecurityTrades'
        ],
        environment: {'PATH': '/usr/local/bin:/opt/homebrew/bin:${Platform.environment['PATH']}'},
      ).timeout(const Duration(seconds: 10));

      if (result.exitCode == 0) {
        final responseJson = jsonDecode(result.stdout);
        responseData['success'] = true;
        responseData['output'] = responseJson;
        print('✅ GetSecurityTrades successful');
      } else {
        responseData['output'] = {
          'error': 'gRPC call failed',
          'stderr': result.stderr.toString(),
          'stdout': result.stdout.toString(),
          'exit_code': result.exitCode,
        };
        print('❌ GetSecurityTrades failed: ${result.stderr}');
      }

      return responseData;
    } catch (e) {
      print('❌ GetSecurityTrades exception: $e');
      return {
        'success': false,
        'output': {'error': 'Exception occurred', 'details': e.toString()},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'exception',
      };
    }
  }

  /// Get Venue List using grpcurl
  static Future<Map<String, dynamic>> getVenueList({
    String? marketIdOrSymbolRegex,
    int pageNumber = 0,
    int pageSize = 0,
  }) async {
    final responseData = <String, dynamic>{
      'success': false,
      'output': {},
      'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
      'serverType': 'real_grpc',
    };

    try {
      print('📋 Getting venue list from real server...');

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
        'proposed_execution_id': 'get_venue_list_${DateTime.now().millisecondsSinceEpoch}',
        'pagination': {
          'page_nr': pageNumber,
          'page_size': pageSize,
        },
        if (marketIdOrSymbolRegex != null && marketIdOrSymbolRegex.isNotEmpty)
          'market_id_or_symbol_regex': marketIdOrSymbolRegex,
      };

      // Log the full request
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      print('📤 GetVenueList REQUEST:');
      print('Service: tech.qomet.agora.api.grpc.prtagent.v1.VenueService/GetVenueList');
      print('Host: $_host:$_port');
      print('Request Body:');
      print(const JsonEncoder.withIndent('  ').convert(inputParams));
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

      final result = await Process.run(
        grpcurlPath,
        [
          '-plaintext',
          '-d', jsonEncode(inputParams),
          '$_host:$_port',
          'tech.qomet.agora.api.grpc.prtagent.v1.VenueService/GetVenueList'
        ],
        environment: {'PATH': '/usr/local/bin:/opt/homebrew/bin:${Platform.environment['PATH']}'},
      ).timeout(const Duration(seconds: 10));

      if (result.exitCode == 0) {
        final responseJson = jsonDecode(result.stdout);
        responseData['success'] = true;
        responseData['output'] = responseJson;

        // Log the full response
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('📥 GetVenueList RESPONSE:');
        print('Status: SUCCESS');
        print('Response Body:');
        print(const JsonEncoder.withIndent('  ').convert(responseJson));
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      } else {
        responseData['output'] = {
          'error': 'gRPC call failed',
          'stderr': result.stderr.toString(),
          'stdout': result.stdout.toString(),
          'exit_code': result.exitCode,
        };

        // Log the error response
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('📥 GetVenueList RESPONSE:');
        print('Status: FAILED');
        print('Exit Code: ${result.exitCode}');
        print('STDERR: ${result.stderr}');
        print('STDOUT: ${result.stdout}');
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('❌ GetVenueList failed: ${result.stderr}');
      }

      return responseData;
    } catch (e) {
      print('❌ GetVenueList exception: $e');
      return {
        'success': false,
        'output': {'error': 'Exception occurred', 'details': e.toString()},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'exception',
      };
    }
  }

  /// Get historical OHLC data for a symbol
  static Future<Map<String, dynamic>> getHistoricalOhlcData({
    required String symbol,
    required String period,
    int? pageSize,
  }) async {
    try {
      print('📊 Fetching historical OHLC data for $symbol, period: $period');

      // Find grpcurl path
      final grpcurlPath = await _findGrpcurlPath();
      if (grpcurlPath == null) {
        print('❌ grpcurl not found - cannot fetch OHLC data');
        return {
          'success': false,
          'output': {'error': 'grpcurl not available'},
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'grpcurl_unavailable',
        };
      }

      // Build request
      final requestData = {
        'securityIdAndSymbolRegexes': [symbol],
        'period': period,
        'includeVolume': true,
      };

      if (pageSize != null) {
        requestData['pagination'] = {
          'pageSize': pageSize,
        };
      }

      final requestJson = json.encode(requestData);

      // Log the request
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      print('📤 GetHistoricalOhlcData REQUEST:');
      print('Symbol: $symbol');
      print('Period: $period');
      print('Page Size: $pageSize');
      print('Request Body:');
      print(const JsonEncoder.withIndent('  ').convert(requestData));
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

      // Execute grpcurl command
      final result = await Process.run(
        grpcurlPath,
        [
          '-plaintext',
          '-d',
          requestJson,
          '$_host:$_port',
          'tech.qomet.agora.api.grpc.prtagent.v1.TradingService/GetHistoricalOhlcData',
        ],
        runInShell: false,
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('GetHistoricalOhlcData timed out');
        },
      );

      final Map<String, dynamic> responseData = {
        'success': result.exitCode == 0,
        'output': result.exitCode == 0 ? json.decode(result.stdout) : {'error': result.stderr},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'real',
      };

      if (result.exitCode == 0) {
        final responseJson = json.decode(result.stdout);
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('📥 GetHistoricalOhlcData RESPONSE:');
        print('Status: SUCCESS');
        print('Exit Code: 0');

        // Check if we have ohlcDatas
        if (responseJson['ohlcDatas'] != null) {
          final ohlcList = responseJson['ohlcDatas'] as List;
          print('OHLC Data Count: ${ohlcList.length}');

          // Print first few items as sample
          if (ohlcList.isNotEmpty) {
            print('\nSample OHLC Data (first 3):');
            for (int i = 0; i < (ohlcList.length > 3 ? 3 : ohlcList.length); i++) {
              print('  [$i]: ${const JsonEncoder.withIndent('    ').convert(ohlcList[i])}');
            }
          } else {
            print('⚠️  WARNING: ohlcDatas array is EMPTY!');
          }
        } else {
          print('⚠️  WARNING: No ohlcDatas field in response!');
        }

        print('\nFull Response:');
        print(const JsonEncoder.withIndent('  ').convert(responseJson));
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      } else {
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('📥 GetHistoricalOhlcData RESPONSE:');
        print('Status: FAILED');
        print('Exit Code: ${result.exitCode}');
        print('STDERR: ${result.stderr}');
        print('STDOUT: ${result.stdout}');
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      }

      return responseData;
    } catch (e) {
      print('❌ GetHistoricalOhlcData exception: $e');
      return {
        'success': false,
        'output': {'error': 'Exception occurred', 'details': e.toString()},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'exception',
      };
    }
  }
}