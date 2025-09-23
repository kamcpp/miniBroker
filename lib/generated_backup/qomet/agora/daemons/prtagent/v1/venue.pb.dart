// This is a generated file - do not edit.
//
// Generated from venue.proto.

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

class GetVenueListRequest extends $pb.GeneratedMessage {
  factory GetVenueListRequest({
    $core.String? proposedExecutionId,
    $1.PaginationParams? pagination,
    $core.String? marketIdOrSymbolRegex,
    $core.String? venueIdOrSymbolRegex,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (pagination != null) result.pagination = pagination;
    if (marketIdOrSymbolRegex != null)
      result.marketIdOrSymbolRegex = marketIdOrSymbolRegex;
    if (venueIdOrSymbolRegex != null)
      result.venueIdOrSymbolRegex = venueIdOrSymbolRegex;
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  GetVenueListRequest._();

  factory GetVenueListRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetVenueListRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetVenueListRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..aOS(3, _omitFieldNames ? '' : 'marketIdOrSymbolRegex')
    ..aOS(4, _omitFieldNames ? '' : 'venueIdOrSymbolRegex')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'GetVenueListRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVenueListRequest clone() => GetVenueListRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVenueListRequest copyWith(void Function(GetVenueListRequest) updates) =>
      super.copyWith((message) => updates(message as GetVenueListRequest))
          as GetVenueListRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVenueListRequest create() => GetVenueListRequest._();
  @$core.override
  GetVenueListRequest createEmptyInstance() => create();
  static $pb.PbList<GetVenueListRequest> createRepeated() =>
      $pb.PbList<GetVenueListRequest>();
  @$core.pragma('dart2js:noInline')
  static GetVenueListRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetVenueListRequest>(create);
  static GetVenueListRequest? _defaultInstance;

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

  @$pb.TagNumber(4)
  $core.String get venueIdOrSymbolRegex => $_getSZ(3);
  @$pb.TagNumber(4)
  set venueIdOrSymbolRegex($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasVenueIdOrSymbolRegex() => $_has(3);
  @$pb.TagNumber(4)
  void clearVenueIdOrSymbolRegex() => $_clearField(4);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(4);
}

class GetVenueListResponse extends $pb.GeneratedMessage {
  factory GetVenueListResponse({
    $core.String? refExecutionId,
    $1.PaginationInfo? pagination,
    $core.Iterable<$2.Venue>? venues,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (pagination != null) result.pagination = pagination;
    if (venues != null) result.venues.addAll(venues);
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  GetVenueListResponse._();

  factory GetVenueListResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetVenueListResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetVenueListResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationInfo.create)
    ..pc<$2.Venue>(3, _omitFieldNames ? '' : 'venues', $pb.PbFieldType.PM,
        subBuilder: $2.Venue.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'GetVenueListResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVenueListResponse clone() =>
      GetVenueListResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVenueListResponse copyWith(void Function(GetVenueListResponse) updates) =>
      super.copyWith((message) => updates(message as GetVenueListResponse))
          as GetVenueListResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVenueListResponse create() => GetVenueListResponse._();
  @$core.override
  GetVenueListResponse createEmptyInstance() => create();
  static $pb.PbList<GetVenueListResponse> createRepeated() =>
      $pb.PbList<GetVenueListResponse>();
  @$core.pragma('dart2js:noInline')
  static GetVenueListResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetVenueListResponse>(create);
  static GetVenueListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.PaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination($1.PaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.PaginationInfo ensurePagination() => $_ensure(1);

  @$pb.TagNumber(3)
  $pb.PbList<$2.Venue> get venues => $_getList(2);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(3);
}

class GetVenueCalendarRequest extends $pb.GeneratedMessage {
  factory GetVenueCalendarRequest({
    $core.String? proposedExecutionId,
    $core.String? venueIid,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (venueIid != null) result.venueIid = venueIid;
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  GetVenueCalendarRequest._();

  factory GetVenueCalendarRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetVenueCalendarRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetVenueCalendarRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'venueIid')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'GetVenueCalendarRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVenueCalendarRequest clone() =>
      GetVenueCalendarRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVenueCalendarRequest copyWith(
          void Function(GetVenueCalendarRequest) updates) =>
      super.copyWith((message) => updates(message as GetVenueCalendarRequest))
          as GetVenueCalendarRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVenueCalendarRequest create() => GetVenueCalendarRequest._();
  @$core.override
  GetVenueCalendarRequest createEmptyInstance() => create();
  static $pb.PbList<GetVenueCalendarRequest> createRepeated() =>
      $pb.PbList<GetVenueCalendarRequest>();
  @$core.pragma('dart2js:noInline')
  static GetVenueCalendarRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetVenueCalendarRequest>(create);
  static GetVenueCalendarRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get venueIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set venueIid($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVenueIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearVenueIid() => $_clearField(2);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(2);
}

class GetVenueCalendarResponse extends $pb.GeneratedMessage {
  factory GetVenueCalendarResponse({
    $core.String? refExecutionId,
    $2.VenueCalendar? calendar,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (calendar != null) result.calendar = calendar;
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  GetVenueCalendarResponse._();

  factory GetVenueCalendarResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetVenueCalendarResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetVenueCalendarResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$2.VenueCalendar>(2, _omitFieldNames ? '' : 'calendar',
        subBuilder: $2.VenueCalendar.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'GetVenueCalendarResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVenueCalendarResponse clone() =>
      GetVenueCalendarResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVenueCalendarResponse copyWith(
          void Function(GetVenueCalendarResponse) updates) =>
      super.copyWith((message) => updates(message as GetVenueCalendarResponse))
          as GetVenueCalendarResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVenueCalendarResponse create() => GetVenueCalendarResponse._();
  @$core.override
  GetVenueCalendarResponse createEmptyInstance() => create();
  static $pb.PbList<GetVenueCalendarResponse> createRepeated() =>
      $pb.PbList<GetVenueCalendarResponse>();
  @$core.pragma('dart2js:noInline')
  static GetVenueCalendarResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetVenueCalendarResponse>(create);
  static GetVenueCalendarResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $2.VenueCalendar get calendar => $_getN(1);
  @$pb.TagNumber(2)
  set calendar($2.VenueCalendar value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCalendar() => $_has(1);
  @$pb.TagNumber(2)
  void clearCalendar() => $_clearField(2);
  @$pb.TagNumber(2)
  $2.VenueCalendar ensureCalendar() => $_ensure(1);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
