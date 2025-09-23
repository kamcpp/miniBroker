// This is a generated file - do not edit.
//
// Generated from participant.proto.

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
import 'participant.pb.dart' as $0;

export 'participant.pb.dart';

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.ParticipantService')
class ParticipantServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  ParticipantServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.GetParticipantInfoResponse> getParticipantInfo(
    $0.GetParticipantInfoRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getParticipantInfo, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getParticipantInfoAsync(
    $0.GetParticipantInfoRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getParticipantInfoAsync, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetParticipantOrdersResponse> getParticipantOrders(
    $0.GetParticipantOrdersRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getParticipantOrders, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getParticipantOrdersAsync(
    $0.GetParticipantOrdersRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getParticipantOrdersAsync, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetParticipantTradesResponse> getParticipantTrades(
    $0.GetParticipantTradesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getParticipantTrades, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getParticipantTradesAsync(
    $0.GetParticipantTradesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getParticipantTradesAsync, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetParticipantSettlementsResponse>
      getParticipantSettlements(
    $0.GetParticipantSettlementsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getParticipantSettlements, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse>
      getParticipantSettlementsAsync(
    $0.GetParticipantSettlementsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getParticipantSettlementsAsync, request,
        options: options);
  }

  // method descriptors

  static final _$getParticipantInfo = $grpc.ClientMethod<
          $0.GetParticipantInfoRequest, $0.GetParticipantInfoResponse>(
      '/qomet.agora.daemons.prtagent.v1.ParticipantService/GetParticipantInfo',
      ($0.GetParticipantInfoRequest value) => value.writeToBuffer(),
      $0.GetParticipantInfoResponse.fromBuffer);
  static final _$getParticipantInfoAsync = $grpc.ClientMethod<
          $0.GetParticipantInfoRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.ParticipantService/GetParticipantInfoAsync',
      ($0.GetParticipantInfoRequest value) => value.writeToBuffer(),
      $1.ExecutionAsyncResponse.fromBuffer);
  static final _$getParticipantOrders = $grpc.ClientMethod<
          $0.GetParticipantOrdersRequest, $0.GetParticipantOrdersResponse>(
      '/qomet.agora.daemons.prtagent.v1.ParticipantService/GetParticipantOrders',
      ($0.GetParticipantOrdersRequest value) => value.writeToBuffer(),
      $0.GetParticipantOrdersResponse.fromBuffer);
  static final _$getParticipantOrdersAsync = $grpc.ClientMethod<
          $0.GetParticipantOrdersRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.ParticipantService/GetParticipantOrdersAsync',
      ($0.GetParticipantOrdersRequest value) => value.writeToBuffer(),
      $1.ExecutionAsyncResponse.fromBuffer);
  static final _$getParticipantTrades = $grpc.ClientMethod<
          $0.GetParticipantTradesRequest, $0.GetParticipantTradesResponse>(
      '/qomet.agora.daemons.prtagent.v1.ParticipantService/GetParticipantTrades',
      ($0.GetParticipantTradesRequest value) => value.writeToBuffer(),
      $0.GetParticipantTradesResponse.fromBuffer);
  static final _$getParticipantTradesAsync = $grpc.ClientMethod<
          $0.GetParticipantTradesRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.ParticipantService/GetParticipantTradesAsync',
      ($0.GetParticipantTradesRequest value) => value.writeToBuffer(),
      $1.ExecutionAsyncResponse.fromBuffer);
  static final _$getParticipantSettlements = $grpc.ClientMethod<
          $0.GetParticipantSettlementsRequest,
          $0.GetParticipantSettlementsResponse>(
      '/qomet.agora.daemons.prtagent.v1.ParticipantService/GetParticipantSettlements',
      ($0.GetParticipantSettlementsRequest value) => value.writeToBuffer(),
      $0.GetParticipantSettlementsResponse.fromBuffer);
  static final _$getParticipantSettlementsAsync = $grpc.ClientMethod<
          $0.GetParticipantSettlementsRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.ParticipantService/GetParticipantSettlementsAsync',
      ($0.GetParticipantSettlementsRequest value) => value.writeToBuffer(),
      $1.ExecutionAsyncResponse.fromBuffer);
}

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.ParticipantService')
abstract class ParticipantServiceBase extends $grpc.Service {
  $core.String get $name =>
      'qomet.agora.daemons.prtagent.v1.ParticipantService';

  ParticipantServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetParticipantInfoRequest,
            $0.GetParticipantInfoResponse>(
        'GetParticipantInfo',
        getParticipantInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetParticipantInfoRequest.fromBuffer(value),
        ($0.GetParticipantInfoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetParticipantInfoRequest,
            $1.ExecutionAsyncResponse>(
        'GetParticipantInfoAsync',
        getParticipantInfoAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetParticipantInfoRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetParticipantOrdersRequest,
            $0.GetParticipantOrdersResponse>(
        'GetParticipantOrders',
        getParticipantOrders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetParticipantOrdersRequest.fromBuffer(value),
        ($0.GetParticipantOrdersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetParticipantOrdersRequest,
            $1.ExecutionAsyncResponse>(
        'GetParticipantOrdersAsync',
        getParticipantOrdersAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetParticipantOrdersRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetParticipantTradesRequest,
            $0.GetParticipantTradesResponse>(
        'GetParticipantTrades',
        getParticipantTrades_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetParticipantTradesRequest.fromBuffer(value),
        ($0.GetParticipantTradesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetParticipantTradesRequest,
            $1.ExecutionAsyncResponse>(
        'GetParticipantTradesAsync',
        getParticipantTradesAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetParticipantTradesRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetParticipantSettlementsRequest,
            $0.GetParticipantSettlementsResponse>(
        'GetParticipantSettlements',
        getParticipantSettlements_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetParticipantSettlementsRequest.fromBuffer(value),
        ($0.GetParticipantSettlementsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetParticipantSettlementsRequest,
            $1.ExecutionAsyncResponse>(
        'GetParticipantSettlementsAsync',
        getParticipantSettlementsAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetParticipantSettlementsRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetParticipantInfoResponse> getParticipantInfo_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetParticipantInfoRequest> $request) async {
    return getParticipantInfo($call, await $request);
  }

  $async.Future<$0.GetParticipantInfoResponse> getParticipantInfo(
      $grpc.ServiceCall call, $0.GetParticipantInfoRequest request);

  $async.Future<$1.ExecutionAsyncResponse> getParticipantInfoAsync_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetParticipantInfoRequest> $request) async {
    return getParticipantInfoAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getParticipantInfoAsync(
      $grpc.ServiceCall call, $0.GetParticipantInfoRequest request);

  $async.Future<$0.GetParticipantOrdersResponse> getParticipantOrders_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetParticipantOrdersRequest> $request) async {
    return getParticipantOrders($call, await $request);
  }

  $async.Future<$0.GetParticipantOrdersResponse> getParticipantOrders(
      $grpc.ServiceCall call, $0.GetParticipantOrdersRequest request);

  $async.Future<$1.ExecutionAsyncResponse> getParticipantOrdersAsync_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetParticipantOrdersRequest> $request) async {
    return getParticipantOrdersAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getParticipantOrdersAsync(
      $grpc.ServiceCall call, $0.GetParticipantOrdersRequest request);

  $async.Future<$0.GetParticipantTradesResponse> getParticipantTrades_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetParticipantTradesRequest> $request) async {
    return getParticipantTrades($call, await $request);
  }

  $async.Future<$0.GetParticipantTradesResponse> getParticipantTrades(
      $grpc.ServiceCall call, $0.GetParticipantTradesRequest request);

  $async.Future<$1.ExecutionAsyncResponse> getParticipantTradesAsync_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetParticipantTradesRequest> $request) async {
    return getParticipantTradesAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getParticipantTradesAsync(
      $grpc.ServiceCall call, $0.GetParticipantTradesRequest request);

  $async.Future<$0.GetParticipantSettlementsResponse>
      getParticipantSettlements_Pre($grpc.ServiceCall $call,
          $async.Future<$0.GetParticipantSettlementsRequest> $request) async {
    return getParticipantSettlements($call, await $request);
  }

  $async.Future<$0.GetParticipantSettlementsResponse> getParticipantSettlements(
      $grpc.ServiceCall call, $0.GetParticipantSettlementsRequest request);

  $async.Future<$1.ExecutionAsyncResponse> getParticipantSettlementsAsync_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetParticipantSettlementsRequest> $request) async {
    return getParticipantSettlementsAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getParticipantSettlementsAsync(
      $grpc.ServiceCall call, $0.GetParticipantSettlementsRequest request);
}
