// This is a generated file - do not edit.
//
// Generated from market.proto.

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

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getMarketListAsync(
    $0.GetMarketListRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getMarketListAsync, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMarketCalendarResponse> getMarketCalendar(
    $0.GetMarketCalendarRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getMarketCalendar, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getMarketCalendarAsync(
    $0.GetMarketCalendarRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getMarketCalendarAsync, request,
        options: options);
  }

  // method descriptors

  static final _$getMarketList =
      $grpc.ClientMethod<$0.GetMarketListRequest, $0.GetMarketListResponse>(
          '/qomet.agora.daemons.prtagent.v1.MarketService/GetMarketList',
          ($0.GetMarketListRequest value) => value.writeToBuffer(),
          $0.GetMarketListResponse.fromBuffer);
  static final _$getMarketListAsync =
      $grpc.ClientMethod<$0.GetMarketListRequest, $1.ExecutionAsyncResponse>(
          '/qomet.agora.daemons.prtagent.v1.MarketService/GetMarketListAsync',
          ($0.GetMarketListRequest value) => value.writeToBuffer(),
          $1.ExecutionAsyncResponse.fromBuffer);
  static final _$getMarketCalendar = $grpc.ClientMethod<
          $0.GetMarketCalendarRequest, $0.GetMarketCalendarResponse>(
      '/qomet.agora.daemons.prtagent.v1.MarketService/GetMarketCalendar',
      ($0.GetMarketCalendarRequest value) => value.writeToBuffer(),
      $0.GetMarketCalendarResponse.fromBuffer);
  static final _$getMarketCalendarAsync = $grpc.ClientMethod<
          $0.GetMarketCalendarRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.MarketService/GetMarketCalendarAsync',
      ($0.GetMarketCalendarRequest value) => value.writeToBuffer(),
      $1.ExecutionAsyncResponse.fromBuffer);
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
    $addMethod(
        $grpc.ServiceMethod<$0.GetMarketListRequest, $1.ExecutionAsyncResponse>(
            'GetMarketListAsync',
            getMarketListAsync_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetMarketListRequest.fromBuffer(value),
            ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMarketCalendarRequest,
            $0.GetMarketCalendarResponse>(
        'GetMarketCalendar',
        getMarketCalendar_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMarketCalendarRequest.fromBuffer(value),
        ($0.GetMarketCalendarResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMarketCalendarRequest,
            $1.ExecutionAsyncResponse>(
        'GetMarketCalendarAsync',
        getMarketCalendarAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMarketCalendarRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetMarketListResponse> getMarketList_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetMarketListRequest> $request) async {
    return getMarketList($call, await $request);
  }

  $async.Future<$0.GetMarketListResponse> getMarketList(
      $grpc.ServiceCall call, $0.GetMarketListRequest request);

  $async.Future<$1.ExecutionAsyncResponse> getMarketListAsync_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetMarketListRequest> $request) async {
    return getMarketListAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getMarketListAsync(
      $grpc.ServiceCall call, $0.GetMarketListRequest request);

  $async.Future<$0.GetMarketCalendarResponse> getMarketCalendar_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetMarketCalendarRequest> $request) async {
    return getMarketCalendar($call, await $request);
  }

  $async.Future<$0.GetMarketCalendarResponse> getMarketCalendar(
      $grpc.ServiceCall call, $0.GetMarketCalendarRequest request);

  $async.Future<$1.ExecutionAsyncResponse> getMarketCalendarAsync_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetMarketCalendarRequest> $request) async {
    return getMarketCalendarAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getMarketCalendarAsync(
      $grpc.ServiceCall call, $0.GetMarketCalendarRequest request);
}
