import 'dart:async';
import 'package:mini_broker/generated/qomet/agora/daemons/prtagent/v1/agent.pb.dart';
import 'package:mini_broker/generated/qomet/agora/daemons/prtagent/v1/common.pb.dart';
import 'package:mini_broker/generated/google/protobuf/timestamp.pb.dart';
import 'package:mini_broker/services/grpc_client.dart';

class AgentService {
  static final TradingGrpcClient _client = grpcClient;

  /// Ping the server to test connectivity
  static Future<PingResponse> ping({
    String stringToBePonged = 'Hello from Flutter!',
  }) async {
    final request = PingRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'ping')
      ..stringToBePonged = stringToBePonged;

    return await _client.agentService.ping(request);
  }

  /// Get participant information
  static Future<GetParticipantInfoResponse> getParticipantInfo() async {
    final request = GetParticipantInfoRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'get_participant_info');

    return await _client.agentService.getParticipantInfo(request);
  }

  /// Get supported currencies
  static Future<GetSupportedCurrenciesResponse> getSupportedCurrencies({
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

    final request = GetSupportedCurrenciesRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'get_supported_currencies')
      ..pagination = pagination;

    return await _client.agentService.getSupportedCurrencies(request);
  }

  /// Get participant orders across all accounts
  static Future<GetParticipantOrdersResponse> getParticipantOrders({
    List<String>? accountRegexes,
    List<String>? marketRegexes,
    DateTime? fromTime,
    DateTime? toTime,
    OrderSide? side,
    List<bool>? statusFilters,
    List<String>? instrumentRegexes,
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

    final request = GetParticipantOrdersRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'get_participant_orders')
      ..pagination = pagination;

    if (accountRegexes != null) {
      request.accountIdOrNameRegexes.addAll(accountRegexes);
    }

    if (marketRegexes != null) {
      request.marketIdOrNameRegexes.addAll(marketRegexes);
    }

    if (fromTime != null) {
      request.fromTime = Time()..ts = Timestamp.fromDateTime(fromTime);
    }

    if (toTime != null) {
      request.toTime = Time()..ts = Timestamp.fromDateTime(toTime);
    }

    if (side != null) {
      request.side = side;
    }

    if (statusFilters != null) {
      request.statusFilters.addAll(statusFilters);
    }

    if (instrumentRegexes != null) {
      request.instrumentIdOrSymbolRegexes.addAll(instrumentRegexes);
    }

    return await _client.agentService.getParticipantOrders(request);
  }

  /// Get participant trades across all accounts
  static Future<GetParticipantTradesResponse> getParticipantTrades({
    List<String>? accountRegexes,
    List<String>? marketRegexes,
    DateTime? fromTime,
    DateTime? toTime,
    OrderSide? side,
    List<String>? instrumentRegexes,
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

    final request = GetParticipantTradesRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'get_participant_trades')
      ..pagination = pagination;

    if (accountRegexes != null) {
      request.accountIdOrNameRegexes.addAll(accountRegexes);
    }

    if (marketRegexes != null) {
      request.marketIdOrNameRegexes.addAll(marketRegexes);
    }

    if (fromTime != null) {
      request.fromTime = Time()..ts = Timestamp.fromDateTime(fromTime);
    }

    if (toTime != null) {
      request.toTime = Time()..ts = Timestamp.fromDateTime(toTime);
    }

    if (side != null) {
      request.side = side;
    }

    if (instrumentRegexes != null) {
      request.instrumentIdOrSymbolRegexes.addAll(instrumentRegexes);
    }

    return await _client.agentService.getParticipantTrades(request);
  }

  /// Get participant settlements across all accounts
  static Future<GetParticipantSettlementsResponse> getParticipantSettlements({
    List<String>? accountRegexes,
    List<String>? marketRegexes,
    DateTime? fromTime,
    DateTime? toTime,
    ConfirmationStatus? status,
    List<String>? assetRegexes,
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

    final request = GetParticipantSettlementsRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'get_participant_settlements')
      ..pagination = pagination;

    if (accountRegexes != null) {
      request.accountIdOrNameRegexes.addAll(accountRegexes);
    }

    if (marketRegexes != null) {
      request.marketIdOrNameRegexes.addAll(marketRegexes);
    }

    if (fromTime != null) {
      request.fromTime = Time()..ts = Timestamp.fromDateTime(fromTime);
    }

    if (toTime != null) {
      request.toTime = Time()..ts = Timestamp.fromDateTime(toTime);
    }

    if (status != null) {
      request.status = status;
    }

    if (assetRegexes != null) {
      request.assetIdOrNameRegexes.addAll(assetRegexes);
    }

    return await _client.agentService.getParticipantSettlements(request);
  }

  /// Subscribe to agent events stream
  static Stream<Event> subscribeToEvents({
    required String subscriptionId,
    List<String>? topics,
    String? typeRegex,
  }) {
    final request = EventSubscriptionParams()
      ..refSubscriptionId = subscriptionId;

    if (topics != null) {
      request.topics.addAll(topics);
    }

    if (typeRegex != null) {
      request.typeRegex = typeRegex;
    }

    return _client.agentService.subscribeToAgentEvents(request);
  }

  /// Helper method to create a subscription ID
  static String generateSubscriptionId({String? prefix}) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final prefixStr = prefix != null ? '${prefix}_' : 'sub_';
    return '${prefixStr}${timestamp}';
  }
}