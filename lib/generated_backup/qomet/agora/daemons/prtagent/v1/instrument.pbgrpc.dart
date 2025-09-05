// This is a generated file - do not edit.
//
// Generated from qomet/agora/daemons/prtagent/v1/instrument.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'instrument.pb.dart' as $0;

export 'instrument.pb.dart';

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.InstrumentService')
class InstrumentServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  InstrumentServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.GetInstrumentsInfoResponse> getInstrumentsInfo(
    $0.GetInstrumentsInfoRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getInstrumentsInfo, request, options: options);
  }

  $grpc.ResponseFuture<$0.InstrumentQuoteResponse> getLatestQuote(
    $0.GetLatestQuoteRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getLatestQuote, request, options: options);
  }

  $grpc.ResponseStream<$0.InstrumentQuoteResponse> fetchLiveQuote(
    $0.FetchLiveQuoteRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$fetchLiveQuote, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.GetHistoricalQuoteResponse> getHistoricalQuote(
    $0.GetHistoricalQuoteRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getHistoricalQuote, request, options: options);
  }

  $grpc.ResponseStream<$0.OhlcDataResponse> fetchLiveOhlcData(
    $0.FetchLiveOhlcDataRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$fetchLiveOhlcData, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.GetHistoricalOhlcDataResponse> getHistoricalOhlcData(
    $0.GetHistoricalOhlcDataRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getHistoricalOhlcData, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInstrumentOrdersResponse> getInstrumentOrders(
    $0.GetInstrumentOrdersRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getInstrumentOrders, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInstrumentTradesResponse> getInstrumentTrades(
    $0.GetInstrumentTradesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getInstrumentTrades, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInstrumentSettlementsResponse>
      getInstrumentSettlements(
    $0.GetInstrumentSettlementsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getInstrumentSettlements, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetOrderbookResponse> getOrderbook(
    $0.GetOrderbookRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getOrderbook, request, options: options);
  }

  // method descriptors

  static final _$getInstrumentsInfo = $grpc.ClientMethod<
          $0.GetInstrumentsInfoRequest, $0.GetInstrumentsInfoResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetInstrumentsInfo',
      ($0.GetInstrumentsInfoRequest value) => value.writeToBuffer(),
      $0.GetInstrumentsInfoResponse.fromBuffer);
  static final _$getLatestQuote =
      $grpc.ClientMethod<$0.GetLatestQuoteRequest, $0.InstrumentQuoteResponse>(
          '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetLatestQuote',
          ($0.GetLatestQuoteRequest value) => value.writeToBuffer(),
          $0.InstrumentQuoteResponse.fromBuffer);
  static final _$fetchLiveQuote =
      $grpc.ClientMethod<$0.FetchLiveQuoteRequest, $0.InstrumentQuoteResponse>(
          '/qomet.agora.daemons.prtagent.v1.InstrumentService/FetchLiveQuote',
          ($0.FetchLiveQuoteRequest value) => value.writeToBuffer(),
          $0.InstrumentQuoteResponse.fromBuffer);
  static final _$getHistoricalQuote = $grpc.ClientMethod<
          $0.GetHistoricalQuoteRequest, $0.GetHistoricalQuoteResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetHistoricalQuote',
      ($0.GetHistoricalQuoteRequest value) => value.writeToBuffer(),
      $0.GetHistoricalQuoteResponse.fromBuffer);
  static final _$fetchLiveOhlcData = $grpc.ClientMethod<
          $0.FetchLiveOhlcDataRequest, $0.OhlcDataResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/FetchLiveOhlcData',
      ($0.FetchLiveOhlcDataRequest value) => value.writeToBuffer(),
      $0.OhlcDataResponse.fromBuffer);
  static final _$getHistoricalOhlcData = $grpc.ClientMethod<
          $0.GetHistoricalOhlcDataRequest, $0.GetHistoricalOhlcDataResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetHistoricalOhlcData',
      ($0.GetHistoricalOhlcDataRequest value) => value.writeToBuffer(),
      $0.GetHistoricalOhlcDataResponse.fromBuffer);
  static final _$getInstrumentOrders = $grpc.ClientMethod<
          $0.GetInstrumentOrdersRequest, $0.GetInstrumentOrdersResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetInstrumentOrders',
      ($0.GetInstrumentOrdersRequest value) => value.writeToBuffer(),
      $0.GetInstrumentOrdersResponse.fromBuffer);
  static final _$getInstrumentTrades = $grpc.ClientMethod<
          $0.GetInstrumentTradesRequest, $0.GetInstrumentTradesResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetInstrumentTrades',
      ($0.GetInstrumentTradesRequest value) => value.writeToBuffer(),
      $0.GetInstrumentTradesResponse.fromBuffer);
  static final _$getInstrumentSettlements = $grpc.ClientMethod<
          $0.GetInstrumentSettlementsRequest,
          $0.GetInstrumentSettlementsResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetInstrumentSettlements',
      ($0.GetInstrumentSettlementsRequest value) => value.writeToBuffer(),
      $0.GetInstrumentSettlementsResponse.fromBuffer);
  static final _$getOrderbook =
      $grpc.ClientMethod<$0.GetOrderbookRequest, $0.GetOrderbookResponse>(
          '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetOrderbook',
          ($0.GetOrderbookRequest value) => value.writeToBuffer(),
          $0.GetOrderbookResponse.fromBuffer);
}

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.InstrumentService')
abstract class InstrumentServiceBase extends $grpc.Service {
  $core.String get $name => 'qomet.agora.daemons.prtagent.v1.InstrumentService';

  InstrumentServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetInstrumentsInfoRequest,
            $0.GetInstrumentsInfoResponse>(
        'GetInstrumentsInfo',
        getInstrumentsInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInstrumentsInfoRequest.fromBuffer(value),
        ($0.GetInstrumentsInfoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetLatestQuoteRequest,
            $0.InstrumentQuoteResponse>(
        'GetLatestQuote',
        getLatestQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetLatestQuoteRequest.fromBuffer(value),
        ($0.InstrumentQuoteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.FetchLiveQuoteRequest,
            $0.InstrumentQuoteResponse>(
        'FetchLiveQuote',
        fetchLiveQuote_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $0.FetchLiveQuoteRequest.fromBuffer(value),
        ($0.InstrumentQuoteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetHistoricalQuoteRequest,
            $0.GetHistoricalQuoteResponse>(
        'GetHistoricalQuote',
        getHistoricalQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetHistoricalQuoteRequest.fromBuffer(value),
        ($0.GetHistoricalQuoteResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.FetchLiveOhlcDataRequest, $0.OhlcDataResponse>(
            'FetchLiveOhlcData',
            fetchLiveOhlcData_Pre,
            false,
            true,
            ($core.List<$core.int> value) =>
                $0.FetchLiveOhlcDataRequest.fromBuffer(value),
            ($0.OhlcDataResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetHistoricalOhlcDataRequest,
            $0.GetHistoricalOhlcDataResponse>(
        'GetHistoricalOhlcData',
        getHistoricalOhlcData_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetHistoricalOhlcDataRequest.fromBuffer(value),
        ($0.GetHistoricalOhlcDataResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInstrumentOrdersRequest,
            $0.GetInstrumentOrdersResponse>(
        'GetInstrumentOrders',
        getInstrumentOrders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInstrumentOrdersRequest.fromBuffer(value),
        ($0.GetInstrumentOrdersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInstrumentTradesRequest,
            $0.GetInstrumentTradesResponse>(
        'GetInstrumentTrades',
        getInstrumentTrades_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInstrumentTradesRequest.fromBuffer(value),
        ($0.GetInstrumentTradesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInstrumentSettlementsRequest,
            $0.GetInstrumentSettlementsResponse>(
        'GetInstrumentSettlements',
        getInstrumentSettlements_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInstrumentSettlementsRequest.fromBuffer(value),
        ($0.GetInstrumentSettlementsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetOrderbookRequest, $0.GetOrderbookResponse>(
            'GetOrderbook',
            getOrderbook_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetOrderbookRequest.fromBuffer(value),
            ($0.GetOrderbookResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetInstrumentsInfoResponse> getInstrumentsInfo_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetInstrumentsInfoRequest> $request) async {
    return getInstrumentsInfo($call, await $request);
  }

  $async.Future<$0.GetInstrumentsInfoResponse> getInstrumentsInfo(
      $grpc.ServiceCall call, $0.GetInstrumentsInfoRequest request);

  $async.Future<$0.InstrumentQuoteResponse> getLatestQuote_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetLatestQuoteRequest> $request) async {
    return getLatestQuote($call, await $request);
  }

  $async.Future<$0.InstrumentQuoteResponse> getLatestQuote(
      $grpc.ServiceCall call, $0.GetLatestQuoteRequest request);

  $async.Stream<$0.InstrumentQuoteResponse> fetchLiveQuote_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.FetchLiveQuoteRequest> $request) async* {
    yield* fetchLiveQuote($call, await $request);
  }

  $async.Stream<$0.InstrumentQuoteResponse> fetchLiveQuote(
      $grpc.ServiceCall call, $0.FetchLiveQuoteRequest request);

  $async.Future<$0.GetHistoricalQuoteResponse> getHistoricalQuote_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetHistoricalQuoteRequest> $request) async {
    return getHistoricalQuote($call, await $request);
  }

  $async.Future<$0.GetHistoricalQuoteResponse> getHistoricalQuote(
      $grpc.ServiceCall call, $0.GetHistoricalQuoteRequest request);

  $async.Stream<$0.OhlcDataResponse> fetchLiveOhlcData_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.FetchLiveOhlcDataRequest> $request) async* {
    yield* fetchLiveOhlcData($call, await $request);
  }

  $async.Stream<$0.OhlcDataResponse> fetchLiveOhlcData(
      $grpc.ServiceCall call, $0.FetchLiveOhlcDataRequest request);

  $async.Future<$0.GetHistoricalOhlcDataResponse> getHistoricalOhlcData_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetHistoricalOhlcDataRequest> $request) async {
    return getHistoricalOhlcData($call, await $request);
  }

  $async.Future<$0.GetHistoricalOhlcDataResponse> getHistoricalOhlcData(
      $grpc.ServiceCall call, $0.GetHistoricalOhlcDataRequest request);

  $async.Future<$0.GetInstrumentOrdersResponse> getInstrumentOrders_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetInstrumentOrdersRequest> $request) async {
    return getInstrumentOrders($call, await $request);
  }

  $async.Future<$0.GetInstrumentOrdersResponse> getInstrumentOrders(
      $grpc.ServiceCall call, $0.GetInstrumentOrdersRequest request);

  $async.Future<$0.GetInstrumentTradesResponse> getInstrumentTrades_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetInstrumentTradesRequest> $request) async {
    return getInstrumentTrades($call, await $request);
  }

  $async.Future<$0.GetInstrumentTradesResponse> getInstrumentTrades(
      $grpc.ServiceCall call, $0.GetInstrumentTradesRequest request);

  $async.Future<$0.GetInstrumentSettlementsResponse>
      getInstrumentSettlements_Pre($grpc.ServiceCall $call,
          $async.Future<$0.GetInstrumentSettlementsRequest> $request) async {
    return getInstrumentSettlements($call, await $request);
  }

  $async.Future<$0.GetInstrumentSettlementsResponse> getInstrumentSettlements(
      $grpc.ServiceCall call, $0.GetInstrumentSettlementsRequest request);

  $async.Future<$0.GetOrderbookResponse> getOrderbook_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetOrderbookRequest> $request) async {
    return getOrderbook($call, await $request);
  }

  $async.Future<$0.GetOrderbookResponse> getOrderbook(
      $grpc.ServiceCall call, $0.GetOrderbookRequest request);
}
