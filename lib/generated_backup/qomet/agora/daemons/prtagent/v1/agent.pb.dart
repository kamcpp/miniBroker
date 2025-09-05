// This is a generated file - do not edit.
//
// Generated from qomet/agora/daemons/prtagent/v1/agent.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class PingRequest extends $pb.GeneratedMessage {
  factory PingRequest({
    $core.String? refRequestId,
    $core.String? stringToBePonged,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (stringToBePonged != null) result.stringToBePonged = stringToBePonged;
    return result;
  }

  PingRequest._();

  factory PingRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PingRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PingRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'stringToBePonged')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PingRequest clone() => PingRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PingRequest copyWith(void Function(PingRequest) updates) =>
      super.copyWith((message) => updates(message as PingRequest))
          as PingRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PingRequest create() => PingRequest._();
  @$core.override
  PingRequest createEmptyInstance() => create();
  static $pb.PbList<PingRequest> createRepeated() => $pb.PbList<PingRequest>();
  @$core.pragma('dart2js:noInline')
  static PingRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PingRequest>(create);
  static PingRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get stringToBePonged => $_getSZ(1);
  @$pb.TagNumber(2)
  set stringToBePonged($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStringToBePonged() => $_has(1);
  @$pb.TagNumber(2)
  void clearStringToBePonged() => $_clearField(2);
}

