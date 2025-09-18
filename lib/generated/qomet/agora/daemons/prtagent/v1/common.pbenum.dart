// This is a generated file - do not edit.
//
// Generated from qomet/agora/daemons/prtagent/v1/common.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class AsyncResponseStatusEnum extends $pb.ProtobufEnum {
  static const AsyncResponseStatusEnum ASYNC_RESPONSE_STATUS__UNKNOWN =
      AsyncResponseStatusEnum._(
          0, _omitEnumNames ? '' : 'ASYNC_RESPONSE_STATUS__UNKNOWN');
  static const AsyncResponseStatusEnum ASYNC_RESPONSE_STATUS__ACCEPTED =
      AsyncResponseStatusEnum._(
          1, _omitEnumNames ? '' : 'ASYNC_RESPONSE_STATUS__ACCEPTED');
  static const AsyncResponseStatusEnum ASYNC_RESPONSE_STATUS__COMPLETED =
      AsyncResponseStatusEnum._(
          2, _omitEnumNames ? '' : 'ASYNC_RESPONSE_STATUS__COMPLETED');
  static const AsyncResponseStatusEnum ASYNC_RESPONSE_STATUS__REJECTED =
      AsyncResponseStatusEnum._(
          3, _omitEnumNames ? '' : 'ASYNC_RESPONSE_STATUS__REJECTED');
  static const AsyncResponseStatusEnum ASYNC_RESPONSE_STATUS__FAILED =
      AsyncResponseStatusEnum._(
          4, _omitEnumNames ? '' : 'ASYNC_RESPONSE_STATUS__FAILED');
  static const AsyncResponseStatusEnum ASYNC_RESPONSE_STATUS__EXPIRED =
      AsyncResponseStatusEnum._(
          5, _omitEnumNames ? '' : 'ASYNC_RESPONSE_STATUS__EXPIRED');
  static const AsyncResponseStatusEnum ASYNC_RESPONSE_STATUS__IN_PROGRESS =
      AsyncResponseStatusEnum._(
          6, _omitEnumNames ? '' : 'ASYNC_RESPONSE_STATUS__IN_PROGRESS');
  static const AsyncResponseStatusEnum ASYNC_RESPONSE_STATUS__PENDING =
      AsyncResponseStatusEnum._(
          7, _omitEnumNames ? '' : 'ASYNC_RESPONSE_STATUS__PENDING');
  static const AsyncResponseStatusEnum ASYNC_RESPONSE_STATUS__UNAUTHORIZED =
      AsyncResponseStatusEnum._(
          8, _omitEnumNames ? '' : 'ASYNC_RESPONSE_STATUS__UNAUTHORIZED');
  static const AsyncResponseStatusEnum ASYNC_RESPONSE_STATUS__CONFLICT =
      AsyncResponseStatusEnum._(
          9, _omitEnumNames ? '' : 'ASYNC_RESPONSE_STATUS__CONFLICT');
  static const AsyncResponseStatusEnum
      ASYNC_RESPONSE_STATUS__SERVICE_UNAVAILABLE = AsyncResponseStatusEnum._(10,
          _omitEnumNames ? '' : 'ASYNC_RESPONSE_STATUS__SERVICE_UNAVAILABLE');
  static const AsyncResponseStatusEnum ASYNC_RESPONSE_STATUS__GATEWAY_TIMEOUT =
      AsyncResponseStatusEnum._(
          11, _omitEnumNames ? '' : 'ASYNC_RESPONSE_STATUS__GATEWAY_TIMEOUT');
  static const AsyncResponseStatusEnum ASYNC_RESPONSE_STATUS__NOT_IMPLEMENTED =
      AsyncResponseStatusEnum._(
          12, _omitEnumNames ? '' : 'ASYNC_RESPONSE_STATUS__NOT_IMPLEMENTED');
  static const AsyncResponseStatusEnum ASYNC_RESPONSE_STATUS__BAD_REQUEST =
      AsyncResponseStatusEnum._(
          13, _omitEnumNames ? '' : 'ASYNC_RESPONSE_STATUS__BAD_REQUEST');
  static const AsyncResponseStatusEnum
      ASYNC_RESPONSE_STATUS__TOO_MANY_REQUESTS = AsyncResponseStatusEnum._(
          14, _omitEnumNames ? '' : 'ASYNC_RESPONSE_STATUS__TOO_MANY_REQUESTS');
  static const AsyncResponseStatusEnum
      ASYNC_RESPONSE_STATUS__INTERNAL_SERVER_ERROR = AsyncResponseStatusEnum._(
          15,
          _omitEnumNames ? '' : 'ASYNC_RESPONSE_STATUS__INTERNAL_SERVER_ERROR');
  static const AsyncResponseStatusEnum ASYNC_RESPONSE_STATUS__OTHER =
      AsyncResponseStatusEnum._(
          1000, _omitEnumNames ? '' : 'ASYNC_RESPONSE_STATUS__OTHER');

  static const $core.List<AsyncResponseStatusEnum> values =
      <AsyncResponseStatusEnum>[
    ASYNC_RESPONSE_STATUS__UNKNOWN,
    ASYNC_RESPONSE_STATUS__ACCEPTED,
    ASYNC_RESPONSE_STATUS__COMPLETED,
    ASYNC_RESPONSE_STATUS__REJECTED,
    ASYNC_RESPONSE_STATUS__FAILED,
    ASYNC_RESPONSE_STATUS__EXPIRED,
    ASYNC_RESPONSE_STATUS__IN_PROGRESS,
    ASYNC_RESPONSE_STATUS__PENDING,
    ASYNC_RESPONSE_STATUS__UNAUTHORIZED,
    ASYNC_RESPONSE_STATUS__CONFLICT,
    ASYNC_RESPONSE_STATUS__SERVICE_UNAVAILABLE,
    ASYNC_RESPONSE_STATUS__GATEWAY_TIMEOUT,
    ASYNC_RESPONSE_STATUS__NOT_IMPLEMENTED,
    ASYNC_RESPONSE_STATUS__BAD_REQUEST,
    ASYNC_RESPONSE_STATUS__TOO_MANY_REQUESTS,
    ASYNC_RESPONSE_STATUS__INTERNAL_SERVER_ERROR,
    ASYNC_RESPONSE_STATUS__OTHER,
  ];

  static final $core.Map<$core.int, AsyncResponseStatusEnum> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static AsyncResponseStatusEnum? valueOf($core.int value) => _byValue[value];

  const AsyncResponseStatusEnum._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
