import 'dart:async';
import 'package:candlesticks/candlesticks.dart';
import 'package:mini_broker/generated/prtagent/v1/trading.pbgrpc.dart' as trading_pb;
import 'package:mini_broker/generated/common.pb.dart' as common_pb;

class ChartService {
  final trading_pb.TradingServiceClient _tradingClient;
  StreamSubscription? _liveOhlcSubscription;

  ChartService(this._tradingClient);

  /// Convert proto OhlcData to Candle for the interactive_chart package
  Candle _convertToCandle(trading_pb.OhlcData ohlcData) {
    // Parse timestamp from duration
    DateTime timestamp = DateTime.now();
    if (ohlcData.hasDuration()) {
      if (ohlcData.duration.hasStartDt()) {
        final startDt = ohlcData.duration.startDt;
        if (startDt.hasYmdhmss()) {
          final ymdhmss = startDt.ymdhmss;
          if (ymdhmss.hasDate()) {
            timestamp = DateTime(
              ymdhmss.date.year,
              ymdhmss.date.month,
              ymdhmss.date.day,
              ymdhmss.hasTime() ? ymdhmss.time.hour : 0,
              ymdhmss.hasTime() ? ymdhmss.time.minute : 0,
              ymdhmss.hasTime() ? ymdhmss.time.second : 0,
            );
          }
        }
      }
    }

    return Candle(
      date: timestamp,
      open: (double.tryParse(ohlcData.open) ?? 0.0) / 100.0,
      high: (double.tryParse(ohlcData.high) ?? 0.0) / 100.0,
      low: (double.tryParse(ohlcData.low) ?? 0.0) / 100.0,
      close: (double.tryParse(ohlcData.close) ?? 0.0) / 100.0,
      volume: double.tryParse(ohlcData.volume) ?? 0.0,
    );
  }

  /// Fetch historical OHLC data for a security listing IID
  Future<List<Candle>> getHistoricalOhlcData({
    required String securityListingIid,
    required String period, // "1m", "5m", "15m", "1h", "1d"
    DateTime? startDate,
    DateTime? endDate,
    int? pageSize,
  }) async {
    try {
      print('📊 Fetching historical OHLC data for $securityListingIid, period: $period');

      final request = trading_pb.GetHistoricalOhlcDataRequest()
        ..securityListingIids.add(securityListingIid)
        ..period = period
        ..includeVolume = true;

      // Add pagination if specified
      if (pageSize != null) {
        request.pagination = common_pb.PaginationParams()
          ..pageSize = pageSize;
      }

      // Add duration filter if dates are specified
      if (startDate != null && endDate != null) {
        final duration = common_pb.Duration()
          ..startDt = (common_pb.DateTime()
            ..ymdhmss = (common_pb.DateTimeYMDHMSS()
              ..date = (common_pb.DateYMD()
                ..year = startDate.year
                ..month = startDate.month
                ..day = startDate.day)
              ..time = (common_pb.TimeHMSS()
                ..hour = startDate.hour
                ..minute = startDate.minute
                ..second = startDate.second)))
          ..endDt = (common_pb.DateTime()
            ..ymdhmss = (common_pb.DateTimeYMDHMSS()
              ..date = (common_pb.DateYMD()
                ..year = endDate.year
                ..month = endDate.month
                ..day = endDate.day)
              ..time = (common_pb.TimeHMSS()
                ..hour = endDate.hour
                ..minute = endDate.minute
                ..second = endDate.second)));
        request.duration = duration;
      }

      final response = await _tradingClient.getHistoricalOhlcData(request);

      print('✅ Received ${response.ohlcData.length} OHLC data points');

      // Convert to Candle objects
      final candles = response.ohlcData
          .map((ohlcData) => _convertToCandle(ohlcData))
          .toList();

      // Server returns candles newest-first (index 0 = newest) — no client sort needed

      return candles;
    } catch (e) {
      print('❌ Error fetching historical OHLC data: $e');
      rethrow;
    }
  }

  /// Stream live OHLC data updates
  Stream<Candle> fetchLiveOhlcData({
    required String symbol,
    required String period,
    int? updateIntervalMs,
    int? maxDurationMs,
  }) async* {
    try {
      print('📡 Starting live OHLC stream for $symbol, period: $period');

      final request = trading_pb.FetchLiveOhlcDataRequest()
        ..securityListingIids.add(symbol);

      // Set fetch parameters
      final fetchParams = trading_pb.LiveOhlcDataFetchParams()
        ..period = period
        ..includeVolume = true;

      if (updateIntervalMs != null) {
        fetchParams.updateIntervalMs = updateIntervalMs;
      }
      if (maxDurationMs != null) {
        fetchParams.maxDurationMs = maxDurationMs;
      }

      request.fetchParams = fetchParams;

      final stream = _tradingClient.fetchLiveOhlcData(request);

      await for (final response in stream) {
        if (response.hasOhlcData()) {
          final candle = _convertToCandle(response.ohlcData);
          print('📈 Live OHLC update: ${candle.close}');
          yield candle;
        }
      }
    } catch (e) {
      print('❌ Error in live OHLC stream: $e');
      rethrow;
    }
  }

  /// Get latest quote (current price)
  Future<double?> getLatestQuote(String symbol) async {
    try {
      final request = trading_pb.GetLatestQuoteRequest()
        ..securityListingIids.add(symbol);

      final response = await _tradingClient.getLatestQuote(request);

      if (response.hasQuote()) {
        return double.tryParse(response.quote.amount);
      }
      return null;
    } catch (e) {
      print('❌ Error fetching latest quote: $e');
      return null;
    }
  }

  /// Stream live quotes
  Stream<double> fetchLiveQuote({
    required String symbol,
    int? updateIntervalMs,
  }) async* {
    try {
      final request = trading_pb.FetchLiveQuoteRequest()
        ..securityListingIids.add(symbol);

      if (updateIntervalMs != null) {
        final fetchParams = trading_pb.LiveQuoteFetchParams()
          ..updateIntervalMs = updateIntervalMs;
        request.fetchParams = fetchParams;
      }

      final stream = _tradingClient.fetchLiveQuote(request);

      await for (final response in stream) {
        if (response.hasQuote()) {
          final price = double.tryParse(response.quote.amount);
          if (price != null) {
            yield price;
          }
        }
      }
    } catch (e) {
      print('❌ Error in live quote stream: $e');
      rethrow;
    }
  }

  /// Dispose and cancel subscriptions
  void dispose() {
    _liveOhlcSubscription?.cancel();
  }
}
