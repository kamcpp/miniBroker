//
//  Generated code. Do not modify.
//  source: instrument.proto
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
import 'instrument.pb.dart' as $2;

export 'instrument.pb.dart';

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.InstrumentService')
class InstrumentServiceClient extends $grpc.Client {
  static final _$getInstrumentList = $grpc.ClientMethod<$2.GetInstrumentListRequest, $2.GetInstrumentListResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetInstrumentList',
      ($2.GetInstrumentListRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.GetInstrumentListResponse.fromBuffer(value));
  static final _$getInstrumentListAsync = $grpc.ClientMethod<$2.GetInstrumentListRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetInstrumentListAsync',
      ($2.GetInstrumentListRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ExecutionAsyncResponse.fromBuffer(value));
  static final _$getInstrumentInfoBatch = $grpc.ClientMethod<$2.GetInstrumentInfoBatchRequest, $2.GetInstrumentInfoBatchResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetInstrumentInfoBatch',
      ($2.GetInstrumentInfoBatchRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.GetInstrumentInfoBatchResponse.fromBuffer(value));
  static final _$getInstrumentInfoBatchAsync = $grpc.ClientMethod<$2.GetInstrumentInfoBatchRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetInstrumentInfoBatchAsync',
      ($2.GetInstrumentInfoBatchRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ExecutionAsyncResponse.fromBuffer(value));
  static final _$getInstrumentOrders = $grpc.ClientMethod<$2.GetInstrumentOrdersRequest, $2.GetInstrumentOrdersResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetInstrumentOrders',
      ($2.GetInstrumentOrdersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.GetInstrumentOrdersResponse.fromBuffer(value));
  static final _$getInstrumentOrdersAsync = $grpc.ClientMethod<$2.GetInstrumentOrdersRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetInstrumentOrdersAsync',
      ($2.GetInstrumentOrdersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ExecutionAsyncResponse.fromBuffer(value));
  static final _$getInstrumentTrades = $grpc.ClientMethod<$2.GetInstrumentTradesRequest, $2.GetInstrumentTradesResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetInstrumentTrades',
      ($2.GetInstrumentTradesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.GetInstrumentTradesResponse.fromBuffer(value));
  static final _$getInstrumentTradesAsync = $grpc.ClientMethod<$2.GetInstrumentTradesRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetInstrumentTradesAsync',
      ($2.GetInstrumentTradesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ExecutionAsyncResponse.fromBuffer(value));
  static final _$getInstrumentSettlements = $grpc.ClientMethod<$2.GetInstrumentSettlementsRequest, $2.GetInstrumentSettlementsResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetInstrumentSettlements',
      ($2.GetInstrumentSettlementsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.GetInstrumentSettlementsResponse.fromBuffer(value));
  static final _$getInstrumentSettlementsAsync = $grpc.ClientMethod<$2.GetInstrumentSettlementsRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.InstrumentService/GetInstrumentSettlementsAsync',
      ($2.GetInstrumentSettlementsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ExecutionAsyncResponse.fromBuffer(value));

  InstrumentServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$2.GetInstrumentListResponse> getInstrumentList($2.GetInstrumentListRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInstrumentList, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getInstrumentListAsync($2.GetInstrumentListRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInstrumentListAsync, request, options: options);
  }

  $grpc.ResponseFuture<$2.GetInstrumentInfoBatchResponse> getInstrumentInfoBatch($2.GetInstrumentInfoBatchRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInstrumentInfoBatch, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getInstrumentInfoBatchAsync($2.GetInstrumentInfoBatchRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInstrumentInfoBatchAsync, request, options: options);
  }

  $grpc.ResponseFuture<$2.GetInstrumentOrdersResponse> getInstrumentOrders($2.GetInstrumentOrdersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInstrumentOrders, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getInstrumentOrdersAsync($2.GetInstrumentOrdersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInstrumentOrdersAsync, request, options: options);
  }

  $grpc.ResponseFuture<$2.GetInstrumentTradesResponse> getInstrumentTrades($2.GetInstrumentTradesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInstrumentTrades, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getInstrumentTradesAsync($2.GetInstrumentTradesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInstrumentTradesAsync, request, options: options);
  }

  $grpc.ResponseFuture<$2.GetInstrumentSettlementsResponse> getInstrumentSettlements($2.GetInstrumentSettlementsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInstrumentSettlements, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getInstrumentSettlementsAsync($2.GetInstrumentSettlementsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInstrumentSettlementsAsync, request, options: options);
  }
}

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.InstrumentService')
abstract class InstrumentServiceBase extends $grpc.Service {
  $core.String get $name => 'qomet.agora.daemons.prtagent.v1.InstrumentService';

  InstrumentServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.GetInstrumentListRequest, $2.GetInstrumentListResponse>(
        'GetInstrumentList',
        getInstrumentList_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetInstrumentListRequest.fromBuffer(value),
        ($2.GetInstrumentListResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetInstrumentListRequest, $1.ExecutionAsyncResponse>(
        'GetInstrumentListAsync',
        getInstrumentListAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetInstrumentListRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetInstrumentInfoBatchRequest, $2.GetInstrumentInfoBatchResponse>(
        'GetInstrumentInfoBatch',
        getInstrumentInfoBatch_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetInstrumentInfoBatchRequest.fromBuffer(value),
        ($2.GetInstrumentInfoBatchResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetInstrumentInfoBatchRequest, $1.ExecutionAsyncResponse>(
        'GetInstrumentInfoBatchAsync',
        getInstrumentInfoBatchAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetInstrumentInfoBatchRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetInstrumentOrdersRequest, $2.GetInstrumentOrdersResponse>(
        'GetInstrumentOrders',
        getInstrumentOrders_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetInstrumentOrdersRequest.fromBuffer(value),
        ($2.GetInstrumentOrdersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetInstrumentOrdersRequest, $1.ExecutionAsyncResponse>(
        'GetInstrumentOrdersAsync',
        getInstrumentOrdersAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetInstrumentOrdersRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetInstrumentTradesRequest, $2.GetInstrumentTradesResponse>(
        'GetInstrumentTrades',
        getInstrumentTrades_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetInstrumentTradesRequest.fromBuffer(value),
        ($2.GetInstrumentTradesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetInstrumentTradesRequest, $1.ExecutionAsyncResponse>(
        'GetInstrumentTradesAsync',
        getInstrumentTradesAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetInstrumentTradesRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetInstrumentSettlementsRequest, $2.GetInstrumentSettlementsResponse>(
        'GetInstrumentSettlements',
        getInstrumentSettlements_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetInstrumentSettlementsRequest.fromBuffer(value),
        ($2.GetInstrumentSettlementsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetInstrumentSettlementsRequest, $1.ExecutionAsyncResponse>(
        'GetInstrumentSettlementsAsync',
        getInstrumentSettlementsAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetInstrumentSettlementsRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
  }

  $async.Future<$2.GetInstrumentListResponse> getInstrumentList_Pre($grpc.ServiceCall call, $async.Future<$2.GetInstrumentListRequest> request) async {
    return getInstrumentList(call, await request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getInstrumentListAsync_Pre($grpc.ServiceCall call, $async.Future<$2.GetInstrumentListRequest> request) async {
    return getInstrumentListAsync(call, await request);
  }

  $async.Future<$2.GetInstrumentInfoBatchResponse> getInstrumentInfoBatch_Pre($grpc.ServiceCall call, $async.Future<$2.GetInstrumentInfoBatchRequest> request) async {
    return getInstrumentInfoBatch(call, await request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getInstrumentInfoBatchAsync_Pre($grpc.ServiceCall call, $async.Future<$2.GetInstrumentInfoBatchRequest> request) async {
    return getInstrumentInfoBatchAsync(call, await request);
  }

  $async.Future<$2.GetInstrumentOrdersResponse> getInstrumentOrders_Pre($grpc.ServiceCall call, $async.Future<$2.GetInstrumentOrdersRequest> request) async {
    return getInstrumentOrders(call, await request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getInstrumentOrdersAsync_Pre($grpc.ServiceCall call, $async.Future<$2.GetInstrumentOrdersRequest> request) async {
    return getInstrumentOrdersAsync(call, await request);
  }

  $async.Future<$2.GetInstrumentTradesResponse> getInstrumentTrades_Pre($grpc.ServiceCall call, $async.Future<$2.GetInstrumentTradesRequest> request) async {
    return getInstrumentTrades(call, await request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getInstrumentTradesAsync_Pre($grpc.ServiceCall call, $async.Future<$2.GetInstrumentTradesRequest> request) async {
    return getInstrumentTradesAsync(call, await request);
  }

  $async.Future<$2.GetInstrumentSettlementsResponse> getInstrumentSettlements_Pre($grpc.ServiceCall call, $async.Future<$2.GetInstrumentSettlementsRequest> request) async {
    return getInstrumentSettlements(call, await request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getInstrumentSettlementsAsync_Pre($grpc.ServiceCall call, $async.Future<$2.GetInstrumentSettlementsRequest> request) async {
    return getInstrumentSettlementsAsync(call, await request);
  }

  $async.Future<$2.GetInstrumentListResponse> getInstrumentList($grpc.ServiceCall call, $2.GetInstrumentListRequest request);
  $async.Future<$1.ExecutionAsyncResponse> getInstrumentListAsync($grpc.ServiceCall call, $2.GetInstrumentListRequest request);
  $async.Future<$2.GetInstrumentInfoBatchResponse> getInstrumentInfoBatch($grpc.ServiceCall call, $2.GetInstrumentInfoBatchRequest request);
  $async.Future<$1.ExecutionAsyncResponse> getInstrumentInfoBatchAsync($grpc.ServiceCall call, $2.GetInstrumentInfoBatchRequest request);
  $async.Future<$2.GetInstrumentOrdersResponse> getInstrumentOrders($grpc.ServiceCall call, $2.GetInstrumentOrdersRequest request);
  $async.Future<$1.ExecutionAsyncResponse> getInstrumentOrdersAsync($grpc.ServiceCall call, $2.GetInstrumentOrdersRequest request);
  $async.Future<$2.GetInstrumentTradesResponse> getInstrumentTrades($grpc.ServiceCall call, $2.GetInstrumentTradesRequest request);
  $async.Future<$1.ExecutionAsyncResponse> getInstrumentTradesAsync($grpc.ServiceCall call, $2.GetInstrumentTradesRequest request);
  $async.Future<$2.GetInstrumentSettlementsResponse> getInstrumentSettlements($grpc.ServiceCall call, $2.GetInstrumentSettlementsRequest request);
  $async.Future<$1.ExecutionAsyncResponse> getInstrumentSettlementsAsync($grpc.ServiceCall call, $2.GetInstrumentSettlementsRequest request);
}
