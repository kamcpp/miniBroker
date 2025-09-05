import 'dart:async';
import 'package:mini_broker/generated/qomet/agora/daemons/prtagent/v1/instrument.pb.dart';
import 'package:mini_broker/generated/qomet/agora/daemons/prtagent/v1/common.pb.dart';
import 'package:mini_broker/services/grpc_client.dart';

class InstrumentService {
  static final TradingGrpcClient _client = grpcClient;

  /// Get information about instruments
  static Future<GetInstrumentsInfoResponse> getInstrumentsInfo({
    List<String>? instrumentRegexes,
    List<InstrumentListingStatusType>? listingTypes,
    String? metadata,
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

    final request = GetInstrumentsInfoRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'get_instruments_info')
      ..pagination = pagination;

    if (instrumentRegexes != null) {
      request.instrumentIdAndSymbolRegexes.addAll(instrumentRegexes);
    }

    if (listingTypes != null) {
      request.listingTypes.addAll(listingTypes);
    }

    if (metadata != null) {
      request.metadata = metadata;
    }

    return await _client.instrumentService.getInstrumentsInfo(request);
  }

  /// Get latest quote for instruments
  static Future<InstrumentQuoteResponse> getLatestQuote({
    required List<String> instrumentRegexes,
    String? metadata,
  }) async {
    final request = GetLatestQuoteRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'get_latest_quote')
      ..instrumentIdAndSymbolRegexes.addAll(instrumentRegexes);

    if (metadata != null) {
      request.metadata = metadata;
    }

