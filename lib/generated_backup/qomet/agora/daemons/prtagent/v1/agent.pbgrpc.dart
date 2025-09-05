// This is a generated file - do not edit.
//
// Generated from qomet/agora/daemons/prtagent/v1/agent.proto.

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

import 'agent.pb.dart' as $0;
import 'common.pb.dart' as $1;

export 'agent.pb.dart';

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.AgentService')
class AgentServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  AgentServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.PingResponse> ping(
    $0.PingRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$ping, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetParticipantInfoResponse> getParticipantInfo(
    $0.GetParticipantInfoRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getParticipantInfo, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSupportedCurrenciesResponse>
      getSupportedCurrencies(
    $0.GetSupportedCurrenciesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSupportedCurrencies, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetParticipantOrdersResponse> getParticipantOrders(
    $0.GetParticipantOrdersRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getParticipantOrders, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetParticipantTradesResponse> getParticipantTrades(
    $0.GetParticipantTradesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getParticipantTrades, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetParticipantSettlementsResponse>
      getParticipantSettlements(
    $0.GetParticipantSettlementsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getParticipantSettlements, request,
        options: options);
  }

  $grpc.ResponseStream<$1.Event> subscribeToAgentEvents(
    $1.EventSubscriptionParams request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$subscribeToAgentEvents, $async.Stream.fromIterable([request]),
        options: options);
  }

  // method descriptors

  static final _$ping = $grpc.ClientMethod<$0.PingRequest, $0.PingResponse>(
      '/qomet.agora.daemons.prtagent.v1.AgentService/Ping',
      ($0.PingRequest value) => value.writeToBuffer(),
      $0.PingResponse.fromBuffer);
  static final _$getParticipantInfo = $grpc.ClientMethod<
          $0.GetParticipantInfoRequest, $0.GetParticipantInfoResponse>(
      '/qomet.agora.daemons.prtagent.v1.AgentService/GetParticipantInfo',
      ($0.GetParticipantInfoRequest value) => value.writeToBuffer(),
      $0.GetParticipantInfoResponse.fromBuffer);
  static final _$getSupportedCurrencies = $grpc.ClientMethod<
          $0.GetSupportedCurrenciesRequest, $0.GetSupportedCurrenciesResponse>(
      '/qomet.agora.daemons.prtagent.v1.AgentService/GetSupportedCurrencies',
      ($0.GetSupportedCurrenciesRequest value) => value.writeToBuffer(),
      $0.GetSupportedCurrenciesResponse.fromBuffer);
  static final _$getParticipantOrders = $grpc.ClientMethod<
          $0.GetParticipantOrdersRequest, $0.GetParticipantOrdersResponse>(
      '/qomet.agora.daemons.prtagent.v1.AgentService/GetParticipantOrders',
      ($0.GetParticipantOrdersRequest value) => value.writeToBuffer(),
      $0.GetParticipantOrdersResponse.fromBuffer);
  static final _$getParticipantTrades = $grpc.ClientMethod<
          $0.GetParticipantTradesRequest, $0.GetParticipantTradesResponse>(
      '/qomet.agora.daemons.prtagent.v1.AgentService/GetParticipantTrades',
      ($0.GetParticipantTradesRequest value) => value.writeToBuffer(),
      $0.GetParticipantTradesResponse.fromBuffer);
  static final _$getParticipantSettlements = $grpc.ClientMethod<
          $0.GetParticipantSettlementsRequest,
          $0.GetParticipantSettlementsResponse>(
      '/qomet.agora.daemons.prtagent.v1.AgentService/GetParticipantSettlements',
      ($0.GetParticipantSettlementsRequest value) => value.writeToBuffer(),
      $0.GetParticipantSettlementsResponse.fromBuffer);
  static final _$subscribeToAgentEvents = $grpc.ClientMethod<
          $1.EventSubscriptionParams, $1.Event>(
      '/qomet.agora.daemons.prtagent.v1.AgentService/SubscribeToAgentEvents',
      ($1.EventSubscriptionParams value) => value.writeToBuffer(),
      $1.Event.fromBuffer);
}

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.AgentService')
abstract class AgentServiceBase extends $grpc.Service {
  $core.String get $name => 'qomet.agora.daemons.prtagent.v1.AgentService';

  AgentServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.PingRequest, $0.PingResponse>(
        'Ping',
        ping_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PingRequest.fromBuffer(value),
        ($0.PingResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetParticipantInfoRequest,
            $0.GetParticipantInfoResponse>(
        'GetParticipantInfo',
        getParticipantInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetParticipantInfoRequest.fromBuffer(value),
        ($0.GetParticipantInfoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSupportedCurrenciesRequest,
            $0.GetSupportedCurrenciesResponse>(
        'GetSupportedCurrencies',
        getSupportedCurrencies_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSupportedCurrenciesRequest.fromBuffer(value),
        ($0.GetSupportedCurrenciesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetParticipantOrdersRequest,
            $0.GetParticipantOrdersResponse>(
        'GetParticipantOrders',
        getParticipantOrders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetParticipantOrdersRequest.fromBuffer(value),
        ($0.GetParticipantOrdersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetParticipantTradesRequest,
            $0.GetParticipantTradesResponse>(
        'GetParticipantTrades',
        getParticipantTrades_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetParticipantTradesRequest.fromBuffer(value),
        ($0.GetParticipantTradesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetParticipantSettlementsRequest,
            $0.GetParticipantSettlementsResponse>(
        'GetParticipantSettlements',
        getParticipantSettlements_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetParticipantSettlementsRequest.fromBuffer(value),
        ($0.GetParticipantSettlementsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.EventSubscriptionParams, $1.Event>(
        'SubscribeToAgentEvents',
        subscribeToAgentEvents_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $1.EventSubscriptionParams.fromBuffer(value),
        ($1.Event value) => value.writeToBuffer()));
  }

  $async.Future<$0.PingResponse> ping_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.PingRequest> $request) async {
    return ping($call, await $request);
  }

  $async.Future<$0.PingResponse> ping(
      $grpc.ServiceCall call, $0.PingRequest request);

  $async.Future<$0.GetParticipantInfoResponse> getParticipantInfo_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetParticipantInfoRequest> $request) async {
    return getParticipantInfo($call, await $request);
  }

  $async.Future<$0.GetParticipantInfoResponse> getParticipantInfo(
      $grpc.ServiceCall call, $0.GetParticipantInfoRequest request);

  $async.Future<$0.GetSupportedCurrenciesResponse> getSupportedCurrencies_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetSupportedCurrenciesRequest> $request) async {
    return getSupportedCurrencies($call, await $request);
  }

  $async.Future<$0.GetSupportedCurrenciesResponse> getSupportedCurrencies(
      $grpc.ServiceCall call, $0.GetSupportedCurrenciesRequest request);

  $async.Future<$0.GetParticipantOrdersResponse> getParticipantOrders_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetParticipantOrdersRequest> $request) async {
    return getParticipantOrders($call, await $request);
  }

  $async.Future<$0.GetParticipantOrdersResponse> getParticipantOrders(
      $grpc.ServiceCall call, $0.GetParticipantOrdersRequest request);

  $async.Future<$0.GetParticipantTradesResponse> getParticipantTrades_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetParticipantTradesRequest> $request) async {
    return getParticipantTrades($call, await $request);
  }

  $async.Future<$0.GetParticipantTradesResponse> getParticipantTrades(
      $grpc.ServiceCall call, $0.GetParticipantTradesRequest request);

  $async.Future<$0.GetParticipantSettlementsResponse>
      getParticipantSettlements_Pre($grpc.ServiceCall $call,
          $async.Future<$0.GetParticipantSettlementsRequest> $request) async {
    return getParticipantSettlements($call, await $request);
  }

  $async.Future<$0.GetParticipantSettlementsResponse> getParticipantSettlements(
      $grpc.ServiceCall call, $0.GetParticipantSettlementsRequest request);

  $async.Stream<$1.Event> subscribeToAgentEvents_Pre($grpc.ServiceCall $call,
      $async.Future<$1.EventSubscriptionParams> $request) async* {
    yield* subscribeToAgentEvents($call, await $request);
  }

  $async.Stream<$1.Event> subscribeToAgentEvents(
      $grpc.ServiceCall call, $1.EventSubscriptionParams request);
}
