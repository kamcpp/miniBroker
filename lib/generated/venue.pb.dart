//
//  Generated code. Do not modify.
//  source: venue.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $1;
import 'fin_common.pb.dart' as $9;

class GetVenueListRequest extends $pb.GeneratedMessage {
  factory GetVenueListRequest({
    $core.String? proposedExecutionId,
    $1.PaginationParams? pagination,
    $core.String? marketIdOrSymbolRegex,
    $core.String? venueIdOrSymbolRegex,
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    if (marketIdOrSymbolRegex != null) {
      $result.marketIdOrSymbolRegex = marketIdOrSymbolRegex;
    }
    if (venueIdOrSymbolRegex != null) {
      $result.venueIdOrSymbolRegex = venueIdOrSymbolRegex;
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  GetVenueListRequest._() : super();
  factory GetVenueListRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetVenueListRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetVenueListRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination', subBuilder: $1.PaginationParams.create)
    ..aOS(3, _omitFieldNames ? '' : 'marketIdOrSymbolRegex')
    ..aOS(4, _omitFieldNames ? '' : 'venueIdOrSymbolRegex')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'GetVenueListRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetVenueListRequest clone() => GetVenueListRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetVenueListRequest copyWith(void Function(GetVenueListRequest) updates) => super.copyWith((message) => updates(message as GetVenueListRequest)) as GetVenueListRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVenueListRequest create() => GetVenueListRequest._();
  GetVenueListRequest createEmptyInstance() => create();
  static $pb.PbList<GetVenueListRequest> createRepeated() => $pb.PbList<GetVenueListRequest>();
  @$core.pragma('dart2js:noInline')
  static GetVenueListRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetVenueListRequest>(create);
  static GetVenueListRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $1.PaginationParams get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination($1.PaginationParams v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  $1.PaginationParams ensurePagination() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get marketIdOrSymbolRegex => $_getSZ(2);
  @$pb.TagNumber(3)
  set marketIdOrSymbolRegex($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMarketIdOrSymbolRegex() => $_has(2);
  @$pb.TagNumber(3)
  void clearMarketIdOrSymbolRegex() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get venueIdOrSymbolRegex => $_getSZ(3);
  @$pb.TagNumber(4)
  set venueIdOrSymbolRegex($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasVenueIdOrSymbolRegex() => $_has(3);
  @$pb.TagNumber(4)
  void clearVenueIdOrSymbolRegex() => clearField(4);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(4);
}

class GetVenueListResponse extends $pb.GeneratedMessage {
  factory GetVenueListResponse({
    $core.String? refExecutionId,
    $1.PaginationInfo? pagination,
    $core.Iterable<$9.Venue>? venues,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (refExecutionId != null) {
      $result.refExecutionId = refExecutionId;
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    if (venues != null) {
      $result.venues.addAll(venues);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  GetVenueListResponse._() : super();
  factory GetVenueListResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetVenueListResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetVenueListResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'pagination', subBuilder: $1.PaginationInfo.create)
    ..pc<$9.Venue>(3, _omitFieldNames ? '' : 'venues', $pb.PbFieldType.PM, subBuilder: $9.Venue.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'GetVenueListResponse.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetVenueListResponse clone() => GetVenueListResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetVenueListResponse copyWith(void Function(GetVenueListResponse) updates) => super.copyWith((message) => updates(message as GetVenueListResponse)) as GetVenueListResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVenueListResponse create() => GetVenueListResponse._();
  GetVenueListResponse createEmptyInstance() => create();
  static $pb.PbList<GetVenueListResponse> createRepeated() => $pb.PbList<GetVenueListResponse>();
  @$core.pragma('dart2js:noInline')
  static GetVenueListResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetVenueListResponse>(create);
  static GetVenueListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $1.PaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination($1.PaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  $1.PaginationInfo ensurePagination() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.List<$9.Venue> get venues => $_getList(2);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(3);
}

class GetVenueCalendarRequest extends $pb.GeneratedMessage {
  factory GetVenueCalendarRequest({
    $core.String? proposedExecutionId,
    $core.String? venueIid,
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (venueIid != null) {
      $result.venueIid = venueIid;
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  GetVenueCalendarRequest._() : super();
  factory GetVenueCalendarRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetVenueCalendarRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetVenueCalendarRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'venueIid')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'GetVenueCalendarRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetVenueCalendarRequest clone() => GetVenueCalendarRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetVenueCalendarRequest copyWith(void Function(GetVenueCalendarRequest) updates) => super.copyWith((message) => updates(message as GetVenueCalendarRequest)) as GetVenueCalendarRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVenueCalendarRequest create() => GetVenueCalendarRequest._();
  GetVenueCalendarRequest createEmptyInstance() => create();
  static $pb.PbList<GetVenueCalendarRequest> createRepeated() => $pb.PbList<GetVenueCalendarRequest>();
  @$core.pragma('dart2js:noInline')
  static GetVenueCalendarRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetVenueCalendarRequest>(create);
  static GetVenueCalendarRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get venueIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set venueIid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVenueIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearVenueIid() => clearField(2);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(2);
}

class GetVenueCalendarResponse extends $pb.GeneratedMessage {
  factory GetVenueCalendarResponse({
    $core.String? refExecutionId,
    $9.VenueCalendar? calendar,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (refExecutionId != null) {
      $result.refExecutionId = refExecutionId;
    }
    if (calendar != null) {
      $result.calendar = calendar;
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  GetVenueCalendarResponse._() : super();
  factory GetVenueCalendarResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetVenueCalendarResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetVenueCalendarResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$9.VenueCalendar>(2, _omitFieldNames ? '' : 'calendar', subBuilder: $9.VenueCalendar.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'GetVenueCalendarResponse.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetVenueCalendarResponse clone() => GetVenueCalendarResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetVenueCalendarResponse copyWith(void Function(GetVenueCalendarResponse) updates) => super.copyWith((message) => updates(message as GetVenueCalendarResponse)) as GetVenueCalendarResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVenueCalendarResponse create() => GetVenueCalendarResponse._();
  GetVenueCalendarResponse createEmptyInstance() => create();
  static $pb.PbList<GetVenueCalendarResponse> createRepeated() => $pb.PbList<GetVenueCalendarResponse>();
  @$core.pragma('dart2js:noInline')
  static GetVenueCalendarResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetVenueCalendarResponse>(create);
  static GetVenueCalendarResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $9.VenueCalendar get calendar => $_getN(1);
  @$pb.TagNumber(2)
  set calendar($9.VenueCalendar v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCalendar() => $_has(1);
  @$pb.TagNumber(2)
  void clearCalendar() => clearField(2);
  @$pb.TagNumber(2)
  $9.VenueCalendar ensureCalendar() => $_ensure(1);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
