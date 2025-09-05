// This is a generated file - do not edit.
//
// Generated from qomet/agora/daemons/prtagent/v1/market.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $1;
import 'market.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'market.pbenum.dart';

class MarketDuration extends $pb.GeneratedMessage {
  factory MarketDuration({
    $1.Duration? duration,
    MarketStatus? status,
    $core.String? metadata,
    $core.Iterable<$core.String>? comments,
  }) {
    final result = create();
    if (duration != null) result.duration = duration;
    if (status != null) result.status = status;
    if (metadata != null) result.metadata = metadata;
    if (comments != null) result.comments.addAll(comments);
    return result;
  }

  MarketDuration._();

  factory MarketDuration.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MarketDuration.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MarketDuration',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOM<$1.Duration>(1, _omitFieldNames ? '' : 'duration',
        subBuilder: $1.Duration.create)
    ..e<MarketStatus>(2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: MarketStatus.MARKET_STATUS__UNKNOWN,
        valueOf: MarketStatus.valueOf,
        enumValues: MarketStatus.values)
    ..aOS(3, _omitFieldNames ? '' : 'metadata')
    ..pPS(4, _omitFieldNames ? '' : 'comments')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarketDuration clone() => MarketDuration()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarketDuration copyWith(void Function(MarketDuration) updates) =>
      super.copyWith((message) => updates(message as MarketDuration))
          as MarketDuration;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarketDuration create() => MarketDuration._();
  @$core.override
  MarketDuration createEmptyInstance() => create();
  static $pb.PbList<MarketDuration> createRepeated() =>
      $pb.PbList<MarketDuration>();
  @$core.pragma('dart2js:noInline')
  static MarketDuration getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MarketDuration>(create);
  static MarketDuration? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Duration get duration => $_getN(0);
  @$pb.TagNumber(1)
  set duration($1.Duration value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDuration() => $_has(0);
  @$pb.TagNumber(1)
  void clearDuration() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Duration ensureDuration() => $_ensure(0);

  @$pb.TagNumber(2)
  MarketStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(MarketStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get metadata => $_getSZ(2);
  @$pb.TagNumber(3)
  set metadata($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMetadata() => $_has(2);
  @$pb.TagNumber(3)
  void clearMetadata() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get comments => $_getList(3);
}

class MarketCalendar extends $pb.GeneratedMessage {
  factory MarketCalendar({
    $core.Iterable<$core.String>? marketIdentifiers,
    $1.Time? dailyOpen,
    $1.Time? dailyClose,
    $core.Iterable<$1.Duration>? calendar,
  }) {
    final result = create();
    if (marketIdentifiers != null)
      result.marketIdentifiers.addAll(marketIdentifiers);
    if (dailyOpen != null) result.dailyOpen = dailyOpen;
    if (dailyClose != null) result.dailyClose = dailyClose;
    if (calendar != null) result.calendar.addAll(calendar);
    return result;
  }

  MarketCalendar._();

  factory MarketCalendar.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MarketCalendar.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MarketCalendar',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'marketIdentifiers')
    ..aOM<$1.Time>(2, _omitFieldNames ? '' : 'dailyOpen',
        subBuilder: $1.Time.create)
    ..aOM<$1.Time>(3, _omitFieldNames ? '' : 'dailyClose',
        subBuilder: $1.Time.create)
    ..pc<$1.Duration>(4, _omitFieldNames ? '' : 'calendar', $pb.PbFieldType.PM,
        subBuilder: $1.Duration.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarketCalendar clone() => MarketCalendar()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarketCalendar copyWith(void Function(MarketCalendar) updates) =>
      super.copyWith((message) => updates(message as MarketCalendar))
          as MarketCalendar;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarketCalendar create() => MarketCalendar._();
  @$core.override
  MarketCalendar createEmptyInstance() => create();
  static $pb.PbList<MarketCalendar> createRepeated() =>
      $pb.PbList<MarketCalendar>();
  @$core.pragma('dart2js:noInline')
  static MarketCalendar getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MarketCalendar>(create);
  static MarketCalendar? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get marketIdentifiers => $_getList(0);

  @$pb.TagNumber(2)
  $1.Time get dailyOpen => $_getN(1);
  @$pb.TagNumber(2)
  set dailyOpen($1.Time value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDailyOpen() => $_has(1);
  @$pb.TagNumber(2)
  void clearDailyOpen() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Time ensureDailyOpen() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.Time get dailyClose => $_getN(2);
  @$pb.TagNumber(3)
  set dailyClose($1.Time value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDailyClose() => $_has(2);
  @$pb.TagNumber(3)
  void clearDailyClose() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Time ensureDailyClose() => $_ensure(2);

  @$pb.TagNumber(4)
  $pb.PbList<$1.Duration> get calendar => $_getList(3);
}

class GetMarketListRequest extends $pb.GeneratedMessage {
  factory GetMarketListRequest({
    $core.String? refRequestId,
    $1.PaginationParams? pagination,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (pagination != null) result.pagination = pagination;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
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

class GetMarketListResponse extends $pb.GeneratedMessage {
  factory GetMarketListResponse({
    $core.String? refRequestId,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<$1.Market>? markets,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (markets != null) result.markets.addAll(markets);
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<$1.Market>(3, _omitFieldNames ? '' : 'markets', $pb.PbFieldType.PM,
        subBuilder: $1.Market.create)
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
  $pb.PbList<$1.Market> get markets => $_getList(2);
}

class GetMarketsInfoRequest extends $pb.GeneratedMessage {
  factory GetMarketsInfoRequest({
    $core.String? refRequestId,
    $core.Iterable<$core.String>? marketIds,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (marketIds != null) result.marketIds.addAll(marketIds);
    return result;
  }

  GetMarketsInfoRequest._();

  factory GetMarketsInfoRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMarketsInfoRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMarketsInfoRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..pPS(2, _omitFieldNames ? '' : 'marketIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketsInfoRequest clone() =>
      GetMarketsInfoRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketsInfoRequest copyWith(
          void Function(GetMarketsInfoRequest) updates) =>
      super.copyWith((message) => updates(message as GetMarketsInfoRequest))
          as GetMarketsInfoRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketsInfoRequest create() => GetMarketsInfoRequest._();
  @$core.override
  GetMarketsInfoRequest createEmptyInstance() => create();
  static $pb.PbList<GetMarketsInfoRequest> createRepeated() =>
      $pb.PbList<GetMarketsInfoRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMarketsInfoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMarketsInfoRequest>(create);
  static GetMarketsInfoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get marketIds => $_getList(1);
}

class GetMarketsInfoResponse extends $pb.GeneratedMessage {
  factory GetMarketsInfoResponse({
    $core.String? refRequestId,
    $core.Iterable<$1.Market>? markets,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (markets != null) result.markets.addAll(markets);
    return result;
  }

  GetMarketsInfoResponse._();

  factory GetMarketsInfoResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMarketsInfoResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMarketsInfoResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..pc<$1.Market>(2, _omitFieldNames ? '' : 'markets', $pb.PbFieldType.PM,
        subBuilder: $1.Market.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketsInfoResponse clone() =>
      GetMarketsInfoResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketsInfoResponse copyWith(
          void Function(GetMarketsInfoResponse) updates) =>
      super.copyWith((message) => updates(message as GetMarketsInfoResponse))
          as GetMarketsInfoResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketsInfoResponse create() => GetMarketsInfoResponse._();
  @$core.override
  GetMarketsInfoResponse createEmptyInstance() => create();
  static $pb.PbList<GetMarketsInfoResponse> createRepeated() =>
      $pb.PbList<GetMarketsInfoResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMarketsInfoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMarketsInfoResponse>(create);
  static GetMarketsInfoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$1.Market> get markets => $_getList(1);
}

class GetMarketCalendarRequest extends $pb.GeneratedMessage {
  factory GetMarketCalendarRequest({
    $core.String? refRequestId,
    $core.String? marketId,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (marketId != null) result.marketId = marketId;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'marketId')
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get marketId => $_getSZ(1);
  @$pb.TagNumber(2)
  set marketId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMarketId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMarketId() => $_clearField(2);
}

class GetMarketCalendarResponse extends $pb.GeneratedMessage {
  factory GetMarketCalendarResponse({
    $core.String? refRequestId,
    MarketCalendar? calendar,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (calendar != null) result.calendar = calendar;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<MarketCalendar>(2, _omitFieldNames ? '' : 'calendar',
        subBuilder: MarketCalendar.create)
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  MarketCalendar get calendar => $_getN(1);
  @$pb.TagNumber(2)
  set calendar(MarketCalendar value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCalendar() => $_has(1);
  @$pb.TagNumber(2)
  void clearCalendar() => $_clearField(2);
  @$pb.TagNumber(2)
  MarketCalendar ensureCalendar() => $_ensure(1);
}

class GetMarketSupportedCurrenciesRequest extends $pb.GeneratedMessage {
  factory GetMarketSupportedCurrenciesRequest({
    $core.String? refRequestId,
    $1.PaginationParams? pagination,
    $core.String? marketId,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (pagination != null) result.pagination = pagination;
    if (marketId != null) result.marketId = marketId;
    return result;
  }

  GetMarketSupportedCurrenciesRequest._();

  factory GetMarketSupportedCurrenciesRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMarketSupportedCurrenciesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMarketSupportedCurrenciesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..aOS(3, _omitFieldNames ? '' : 'marketId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketSupportedCurrenciesRequest clone() =>
      GetMarketSupportedCurrenciesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketSupportedCurrenciesRequest copyWith(
          void Function(GetMarketSupportedCurrenciesRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetMarketSupportedCurrenciesRequest))
          as GetMarketSupportedCurrenciesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketSupportedCurrenciesRequest create() =>
      GetMarketSupportedCurrenciesRequest._();
  @$core.override
  GetMarketSupportedCurrenciesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMarketSupportedCurrenciesRequest> createRepeated() =>
      $pb.PbList<GetMarketSupportedCurrenciesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMarketSupportedCurrenciesRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetMarketSupportedCurrenciesRequest>(create);
  static GetMarketSupportedCurrenciesRequest? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.String get marketId => $_getSZ(2);
  @$pb.TagNumber(3)
  set marketId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMarketId() => $_has(2);
  @$pb.TagNumber(3)
  void clearMarketId() => $_clearField(3);
}

class GetMarketSupportedCurrenciesResponse extends $pb.GeneratedMessage {
  factory GetMarketSupportedCurrenciesResponse({
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

  GetMarketSupportedCurrenciesResponse._();

  factory GetMarketSupportedCurrenciesResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMarketSupportedCurrenciesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMarketSupportedCurrenciesResponse',
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
  GetMarketSupportedCurrenciesResponse clone() =>
      GetMarketSupportedCurrenciesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketSupportedCurrenciesResponse copyWith(
          void Function(GetMarketSupportedCurrenciesResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetMarketSupportedCurrenciesResponse))
          as GetMarketSupportedCurrenciesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketSupportedCurrenciesResponse create() =>
      GetMarketSupportedCurrenciesResponse._();
  @$core.override
  GetMarketSupportedCurrenciesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMarketSupportedCurrenciesResponse> createRepeated() =>
      $pb.PbList<GetMarketSupportedCurrenciesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMarketSupportedCurrenciesResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetMarketSupportedCurrenciesResponse>(create);
  static GetMarketSupportedCurrenciesResponse? _defaultInstance;

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

class GetMarketInstrumentListRequest extends $pb.GeneratedMessage {
  factory GetMarketInstrumentListRequest({
    $core.String? refRequestId,
    $1.PaginationParams? pagination,
    $core.String? marketId,
    $core.String? instrumentIdRegex,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (pagination != null) result.pagination = pagination;
    if (marketId != null) result.marketId = marketId;
    if (instrumentIdRegex != null) result.instrumentIdRegex = instrumentIdRegex;
    return result;
  }

  GetMarketInstrumentListRequest._();

  factory GetMarketInstrumentListRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMarketInstrumentListRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMarketInstrumentListRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..aOS(3, _omitFieldNames ? '' : 'marketId')
    ..aOS(4, _omitFieldNames ? '' : 'instrumentIdRegex')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketInstrumentListRequest clone() =>
      GetMarketInstrumentListRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketInstrumentListRequest copyWith(
          void Function(GetMarketInstrumentListRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetMarketInstrumentListRequest))
          as GetMarketInstrumentListRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketInstrumentListRequest create() =>
      GetMarketInstrumentListRequest._();
  @$core.override
  GetMarketInstrumentListRequest createEmptyInstance() => create();
  static $pb.PbList<GetMarketInstrumentListRequest> createRepeated() =>
      $pb.PbList<GetMarketInstrumentListRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMarketInstrumentListRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMarketInstrumentListRequest>(create);
  static GetMarketInstrumentListRequest? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.String get marketId => $_getSZ(2);
  @$pb.TagNumber(3)
  set marketId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMarketId() => $_has(2);
  @$pb.TagNumber(3)
  void clearMarketId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get instrumentIdRegex => $_getSZ(3);
  @$pb.TagNumber(4)
  set instrumentIdRegex($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInstrumentIdRegex() => $_has(3);
  @$pb.TagNumber(4)
  void clearInstrumentIdRegex() => $_clearField(4);
}

class GetMarketInstrumentListResponse extends $pb.GeneratedMessage {
  factory GetMarketInstrumentListResponse({
    $core.String? refRequestId,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<$1.Instrument>? instruments,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (instruments != null) result.instruments.addAll(instruments);
    return result;
  }

  GetMarketInstrumentListResponse._();

  factory GetMarketInstrumentListResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMarketInstrumentListResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMarketInstrumentListResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<$1.Instrument>(
        3, _omitFieldNames ? '' : 'instruments', $pb.PbFieldType.PM,
        subBuilder: $1.Instrument.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketInstrumentListResponse clone() =>
      GetMarketInstrumentListResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketInstrumentListResponse copyWith(
          void Function(GetMarketInstrumentListResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetMarketInstrumentListResponse))
          as GetMarketInstrumentListResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketInstrumentListResponse create() =>
      GetMarketInstrumentListResponse._();
  @$core.override
  GetMarketInstrumentListResponse createEmptyInstance() => create();
  static $pb.PbList<GetMarketInstrumentListResponse> createRepeated() =>
      $pb.PbList<GetMarketInstrumentListResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMarketInstrumentListResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMarketInstrumentListResponse>(
          create);
  static GetMarketInstrumentListResponse? _defaultInstance;

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
  $pb.PbList<$1.Instrument> get instruments => $_getList(2);
}

class FeeStructure extends $pb.GeneratedMessage {
  factory FeeStructure({
    $core.String? baseFee,
    $core.String? percentageFee,
    $core.String? minimumFee,
    $core.String? maximumFee,
    $core.String? gasFeeEstimate,
    $core.String? makerFee,
    $core.String? takerFee,
    $core.String? currency,
    $core.String? feeTier,
    $core.String? discountRate,
    $core.String? totalEstimatedFee,
  }) {
    final result = create();
    if (baseFee != null) result.baseFee = baseFee;
    if (percentageFee != null) result.percentageFee = percentageFee;
    if (minimumFee != null) result.minimumFee = minimumFee;
    if (maximumFee != null) result.maximumFee = maximumFee;
    if (gasFeeEstimate != null) result.gasFeeEstimate = gasFeeEstimate;
    if (makerFee != null) result.makerFee = makerFee;
    if (takerFee != null) result.takerFee = takerFee;
    if (currency != null) result.currency = currency;
    if (feeTier != null) result.feeTier = feeTier;
    if (discountRate != null) result.discountRate = discountRate;
    if (totalEstimatedFee != null) result.totalEstimatedFee = totalEstimatedFee;
    return result;
  }

  FeeStructure._();

  factory FeeStructure.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FeeStructure.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FeeStructure',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'baseFee')
    ..aOS(2, _omitFieldNames ? '' : 'percentageFee')
    ..aOS(3, _omitFieldNames ? '' : 'minimumFee')
    ..aOS(4, _omitFieldNames ? '' : 'maximumFee')
    ..aOS(5, _omitFieldNames ? '' : 'gasFeeEstimate')
    ..aOS(6, _omitFieldNames ? '' : 'makerFee')
    ..aOS(7, _omitFieldNames ? '' : 'takerFee')
    ..aOS(8, _omitFieldNames ? '' : 'currency')
    ..aOS(9, _omitFieldNames ? '' : 'feeTier')
    ..aOS(10, _omitFieldNames ? '' : 'discountRate')
    ..aOS(11, _omitFieldNames ? '' : 'totalEstimatedFee')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FeeStructure clone() => FeeStructure()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FeeStructure copyWith(void Function(FeeStructure) updates) =>
      super.copyWith((message) => updates(message as FeeStructure))
          as FeeStructure;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FeeStructure create() => FeeStructure._();
  @$core.override
  FeeStructure createEmptyInstance() => create();
  static $pb.PbList<FeeStructure> createRepeated() =>
      $pb.PbList<FeeStructure>();
  @$core.pragma('dart2js:noInline')
  static FeeStructure getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FeeStructure>(create);
  static FeeStructure? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get baseFee => $_getSZ(0);
  @$pb.TagNumber(1)
  set baseFee($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBaseFee() => $_has(0);
  @$pb.TagNumber(1)
  void clearBaseFee() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get percentageFee => $_getSZ(1);
  @$pb.TagNumber(2)
  set percentageFee($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPercentageFee() => $_has(1);
  @$pb.TagNumber(2)
  void clearPercentageFee() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get minimumFee => $_getSZ(2);
  @$pb.TagNumber(3)
  set minimumFee($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMinimumFee() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinimumFee() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get maximumFee => $_getSZ(3);
  @$pb.TagNumber(4)
  set maximumFee($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMaximumFee() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaximumFee() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get gasFeeEstimate => $_getSZ(4);
  @$pb.TagNumber(5)
  set gasFeeEstimate($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasGasFeeEstimate() => $_has(4);
  @$pb.TagNumber(5)
  void clearGasFeeEstimate() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get makerFee => $_getSZ(5);
  @$pb.TagNumber(6)
  set makerFee($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMakerFee() => $_has(5);
  @$pb.TagNumber(6)
  void clearMakerFee() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get takerFee => $_getSZ(6);
  @$pb.TagNumber(7)
  set takerFee($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTakerFee() => $_has(6);
  @$pb.TagNumber(7)
  void clearTakerFee() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get currency => $_getSZ(7);
  @$pb.TagNumber(8)
  set currency($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCurrency() => $_has(7);
  @$pb.TagNumber(8)
  void clearCurrency() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get feeTier => $_getSZ(8);
  @$pb.TagNumber(9)
  set feeTier($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasFeeTier() => $_has(8);
  @$pb.TagNumber(9)
  void clearFeeTier() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get discountRate => $_getSZ(9);
  @$pb.TagNumber(10)
  set discountRate($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasDiscountRate() => $_has(9);
  @$pb.TagNumber(10)
  void clearDiscountRate() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get totalEstimatedFee => $_getSZ(10);
  @$pb.TagNumber(11)
  set totalEstimatedFee($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasTotalEstimatedFee() => $_has(10);
  @$pb.TagNumber(11)
  void clearTotalEstimatedFee() => $_clearField(11);
}

class GetOrderFeesRequest extends $pb.GeneratedMessage {
  factory GetOrderFeesRequest({
    $core.String? refRequestId,
    $core.String? accountId,
    $core.String? feePayerAccountId,
    $core.String? instrumentId,
    $core.String? orderType,
    $1.OrderSide? side,
    $core.String? quantity,
    $core.String? price,
    $core.String? timeInForce,
    $core.bool? isPostOnly,
    $core.String? metadata,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (accountId != null) result.accountId = accountId;
    if (feePayerAccountId != null) result.feePayerAccountId = feePayerAccountId;
    if (instrumentId != null) result.instrumentId = instrumentId;
    if (orderType != null) result.orderType = orderType;
    if (side != null) result.side = side;
    if (quantity != null) result.quantity = quantity;
    if (price != null) result.price = price;
    if (timeInForce != null) result.timeInForce = timeInForce;
    if (isPostOnly != null) result.isPostOnly = isPostOnly;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  GetOrderFeesRequest._();

  factory GetOrderFeesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOrderFeesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOrderFeesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..aOS(3, _omitFieldNames ? '' : 'feePayerAccountId')
    ..aOS(4, _omitFieldNames ? '' : 'instrumentId')
    ..aOS(5, _omitFieldNames ? '' : 'orderType')
    ..e<$1.OrderSide>(6, _omitFieldNames ? '' : 'side', $pb.PbFieldType.OE,
        defaultOrMaker: $1.OrderSide.ORDER_SIDE__UNKNOWN,
        valueOf: $1.OrderSide.valueOf,
        enumValues: $1.OrderSide.values)
    ..aOS(7, _omitFieldNames ? '' : 'quantity')
    ..aOS(8, _omitFieldNames ? '' : 'price')
    ..aOS(9, _omitFieldNames ? '' : 'timeInForce')
    ..aOB(10, _omitFieldNames ? '' : 'isPostOnly')
    ..aOS(11, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrderFeesRequest clone() => GetOrderFeesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrderFeesRequest copyWith(void Function(GetOrderFeesRequest) updates) =>
      super.copyWith((message) => updates(message as GetOrderFeesRequest))
          as GetOrderFeesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOrderFeesRequest create() => GetOrderFeesRequest._();
  @$core.override
  GetOrderFeesRequest createEmptyInstance() => create();
  static $pb.PbList<GetOrderFeesRequest> createRepeated() =>
      $pb.PbList<GetOrderFeesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOrderFeesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOrderFeesRequest>(create);
  static GetOrderFeesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get feePayerAccountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set feePayerAccountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFeePayerAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearFeePayerAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get instrumentId => $_getSZ(3);
  @$pb.TagNumber(4)
  set instrumentId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInstrumentId() => $_has(3);
  @$pb.TagNumber(4)
  void clearInstrumentId() => $_clearField(4);

  /// Order details for fee calculation
  @$pb.TagNumber(5)
  $core.String get orderType => $_getSZ(4);
  @$pb.TagNumber(5)
  set orderType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasOrderType() => $_has(4);
  @$pb.TagNumber(5)
  void clearOrderType() => $_clearField(5);

  @$pb.TagNumber(6)
  $1.OrderSide get side => $_getN(5);
  @$pb.TagNumber(6)
  set side($1.OrderSide value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasSide() => $_has(5);
  @$pb.TagNumber(6)
  void clearSide() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get quantity => $_getSZ(6);
  @$pb.TagNumber(7)
  set quantity($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasQuantity() => $_has(6);
  @$pb.TagNumber(7)
  void clearQuantity() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get price => $_getSZ(7);
  @$pb.TagNumber(8)
  set price($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPrice() => $_has(7);
  @$pb.TagNumber(8)
  void clearPrice() => $_clearField(8);

  /// Optional parameters that might affect fees
  @$pb.TagNumber(9)
  $core.String get timeInForce => $_getSZ(8);
  @$pb.TagNumber(9)
  set timeInForce($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasTimeInForce() => $_has(8);
  @$pb.TagNumber(9)
  void clearTimeInForce() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isPostOnly => $_getBF(9);
  @$pb.TagNumber(10)
  set isPostOnly($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasIsPostOnly() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsPostOnly() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get metadata => $_getSZ(10);
  @$pb.TagNumber(11)
  set metadata($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasMetadata() => $_has(10);
  @$pb.TagNumber(11)
  void clearMetadata() => $_clearField(11);
}

class GetOrderFeesResponse extends $pb.GeneratedMessage {
  factory GetOrderFeesResponse({
    $core.String? refRequestId,
    FeeStructure? feeStructure,
    $core.Iterable<$core.String>? feeNotes,
    $1.Time? feeValidUntil,
    $core.String? message,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? feeBreakdown,
    $core.Iterable<FeeStructure>? alternativeFeeOptions,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (feeStructure != null) result.feeStructure = feeStructure;
    if (feeNotes != null) result.feeNotes.addAll(feeNotes);
    if (feeValidUntil != null) result.feeValidUntil = feeValidUntil;
    if (message != null) result.message = message;
    if (feeBreakdown != null) result.feeBreakdown.addEntries(feeBreakdown);
    if (alternativeFeeOptions != null)
      result.alternativeFeeOptions.addAll(alternativeFeeOptions);
    return result;
  }

  GetOrderFeesResponse._();

  factory GetOrderFeesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOrderFeesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOrderFeesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<FeeStructure>(2, _omitFieldNames ? '' : 'feeStructure',
        subBuilder: FeeStructure.create)
    ..pPS(3, _omitFieldNames ? '' : 'feeNotes')
    ..aOM<$1.Time>(4, _omitFieldNames ? '' : 'feeValidUntil',
        subBuilder: $1.Time.create)
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..m<$core.String, $core.String>(6, _omitFieldNames ? '' : 'feeBreakdown',
        entryClassName: 'GetOrderFeesResponse.FeeBreakdownEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..pc<FeeStructure>(
        7, _omitFieldNames ? '' : 'alternativeFeeOptions', $pb.PbFieldType.PM,
        subBuilder: FeeStructure.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrderFeesResponse clone() =>
      GetOrderFeesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrderFeesResponse copyWith(void Function(GetOrderFeesResponse) updates) =>
      super.copyWith((message) => updates(message as GetOrderFeesResponse))
          as GetOrderFeesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOrderFeesResponse create() => GetOrderFeesResponse._();
  @$core.override
  GetOrderFeesResponse createEmptyInstance() => create();
  static $pb.PbList<GetOrderFeesResponse> createRepeated() =>
      $pb.PbList<GetOrderFeesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOrderFeesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOrderFeesResponse>(create);
  static GetOrderFeesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  FeeStructure get feeStructure => $_getN(1);
  @$pb.TagNumber(2)
  set feeStructure(FeeStructure value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasFeeStructure() => $_has(1);
  @$pb.TagNumber(2)
  void clearFeeStructure() => $_clearField(2);
  @$pb.TagNumber(2)
  FeeStructure ensureFeeStructure() => $_ensure(1);

  /// Additional fee information
  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get feeNotes => $_getList(2);

  @$pb.TagNumber(4)
  $1.Time get feeValidUntil => $_getN(3);
  @$pb.TagNumber(4)
  set feeValidUntil($1.Time value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasFeeValidUntil() => $_has(3);
  @$pb.TagNumber(4)
  void clearFeeValidUntil() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Time ensureFeeValidUntil() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => $_clearField(5);

  /// Breakdown by fee type
  @$pb.TagNumber(6)
  $pb.PbMap<$core.String, $core.String> get feeBreakdown => $_getMap(5);

  /// Alternative fee payment options
  @$pb.TagNumber(7)
  $pb.PbList<FeeStructure> get alternativeFeeOptions => $_getList(6);
}

class CreateOrderRequest extends $pb.GeneratedMessage {
  factory CreateOrderRequest({
    $core.String? refRequestId,
    $core.String? accountId,
    $core.String? feePayerAccountId,
    $core.String? instrumentId,
    $core.String? orderType,
    $1.OrderSide? side,
    $core.String? quantity,
    $core.String? price,
    $core.String? timeInForce,
    $1.Time? expireTime,
    $core.String? participantOrderId,
    $core.String? metadata,
    $core.String? auxData,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (accountId != null) result.accountId = accountId;
    if (feePayerAccountId != null) result.feePayerAccountId = feePayerAccountId;
    if (instrumentId != null) result.instrumentId = instrumentId;
    if (orderType != null) result.orderType = orderType;
    if (side != null) result.side = side;
    if (quantity != null) result.quantity = quantity;
    if (price != null) result.price = price;
    if (timeInForce != null) result.timeInForce = timeInForce;
    if (expireTime != null) result.expireTime = expireTime;
    if (participantOrderId != null)
      result.participantOrderId = participantOrderId;
    if (metadata != null) result.metadata = metadata;
    if (auxData != null) result.auxData = auxData;
    return result;
  }

  CreateOrderRequest._();

  factory CreateOrderRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateOrderRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateOrderRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..aOS(3, _omitFieldNames ? '' : 'feePayerAccountId')
    ..aOS(4, _omitFieldNames ? '' : 'instrumentId')
    ..aOS(5, _omitFieldNames ? '' : 'orderType')
    ..e<$1.OrderSide>(6, _omitFieldNames ? '' : 'side', $pb.PbFieldType.OE,
        defaultOrMaker: $1.OrderSide.ORDER_SIDE__UNKNOWN,
        valueOf: $1.OrderSide.valueOf,
        enumValues: $1.OrderSide.values)
    ..aOS(7, _omitFieldNames ? '' : 'quantity')
    ..aOS(8, _omitFieldNames ? '' : 'price')
    ..aOS(9, _omitFieldNames ? '' : 'timeInForce')
    ..aOM<$1.Time>(10, _omitFieldNames ? '' : 'expireTime',
        subBuilder: $1.Time.create)
    ..aOS(11, _omitFieldNames ? '' : 'participantOrderId')
    ..aOS(12, _omitFieldNames ? '' : 'metadata')
    ..aOS(13, _omitFieldNames ? '' : 'auxData')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateOrderRequest clone() => CreateOrderRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateOrderRequest copyWith(void Function(CreateOrderRequest) updates) =>
      super.copyWith((message) => updates(message as CreateOrderRequest))
          as CreateOrderRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateOrderRequest create() => CreateOrderRequest._();
  @$core.override
  CreateOrderRequest createEmptyInstance() => create();
  static $pb.PbList<CreateOrderRequest> createRepeated() =>
      $pb.PbList<CreateOrderRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateOrderRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateOrderRequest>(create);
  static CreateOrderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get feePayerAccountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set feePayerAccountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFeePayerAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearFeePayerAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get instrumentId => $_getSZ(3);
  @$pb.TagNumber(4)
  set instrumentId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInstrumentId() => $_has(3);
  @$pb.TagNumber(4)
  void clearInstrumentId() => $_clearField(4);

  /// Order details
  @$pb.TagNumber(5)
  $core.String get orderType => $_getSZ(4);
  @$pb.TagNumber(5)
  set orderType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasOrderType() => $_has(4);
  @$pb.TagNumber(5)
  void clearOrderType() => $_clearField(5);

  @$pb.TagNumber(6)
  $1.OrderSide get side => $_getN(5);
  @$pb.TagNumber(6)
  set side($1.OrderSide value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasSide() => $_has(5);
  @$pb.TagNumber(6)
  void clearSide() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get quantity => $_getSZ(6);
  @$pb.TagNumber(7)
  set quantity($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasQuantity() => $_has(6);
  @$pb.TagNumber(7)
  void clearQuantity() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get price => $_getSZ(7);
  @$pb.TagNumber(8)
  set price($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPrice() => $_has(7);
  @$pb.TagNumber(8)
  void clearPrice() => $_clearField(8);

  /// Time constraints
  @$pb.TagNumber(9)
  $core.String get timeInForce => $_getSZ(8);
  @$pb.TagNumber(9)
  set timeInForce($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasTimeInForce() => $_has(8);
  @$pb.TagNumber(9)
  void clearTimeInForce() => $_clearField(9);

  @$pb.TagNumber(10)
  $1.Time get expireTime => $_getN(9);
  @$pb.TagNumber(10)
  set expireTime($1.Time value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasExpireTime() => $_has(9);
  @$pb.TagNumber(10)
  void clearExpireTime() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.Time ensureExpireTime() => $_ensure(9);

  /// Additional parameters
  @$pb.TagNumber(11)
  $core.String get participantOrderId => $_getSZ(10);
  @$pb.TagNumber(11)
  set participantOrderId($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasParticipantOrderId() => $_has(10);
  @$pb.TagNumber(11)
  void clearParticipantOrderId() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get metadata => $_getSZ(11);
  @$pb.TagNumber(12)
  set metadata($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasMetadata() => $_has(11);
  @$pb.TagNumber(12)
  void clearMetadata() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get auxData => $_getSZ(12);
  @$pb.TagNumber(13)
  set auxData($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasAuxData() => $_has(12);
  @$pb.TagNumber(13)
  void clearAuxData() => $_clearField(13);
}

class CreateOrderResponse extends $pb.GeneratedMessage {
  factory CreateOrderResponse({
    $core.String? refRequestId,
    $core.String? proposedOrderId,
    $core.String? agentOrderId,
    $core.String? orderHash,
    $1.ConfirmationStatus? status,
    $core.String? message,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (proposedOrderId != null) result.proposedOrderId = proposedOrderId;
    if (agentOrderId != null) result.agentOrderId = agentOrderId;
    if (orderHash != null) result.orderHash = orderHash;
    if (status != null) result.status = status;
    if (message != null) result.message = message;
    return result;
  }

  CreateOrderResponse._();

  factory CreateOrderResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateOrderResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateOrderResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'proposedOrderId')
    ..aOS(3, _omitFieldNames ? '' : 'agentOrderId')
    ..aOS(4, _omitFieldNames ? '' : 'orderHash')
    ..e<$1.ConfirmationStatus>(
        5, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: $1.ConfirmationStatus.CONFIRMATION_STATUS__UNKNOWN,
        valueOf: $1.ConfirmationStatus.valueOf,
        enumValues: $1.ConfirmationStatus.values)
    ..aOS(6, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateOrderResponse clone() => CreateOrderResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateOrderResponse copyWith(void Function(CreateOrderResponse) updates) =>
      super.copyWith((message) => updates(message as CreateOrderResponse))
          as CreateOrderResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateOrderResponse create() => CreateOrderResponse._();
  @$core.override
  CreateOrderResponse createEmptyInstance() => create();
  static $pb.PbList<CreateOrderResponse> createRepeated() =>
      $pb.PbList<CreateOrderResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateOrderResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateOrderResponse>(create);
  static CreateOrderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get proposedOrderId => $_getSZ(1);
  @$pb.TagNumber(2)
  set proposedOrderId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProposedOrderId() => $_has(1);
  @$pb.TagNumber(2)
  void clearProposedOrderId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get agentOrderId => $_getSZ(2);
  @$pb.TagNumber(3)
  set agentOrderId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAgentOrderId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAgentOrderId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get orderHash => $_getSZ(3);
  @$pb.TagNumber(4)
  set orderHash($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOrderHash() => $_has(3);
  @$pb.TagNumber(4)
  void clearOrderHash() => $_clearField(4);

  @$pb.TagNumber(5)
  $1.ConfirmationStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status($1.ConfirmationStatus value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => $_clearField(6);
}

class ReplaceOrderRequest extends $pb.GeneratedMessage {
  factory ReplaceOrderRequest({
    $core.String? refRequestId,
    $core.String? proposedOrderId,
    $core.String? newProposedOrderId,
    $core.String? newQuantity,
    $core.String? newPrice,
    $1.Time? newExpireTime,
    $core.String? reason,
    $core.String? metadata,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (proposedOrderId != null) result.proposedOrderId = proposedOrderId;
    if (newProposedOrderId != null)
      result.newProposedOrderId = newProposedOrderId;
    if (newQuantity != null) result.newQuantity = newQuantity;
    if (newPrice != null) result.newPrice = newPrice;
    if (newExpireTime != null) result.newExpireTime = newExpireTime;
    if (reason != null) result.reason = reason;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  ReplaceOrderRequest._();

  factory ReplaceOrderRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReplaceOrderRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReplaceOrderRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'proposedOrderId')
    ..aOS(3, _omitFieldNames ? '' : 'newProposedOrderId')
    ..aOS(4, _omitFieldNames ? '' : 'newQuantity')
    ..aOS(5, _omitFieldNames ? '' : 'newPrice')
    ..aOM<$1.Time>(6, _omitFieldNames ? '' : 'newExpireTime',
        subBuilder: $1.Time.create)
    ..aOS(7, _omitFieldNames ? '' : 'reason')
    ..aOS(8, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReplaceOrderRequest clone() => ReplaceOrderRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReplaceOrderRequest copyWith(void Function(ReplaceOrderRequest) updates) =>
      super.copyWith((message) => updates(message as ReplaceOrderRequest))
          as ReplaceOrderRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReplaceOrderRequest create() => ReplaceOrderRequest._();
  @$core.override
  ReplaceOrderRequest createEmptyInstance() => create();
  static $pb.PbList<ReplaceOrderRequest> createRepeated() =>
      $pb.PbList<ReplaceOrderRequest>();
  @$core.pragma('dart2js:noInline')
  static ReplaceOrderRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReplaceOrderRequest>(create);
  static ReplaceOrderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get proposedOrderId => $_getSZ(1);
  @$pb.TagNumber(2)
  set proposedOrderId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProposedOrderId() => $_has(1);
  @$pb.TagNumber(2)
  void clearProposedOrderId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get newProposedOrderId => $_getSZ(2);
  @$pb.TagNumber(3)
  set newProposedOrderId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNewProposedOrderId() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewProposedOrderId() => $_clearField(3);

  /// Fields that can be modified
  @$pb.TagNumber(4)
  $core.String get newQuantity => $_getSZ(3);
  @$pb.TagNumber(4)
  set newQuantity($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNewQuantity() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewQuantity() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get newPrice => $_getSZ(4);
  @$pb.TagNumber(5)
  set newPrice($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNewPrice() => $_has(4);
  @$pb.TagNumber(5)
  void clearNewPrice() => $_clearField(5);

  @$pb.TagNumber(6)
  $1.Time get newExpireTime => $_getN(5);
  @$pb.TagNumber(6)
  set newExpireTime($1.Time value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasNewExpireTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearNewExpireTime() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Time ensureNewExpireTime() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get reason => $_getSZ(6);
  @$pb.TagNumber(7)
  set reason($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasReason() => $_has(6);
  @$pb.TagNumber(7)
  void clearReason() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get metadata => $_getSZ(7);
  @$pb.TagNumber(8)
  set metadata($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMetadata() => $_has(7);
  @$pb.TagNumber(8)
  void clearMetadata() => $_clearField(8);
}

class ReplaceOrderResponse extends $pb.GeneratedMessage {
  factory ReplaceOrderResponse({
    $core.String? refRequestId,
    $core.String? originalProposedOrderId,
    $core.String? newProposedOrderId,
    $core.String? newOrderHash,
    $1.ConfirmationStatus? status,
    $core.String? message,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (originalProposedOrderId != null)
      result.originalProposedOrderId = originalProposedOrderId;
    if (newProposedOrderId != null)
      result.newProposedOrderId = newProposedOrderId;
    if (newOrderHash != null) result.newOrderHash = newOrderHash;
    if (status != null) result.status = status;
    if (message != null) result.message = message;
    return result;
  }

  ReplaceOrderResponse._();

  factory ReplaceOrderResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReplaceOrderResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReplaceOrderResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'originalProposedOrderId')
    ..aOS(3, _omitFieldNames ? '' : 'newProposedOrderId')
    ..aOS(4, _omitFieldNames ? '' : 'newOrderHash')
    ..e<$1.ConfirmationStatus>(
        5, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: $1.ConfirmationStatus.CONFIRMATION_STATUS__UNKNOWN,
        valueOf: $1.ConfirmationStatus.valueOf,
        enumValues: $1.ConfirmationStatus.values)
    ..aOS(6, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReplaceOrderResponse clone() =>
      ReplaceOrderResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReplaceOrderResponse copyWith(void Function(ReplaceOrderResponse) updates) =>
      super.copyWith((message) => updates(message as ReplaceOrderResponse))
          as ReplaceOrderResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReplaceOrderResponse create() => ReplaceOrderResponse._();
  @$core.override
  ReplaceOrderResponse createEmptyInstance() => create();
  static $pb.PbList<ReplaceOrderResponse> createRepeated() =>
      $pb.PbList<ReplaceOrderResponse>();
  @$core.pragma('dart2js:noInline')
  static ReplaceOrderResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReplaceOrderResponse>(create);
  static ReplaceOrderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get originalProposedOrderId => $_getSZ(1);
  @$pb.TagNumber(2)
  set originalProposedOrderId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOriginalProposedOrderId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOriginalProposedOrderId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get newProposedOrderId => $_getSZ(2);
  @$pb.TagNumber(3)
  set newProposedOrderId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNewProposedOrderId() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewProposedOrderId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get newOrderHash => $_getSZ(3);
  @$pb.TagNumber(4)
  set newOrderHash($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNewOrderHash() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewOrderHash() => $_clearField(4);

  @$pb.TagNumber(5)
  $1.ConfirmationStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status($1.ConfirmationStatus value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => $_clearField(6);
}

class CancelOrderRequest extends $pb.GeneratedMessage {
  factory CancelOrderRequest({
    $core.String? refRequestId,
    $core.String? proposedOrderId,
    $core.String? reason,
    $core.String? metadata,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (proposedOrderId != null) result.proposedOrderId = proposedOrderId;
    if (reason != null) result.reason = reason;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  CancelOrderRequest._();

  factory CancelOrderRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelOrderRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelOrderRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'proposedOrderId')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..aOS(4, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelOrderRequest clone() => CancelOrderRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelOrderRequest copyWith(void Function(CancelOrderRequest) updates) =>
      super.copyWith((message) => updates(message as CancelOrderRequest))
          as CancelOrderRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelOrderRequest create() => CancelOrderRequest._();
  @$core.override
  CancelOrderRequest createEmptyInstance() => create();
  static $pb.PbList<CancelOrderRequest> createRepeated() =>
      $pb.PbList<CancelOrderRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelOrderRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelOrderRequest>(create);
  static CancelOrderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get proposedOrderId => $_getSZ(1);
  @$pb.TagNumber(2)
  set proposedOrderId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProposedOrderId() => $_has(1);
  @$pb.TagNumber(2)
  void clearProposedOrderId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get metadata => $_getSZ(3);
  @$pb.TagNumber(4)
  set metadata($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMetadata() => $_has(3);
  @$pb.TagNumber(4)
  void clearMetadata() => $_clearField(4);
}

class CancelOrderResponse extends $pb.GeneratedMessage {
  factory CancelOrderResponse({
    $core.String? refRequestId,
    $core.String? cancelledProposedOrderId,
    $core.String? cancellationHash,
    $1.ConfirmationStatus? status,
    $1.Time? cancelledAt,
    $core.String? message,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (cancelledProposedOrderId != null)
      result.cancelledProposedOrderId = cancelledProposedOrderId;
    if (cancellationHash != null) result.cancellationHash = cancellationHash;
    if (status != null) result.status = status;
    if (cancelledAt != null) result.cancelledAt = cancelledAt;
    if (message != null) result.message = message;
    return result;
  }

  CancelOrderResponse._();

  factory CancelOrderResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelOrderResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelOrderResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'cancelledProposedOrderId')
    ..aOS(3, _omitFieldNames ? '' : 'cancellationHash')
    ..e<$1.ConfirmationStatus>(
        4, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: $1.ConfirmationStatus.CONFIRMATION_STATUS__UNKNOWN,
        valueOf: $1.ConfirmationStatus.valueOf,
        enumValues: $1.ConfirmationStatus.values)
    ..aOM<$1.Time>(5, _omitFieldNames ? '' : 'cancelledAt',
        subBuilder: $1.Time.create)
    ..aOS(6, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelOrderResponse clone() => CancelOrderResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelOrderResponse copyWith(void Function(CancelOrderResponse) updates) =>
      super.copyWith((message) => updates(message as CancelOrderResponse))
          as CancelOrderResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelOrderResponse create() => CancelOrderResponse._();
  @$core.override
  CancelOrderResponse createEmptyInstance() => create();
  static $pb.PbList<CancelOrderResponse> createRepeated() =>
      $pb.PbList<CancelOrderResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelOrderResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelOrderResponse>(create);
  static CancelOrderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get cancelledProposedOrderId => $_getSZ(1);
  @$pb.TagNumber(2)
  set cancelledProposedOrderId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCancelledProposedOrderId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCancelledProposedOrderId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get cancellationHash => $_getSZ(2);
  @$pb.TagNumber(3)
  set cancellationHash($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCancellationHash() => $_has(2);
  @$pb.TagNumber(3)
  void clearCancellationHash() => $_clearField(3);

  @$pb.TagNumber(4)
  $1.ConfirmationStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status($1.ConfirmationStatus value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $1.Time get cancelledAt => $_getN(4);
  @$pb.TagNumber(5)
  set cancelledAt($1.Time value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCancelledAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCancelledAt() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Time ensureCancelledAt() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => $_clearField(6);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
