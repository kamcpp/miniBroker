//
//  Generated code. Do not modify.
//  source: participant.proto
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
import 'participant.pb.dart' as $4;

export 'participant.pb.dart';

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.ParticipantService')
class ParticipantServiceClient extends $grpc.Client {
  static final _$getParticipantInfo = $grpc.ClientMethod<$4.GetParticipantInfoRequest, $4.GetParticipantInfoResponse>(
      '/qomet.agora.daemons.prtagent.v1.ParticipantService/GetParticipantInfo',
      ($4.GetParticipantInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.GetParticipantInfoResponse.fromBuffer(value));
  static final _$getParticipantInfoAsync = $grpc.ClientMethod<$4.GetParticipantInfoRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.ParticipantService/GetParticipantInfoAsync',
      ($4.GetParticipantInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ExecutionAsyncResponse.fromBuffer(value));
  static final _$getParticipantOrders = $grpc.ClientMethod<$4.GetParticipantOrdersRequest, $4.GetParticipantOrdersResponse>(
      '/qomet.agora.daemons.prtagent.v1.ParticipantService/GetParticipantOrders',
      ($4.GetParticipantOrdersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.GetParticipantOrdersResponse.fromBuffer(value));
  static final _$getParticipantOrdersAsync = $grpc.ClientMethod<$4.GetParticipantOrdersRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.ParticipantService/GetParticipantOrdersAsync',
      ($4.GetParticipantOrdersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ExecutionAsyncResponse.fromBuffer(value));
  static final _$getParticipantTrades = $grpc.ClientMethod<$4.GetParticipantTradesRequest, $4.GetParticipantTradesResponse>(
      '/qomet.agora.daemons.prtagent.v1.ParticipantService/GetParticipantTrades',
      ($4.GetParticipantTradesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.GetParticipantTradesResponse.fromBuffer(value));
  static final _$getParticipantTradesAsync = $grpc.ClientMethod<$4.GetParticipantTradesRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.ParticipantService/GetParticipantTradesAsync',
      ($4.GetParticipantTradesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ExecutionAsyncResponse.fromBuffer(value));
  static final _$getParticipantSettlements = $grpc.ClientMethod<$4.GetParticipantSettlementsRequest, $4.GetParticipantSettlementsResponse>(
      '/qomet.agora.daemons.prtagent.v1.ParticipantService/GetParticipantSettlements',
      ($4.GetParticipantSettlementsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.GetParticipantSettlementsResponse.fromBuffer(value));
  static final _$getParticipantSettlementsAsync = $grpc.ClientMethod<$4.GetParticipantSettlementsRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.ParticipantService/GetParticipantSettlementsAsync',
      ($4.GetParticipantSettlementsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ExecutionAsyncResponse.fromBuffer(value));

  ParticipantServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$4.GetParticipantInfoResponse> getParticipantInfo($4.GetParticipantInfoRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getParticipantInfo, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getParticipantInfoAsync($4.GetParticipantInfoRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getParticipantInfoAsync, request, options: options);
  }

  $grpc.ResponseFuture<$4.GetParticipantOrdersResponse> getParticipantOrders($4.GetParticipantOrdersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getParticipantOrders, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getParticipantOrdersAsync($4.GetParticipantOrdersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getParticipantOrdersAsync, request, options: options);
  }

  $grpc.ResponseFuture<$4.GetParticipantTradesResponse> getParticipantTrades($4.GetParticipantTradesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getParticipantTrades, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getParticipantTradesAsync($4.GetParticipantTradesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getParticipantTradesAsync, request, options: options);
  }

  $grpc.ResponseFuture<$4.GetParticipantSettlementsResponse> getParticipantSettlements($4.GetParticipantSettlementsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getParticipantSettlements, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getParticipantSettlementsAsync($4.GetParticipantSettlementsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getParticipantSettlementsAsync, request, options: options);
  }
}

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.ParticipantService')
abstract class ParticipantServiceBase extends $grpc.Service {
  $core.String get $name => 'qomet.agora.daemons.prtagent.v1.ParticipantService';

  ParticipantServiceBase() {
    $addMethod($grpc.ServiceMethod<$4.GetParticipantInfoRequest, $4.GetParticipantInfoResponse>(
        'GetParticipantInfo',
        getParticipantInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.GetParticipantInfoRequest.fromBuffer(value),
        ($4.GetParticipantInfoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.GetParticipantInfoRequest, $1.ExecutionAsyncResponse>(
        'GetParticipantInfoAsync',
        getParticipantInfoAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.GetParticipantInfoRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.GetParticipantOrdersRequest, $4.GetParticipantOrdersResponse>(
        'GetParticipantOrders',
        getParticipantOrders_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.GetParticipantOrdersRequest.fromBuffer(value),
        ($4.GetParticipantOrdersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.GetParticipantOrdersRequest, $1.ExecutionAsyncResponse>(
        'GetParticipantOrdersAsync',
        getParticipantOrdersAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.GetParticipantOrdersRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.GetParticipantTradesRequest, $4.GetParticipantTradesResponse>(
        'GetParticipantTrades',
        getParticipantTrades_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.GetParticipantTradesRequest.fromBuffer(value),
        ($4.GetParticipantTradesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.GetParticipantTradesRequest, $1.ExecutionAsyncResponse>(
        'GetParticipantTradesAsync',
        getParticipantTradesAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.GetParticipantTradesRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.GetParticipantSettlementsRequest, $4.GetParticipantSettlementsResponse>(
        'GetParticipantSettlements',
        getParticipantSettlements_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.GetParticipantSettlementsRequest.fromBuffer(value),
        ($4.GetParticipantSettlementsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.GetParticipantSettlementsRequest, $1.ExecutionAsyncResponse>(
        'GetParticipantSettlementsAsync',
        getParticipantSettlementsAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.GetParticipantSettlementsRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
  }

  $async.Future<$4.GetParticipantInfoResponse> getParticipantInfo_Pre($grpc.ServiceCall call, $async.Future<$4.GetParticipantInfoRequest> request) async {
    return getParticipantInfo(call, await request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getParticipantInfoAsync_Pre($grpc.ServiceCall call, $async.Future<$4.GetParticipantInfoRequest> request) async {
    return getParticipantInfoAsync(call, await request);
  }

  $async.Future<$4.GetParticipantOrdersResponse> getParticipantOrders_Pre($grpc.ServiceCall call, $async.Future<$4.GetParticipantOrdersRequest> request) async {
    return getParticipantOrders(call, await request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getParticipantOrdersAsync_Pre($grpc.ServiceCall call, $async.Future<$4.GetParticipantOrdersRequest> request) async {
    return getParticipantOrdersAsync(call, await request);
  }

  $async.Future<$4.GetParticipantTradesResponse> getParticipantTrades_Pre($grpc.ServiceCall call, $async.Future<$4.GetParticipantTradesRequest> request) async {
    return getParticipantTrades(call, await request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getParticipantTradesAsync_Pre($grpc.ServiceCall call, $async.Future<$4.GetParticipantTradesRequest> request) async {
    return getParticipantTradesAsync(call, await request);
  }

  $async.Future<$4.GetParticipantSettlementsResponse> getParticipantSettlements_Pre($grpc.ServiceCall call, $async.Future<$4.GetParticipantSettlementsRequest> request) async {
    return getParticipantSettlements(call, await request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getParticipantSettlementsAsync_Pre($grpc.ServiceCall call, $async.Future<$4.GetParticipantSettlementsRequest> request) async {
    return getParticipantSettlementsAsync(call, await request);
  }

  $async.Future<$4.GetParticipantInfoResponse> getParticipantInfo($grpc.ServiceCall call, $4.GetParticipantInfoRequest request);
  $async.Future<$1.ExecutionAsyncResponse> getParticipantInfoAsync($grpc.ServiceCall call, $4.GetParticipantInfoRequest request);
  $async.Future<$4.GetParticipantOrdersResponse> getParticipantOrders($grpc.ServiceCall call, $4.GetParticipantOrdersRequest request);
  $async.Future<$1.ExecutionAsyncResponse> getParticipantOrdersAsync($grpc.ServiceCall call, $4.GetParticipantOrdersRequest request);
  $async.Future<$4.GetParticipantTradesResponse> getParticipantTrades($grpc.ServiceCall call, $4.GetParticipantTradesRequest request);
  $async.Future<$1.ExecutionAsyncResponse> getParticipantTradesAsync($grpc.ServiceCall call, $4.GetParticipantTradesRequest request);
  $async.Future<$4.GetParticipantSettlementsResponse> getParticipantSettlements($grpc.ServiceCall call, $4.GetParticipantSettlementsRequest request);
  $async.Future<$1.ExecutionAsyncResponse> getParticipantSettlementsAsync($grpc.ServiceCall call, $4.GetParticipantSettlementsRequest request);
}
