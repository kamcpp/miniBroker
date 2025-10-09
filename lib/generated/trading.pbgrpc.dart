//
//  Generated code. Do not modify.
//  source: trading.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $1;
import 'trading.pb.dart' as $5;

export 'trading.pb.dart';

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.TradingService')
class TradingServiceClient extends $grpc.Client {
  static final _$getLatestQuote = $grpc.ClientMethod<$5.GetLatestQuoteRequest, $5.InstrumentQuoteResponse>(
      '/qomet.agora.daemons.prtagent.v1.TradingService/GetLatestQuote',
      ($5.GetLatestQuoteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.InstrumentQuoteResponse.fromBuffer(value));
  static final _$fetchLiveQuote = $grpc.ClientMethod<$5.FetchLiveQuoteRequest, $5.InstrumentQuoteResponse>(
      '/qomet.agora.daemons.prtagent.v1.TradingService/FetchLiveQuote',
      ($5.FetchLiveQuoteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.InstrumentQuoteResponse.fromBuffer(value));
  static final _$getHistoricalQuote = $grpc.ClientMethod<$5.GetHistoricalQuoteRequest, $5.GetHistoricalQuoteResponse>(
      '/qomet.agora.daemons.prtagent.v1.TradingService/GetHistoricalQuote',
      ($5.GetHistoricalQuoteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.GetHistoricalQuoteResponse.fromBuffer(value));
  static final _$fetchLiveOhlcData = $grpc.ClientMethod<$5.FetchLiveOhlcDataRequest, $5.OhlcDataResponse>(
      '/qomet.agora.daemons.prtagent.v1.TradingService/FetchLiveOhlcData',
      ($5.FetchLiveOhlcDataRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.OhlcDataResponse.fromBuffer(value));
  static final _$getHistoricalOhlcData = $grpc.ClientMethod<$5.GetHistoricalOhlcDataRequest, $5.GetHistoricalOhlcDataResponse>(
      '/qomet.agora.daemons.prtagent.v1.TradingService/GetHistoricalOhlcData',
      ($5.GetHistoricalOhlcDataRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.GetHistoricalOhlcDataResponse.fromBuffer(value));
  static final _$getOrderFees = $grpc.ClientMethod<$5.GetOrderFeesRequest, $5.GetOrderFeesResponse>(
      '/qomet.agora.daemons.prtagent.v1.TradingService/GetOrderFees',
      ($5.GetOrderFeesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.GetOrderFeesResponse.fromBuffer(value));
  static final _$getOrderFeesAsync = $grpc.ClientMethod<$5.GetOrderFeesRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.TradingService/GetOrderFeesAsync',
      ($5.GetOrderFeesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ExecutionAsyncResponse.fromBuffer(value));
  static final _$createOrderAsync = $grpc.ClientMethod<$5.CreateOrderAsyncRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.TradingService/CreateOrderAsync',
      ($5.CreateOrderAsyncRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ExecutionAsyncResponse.fromBuffer(value));
  static final _$replaceOrderAsync = $grpc.ClientMethod<$5.ReplaceOrderAsyncRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.TradingService/ReplaceOrderAsync',
      ($5.ReplaceOrderAsyncRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ExecutionAsyncResponse.fromBuffer(value));
  static final _$cancelOrderAsync = $grpc.ClientMethod<$5.CancelOrderAsyncRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.TradingService/CancelOrderAsync',
      ($5.CancelOrderAsyncRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ExecutionAsyncResponse.fromBuffer(value));
  static final _$getOrderbook = $grpc.ClientMethod<$5.GetOrderbookRequest, $5.GetOrderbookResponse>(
      '/qomet.agora.daemons.prtagent.v1.TradingService/GetOrderbook',
      ($5.GetOrderbookRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.GetOrderbookResponse.fromBuffer(value));
  static final _$getOrderbookAsync = $grpc.ClientMethod<$5.GetOrderbookRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.TradingService/GetOrderbookAsync',
      ($5.GetOrderbookRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ExecutionAsyncResponse.fromBuffer(value));

  TradingServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$5.InstrumentQuoteResponse> getLatestQuote($5.GetLatestQuoteRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLatestQuote, request, options: options);
  }

  $grpc.ResponseStream<$5.InstrumentQuoteResponse> fetchLiveQuote($5.FetchLiveQuoteRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$fetchLiveQuote, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$5.GetHistoricalQuoteResponse> getHistoricalQuote($5.GetHistoricalQuoteRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getHistoricalQuote, request, options: options);
  }

  $grpc.ResponseStream<$5.OhlcDataResponse> fetchLiveOhlcData($5.FetchLiveOhlcDataRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$fetchLiveOhlcData, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$5.GetHistoricalOhlcDataResponse> getHistoricalOhlcData($5.GetHistoricalOhlcDataRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getHistoricalOhlcData, request, options: options);
  }

  $grpc.ResponseFuture<$5.GetOrderFeesResponse> getOrderFees($5.GetOrderFeesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrderFees, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getOrderFeesAsync($5.GetOrderFeesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrderFeesAsync, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> createOrderAsync($5.CreateOrderAsyncRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createOrderAsync, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> replaceOrderAsync($5.ReplaceOrderAsyncRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$replaceOrderAsync, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> cancelOrderAsync($5.CancelOrderAsyncRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelOrderAsync, request, options: options);
  }

  $grpc.ResponseFuture<$5.GetOrderbookResponse> getOrderbook($5.GetOrderbookRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrderbook, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getOrderbookAsync($5.GetOrderbookRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrderbookAsync, request, options: options);
  }
}

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.TradingService')
abstract class TradingServiceBase extends $grpc.Service {
  $core.String get $name => 'qomet.agora.daemons.prtagent.v1.TradingService';

  TradingServiceBase() {
    $addMethod($grpc.ServiceMethod<$5.GetLatestQuoteRequest, $5.InstrumentQuoteResponse>(
        'GetLatestQuote',
        getLatestQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.GetLatestQuoteRequest.fromBuffer(value),
        ($5.InstrumentQuoteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.FetchLiveQuoteRequest, $5.InstrumentQuoteResponse>(
        'FetchLiveQuote',
        fetchLiveQuote_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $5.FetchLiveQuoteRequest.fromBuffer(value),
        ($5.InstrumentQuoteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.GetHistoricalQuoteRequest, $5.GetHistoricalQuoteResponse>(
        'GetHistoricalQuote',
        getHistoricalQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.GetHistoricalQuoteRequest.fromBuffer(value),
        ($5.GetHistoricalQuoteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.FetchLiveOhlcDataRequest, $5.OhlcDataResponse>(
        'FetchLiveOhlcData',
        fetchLiveOhlcData_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $5.FetchLiveOhlcDataRequest.fromBuffer(value),
        ($5.OhlcDataResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.GetHistoricalOhlcDataRequest, $5.GetHistoricalOhlcDataResponse>(
        'GetHistoricalOhlcData',
        getHistoricalOhlcData_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.GetHistoricalOhlcDataRequest.fromBuffer(value),
        ($5.GetHistoricalOhlcDataResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.GetOrderFeesRequest, $5.GetOrderFeesResponse>(
        'GetOrderFees',
        getOrderFees_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.GetOrderFeesRequest.fromBuffer(value),
        ($5.GetOrderFeesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.GetOrderFeesRequest, $1.ExecutionAsyncResponse>(
        'GetOrderFeesAsync',
        getOrderFeesAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.GetOrderFeesRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.CreateOrderAsyncRequest, $1.ExecutionAsyncResponse>(
        'CreateOrderAsync',
        createOrderAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.CreateOrderAsyncRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.ReplaceOrderAsyncRequest, $1.ExecutionAsyncResponse>(
        'ReplaceOrderAsync',
        replaceOrderAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.ReplaceOrderAsyncRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.CancelOrderAsyncRequest, $1.ExecutionAsyncResponse>(
        'CancelOrderAsync',
        cancelOrderAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.CancelOrderAsyncRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.GetOrderbookRequest, $5.GetOrderbookResponse>(
        'GetOrderbook',
        getOrderbook_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.GetOrderbookRequest.fromBuffer(value),
        ($5.GetOrderbookResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.GetOrderbookRequest, $1.ExecutionAsyncResponse>(
        'GetOrderbookAsync',
        getOrderbookAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.GetOrderbookRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
  }

  $async.Future<$5.InstrumentQuoteResponse> getLatestQuote_Pre($grpc.ServiceCall call, $async.Future<$5.GetLatestQuoteRequest> request) async {
    return getLatestQuote(call, await request);
  }

  $async.Stream<$5.InstrumentQuoteResponse> fetchLiveQuote_Pre($grpc.ServiceCall call, $async.Future<$5.FetchLiveQuoteRequest> request) async* {
    yield* fetchLiveQuote(call, await request);
  }

  $async.Future<$5.GetHistoricalQuoteResponse> getHistoricalQuote_Pre($grpc.ServiceCall call, $async.Future<$5.GetHistoricalQuoteRequest> request) async {
    return getHistoricalQuote(call, await request);
  }

  $async.Stream<$5.OhlcDataResponse> fetchLiveOhlcData_Pre($grpc.ServiceCall call, $async.Future<$5.FetchLiveOhlcDataRequest> request) async* {
    yield* fetchLiveOhlcData(call, await request);
  }

  $async.Future<$5.GetHistoricalOhlcDataResponse> getHistoricalOhlcData_Pre($grpc.ServiceCall call, $async.Future<$5.GetHistoricalOhlcDataRequest> request) async {
    return getHistoricalOhlcData(call, await request);
  }

  $async.Future<$5.GetOrderFeesResponse> getOrderFees_Pre($grpc.ServiceCall call, $async.Future<$5.GetOrderFeesRequest> request) async {
    return getOrderFees(call, await request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getOrderFeesAsync_Pre($grpc.ServiceCall call, $async.Future<$5.GetOrderFeesRequest> request) async {
    return getOrderFeesAsync(call, await request);
  }

  $async.Future<$1.ExecutionAsyncResponse> createOrderAsync_Pre($grpc.ServiceCall call, $async.Future<$5.CreateOrderAsyncRequest> request) async {
    return createOrderAsync(call, await request);
  }

  $async.Future<$1.ExecutionAsyncResponse> replaceOrderAsync_Pre($grpc.ServiceCall call, $async.Future<$5.ReplaceOrderAsyncRequest> request) async {
    return replaceOrderAsync(call, await request);
  }

  $async.Future<$1.ExecutionAsyncResponse> cancelOrderAsync_Pre($grpc.ServiceCall call, $async.Future<$5.CancelOrderAsyncRequest> request) async {
    return cancelOrderAsync(call, await request);
  }

  $async.Future<$5.GetOrderbookResponse> getOrderbook_Pre($grpc.ServiceCall call, $async.Future<$5.GetOrderbookRequest> request) async {
    return getOrderbook(call, await request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getOrderbookAsync_Pre($grpc.ServiceCall call, $async.Future<$5.GetOrderbookRequest> request) async {
    return getOrderbookAsync(call, await request);
  }

  $async.Future<$5.InstrumentQuoteResponse> getLatestQuote($grpc.ServiceCall call, $5.GetLatestQuoteRequest request);
  $async.Stream<$5.InstrumentQuoteResponse> fetchLiveQuote($grpc.ServiceCall call, $5.FetchLiveQuoteRequest request);
  $async.Future<$5.GetHistoricalQuoteResponse> getHistoricalQuote($grpc.ServiceCall call, $5.GetHistoricalQuoteRequest request);
  $async.Stream<$5.OhlcDataResponse> fetchLiveOhlcData($grpc.ServiceCall call, $5.FetchLiveOhlcDataRequest request);
  $async.Future<$5.GetHistoricalOhlcDataResponse> getHistoricalOhlcData($grpc.ServiceCall call, $5.GetHistoricalOhlcDataRequest request);
  $async.Future<$5.GetOrderFeesResponse> getOrderFees($grpc.ServiceCall call, $5.GetOrderFeesRequest request);
  $async.Future<$1.ExecutionAsyncResponse> getOrderFeesAsync($grpc.ServiceCall call, $5.GetOrderFeesRequest request);
  $async.Future<$1.ExecutionAsyncResponse> createOrderAsync($grpc.ServiceCall call, $5.CreateOrderAsyncRequest request);
  $async.Future<$1.ExecutionAsyncResponse> replaceOrderAsync($grpc.ServiceCall call, $5.ReplaceOrderAsyncRequest request);
  $async.Future<$1.ExecutionAsyncResponse> cancelOrderAsync($grpc.ServiceCall call, $5.CancelOrderAsyncRequest request);
  $async.Future<$5.GetOrderbookResponse> getOrderbook($grpc.ServiceCall call, $5.GetOrderbookRequest request);
  $async.Future<$1.ExecutionAsyncResponse> getOrderbookAsync($grpc.ServiceCall call, $5.GetOrderbookRequest request);
}
