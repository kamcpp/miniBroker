import 'dart:convert';
import 'package:grpc/grpc.dart';
import 'package:protobuf/protobuf.dart';
import 'grpc_channel_manager.dart';

// Generated protobuf imports
import '../generated/prtagent/v1/agent.pb.dart';
import '../generated/prtagent/v1/participant_types.pb.dart';
import '../generated/prtagent/v1/investor.pb.dart';
import '../generated/prtagent/v1/trading.pb.dart';
import '../generated/prtagent/v1/admin.pb.dart' hide ExecutionReport;
import '../generated/prtagent/v1/market.pb.dart';
import '../generated/prtagent/v1/security_listing.pb.dart';
import '../generated/prtagent/v1/cash_token.pb.dart';
import '../generated/prtagent/v1/venue.pb.dart';
import '../generated/prtagent/v1/query.pb.dart';
import '../generated/common.pb.dart' as common_pb;
import '../generated/fin/trading.pbenum.dart' as fin_enum;

/// Helper class to make gRPC calls using native Dart gRPC clients.
/// All method signatures and return shapes are preserved.
class GrpcHelper {

  static int _toUnixTimestamp(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch ~/ 1000;
  }

  // Prevent concurrent operations to avoid race conditions
  static bool _isPingInProgress = false;
  static bool _isInvestorOperationInProgress = false;

  static GrpcChannelManager get _mgr => GrpcChannelManager.instance;

  // ============================================================================
  // Centralized Native gRPC Call Executor
  // ============================================================================

