// This is a generated file - do not edit.
//
// Generated from trading.proto.

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

import 'common.pb.dart' as $1;
import 'trading.pb.dart' as $0;

export 'trading.pb.dart';

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.TradingService')
class TradingServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  TradingServiceClient(super.channel, {super.options, super.interceptors});

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

  $grpc.ResponseFuture<$0.GetOrderFeesResponse> getOrderFees(
    $0.GetOrderFeesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getOrderFees, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getOrderFeesAsync(
    $0.GetOrderFeesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getOrderFeesAsync, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> createOrderAsync(
    $0.CreateOrderAsyncRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createOrderAsync, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> replaceOrderAsync(
    $0.ReplaceOrderAsyncRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$replaceOrderAsync, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> cancelOrderAsync(
    $0.CancelOrderAsyncRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$cancelOrderAsync, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetOrderbookResponse> getOrderbook(
    $0.GetOrderbookRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getOrderbook, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getOrderbookAsync(
    $0.GetOrderbookRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getOrderbookAsync, request, options: options);
  }

  // method descriptors

  static final _$getLatestQuote =
      $grpc.ClientMethod<$0.GetLatestQuoteRequest, $0.InstrumentQuoteResponse>(
          '/qomet.agora.daemons.prtagent.v1.TradingService/GetLatestQuote',
          ($0.GetLatestQuoteRequest value) => value.writeToBuffer(),
          $0.InstrumentQuoteResponse.fromBuffer);
  static final _$fetchLiveQuote =
      $grpc.ClientMethod<$0.FetchLiveQuoteRequest, $0.InstrumentQuoteResponse>(
          '/qomet.agora.daemons.prtagent.v1.TradingService/FetchLiveQuote',
          ($0.FetchLiveQuoteRequest value) => value.writeToBuffer(),
          $0.InstrumentQuoteResponse.fromBuffer);
  static final _$getHistoricalQuote = $grpc.ClientMethod<
          $0.GetHistoricalQuoteRequest, $0.GetHistoricalQuoteResponse>(
      '/qomet.agora.daemons.prtagent.v1.TradingService/GetHistoricalQuote',
      ($0.GetHistoricalQuoteRequest value) => value.writeToBuffer(),
      $0.GetHistoricalQuoteResponse.fromBuffer);
  static final _$fetchLiveOhlcData =
      $grpc.ClientMethod<$0.FetchLiveOhlcDataRequest, $0.OhlcDataResponse>(
          '/qomet.agora.daemons.prtagent.v1.TradingService/FetchLiveOhlcData',
          ($0.FetchLiveOhlcDataRequest value) => value.writeToBuffer(),
          $0.OhlcDataResponse.fromBuffer);
  static final _$getHistoricalOhlcData = $grpc.ClientMethod<
          $0.GetHistoricalOhlcDataRequest, $0.GetHistoricalOhlcDataResponse>(
      '/qomet.agora.daemons.prtagent.v1.TradingService/GetHistoricalOhlcData',
      ($0.GetHistoricalOhlcDataRequest value) => value.writeToBuffer(),
      $0.GetHistoricalOhlcDataResponse.fromBuffer);
  static final _$getOrderFees =
      $grpc.ClientMethod<$0.GetOrderFeesRequest, $0.GetOrderFeesResponse>(
          '/qomet.agora.daemons.prtagent.v1.TradingService/GetOrderFees',
          ($0.GetOrderFeesRequest value) => value.writeToBuffer(),
          $0.GetOrderFeesResponse.fromBuffer);
  static final _$getOrderFeesAsync =
      $grpc.ClientMethod<$0.GetOrderFeesRequest, $1.ExecutionAsyncResponse>(
          '/qomet.agora.daemons.prtagent.v1.TradingService/GetOrderFeesAsync',
          ($0.GetOrderFeesRequest value) => value.writeToBuffer(),
          $1.ExecutionAsyncResponse.fromBuffer);
  static final _$createOrderAsync =
      $grpc.ClientMethod<$0.CreateOrderAsyncRequest, $1.ExecutionAsyncResponse>(
          '/qomet.agora.daemons.prtagent.v1.TradingService/CreateOrderAsync',
          ($0.CreateOrderAsyncRequest value) => value.writeToBuffer(),
          $1.ExecutionAsyncResponse.fromBuffer);
  static final _$replaceOrderAsync = $grpc.ClientMethod<
          $0.ReplaceOrderAsyncRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.TradingService/ReplaceOrderAsync',
      ($0.ReplaceOrderAsyncRequest value) => value.writeToBuffer(),
      $1.ExecutionAsyncResponse.fromBuffer);
  static final _$cancelOrderAsync =
      $grpc.ClientMethod<$0.CancelOrderAsyncRequest, $1.ExecutionAsyncResponse>(
          '/qomet.agora.daemons.prtagent.v1.TradingService/CancelOrderAsync',
          ($0.CancelOrderAsyncRequest value) => value.writeToBuffer(),
          $1.ExecutionAsyncResponse.fromBuffer);
  static final _$getOrderbook =
      $grpc.ClientMethod<$0.GetOrderbookRequest, $0.GetOrderbookResponse>(
          '/qomet.agora.daemons.prtagent.v1.TradingService/GetOrderbook',
          ($0.GetOrderbookRequest value) => value.writeToBuffer(),
          $0.GetOrderbookResponse.fromBuffer);
  static final _$getOrderbookAsync =
      $grpc.ClientMethod<$0.GetOrderbookRequest, $1.ExecutionAsyncResponse>(
          '/qomet.agora.daemons.prtagent.v1.TradingService/GetOrderbookAsync',
          ($0.GetOrderbookRequest value) => value.writeToBuffer(),
          $1.ExecutionAsyncResponse.fromBuffer);
}

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.TradingService')
abstract class TradingServiceBase extends $grpc.Service {
  $core.String get $name => 'qomet.agora.daemons.prtagent.v1.TradingService';

  TradingServiceBase() {
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
    $addMethod(
        $grpc.ServiceMethod<$0.GetOrderFeesRequest, $0.GetOrderFeesResponse>(
            'GetOrderFees',
            getOrderFees_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetOrderFeesRequest.fromBuffer(value),
            ($0.GetOrderFeesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetOrderFeesRequest, $1.ExecutionAsyncResponse>(
            'GetOrderFeesAsync',
            getOrderFeesAsync_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetOrderFeesRequest.fromBuffer(value),
            ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateOrderAsyncRequest,
            $1.ExecutionAsyncResponse>(
        'CreateOrderAsync',
        createOrderAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateOrderAsyncRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ReplaceOrderAsyncRequest,
            $1.ExecutionAsyncResponse>(
        'ReplaceOrderAsync',
        replaceOrderAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ReplaceOrderAsyncRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelOrderAsyncRequest,
            $1.ExecutionAsyncResponse>(
        'CancelOrderAsync',
        cancelOrderAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CancelOrderAsyncRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetOrderbookRequest, $0.GetOrderbookResponse>(
            'GetOrderbook',
            getOrderbook_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetOrderbookRequest.fromBuffer(value),
            ($0.GetOrderbookResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetOrderbookRequest, $1.ExecutionAsyncResponse>(
            'GetOrderbookAsync',
            getOrderbookAsync_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetOrderbookRequest.fromBuffer(value),
            ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
  }

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

  $async.Future<$0.GetOrderFeesResponse> getOrderFees_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetOrderFeesRequest> $request) async {
    return getOrderFees($call, await $request);
  }

  $async.Future<$0.GetOrderFeesResponse> getOrderFees(
      $grpc.ServiceCall call, $0.GetOrderFeesRequest request);

  $async.Future<$1.ExecutionAsyncResponse> getOrderFeesAsync_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetOrderFeesRequest> $request) async {
    return getOrderFeesAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getOrderFeesAsync(
      $grpc.ServiceCall call, $0.GetOrderFeesRequest request);

  $async.Future<$1.ExecutionAsyncResponse> createOrderAsync_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CreateOrderAsyncRequest> $request) async {
    return createOrderAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> createOrderAsync(
      $grpc.ServiceCall call, $0.CreateOrderAsyncRequest request);

  $async.Future<$1.ExecutionAsyncResponse> replaceOrderAsync_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ReplaceOrderAsyncRequest> $request) async {
    return replaceOrderAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> replaceOrderAsync(
      $grpc.ServiceCall call, $0.ReplaceOrderAsyncRequest request);

  $async.Future<$1.ExecutionAsyncResponse> cancelOrderAsync_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CancelOrderAsyncRequest> $request) async {
    return cancelOrderAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> cancelOrderAsync(
      $grpc.ServiceCall call, $0.CancelOrderAsyncRequest request);

  $async.Future<$0.GetOrderbookResponse> getOrderbook_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetOrderbookRequest> $request) async {
    return getOrderbook($call, await $request);
  }

  $async.Future<$0.GetOrderbookResponse> getOrderbook(
      $grpc.ServiceCall call, $0.GetOrderbookRequest request);

  $async.Future<$1.ExecutionAsyncResponse> getOrderbookAsync_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetOrderbookRequest> $request) async {
    return getOrderbookAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getOrderbookAsync(
      $grpc.ServiceCall call, $0.GetOrderbookRequest request);
}
