// This is a generated file - do not edit.
//
// Generated from instrument.proto.

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

  $grpc.ResponseFuture<$0.GetInstrumentListResponse> getInstrumentList(
    $0.GetInstrumentListRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getInstrumentList, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getInstrumentListAsync(
    $0.GetInstrumentListRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getInstrumentListAsync, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetInstrumentInfoBatchResponse>
      getInstrumentInfoBatch(
    $0.GetInstrumentInfoBatchRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getInstrumentInfoBatch, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getInstrumentInfoBatchAsync(
    $0.GetInstrumentInfoBatchRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getInstrumentInfoBatchAsync, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetInstrumentOrdersResponse> getInstrumentOrders(
    $0.GetInstrumentOrdersRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getInstrumentOrders, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getInstrumentOrdersAsync(
    $0.GetInstrumentOrdersRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getInstrumentOrdersAsync, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetInstrumentTradesResponse> getInstrumentTrades(
    $0.GetInstrumentTradesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getInstrumentTrades, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getInstrumentTradesAsync(
    $0.GetInstrumentTradesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getInstrumentTradesAsync, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetInstrumentSettlementsResponse>
      getInstrumentSettlements(
    $0.GetInstrumentSettlementsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getInstrumentSettlements, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getInstrumentSettlementsAsync(
    $0.GetInstrumentSettlementsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getInstrumentSettlementsAsync, request,
        options: options);
  }

  // method descriptors

  static final _$getInstrumentList = $grpc.ClientMethod<
          $0.GetInstrumentListRequest, $0.GetInstrumentListResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetInstrumentList',
      ($0.GetInstrumentListRequest value) => value.writeToBuffer(),
      $0.GetInstrumentListResponse.fromBuffer);
  static final _$getInstrumentListAsync = $grpc.ClientMethod<
          $0.GetInstrumentListRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetInstrumentListAsync',
      ($0.GetInstrumentListRequest value) => value.writeToBuffer(),
      $1.ExecutionAsyncResponse.fromBuffer);
  static final _$getInstrumentInfoBatch = $grpc.ClientMethod<
          $0.GetInstrumentInfoBatchRequest, $0.GetInstrumentInfoBatchResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetInstrumentInfoBatch',
      ($0.GetInstrumentInfoBatchRequest value) => value.writeToBuffer(),
      $0.GetInstrumentInfoBatchResponse.fromBuffer);
  static final _$getInstrumentInfoBatchAsync = $grpc.ClientMethod<
          $0.GetInstrumentInfoBatchRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetInstrumentInfoBatchAsync',
      ($0.GetInstrumentInfoBatchRequest value) => value.writeToBuffer(),
      $1.ExecutionAsyncResponse.fromBuffer);
  static final _$getInstrumentOrders = $grpc.ClientMethod<
          $0.GetInstrumentOrdersRequest, $0.GetInstrumentOrdersResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetInstrumentOrders',
      ($0.GetInstrumentOrdersRequest value) => value.writeToBuffer(),
      $0.GetInstrumentOrdersResponse.fromBuffer);
  static final _$getInstrumentOrdersAsync = $grpc.ClientMethod<
          $0.GetInstrumentOrdersRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetInstrumentOrdersAsync',
      ($0.GetInstrumentOrdersRequest value) => value.writeToBuffer(),
      $1.ExecutionAsyncResponse.fromBuffer);
  static final _$getInstrumentTrades = $grpc.ClientMethod<
          $0.GetInstrumentTradesRequest, $0.GetInstrumentTradesResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetInstrumentTrades',
      ($0.GetInstrumentTradesRequest value) => value.writeToBuffer(),
      $0.GetInstrumentTradesResponse.fromBuffer);
  static final _$getInstrumentTradesAsync = $grpc.ClientMethod<
          $0.GetInstrumentTradesRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetInstrumentTradesAsync',
      ($0.GetInstrumentTradesRequest value) => value.writeToBuffer(),
      $1.ExecutionAsyncResponse.fromBuffer);
  static final _$getInstrumentSettlements = $grpc.ClientMethod<
          $0.GetInstrumentSettlementsRequest,
          $0.GetInstrumentSettlementsResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetInstrumentSettlements',
      ($0.GetInstrumentSettlementsRequest value) => value.writeToBuffer(),
      $0.GetInstrumentSettlementsResponse.fromBuffer);
  static final _$getInstrumentSettlementsAsync = $grpc.ClientMethod<
          $0.GetInstrumentSettlementsRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetInstrumentSettlementsAsync',
      ($0.GetInstrumentSettlementsRequest value) => value.writeToBuffer(),
      $1.ExecutionAsyncResponse.fromBuffer);
}

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.InstrumentService')
abstract class InstrumentServiceBase extends $grpc.Service {
  $core.String get $name => 'qomet.agora.daemons.prtagent.v1.InstrumentService';

  InstrumentServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetInstrumentListRequest,
            $0.GetInstrumentListResponse>(
        'GetInstrumentList',
        getInstrumentList_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInstrumentListRequest.fromBuffer(value),
        ($0.GetInstrumentListResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInstrumentListRequest,
            $1.ExecutionAsyncResponse>(
        'GetInstrumentListAsync',
        getInstrumentListAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInstrumentListRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInstrumentInfoBatchRequest,
            $0.GetInstrumentInfoBatchResponse>(
        'GetInstrumentInfoBatch',
        getInstrumentInfoBatch_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInstrumentInfoBatchRequest.fromBuffer(value),
        ($0.GetInstrumentInfoBatchResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInstrumentInfoBatchRequest,
            $1.ExecutionAsyncResponse>(
        'GetInstrumentInfoBatchAsync',
        getInstrumentInfoBatchAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInstrumentInfoBatchRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInstrumentOrdersRequest,
            $0.GetInstrumentOrdersResponse>(
        'GetInstrumentOrders',
        getInstrumentOrders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInstrumentOrdersRequest.fromBuffer(value),
        ($0.GetInstrumentOrdersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInstrumentOrdersRequest,
            $1.ExecutionAsyncResponse>(
        'GetInstrumentOrdersAsync',
        getInstrumentOrdersAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInstrumentOrdersRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInstrumentTradesRequest,
            $0.GetInstrumentTradesResponse>(
        'GetInstrumentTrades',
        getInstrumentTrades_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInstrumentTradesRequest.fromBuffer(value),
        ($0.GetInstrumentTradesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInstrumentTradesRequest,
            $1.ExecutionAsyncResponse>(
        'GetInstrumentTradesAsync',
        getInstrumentTradesAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInstrumentTradesRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInstrumentSettlementsRequest,
            $0.GetInstrumentSettlementsResponse>(
        'GetInstrumentSettlements',
        getInstrumentSettlements_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInstrumentSettlementsRequest.fromBuffer(value),
        ($0.GetInstrumentSettlementsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInstrumentSettlementsRequest,
            $1.ExecutionAsyncResponse>(
        'GetInstrumentSettlementsAsync',
        getInstrumentSettlementsAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInstrumentSettlementsRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetInstrumentListResponse> getInstrumentList_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetInstrumentListRequest> $request) async {
    return getInstrumentList($call, await $request);
  }

  $async.Future<$0.GetInstrumentListResponse> getInstrumentList(
      $grpc.ServiceCall call, $0.GetInstrumentListRequest request);

  $async.Future<$1.ExecutionAsyncResponse> getInstrumentListAsync_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetInstrumentListRequest> $request) async {
    return getInstrumentListAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getInstrumentListAsync(
      $grpc.ServiceCall call, $0.GetInstrumentListRequest request);

  $async.Future<$0.GetInstrumentInfoBatchResponse> getInstrumentInfoBatch_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetInstrumentInfoBatchRequest> $request) async {
    return getInstrumentInfoBatch($call, await $request);
  }

  $async.Future<$0.GetInstrumentInfoBatchResponse> getInstrumentInfoBatch(
      $grpc.ServiceCall call, $0.GetInstrumentInfoBatchRequest request);

  $async.Future<$1.ExecutionAsyncResponse> getInstrumentInfoBatchAsync_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetInstrumentInfoBatchRequest> $request) async {
    return getInstrumentInfoBatchAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getInstrumentInfoBatchAsync(
      $grpc.ServiceCall call, $0.GetInstrumentInfoBatchRequest request);

  $async.Future<$0.GetInstrumentOrdersResponse> getInstrumentOrders_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetInstrumentOrdersRequest> $request) async {
    return getInstrumentOrders($call, await $request);
  }

  $async.Future<$0.GetInstrumentOrdersResponse> getInstrumentOrders(
      $grpc.ServiceCall call, $0.GetInstrumentOrdersRequest request);

  $async.Future<$1.ExecutionAsyncResponse> getInstrumentOrdersAsync_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetInstrumentOrdersRequest> $request) async {
    return getInstrumentOrdersAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getInstrumentOrdersAsync(
      $grpc.ServiceCall call, $0.GetInstrumentOrdersRequest request);

  $async.Future<$0.GetInstrumentTradesResponse> getInstrumentTrades_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetInstrumentTradesRequest> $request) async {
    return getInstrumentTrades($call, await $request);
  }

  $async.Future<$0.GetInstrumentTradesResponse> getInstrumentTrades(
      $grpc.ServiceCall call, $0.GetInstrumentTradesRequest request);

  $async.Future<$1.ExecutionAsyncResponse> getInstrumentTradesAsync_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetInstrumentTradesRequest> $request) async {
    return getInstrumentTradesAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getInstrumentTradesAsync(
      $grpc.ServiceCall call, $0.GetInstrumentTradesRequest request);

  $async.Future<$0.GetInstrumentSettlementsResponse>
      getInstrumentSettlements_Pre($grpc.ServiceCall $call,
          $async.Future<$0.GetInstrumentSettlementsRequest> $request) async {
    return getInstrumentSettlements($call, await $request);
  }

  $async.Future<$0.GetInstrumentSettlementsResponse> getInstrumentSettlements(
      $grpc.ServiceCall call, $0.GetInstrumentSettlementsRequest request);

  $async.Future<$1.ExecutionAsyncResponse> getInstrumentSettlementsAsync_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetInstrumentSettlementsRequest> $request) async {
    return getInstrumentSettlementsAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getInstrumentSettlementsAsync(
      $grpc.ServiceCall call, $0.GetInstrumentSettlementsRequest request);
}