  /// Execute a native gRPC call and return the standard Map response shape.
  static Future<Map<String, dynamic>> _executeNativeCall({
    required String method,
    required Map<String, dynamic> requestBody,
    required Future<GeneratedMessage> Function() rpcCall,
  }) async {
    try {
      final stopwatch = Stopwatch()..start();
      final response = await rpcCall();
      stopwatch.stop();

      final outputMap = _protoToJsonMap(response);

      print('📥 $method response: OK (${stopwatch.elapsedMilliseconds}ms)');

      return {
        'input': requestBody,
        'output': outputMap,
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'native-grpc',
        'success': true,
      };
    } on GrpcError catch (e) {
      print('❌ $method gRPC error: code=${e.code}, message=${e.message}');
      return {
        'input': requestBody,
        'output': {
          'error': e.message ?? 'gRPC error ${e.code}',
          'code': e.code,
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'native-grpc',
        'success': false,
      };
    } catch (e) {
      print('❌ $method exception: $e');
      return {
        'input': requestBody,
        'output': {
          'error': 'Exception occurred',
          'message': e.toString(),
        },
        'requestTime': _toUnixTimestamp(DateTime.now()).toString(),
        'serverType': 'native-grpc',
        'success': false,
      };
    }
  }

  /// Convert a protobuf message to a JSON-compatible Map<String, dynamic>.
  /// Uses proto3 JSON representation (camelCase field name keys).
  /// Always roundtrips through jsonEncode/jsonDecode to ensure all nested
  /// maps are proper Map<String, dynamic> (toProto3Json returns Map<String?, Object?>).
  static Map<String, dynamic> _protoToJsonMap(GeneratedMessage message) {
    try {
      final proto3 = message.toProto3Json();
      final jsonStr = jsonEncode(proto3);
      return jsonDecode(jsonStr) as Map<String, dynamic>;
    } catch (_) {
      try {
        return message.writeToJsonMap();
      } catch (_) {
        return {'raw': message.toString()};
      }
    }
  }

  // ============================================================================
  // Connection Testing
  // ============================================================================

  /// Test if the gRPC server is reachable.
  static Future<bool> testConnection() async {
    try {
      final reachable = await _mgr.testConnectivity();
      if (!reachable) return false;

      // Also try a ping to verify the gRPC service is responding
      try {
        final client = _mgr.agentClient;
        final options = _mgr.callOptions(timeout: const Duration(seconds: 5));
        await client.ping(
          PingRequest(
            proposedExecutionId: 'test_${DateTime.now().millisecondsSinceEpoch}',
            stringToBePonged: 'test',
          ),
          options: options,
        );
      } catch (_) {
        // Ping failed but socket was reachable — server may not have AgentService
        // Still consider it connected
      }

      print('✅ Server is reachable via native gRPC');
      return true;
    } catch (e) {
      print('⚠️ Server not reachable: $e');
      return false;
    }
  }

  /// List available services. Returns hardcoded list since gRPC reflection
  /// is not available in the Dart gRPC package.
  static Future<List<String>> listServices() async {
    return [
      'tech.qomet.agora.api.grpc.prtagent.v1.AgentService',
      'tech.qomet.agora.api.grpc.prtagent.v1.ParticipantService',
      'tech.qomet.agora.api.grpc.prtagent.v1.InvestorService',
      'tech.qomet.agora.api.grpc.prtagent.v1.TradingService',
      'tech.qomet.agora.api.grpc.prtagent.v1.AdminService',
      'tech.qomet.agora.api.grpc.prtagent.v1.MarketService',
      'tech.qomet.agora.api.grpc.prtagent.v1.SecurityListingService',
      'tech.qomet.agora.api.grpc.prtagent.v1.CashTokenService',
      'tech.qomet.agora.api.grpc.prtagent.v1.VenueService',
    ];
  }

  // ============================================================================
  // AgentService Methods
  // ============================================================================

  /// AgentService.Ping
  static Future<Map<String, dynamic>> ping({
    required String stringToBePonged,
  }) async {
    if (_isPingInProgress) {
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
      final execId = 'ping_${DateTime.now().millisecondsSinceEpoch}';
      final requestBody = {
        'proposed_execution_id': execId,
        'string_to_be_ponged': stringToBePonged,
      };

      return await _executeNativeCall(
        method: 'Ping',
        requestBody: requestBody,
        rpcCall: () => _mgr.agentClient.ping(
          PingRequest(
            proposedExecutionId: execId,
            stringToBePonged: stringToBePonged,
          ),
          options: _mgr.callOptions(),
        ),
      );
    } finally {
      _isPingInProgress = false;
    }
  }

  // ============================================================================
  // InvestorService Methods
  // ============================================================================

  /// InvestorService.NewInvestor
  static Future<Map<String, dynamic>> newInvestor({
    required String externalInvestorId,
    String? auxData,
  }) async {
    if (_isInvestorOperationInProgress) {
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
      final execId = 'new_investor_${DateTime.now().millisecondsSinceEpoch}';
      final requestBody = {
        'proposed_execution_id': execId,
        'external_investor_id': externalInvestorId,
        'aux_data': {
          'source': 'flutter_app',
          'created_at': auxData ?? 'Created from Flutter signup',
        },
      };

      return await _executeNativeCall(
        method: 'NewInvestor',
        requestBody: requestBody,
        rpcCall: () => _mgr.investorClient.newInvestor(
          NewInvestorRequest(
            proposedExecutionId: execId,
            externalInvestorId: externalInvestorId,
            auxData: {
              'source': 'flutter_app',
              'created_at': auxData ?? 'Created from Flutter signup',
            },
          ),
          options: _mgr.callOptions(),
        ),
      );
    } finally {
      _isInvestorOperationInProgress = false;
    }
  }

  /// InvestorService.GetInvestorList
  static Future<Map<String, dynamic>> getInvestorList({
    int pageNumber = 0,
    int pageSize = 0,
    String? investorIdRegex,
    Map<String, String>? auxData,
  }) async {
    print('📋 Getting investor list...');

    final execId = 'get_investor_list_${DateTime.now().millisecondsSinceEpoch}';
    final requestBody = <String, dynamic>{
      'proposed_execution_id': execId,
      'pagination': {'page_nr': pageNumber, 'page_size': pageSize},
    };
    if (investorIdRegex != null && investorIdRegex.isNotEmpty) {
      requestBody['external_investor_id'] = investorIdRegex;
    }

    final request = GetInvestorListRequest(
      proposedExecutionId: execId,
      pagination: common_pb.PaginationParams(pageNr: pageNumber, pageSize: pageSize),
    );
    if (investorIdRegex != null && investorIdRegex.isNotEmpty) {
      request.externalInvestorId = investorIdRegex;
    }
    if (auxData != null && auxData.isNotEmpty) {
      request.auxData.addAll(auxData);
    }

    return _executeNativeCall(
      method: 'GetInvestorList',
      requestBody: requestBody,
      rpcCall: () => _mgr.investorClient.getInvestorList(request, options: _mgr.callOptions()),
    );
  }

  /// InvestorService.GetInvestorCashHoldings
  static Future<Map<String, dynamic>> getInvestorCashHoldings({
    required String investorId,
    List<String>? currencyCodes,
  }) async {
    print('📋 Getting cash holdings for investor: $investorId');

    final execId = 'get_investor_cash_holdings_${DateTime.now().millisecondsSinceEpoch}';
    final request = GetInvestorCashHoldingsRequest(
      proposedExecutionId: execId,
      externalInvestorId: investorId,
    );
    if (currencyCodes != null && currencyCodes.isNotEmpty) {
      request.currencyCodes.addAll(currencyCodes);
    }

    return _executeNativeCall(
      method: 'GetInvestorCashHoldings',
      requestBody: {
        'proposed_execution_id': execId,
        'external_investor_id': investorId,
        if (currencyCodes != null) 'currency_codes': currencyCodes,
      },
      rpcCall: () => _mgr.investorClient.getInvestorCashHoldings(request, options: _mgr.callOptions()),
    );
  }

  /// InvestorService.GetInvestorSecurityHoldings
  static Future<Map<String, dynamic>> getInvestorSecurityHoldings({
    required String investorId,
    String? venueId,
  }) async {
    print('📋 Getting security holdings for investor: $investorId');

    final execId = 'get_investor_security_holdings_${DateTime.now().millisecondsSinceEpoch}';
    final request = GetInvestorSecurityHoldingsRequest(
      proposedExecutionId: execId,
      externalInvestorId: investorId,
    );
    if (venueId != null && venueId.isNotEmpty) {
      request.venueIid = venueId;
    }

    return _executeNativeCall(
      method: 'GetInvestorSecurityHoldings',
      requestBody: {
        'proposed_execution_id': execId,
        'external_investor_id': investorId,
        if (venueId != null) 'venue_iid': venueId,
      },
      rpcCall: () => _mgr.investorClient.getInvestorSecurityHoldings(request, options: _mgr.callOptions()),
    );
  }

  /// InvestorService.GetInvestorOrders
  static Future<Map<String, dynamic>> getInvestorOrders({
    required String investorId,
    String refRequestId = 'flutter-get-orders',
    List<String>? venueIids,
    List<String>? securityListingIids,
    Map<String, dynamic>? pagination,
    String? fromTime,
    String? toTime,
    String? side,
    List<bool>? statusFilters,
  }) async {
    final request = GetInvestorOrdersRequest(
      proposedExecutionId: refRequestId,
      externalInvestorId: investorId,
    );

    if (venueIids != null && venueIids.isNotEmpty) {
      request.venueIids.addAll(venueIids);
    }
    if (securityListingIids != null && securityListingIids.isNotEmpty) {
      request.securityListingIids.addAll(securityListingIids);
    }
    if (pagination != null) {
      request.pagination = common_pb.PaginationParams(
        pageNr: pagination['page_nr'] ?? 0,
        pageSize: pagination['page_size'] ?? 0,
      );
    }

    // Build order query filter
    final filter = OrderQueryFilter();
    bool hasFilter = false;
    if (fromTime != null) {
      try {
        final parsed = jsonDecode(fromTime);
        if (parsed is Map<String, dynamic> && parsed['utc_unix_epoch_ts_millis'] != null) {
          filter.fromDt = common_pb.DateTime(utcUnixEpochTsMillis: parsed['utc_unix_epoch_ts_millis'].toString());
          hasFilter = true;
        }
      } catch (_) {}
    }
    if (toTime != null) {
      try {
        final parsed = jsonDecode(toTime);
        if (parsed is Map<String, dynamic> && parsed['utc_unix_epoch_ts_millis'] != null) {
          filter.toDt = common_pb.DateTime(utcUnixEpochTsMillis: parsed['utc_unix_epoch_ts_millis'].toString());
          hasFilter = true;
        }
      } catch (_) {}
    }
    if (side != null) {
      final sideUpper = side.toUpperCase();
      if (sideUpper == 'BUY' || sideUpper == 'ORDER_SIDE_ENUM_BUY') {
        filter.side = fin_enum.OrderSideEnum.ORDER_SIDE_ENUM_BUY;
        hasFilter = true;
      } else if (sideUpper == 'SELL' || sideUpper == 'ORDER_SIDE_ENUM_SELL') {
        filter.side = fin_enum.OrderSideEnum.ORDER_SIDE_ENUM_SELL;
        hasFilter = true;
      }
    }
    if (statusFilters != null) {
      filter.statusFilters.addAll(statusFilters);
      hasFilter = true;
    }
    if (hasFilter) {
      request.orderQueryFilter = filter;
    }

    final requestBody = <String, dynamic>{
      'proposed_execution_id': refRequestId,
      'external_investor_id': investorId,
    };

    return _executeNativeCall(
      method: 'GetInvestorOrders',
      requestBody: requestBody,
      rpcCall: () => _mgr.investorClient.getInvestorOrders(request, options: _mgr.callOptions()),
    );
  }

  /// InvestorService.GetInvestorTrades
  static Future<Map<String, dynamic>> getInvestorTrades({
    required String investorId,
    String refRequestId = 'flutter-get-trades',
    List<String>? marketIids,
    List<String>? securityListingIids,
    Map<String, dynamic>? pagination,
    String? fromTime,
    String? toTime,
    String? side,
  }) async {
    final request = GetInvestorTradesRequest(
      proposedExecutionId: refRequestId,
      externalInvestorId: investorId,
    );

    if (marketIids != null && marketIids.isNotEmpty) {
      request.marketIids.addAll(marketIids);
    }
    if (securityListingIids != null && securityListingIids.isNotEmpty) {
      request.securityListingIids.addAll(securityListingIids);
    }
    if (pagination != null) {
      request.pagination = common_pb.PaginationParams(
        pageNr: pagination['page_nr'] ?? 0,
        pageSize: pagination['page_size'] ?? 0,
      );
    }
    if (fromTime != null) {
      try {
        final parsed = jsonDecode(fromTime);
        if (parsed is Map<String, dynamic> && parsed['utc_unix_epoch_ts_millis'] != null) {
          request.fromDt = common_pb.DateTime(utcUnixEpochTsMillis: parsed['utc_unix_epoch_ts_millis'].toString());
        }
      } catch (_) {}
    }
    if (toTime != null) {
      try {
        final parsed = jsonDecode(toTime);
        if (parsed is Map<String, dynamic> && parsed['utc_unix_epoch_ts_millis'] != null) {
          request.toDt = common_pb.DateTime(utcUnixEpochTsMillis: parsed['utc_unix_epoch_ts_millis'].toString());
        }
      } catch (_) {}
    }
    if (side != null) {
      final sideUpper = side.toUpperCase();
      if (sideUpper == 'BUY' || sideUpper == 'ORDER_SIDE_ENUM_BUY') {
        request.side = fin_enum.OrderSideEnum.ORDER_SIDE_ENUM_BUY;
      } else if (sideUpper == 'SELL' || sideUpper == 'ORDER_SIDE_ENUM_SELL') {
        request.side = fin_enum.OrderSideEnum.ORDER_SIDE_ENUM_SELL;
      }
    }

    return _executeNativeCall(
      method: 'GetInvestorTrades',
      requestBody: {
        'proposed_execution_id': refRequestId,
        'external_investor_id': investorId,
      },
      rpcCall: () => _mgr.investorClient.getInvestorTrades(request, options: _mgr.callOptions()),
    );
  }

  /// InvestorService.GetInvestorTransactions
  static Future<Map<String, dynamic>> getInvestorTransactions({
    required String investorId,
    String refRequestId = 'flutter-get-transactions',
    Map<String, dynamic>? pagination,
    String? fromTime,
    String? toTime,
    List<String>? transactionTypes,
    List<String>? assetIds,
  }) async {
    final request = GetInvestorTransactionsRequest(
      proposedExecutionId: refRequestId,
      externalInvestorId: investorId,
    );

    if (pagination != null) {
      request.pagination = common_pb.PaginationParams(
        pageNr: pagination['page_nr'] ?? 0,
        pageSize: pagination['page_size'] ?? 0,
      );
    }
    if (fromTime != null) {
      try {
        final parsed = jsonDecode(fromTime);
        if (parsed is Map<String, dynamic> && parsed['utc_unix_epoch_ts_millis'] != null) {
          request.fromDt = common_pb.DateTime(utcUnixEpochTsMillis: parsed['utc_unix_epoch_ts_millis'].toString());
        }
      } catch (_) {}
    }
    if (toTime != null) {
      try {
        final parsed = jsonDecode(toTime);
        if (parsed is Map<String, dynamic> && parsed['utc_unix_epoch_ts_millis'] != null) {
          request.toDt = common_pb.DateTime(utcUnixEpochTsMillis: parsed['utc_unix_epoch_ts_millis'].toString());
        }
      } catch (_) {}
    }
    if (assetIds != null && assetIds.isNotEmpty) {
      request.assetIids.addAll(assetIds);
    }

    return _executeNativeCall(
      method: 'GetInvestorTransactions',
      requestBody: {
        'proposed_execution_id': refRequestId,
        'external_investor_id': investorId,
      },
      rpcCall: () => _mgr.investorClient.getInvestorTransactions(request, options: _mgr.callOptions()),
    );
  }

  /// InvestorService.DepositCash
  static Future<Map<String, dynamic>> depositCash({
    required String investorId,
    required String currencyCode,
    required String amount,
    Map<String, String>? auxData,
  }) async {
    print('💰 Depositing $amount $currencyCode to investor: $investorId');

    final execId = 'deposit_cash_${DateTime.now().millisecondsSinceEpoch}';
    return _executeNativeCall(
      method: 'DepositCash',
      requestBody: {
        'proposed_execution_id': execId,
        'external_investor_id': investorId,
        'currency_code': currencyCode,
        'amount': amount,
      },
      rpcCall: () => _mgr.investorClient.depositCash(
        DepositCashRequest(
          proposedExecutionId: execId,
          externalInvestorId: investorId,
          currencyCode: currencyCode,
          amount: amount,
          auxData: auxData ?? {
            'source': 'flutter_app',
            'transaction_type': 'deposit',
          },
        ),
        options: _mgr.callOptions(),
      ),
    );
  }

  /// InvestorService.WithdrawCash
  static Future<Map<String, dynamic>> withdrawCash({
    required String investorId,
    required String currencyCode,
    required String amount,
    Map<String, String>? auxData,
  }) async {
    print('💸 Withdrawing $amount $currencyCode from investor: $investorId');

    final execId = 'withdraw_cash_${DateTime.now().millisecondsSinceEpoch}';
    return _executeNativeCall(
      method: 'WithdrawCash',
      requestBody: {
        'proposed_execution_id': execId,
        'external_investor_id': investorId,
        'currency_code': currencyCode,
        'amount': amount,
      },
      rpcCall: () => _mgr.investorClient.withdrawCash(
        WithdrawCashRequest(
          proposedExecutionId: execId,
          externalInvestorId: investorId,
          currencyCode: currencyCode,
          amount: amount,
          auxData: auxData ?? {
            'source': 'flutter_app',
            'transaction_type': 'withdrawal',
          },
        ),
        options: _mgr.callOptions(),
      ),
    );
  }

  /// InvestorService.ActivateVenueForInvestor
  /// Note: This RPC does not exist in the current proto. Kept for API compatibility.
  /// Uses RegisterInvestorAtDepositories as the closest match.
  static Future<Map<String, dynamic>> activateVenueForInvestor({
    required String investorId,
    required String venueId,
  }) async {
    print('🏢 Activating venue $venueId for investor: $investorId');

    final execId = 'activate_venue_${DateTime.now().millisecondsSinceEpoch}';
    return _executeNativeCall(
      method: 'RegisterInvestorAtDepositories',
      requestBody: {
        'proposed_execution_id': execId,
        'external_investor_id': investorId,
        'venue_iid': venueId,
      },
      rpcCall: () => _mgr.investorClient.registerInvestorAtDepositories(
        RegisterInvestorAtDepositoriesRequest(
          proposedExecutionId: execId,
          externalInvestorId: investorId,
        ),
        options: _mgr.callOptions(),
      ),
    );
  }

  /// InvestorService.GetInvestorInfoBatch
  static Future<Map<String, dynamic>> getInvestorInfoBatch({
    required List<String> externalInvestorIds,
  }) async {
    print('📋 Getting investor info for: $externalInvestorIds');

    final execId = 'get_investor_info_batch_${DateTime.now().millisecondsSinceEpoch}';
    return _executeNativeCall(
      method: 'GetInvestorInfoBatch',
      requestBody: {
        'proposed_execution_id': execId,
        'external_investor_ids': externalInvestorIds,
      },
      rpcCall: () => _mgr.investorClient.getInvestorInfoBatch(
        GetInvestorInfoBatchRequest(
          proposedExecutionId: execId,
          externalInvestorIds: externalInvestorIds,
        ),
        options: _mgr.callOptions(),
      ),
    );
  }

  // ============================================================================
  // VenueService Methods
  // ============================================================================

  /// VenueService.GetVenueList
  static Future<Map<String, dynamic>> getVenueList({
    int pageNumber = 0,
    int pageSize = 0,
    String? venueIid,
    String? marketIid,
  }) async {
    final execId = 'get_venue_list_${DateTime.now().millisecondsSinceEpoch}';
    final request = GetVenueListRequest(
      proposedExecutionId: execId,
      pagination: common_pb.PaginationParams(pageNr: pageNumber, pageSize: pageSize),
    );
    if (marketIid != null && marketIid.isNotEmpty) {
      request.marketIid = marketIid;
    }
    if (venueIid != null && venueIid.isNotEmpty) {
      request.venueIid = venueIid;
    }

    return _executeNativeCall(
      method: 'GetVenueList',
      requestBody: {
        'proposed_execution_id': execId,
        'pagination': {'page_nr': pageNumber, 'page_size': pageSize},
      },
      rpcCall: () => _mgr.venueClient.getVenueList(request, options: _mgr.callOptions()),
    );
  }

  // ============================================================================
  // MarketService Methods
  // ============================================================================

  /// MarketService.GetMarketList
  static Future<Map<String, dynamic>> getMarketList({
    int pageNumber = 0,
    int pageSize = 0,
    String? marketIdOrSymbolRegex,
  }) async {
    print('📋 Getting market list from real server...');

    final execId = 'get_market_list_${DateTime.now().millisecondsSinceEpoch}';
    final request = GetMarketListRequest(
      proposedExecutionId: execId,
      pagination: common_pb.PaginationParams(pageNr: pageNumber, pageSize: pageSize),
    );
    if (marketIdOrSymbolRegex != null && marketIdOrSymbolRegex.isNotEmpty) {
      request.marketIid = marketIdOrSymbolRegex;
    }

    return _executeNativeCall(
      method: 'GetMarketList',
      requestBody: {
        'proposed_execution_id': execId,
        'pagination': {'page_nr': pageNumber, 'page_size': pageSize},
      },
      rpcCall: () => _mgr.marketClient.getMarketList(request, options: _mgr.callOptions()),
    );
  }

  // ============================================================================
  // SecurityListingService Methods
  // ============================================================================

  /// SecurityListingService.GetSecurityListingList
  static Future<Map<String, dynamic>> getSecurityListingList({
    int pageNumber = 0,
    int pageSize = 0,
    String? symbolRegex,
    String? securityListingIid,
    List<String>? venueIids,
  }) async {
    final execId = 'get_security_listing_list_${DateTime.now().millisecondsSinceEpoch}';
    final request = GetSecurityListingListRequest(
      proposedExecutionId: execId,
      pagination: common_pb.PaginationParams(pageNr: pageNumber, pageSize: pageSize),
    );
    if (symbolRegex != null && symbolRegex.isNotEmpty) {
      request.symbolRegex = symbolRegex;
    }
    if (securityListingIid != null && securityListingIid.isNotEmpty) {
      request.securityListingIid = securityListingIid;
    }
    if (venueIids != null && venueIids.isNotEmpty) {
      request.venueIids.addAll(venueIids);
    }

    return _executeNativeCall(
      method: 'GetSecurityListingList',
      requestBody: {
        'proposed_execution_id': execId,
        'pagination': {'page_nr': pageNumber, 'page_size': pageSize},
      },
      rpcCall: () => _mgr.securityListingClient.getSecurityListingList(request, options: _mgr.callOptions()),
    );
  }

  /// SecurityListingService.GetSecurityListingInfoBatch
  static Future<Map<String, dynamic>> getSecurityListingInfoBatch({
    required List<String> securityListingIids,
  }) async {
    print('📋 Getting security listing info for: $securityListingIids');

    final execId = 'get_security_listing_info_batch_${DateTime.now().millisecondsSinceEpoch}';
    return _executeNativeCall(
      method: 'GetSecurityListingInfoBatch',
      requestBody: {
        'proposed_execution_id': execId,
        'security_listing_iids': securityListingIids,
      },
      rpcCall: () => _mgr.securityListingClient.getSecurityListingInfoBatch(
        GetSecurityListingInfoBatchRequest(
          proposedExecutionId: execId,
          securityListingIids: securityListingIids,
        ),
        options: _mgr.callOptions(),
      ),
    );
  }

  /// SecurityListingService.GetSecurityListingTrades
  static Future<Map<String, dynamic>> getSecurityTrades({
    required String securityId,
    int pageNumber = 1,
    int pageSize = 50,
  }) async {
    print('📋 Getting trades for security: $securityId');

    final execId = 'get_security_trades_${DateTime.now().millisecondsSinceEpoch}';
    return _executeNativeCall(
      method: 'GetSecurityListingTrades',
      requestBody: {
        'proposed_execution_id': execId,
        'pagination': {'page_nr': pageNumber, 'page_size': pageSize},
        'security_listing_iids': [securityId],
      },
      rpcCall: () => _mgr.securityListingClient.getSecurityListingTrades(
        GetSecurityListingTradesRequest(
          proposedExecutionId: execId,
          pagination: common_pb.PaginationParams(pageNr: pageNumber, pageSize: pageSize),
          securityListingIids: [securityId],
        ),
        options: _mgr.callOptions(),
      ),
    );
  }

  // ============================================================================
  // CashTokenService Methods
  // ============================================================================

  /// CashTokenService.GetCashTokenList
  static Future<Map<String, dynamic>> getCashTokenList({
    int pageNumber = 0,
    int pageSize = 0,
  }) async {
    print('📋 Getting cash token list...');

    final execId = 'get_cash_token_list_${DateTime.now().millisecondsSinceEpoch}';
    return _executeNativeCall(
      method: 'GetCashTokenList',
      requestBody: {
        'proposed_execution_id': execId,
        'pagination': {'page_nr': pageNumber, 'page_size': pageSize},
      },
      rpcCall: () => _mgr.cashTokenClient.getCashTokenList(
        GetCashTokenListRequest(
          proposedExecutionId: execId,
          pagination: common_pb.PaginationParams(pageNr: pageNumber, pageSize: pageSize),
        ),
        options: _mgr.callOptions(),
      ),
    );
  }

  /// CashTokenService.GetCashTokenInfoBatch
  static Future<Map<String, dynamic>> getCashTokenInfoBatch({
    required List<String> cashTokenIds,
  }) async {
    print('📋 Getting cash token info for: $cashTokenIds');

    final execId = 'get_cash_token_info_batch_${DateTime.now().millisecondsSinceEpoch}';
    return _executeNativeCall(
      method: 'GetCashTokenInfoBatch',
      requestBody: {
        'proposed_execution_id': execId,
        'cash_token_iids': cashTokenIds,
      },
      rpcCall: () => _mgr.cashTokenClient.getCashTokenInfoBatch(
        GetCashTokenInfoBatchRequest(
          proposedExecutionId: execId,
          cashTokenIids: cashTokenIds,
        ),
        options: _mgr.callOptions(),
      ),
    );
  }

  // ============================================================================
  // TradingService Methods
  // ============================================================================

  /// TradingService.GetHistoricalOhlcData
  static Future<Map<String, dynamic>> getHistoricalOhlcData({
    required String securityListingIid,
    required String period,
    int pageSize = 0,
  }) async {
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
    final fromTs = fromDt.millisecondsSinceEpoch.toString();
    final toTs = now.millisecondsSinceEpoch.toString();

    final execId = 'get_historical_ohlc_${DateTime.now().millisecondsSinceEpoch}';
    return _executeNativeCall(
      method: 'GetHistoricalOhlcData',
      requestBody: {
        'proposed_execution_id': execId,
        'security_listing_iids': [securityListingIid],
        'period': period,
      },
      rpcCall: () => _mgr.tradingClient.getHistoricalOhlcData(
        GetHistoricalOhlcDataRequest(
          proposedExecutionId: execId,
          pagination: common_pb.PaginationParams(pageNr: 1, pageSize: pageSize),
          securityListingIids: [securityListingIid],
          period: period,
          includeVolume: true,
          auxData: {
            'from_ts': fromTs,
            'to_ts': toTs,
          },
        ),
        options: _mgr.callOptions(),
      ),
    );
  }

  /// TradingService.GetOrderbook
  static Future<Map<String, dynamic>> getOrderbook({
    required String securityIid,
    String? side,
    int pageNumber = 1,
    int pageSize = 10,
    String? mode,
  }) async {
    final execId = 'get_orderbook_${DateTime.now().millisecondsSinceEpoch}';
    final request = GetOrderbookRequest(
      proposedExecutionId: execId,
      pagination: common_pb.PaginationParams(pageNr: pageNumber, pageSize: pageSize),
      securityListingIid: securityIid,
    );

    if (side != null && side.isNotEmpty) {
      final filter = OrderbookQueryFilter();
      // Set the side on the filter if the generated code supports it
      // The filter is typically used for side filtering
      request.orderbookQueryFilter = filter;
    }

    if (mode != null && mode.isNotEmpty) {
      switch (mode.toUpperCase()) {
        case 'L1_BEST_BID_ASK':
        case '1':
          request.mode = OrderbookModeEnum.ORDERBOOK_MODE_ENUM_L1_BEST_BID_ASK;
          break;
        case 'L2_AGGREGATED_PRICE_LEVELS':
        case '2':
          request.mode = OrderbookModeEnum.ORDERBOOK_MODE_ENUM_L2_AGGREGATED_PRICE_LEVELS;
          break;
        case 'L3_INDIVIDUAL_ORDERS':
        case '3':
          request.mode = OrderbookModeEnum.ORDERBOOK_MODE_ENUM_L3_INDIVIDUAL_ORDERS;
          break;
        case 'CUMULATIVE_DEPTH':
        case '4':
          request.mode = OrderbookModeEnum.ORDERBOOK_MODE_ENUM_CUMULATIVE_DEPTH;
          break;
        case 'ACTUAL':
        case '5':
          request.mode = OrderbookModeEnum.ORDERBOOK_MODE_ENUM_ACTUAL;
          break;
      }
    }

    return _executeNativeCall(
      method: 'GetOrderbook',
      requestBody: {
        'proposed_execution_id': execId,
        'security_listing_iid': securityIid,
        'pagination': {'page_nr': pageNumber, 'page_size': pageSize},
      },
      rpcCall: () => _mgr.tradingClient.getOrderbook(request, options: _mgr.callOptions()),
    );
  }

  /// TradingService.CancelOrderAsync
  static Future<Map<String, dynamic>> cancelOrderAsync({
    required String externalOrderId,
    String? reason,
    String refRequestId = 'flutter-cancel-order',
    Map<String, String>? auxData,
  }) async {
    print('❌ Cancelling order: $externalOrderId');

    final request = CancelOrderAsyncRequest(
      proposedExecutionId: refRequestId,
      externalOrderId: externalOrderId,
      reason: reason ?? 'User requested cancellation',
    );
    if (auxData != null) {
      request.auxData.addAll(auxData);
    }

    return _executeNativeCall(
      method: 'CancelOrderAsync',
      requestBody: {
        'proposed_execution_id': refRequestId,
        'external_order_id': externalOrderId,
        'reason': reason ?? 'User requested cancellation',
      },
      rpcCall: () => _mgr.tradingClient.cancelOrderAsync(request, options: _mgr.callOptions()),
    );
  }

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

    final request = ReplaceOrderAsyncRequest(
      proposedExecutionId: refRequestId,
      oldParticipantOrderId: oldParticipantOrderId,
      newParticipantOrderId: newParticipantOrderId,
    );
    if (newQuantity != null) request.newQuantity = newQuantity;
    if (newPrice != null) request.newPrice = newPrice;
    if (newExpireTime != null) {
      request.newExpireTime = common_pb.Time(
        hmss: common_pb.TimeHMSS(
          hour: newExpireTime.hour,
          minute: newExpireTime.minute,
          second: newExpireTime.second,
        ),
      );
    }
    if (reason != null) request.reason = reason;

    return _executeNativeCall(
      method: 'ReplaceOrderAsync',
      requestBody: {
        'proposed_execution_id': refRequestId,
        'old_participant_order_id': oldParticipantOrderId,
        'new_participant_order_id': newParticipantOrderId,
      },
      rpcCall: () => _mgr.tradingClient.replaceOrderAsync(request, options: _mgr.callOptions()),
    );
  }