    return await _client.instrumentService.getLatestQuote(request);
  }

  /// Fetch live quotes stream
  static Stream<InstrumentQuoteResponse> fetchLiveQuotes({
    required List<String> instrumentRegexes,
    int updateIntervalMs = 1000,
    int maxDurationMs = 300000, // 5 minutes default
    bool includeDepth = false,
    int depthLevels = 5,
    bool includeTrades = false,
    String? metadata,
  }) {
    final fetchParams = LiveQuoteFetchParams()
      ..updateIntervalMs = updateIntervalMs
      ..maxDurationMs = maxDurationMs
      ..includeDepth = includeDepth
      ..depthLevels = depthLevels
      ..includeTrades = includeTrades;

    final request = FetchLiveQuoteRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'fetch_live_quotes')
      ..instrumentIdAndSymbolRegexes.addAll(instrumentRegexes)
      ..fetchParams = fetchParams;

    if (metadata != null) {
      request.metadata = metadata;
    }

    return _client.instrumentService.fetchLiveQuote(request);
  }

  /// Get historical quotes
  static Future<GetHistoricalQuoteResponse> getHistoricalQuotes({
    required List<String> instrumentRegexes,
    Duration? duration,
    String? metadata,
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

    final request = GetHistoricalQuoteRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'get_historical_quotes')
      ..pagination = pagination
      ..instrumentIdAndSymbolRegexes.addAll(instrumentRegexes);

    if (duration != null) {
      // Convert Dart Duration to proto Duration - this would need proper implementation
      // For now, we'll skip it as it requires more complex mapping
    }

    if (metadata != null) {
      request.metadata = metadata;
    }

    return await _client.instrumentService.getHistoricalQuote(request);
  }

  /// Fetch live OHLC data stream
  static Stream<OhlcDataResponse> fetchLiveOhlcData({
    required List<String> instrumentRegexes,
    int updateIntervalMs = 5000,
    int maxDurationMs = 300000, // 5 minutes default
    String period = "1m", // "1m", "5m", "15m", "1h", "1d"
    bool includeVolume = true,
    bool includeIndicators = false,
    String? metadata,
  }) {
    final fetchParams = LiveOhlcDataFetchParams()
      ..updateIntervalMs = updateIntervalMs
      ..maxDurationMs = maxDurationMs
      ..period = period
      ..includeVolume = includeVolume
      ..includeIndicators = includeIndicators;

    final request = FetchLiveOhlcDataRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'fetch_live_ohlc')
      ..instrumentIdAndSymbolRegexes.addAll(instrumentRegexes)
      ..fetchParams = fetchParams;

    if (metadata != null) {
      request.metadata = metadata;
    }

    return _client.instrumentService.fetchLiveOhlcData(request);
  }

  /// Get historical OHLC data
  static Future<GetHistoricalOhlcDataResponse> getHistoricalOhlcData({
    required List<String> instrumentRegexes,
    Duration? duration,
    String? metadata,
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

    final request = GetHistoricalOhlcDataRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'get_historical_ohlc')
      ..pagination = pagination
      ..instrumentIdAndSymbolRegexes.addAll(instrumentRegexes);

    if (duration != null) {
      // Convert Dart Duration to proto Duration - this would need proper implementation
    }

    if (metadata != null) {
      request.metadata = metadata;
    }

    return await _client.instrumentService.getHistoricalOhlcData(request);
  }

  /// Get orders for specific instruments
  static Future<GetInstrumentOrdersResponse> getInstrumentOrders({
    required List<String> instrumentRegexes,
    DateTime? fromTime,
    DateTime? toTime,
    OrderSide? side,
    List<String>? orderTypes,
    String? priceMin,
    String? priceMax,
    String? quantityMin,
    String? quantityMax,
    List<bool>? statusFilters,
    String? creatorAddress,
    String? metadata,
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

    final orderQueryFilter = OrderQueryFilter();
    
    if (fromTime != null) {
      orderQueryFilter.fromTime = Time()..ts = Timestamp.fromDateTime(fromTime);
    }
    
    if (toTime != null) {
      orderQueryFilter.toTime = Time()..ts = Timestamp.fromDateTime(toTime);
    }
    
    if (side != null) {
      orderQueryFilter.side = side;
    }
    
    if (orderTypes != null) {
      orderQueryFilter.orderTypes.addAll(orderTypes);
    }
    
    if (priceMin != null) {
      orderQueryFilter.priceMin = priceMin;
    }
    
    if (priceMax != null) {
      orderQueryFilter.priceMax = priceMax;
    }
    
    if (quantityMin != null) {
      orderQueryFilter.quantityMin = quantityMin;
    }
    
    if (quantityMax != null) {
      orderQueryFilter.quantityMax = quantityMax;
    }
    
    if (statusFilters != null) {
      orderQueryFilter.statusFilters.addAll(statusFilters);
    }
    
    if (creatorAddress != null) {
      orderQueryFilter.creatorAddress = creatorAddress;
    }

    final request = GetInstrumentOrdersRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'get_instrument_orders')
      ..pagination = pagination
      ..instrumentIdAndSymbolRegexes.addAll(instrumentRegexes)
      ..orderQueryFilter = orderQueryFilter;

    if (metadata != null) {
      request.metadata = metadata;
    }

    return await _client.instrumentService.getInstrumentOrders(request);
  }

  /// Get trades for specific instruments
  static Future<GetInstrumentTradesResponse> getInstrumentTrades({
    required List<String> instrumentRegexes,
    DateTime? fromTime,
    DateTime? toTime,
    String? priceMin,
    String? priceMax,
    String? volumeMin,
    String? volumeMax,
    List<String>? tradeTypes,
    OrderSide? side,
    String? metadata,
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

    final tradeQueryFilter = TradeQueryFilter();
    
    if (fromTime != null) {
      tradeQueryFilter.fromTime = Time()..ts = Timestamp.fromDateTime(fromTime);
    }
    
    if (toTime != null) {
      tradeQueryFilter.toTime = Time()..ts = Timestamp.fromDateTime(toTime);
    }
    
    if (priceMin != null) {
      tradeQueryFilter.priceMin = priceMin;
    }
    
    if (priceMax != null) {
      tradeQueryFilter.priceMax = priceMax;
    }
    
    if (volumeMin != null) {
      tradeQueryFilter.volumeMin = volumeMin;
    }
    
    if (volumeMax != null) {
      tradeQueryFilter.volumeMax = volumeMax;
    }
    
    if (tradeTypes != null) {
      tradeQueryFilter.tradeTypes.addAll(tradeTypes);
    }
    
    if (side != null) {
      tradeQueryFilter.side = side;
    }

    final request = GetInstrumentTradesRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'get_instrument_trades')
      ..pagination = pagination
      ..instrumentIdAndSymbolRegexes.addAll(instrumentRegexes)
      ..tradeQueryFilter = tradeQueryFilter;

    if (metadata != null) {
      request.metadata = metadata;
    }

    return await _client.instrumentService.getInstrumentTrades(request);
  }

  /// Get orderbook for a specific instrument
  static Future<GetOrderbookResponse> getOrderbook({
    required String instrumentId,
    bool aggregated = false,
    OrderSide? side,
    int depth = 10,
    String? priceMin,
    String? priceMax,
    bool includeMyOrders = false,
    String? groupByPriceIncrement,
    String? metadata,
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

    final orderbookQueryFilter = OrderbookQueryFilter()
      ..aggregated = aggregated
      ..depth = depth
      ..includeMyOrders = includeMyOrders;

    if (side != null) {
      orderbookQueryFilter.side = side;
    }

    if (priceMin != null) {
      orderbookQueryFilter.priceMin = priceMin;
    }

    if (priceMax != null) {
      orderbookQueryFilter.priceMax = priceMax;
    }

    if (groupByPriceIncrement != null) {
      orderbookQueryFilter.groupByPriceIncrement = groupByPriceIncrement;
    }

    final request = GetOrderbookRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'get_orderbook')
      ..pagination = pagination
      ..instrumentId = instrumentId
      ..orderbookQueryFilter = orderbookQueryFilter;

    if (metadata != null) {
      request.metadata = metadata;
    }

    return await _client.instrumentService.getOrderbook(request);
  }
}