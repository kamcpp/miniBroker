//
//  Generated code. Do not modify.
//  source: venue.proto
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
import 'venue.pb.dart' as $6;

export 'venue.pb.dart';

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.VenueService')
class VenueServiceClient extends $grpc.Client {
  static final _$getVenueList = $grpc.ClientMethod<$6.GetVenueListRequest, $6.GetVenueListResponse>(
      '/qomet.agora.daemons.prtagent.v1.VenueService/GetVenueList',
      ($6.GetVenueListRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $6.GetVenueListResponse.fromBuffer(value));
  static final _$getVenueListAsync = $grpc.ClientMethod<$6.GetVenueListRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.VenueService/GetVenueListAsync',
      ($6.GetVenueListRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ExecutionAsyncResponse.fromBuffer(value));
  static final _$getVenueCalendar = $grpc.ClientMethod<$6.GetVenueCalendarRequest, $6.GetVenueCalendarResponse>(
      '/qomet.agora.daemons.prtagent.v1.VenueService/GetVenueCalendar',
      ($6.GetVenueCalendarRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $6.GetVenueCalendarResponse.fromBuffer(value));
  static final _$getVenueCalendarAsync = $grpc.ClientMethod<$6.GetVenueCalendarRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.VenueService/GetVenueCalendarAsync',
      ($6.GetVenueCalendarRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ExecutionAsyncResponse.fromBuffer(value));

  VenueServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$6.GetVenueListResponse> getVenueList($6.GetVenueListRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getVenueList, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getVenueListAsync($6.GetVenueListRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getVenueListAsync, request, options: options);
  }

  $grpc.ResponseFuture<$6.GetVenueCalendarResponse> getVenueCalendar($6.GetVenueCalendarRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getVenueCalendar, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getVenueCalendarAsync($6.GetVenueCalendarRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getVenueCalendarAsync, request, options: options);
  }
}

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.VenueService')
abstract class VenueServiceBase extends $grpc.Service {
  $core.String get $name => 'qomet.agora.daemons.prtagent.v1.VenueService';

  VenueServiceBase() {
    $addMethod($grpc.ServiceMethod<$6.GetVenueListRequest, $6.GetVenueListResponse>(
        'GetVenueList',
        getVenueList_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.GetVenueListRequest.fromBuffer(value),
        ($6.GetVenueListResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.GetVenueListRequest, $1.ExecutionAsyncResponse>(
        'GetVenueListAsync',
        getVenueListAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.GetVenueListRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.GetVenueCalendarRequest, $6.GetVenueCalendarResponse>(
        'GetVenueCalendar',
        getVenueCalendar_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.GetVenueCalendarRequest.fromBuffer(value),
        ($6.GetVenueCalendarResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.GetVenueCalendarRequest, $1.ExecutionAsyncResponse>(
        'GetVenueCalendarAsync',
        getVenueCalendarAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.GetVenueCalendarRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
  }

  $async.Future<$6.GetVenueListResponse> getVenueList_Pre($grpc.ServiceCall call, $async.Future<$6.GetVenueListRequest> request) async {
    return getVenueList(call, await request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getVenueListAsync_Pre($grpc.ServiceCall call, $async.Future<$6.GetVenueListRequest> request) async {
    return getVenueListAsync(call, await request);
  }

  $async.Future<$6.GetVenueCalendarResponse> getVenueCalendar_Pre($grpc.ServiceCall call, $async.Future<$6.GetVenueCalendarRequest> request) async {
    return getVenueCalendar(call, await request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getVenueCalendarAsync_Pre($grpc.ServiceCall call, $async.Future<$6.GetVenueCalendarRequest> request) async {
    return getVenueCalendarAsync(call, await request);
  }

  $async.Future<$6.GetVenueListResponse> getVenueList($grpc.ServiceCall call, $6.GetVenueListRequest request);
  $async.Future<$1.ExecutionAsyncResponse> getVenueListAsync($grpc.ServiceCall call, $6.GetVenueListRequest request);
  $async.Future<$6.GetVenueCalendarResponse> getVenueCalendar($grpc.ServiceCall call, $6.GetVenueCalendarRequest request);
  $async.Future<$1.ExecutionAsyncResponse> getVenueCalendarAsync($grpc.ServiceCall call, $6.GetVenueCalendarRequest request);
}
