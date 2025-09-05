import 'package:mini_broker/generated/qomet/agora/daemons/prtagent/v1/market.pb.dart';
import 'package:mini_broker/generated/qomet/agora/daemons/prtagent/v1/common.pb.dart';
import 'package:mini_broker/services/grpc_client.dart';

class MarketService {
  static final TradingGrpcClient _client = grpcClient;

  /// Get list of available markets
  static Future<GetMarketListResponse> getMarketList({
    int pageNumber = 1,
    int pageSize = 20,
    String? pageToken,
  }) async {
    final pagination = PaginationParams()
      ..pageNr = pageNumber
      ..pageSize = pageSize;
    
    if (pageToken != null) {
      pagination.pageToken = pageToken;
    }

    final request = GetMarketListRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'get_market_list')
      ..pagination = pagination;

    return await _client.marketService.getMarketList(request);
  }

  /// Get information about specific markets
  static Future<GetMarketsInfoResponse> getMarketsInfo({
    required List<String> marketIds,
  }) async {
    final request = GetMarketsInfoRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'get_markets_info')
      ..marketIds.addAll(marketIds);

    return await _client.marketService.getMarketsInfo(request);
  }

  /// Get market calendar (trading hours, holidays, etc.)
  static Future<GetMarketCalendarResponse> getMarketCalendar({
    required String marketId,
  }) async {
    final request = GetMarketCalendarRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'get_market_calendar')
      ..marketId = marketId;

    return await _client.marketService.getMarketCalendar(request);
  }

  /// Get supported currencies for a market
  static Future<GetMarketSupportedCurrenciesResponse> getMarketSupportedCurrencies({
    required String marketId,
    int pageNumber = 1,
    int pageSize = 20,
    String? pageToken,
  }) async {
    final pagination = PaginationParams()
      ..pageNr = pageNumber
      ..pageSize = pageSize;
    
    if (pageToken != null) {
      pagination.pageToken = pageToken;
    }

    final request = GetMarketSupportedCurrenciesRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'get_market_currencies')
      ..pagination = pagination
      ..marketId = marketId;

    return await _client.marketService.getMarketSupportedCurrencies(request);
  }

  /// Get instruments available in a market
  static Future<GetMarketInstrumentListResponse> getMarketInstrumentList({
    required String marketId,
    String? instrumentIdRegex,
    int pageNumber = 1,
    int pageSize = 20,
    String? pageToken,
  }) async {
    final pagination = PaginationParams()
      ..pageNr = pageNumber
      ..pageSize = pageSize;
    
    if (pageToken != null) {
      pagination.pageToken = pageToken;
    }

    final request = GetMarketInstrumentListRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'get_market_instruments')
      ..pagination = pagination
      ..marketId = marketId;

    if (instrumentIdRegex != null) {
      request.instrumentIdRegex = instrumentIdRegex;
    }

    return await _client.marketService.getMarketInstrumentList(request);
  }

  /// Get order fees for a specific order
  static Future<GetOrderFeesResponse> getOrderFees({
    required String accountId,
    String? feePayerAccountId,
    required String instrumentId,
    required String orderType, // "LIMIT" or "MARKET"
    required OrderSide side,
    required String quantity,
    String? price, // Required for LIMIT orders
    String? timeInForce, // "GTC", "IOC", "FOK", "DAY"
    bool isPostOnly = false,
    String? metadata,
  }) async {
    final request = GetOrderFeesRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'get_order_fees')
      ..accountId = accountId
      ..instrumentId = instrumentId
      ..orderType = orderType
      ..side = side
      ..quantity = quantity
      ..isPostOnly = isPostOnly;

    if (feePayerAccountId != null) {
      request.feePayerAccountId = feePayerAccountId;
    }

    if (price != null) {
      request.price = price;
    }

    if (timeInForce != null) {
      request.timeInForce = timeInForce;
    }

    if (metadata != null) {
      request.metadata = metadata;
    }

    return await _client.marketService.getOrderFees(request);
  }

  /// Create a new order
  static Future<CreateOrderResponse> createOrder({
    required String accountId,
    String? feePayerAccountId,
    required String instrumentId,
    required String orderType, // "LIMIT" or "MARKET"
    required OrderSide side,
    required String quantity,
    required String price, // Must be zero for MARKET orders
    String timeInForce = "GTC", // "GTC", "IOC", "FOK", "DAY"
    DateTime? expireTime,
    required String participantOrderId,
    String? metadata,
    String? auxData,
  }) async {
    final request = CreateOrderRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'create_order')
      ..accountId = accountId
      ..instrumentId = instrumentId
      ..orderType = orderType
      ..side = side
      ..quantity = quantity
      ..price = price
      ..timeInForce = timeInForce
      ..participantOrderId = participantOrderId;

    if (feePayerAccountId != null) {
      request.feePayerAccountId = feePayerAccountId;
    }

    if (expireTime != null) {
      request.expireTime = Time()..ts = Timestamp.fromDateTime(expireTime);
    }

    if (metadata != null) {
      request.metadata = metadata;
    }

    if (auxData != null) {
      request.auxData = auxData;
    }

    return await _client.marketService.createOrder(request);
  }

  /// Replace an existing order
  static Future<ReplaceOrderResponse> replaceOrder({
    required String proposedOrderId,
    required String newProposedOrderId,
    String? newQuantity,
    String? newPrice,
    DateTime? newExpireTime,
    String? reason,
    String? metadata,
  }) async {
    final request = ReplaceOrderRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'replace_order')
      ..proposedOrderId = proposedOrderId
      ..newProposedOrderId = newProposedOrderId;

    if (newQuantity != null) {
      request.newQuantity = newQuantity;
    }

    if (newPrice != null) {
      request.newPrice = newPrice;
    }

    if (newExpireTime != null) {
      request.newExpireTime = Time()..ts = Timestamp.fromDateTime(newExpireTime);
    }

    if (reason != null) {
      request.reason = reason;
    }

    if (metadata != null) {
      request.metadata = metadata;
    }

    return await _client.marketService.replaceOrder(request);
  }

  /// Cancel an existing order
  static Future<CancelOrderResponse> cancelOrder({
    required String proposedOrderId,
    String? reason,
    String? metadata,
  }) async {
    final request = CancelOrderRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'cancel_order')
      ..proposedOrderId = proposedOrderId;

    if (reason != null) {
      request.reason = reason;
    }

    if (metadata != null) {
      request.metadata = metadata;
    }

    return await _client.marketService.cancelOrder(request);
  }
}