// This is a generated file - do not edit.
//
// Generated from agent.proto.

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
import 'event.pb.dart' as $2;

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

  $grpc.ResponseFuture<$0.GetSupportedCurrenciesResponse>
      getSupportedCurrencies(
    $0.GetSupportedCurrenciesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSupportedCurrencies, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getSupportedCurrenciesAsync(
    $0.GetSupportedCurrenciesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSupportedCurrenciesAsync, request,
        options: options);
  }

  $grpc.ResponseStream<$2.Event> subscribeToEvents(
    $2.EventSubscriptionParams request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$subscribeToEvents, $async.Stream.fromIterable([request]),
        options: options);
  }

  // method descriptors

  static final _$ping = $grpc.ClientMethod<$0.PingRequest, $0.PingResponse>(
      '/qomet.agora.daemons.prtagent.v1.AgentService/Ping',
      ($0.PingRequest value) => value.writeToBuffer(),
      $0.PingResponse.fromBuffer);
  static final _$getSupportedCurrencies = $grpc.ClientMethod<
          $0.GetSupportedCurrenciesRequest, $0.GetSupportedCurrenciesResponse>(
      '/qomet.agora.daemons.prtagent.v1.AgentService/GetSupportedCurrencies',
      ($0.GetSupportedCurrenciesRequest value) => value.writeToBuffer(),
      $0.GetSupportedCurrenciesResponse.fromBuffer);
  static final _$getSupportedCurrenciesAsync = $grpc.ClientMethod<
          $0.GetSupportedCurrenciesRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.AgentService/GetSupportedCurrenciesAsync',
      ($0.GetSupportedCurrenciesRequest value) => value.writeToBuffer(),
      $1.ExecutionAsyncResponse.fromBuffer);
  static final _$subscribeToEvents =
      $grpc.ClientMethod<$2.EventSubscriptionParams, $2.Event>(
          '/qomet.agora.daemons.prtagent.v1.AgentService/SubscribeToEvents',
          ($2.EventSubscriptionParams value) => value.writeToBuffer(),
          $2.Event.fromBuffer);
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
    $addMethod($grpc.ServiceMethod<$0.GetSupportedCurrenciesRequest,
            $0.GetSupportedCurrenciesResponse>(
        'GetSupportedCurrencies',
        getSupportedCurrencies_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSupportedCurrenciesRequest.fromBuffer(value),
        ($0.GetSupportedCurrenciesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSupportedCurrenciesRequest,
            $1.ExecutionAsyncResponse>(
        'GetSupportedCurrenciesAsync',
        getSupportedCurrenciesAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSupportedCurrenciesRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.EventSubscriptionParams, $2.Event>(
        'SubscribeToEvents',
        subscribeToEvents_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $2.EventSubscriptionParams.fromBuffer(value),
        ($2.Event value) => value.writeToBuffer()));
  }

  $async.Future<$0.PingResponse> ping_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.PingRequest> $request) async {
    return ping($call, await $request);
  }

  $async.Future<$0.PingResponse> ping(
      $grpc.ServiceCall call, $0.PingRequest request);

  $async.Future<$0.GetSupportedCurrenciesResponse> getSupportedCurrencies_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetSupportedCurrenciesRequest> $request) async {
    return getSupportedCurrencies($call, await $request);
  }

  $async.Future<$0.GetSupportedCurrenciesResponse> getSupportedCurrencies(
      $grpc.ServiceCall call, $0.GetSupportedCurrenciesRequest request);

  $async.Future<$1.ExecutionAsyncResponse> getSupportedCurrenciesAsync_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetSupportedCurrenciesRequest> $request) async {
    return getSupportedCurrenciesAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getSupportedCurrenciesAsync(
      $grpc.ServiceCall call, $0.GetSupportedCurrenciesRequest request);

  $async.Stream<$2.Event> subscribeToEvents_Pre($grpc.ServiceCall $call,
      $async.Future<$2.EventSubscriptionParams> $request) async* {
    yield* subscribeToEvents($call, await $request);
  }

  $async.Stream<$2.Event> subscribeToEvents(
      $grpc.ServiceCall call, $2.EventSubscriptionParams request);
}