  /// TradingService.CreateOrderAsync
  static Future<Map<String, dynamic>> createOrderAsync({
    required String externalInvestorId,
    required String feePayerAccountIid,
    required String securityListingIid,
    required String orderType,
    required String side,
    required String quantity,
    required String price,
    String timeInForce = '0',
    required String investorOrderId,
    DateTime? expireTime,
    String? currency,
    String? feeAmount,
    Map<String, String>? auxData,
  }) async {
    print('📝 Creating order: $side $quantity @ $price for $securityListingIid');

    fin_enum.OrderSideEnum sideEnum;
    switch (side.toUpperCase()) {
      case 'BUY':
        sideEnum = fin_enum.OrderSideEnum.ORDER_SIDE_ENUM_BUY;
        break;
      case 'SELL':
        sideEnum = fin_enum.OrderSideEnum.ORDER_SIDE_ENUM_SELL;
        break;
      default:
        sideEnum = fin_enum.OrderSideEnum.ORDER_SIDE_ENUM_UNKNOWN;
    }

    final execId = 'create_order_${DateTime.now().millisecondsSinceEpoch}';
    final request = CreateOrderAsyncRequest(
      proposedExecutionId: execId,
      externalInvestorId: externalInvestorId,
      feePayerAccountIid: feePayerAccountIid,
      securityListingIid: securityListingIid,
      orderType: orderType,
      side: sideEnum,
      quantity: quantity,
      price: price,
      timeInForce: timeInForce,
      investorOrderId: investorOrderId,
    );

    request.expireDt = common_pb.DateTime(
      utcUnixEpochTsMillis: expireTime != null
          ? expireTime.millisecondsSinceEpoch.toString()
          : '0',
    );
    if (currency != null && currency.isNotEmpty) request.currency = currency;
    if (feeAmount != null && feeAmount.isNotEmpty) request.feeAmount = feeAmount;
    if (auxData != null) request.auxData.addAll(auxData);

    return _executeNativeCall(
      method: 'CreateOrderAsync',
      requestBody: {
        'proposed_execution_id': execId,
        'external_investor_id': externalInvestorId,
        'security_listing_iid': securityListingIid,
        'order_type': orderType,
        'side': side,
        'quantity': quantity,
        'price': price,
      },
      rpcCall: () => _mgr.tradingClient.createOrderAsync(request, options: _mgr.callOptions()),
    );
  }

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

