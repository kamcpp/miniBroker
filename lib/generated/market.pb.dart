//
//  Generated code. Do not modify.
//  source: market.proto
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

class GetMarketListRequest extends $pb.GeneratedMessage {
  factory GetMarketListRequest({
    $core.String? proposedExecutionId,
    $1.PaginationParams? pagination,
    $core.String? marketIdOrSymbolRegex,
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
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  GetMarketListRequest._() : super();
  factory GetMarketListRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMarketListRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMarketListRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination', subBuilder: $1.PaginationParams.create)
    ..aOS(3, _omitFieldNames ? '' : 'marketIdOrSymbolRegex')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'GetMarketListRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMarketListRequest clone() => GetMarketListRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMarketListRequest copyWith(void Function(GetMarketListRequest) updates) => super.copyWith((message) => updates(message as GetMarketListRequest)) as GetMarketListRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketListRequest create() => GetMarketListRequest._();
  GetMarketListRequest createEmptyInstance() => create();
  static $pb.PbList<GetMarketListRequest> createRepeated() => $pb.PbList<GetMarketListRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMarketListRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMarketListRequest>(create);
  static GetMarketListRequest? _defaultInstance;

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

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(3);
}

class GetMarketListResponse extends $pb.GeneratedMessage {
  factory GetMarketListResponse({
    $core.String? refExecutionId,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<$9.Market>? markets,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (refExecutionId != null) {
      $result.refExecutionId = refExecutionId;
    }
    if (paginationInfo != null) {
      $result.paginationInfo = paginationInfo;
    }
    if (markets != null) {
      $result.markets.addAll(markets);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  GetMarketListResponse._() : super();
  factory GetMarketListResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMarketListResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMarketListResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo', subBuilder: $1.PaginationInfo.create)
    ..pc<$9.Market>(3, _omitFieldNames ? '' : 'markets', $pb.PbFieldType.PM, subBuilder: $9.Market.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'GetMarketListResponse.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMarketListResponse clone() => GetMarketListResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMarketListResponse copyWith(void Function(GetMarketListResponse) updates) => super.copyWith((message) => updates(message as GetMarketListResponse)) as GetMarketListResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketListResponse create() => GetMarketListResponse._();
  GetMarketListResponse createEmptyInstance() => create();
  static $pb.PbList<GetMarketListResponse> createRepeated() => $pb.PbList<GetMarketListResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMarketListResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMarketListResponse>(create);
  static GetMarketListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $1.PaginationInfo get paginationInfo => $_getN(1);
  @$pb.TagNumber(2)
  set paginationInfo($1.PaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaginationInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaginationInfo() => clearField(2);
  @$pb.TagNumber(2)
  $1.PaginationInfo ensurePaginationInfo() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.List<$9.Market> get markets => $_getList(2);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(3);
}

class GetMarketCalendarRequest extends $pb.GeneratedMessage {
  factory GetMarketCalendarRequest({
    $core.String? proposedExecutionId,
    $core.String? marketId,
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (marketId != null) {
      $result.marketId = marketId;
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  GetMarketCalendarRequest._() : super();
  factory GetMarketCalendarRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMarketCalendarRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMarketCalendarRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'marketId')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'GetMarketCalendarRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMarketCalendarRequest clone() => GetMarketCalendarRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMarketCalendarRequest copyWith(void Function(GetMarketCalendarRequest) updates) => super.copyWith((message) => updates(message as GetMarketCalendarRequest)) as GetMarketCalendarRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketCalendarRequest create() => GetMarketCalendarRequest._();
  GetMarketCalendarRequest createEmptyInstance() => create();
  static $pb.PbList<GetMarketCalendarRequest> createRepeated() => $pb.PbList<GetMarketCalendarRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMarketCalendarRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMarketCalendarRequest>(create);
  static GetMarketCalendarRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get marketId => $_getSZ(1);
  @$pb.TagNumber(2)
  set marketId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMarketId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMarketId() => clearField(2);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(2);
}

class GetMarketCalendarResponse extends $pb.GeneratedMessage {
  factory GetMarketCalendarResponse({
    $core.String? refExecutionId,
    $9.MarketCalendar? calendar,
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
  GetMarketCalendarResponse._() : super();
  factory GetMarketCalendarResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMarketCalendarResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMarketCalendarResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$9.MarketCalendar>(2, _omitFieldNames ? '' : 'calendar', subBuilder: $9.MarketCalendar.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'GetMarketCalendarResponse.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMarketCalendarResponse clone() => GetMarketCalendarResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMarketCalendarResponse copyWith(void Function(GetMarketCalendarResponse) updates) => super.copyWith((message) => updates(message as GetMarketCalendarResponse)) as GetMarketCalendarResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketCalendarResponse create() => GetMarketCalendarResponse._();
  GetMarketCalendarResponse createEmptyInstance() => create();
  static $pb.PbList<GetMarketCalendarResponse> createRepeated() => $pb.PbList<GetMarketCalendarResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMarketCalendarResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMarketCalendarResponse>(create);
  static GetMarketCalendarResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $9.MarketCalendar get calendar => $_getN(1);
  @$pb.TagNumber(2)
  set calendar($9.MarketCalendar v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCalendar() => $_has(1);
  @$pb.TagNumber(2)
  void clearCalendar() => clearField(2);
  @$pb.TagNumber(2)
  $9.MarketCalendar ensureCalendar() => $_ensure(1);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
