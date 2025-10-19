import 'dart:async';
import 'dart:io';
import 'package:grpc/grpc.dart';
import '../config/app_config.dart';
import '../generated/prtagent/v1/instrument.pbgrpc.dart';
import '../generated/prtagent/v1/account.pbgrpc.dart';
import '../generated/prtagent/v1/agent.pbgrpc.dart';
import '../generated/prtagent/v1/market.pbgrpc.dart';
import '../generated/prtagent/v1/trading.pbgrpc.dart';
import '../generated/prtagent/v1/participant.pbgrpc.dart';
import '../generated/prtagent/v1/venue.pbgrpc.dart';
import '../generated/common.pb.dart' as common;

/// Real gRPC client that uses proper Dart gRPC to communicate with the prtagent server
class RealGrpcClient {
  /// Convert DateTime to Unix timestamp (seconds since epoch)
  static int _toUnixTimestamp(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch ~/ 1000;
  }

  bool _isConnected = false;
  String _host = AppConfig.grpcHost;
  int _port = AppConfig.grpcPort;
  ClientChannel? _channel;

  // gRPC service clients
  InstrumentServiceClient? _instrumentClient;
  AccountServiceClient? _accountClient;
  AgentServiceClient? _agentClient;
  MarketServiceClient? _marketClient;
  TradingServiceClient? _tradingClient;
  ParticipantServiceClient? _participantClient;
  VenueServiceClient? _venueClient;

  // Getters
  bool get isConnected => _isConnected;
  String get currentHost => _host;
  int get currentPort => _port;

  /// Connect to the actual gRPC server
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

      // Create gRPC channel
      _channel = ClientChannel(
        host,
        port: port,
        options: ChannelOptions(
          credentials: useSecure
              ? const ChannelCredentials.secure()
              : const ChannelCredentials.insecure(),
          connectionTimeout: timeout ?? const Duration(seconds: 10),
        ),
      );

      // Initialize service clients
      _instrumentClient = InstrumentServiceClient(_channel!);
      _accountClient = AccountServiceClient(_channel!);
      _agentClient = AgentServiceClient(_channel!);
      _marketClient = MarketServiceClient(_channel!);
      _tradingClient = TradingServiceClient(_channel!);
      _participantClient = ParticipantServiceClient(_channel!);
      _venueClient = VenueServiceClient(_channel!);

      // Test actual server connectivity before marking as connected
      print('🔄 Testing server connectivity before marking as connected...');
      final testResult = await testServerConnectivity();

