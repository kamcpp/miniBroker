// This is a generated file - do not edit.
//
// Generated from market.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $1;
import 'fin_common.pb.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class GetMarketListRequest extends $pb.GeneratedMessage {
  factory GetMarketListRequest({
    $core.String? proposedExecutionId,
    $1.PaginationParams? pagination,
    $core.String? marketIdOrSymbolRegex,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (pagination != null) result.pagination = pagination;
    if (marketIdOrSymbolRegex != null)
      result.marketIdOrSymbolRegex = marketIdOrSymbolRegex;
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  GetMarketListRequest._();

  factory GetMarketListRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMarketListRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMarketListRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..aOS(3, _omitFieldNames ? '' : 'marketIdOrSymbolRegex')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'GetMarketListRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketListRequest clone() =>
      GetMarketListRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketListRequest copyWith(void Function(GetMarketListRequest) updates) =>
      super.copyWith((message) => updates(message as GetMarketListRequest))
          as GetMarketListRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketListRequest create() => GetMarketListRequest._();
  @$core.override
  GetMarketListRequest createEmptyInstance() => create();
  static $pb.PbList<GetMarketListRequest> createRepeated() =>
      $pb.PbList<GetMarketListRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMarketListRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMarketListRequest>(create);
  static GetMarketListRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => $_clearField(1);

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

  @$pb.TagNumber(3)
  $core.String get marketIdOrSymbolRegex => $_getSZ(2);
  @$pb.TagNumber(3)
  set marketIdOrSymbolRegex($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMarketIdOrSymbolRegex() => $_has(2);
  @$pb.TagNumber(3)
  void clearMarketIdOrSymbolRegex() => $_clearField(3);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(3);
}

class GetMarketListResponse extends $pb.GeneratedMessage {
  factory GetMarketListResponse({
    $core.String? refExecutionId,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<$2.Market>? markets,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (markets != null) result.markets.addAll(markets);
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  GetMarketListResponse._();

  factory GetMarketListResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMarketListResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMarketListResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<$2.Market>(3, _omitFieldNames ? '' : 'markets', $pb.PbFieldType.PM,
        subBuilder: $2.Market.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'GetMarketListResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketListResponse clone() =>
      GetMarketListResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketListResponse copyWith(
          void Function(GetMarketListResponse) updates) =>
      super.copyWith((message) => updates(message as GetMarketListResponse))
          as GetMarketListResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketListResponse create() => GetMarketListResponse._();
  @$core.override
  GetMarketListResponse createEmptyInstance() => create();
  static $pb.PbList<GetMarketListResponse> createRepeated() =>
      $pb.PbList<GetMarketListResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMarketListResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMarketListResponse>(create);
  static GetMarketListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => $_clearField(1);

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
  $pb.PbList<$2.Market> get markets => $_getList(2);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(3);
}

class GetMarketCalendarRequest extends $pb.GeneratedMessage {
  factory GetMarketCalendarRequest({
    $core.String? proposedExecutionId,
    $core.String? marketId,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (marketId != null) result.marketId = marketId;
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  GetMarketCalendarRequest._();

  factory GetMarketCalendarRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMarketCalendarRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMarketCalendarRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'marketId')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'GetMarketCalendarRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketCalendarRequest clone() =>
      GetMarketCalendarRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketCalendarRequest copyWith(
          void Function(GetMarketCalendarRequest) updates) =>
      super.copyWith((message) => updates(message as GetMarketCalendarRequest))
          as GetMarketCalendarRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketCalendarRequest create() => GetMarketCalendarRequest._();
  @$core.override
  GetMarketCalendarRequest createEmptyInstance() => create();
  static $pb.PbList<GetMarketCalendarRequest> createRepeated() =>
      $pb.PbList<GetMarketCalendarRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMarketCalendarRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMarketCalendarRequest>(create);
  static GetMarketCalendarRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get marketId => $_getSZ(1);
  @$pb.TagNumber(2)
  set marketId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMarketId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMarketId() => $_clearField(2);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(2);
}

class GetMarketCalendarResponse extends $pb.GeneratedMessage {
  factory GetMarketCalendarResponse({
    $core.String? refExecutionId,
    $2.MarketCalendar? calendar,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (calendar != null) result.calendar = calendar;
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  GetMarketCalendarResponse._();

  factory GetMarketCalendarResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMarketCalendarResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMarketCalendarResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$2.MarketCalendar>(2, _omitFieldNames ? '' : 'calendar',
        subBuilder: $2.MarketCalendar.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'GetMarketCalendarResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketCalendarResponse clone() =>
      GetMarketCalendarResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketCalendarResponse copyWith(
          void Function(GetMarketCalendarResponse) updates) =>
      super.copyWith((message) => updates(message as GetMarketCalendarResponse))
          as GetMarketCalendarResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketCalendarResponse create() => GetMarketCalendarResponse._();
  @$core.override
  GetMarketCalendarResponse createEmptyInstance() => create();
  static $pb.PbList<GetMarketCalendarResponse> createRepeated() =>
      $pb.PbList<GetMarketCalendarResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMarketCalendarResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMarketCalendarResponse>(create);
  static GetMarketCalendarResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $2.MarketCalendar get calendar => $_getN(1);
  @$pb.TagNumber(2)
  set calendar($2.MarketCalendar value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCalendar() => $_has(1);
  @$pb.TagNumber(2)
  void clearCalendar() => $_clearField(2);
  @$pb.TagNumber(2)
  $2.MarketCalendar ensureCalendar() => $_ensure(1);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
