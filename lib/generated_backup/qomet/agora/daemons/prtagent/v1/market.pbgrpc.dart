// This is a generated file - do not edit.
//
// Generated from qomet/agora/daemons/prtagent/v1/market.proto.

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

import 'market.pb.dart' as $0;

export 'market.pb.dart';

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.MarketService')
class MarketServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  MarketServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.GetMarketListResponse> getMarketList(
    $0.GetMarketListRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getMarketList, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMarketsInfoResponse> getMarketsInfo(
    $0.GetMarketsInfoRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getMarketsInfo, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMarketCalendarResponse> getMarketCalendar(
    $0.GetMarketCalendarRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getMarketCalendar, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMarketSupportedCurrenciesResponse>
      getMarketSupportedCurrencies(
    $0.GetMarketSupportedCurrenciesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getMarketSupportedCurrencies, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetMarketInstrumentListResponse>
      getMarketInstrumentList(
    $0.GetMarketInstrumentListRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getMarketInstrumentList, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetOrderFeesResponse> getOrderFees(
    $0.GetOrderFeesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getOrderFees, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateOrderResponse> createOrder(
    $0.CreateOrderRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createOrder, request, options: options);
  }

  $grpc.ResponseFuture<$0.ReplaceOrderResponse> replaceOrder(
    $0.ReplaceOrderRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$replaceOrder, request, options: options);
  }

  $grpc.ResponseFuture<$0.CancelOrderResponse> cancelOrder(
    $0.CancelOrderRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$cancelOrder, request, options: options);
  }

  // method descriptors

  static final _$getMarketList =
      $grpc.ClientMethod<$0.GetMarketListRequest, $0.GetMarketListResponse>(
          '/qomet.agora.daemons.prtagent.v1.MarketService/GetMarketList',
          ($0.GetMarketListRequest value) => value.writeToBuffer(),
          $0.GetMarketListResponse.fromBuffer);
  static final _$getMarketsInfo =
      $grpc.ClientMethod<$0.GetMarketsInfoRequest, $0.GetMarketsInfoResponse>(
          '/qomet.agora.daemons.prtagent.v1.MarketService/GetMarketsInfo',
          ($0.GetMarketsInfoRequest value) => value.writeToBuffer(),
          $0.GetMarketsInfoResponse.fromBuffer);
  static final _$getMarketCalendar = $grpc.ClientMethod<
          $0.GetMarketCalendarRequest, $0.GetMarketCalendarResponse>(
      '/qomet.agora.daemons.prtagent.v1.MarketService/GetMarketCalendar',
      ($0.GetMarketCalendarRequest value) => value.writeToBuffer(),
      $0.GetMarketCalendarResponse.fromBuffer);
  static final _$getMarketSupportedCurrencies = $grpc.ClientMethod<
          $0.GetMarketSupportedCurrenciesRequest,
          $0.GetMarketSupportedCurrenciesResponse>(
      '/qomet.agora.daemons.prtagent.v1.MarketService/GetMarketSupportedCurrencies',
      ($0.GetMarketSupportedCurrenciesRequest value) => value.writeToBuffer(),
      $0.GetMarketSupportedCurrenciesResponse.fromBuffer);
  static final _$getMarketInstrumentList = $grpc.ClientMethod<
          $0.GetMarketInstrumentListRequest,
          $0.GetMarketInstrumentListResponse>(
      '/qomet.agora.daemons.prtagent.v1.MarketService/GetMarketInstrumentList',
      ($0.GetMarketInstrumentListRequest value) => value.writeToBuffer(),
      $0.GetMarketInstrumentListResponse.fromBuffer);
  static final _$getOrderFees =
      $grpc.ClientMethod<$0.GetOrderFeesRequest, $0.GetOrderFeesResponse>(
          '/qomet.agora.daemons.prtagent.v1.TradingService/GetOrderFees',
          ($0.GetOrderFeesRequest value) => value.writeToBuffer(),
          $0.GetOrderFeesResponse.fromBuffer);
  static final _$createOrder =
      $grpc.ClientMethod<$0.CreateOrderRequest, $0.CreateOrderResponse>(
          '/qomet.agora.daemons.prtagent.v1.TradingService/CreateOrder',
          ($0.CreateOrderRequest value) => value.writeToBuffer(),
          $0.CreateOrderResponse.fromBuffer);
  static final _$replaceOrder =
      $grpc.ClientMethod<$0.ReplaceOrderRequest, $0.ReplaceOrderResponse>(
          '/qomet.agora.daemons.prtagent.v1.TradingService/ReplaceOrder',
          ($0.ReplaceOrderRequest value) => value.writeToBuffer(),
          $0.ReplaceOrderResponse.fromBuffer);
  static final _$cancelOrder =
      $grpc.ClientMethod<$0.CancelOrderRequest, $0.CancelOrderResponse>(
          '/qomet.agora.daemons.prtagent.v1.TradingService/CancelOrder',
          ($0.CancelOrderRequest value) => value.writeToBuffer(),
          $0.CancelOrderResponse.fromBuffer);
}

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.MarketService')
abstract class MarketServiceBase extends $grpc.Service {
  $core.String get $name => 'qomet.agora.daemons.prtagent.v1.MarketService';

  MarketServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.GetMarketListRequest, $0.GetMarketListResponse>(
            'GetMarketList',
            getMarketList_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetMarketListRequest.fromBuffer(value),
            ($0.GetMarketListResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMarketsInfoRequest,
            $0.GetMarketsInfoResponse>(
        'GetMarketsInfo',
        getMarketsInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMarketsInfoRequest.fromBuffer(value),
        ($0.GetMarketsInfoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMarketCalendarRequest,
            $0.GetMarketCalendarResponse>(
        'GetMarketCalendar',
        getMarketCalendar_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMarketCalendarRequest.fromBuffer(value),
        ($0.GetMarketCalendarResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMarketSupportedCurrenciesRequest,
            $0.GetMarketSupportedCurrenciesResponse>(
        'GetMarketSupportedCurrencies',
        getMarketSupportedCurrencies_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMarketSupportedCurrenciesRequest.fromBuffer(value),
        ($0.GetMarketSupportedCurrenciesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMarketInstrumentListRequest,
            $0.GetMarketInstrumentListResponse>(
        'GetMarketInstrumentList',
        getMarketInstrumentList_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMarketInstrumentListRequest.fromBuffer(value),
        ($0.GetMarketInstrumentListResponse value) => value.writeToBuffer()));
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
        $grpc.ServiceMethod<$0.CreateOrderRequest, $0.CreateOrderResponse>(
            'CreateOrder',
            createOrder_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.CreateOrderRequest.fromBuffer(value),
            ($0.CreateOrderResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ReplaceOrderRequest, $0.ReplaceOrderResponse>(
            'ReplaceOrder',
            replaceOrder_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ReplaceOrderRequest.fromBuffer(value),
            ($0.ReplaceOrderResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.CancelOrderRequest, $0.CancelOrderResponse>(
            'CancelOrder',
            cancelOrder_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.CancelOrderRequest.fromBuffer(value),
            ($0.CancelOrderResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetMarketListResponse> getMarketList_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetMarketListRequest> $request) async {
    return getMarketList($call, await $request);
  }

  $async.Future<$0.GetMarketListResponse> getMarketList(
      $grpc.ServiceCall call, $0.GetMarketListRequest request);

  $async.Future<$0.GetMarketsInfoResponse> getMarketsInfo_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetMarketsInfoRequest> $request) async {
    return getMarketsInfo($call, await $request);
  }

  $async.Future<$0.GetMarketsInfoResponse> getMarketsInfo(
      $grpc.ServiceCall call, $0.GetMarketsInfoRequest request);

  $async.Future<$0.GetMarketCalendarResponse> getMarketCalendar_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetMarketCalendarRequest> $request) async {
    return getMarketCalendar($call, await $request);
  }

  $async.Future<$0.GetMarketCalendarResponse> getMarketCalendar(
      $grpc.ServiceCall call, $0.GetMarketCalendarRequest request);

  $async.Future<$0.GetMarketSupportedCurrenciesResponse>
      getMarketSupportedCurrencies_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$0.GetMarketSupportedCurrenciesRequest>
              $request) async {
    return getMarketSupportedCurrencies($call, await $request);
  }

  $async.Future<$0.GetMarketSupportedCurrenciesResponse>
      getMarketSupportedCurrencies($grpc.ServiceCall call,
          $0.GetMarketSupportedCurrenciesRequest request);

  $async.Future<$0.GetMarketInstrumentListResponse> getMarketInstrumentList_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetMarketInstrumentListRequest> $request) async {
    return getMarketInstrumentList($call, await $request);
  }

  $async.Future<$0.GetMarketInstrumentListResponse> getMarketInstrumentList(
      $grpc.ServiceCall call, $0.GetMarketInstrumentListRequest request);

  $async.Future<$0.GetOrderFeesResponse> getOrderFees_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetOrderFeesRequest> $request) async {
    return getOrderFees($call, await $request);
  }

  $async.Future<$0.GetOrderFeesResponse> getOrderFees(
      $grpc.ServiceCall call, $0.GetOrderFeesRequest request);

  $async.Future<$0.CreateOrderResponse> createOrder_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CreateOrderRequest> $request) async {
    return createOrder($call, await $request);
  }

  $async.Future<$0.CreateOrderResponse> createOrder(
      $grpc.ServiceCall call, $0.CreateOrderRequest request);

  $async.Future<$0.ReplaceOrderResponse> replaceOrder_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ReplaceOrderRequest> $request) async {
    return replaceOrder($call, await $request);
  }

  $async.Future<$0.ReplaceOrderResponse> replaceOrder(
      $grpc.ServiceCall call, $0.ReplaceOrderRequest request);

  $async.Future<$0.CancelOrderResponse> cancelOrder_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CancelOrderRequest> $request) async {
    return cancelOrder($call, await $request);
  }

  $async.Future<$0.CancelOrderResponse> cancelOrder(
      $grpc.ServiceCall call, $0.CancelOrderRequest request);
}
