import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../config/app_config.dart';

/// Helper class to make gRPC calls using system grpcurl command
/// This ensures we get real responses from your server
///
/// Available services on server:
/// - AgentService: Ping
/// - CashTokenService: GetCashTokenList, GetCashTokenInfoBatch
/// - InvestorService: NewInvestor, GetInvestorList, GetInvestorCashHoldings,
///   GetInvestorSecurityHoldings, GetInvestorOrders, GetInvestorTrades,
///   GetInvestorSettlements, GetInvestorTransactions, DepositCash, WithdrawCash,
///   DepositSecurity, WithdrawSecurity, ActivateVenueForInvestor
/// - VenueService: GetVenueList, GetVenueCalendar
/// - MarketService: GetMarketList
/// - SecurityListingService: GetSecurityListingList, GetSecurityListingInfoBatch,
///   GetSecurityListingOrders, GetSecurityListingTrades, GetSecurityListingSettlements
class GrpcurlHelper {

  /// Convert DateTime to Unix timestamp (seconds since epoch)
  static int _toUnixTimestamp(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch ~/ 1000;
  }
  static String get _host => AppConfig.grpcHost;
  static int get _port => AppConfig.grpcPort;

  // Prevent concurrent operations to avoid race conditions and crashes
  static bool _isPingInProgress = false;
  static bool _isInvestorOperationInProgress = false;
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


  // ============================================================================
  // Centralized gRPC Call Executor
  // ============================================================================

  /// Centralized helper to execute grpcurl calls with consistent configuration
  /// Handles: API key, host/port, timeouts, logging, error handling, and retries
  static Future<Map<String, dynamic>> _executeGrpcCall({
    required String method,
    required String endpoint,
    required Map<String, dynamic> requestBody,
    Duration timeout = const Duration(minutes: 5),
    bool enableRetry = false,
    int maxRetries = 3,
  }) async {
    try {
      // Find grpcurl path with adequate timeout
      print('🔍 Looking for grpcurl executable for $method...');
      final grpcurlPath = await _findGrpcurlPath().timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          print('⏰ grpcurl path finder timed out for $method');
          return null;
        },
      );

      if (grpcurlPath == null) {
        print('❌ No grpcurl path found for $method');
        return {
          'input': requestBody,
          'output': {
            'error': 'grpcurl command not available',
            'message': 'Unable to locate grpcurl executable. Ensure grpcurl is installed.',
          },
          'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
          'serverType': 'grpcurl-unavailable',
          'success': false,
        };
      }

      // Build grpcurl arguments with API key header
      final useSecure = AppConfig.grpcUseSecure;
      final args = <String>[];
      if (useSecure) {
        args.add('-insecure'); // Skip CA chain verification for TLS
      } else {
        args.add('-plaintext');
      }
      final headers = <String, String>{};
      final apiKey = AppConfig.grpcApiKey;
      if (apiKey != null && apiKey.isNotEmpty) {
        args.addAll(['-H', 'x-agora-participant-api-key: $apiKey']);
        headers['x-agora-participant-api-key'] = apiKey;
      }

      final jsonRequest = jsonEncode(requestBody);
      final fullEndpoint = 'tech.qomet.agora.api.grpc.prtagent.v1.$endpoint';
      args.addAll(['-d', jsonRequest, '$_host:$_port', fullEndpoint]);

      // Log the request
      _logRequest(
        method: method,
        endpoint: fullEndpoint,
        args: args,
        body: jsonRequest,
        headers: headers,
      );

      // Execute with optional retry logic
      final retryDelays = [const Duration(seconds: 2), const Duration(seconds: 4), const Duration(seconds: 8)];
      final attempts = enableRetry ? maxRetries + 1 : 1;

      for (var attempt = 0; attempt < attempts; attempt++) {
        try {
          final stopwatch = Stopwatch()..start();
          final result = await Process.run(
            grpcurlPath,
            args,
            environment: {'PATH': '/usr/local/bin:/opt/homebrew/bin:${Platform.environment['PATH']}'},
          ).timeout(
            timeout,
            onTimeout: () {
              stopwatch.stop();
              print('⏰ grpcurl $method timed out after ${timeout.inSeconds} seconds');
              throw TimeoutException('grpcurl $method timed out', timeout);
            },
          );
          stopwatch.stop();

          // Log the response
          _logResponse(
            method: method,
            exitCode: result.exitCode,
            stdout: result.stdout.toString(),
            stderr: result.stderr.toString(),
            duration: stopwatch.elapsed,
          );

          if (result.exitCode == 0) {
            final responseJson = result.stdout.toString().trim();
            try {
              final parsedResponse = jsonDecode(responseJson) as Map<String, dynamic>;
              return {
                'input': requestBody,
                'output': parsedResponse,
                'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
                'serverType': 'grpcurl',
                'success': true,
              };
            } catch (e) {
              return {
                'input': requestBody,
                'output': {
                  'raw_response': responseJson,
                  'parse_error': e.toString(),
                },
                'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
                'serverType': 'grpcurl',
                'success': false,
              };
            }
          } else {
            final errorStr = result.stderr.toString().toLowerCase();

            // Check if this is a retryable connection error
            if (enableRetry && attempt < maxRetries &&
                (errorStr.contains('connection refused') ||
                 errorStr.contains('connection error') ||
                 errorStr.contains('failed to dial') ||
                 errorStr.contains('transport: error while dialing'))) {
              print('🔄 Connection error on attempt ${attempt + 1}/${attempts}, waiting before retry...');

              // Clear cached path to force re-discovery
              _cachedGrpcurlPath = null;

              // Wait with exponential backoff
              await Future.delayed(retryDelays[attempt]);

              // Check server reachability before retry
              print('🔌 Checking if server is reachable before retry...');
              final serverReachable = await _isServerReachable();
              print(serverReachable ? '✅ Server is now reachable, retrying...' : '⚠️ Server still not reachable, will retry anyway...');

              continue; // Retry
            }

            // Non-retryable error or max retries exceeded
            return {
              'input': requestBody,
              'output': {
                'error': result.stderr.toString(),
                'exit_code': result.exitCode,
              },
              'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
              'serverType': 'grpcurl',
              'success': false,
            };
          }
        } on TimeoutException {
          if (enableRetry && attempt < maxRetries) {
            print('🔄 Timeout on attempt ${attempt + 1}/${attempts}, retrying...');
            await Future.delayed(retryDelays[attempt]);
            continue;
          }
          return {
            'input': requestBody,
            'output': {
              'error': 'Request timed out',
              'message': '$method request timed out after ${timeout.inSeconds} seconds.',
            },
            'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
            'serverType': 'timeout',
            'success': false,
          };
        }
      }

