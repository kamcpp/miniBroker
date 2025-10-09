//
//  Generated code. Do not modify.
//  source: agent.proto
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

import 'agent.pb.dart' as $7;
import 'common.pb.dart' as $1;
import 'event.pb.dart' as $8;

export 'agent.pb.dart';

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.AgentService')
class AgentServiceClient extends $grpc.Client {
  static final _$ping = $grpc.ClientMethod<$7.PingRequest, $7.PingResponse>(
      '/qomet.agora.daemons.prtagent.v1.AgentService/Ping',
      ($7.PingRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.PingResponse.fromBuffer(value));
  static final _$getSupportedCurrencies = $grpc.ClientMethod<$7.GetSupportedCurrenciesRequest, $7.GetSupportedCurrenciesResponse>(
      '/qomet.agora.daemons.prtagent.v1.AgentService/GetSupportedCurrencies',
      ($7.GetSupportedCurrenciesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.GetSupportedCurrenciesResponse.fromBuffer(value));
  static final _$getSupportedCurrenciesAsync = $grpc.ClientMethod<$7.GetSupportedCurrenciesRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.AgentService/GetSupportedCurrenciesAsync',
      ($7.GetSupportedCurrenciesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ExecutionAsyncResponse.fromBuffer(value));
  static final _$subscribeToEvents = $grpc.ClientMethod<$8.EventSubscriptionParams, $8.Event>(
      '/qomet.agora.daemons.prtagent.v1.AgentService/SubscribeToEvents',
      ($8.EventSubscriptionParams value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $8.Event.fromBuffer(value));

  AgentServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$7.PingResponse> ping($7.PingRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$ping, request, options: options);
  }

  $grpc.ResponseFuture<$7.GetSupportedCurrenciesResponse> getSupportedCurrencies($7.GetSupportedCurrenciesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportedCurrencies, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getSupportedCurrenciesAsync($7.GetSupportedCurrenciesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportedCurrenciesAsync, request, options: options);
  }

  $grpc.ResponseStream<$8.Event> subscribeToEvents($8.EventSubscriptionParams request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$subscribeToEvents, $async.Stream.fromIterable([request]), options: options);
  }
}

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.AgentService')
abstract class AgentServiceBase extends $grpc.Service {
  $core.String get $name => 'qomet.agora.daemons.prtagent.v1.AgentService';

  AgentServiceBase() {
    $addMethod($grpc.ServiceMethod<$7.PingRequest, $7.PingResponse>(
        'Ping',
        ping_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.PingRequest.fromBuffer(value),
        ($7.PingResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetSupportedCurrenciesRequest, $7.GetSupportedCurrenciesResponse>(
        'GetSupportedCurrencies',
        getSupportedCurrencies_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetSupportedCurrenciesRequest.fromBuffer(value),
        ($7.GetSupportedCurrenciesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetSupportedCurrenciesRequest, $1.ExecutionAsyncResponse>(
        'GetSupportedCurrenciesAsync',
        getSupportedCurrenciesAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetSupportedCurrenciesRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$8.EventSubscriptionParams, $8.Event>(
        'SubscribeToEvents',
        subscribeToEvents_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $8.EventSubscriptionParams.fromBuffer(value),
        ($8.Event value) => value.writeToBuffer()));
  }

  $async.Future<$7.PingResponse> ping_Pre($grpc.ServiceCall call, $async.Future<$7.PingRequest> request) async {
    return ping(call, await request);
  }

  $async.Future<$7.GetSupportedCurrenciesResponse> getSupportedCurrencies_Pre($grpc.ServiceCall call, $async.Future<$7.GetSupportedCurrenciesRequest> request) async {
    return getSupportedCurrencies(call, await request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getSupportedCurrenciesAsync_Pre($grpc.ServiceCall call, $async.Future<$7.GetSupportedCurrenciesRequest> request) async {
    return getSupportedCurrenciesAsync(call, await request);
  }

  $async.Stream<$8.Event> subscribeToEvents_Pre($grpc.ServiceCall call, $async.Future<$8.EventSubscriptionParams> request) async* {
    yield* subscribeToEvents(call, await request);
  }

  $async.Future<$7.PingResponse> ping($grpc.ServiceCall call, $7.PingRequest request);
  $async.Future<$7.GetSupportedCurrenciesResponse> getSupportedCurrencies($grpc.ServiceCall call, $7.GetSupportedCurrenciesRequest request);
  $async.Future<$1.ExecutionAsyncResponse> getSupportedCurrenciesAsync($grpc.ServiceCall call, $7.GetSupportedCurrenciesRequest request);
  $async.Stream<$8.Event> subscribeToEvents($grpc.ServiceCall call, $8.EventSubscriptionParams request);
}