      if (testResult) {
        _isConnected = true;
        print('✅ gRPC client successfully connected to $host:$port');
      } else {
        _isConnected = false;
        print('⚠️ gRPC client configured for $host:$port but server is not reachable');
        // Keep clients initialized - they can still attempt reconnection later
      }
    } catch (e) {
      _isConnected = false;
      print('❌ Failed to configure gRPC client: $e');
      // DON'T throw - allow reconnection attempts later
      // The clients are still initialized and can try to connect when called
    }
  }

  /// Disconnect from the gRPC server
  Future<void> disconnect() async {
    try {
      await _channel?.shutdown();
      _channel = null;
      _instrumentClient = null;
      _accountClient = null;
      _agentClient = null;
      _marketClient = null;
      _tradingClient = null;
      _participantClient = null;
      _venueClient = null;
      _isConnected = false;
      print('✅ gRPC client disconnected');
    } catch (e) {
      print('⚠️ Error during disconnect: $e');
    }
  }

  /// Create CallOptions with API key header
  CallOptions _createCallOptions({Duration? timeout}) {
    final metadata = <String, String>{};

    // Add API key header if available
    if (AppConfig.grpcApiKey != null && AppConfig.grpcApiKey!.isNotEmpty) {
      metadata['x-agora-participant-api-key'] = AppConfig.grpcApiKey!;
    }

    return CallOptions(
      timeout: timeout ?? const Duration(seconds: 30),
      metadata: metadata,
    );
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

  /// Attempt to reconnect to the server
  /// This can be called at any time to retry connection
  Future<bool> reconnect() async {
    try {
      print('🔄 Attempting to reconnect to $_host:$_port...');

      // Test connectivity first
      final isReachable = await testServerConnectivity();

      if (isReachable) {
        _isConnected = true;
        print('✅ Reconnection successful');
        return true;
      } else {
        _isConnected = false;
        print('⚠️ Reconnection failed - server not reachable');
        return false;
      }
    } catch (e) {
      _isConnected = false;
      print('❌ Reconnection error: $e');
      return false;
    }
  }

  /// Ping call to AgentService.Ping
  Future<Map<String, dynamic>> ping({
    String stringToBePonged = 'Hello from Flutter!',
    Duration? timeout,
  }) async {
    // If not connected, try to reconnect first
    if (!_isConnected && _agentClient != null) {
      print('🔄 Not connected - attempting auto-reconnect...');
      await reconnect();
    }

    if (_agentClient == null) {
      return {
        'input': {
          'proposed_execution_id': 'ping_${DateTime.now().millisecondsSinceEpoch}',
          'string_to_be_ponged': stringToBePonged,
        },
        'output': {
          'error': 'Not initialized',
          'message': 'gRPC client not initialized. Call connect() first.',
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'not-initialized',
        'success': false,
      };
    }

    try {
      print('🏓 Ping - attempting real server connection');

      final request = PingRequest()
        ..proposedExecutionId = 'ping_${DateTime.now().millisecondsSinceEpoch}'
        ..stringToBePonged = stringToBePonged;

      final response = await _agentClient!.ping(request,
          options: _createCallOptions(timeout: timeout ?? const Duration(seconds: 10)));

      print('📬 Ping Response: ${response.pongString}');

      return {
        'input': {
          'proposed_execution_id': request.proposedExecutionId,
          'string_to_be_ponged': stringToBePonged,
        },
        'output': {
          'pong_string': response.pongString,
          'ref_execution_id': response.refExecutionId,
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'real_grpc',
        'success': true,
      };
    } catch (e) {
      print('❌ Ping failed: $e');
      // Mark as disconnected on error
      _isConnected = false;
      return {
        'input': {
          'proposed_execution_id': 'ping_${DateTime.now().millisecondsSinceEpoch}',
          'string_to_be_ponged': stringToBePonged,
        },
        'output': {
          'error': 'gRPC call failed',
          'details': e.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'grpc-error',
        'success': false,
      };
    }
  }

  /// Get Instrument List using InstrumentService.GetInstrumentList
  Future<Map<String, dynamic>> getInstrumentList({
    int pageNumber = 0,
    int pageSize = 0,
    Duration? timeout,
  }) async {
    // If not connected, try to reconnect first
    if (!_isConnected && _instrumentClient != null) {
      print('🔄 Not connected - attempting auto-reconnect...');
      await reconnect();
    }

    if (_instrumentClient == null) {
      return {
        'input': {},
        'output': {'error': 'gRPC client not initialized'},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'not-initialized',
        'success': false,
      };
    }

    try {
      print('📋 Getting instrument list from real server...');

      final request = GetInstrumentListRequest()
        ..proposedExecutionId = 'get_instrument_list_${DateTime.now().millisecondsSinceEpoch}'
        ..pagination = (common.PaginationParams()
          ..pageNr = pageNumber
          ..pageSize = pageSize
          ..cursorToken = '');

      final response = await _instrumentClient!.getInstrumentList(request,
          options: _createCallOptions(timeout: timeout ?? const Duration(seconds: 10)));

      print('✅ GetInstrumentList successful: ${response.instruments.length} instruments');

      return {
        'input': {
          'proposed_execution_id': request.proposedExecutionId,
          'pagination': {
            'page_nr': pageNumber,
            'page_size': pageSize,
          },
        },
        'output': {
          'ref_execution_id': response.refExecutionId,
          'instruments': response.instruments.map((i) => {
            'id': i.iid,
            'cfi_code': i.cfiCode,
            'issue_currency': i.issueCurrency,
            'identifiers': i.identifiers.map((id) => {
              'scheme_type': id.schemeType.toString(),
              'scheme_name': id.schemeName,
              'ids': id.ids.map((v) => v.value).toList(),
            }).toList(),
            'display_names': i.displayNames,
            'metadata': i.metadata,
          }).toList(),
          'pagination_info': response.hasPaginationInfo() ? {
            'total_count': response.paginationInfo.totalCount.toString(),
            'next_cursor_token': response.paginationInfo.nextCursorToken,
          } : null,
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'real_grpc',
        'success': true,
      };
    } catch (e) {
      print('❌ GetInstrumentList failed: $e');
      return {
        'input': {},
        'output': {
          'error': 'gRPC call failed',
          'details': e.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'grpc-error',
        'success': false,
      };
    }
  }

  /// Get Account List using AccountService.GetAccountList
  Future<Map<String, dynamic>> getAccountList({
    String? accountIdRegex,
    int pageNumber = 0,
    int pageSize = 0,
    Duration? timeout,
  }) async {
    // If not connected, try to reconnect first
    if (!_isConnected && _accountClient != null) {
      print('🔄 Not connected - attempting auto-reconnect...');
      await reconnect();
    }

    if (_accountClient == null) {
      return {
        'input': {},
        'output': {'error': 'gRPC client not initialized'},
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'not-initialized',
        'success': false,
      };
    }

    try {
      print('🔄 GetAccountList - attempting real server connection');

      final request = GetAccountListRequest()
        ..proposedExecutionId = 'get_account_list_${DateTime.now().millisecondsSinceEpoch}'
        ..pagination = (common.PaginationParams()
          ..pageNr = pageNumber
          ..pageSize = pageSize
          ..cursorToken = '');

      if (accountIdRegex != null && accountIdRegex.isNotEmpty) {
        request.accountIidOrExternalIdRegex = accountIdRegex;
      }

      final response = await _accountClient!.getAccountList(request,
          options: _createCallOptions(timeout: timeout ?? const Duration(seconds: 10)));

      print('✅ GetAccountList successful: ${response.accounts.length} accounts');

      return {
        'input': {
          'proposed_execution_id': request.proposedExecutionId,
          'account_iid_or_external_id_regex': accountIdRegex ?? '',
        },
        'output': {
          'ref_execution_id': response.refExecutionId,
          'accounts': response.accounts.map((a) => {
            'id': a.iid,
            'external_account_id': a.externalAccountId,
            'account_type': a.accountType.toString(),
            'account_status': a.accountStatus.toString(),
            'identifiers': a.identifiers.map((id) => {
              'scheme_type': id.schemeType.toString(),
              'scheme_name': id.schemeName,
              'ids': id.ids.map((v) => v.value).toList(),
            }).toList(),
          }).toList(),
          'pagination_info': response.hasPaginationInfo() ? {
            'total_count': response.paginationInfo.totalCount.toString(),
            'next_cursor_token': response.paginationInfo.nextCursorToken,
          } : null,
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'real_grpc',
        'success': true,
      };
    } catch (e) {
      print('❌ GetAccountList failed: $e');
      // Mark as disconnected on error
      _isConnected = false;
      return {
        'input': {
          'account_iid_or_external_id_regex': accountIdRegex ?? '',
        },
        'output': {
          'error': 'gRPC call failed',
          'details': e.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'grpc-error',
        'success': false,
      };
    }
  }

  // TODO: Implement remaining methods using proper Dart gRPC clients
  // For now, these are stub methods that return "not implemented" errors

  Future<Map<String, dynamic>> newAccount({required String externalAccountId, String? auxData}) async {
    return _notImplemented('newAccount');
  }

  Future<Map<String, dynamic>> getAccountOrders({
    required String accountId,
    List<String>? marketIdOrNameRegexes,
    Map<String, dynamic>? pagination,
    String? fromTime,
    String? toTime,
    String? side,
    dynamic statusFilters,
    List<String>? instrumentIdOrSymbolRegexes,
  }) async {
    return _notImplemented('getAccountOrders');
  }

  Future<Map<String, dynamic>> getAccountTrades({
    required String accountId,
    List<String>? marketIdOrNameRegexes,
    Map<String, dynamic>? pagination,
    String? fromTime,
    String? toTime,
    String? side,
    dynamic statusFilters,
    List<String>? instrumentIdOrSymbolRegexes,
  }) async {
    return _notImplemented('getAccountTrades');
  }

  Future<Map<String, dynamic>> getMarketList() async {
    return _notImplemented('getMarketList');
  }

  Future<Map<String, dynamic>> getMarketInstrumentList({required String marketId, int pageNumber = 0, int pageSize = 0}) async {
    return _notImplemented('getMarketInstrumentList');
  }

  Future<Map<String, dynamic>> getMarketSupportedCurrencies({required String marketId}) async {
    return _notImplemented('getMarketSupportedCurrencies');
  }

  Future<Map<String, dynamic>> getAccountCashHoldings({required String accountId, List<String>? cashAssetIds}) async {
    return _notImplemented('getAccountCashHoldings');
  }

  Future<Map<String, dynamic>> depositCash({required String accountId, String? currencyCode, String? assetId, required String amount}) async {
    return _notImplemented('depositCash');
  }

  Future<Map<String, dynamic>> withdrawCash({required String accountId, String? currencyCode, String? assetId, required String amount}) async {
    return _notImplemented('withdrawCash');
  }

  Future<Map<String, dynamic>> getAccountMarketPortfolio({required String accountId, String? marketId, List<String>? assetIds}) async {
    return _notImplemented('getAccountMarketPortfolio');
  }

  Future<Map<String, dynamic>> placeOrder({
    required String accountId,
    required String marketId,
    required String instrumentId,
    required String orderType,
    required String side,
    required String quantity,
    String? price,
  }) async {
    return _notImplemented('placeOrder');
  }

  Future<Map<String, dynamic>> createOrder({
    required String accountId,
    required String instrumentId,
    required String side,
    required String quantity,
    String? price,
    String? orderType,
    String? feePayerAccountId,
    String? timeInForce,
    String? participantOrderId,
  }) async {
    return _notImplemented('createOrder');
  }

  Future<Map<String, dynamic>> getSupportedCurrencies() async {
    return _notImplemented('getSupportedCurrencies');
  }

  Future<Map<String, dynamic>> getVenueList({String? marketId}) async {
    return _notImplemented('getVenueList');
  }

  Future<Map<String, dynamic>> getOrderFees({
    required String accountId,
    required String feePayerAccountId,
    required String instrumentId,
    required String orderType,
    required String side,
    required String quantity,
    String? price,
    String? timeInForce,
  }) async {
    return _notImplemented('getOrderFees');
  }

  Map<String, dynamic> _notImplemented(String methodName) {
    return {
      'input': {},
      'output': {
        'error': 'Method not yet implemented in new gRPC client',
        'details': '$methodName is not yet implemented. This method needs to be converted to use proper Dart gRPC client instead of grpcurl.',
      },
      'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
      'serverType': 'not-implemented',
      'success': false,
    };
  }
}

/// Global singleton instance of RealGrpcClient
final realGrpcClient = RealGrpcClient();