class PingResponse extends $pb.GeneratedMessage {
  factory PingResponse({
    $core.String? refRequestId,
    $core.String? pongString,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (pongString != null) result.pongString = pongString;
    return result;
  }

  PingResponse._();

  factory PingResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PingResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PingResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'pongString')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PingResponse clone() => PingResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PingResponse copyWith(void Function(PingResponse) updates) =>
      super.copyWith((message) => updates(message as PingResponse))
          as PingResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PingResponse create() => PingResponse._();
  @$core.override
  PingResponse createEmptyInstance() => create();
  static $pb.PbList<PingResponse> createRepeated() =>
      $pb.PbList<PingResponse>();
  @$core.pragma('dart2js:noInline')
  static PingResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PingResponse>(create);
  static PingResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get pongString => $_getSZ(1);
  @$pb.TagNumber(2)
  set pongString($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPongString() => $_has(1);
  @$pb.TagNumber(2)
  void clearPongString() => $_clearField(2);
}

class GetParticipantInfoRequest extends $pb.GeneratedMessage {
  factory GetParticipantInfoRequest({
    $core.String? refRequestId,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    return result;
  }

  GetParticipantInfoRequest._();

  factory GetParticipantInfoRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetParticipantInfoRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetParticipantInfoRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetParticipantInfoRequest clone() =>
      GetParticipantInfoRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetParticipantInfoRequest copyWith(
          void Function(GetParticipantInfoRequest) updates) =>
      super.copyWith((message) => updates(message as GetParticipantInfoRequest))
          as GetParticipantInfoRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetParticipantInfoRequest create() => GetParticipantInfoRequest._();
  @$core.override
  GetParticipantInfoRequest createEmptyInstance() => create();
  static $pb.PbList<GetParticipantInfoRequest> createRepeated() =>
      $pb.PbList<GetParticipantInfoRequest>();
  @$core.pragma('dart2js:noInline')
  static GetParticipantInfoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetParticipantInfoRequest>(create);
  static GetParticipantInfoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);
}

class GetParticipantInfoResponse extends $pb.GeneratedMessage {
  factory GetParticipantInfoResponse({
    $core.String? refRequestId,
    $core.String? identifier,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (identifier != null) result.identifier = identifier;
    return result;
  }

  GetParticipantInfoResponse._();

  factory GetParticipantInfoResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetParticipantInfoResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetParticipantInfoResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'identifier')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetParticipantInfoResponse clone() =>
      GetParticipantInfoResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetParticipantInfoResponse copyWith(
          void Function(GetParticipantInfoResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetParticipantInfoResponse))
          as GetParticipantInfoResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetParticipantInfoResponse create() => GetParticipantInfoResponse._();
  @$core.override
  GetParticipantInfoResponse createEmptyInstance() => create();
  static $pb.PbList<GetParticipantInfoResponse> createRepeated() =>
      $pb.PbList<GetParticipantInfoResponse>();
  @$core.pragma('dart2js:noInline')
  static GetParticipantInfoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetParticipantInfoResponse>(create);
  static GetParticipantInfoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get identifier => $_getSZ(1);
  @$pb.TagNumber(2)
  set identifier($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIdentifier() => $_has(1);
  @$pb.TagNumber(2)
  void clearIdentifier() => $_clearField(2);
}

class GetSupportedCurrenciesRequest extends $pb.GeneratedMessage {
  factory GetSupportedCurrenciesRequest({
    $core.String? refRequestId,
    $1.PaginationParams? pagination,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  GetSupportedCurrenciesRequest._();

  factory GetSupportedCurrenciesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSupportedCurrenciesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSupportedCurrenciesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSupportedCurrenciesRequest clone() =>
      GetSupportedCurrenciesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSupportedCurrenciesRequest copyWith(
          void Function(GetSupportedCurrenciesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetSupportedCurrenciesRequest))
          as GetSupportedCurrenciesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSupportedCurrenciesRequest create() =>
      GetSupportedCurrenciesRequest._();
  @$core.override
  GetSupportedCurrenciesRequest createEmptyInstance() => create();
  static $pb.PbList<GetSupportedCurrenciesRequest> createRepeated() =>
      $pb.PbList<GetSupportedCurrenciesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSupportedCurrenciesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSupportedCurrenciesRequest>(create);
  static GetSupportedCurrenciesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.PaginationParams get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination($1.PaginationParams value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.PaginationParams ensurePagination() => $_ensure(1);
}

class GetSupportedCurrenciesResponse extends $pb.GeneratedMessage {
  factory GetSupportedCurrenciesResponse({
    $core.String? refRequestId,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<$1.Asset>? currencies,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (currencies != null) result.currencies.addAll(currencies);
    return result;
  }

  GetSupportedCurrenciesResponse._();

  factory GetSupportedCurrenciesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSupportedCurrenciesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSupportedCurrenciesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<$1.Asset>(3, _omitFieldNames ? '' : 'currencies', $pb.PbFieldType.PM,
        subBuilder: $1.Asset.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSupportedCurrenciesResponse clone() =>
      GetSupportedCurrenciesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSupportedCurrenciesResponse copyWith(
          void Function(GetSupportedCurrenciesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetSupportedCurrenciesResponse))
          as GetSupportedCurrenciesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSupportedCurrenciesResponse create() =>
      GetSupportedCurrenciesResponse._();
  @$core.override
  GetSupportedCurrenciesResponse createEmptyInstance() => create();
  static $pb.PbList<GetSupportedCurrenciesResponse> createRepeated() =>
      $pb.PbList<GetSupportedCurrenciesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSupportedCurrenciesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSupportedCurrenciesResponse>(create);
  static GetSupportedCurrenciesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.PaginationInfo get paginationInfo => $_getN(1);
  @$pb.TagNumber(2)
  set paginationInfo($1.PaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPaginationInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaginationInfo() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.PaginationInfo ensurePaginationInfo() => $_ensure(1);

  @$pb.TagNumber(3)
  $pb.PbList<$1.Asset> get currencies => $_getList(2);
}

class GetParticipantOrdersRequest extends $pb.GeneratedMessage {
  factory GetParticipantOrdersRequest({
    $core.String? refRequestId,
    $1.PaginationParams? pagination,
    $core.Iterable<$core.String>? accountIdOrNameRegexes,
    $core.Iterable<$core.String>? marketIdOrNameRegexes,
    $1.Time? fromTime,
    $1.Time? toTime,
    $1.OrderSide? side,
    $core.Iterable<$core.bool>? statusFilters,
    $core.Iterable<$core.String>? instrumentIdOrSymbolRegexes,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (pagination != null) result.pagination = pagination;
    if (accountIdOrNameRegexes != null)
      result.accountIdOrNameRegexes.addAll(accountIdOrNameRegexes);
    if (marketIdOrNameRegexes != null)
      result.marketIdOrNameRegexes.addAll(marketIdOrNameRegexes);
    if (fromTime != null) result.fromTime = fromTime;
    if (toTime != null) result.toTime = toTime;
    if (side != null) result.side = side;
    if (statusFilters != null) result.statusFilters.addAll(statusFilters);
    if (instrumentIdOrSymbolRegexes != null)
      result.instrumentIdOrSymbolRegexes.addAll(instrumentIdOrSymbolRegexes);
    return result;
  }

  GetParticipantOrdersRequest._();

  factory GetParticipantOrdersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetParticipantOrdersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetParticipantOrdersRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..pPS(3, _omitFieldNames ? '' : 'accountIdOrNameRegexes')
    ..pPS(4, _omitFieldNames ? '' : 'marketIdOrNameRegexes')
    ..aOM<$1.Time>(5, _omitFieldNames ? '' : 'fromTime',
        subBuilder: $1.Time.create)
    ..aOM<$1.Time>(6, _omitFieldNames ? '' : 'toTime',
        subBuilder: $1.Time.create)
    ..e<$1.OrderSide>(7, _omitFieldNames ? '' : 'side', $pb.PbFieldType.OE,
        defaultOrMaker: $1.OrderSide.ORDER_SIDE__UNKNOWN,
        valueOf: $1.OrderSide.valueOf,
        enumValues: $1.OrderSide.values)
    ..p<$core.bool>(
        8, _omitFieldNames ? '' : 'statusFilters', $pb.PbFieldType.KB)
    ..pPS(9, _omitFieldNames ? '' : 'instrumentIdOrSymbolRegexes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetParticipantOrdersRequest clone() =>
      GetParticipantOrdersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetParticipantOrdersRequest copyWith(
          void Function(GetParticipantOrdersRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetParticipantOrdersRequest))
          as GetParticipantOrdersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetParticipantOrdersRequest create() =>
      GetParticipantOrdersRequest._();
  @$core.override
  GetParticipantOrdersRequest createEmptyInstance() => create();
  static $pb.PbList<GetParticipantOrdersRequest> createRepeated() =>
      $pb.PbList<GetParticipantOrdersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetParticipantOrdersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetParticipantOrdersRequest>(create);
  static GetParticipantOrdersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.PaginationParams get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination($1.PaginationParams value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.PaginationParams ensurePagination() => $_ensure(1);

  /// Optional filters
  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get accountIdOrNameRegexes => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get marketIdOrNameRegexes => $_getList(3);

  @$pb.TagNumber(5)
  $1.Time get fromTime => $_getN(4);
  @$pb.TagNumber(5)
  set fromTime($1.Time value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasFromTime() => $_has(4);
  @$pb.TagNumber(5)
  void clearFromTime() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Time ensureFromTime() => $_ensure(4);

  @$pb.TagNumber(6)
  $1.Time get toTime => $_getN(5);
  @$pb.TagNumber(6)
  set toTime($1.Time value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasToTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearToTime() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Time ensureToTime() => $_ensure(5);

  @$pb.TagNumber(7)
  $1.OrderSide get side => $_getN(6);
  @$pb.TagNumber(7)
  set side($1.OrderSide value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasSide() => $_has(6);
  @$pb.TagNumber(7)
  void clearSide() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<$core.bool> get statusFilters => $_getList(7);

  @$pb.TagNumber(9)
  $pb.PbList<$core.String> get instrumentIdOrSymbolRegexes => $_getList(8);
}

class GetParticipantOrdersResponse extends $pb.GeneratedMessage {
  factory GetParticipantOrdersResponse({
    $core.String? refRequestId,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<$1.Order>? orders,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>?
        accountSummaries,
    $1.Time? createdAt,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (orders != null) result.orders.addAll(orders);
    if (accountSummaries != null)
      result.accountSummaries.addEntries(accountSummaries);
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  GetParticipantOrdersResponse._();

  factory GetParticipantOrdersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetParticipantOrdersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetParticipantOrdersResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<$1.Order>(3, _omitFieldNames ? '' : 'orders', $pb.PbFieldType.PM,
        subBuilder: $1.Order.create)
    ..m<$core.String, $core.String>(
        4, _omitFieldNames ? '' : 'accountSummaries',
        entryClassName: 'GetParticipantOrdersResponse.AccountSummariesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..aOM<$1.Time>(5, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Time.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetParticipantOrdersResponse clone() =>
      GetParticipantOrdersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetParticipantOrdersResponse copyWith(
          void Function(GetParticipantOrdersResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetParticipantOrdersResponse))
          as GetParticipantOrdersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetParticipantOrdersResponse create() =>
      GetParticipantOrdersResponse._();
  @$core.override
  GetParticipantOrdersResponse createEmptyInstance() => create();
  static $pb.PbList<GetParticipantOrdersResponse> createRepeated() =>
      $pb.PbList<GetParticipantOrdersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetParticipantOrdersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetParticipantOrdersResponse>(create);
  static GetParticipantOrdersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.PaginationInfo get paginationInfo => $_getN(1);
  @$pb.TagNumber(2)
  set paginationInfo($1.PaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPaginationInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaginationInfo() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.PaginationInfo ensurePaginationInfo() => $_ensure(1);

  @$pb.TagNumber(3)
  $pb.PbList<$1.Order> get orders => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbMap<$core.String, $core.String> get accountSummaries => $_getMap(3);

  @$pb.TagNumber(5)
  $1.Time get createdAt => $_getN(4);
  @$pb.TagNumber(5)
  set createdAt($1.Time value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedAt() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Time ensureCreatedAt() => $_ensure(4);
}

class GetParticipantTradesRequest extends $pb.GeneratedMessage {
  factory GetParticipantTradesRequest({
    $core.String? refRequestId,
    $1.PaginationParams? pagination,
    $core.Iterable<$core.String>? accountIdOrNameRegexes,
    $core.Iterable<$core.String>? marketIdOrNameRegexes,
    $1.Time? fromTime,
    $1.Time? toTime,
    $1.OrderSide? side,
    $core.Iterable<$core.String>? instrumentIdOrSymbolRegexes,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (pagination != null) result.pagination = pagination;
    if (accountIdOrNameRegexes != null)
      result.accountIdOrNameRegexes.addAll(accountIdOrNameRegexes);
    if (marketIdOrNameRegexes != null)
      result.marketIdOrNameRegexes.addAll(marketIdOrNameRegexes);
    if (fromTime != null) result.fromTime = fromTime;
    if (toTime != null) result.toTime = toTime;
    if (side != null) result.side = side;
    if (instrumentIdOrSymbolRegexes != null)
      result.instrumentIdOrSymbolRegexes.addAll(instrumentIdOrSymbolRegexes);
    return result;
  }

  GetParticipantTradesRequest._();

  factory GetParticipantTradesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetParticipantTradesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetParticipantTradesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..pPS(3, _omitFieldNames ? '' : 'accountIdOrNameRegexes')
    ..pPS(4, _omitFieldNames ? '' : 'marketIdOrNameRegexes')
    ..aOM<$1.Time>(5, _omitFieldNames ? '' : 'fromTime',
        subBuilder: $1.Time.create)
    ..aOM<$1.Time>(6, _omitFieldNames ? '' : 'toTime',
        subBuilder: $1.Time.create)
    ..e<$1.OrderSide>(7, _omitFieldNames ? '' : 'side', $pb.PbFieldType.OE,
        defaultOrMaker: $1.OrderSide.ORDER_SIDE__UNKNOWN,
        valueOf: $1.OrderSide.valueOf,
        enumValues: $1.OrderSide.values)
    ..pPS(8, _omitFieldNames ? '' : 'instrumentIdOrSymbolRegexes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetParticipantTradesRequest clone() =>
      GetParticipantTradesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetParticipantTradesRequest copyWith(
          void Function(GetParticipantTradesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetParticipantTradesRequest))
          as GetParticipantTradesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetParticipantTradesRequest create() =>
      GetParticipantTradesRequest._();
  @$core.override
  GetParticipantTradesRequest createEmptyInstance() => create();
  static $pb.PbList<GetParticipantTradesRequest> createRepeated() =>
      $pb.PbList<GetParticipantTradesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetParticipantTradesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetParticipantTradesRequest>(create);
  static GetParticipantTradesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.PaginationParams get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination($1.PaginationParams value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.PaginationParams ensurePagination() => $_ensure(1);

  /// Optional filters
  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get accountIdOrNameRegexes => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get marketIdOrNameRegexes => $_getList(3);

  @$pb.TagNumber(5)
  $1.Time get fromTime => $_getN(4);
  @$pb.TagNumber(5)
  set fromTime($1.Time value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasFromTime() => $_has(4);
  @$pb.TagNumber(5)
  void clearFromTime() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Time ensureFromTime() => $_ensure(4);

  @$pb.TagNumber(6)
  $1.Time get toTime => $_getN(5);
  @$pb.TagNumber(6)
  set toTime($1.Time value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasToTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearToTime() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Time ensureToTime() => $_ensure(5);

  @$pb.TagNumber(7)
  $1.OrderSide get side => $_getN(6);
  @$pb.TagNumber(7)
  set side($1.OrderSide value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasSide() => $_has(6);
  @$pb.TagNumber(7)
  void clearSide() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get instrumentIdOrSymbolRegexes => $_getList(7);
}

class GetParticipantTradesResponse extends $pb.GeneratedMessage {
  factory GetParticipantTradesResponse({
    $core.String? refRequestId,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<$1.Trade>? trades,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>?
        accountSummaries,
    $1.Time? createdAt,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (trades != null) result.trades.addAll(trades);
    if (accountSummaries != null)
      result.accountSummaries.addEntries(accountSummaries);
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  GetParticipantTradesResponse._();

  factory GetParticipantTradesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetParticipantTradesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetParticipantTradesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<$1.Trade>(3, _omitFieldNames ? '' : 'trades', $pb.PbFieldType.PM,
        subBuilder: $1.Trade.create)
    ..m<$core.String, $core.String>(
        4, _omitFieldNames ? '' : 'accountSummaries',
        entryClassName: 'GetParticipantTradesResponse.AccountSummariesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..aOM<$1.Time>(5, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Time.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetParticipantTradesResponse clone() =>
      GetParticipantTradesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetParticipantTradesResponse copyWith(
          void Function(GetParticipantTradesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetParticipantTradesResponse))
          as GetParticipantTradesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetParticipantTradesResponse create() =>
      GetParticipantTradesResponse._();
  @$core.override
  GetParticipantTradesResponse createEmptyInstance() => create();
  static $pb.PbList<GetParticipantTradesResponse> createRepeated() =>
      $pb.PbList<GetParticipantTradesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetParticipantTradesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetParticipantTradesResponse>(create);
  static GetParticipantTradesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.PaginationInfo get paginationInfo => $_getN(1);
  @$pb.TagNumber(2)
  set paginationInfo($1.PaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPaginationInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaginationInfo() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.PaginationInfo ensurePaginationInfo() => $_ensure(1);

  @$pb.TagNumber(3)
  $pb.PbList<$1.Trade> get trades => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbMap<$core.String, $core.String> get accountSummaries => $_getMap(3);

  @$pb.TagNumber(5)
  $1.Time get createdAt => $_getN(4);
  @$pb.TagNumber(5)
  set createdAt($1.Time value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedAt() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Time ensureCreatedAt() => $_ensure(4);
}

class GetParticipantSettlementsRequest extends $pb.GeneratedMessage {
  factory GetParticipantSettlementsRequest({
    $core.String? refRequestId,
    $1.PaginationParams? pagination,
    $core.Iterable<$core.String>? accountIdOrNameRegexes,
    $core.Iterable<$core.String>? marketIdOrNameRegexes,
    $1.Time? fromTime,
    $1.Time? toTime,
    $1.ConfirmationStatus? status,
    $core.Iterable<$core.String>? assetIdOrNameRegexes,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (pagination != null) result.pagination = pagination;
    if (accountIdOrNameRegexes != null)
      result.accountIdOrNameRegexes.addAll(accountIdOrNameRegexes);
    if (marketIdOrNameRegexes != null)
      result.marketIdOrNameRegexes.addAll(marketIdOrNameRegexes);
    if (fromTime != null) result.fromTime = fromTime;
    if (toTime != null) result.toTime = toTime;
    if (status != null) result.status = status;
    if (assetIdOrNameRegexes != null)
      result.assetIdOrNameRegexes.addAll(assetIdOrNameRegexes);
    return result;
  }

  GetParticipantSettlementsRequest._();

  factory GetParticipantSettlementsRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetParticipantSettlementsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetParticipantSettlementsRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..pPS(3, _omitFieldNames ? '' : 'accountIdOrNameRegexes')
    ..pPS(4, _omitFieldNames ? '' : 'marketIdOrNameRegexes')
    ..aOM<$1.Time>(5, _omitFieldNames ? '' : 'fromTime',
        subBuilder: $1.Time.create)
    ..aOM<$1.Time>(6, _omitFieldNames ? '' : 'toTime',
        subBuilder: $1.Time.create)
    ..e<$1.ConfirmationStatus>(
        7, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: $1.ConfirmationStatus.CONFIRMATION_STATUS__UNKNOWN,
        valueOf: $1.ConfirmationStatus.valueOf,
        enumValues: $1.ConfirmationStatus.values)
    ..pPS(8, _omitFieldNames ? '' : 'assetIdOrNameRegexes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetParticipantSettlementsRequest clone() =>
      GetParticipantSettlementsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetParticipantSettlementsRequest copyWith(
          void Function(GetParticipantSettlementsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetParticipantSettlementsRequest))
          as GetParticipantSettlementsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetParticipantSettlementsRequest create() =>
      GetParticipantSettlementsRequest._();
  @$core.override
  GetParticipantSettlementsRequest createEmptyInstance() => create();
  static $pb.PbList<GetParticipantSettlementsRequest> createRepeated() =>
      $pb.PbList<GetParticipantSettlementsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetParticipantSettlementsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetParticipantSettlementsRequest>(
          create);
  static GetParticipantSettlementsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.PaginationParams get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination($1.PaginationParams value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.PaginationParams ensurePagination() => $_ensure(1);

  /// Optional filters
  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get accountIdOrNameRegexes => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get marketIdOrNameRegexes => $_getList(3);

  @$pb.TagNumber(5)
  $1.Time get fromTime => $_getN(4);
  @$pb.TagNumber(5)
  set fromTime($1.Time value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasFromTime() => $_has(4);
  @$pb.TagNumber(5)
  void clearFromTime() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Time ensureFromTime() => $_ensure(4);

  @$pb.TagNumber(6)
  $1.Time get toTime => $_getN(5);
  @$pb.TagNumber(6)
  set toTime($1.Time value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasToTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearToTime() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Time ensureToTime() => $_ensure(5);

  @$pb.TagNumber(7)
  $1.ConfirmationStatus get status => $_getN(6);
  @$pb.TagNumber(7)
  set status($1.ConfirmationStatus value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get assetIdOrNameRegexes => $_getList(7);
}

class GetParticipantSettlementsResponse extends $pb.GeneratedMessage {
  factory GetParticipantSettlementsResponse({
    $core.String? refRequestId,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<$1.Settlement>? settlements,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>?
        accountSummaries,
    $1.Time? createdAt,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (settlements != null) result.settlements.addAll(settlements);
    if (accountSummaries != null)
      result.accountSummaries.addEntries(accountSummaries);
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  GetParticipantSettlementsResponse._();

  factory GetParticipantSettlementsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetParticipantSettlementsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetParticipantSettlementsResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<$1.Settlement>(
        3, _omitFieldNames ? '' : 'settlements', $pb.PbFieldType.PM,
        subBuilder: $1.Settlement.create)
    ..m<$core.String, $core.String>(
        4, _omitFieldNames ? '' : 'accountSummaries',
        entryClassName:
            'GetParticipantSettlementsResponse.AccountSummariesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..aOM<$1.Time>(5, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Time.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetParticipantSettlementsResponse clone() =>
      GetParticipantSettlementsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetParticipantSettlementsResponse copyWith(
          void Function(GetParticipantSettlementsResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetParticipantSettlementsResponse))
          as GetParticipantSettlementsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetParticipantSettlementsResponse create() =>
      GetParticipantSettlementsResponse._();
  @$core.override
  GetParticipantSettlementsResponse createEmptyInstance() => create();
  static $pb.PbList<GetParticipantSettlementsResponse> createRepeated() =>
      $pb.PbList<GetParticipantSettlementsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetParticipantSettlementsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetParticipantSettlementsResponse>(
          create);
  static GetParticipantSettlementsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.PaginationInfo get paginationInfo => $_getN(1);
  @$pb.TagNumber(2)
  set paginationInfo($1.PaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPaginationInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaginationInfo() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.PaginationInfo ensurePaginationInfo() => $_ensure(1);

  @$pb.TagNumber(3)
  $pb.PbList<$1.Settlement> get settlements => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbMap<$core.String, $core.String> get accountSummaries => $_getMap(3);

  @$pb.TagNumber(5)
  $1.Time get createdAt => $_getN(4);
  @$pb.TagNumber(5)
  set createdAt($1.Time value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedAt() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Time ensureCreatedAt() => $_ensure(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