      // Should not reach here
      return {
        'input': requestBody,
        'output': {
          'error': 'Max retries exceeded',
          'message': 'Failed after $attempts attempts.',
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'retry-exhausted',
        'success': false,
      };
    } catch (e, stack) {
      print('❌ $method exception: $e');
      print('Stack: $stack');
      return {
        'input': requestBody,
        'output': {
          'error': 'Exception occurred',
          'message': e.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'exception',
        'success': false,
      };
    }
  }

  // ============================================================================
  // Path Finding and Server Detection
  // ============================================================================

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
          final testArgs = AppConfig.grpcUseSecure
              ? ['-insecure', '$_host:$_port', 'list']
              : ['-plaintext', '$_host:$_port', 'list'];
          result = await Process.run(
            path,
            testArgs,
          ).timeout(
            const Duration(minutes: 5),
            onTimeout: () {
              print('⏰ Timeout testing $path');
              throw TimeoutException('Command timed out', const Duration(minutes: 5));
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

  // ============================================================================
  // AgentService Methods
  // ============================================================================

  /// Make a real ping call using grpcurl
  /// AgentService.Ping
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
      return await _executeGrpcCall(
        method: 'Ping',
        endpoint: 'AgentService/Ping',
        requestBody: {
          'proposed_execution_id': 'ping_${DateTime.now().millisecondsSinceEpoch}',
          'string_to_be_ponged': stringToBePonged,
        },
        timeout: const Duration(minutes: 5),
      );
    } finally {
      _isPingInProgress = false;
    }
  }

  // ============================================================================
  // InvestorService Methods
  // ============================================================================

