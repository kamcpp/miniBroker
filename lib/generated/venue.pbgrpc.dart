// This is a generated file - do not edit.
//
// Generated from venue.proto.

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
import 'venue.pb.dart' as $0;

export 'venue.pb.dart';

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.VenueService')
class VenueServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  VenueServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.GetVenueListResponse> getVenueList(
    $0.GetVenueListRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getVenueList, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getVenueListAsync(
    $0.GetVenueListRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getVenueListAsync, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetVenueCalendarResponse> getVenueCalendar(
    $0.GetVenueCalendarRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getVenueCalendar, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getVenueCalendarAsync(
    $0.GetVenueCalendarRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getVenueCalendarAsync, request, options: options);
  }

  // method descriptors

  static final _$getVenueList =
      $grpc.ClientMethod<$0.GetVenueListRequest, $0.GetVenueListResponse>(
          '/qomet.agora.daemons.prtagent.v1.VenueService/GetVenueList',
          ($0.GetVenueListRequest value) => value.writeToBuffer(),
          $0.GetVenueListResponse.fromBuffer);
  static final _$getVenueListAsync =
      $grpc.ClientMethod<$0.GetVenueListRequest, $1.ExecutionAsyncResponse>(
          '/qomet.agora.daemons.prtagent.v1.VenueService/GetVenueListAsync',
          ($0.GetVenueListRequest value) => value.writeToBuffer(),
          $1.ExecutionAsyncResponse.fromBuffer);
  static final _$getVenueCalendar = $grpc.ClientMethod<
          $0.GetVenueCalendarRequest, $0.GetVenueCalendarResponse>(
      '/qomet.agora.daemons.prtagent.v1.VenueService/GetVenueCalendar',
      ($0.GetVenueCalendarRequest value) => value.writeToBuffer(),
      $0.GetVenueCalendarResponse.fromBuffer);
  static final _$getVenueCalendarAsync =
      $grpc.ClientMethod<$0.GetVenueCalendarRequest, $1.ExecutionAsyncResponse>(
          '/qomet.agora.daemons.prtagent.v1.VenueService/GetVenueCalendarAsync',
          ($0.GetVenueCalendarRequest value) => value.writeToBuffer(),
          $1.ExecutionAsyncResponse.fromBuffer);
}

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.VenueService')
abstract class VenueServiceBase extends $grpc.Service {
  $core.String get $name => 'qomet.agora.daemons.prtagent.v1.VenueService';

  VenueServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.GetVenueListRequest, $0.GetVenueListResponse>(
            'GetVenueList',
            getVenueList_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetVenueListRequest.fromBuffer(value),
            ($0.GetVenueListResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetVenueListRequest, $1.ExecutionAsyncResponse>(
            'GetVenueListAsync',
            getVenueListAsync_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetVenueListRequest.fromBuffer(value),
            ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetVenueCalendarRequest,
            $0.GetVenueCalendarResponse>(
        'GetVenueCalendar',
        getVenueCalendar_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetVenueCalendarRequest.fromBuffer(value),
        ($0.GetVenueCalendarResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetVenueCalendarRequest,
            $1.ExecutionAsyncResponse>(
        'GetVenueCalendarAsync',
        getVenueCalendarAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetVenueCalendarRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetVenueListResponse> getVenueList_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetVenueListRequest> $request) async {
    return getVenueList($call, await $request);
  }

  $async.Future<$0.GetVenueListResponse> getVenueList(
      $grpc.ServiceCall call, $0.GetVenueListRequest request);

  $async.Future<$1.ExecutionAsyncResponse> getVenueListAsync_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetVenueListRequest> $request) async {
    return getVenueListAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getVenueListAsync(
      $grpc.ServiceCall call, $0.GetVenueListRequest request);

  $async.Future<$0.GetVenueCalendarResponse> getVenueCalendar_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetVenueCalendarRequest> $request) async {
    return getVenueCalendar($call, await $request);
  }

  $async.Future<$0.GetVenueCalendarResponse> getVenueCalendar(
      $grpc.ServiceCall call, $0.GetVenueCalendarRequest request);

  $async.Future<$1.ExecutionAsyncResponse> getVenueCalendarAsync_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetVenueCalendarRequest> $request) async {
    return getVenueCalendarAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getVenueCalendarAsync(
      $grpc.ServiceCall call, $0.GetVenueCalendarRequest request);
}
