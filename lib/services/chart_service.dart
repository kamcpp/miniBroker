import 'dart:async';
import 'package:candlesticks/candlesticks.dart';
import 'package:mini_broker/generated/trading.pbgrpc.dart' as trading_pb;
import 'package:mini_broker/generated/common.pb.dart' as common_pb;

class ChartService {
  final trading_pb.TradingServiceClient _tradingClient;
  StreamSubscription? _liveOhlcSubscription;

  ChartService(this._tradingClient);

  /// Convert proto OhlcData to Candle for the candlesticks package
  Candle _convertToCandle(trading_pb.OhlcData ohlcData) {
    // Parse timestamp from duration
    DateTime timestamp = DateTime.now();
    if (ohlcData.hasDuration()) {
      if (ohlcData.duration.hasStartDt()) {
        final startDt = ohlcData.duration.startDt;
        if (startDt.hasDate()) {
          timestamp = DateTime(
            startDt.date.year,
            startDt.date.month,
            startDt.date.day,
            startDt.hasTime() && startDt.time.hasHms() ? startDt.time.hms.hour : 0,
            startDt.hasTime() && startDt.time.hasHms() ? startDt.time.hms.minute : 0,
          );
        }
      }
    }

    return Candle(
      date: timestamp,
      open: double.tryParse(ohlcData.open) ?? 0.0,
      high: double.tryParse(ohlcData.high) ?? 0.0,
      low: double.tryParse(ohlcData.low) ?? 0.0,
      close: double.tryParse(ohlcData.close) ?? 0.0,
      volume: double.tryParse(ohlcData.volume) ?? 0.0,
    );
  }

  /// Fetch historical OHLC data for a symbol
  Future<List<Candle>> getHistoricalOhlcData({
    required String symbol,
    required String period, // "1m", "5m", "15m", "1h", "1d"
    DateTime? startDate,
    DateTime? endDate,
    int? pageSize,
  }) async {
    try {
      print('📊 Fetching historical OHLC data for $symbol, period: $period');

      final request = trading_pb.GetHistoricalOhlcDataRequest()
        ..instrumentIdAndSymbolRegexes.add(symbol)
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
            ..date = (common_pb.Date()
              ..year = startDate.year
              ..month = startDate.month
              ..day = startDate.day)
            ..time = (common_pb.Time()
              ..hms = (common_pb.TimeHMS()
                ..hour = startDate.hour
                ..minute = startDate.minute
                ..second = startDate.second)))
          ..endDt = (common_pb.DateTime()
            ..date = (common_pb.Date()
              ..year = endDate.year
              ..month = endDate.month
              ..day = endDate.day)
            ..time = (common_pb.Time()
              ..hms = (common_pb.TimeHMS()
                ..hour = endDate.hour
                ..minute = endDate.minute
                ..second = endDate.second)));
        request.duration = duration;
      }

      final response = await _tradingClient.getHistoricalOhlcData(request);

      print('✅ Received ${response.ohlcDatas.length} OHLC data points');

      // Convert to Candle objects
      final candles = response.ohlcDatas
          .map((ohlcData) => _convertToCandle(ohlcData))
          .toList();

      // Sort by date (newest first for candlesticks package)
      candles.sort((a, b) => b.date.compareTo(a.date));

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
        ..instrumentIdAndSymbolRegexes.add(symbol);

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
        ..instrumentIdAndSymbolRegexes.add(symbol);

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
        ..instrumentIdAndSymbolRegexes.add(symbol);

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