  /// Make a real NewInvestor call using grpcurl
  /// InvestorService.NewInvestor
  static Future<Map<String, dynamic>> newInvestor({
    required String externalInvestorId,
    String? auxData,
  }) async {
    // Prevent concurrent investor calls to avoid crashes
    if (_isInvestorOperationInProgress) {
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

    _isInvestorOperationInProgress = true;
    try {
      return await _executeGrpcCall(
        method: 'NewInvestor',
        endpoint: 'InvestorService/NewInvestor',
        requestBody: {
          'proposed_execution_id': 'new_investor_${DateTime.now().millisecondsSinceEpoch}',
          'external_investor_id': externalInvestorId,
          'aux_data': {
            'source': 'flutter_app',
            'created_at': auxData ?? 'Created from Flutter signup',
          },
        },
        timeout: const Duration(minutes: 5),
        enableRetry: false,
      );
    } finally {
      _isInvestorOperationInProgress = false;
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

  /// Get investor list using grpcurl
  /// InvestorService.GetInvestorList
  static Future<Map<String, dynamic>> getInvestorList({
    int pageNumber = 0,
    int pageSize = 0,
    String? investorIdRegex,
    Map<String, String>? auxData,
  }) async {
    print('📋 Getting investor list...');

    final requestBody = <String, dynamic>{
      'proposed_execution_id': 'get_investor_list_${DateTime.now().millisecondsSinceEpoch}',
      'pagination': {
        'page_nr': pageNumber,
        'page_size': pageSize,
      },
    };

    if (investorIdRegex != null && investorIdRegex.isNotEmpty) {
      requestBody['investor_iid_or_external_id_regex'] = investorIdRegex;
    }
    if (auxData != null && auxData.isNotEmpty) {
      requestBody['aux_data'] = auxData;
    }

    return _executeGrpcCall(
      method: 'GetInvestorList',
      endpoint: 'InvestorService/GetInvestorList',
      requestBody: requestBody,
    );
  }

  /// Legacy alias for getInvestorList (backwards compatibility)
  static Future<Map<String, dynamic>> getAccountList({
    int pageNumber = 0,
    int pageSize = 0,
    String? accountIdRegex,
    Map<String, String>? auxData,
  }) => getInvestorList(
    pageNumber: pageNumber,
    pageSize: pageSize,
    investorIdRegex: accountIdRegex,
    auxData: auxData,
  );

  /// Get investor cash holdings using grpcurl
  /// InvestorService.GetInvestorCashHoldings
  static Future<Map<String, dynamic>> getInvestorCashHoldings({
    required String investorId,
    List<String>? currencyCodes,
  }) async {
    print('📋 Getting cash holdings for investor: $investorId');

    return _executeGrpcCall(
      method: 'GetInvestorCashHoldings',
      endpoint: 'InvestorService/GetInvestorCashHoldings',
      requestBody: {
        'proposed_execution_id': 'get_investor_cash_holdings_${DateTime.now().millisecondsSinceEpoch}',
        'investor_iid': investorId,
        if (currencyCodes != null && currencyCodes.isNotEmpty)
          'currency_codes': currencyCodes,
      },
    );
  }

  /// Legacy alias for getInvestorCashHoldings (backwards compatibility)
  static Future<Map<String, dynamic>> getAccountCashHoldings({
    required String accountId,
    List<String>? cashSecurityIds,
  }) => getInvestorCashHoldings(
    investorId: accountId,
    currencyCodes: cashSecurityIds,
  );

  /// Get investor security holdings using grpcurl
  /// InvestorService.GetInvestorSecurityHoldings
  static Future<Map<String, dynamic>> getInvestorSecurityHoldings({
    required String investorId,
    String? venueId,
  }) async {
    print('📋 Getting security holdings for investor: $investorId');

    return _executeGrpcCall(
      method: 'GetInvestorSecurityHoldings',
      endpoint: 'InvestorService/GetInvestorSecurityHoldings',
      requestBody: {
        'proposed_execution_id': 'get_investor_security_holdings_${DateTime.now().millisecondsSinceEpoch}',
        'investor_iid': investorId,
        if (venueId != null && venueId.isNotEmpty)
          'venue_iid': venueId,
      },
    );
  }

  /// Legacy alias for getInvestorSecurityHoldings (backwards compatibility)
  static Future<Map<String, dynamic>> getAccountMarketPortfolio({
    required String accountId,
    String? marketId,
    List<String>? securityIds,
  }) => getInvestorSecurityHoldings(
    investorId: accountId,
    venueId: marketId,
  );

  /// Get investor orders using grpcurl
  /// InvestorService.GetInvestorOrders
  static Future<Map<String, dynamic>> getInvestorOrders({
    required String investorId,
    String refRequestId = 'flutter-get-orders',
    List<String>? venueIdOrSymbolRegexes,
    Map<String, dynamic>? pagination,
    String? fromTime,
    String? toTime,
    String? side,
    List<bool>? statusFilters,
  }) async {
    print('📋 Getting orders for investor: $investorId');

    final requestBody = <String, dynamic>{
      'proposed_execution_id': refRequestId,
      'investor_iid': investorId,
    };

    if (venueIdOrSymbolRegexes != null && venueIdOrSymbolRegexes.isNotEmpty) {
      requestBody['venue_id_or_symbol_regexes'] = venueIdOrSymbolRegexes;
    }
    if (pagination != null) {
      requestBody['pagination'] = pagination;
    }

    // Build order_query_filter
    final orderQueryFilter = <String, dynamic>{};
    if (fromTime != null) {
      try {
        final parsed = jsonDecode(fromTime);
        if (parsed is Map<String, dynamic>) orderQueryFilter['from_dt'] = parsed;
      } catch (_) {}
    }
    if (toTime != null) {
      try {
        final parsed = jsonDecode(toTime);
        if (parsed is Map<String, dynamic>) orderQueryFilter['to_dt'] = parsed;
      } catch (_) {}
    }
    if (side != null) orderQueryFilter['side'] = side;
    if (statusFilters != null) orderQueryFilter['status_filters'] = statusFilters;

    if (orderQueryFilter.isNotEmpty) {
      requestBody['order_query_filter'] = orderQueryFilter;
    }

    return _executeGrpcCall(
      method: 'GetInvestorOrders',
      endpoint: 'InvestorService/GetInvestorOrders',
      requestBody: requestBody,
    );
  }

  /// Legacy alias for getInvestorOrders (backwards compatibility)
  static Future<Map<String, dynamic>> getAccountOrders({
    required String accountId,
    String refRequestId = 'flutter-get-orders',
    List<String>? marketIdOrNameRegexes,
    Map<String, dynamic>? pagination,
    String? fromTime,
    String? toTime,
    String? side,
    List<bool>? statusFilters,
  }) => getInvestorOrders(
    investorId: accountId,
    refRequestId: refRequestId,
    venueIdOrSymbolRegexes: marketIdOrNameRegexes,
    pagination: pagination,
    fromTime: fromTime,
    toTime: toTime,
    side: side,
    statusFilters: statusFilters,
  );

  /// Get investor trades using grpcurl
  /// InvestorService.GetInvestorTrades
  static Future<Map<String, dynamic>> getInvestorTrades({
    required String investorId,
    String refRequestId = 'flutter-get-trades',
    List<String>? venueIdOrSymbolRegexes,
    Map<String, dynamic>? pagination,
    String? fromTime,
    String? toTime,
    String? side,
    List<String>? securityIdOrSymbolRegexes,
  }) async {
    print('📋 Getting trades for investor: $investorId');

    final requestBody = <String, dynamic>{
      'proposed_execution_id': refRequestId,
      'investor_iid': investorId,
    };

    if (venueIdOrSymbolRegexes != null && venueIdOrSymbolRegexes.isNotEmpty) {
      requestBody['venue_id_or_symbol_regexes'] = venueIdOrSymbolRegexes;
    }
    if (pagination != null) requestBody['pagination'] = pagination;
    if (fromTime != null) {
      try {
        final parsed = jsonDecode(fromTime);
        if (parsed is Map<String, dynamic>) requestBody['from_dt'] = parsed;
      } catch (_) {}
    }
    if (toTime != null) {
      try {
        final parsed = jsonDecode(toTime);
        if (parsed is Map<String, dynamic>) requestBody['to_dt'] = parsed;
      } catch (_) {}
    }
    if (side != null) requestBody['side'] = side;
    if (securityIdOrSymbolRegexes != null && securityIdOrSymbolRegexes.isNotEmpty) {
      requestBody['security_id_or_symbol_regexes'] = securityIdOrSymbolRegexes;
    }

    return _executeGrpcCall(
      method: 'GetInvestorTrades',
      endpoint: 'InvestorService/GetInvestorTrades',
      requestBody: requestBody,
    );
  }

  /// Legacy alias for getInvestorTrades (backwards compatibility)
  static Future<Map<String, dynamic>> getAccountTrades({
    required String accountId,
    String refRequestId = 'flutter-get-trades',
    List<String>? marketIdOrNameRegexes,
    Map<String, dynamic>? pagination,
    String? fromTime,
    String? toTime,
    String? side,
    List<String>? securityIdOrSymbolRegexes,
  }) => getInvestorTrades(
    investorId: accountId,
    refRequestId: refRequestId,
    venueIdOrSymbolRegexes: marketIdOrNameRegexes,
    pagination: pagination,
    fromTime: fromTime,
    toTime: toTime,
    side: side,
    securityIdOrSymbolRegexes: securityIdOrSymbolRegexes,
  );

  /// Get investor settlements using grpcurl
  /// InvestorService.GetInvestorSettlements
  static Future<Map<String, dynamic>> getInvestorSettlements({
    required String investorId,
    String refRequestId = 'flutter-get-settlements',
    List<String>? marketIdOrNameRegexes,
    Map<String, dynamic>? pagination,
    String? fromTime,
    String? toTime,
    String? status,
    List<String>? securityIdOrNameRegexes,
  }) async {
    print('📋 Getting settlements for investor: $investorId');

    final requestBody = <String, dynamic>{
      'proposed_execution_id': refRequestId,
      'investor_iid': investorId,
    };

    if (marketIdOrNameRegexes != null && marketIdOrNameRegexes.isNotEmpty) {
      requestBody['market_id_or_name_regexes'] = marketIdOrNameRegexes;
    }
    if (pagination != null) requestBody['pagination'] = pagination;
    if (fromTime != null) {
      try {
        final parsed = jsonDecode(fromTime);
        if (parsed is Map<String, dynamic>) requestBody['from_dt'] = parsed;
      } catch (_) {}
    }
    if (toTime != null) {
      try {
        final parsed = jsonDecode(toTime);
        if (parsed is Map<String, dynamic>) requestBody['to_dt'] = parsed;
      } catch (_) {}
    }
    if (status != null) requestBody['status'] = status;
    if (securityIdOrNameRegexes != null && securityIdOrNameRegexes.isNotEmpty) {
      requestBody['asset_id_or_name_regexes'] = securityIdOrNameRegexes;
    }

    return _executeGrpcCall(
      method: 'GetInvestorSettlements',
      endpoint: 'InvestorService/GetInvestorSettlements',
      requestBody: requestBody,
    );
  }

  /// Legacy alias for getInvestorSettlements (backwards compatibility)
  static Future<Map<String, dynamic>> getAccountSettlements({
    required String accountId,
    String refRequestId = 'flutter-get-settlements',
    List<String>? marketIdOrNameRegexes,
    Map<String, dynamic>? pagination,
    String? fromTime,
    String? toTime,
    String? status,
    List<String>? securityIdOrNameRegexes,
  }) => getInvestorSettlements(
    investorId: accountId,
    refRequestId: refRequestId,
    marketIdOrNameRegexes: marketIdOrNameRegexes,
    pagination: pagination,
    fromTime: fromTime,
    toTime: toTime,
    status: status,
    securityIdOrNameRegexes: securityIdOrNameRegexes,
  );

  /// Get investor transactions using grpcurl
  /// InvestorService.GetInvestorTransactions
  static Future<Map<String, dynamic>> getInvestorTransactions({
    required String investorId,
    String refRequestId = 'flutter-get-transactions',
    Map<String, dynamic>? pagination,
    String? fromTime,
    String? toTime,
    List<String>? transactionTypes,
    List<String>? securityIdOrNameRegexes,
  }) async {
    print('📋 Getting transactions for investor: $investorId');

    final requestBody = <String, dynamic>{
      'proposed_execution_id': refRequestId,
      'investor_iid': investorId,
    };

    if (pagination != null) requestBody['pagination'] = pagination;
    if (fromTime != null) {
      try {
        final parsed = jsonDecode(fromTime);
        if (parsed is Map<String, dynamic>) requestBody['from_dt'] = parsed;
      } catch (_) {}
    }
    if (toTime != null) {
      try {
        final parsed = jsonDecode(toTime);
        if (parsed is Map<String, dynamic>) requestBody['to_dt'] = parsed;
      } catch (_) {}
    }
    if (transactionTypes != null && transactionTypes.isNotEmpty) {
      requestBody['transaction_types'] = transactionTypes;
    }
    if (securityIdOrNameRegexes != null && securityIdOrNameRegexes.isNotEmpty) {
      requestBody['asset_id_or_name_regexes'] = securityIdOrNameRegexes;
    }

    return _executeGrpcCall(
      method: 'GetInvestorTransactions',
      endpoint: 'InvestorService/GetInvestorTransactions',
      requestBody: requestBody,
    );
  }

  /// Deposit cash to an investor using grpcurl
  /// InvestorService.DepositCash
  static Future<Map<String, dynamic>> depositCash({
    required String investorId,
    required String currencyCode,
    required String amount,
    Map<String, String>? auxData,
  }) async {
    print('💰 Depositing $amount $currencyCode to investor: $investorId');

    return _executeGrpcCall(
      method: 'DepositCash',
      endpoint: 'InvestorService/DepositCash',
      requestBody: {
        'proposed_execution_id': 'deposit_cash_${DateTime.now().millisecondsSinceEpoch}',
        'investor_iid': investorId,
        'currency_code': currencyCode,
        'amount': amount,
        'aux_data': auxData ?? {
          'source': 'flutter_app',
          'transaction_type': 'deposit',
        },
      },
    );
  }

  /// Withdraw cash from an investor using grpcurl
  /// InvestorService.WithdrawCash
  static Future<Map<String, dynamic>> withdrawCash({
    required String investorId,
    required String currencyCode,
    required String amount,
    Map<String, String>? auxData,
  }) async {
    print('💸 Withdrawing $amount $currencyCode from investor: $investorId');

    return _executeGrpcCall(
      method: 'WithdrawCash',
      endpoint: 'InvestorService/WithdrawCash',
      requestBody: {
        'proposed_execution_id': 'withdraw_cash_${DateTime.now().millisecondsSinceEpoch}',
        'investor_iid': investorId,
        'currency_code': currencyCode,
        'amount': amount,
        'aux_data': auxData ?? {
          'source': 'flutter_app',
          'transaction_type': 'withdrawal',
        },
      },
    );
  }

  /// Activate a venue for an investor using grpcurl
  /// InvestorService.ActivateVenueForInvestor
  static Future<Map<String, dynamic>> activateVenueForInvestor({
    required String investorId,
    required String venueId,
  }) async {
    print('🏢 Activating venue $venueId for investor: $investorId');

    return _executeGrpcCall(
      method: 'ActivateVenueForInvestor',
      endpoint: 'InvestorService/ActivateVenueForInvestor',
      requestBody: {
        'proposed_execution_id': 'activate_venue_${DateTime.now().millisecondsSinceEpoch}',
        'investor_iid': investorId,
        'venue_iid': venueId,
      },
    );
  }

  // ============================================================================
  // VenueService Methods
  // ============================================================================

  /// Get venue list using grpcurl
  /// VenueService.GetVenueList
  static Future<Map<String, dynamic>> getVenueList({
    int pageNumber = 0,
    int pageSize = 0,
    String? venueIdOrSymbolRegex,
    String? marketIdOrSymbolRegex,
  }) async {
    print('📋 Getting venue list from real server...');

    final requestBody = <String, dynamic>{
      'proposed_execution_id': 'get_venue_list_${DateTime.now().millisecondsSinceEpoch}',
      'pagination': {
        'page_nr': pageNumber,
        'page_size': pageSize,
      },
    };

    if (marketIdOrSymbolRegex != null && marketIdOrSymbolRegex.isNotEmpty) {
      requestBody['market_id_or_symbol_regex'] = marketIdOrSymbolRegex;
    }

    if (venueIdOrSymbolRegex != null && venueIdOrSymbolRegex.isNotEmpty) {
      requestBody['venue_id_or_symbol_regex'] = venueIdOrSymbolRegex;
    }

    return _executeGrpcCall(
      method: 'GetVenueList',
      endpoint: 'VenueService/GetVenueList',
      requestBody: requestBody,
    );
  }

  // ============================================================================
  // MarketService Methods
  // ============================================================================

  /// Get market list using grpcurl
  /// MarketService.GetMarketList
  static Future<Map<String, dynamic>> getMarketList({
    int pageNumber = 0,
    int pageSize = 0,
    String? marketIdOrSymbolRegex,
  }) async {
    print('📋 Getting market list from real server...');

    final requestBody = <String, dynamic>{
      'proposed_execution_id': 'get_market_list_${DateTime.now().millisecondsSinceEpoch}',
      'pagination': {
        'page_nr': pageNumber,
        'page_size': pageSize,
      },
    };

    if (marketIdOrSymbolRegex != null && marketIdOrSymbolRegex.isNotEmpty) {
      requestBody['market_id_or_symbol_regex'] = marketIdOrSymbolRegex;
    }

    return _executeGrpcCall(
      method: 'GetMarketList',
      endpoint: 'MarketService/GetMarketList',
      requestBody: requestBody,
    );
  }

  // ============================================================================
  // SecurityListingService Methods
  // ============================================================================

  /// Get security listing list using grpcurl
  /// SecurityListingService.GetSecurityListingList
  static Future<Map<String, dynamic>> getSecurityListingList({
    int pageNumber = 0,
    int pageSize = 0,
    String? symbolRegex,
    String? securityIdRegex,
    String? securityExchangeRegex,
  }) async {
    print('📋 Getting security listing list from real server...');

    final requestBody = <String, dynamic>{
      'proposed_execution_id': 'get_security_listing_list_${DateTime.now().millisecondsSinceEpoch}',
      'pagination': {
        'page_nr': pageNumber,
        'page_size': pageSize,
      },
    };

    if (symbolRegex != null && symbolRegex.isNotEmpty) {
      requestBody['symbol_regex'] = symbolRegex;
    }
    if (securityIdRegex != null && securityIdRegex.isNotEmpty) {
      requestBody['security_id_regex'] = securityIdRegex;
    }
    if (securityExchangeRegex != null && securityExchangeRegex.isNotEmpty) {
      requestBody['security_exchange_regex'] = securityExchangeRegex;
    }

    return _executeGrpcCall(
      method: 'GetSecurityListingList',
      endpoint: 'SecurityListingService/GetSecurityListingList',
      requestBody: requestBody,
    );
  }

  /// Get security listing info batch using grpcurl
  /// SecurityListingService.GetSecurityListingInfoBatch
  static Future<Map<String, dynamic>> getSecurityListingInfoBatch({
    required List<String> symbolAndSecurityIdRegexes,
  }) async {
    print('📋 Getting security listing info for: $symbolAndSecurityIdRegexes');

    return _executeGrpcCall(
      method: 'GetSecurityListingInfoBatch',
      endpoint: 'SecurityListingService/GetSecurityListingInfoBatch',
      requestBody: {
        'proposed_execution_id': 'get_security_listing_info_batch_${DateTime.now().millisecondsSinceEpoch}',
        'symbol_and_security_id_regexes': symbolAndSecurityIdRegexes,
      },
    );
  }

  /// Legacy alias: getSecurityList now calls SecurityListingService
  static Future<Map<String, dynamic>> getSecurityList({
    int pageNumber = 0,
    int pageSize = 0,
    String? securityIdOrIdentifierRegex,
  }) => getSecurityListingList(
    pageNumber: pageNumber,
    pageSize: pageSize,
    symbolRegex: securityIdOrIdentifierRegex,
  );

  // ============================================================================
  // CashTokenService Methods
  // ============================================================================

  /// Get cash token list using grpcurl
  /// CashTokenService.GetCashTokenList
  static Future<Map<String, dynamic>> getCashTokenList({
    int pageNumber = 0,
    int pageSize = 0,
  }) async {
    print('📋 Getting cash token list...');

    return _executeGrpcCall(
      method: 'GetCashTokenList',
      endpoint: 'CashTokenService/GetCashTokenList',
      requestBody: {
        'proposed_execution_id': 'get_cash_token_list_${DateTime.now().millisecondsSinceEpoch}',
        'pagination': {
          'page_nr': pageNumber,
          'page_size': pageSize,
        },
      },
    );
  }

  /// Get cash token info batch using grpcurl
  /// CashTokenService.GetCashTokenInfoBatch
  static Future<Map<String, dynamic>> getCashTokenInfoBatch({
    required List<String> cashTokenIds,
  }) async {
    print('📋 Getting cash token info for: $cashTokenIds');

    return _executeGrpcCall(
      method: 'GetCashTokenInfoBatch',
      endpoint: 'CashTokenService/GetCashTokenInfoBatch',
      requestBody: {
        'proposed_execution_id': 'get_cash_token_info_batch_${DateTime.now().millisecondsSinceEpoch}',
        'cash_token_iid_and_identifier_regexes': cashTokenIds,
      },
    );
  }

  // ============================================================================
  // TradingService Methods
  // ============================================================================

  /// Get historical OHLC data for a security
  /// TradingService.GetHistoricalOhlcData
  static Future<Map<String, dynamic>> getHistoricalOhlcData({
    required String symbol,
    required String period,
    int pageSize = 0,
  }) async {
    print('📊 Getting historical OHLC data for symbol: $symbol, period: $period');

    // Calculate from_ts based on period
    final now = DateTime.now();
    DateTime fromDt;
    switch (period) {
      case '1m':
      case '5m':
      case '15m':
        fromDt = now.subtract(const Duration(days: 1));
        break;
      case '1h':
        fromDt = now.subtract(const Duration(days: 7));
        break;
      case '4h':
        fromDt = now.subtract(const Duration(days: 30));
        break;
      case '1d':
        fromDt = now.subtract(const Duration(days: 365));
        break;
      case '1w':
        fromDt = now.subtract(const Duration(days: 730));
        break;
      default:
        fromDt = now.subtract(const Duration(days: 30));
    }
    final fromTs = (fromDt.millisecondsSinceEpoch ~/ 1000).toString();
    final toTs = (now.millisecondsSinceEpoch ~/ 1000).toString();

    return _executeGrpcCall(
      method: 'GetHistoricalOhlcData',
      endpoint: 'TradingService/GetHistoricalOhlcData',
      requestBody: {
        'proposed_execution_id': 'get_historical_ohlc_${DateTime.now().millisecondsSinceEpoch}',
        'pagination': {
          'page_nr': 1,
          'page_size': pageSize,
        },
        'security_listing_iid_or_symbol_regexes': [symbol],
        'period': period,
        'aux_data': {
          'from_ts': fromTs,
          'to_ts': toTs,
        },
        'include_volume': true,
      },
    );
  }

  /// Get orderbook for a security
  /// TradingService.GetOrderbook
  static Future<Map<String, dynamic>> getOrderbook({
    required String securityIid,
    String? side,
    int pageNumber = 1,
    int pageSize = 10,
    String? mode,
  }) async {
    print('📋 Getting orderbook for security: $securityIid, side: $side, mode: $mode');

    final requestBody = <String, dynamic>{
      'proposed_execution_id': 'get_orderbook_${DateTime.now().millisecondsSinceEpoch}',
      'pagination': {
        'page_nr': pageNumber,
        'page_size': pageSize,
      },
      'security_listing_iid': securityIid,
    };

    if (side != null && side.isNotEmpty) {
      requestBody['orderbook_query_filter'] = {
        'side': side,
      };
    }

    if (mode != null && mode.isNotEmpty) {
      requestBody['mode'] = mode;
    }

    return _executeGrpcCall(
      method: 'GetOrderbook',
      endpoint: 'TradingService/GetOrderbook',
      requestBody: requestBody,
    );
  }

  /// Cancel an order asynchronously
  /// TradingService.CancelOrderAsync
  static Future<Map<String, dynamic>> cancelOrderAsync({
    required String participantOrderId,
    String? reason,
    String refRequestId = 'flutter-cancel-order',
  }) async {
    print('❌ Cancelling order: $participantOrderId');

    return _executeGrpcCall(
      method: 'CancelOrderAsync',
      endpoint: 'TradingService/CancelOrderAsync',
      requestBody: {
        'proposed_execution_id': refRequestId,
        'participant_order_id': participantOrderId,
        'reason': reason ?? 'User requested cancellation',
      },
    );
  }

  /// Replace an order asynchronously
  /// TradingService.ReplaceOrderAsync
  static Future<Map<String, dynamic>> replaceOrderAsync({
    required String oldParticipantOrderId,
    required String newParticipantOrderId,
    String? newQuantity,
    String? newPrice,
    DateTime? newExpireTime,
    String? reason,
    String refRequestId = 'flutter-replace-order',
  }) async {
    print('🔄 Replacing order: $oldParticipantOrderId -> $newParticipantOrderId');

    final requestBody = <String, dynamic>{
      'proposed_execution_id': refRequestId,
      'old_participant_order_id': oldParticipantOrderId,
      'new_participant_order_id': newParticipantOrderId,
    };

    if (newQuantity != null) {
      requestBody['new_quantity'] = newQuantity;
    }
    if (newPrice != null) {
      requestBody['new_price'] = newPrice;
    }
    if (newExpireTime != null) {
      requestBody['new_expire_time'] = {
        'hmss': {
          'hour': newExpireTime.hour,
          'minute': newExpireTime.minute,
          'second': newExpireTime.second,
        },
      };
    }
    if (reason != null) {
      requestBody['reason'] = reason;
    }

    return _executeGrpcCall(
      method: 'ReplaceOrderAsync',
      endpoint: 'TradingService/ReplaceOrderAsync',
      requestBody: requestBody,
    );
  }

  /// Create an order asynchronously
  /// TradingService.CreateOrderAsync
  static Future<Map<String, dynamic>> createOrderAsync({
    required String accountIid,
    required String feePayerAccountIid,
    required String securityListingIid,
    required String orderType,
    required String side,
    required String quantity,
    required String price,
    String timeInForce = '0',
    required String participantOrderIid,
    DateTime? expireTime,
    String? currency,
    String? feeAmount,
    Map<String, String>? auxData,
  }) async {
    print('📝 Creating order: $side $quantity @ $price for $securityListingIid');

    // Map side string to proto enum value
    String sideEnum;
    switch (side.toUpperCase()) {
      case 'BUY':
        sideEnum = 'ORDER_SIDE_ENUM_BUY';
        break;
      case 'SELL':
        sideEnum = 'ORDER_SIDE_ENUM_SELL';
        break;
      default:
        sideEnum = 'ORDER_SIDE_ENUM_UNKNOWN';
    }

    final requestBody = <String, dynamic>{
      'proposed_execution_id': 'create_order_${DateTime.now().millisecondsSinceEpoch}',
      'account_iid': accountIid,
      'fee_payer_account_iid': feePayerAccountIid,
      'security_listing_iid': securityListingIid,
      'order_type': orderType,
      'side': sideEnum,
      'quantity': quantity,
      'price': price,
      'time_in_force': timeInForce,
      'participant_order_iid': participantOrderIid,
    };

    requestBody['expire_dt'] = {
      'utc_unix_epoch_ts_millis': expireTime != null
          ? expireTime.millisecondsSinceEpoch.toString()
          : '0',
    };
    if (currency != null && currency.isNotEmpty) {
      requestBody['currency'] = currency;
    }
    if (feeAmount != null && feeAmount.isNotEmpty) {
      requestBody['fee_amount'] = feeAmount;
    }
    if (auxData != null) {
      requestBody['aux_data'] = auxData;
    }

    return _executeGrpcCall(
      method: 'CreateOrderAsync',
      endpoint: 'TradingService/CreateOrderAsync',
      requestBody: requestBody,
    );
  }

  /// Get execution reports for an order
  /// TradingService.GetOrderExecutionReports
  static Future<Map<String, dynamic>> getOrderExecutionReports({
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
    print('📋 Getting execution reports for requestId: $requestId');

    final requestBody = <String, dynamic>{
      'proposed_execution_id': 'get_exec_reports_${DateTime.now().millisecondsSinceEpoch}',
      'request_id': requestId,
      'pagination': {
        'page_nr': pageNumber,
        'page_size': pageSize,
      },
    };

    if (symbolFilter != null && symbolFilter.isNotEmpty) {
      requestBody['symbol_filter'] = symbolFilter;
    }
    if (currencyFilter != null && currencyFilter.isNotEmpty) {
      requestBody['currency_filter'] = currencyFilter;
    }
    if (execTypeFilter != null && execTypeFilter.isNotEmpty) {
      requestBody['exec_type_filter'] = execTypeFilter;
    }
    if (fromDate != null && fromDate.isNotEmpty) {
      requestBody['from_date'] = fromDate;
    }
    if (toDate != null && toDate.isNotEmpty) {
      requestBody['to_date'] = toDate;
    }
    if (sortBy != null && sortBy.isNotEmpty) {
      requestBody['sort_by'] = sortBy;
    }
    if (sortDirection != null && sortDirection.isNotEmpty) {
      requestBody['sort_direction'] = sortDirection;
    }

    return _executeGrpcCall(
      method: 'GetOrderExecutionReports',
      endpoint: 'TradingService/GetOrderExecutionReports',
      requestBody: requestBody,
    );
  }

  /// Get execution reports via ReportingService.GetExecutionReports
  static Future<Map<String, dynamic>> getExecutionReports({
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
    print('📋 Getting execution reports from ReportingService');

    final requestBody = <String, dynamic>{
      'proposed_execution_id': 'get_exec_reports_${DateTime.now().millisecondsSinceEpoch}',
      'pagination': {
        'page_nr': pageNumber,
        'page_size': pageSize,
      },
    };

    if (requestId != null && requestId.isNotEmpty) {
      requestBody['request_id'] = requestId;
    }
    if (symbol != null && symbol.isNotEmpty) {
      requestBody['symbol'] = symbol;
    }
    if (currency != null && currency.isNotEmpty) {
      requestBody['currency'] = currency;
    }
    if (execType != null && execType.isNotEmpty) {
      requestBody['exec_type'] = execType;
    }
    if (side != null && side.isNotEmpty) {
      requestBody['side'] = side;
    }
    if (venueIid != null && venueIid.isNotEmpty) {
      requestBody['venue_iid'] = venueIid;
    }
    if (fromDate != null && fromDate.isNotEmpty) {
      requestBody['from_date'] = fromDate;
    }
    if (toDate != null && toDate.isNotEmpty) {
      requestBody['to_date'] = toDate;
    }
    if (sortBy != null && sortBy.isNotEmpty) {
      requestBody['sort_by'] = sortBy;
    }
    if (sortDirection != null && sortDirection.isNotEmpty) {
      requestBody['sort_direction'] = sortDirection;
    }
    if (search != null && search.isNotEmpty) {
      requestBody['search'] = search;
    }

    return _executeGrpcCall(
      method: 'GetExecutionReports',
      endpoint: 'ReportingService/GetExecutionReports',
      requestBody: requestBody,
    );
  }

  // ============================================================================
  // SecurityListingService Methods
  // ============================================================================

  /// Get trades for a security listing
  /// SecurityListingService.GetSecurityListingTrades
  static Future<Map<String, dynamic>> getSecurityTrades({
    required String securityId,
    int pageNumber = 1,
    int pageSize = 50,
  }) async {
    print('📋 Getting trades for security: $securityId');

    return _executeGrpcCall(
      method: 'GetSecurityListingTrades',
      endpoint: 'SecurityListingService/GetSecurityListingTrades',
      requestBody: {
        'proposed_execution_id': 'get_security_trades_${DateTime.now().millisecondsSinceEpoch}',
        'pagination': {
          'page_nr': pageNumber,
          'page_size': pageSize,
        },
        'security_listing_iid_and_identifier_regexes': [securityId],
      },
    );
  }

  // ============================================================================
  // InvestorService - GetInvestorInfoBatch
  // ============================================================================

  /// Get investor info batch using grpcurl
  /// InvestorService.GetInvestorInfoBatch
  static Future<Map<String, dynamic>> getInvestorInfoBatch({
    required List<String> investorIids,
  }) async {
    print('📋 Getting investor info for: $investorIids');

    return _executeGrpcCall(
      method: 'GetInvestorInfoBatch',
      endpoint: 'InvestorService/GetInvestorInfoBatch',
      requestBody: {
        'proposed_execution_id': 'get_investor_info_batch_${DateTime.now().millisecondsSinceEpoch}',
        'investor_iids': investorIids,
      },
    );
  }

  // ============================================================================
  // ParticipantService Methods
  // ============================================================================

  /// Get participant info using grpcurl
  /// ParticipantService.GetParticipantInfo
  static Future<Map<String, dynamic>> getParticipantInfo() async {
    print('📋 Getting participant info from real server...');

    return _executeGrpcCall(
      method: 'GetParticipantInfo',
      endpoint: 'ParticipantService/GetParticipantInfo',
      requestBody: {
        'proposed_execution_id': 'get_participant_info_${DateTime.now().millisecondsSinceEpoch}',
      },
    );
  }

  /// Get participant holdings using grpcurl
  /// ParticipantService.GetParticipantHoldings
  static Future<Map<String, dynamic>> getParticipantHoldings({
    String? mode,
    String? issuedInstrumentIid,
  }) async {
    print('📋 Getting participant holdings from real server...');

    final requestBody = <String, dynamic>{
      'proposed_execution_id': 'get_participant_holdings_${DateTime.now().millisecondsSinceEpoch}',
    };

    if (mode != null && mode.isNotEmpty) {
      requestBody['mode'] = mode;
    }
    if (issuedInstrumentIid != null && issuedInstrumentIid.isNotEmpty) {
      requestBody['issued_instrument_iid'] = issuedInstrumentIid;
    }

    return _executeGrpcCall(
      method: 'GetParticipantHoldings',
      endpoint: 'ParticipantService/GetParticipantHoldings',
      requestBody: requestBody,
    );
  }

  // ============================================================================
  // Utility Methods
  // ============================================================================

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
        final listArgs = AppConfig.grpcUseSecure
            ? ['-insecure', '$_host:$_port', 'list']
            : ['-plaintext', '$_host:$_port', 'list'];
        result = await Process.run(
          grpcurlPath,
          listArgs,
        ).timeout(const Duration(minutes: 5));
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
}
