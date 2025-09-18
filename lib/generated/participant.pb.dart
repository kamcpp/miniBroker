// This is a generated file - do not edit.
//
// Generated from participant.proto.

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

class GetParticipantInfoRequest extends $pb.GeneratedMessage {
  factory GetParticipantInfoRequest({
    $core.String? proposedExecutionId,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (auxData != null) result.auxData.addEntries(auxData);
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
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'GetParticipantInfoRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
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
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => $_clearField(1);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(1);
}

class GetParticipantInfoResponse extends $pb.GeneratedMessage {
  factory GetParticipantInfoResponse({
    $core.String? refExecutionId,
    $2.Participant? participant,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (participant != null) result.participant = participant;
    if (metadata != null) result.metadata.addEntries(metadata);
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
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$2.Participant>(2, _omitFieldNames ? '' : 'participant',
        subBuilder: $2.Participant.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'GetParticipantInfoResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
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
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $2.Participant get participant => $_getN(1);
  @$pb.TagNumber(2)
  set participant($2.Participant value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasParticipant() => $_has(1);
  @$pb.TagNumber(2)
  void clearParticipant() => $_clearField(2);
  @$pb.TagNumber(2)
  $2.Participant ensureParticipant() => $_ensure(1);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(2);
}

class GetParticipantOrdersRequest extends $pb.GeneratedMessage {
  factory GetParticipantOrdersRequest({
    $core.String? proposedExecutionId,
    $1.PaginationParams? pagination,
    $core.Iterable<$core.String>? accountIdOrNameRegexes,
    $core.Iterable<$core.String>? marketIdOrNameRegexes,
    $core.Iterable<$core.String>? venueIdOrSymbolRegexes,
    $core.Iterable<$core.String>? participantIdOrSymbolRegexes,
    $core.Iterable<$core.String>? instrumentIdOrSymbolRegexes,
    $1.DateTime? fromDt,
    $1.DateTime? toDt,
    $2.OrderSide? side,
    $core.Iterable<$core.bool>? statusFilters,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (pagination != null) result.pagination = pagination;
    if (accountIdOrNameRegexes != null)
      result.accountIdOrNameRegexes.addAll(accountIdOrNameRegexes);
    if (marketIdOrNameRegexes != null)
      result.marketIdOrNameRegexes.addAll(marketIdOrNameRegexes);
    if (venueIdOrSymbolRegexes != null)
      result.venueIdOrSymbolRegexes.addAll(venueIdOrSymbolRegexes);
    if (participantIdOrSymbolRegexes != null)
      result.participantIdOrSymbolRegexes.addAll(participantIdOrSymbolRegexes);
    if (instrumentIdOrSymbolRegexes != null)
      result.instrumentIdOrSymbolRegexes.addAll(instrumentIdOrSymbolRegexes);
    if (fromDt != null) result.fromDt = fromDt;
    if (toDt != null) result.toDt = toDt;
    if (side != null) result.side = side;
    if (statusFilters != null) result.statusFilters.addAll(statusFilters);
    if (auxData != null) result.auxData.addEntries(auxData);
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
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..pPS(3, _omitFieldNames ? '' : 'accountIdOrNameRegexes')
    ..pPS(4, _omitFieldNames ? '' : 'marketIdOrNameRegexes')
    ..pPS(5, _omitFieldNames ? '' : 'venueIdOrSymbolRegexes')
    ..pPS(6, _omitFieldNames ? '' : 'participantIdOrSymbolRegexes')
    ..pPS(7, _omitFieldNames ? '' : 'instrumentIdOrSymbolRegexes')
    ..aOM<$1.DateTime>(8, _omitFieldNames ? '' : 'fromDt',
        subBuilder: $1.DateTime.create)
    ..aOM<$1.DateTime>(9, _omitFieldNames ? '' : 'toDt',
        subBuilder: $1.DateTime.create)
    ..e<$2.OrderSide>(10, _omitFieldNames ? '' : 'side', $pb.PbFieldType.OE,
        defaultOrMaker: $2.OrderSide.ORDER_SIDE__UNKNOWN,
        valueOf: $2.OrderSide.valueOf,
        enumValues: $2.OrderSide.values)
    ..p<$core.bool>(
        11, _omitFieldNames ? '' : 'statusFilters', $pb.PbFieldType.KB)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'GetParticipantOrdersRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
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
  $pb.PbList<$core.String> get accountIdOrNameRegexes => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get marketIdOrNameRegexes => $_getList(3);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get venueIdOrSymbolRegexes => $_getList(4);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get participantIdOrSymbolRegexes => $_getList(5);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get instrumentIdOrSymbolRegexes => $_getList(6);

  @$pb.TagNumber(8)
  $1.DateTime get fromDt => $_getN(7);
  @$pb.TagNumber(8)
  set fromDt($1.DateTime value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasFromDt() => $_has(7);
  @$pb.TagNumber(8)
  void clearFromDt() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.DateTime ensureFromDt() => $_ensure(7);

  @$pb.TagNumber(9)
  $1.DateTime get toDt => $_getN(8);
  @$pb.TagNumber(9)
  set toDt($1.DateTime value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasToDt() => $_has(8);
  @$pb.TagNumber(9)
  void clearToDt() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.DateTime ensureToDt() => $_ensure(8);

  @$pb.TagNumber(10)
  $2.OrderSide get side => $_getN(9);
  @$pb.TagNumber(10)
  set side($2.OrderSide value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasSide() => $_has(9);
  @$pb.TagNumber(10)
  void clearSide() => $_clearField(10);

  @$pb.TagNumber(11)
  $pb.PbList<$core.bool> get statusFilters => $_getList(10);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(11);
}

class GetParticipantOrdersResponse extends $pb.GeneratedMessage {
  factory GetParticipantOrdersResponse({
    $core.String? refExecutionId,
    $1.PaginationInfo? paginationInfo,
    $1.DateTime? generatedAtDt,
    $core.Iterable<$2.Order>? orders,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>?
        accountSummaries,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (generatedAtDt != null) result.generatedAtDt = generatedAtDt;
    if (orders != null) result.orders.addAll(orders);
    if (accountSummaries != null)
      result.accountSummaries.addEntries(accountSummaries);
    if (metadata != null) result.metadata.addEntries(metadata);
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
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..aOM<$1.DateTime>(3, _omitFieldNames ? '' : 'generatedAtDt',
        subBuilder: $1.DateTime.create)
    ..pc<$2.Order>(4, _omitFieldNames ? '' : 'orders', $pb.PbFieldType.PM,
        subBuilder: $2.Order.create)
    ..m<$core.String, $core.String>(
        5, _omitFieldNames ? '' : 'accountSummaries',
        entryClassName: 'GetParticipantOrdersResponse.AccountSummariesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'GetParticipantOrdersResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
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
  $1.DateTime get generatedAtDt => $_getN(2);
  @$pb.TagNumber(3)
  set generatedAtDt($1.DateTime value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasGeneratedAtDt() => $_has(2);
  @$pb.TagNumber(3)
  void clearGeneratedAtDt() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.DateTime ensureGeneratedAtDt() => $_ensure(2);

  @$pb.TagNumber(4)
  $pb.PbList<$2.Order> get orders => $_getList(3);

  @$pb.TagNumber(5)
  $pb.PbMap<$core.String, $core.String> get accountSummaries => $_getMap(4);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(5);
}

class GetParticipantTradesRequest extends $pb.GeneratedMessage {
  factory GetParticipantTradesRequest({
    $core.String? proposedExecutionId,
    $1.PaginationParams? pagination,
    $core.Iterable<$core.String>? accountIdOrNameRegexes,
    $core.Iterable<$core.String>? marketIdOrNameRegexes,
    $core.Iterable<$core.String>? venueIdOrSymbolRegexes,
    $core.Iterable<$core.String>? participantIdOrSymbolRegexes,
    $core.Iterable<$core.String>? instrumentIdOrSymbolRegexes,
    $1.DateTime? fromDt,
    $1.DateTime? toDt,
    $2.OrderSide? side,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (pagination != null) result.pagination = pagination;
    if (accountIdOrNameRegexes != null)
      result.accountIdOrNameRegexes.addAll(accountIdOrNameRegexes);
    if (marketIdOrNameRegexes != null)
      result.marketIdOrNameRegexes.addAll(marketIdOrNameRegexes);
    if (venueIdOrSymbolRegexes != null)
      result.venueIdOrSymbolRegexes.addAll(venueIdOrSymbolRegexes);
    if (participantIdOrSymbolRegexes != null)
      result.participantIdOrSymbolRegexes.addAll(participantIdOrSymbolRegexes);
    if (instrumentIdOrSymbolRegexes != null)
      result.instrumentIdOrSymbolRegexes.addAll(instrumentIdOrSymbolRegexes);
    if (fromDt != null) result.fromDt = fromDt;
    if (toDt != null) result.toDt = toDt;
    if (side != null) result.side = side;
    if (auxData != null) result.auxData.addEntries(auxData);
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
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..pPS(3, _omitFieldNames ? '' : 'accountIdOrNameRegexes')
    ..pPS(4, _omitFieldNames ? '' : 'marketIdOrNameRegexes')
    ..pPS(5, _omitFieldNames ? '' : 'venueIdOrSymbolRegexes')
    ..pPS(6, _omitFieldNames ? '' : 'participantIdOrSymbolRegexes')
    ..pPS(7, _omitFieldNames ? '' : 'instrumentIdOrSymbolRegexes')
    ..aOM<$1.DateTime>(8, _omitFieldNames ? '' : 'fromDt',
        subBuilder: $1.DateTime.create)
    ..aOM<$1.DateTime>(9, _omitFieldNames ? '' : 'toDt',
        subBuilder: $1.DateTime.create)
    ..e<$2.OrderSide>(10, _omitFieldNames ? '' : 'side', $pb.PbFieldType.OE,
        defaultOrMaker: $2.OrderSide.ORDER_SIDE__UNKNOWN,
        valueOf: $2.OrderSide.valueOf,
        enumValues: $2.OrderSide.values)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'GetParticipantTradesRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
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
  $pb.PbList<$core.String> get accountIdOrNameRegexes => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get marketIdOrNameRegexes => $_getList(3);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get venueIdOrSymbolRegexes => $_getList(4);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get participantIdOrSymbolRegexes => $_getList(5);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get instrumentIdOrSymbolRegexes => $_getList(6);

  @$pb.TagNumber(8)
  $1.DateTime get fromDt => $_getN(7);
  @$pb.TagNumber(8)
  set fromDt($1.DateTime value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasFromDt() => $_has(7);
  @$pb.TagNumber(8)
  void clearFromDt() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.DateTime ensureFromDt() => $_ensure(7);

  @$pb.TagNumber(9)
  $1.DateTime get toDt => $_getN(8);
  @$pb.TagNumber(9)
  set toDt($1.DateTime value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasToDt() => $_has(8);
  @$pb.TagNumber(9)
  void clearToDt() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.DateTime ensureToDt() => $_ensure(8);

  @$pb.TagNumber(10)
  $2.OrderSide get side => $_getN(9);
  @$pb.TagNumber(10)
  set side($2.OrderSide value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasSide() => $_has(9);
  @$pb.TagNumber(10)
  void clearSide() => $_clearField(10);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(10);
}

class GetParticipantTradesResponse extends $pb.GeneratedMessage {
  factory GetParticipantTradesResponse({
    $core.String? refExecutionId,
    $1.PaginationInfo? paginationInfo,
    $1.DateTime? generatedAtDt,
    $core.Iterable<$2.Trade>? trades,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>?
        accountSummaries,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (generatedAtDt != null) result.generatedAtDt = generatedAtDt;
    if (trades != null) result.trades.addAll(trades);
    if (accountSummaries != null)
      result.accountSummaries.addEntries(accountSummaries);
    if (metadata != null) result.metadata.addEntries(metadata);
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
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..aOM<$1.DateTime>(3, _omitFieldNames ? '' : 'generatedAtDt',
        subBuilder: $1.DateTime.create)
    ..pc<$2.Trade>(4, _omitFieldNames ? '' : 'trades', $pb.PbFieldType.PM,
        subBuilder: $2.Trade.create)
    ..m<$core.String, $core.String>(
        5, _omitFieldNames ? '' : 'accountSummaries',
        entryClassName: 'GetParticipantTradesResponse.AccountSummariesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'GetParticipantTradesResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
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
  $1.DateTime get generatedAtDt => $_getN(2);
  @$pb.TagNumber(3)
  set generatedAtDt($1.DateTime value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasGeneratedAtDt() => $_has(2);
  @$pb.TagNumber(3)
  void clearGeneratedAtDt() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.DateTime ensureGeneratedAtDt() => $_ensure(2);

  @$pb.TagNumber(4)
  $pb.PbList<$2.Trade> get trades => $_getList(3);

  @$pb.TagNumber(5)
  $pb.PbMap<$core.String, $core.String> get accountSummaries => $_getMap(4);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(5);
}

class GetParticipantSettlementsRequest extends $pb.GeneratedMessage {
  factory GetParticipantSettlementsRequest({
    $core.String? proposedExecutionId,
    $1.PaginationParams? pagination,
    $core.Iterable<$core.String>? accountIdOrNameRegexes,
    $core.Iterable<$core.String>? marketIdOrNameRegexes,
    $core.Iterable<$core.String>? venueIdOrSymbolRegexes,
    $core.Iterable<$core.String>? participantIdOrSymbolRegexes,
    $core.Iterable<$core.String>? instrumentIdOrSymbolRegexes,
    $1.DateTime? fromDt,
    $1.DateTime? toDt,
    $2.ConfirmationStatus? status,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (pagination != null) result.pagination = pagination;
    if (accountIdOrNameRegexes != null)
      result.accountIdOrNameRegexes.addAll(accountIdOrNameRegexes);
    if (marketIdOrNameRegexes != null)
      result.marketIdOrNameRegexes.addAll(marketIdOrNameRegexes);
    if (venueIdOrSymbolRegexes != null)
      result.venueIdOrSymbolRegexes.addAll(venueIdOrSymbolRegexes);
    if (participantIdOrSymbolRegexes != null)
      result.participantIdOrSymbolRegexes.addAll(participantIdOrSymbolRegexes);
    if (instrumentIdOrSymbolRegexes != null)
      result.instrumentIdOrSymbolRegexes.addAll(instrumentIdOrSymbolRegexes);
    if (fromDt != null) result.fromDt = fromDt;
    if (toDt != null) result.toDt = toDt;
    if (status != null) result.status = status;
    if (auxData != null) result.auxData.addEntries(auxData);
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
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..pPS(3, _omitFieldNames ? '' : 'accountIdOrNameRegexes')
    ..pPS(4, _omitFieldNames ? '' : 'marketIdOrNameRegexes')
    ..pPS(5, _omitFieldNames ? '' : 'venueIdOrSymbolRegexes')
    ..pPS(6, _omitFieldNames ? '' : 'participantIdOrSymbolRegexes')
    ..pPS(7, _omitFieldNames ? '' : 'instrumentIdOrSymbolRegexes')
    ..aOM<$1.DateTime>(8, _omitFieldNames ? '' : 'fromDt',
        subBuilder: $1.DateTime.create)
    ..aOM<$1.DateTime>(9, _omitFieldNames ? '' : 'toDt',
        subBuilder: $1.DateTime.create)
    ..e<$2.ConfirmationStatus>(
        10, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: $2.ConfirmationStatus.CONFIRMATION_STATUS__UNKNOWN,
        valueOf: $2.ConfirmationStatus.valueOf,
        enumValues: $2.ConfirmationStatus.values)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'GetParticipantSettlementsRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
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
  $pb.PbList<$core.String> get accountIdOrNameRegexes => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get marketIdOrNameRegexes => $_getList(3);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get venueIdOrSymbolRegexes => $_getList(4);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get participantIdOrSymbolRegexes => $_getList(5);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get instrumentIdOrSymbolRegexes => $_getList(6);

  @$pb.TagNumber(8)
  $1.DateTime get fromDt => $_getN(7);
  @$pb.TagNumber(8)
  set fromDt($1.DateTime value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasFromDt() => $_has(7);
  @$pb.TagNumber(8)
  void clearFromDt() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.DateTime ensureFromDt() => $_ensure(7);

  @$pb.TagNumber(9)
  $1.DateTime get toDt => $_getN(8);
  @$pb.TagNumber(9)
  set toDt($1.DateTime value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasToDt() => $_has(8);
  @$pb.TagNumber(9)
  void clearToDt() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.DateTime ensureToDt() => $_ensure(8);

  @$pb.TagNumber(10)
  $2.ConfirmationStatus get status => $_getN(9);
  @$pb.TagNumber(10)
  set status($2.ConfirmationStatus value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => $_clearField(10);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(10);
}

class GetParticipantSettlementsResponse extends $pb.GeneratedMessage {
  factory GetParticipantSettlementsResponse({
    $core.String? refExecutionId,
    $1.PaginationInfo? paginationInfo,
    $1.DateTime? generatedAtDt,
    $core.Iterable<$2.Settlement>? settlements,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>?
        accountSummaries,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (generatedAtDt != null) result.generatedAtDt = generatedAtDt;
    if (settlements != null) result.settlements.addAll(settlements);
    if (accountSummaries != null)
      result.accountSummaries.addEntries(accountSummaries);
    if (metadata != null) result.metadata.addEntries(metadata);
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
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..aOM<$1.DateTime>(3, _omitFieldNames ? '' : 'generatedAtDt',
        subBuilder: $1.DateTime.create)
    ..pc<$2.Settlement>(
        4, _omitFieldNames ? '' : 'settlements', $pb.PbFieldType.PM,
        subBuilder: $2.Settlement.create)
    ..m<$core.String, $core.String>(
        5, _omitFieldNames ? '' : 'accountSummaries',
        entryClassName:
            'GetParticipantSettlementsResponse.AccountSummariesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'GetParticipantSettlementsResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
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
  $1.DateTime get generatedAtDt => $_getN(2);
  @$pb.TagNumber(3)
  set generatedAtDt($1.DateTime value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasGeneratedAtDt() => $_has(2);
  @$pb.TagNumber(3)
  void clearGeneratedAtDt() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.DateTime ensureGeneratedAtDt() => $_ensure(2);

  @$pb.TagNumber(4)
  $pb.PbList<$2.Settlement> get settlements => $_getList(3);

  @$pb.TagNumber(5)
  $pb.PbMap<$core.String, $core.String> get accountSummaries => $_getMap(4);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(5);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
