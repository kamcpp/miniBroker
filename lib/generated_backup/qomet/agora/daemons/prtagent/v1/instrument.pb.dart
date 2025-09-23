// This is a generated file - do not edit.
//
// Generated from instrument.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $1;
import 'filter.pb.dart' as $3;
import 'fin_common.pb.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class GetInstrumentListRequest extends $pb.GeneratedMessage {
  factory GetInstrumentListRequest({
    $core.String? proposedExecutionId,
    $1.PaginationParams? pagination,
    $core.String? marketIdOrSymbolRegex,
    $core.String? venueIdOrSymbolRegex,
    $core.String? instrumentIdOrSymbolRegex,
    $core.Iterable<$2.InstrumentListingStatusEnum>? listingTypes,
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
    if (instrumentIdOrSymbolRegex != null)
      result.instrumentIdOrSymbolRegex = instrumentIdOrSymbolRegex;
    if (listingTypes != null) result.listingTypes.addAll(listingTypes);
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  GetInstrumentListRequest._();

  factory GetInstrumentListRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInstrumentListRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInstrumentListRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..aOS(3, _omitFieldNames ? '' : 'marketIdOrSymbolRegex')
    ..aOS(4, _omitFieldNames ? '' : 'venueIdOrSymbolRegex')
    ..aOS(5, _omitFieldNames ? '' : 'instrumentIdOrSymbolRegex')
    ..pc<$2.InstrumentListingStatusEnum>(
        6, _omitFieldNames ? '' : 'listingTypes', $pb.PbFieldType.KE,
        valueOf: $2.InstrumentListingStatusEnum.valueOf,
        enumValues: $2.InstrumentListingStatusEnum.values,
        defaultEnumValue: $2.InstrumentListingStatusEnum
            .INSTRUMENT_LISTING_STATUS_ENUM__UNKNOWN)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'GetInstrumentListRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInstrumentListRequest clone() =>
      GetInstrumentListRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInstrumentListRequest copyWith(
          void Function(GetInstrumentListRequest) updates) =>
      super.copyWith((message) => updates(message as GetInstrumentListRequest))
          as GetInstrumentListRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInstrumentListRequest create() => GetInstrumentListRequest._();
  @$core.override
  GetInstrumentListRequest createEmptyInstance() => create();
  static $pb.PbList<GetInstrumentListRequest> createRepeated() =>
      $pb.PbList<GetInstrumentListRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInstrumentListRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInstrumentListRequest>(create);
  static GetInstrumentListRequest? _defaultInstance;

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

  @$pb.TagNumber(5)
  $core.String get instrumentIdOrSymbolRegex => $_getSZ(4);
  @$pb.TagNumber(5)
  set instrumentIdOrSymbolRegex($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasInstrumentIdOrSymbolRegex() => $_has(4);
  @$pb.TagNumber(5)
  void clearInstrumentIdOrSymbolRegex() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$2.InstrumentListingStatusEnum> get listingTypes => $_getList(5);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(6);
}

class GetInstrumentListResponse extends $pb.GeneratedMessage {
  factory GetInstrumentListResponse({
    $core.String? refExecutionId,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<$2.Instrument>? instruments,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (instruments != null) result.instruments.addAll(instruments);
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  GetInstrumentListResponse._();

  factory GetInstrumentListResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInstrumentListResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInstrumentListResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<$2.Instrument>(
        3, _omitFieldNames ? '' : 'instruments', $pb.PbFieldType.PM,
        subBuilder: $2.Instrument.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'GetInstrumentListResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInstrumentListResponse clone() =>
      GetInstrumentListResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInstrumentListResponse copyWith(
          void Function(GetInstrumentListResponse) updates) =>
      super.copyWith((message) => updates(message as GetInstrumentListResponse))
          as GetInstrumentListResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInstrumentListResponse create() => GetInstrumentListResponse._();
  @$core.override
  GetInstrumentListResponse createEmptyInstance() => create();
  static $pb.PbList<GetInstrumentListResponse> createRepeated() =>
      $pb.PbList<GetInstrumentListResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInstrumentListResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInstrumentListResponse>(create);
  static GetInstrumentListResponse? _defaultInstance;

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
  $pb.PbList<$2.Instrument> get instruments => $_getList(2);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(3);
}

class GetInstrumentInfoBatchRequest extends $pb.GeneratedMessage {
  factory GetInstrumentInfoBatchRequest({
    $core.String? proposedExecutionId,
    $1.PaginationParams? pagination,
    $core.Iterable<$core.String>? instrumentIdAndSymbolRegexes,
    $core.Iterable<$2.InstrumentListingStatusEnum>? listingTypes,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (pagination != null) result.pagination = pagination;
    if (instrumentIdAndSymbolRegexes != null)
      result.instrumentIdAndSymbolRegexes.addAll(instrumentIdAndSymbolRegexes);
    if (listingTypes != null) result.listingTypes.addAll(listingTypes);
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  GetInstrumentInfoBatchRequest._();

  factory GetInstrumentInfoBatchRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInstrumentInfoBatchRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInstrumentInfoBatchRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..pPS(3, _omitFieldNames ? '' : 'instrumentIdAndSymbolRegexes')
    ..pc<$2.InstrumentListingStatusEnum>(
        4, _omitFieldNames ? '' : 'listingTypes', $pb.PbFieldType.KE,
        valueOf: $2.InstrumentListingStatusEnum.valueOf,
        enumValues: $2.InstrumentListingStatusEnum.values,
        defaultEnumValue: $2.InstrumentListingStatusEnum
            .INSTRUMENT_LISTING_STATUS_ENUM__UNKNOWN)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'GetInstrumentInfoBatchRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInstrumentInfoBatchRequest clone() =>
      GetInstrumentInfoBatchRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInstrumentInfoBatchRequest copyWith(
          void Function(GetInstrumentInfoBatchRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetInstrumentInfoBatchRequest))
          as GetInstrumentInfoBatchRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInstrumentInfoBatchRequest create() =>
      GetInstrumentInfoBatchRequest._();
  @$core.override
  GetInstrumentInfoBatchRequest createEmptyInstance() => create();
  static $pb.PbList<GetInstrumentInfoBatchRequest> createRepeated() =>
      $pb.PbList<GetInstrumentInfoBatchRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInstrumentInfoBatchRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInstrumentInfoBatchRequest>(create);
  static GetInstrumentInfoBatchRequest? _defaultInstance;

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
  $pb.PbList<$core.String> get instrumentIdAndSymbolRegexes => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<$2.InstrumentListingStatusEnum> get listingTypes => $_getList(3);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(4);
}

class GetInstrumentInfoBatchResponse extends $pb.GeneratedMessage {
  factory GetInstrumentInfoBatchResponse({
    $core.String? refExecutionId,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<$2.Instrument>? instruments,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (instruments != null) result.instruments.addAll(instruments);
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  GetInstrumentInfoBatchResponse._();

  factory GetInstrumentInfoBatchResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInstrumentInfoBatchResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInstrumentInfoBatchResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.PaginationInfo>(3, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<$2.Instrument>(
        4, _omitFieldNames ? '' : 'instruments', $pb.PbFieldType.PM,
        subBuilder: $2.Instrument.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'GetInstrumentInfoBatchResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInstrumentInfoBatchResponse clone() =>
      GetInstrumentInfoBatchResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInstrumentInfoBatchResponse copyWith(
          void Function(GetInstrumentInfoBatchResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInstrumentInfoBatchResponse))
          as GetInstrumentInfoBatchResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInstrumentInfoBatchResponse create() =>
      GetInstrumentInfoBatchResponse._();
  @$core.override
  GetInstrumentInfoBatchResponse createEmptyInstance() => create();
  static $pb.PbList<GetInstrumentInfoBatchResponse> createRepeated() =>
      $pb.PbList<GetInstrumentInfoBatchResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInstrumentInfoBatchResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInstrumentInfoBatchResponse>(create);
  static GetInstrumentInfoBatchResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => $_clearField(1);

  @$pb.TagNumber(3)
  $1.PaginationInfo get paginationInfo => $_getN(1);
  @$pb.TagNumber(3)
  set paginationInfo($1.PaginationInfo value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPaginationInfo() => $_has(1);
  @$pb.TagNumber(3)
  void clearPaginationInfo() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.PaginationInfo ensurePaginationInfo() => $_ensure(1);

  @$pb.TagNumber(4)
  $pb.PbList<$2.Instrument> get instruments => $_getList(2);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(3);
}

class GetInstrumentOrdersRequest extends $pb.GeneratedMessage {
  factory GetInstrumentOrdersRequest({
    $core.String? proposedExecutionId,
    $1.PaginationParams? pagination,
    $core.Iterable<$core.String>? instrumentIdAndSymbolRegexes,
    $3.OrderQueryFilter? orderQueryFilter,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (pagination != null) result.pagination = pagination;
    if (instrumentIdAndSymbolRegexes != null)
      result.instrumentIdAndSymbolRegexes.addAll(instrumentIdAndSymbolRegexes);
    if (orderQueryFilter != null) result.orderQueryFilter = orderQueryFilter;
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  GetInstrumentOrdersRequest._();

  factory GetInstrumentOrdersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInstrumentOrdersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInstrumentOrdersRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..pPS(3, _omitFieldNames ? '' : 'instrumentIdAndSymbolRegexes')
    ..aOM<$3.OrderQueryFilter>(4, _omitFieldNames ? '' : 'orderQueryFilter',
        subBuilder: $3.OrderQueryFilter.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'GetInstrumentOrdersRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInstrumentOrdersRequest clone() =>
      GetInstrumentOrdersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInstrumentOrdersRequest copyWith(
          void Function(GetInstrumentOrdersRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetInstrumentOrdersRequest))
          as GetInstrumentOrdersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInstrumentOrdersRequest create() => GetInstrumentOrdersRequest._();
  @$core.override
  GetInstrumentOrdersRequest createEmptyInstance() => create();
  static $pb.PbList<GetInstrumentOrdersRequest> createRepeated() =>
      $pb.PbList<GetInstrumentOrdersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInstrumentOrdersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInstrumentOrdersRequest>(create);
  static GetInstrumentOrdersRequest? _defaultInstance;

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
  $pb.PbList<$core.String> get instrumentIdAndSymbolRegexes => $_getList(2);

  @$pb.TagNumber(4)
  $3.OrderQueryFilter get orderQueryFilter => $_getN(3);
  @$pb.TagNumber(4)
  set orderQueryFilter($3.OrderQueryFilter value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasOrderQueryFilter() => $_has(3);
  @$pb.TagNumber(4)
  void clearOrderQueryFilter() => $_clearField(4);
  @$pb.TagNumber(4)
  $3.OrderQueryFilter ensureOrderQueryFilter() => $_ensure(3);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(4);
}

class GetInstrumentOrdersResponse extends $pb.GeneratedMessage {
  factory GetInstrumentOrdersResponse({
    $core.String? refExecutionId,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<$2.Order>? orders,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (orders != null) result.orders.addAll(orders);
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  GetInstrumentOrdersResponse._();

  factory GetInstrumentOrdersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInstrumentOrdersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInstrumentOrdersResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<$2.Order>(3, _omitFieldNames ? '' : 'orders', $pb.PbFieldType.PM,
        subBuilder: $2.Order.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'GetInstrumentOrdersResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInstrumentOrdersResponse clone() =>
      GetInstrumentOrdersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInstrumentOrdersResponse copyWith(
          void Function(GetInstrumentOrdersResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInstrumentOrdersResponse))
          as GetInstrumentOrdersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInstrumentOrdersResponse create() =>
      GetInstrumentOrdersResponse._();
  @$core.override
  GetInstrumentOrdersResponse createEmptyInstance() => create();
  static $pb.PbList<GetInstrumentOrdersResponse> createRepeated() =>
      $pb.PbList<GetInstrumentOrdersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInstrumentOrdersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInstrumentOrdersResponse>(create);
  static GetInstrumentOrdersResponse? _defaultInstance;

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
  $pb.PbList<$2.Order> get orders => $_getList(2);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(3);
}

class GetInstrumentTradesRequest extends $pb.GeneratedMessage {
  factory GetInstrumentTradesRequest({
    $core.String? proposedExecutionId,
    $1.PaginationParams? pagination,
    $core.Iterable<$core.String>? instrumentIdAndSymbolRegexes,
    $3.TradeQueryFilter? tradeQueryFilter,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (pagination != null) result.pagination = pagination;
    if (instrumentIdAndSymbolRegexes != null)
      result.instrumentIdAndSymbolRegexes.addAll(instrumentIdAndSymbolRegexes);
    if (tradeQueryFilter != null) result.tradeQueryFilter = tradeQueryFilter;
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  GetInstrumentTradesRequest._();

  factory GetInstrumentTradesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInstrumentTradesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInstrumentTradesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..pPS(3, _omitFieldNames ? '' : 'instrumentIdAndSymbolRegexes')
    ..aOM<$3.TradeQueryFilter>(4, _omitFieldNames ? '' : 'tradeQueryFilter',
        subBuilder: $3.TradeQueryFilter.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'GetInstrumentTradesRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInstrumentTradesRequest clone() =>
      GetInstrumentTradesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInstrumentTradesRequest copyWith(
          void Function(GetInstrumentTradesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetInstrumentTradesRequest))
          as GetInstrumentTradesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInstrumentTradesRequest create() => GetInstrumentTradesRequest._();
  @$core.override
  GetInstrumentTradesRequest createEmptyInstance() => create();
  static $pb.PbList<GetInstrumentTradesRequest> createRepeated() =>
      $pb.PbList<GetInstrumentTradesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInstrumentTradesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInstrumentTradesRequest>(create);
  static GetInstrumentTradesRequest? _defaultInstance;

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
  $pb.PbList<$core.String> get instrumentIdAndSymbolRegexes => $_getList(2);

  @$pb.TagNumber(4)
  $3.TradeQueryFilter get tradeQueryFilter => $_getN(3);
  @$pb.TagNumber(4)
  set tradeQueryFilter($3.TradeQueryFilter value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasTradeQueryFilter() => $_has(3);
  @$pb.TagNumber(4)
  void clearTradeQueryFilter() => $_clearField(4);
  @$pb.TagNumber(4)
  $3.TradeQueryFilter ensureTradeQueryFilter() => $_ensure(3);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(4);
}

class GetInstrumentTradesResponse extends $pb.GeneratedMessage {
  factory GetInstrumentTradesResponse({
    $core.String? refExecutionId,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<$2.Trade>? trades,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (trades != null) result.trades.addAll(trades);
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  GetInstrumentTradesResponse._();

  factory GetInstrumentTradesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInstrumentTradesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInstrumentTradesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<$2.Trade>(3, _omitFieldNames ? '' : 'trades', $pb.PbFieldType.PM,
        subBuilder: $2.Trade.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'GetInstrumentTradesResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInstrumentTradesResponse clone() =>
      GetInstrumentTradesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInstrumentTradesResponse copyWith(
          void Function(GetInstrumentTradesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInstrumentTradesResponse))
          as GetInstrumentTradesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInstrumentTradesResponse create() =>
      GetInstrumentTradesResponse._();
  @$core.override
  GetInstrumentTradesResponse createEmptyInstance() => create();
  static $pb.PbList<GetInstrumentTradesResponse> createRepeated() =>
      $pb.PbList<GetInstrumentTradesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInstrumentTradesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInstrumentTradesResponse>(create);
  static GetInstrumentTradesResponse? _defaultInstance;

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
  $pb.PbList<$2.Trade> get trades => $_getList(2);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(3);
}

class GetInstrumentSettlementsRequest extends $pb.GeneratedMessage {
  factory GetInstrumentSettlementsRequest({
    $core.String? proposedExecutionId,
    $1.PaginationParams? pagination,
    $core.Iterable<$core.String>? instrumentIdAndSymbolRegexes,
    $3.SettlementQueryFilter? settlementQueryFilter,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (pagination != null) result.pagination = pagination;
    if (instrumentIdAndSymbolRegexes != null)
      result.instrumentIdAndSymbolRegexes.addAll(instrumentIdAndSymbolRegexes);
    if (settlementQueryFilter != null)
      result.settlementQueryFilter = settlementQueryFilter;
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  GetInstrumentSettlementsRequest._();

  factory GetInstrumentSettlementsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInstrumentSettlementsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInstrumentSettlementsRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..pPS(3, _omitFieldNames ? '' : 'instrumentIdAndSymbolRegexes')
    ..aOM<$3.SettlementQueryFilter>(
        4, _omitFieldNames ? '' : 'settlementQueryFilter',
        subBuilder: $3.SettlementQueryFilter.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'GetInstrumentSettlementsRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInstrumentSettlementsRequest clone() =>
      GetInstrumentSettlementsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInstrumentSettlementsRequest copyWith(
          void Function(GetInstrumentSettlementsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetInstrumentSettlementsRequest))
          as GetInstrumentSettlementsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInstrumentSettlementsRequest create() =>
      GetInstrumentSettlementsRequest._();
  @$core.override
  GetInstrumentSettlementsRequest createEmptyInstance() => create();
  static $pb.PbList<GetInstrumentSettlementsRequest> createRepeated() =>
      $pb.PbList<GetInstrumentSettlementsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInstrumentSettlementsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInstrumentSettlementsRequest>(
          create);
  static GetInstrumentSettlementsRequest? _defaultInstance;

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
  $pb.PbList<$core.String> get instrumentIdAndSymbolRegexes => $_getList(2);

  @$pb.TagNumber(4)
  $3.SettlementQueryFilter get settlementQueryFilter => $_getN(3);
  @$pb.TagNumber(4)
  set settlementQueryFilter($3.SettlementQueryFilter value) =>
      $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasSettlementQueryFilter() => $_has(3);
  @$pb.TagNumber(4)
  void clearSettlementQueryFilter() => $_clearField(4);
  @$pb.TagNumber(4)
  $3.SettlementQueryFilter ensureSettlementQueryFilter() => $_ensure(3);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(4);
}

class GetInstrumentSettlementsResponse extends $pb.GeneratedMessage {
  factory GetInstrumentSettlementsResponse({
    $core.String? refExecutionId,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<$2.Settlement>? settlements,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (settlements != null) result.settlements.addAll(settlements);
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  GetInstrumentSettlementsResponse._();

  factory GetInstrumentSettlementsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInstrumentSettlementsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInstrumentSettlementsResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<$2.Settlement>(
        3, _omitFieldNames ? '' : 'settlements', $pb.PbFieldType.PM,
        subBuilder: $2.Settlement.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'GetInstrumentSettlementsResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInstrumentSettlementsResponse clone() =>
      GetInstrumentSettlementsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInstrumentSettlementsResponse copyWith(
          void Function(GetInstrumentSettlementsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInstrumentSettlementsResponse))
          as GetInstrumentSettlementsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInstrumentSettlementsResponse create() =>
      GetInstrumentSettlementsResponse._();
  @$core.override
  GetInstrumentSettlementsResponse createEmptyInstance() => create();
  static $pb.PbList<GetInstrumentSettlementsResponse> createRepeated() =>
      $pb.PbList<GetInstrumentSettlementsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInstrumentSettlementsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInstrumentSettlementsResponse>(
          create);
  static GetInstrumentSettlementsResponse? _defaultInstance;

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
  $pb.PbList<$2.Settlement> get settlements => $_getList(2);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
