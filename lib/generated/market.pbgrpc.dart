//
//  Generated code. Do not modify.
//  source: market.proto
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
import 'market.pb.dart' as $3;

export 'market.pb.dart';

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.MarketService')
class MarketServiceClient extends $grpc.Client {
  static final _$getMarketList = $grpc.ClientMethod<$3.GetMarketListRequest, $3.GetMarketListResponse>(
      '/qomet.agora.daemons.prtagent.v1.MarketService/GetMarketList',
      ($3.GetMarketListRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.GetMarketListResponse.fromBuffer(value));
  static final _$getMarketListAsync = $grpc.ClientMethod<$3.GetMarketListRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.MarketService/GetMarketListAsync',
      ($3.GetMarketListRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ExecutionAsyncResponse.fromBuffer(value));
  static final _$getMarketCalendar = $grpc.ClientMethod<$3.GetMarketCalendarRequest, $3.GetMarketCalendarResponse>(
      '/qomet.agora.daemons.prtagent.v1.MarketService/GetMarketCalendar',
      ($3.GetMarketCalendarRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.GetMarketCalendarResponse.fromBuffer(value));
  static final _$getMarketCalendarAsync = $grpc.ClientMethod<$3.GetMarketCalendarRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.MarketService/GetMarketCalendarAsync',
      ($3.GetMarketCalendarRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ExecutionAsyncResponse.fromBuffer(value));

  MarketServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$3.GetMarketListResponse> getMarketList($3.GetMarketListRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMarketList, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getMarketListAsync($3.GetMarketListRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMarketListAsync, request, options: options);
  }

  $grpc.ResponseFuture<$3.GetMarketCalendarResponse> getMarketCalendar($3.GetMarketCalendarRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMarketCalendar, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getMarketCalendarAsync($3.GetMarketCalendarRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMarketCalendarAsync, request, options: options);
  }
}

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.MarketService')
abstract class MarketServiceBase extends $grpc.Service {
  $core.String get $name => 'qomet.agora.daemons.prtagent.v1.MarketService';

  MarketServiceBase() {
    $addMethod($grpc.ServiceMethod<$3.GetMarketListRequest, $3.GetMarketListResponse>(
        'GetMarketList',
        getMarketList_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.GetMarketListRequest.fromBuffer(value),
        ($3.GetMarketListResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.GetMarketListRequest, $1.ExecutionAsyncResponse>(
        'GetMarketListAsync',
        getMarketListAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.GetMarketListRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.GetMarketCalendarRequest, $3.GetMarketCalendarResponse>(
        'GetMarketCalendar',
        getMarketCalendar_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.GetMarketCalendarRequest.fromBuffer(value),
        ($3.GetMarketCalendarResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.GetMarketCalendarRequest, $1.ExecutionAsyncResponse>(
        'GetMarketCalendarAsync',
        getMarketCalendarAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.GetMarketCalendarRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
  }

  $async.Future<$3.GetMarketListResponse> getMarketList_Pre($grpc.ServiceCall call, $async.Future<$3.GetMarketListRequest> request) async {
    return getMarketList(call, await request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getMarketListAsync_Pre($grpc.ServiceCall call, $async.Future<$3.GetMarketListRequest> request) async {
    return getMarketListAsync(call, await request);
  }

  $async.Future<$3.GetMarketCalendarResponse> getMarketCalendar_Pre($grpc.ServiceCall call, $async.Future<$3.GetMarketCalendarRequest> request) async {
    return getMarketCalendar(call, await request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getMarketCalendarAsync_Pre($grpc.ServiceCall call, $async.Future<$3.GetMarketCalendarRequest> request) async {
    return getMarketCalendarAsync(call, await request);
  }

  $async.Future<$3.GetMarketListResponse> getMarketList($grpc.ServiceCall call, $3.GetMarketListRequest request);
  $async.Future<$1.ExecutionAsyncResponse> getMarketListAsync($grpc.ServiceCall call, $3.GetMarketListRequest request);
  $async.Future<$3.GetMarketCalendarResponse> getMarketCalendar($grpc.ServiceCall call, $3.GetMarketCalendarRequest request);
  $async.Future<$1.ExecutionAsyncResponse> getMarketCalendarAsync($grpc.ServiceCall call, $3.GetMarketCalendarRequest request);
}