    final execId = 'get_exec_reports_${DateTime.now().millisecondsSinceEpoch}';
    final request = GetOrderExecutionReportsRequest(
      proposedExecutionId: execId,
      requestId: requestId,
      pagination: common_pb.PaginationParams(pageNr: pageNumber, pageSize: pageSize),
    );
    if (symbolFilter != null && symbolFilter.isNotEmpty) request.symbolFilter = symbolFilter;
    if (currencyFilter != null && currencyFilter.isNotEmpty) request.currencyFilter = currencyFilter;
    if (execTypeFilter != null && execTypeFilter.isNotEmpty) request.execTypeFilter = execTypeFilter;
    if (fromDate != null && fromDate.isNotEmpty) request.fromDate = fromDate;
    if (toDate != null && toDate.isNotEmpty) request.toDate = toDate;
    if (sortBy != null && sortBy.isNotEmpty) request.sortBy = sortBy;
    if (sortDirection != null && sortDirection.isNotEmpty) request.sortDirection = sortDirection;

    return _executeNativeCall(
      method: 'GetOrderExecutionReports',
      requestBody: {
        'proposed_execution_id': execId,
        'request_id': requestId,
        'pagination': {'page_nr': pageNumber, 'page_size': pageSize},
      },
      rpcCall: () => _mgr.tradingClient.getOrderExecutionReports(request, options: _mgr.callOptions()),
    );
  }

  // ============================================================================
  // AdminService Methods
  // ============================================================================

  /// AdminService.GetExecutionReports
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
    print('📋 Getting execution reports from AdminService');

    final execId = 'get_exec_reports_${DateTime.now().millisecondsSinceEpoch}';
    final request = GetExecutionReportsRequest(
      proposedExecutionId: execId,
      pagination: common_pb.PaginationParams(pageNr: pageNumber, pageSize: pageSize),
    );
    if (requestId != null && requestId.isNotEmpty) request.requestId = requestId;
    if (symbol != null && symbol.isNotEmpty) request.symbol = symbol;
    if (currency != null && currency.isNotEmpty) request.currency = currency;
    if (execType != null && execType.isNotEmpty) request.execType = execType;
    if (side != null && side.isNotEmpty) request.side = side;
    if (venueIid != null && venueIid.isNotEmpty) request.venueIid = venueIid;
    if (fromDate != null && fromDate.isNotEmpty) request.fromDate = fromDate;
    if (toDate != null && toDate.isNotEmpty) request.toDate = toDate;
    if (sortBy != null && sortBy.isNotEmpty) request.sortBy = sortBy;
    if (sortDirection != null && sortDirection.isNotEmpty) request.sortDirection = sortDirection;
    if (search != null && search.isNotEmpty) request.search = search;

    return _executeNativeCall(
      method: 'GetExecutionReports',
      requestBody: {
        'proposed_execution_id': execId,
        'pagination': {'page_nr': pageNumber, 'page_size': pageSize},
      },
      rpcCall: () => _mgr.adminClient.getExecutionReports(request, options: _mgr.callOptions()),
    );
  }

  // ============================================================================
  // ParticipantService Methods
  // ============================================================================

  /// ParticipantService.GetParticipantInfo
  static Future<Map<String, dynamic>> getParticipantInfo() async {
    print('📋 Getting participant info from real server...');

    final execId = 'get_participant_info_${DateTime.now().millisecondsSinceEpoch}';
    return _executeNativeCall(
      method: 'GetParticipantInfo',
      requestBody: {'proposed_execution_id': execId},
      rpcCall: () => _mgr.participantClient.getParticipantInfo(
        GetParticipantInfoRequest(proposedExecutionId: execId),
        options: _mgr.callOptions(),
      ),
    );
  }

  /// ParticipantService.GetParticipantHoldings
  static Future<Map<String, dynamic>> getParticipantHoldings({
    String? mode,
    String? issuedInstrumentIid,
  }) async {
    print('📋 Getting participant holdings from real server...');

    final execId = 'get_participant_holdings_${DateTime.now().millisecondsSinceEpoch}';
    final request = GetParticipantHoldingsRequest(proposedExecutionId: execId);
    if (mode != null && mode.isNotEmpty) request.mode = mode;
    if (issuedInstrumentIid != null && issuedInstrumentIid.isNotEmpty) {
      request.issuedInstrumentIid = issuedInstrumentIid;
    }

    return _executeNativeCall(
      method: 'GetParticipantHoldings',
      requestBody: {'proposed_execution_id': execId},
      rpcCall: () => _mgr.participantClient.getParticipantHoldings(request, options: _mgr.callOptions()),
    );
  }
}
