// This is a generated file - do not edit.
//
// Generated from event.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'account.pb.dart' as $1;
import 'common.pb.dart' as $0;
import 'event.pbenum.dart';
import 'instrument.pb.dart' as $2;
import 'market.pb.dart' as $3;
import 'participant.pb.dart' as $6;
import 'trading.pb.dart' as $5;
import 'venue.pb.dart' as $4;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'event.pbenum.dart';

class EventSubscriptionParams extends $pb.GeneratedMessage {
  factory EventSubscriptionParams({
    $core.String? proposedSubscriptionId,
    $core.Iterable<$core.String>? topics,
    $core.Iterable<EventTypeEnum>? subscribedEventTypes,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedSubscriptionId != null)
      result.proposedSubscriptionId = proposedSubscriptionId;
    if (topics != null) result.topics.addAll(topics);
    if (subscribedEventTypes != null)
      result.subscribedEventTypes.addAll(subscribedEventTypes);
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  EventSubscriptionParams._();

  factory EventSubscriptionParams.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventSubscriptionParams.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventSubscriptionParams',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedSubscriptionId')
    ..pPS(2, _omitFieldNames ? '' : 'topics')
    ..pc<EventTypeEnum>(
        3, _omitFieldNames ? '' : 'subscribedEventTypes', $pb.PbFieldType.KE,
        valueOf: EventTypeEnum.valueOf,
        enumValues: EventTypeEnum.values,
        defaultEnumValue: EventTypeEnum.EVENT_TYPE_ENUM__UNKNOWN)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'EventSubscriptionParams.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventSubscriptionParams clone() =>
      EventSubscriptionParams()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventSubscriptionParams copyWith(
          void Function(EventSubscriptionParams) updates) =>
      super.copyWith((message) => updates(message as EventSubscriptionParams))
          as EventSubscriptionParams;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventSubscriptionParams create() => EventSubscriptionParams._();
  @$core.override
  EventSubscriptionParams createEmptyInstance() => create();
  static $pb.PbList<EventSubscriptionParams> createRepeated() =>
      $pb.PbList<EventSubscriptionParams>();
  @$core.pragma('dart2js:noInline')
  static EventSubscriptionParams getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventSubscriptionParams>(create);
  static EventSubscriptionParams? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedSubscriptionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedSubscriptionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProposedSubscriptionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedSubscriptionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get topics => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<EventTypeEnum> get subscribedEventTypes => $_getList(2);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(3);
}

class BlobEvent extends $pb.GeneratedMessage {
  factory BlobEvent({
    $0.Blob? data,
  }) {
    final result = create();
    if (data != null) result.data = data;
    return result;
  }

  BlobEvent._();

  factory BlobEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BlobEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BlobEvent',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOM<$0.Blob>(1, _omitFieldNames ? '' : 'data', subBuilder: $0.Blob.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BlobEvent clone() => BlobEvent()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BlobEvent copyWith(void Function(BlobEvent) updates) =>
      super.copyWith((message) => updates(message as BlobEvent)) as BlobEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BlobEvent create() => BlobEvent._();
  @$core.override
  BlobEvent createEmptyInstance() => create();
  static $pb.PbList<BlobEvent> createRepeated() => $pb.PbList<BlobEvent>();
  @$core.pragma('dart2js:noInline')
  static BlobEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlobEvent>(create);
  static BlobEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $0.Blob get data => $_getN(0);
  @$pb.TagNumber(1)
  set data($0.Blob value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Blob ensureData() => $_ensure(0);
}

class ExecutionUpdateEvent extends $pb.GeneratedMessage {
  factory ExecutionUpdateEvent({
    $core.String? refExecutionId,
    ExecutionUpdateEventTypeEnum? eventType,
    $core.String? flowInstanceId,
    $core.String? flowExecutionId,
    $core.String? totalNrOfSteps,
    $core.String? currentStepNr,
    $core.String? stepDescription,
    $core.String? progressPercentage,
    $core.String? msg,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? labels,
    $core.Iterable<$core.String>? tags,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (eventType != null) result.eventType = eventType;
    if (flowInstanceId != null) result.flowInstanceId = flowInstanceId;
    if (flowExecutionId != null) result.flowExecutionId = flowExecutionId;
    if (totalNrOfSteps != null) result.totalNrOfSteps = totalNrOfSteps;
    if (currentStepNr != null) result.currentStepNr = currentStepNr;
    if (stepDescription != null) result.stepDescription = stepDescription;
    if (progressPercentage != null)
      result.progressPercentage = progressPercentage;
    if (msg != null) result.msg = msg;
    if (labels != null) result.labels.addEntries(labels);
    if (tags != null) result.tags.addAll(tags);
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  ExecutionUpdateEvent._();

  factory ExecutionUpdateEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExecutionUpdateEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExecutionUpdateEvent',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..e<ExecutionUpdateEventTypeEnum>(
        2, _omitFieldNames ? '' : 'eventType', $pb.PbFieldType.OE,
        defaultOrMaker: ExecutionUpdateEventTypeEnum
            .EXECUTION_UPDATE_EVENT_TYPE_ENUM__UNKNOWN,
        valueOf: ExecutionUpdateEventTypeEnum.valueOf,
        enumValues: ExecutionUpdateEventTypeEnum.values)
    ..aOS(3, _omitFieldNames ? '' : 'flowInstanceId')
    ..aOS(4, _omitFieldNames ? '' : 'flowExecutionId')
    ..aOS(5, _omitFieldNames ? '' : 'totalNrOfSteps')
    ..aOS(6, _omitFieldNames ? '' : 'currentStepNr')
    ..aOS(7, _omitFieldNames ? '' : 'stepDescription')
    ..aOS(8, _omitFieldNames ? '' : 'progressPercentage')
    ..aOS(9, _omitFieldNames ? '' : 'msg')
    ..m<$core.String, $core.String>(103, _omitFieldNames ? '' : 'labels',
        entryClassName: 'ExecutionUpdateEvent.LabelsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..pPS(104, _omitFieldNames ? '' : 'tags')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'ExecutionUpdateEvent.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExecutionUpdateEvent clone() =>
      ExecutionUpdateEvent()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExecutionUpdateEvent copyWith(void Function(ExecutionUpdateEvent) updates) =>
      super.copyWith((message) => updates(message as ExecutionUpdateEvent))
          as ExecutionUpdateEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExecutionUpdateEvent create() => ExecutionUpdateEvent._();
  @$core.override
  ExecutionUpdateEvent createEmptyInstance() => create();
  static $pb.PbList<ExecutionUpdateEvent> createRepeated() =>
      $pb.PbList<ExecutionUpdateEvent>();
  @$core.pragma('dart2js:noInline')
  static ExecutionUpdateEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExecutionUpdateEvent>(create);
  static ExecutionUpdateEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  ExecutionUpdateEventTypeEnum get eventType => $_getN(1);
  @$pb.TagNumber(2)
  set eventType(ExecutionUpdateEventTypeEnum value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEventType() => $_has(1);
  @$pb.TagNumber(2)
  void clearEventType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get flowInstanceId => $_getSZ(2);
  @$pb.TagNumber(3)
  set flowInstanceId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFlowInstanceId() => $_has(2);
  @$pb.TagNumber(3)
  void clearFlowInstanceId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get flowExecutionId => $_getSZ(3);
  @$pb.TagNumber(4)
  set flowExecutionId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFlowExecutionId() => $_has(3);
  @$pb.TagNumber(4)
  void clearFlowExecutionId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get totalNrOfSteps => $_getSZ(4);
  @$pb.TagNumber(5)
  set totalNrOfSteps($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalNrOfSteps() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalNrOfSteps() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get currentStepNr => $_getSZ(5);
  @$pb.TagNumber(6)
  set currentStepNr($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCurrentStepNr() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrentStepNr() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get stepDescription => $_getSZ(6);
  @$pb.TagNumber(7)
  set stepDescription($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasStepDescription() => $_has(6);
  @$pb.TagNumber(7)
  void clearStepDescription() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get progressPercentage => $_getSZ(7);
  @$pb.TagNumber(8)
  set progressPercentage($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasProgressPercentage() => $_has(7);
  @$pb.TagNumber(8)
  void clearProgressPercentage() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get msg => $_getSZ(8);
  @$pb.TagNumber(9)
  set msg($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasMsg() => $_has(8);
  @$pb.TagNumber(9)
  void clearMsg() => $_clearField(9);

  @$pb.TagNumber(103)
  $pb.PbMap<$core.String, $core.String> get labels => $_getMap(9);

  @$pb.TagNumber(104)
  $pb.PbList<$core.String> get tags => $_getList(10);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(11);
}

enum ExecutionResponseEvent_Response {
  getAccountList,
  getAccountInfoBatch,
  getAccountInstrumentHoldings,
  getAccountCashHoldings,
  getAccountOrders,
  getAccountTrades,
  getAccountSettlements,
  getAccountTransactions,
  getInstrumentList,
  getInstrumentInfoBatch,
  getInstrumentOrders,
  getInstrumentTrades,
  getInstrumentSettlements,
  getMarketList,
  getMarketCalendar,
  getVenueList,
  getVenueCalendar,
  getOrderFees,
  getParticipantInfo,
  getParticipantOrders,
  getParticipantTrades,
  getParticipantSettlements,
  notSet
}

class ExecutionResponseEvent extends $pb.GeneratedMessage {
  factory ExecutionResponseEvent({
    $core.String? refExecutionId,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? labels,
    $core.Iterable<$core.String>? tags,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
    $1.GetAccountListResponse? getAccountList,
    $1.GetAccountInfoBatchResponse? getAccountInfoBatch,
    $1.GetAccountInstrumentHoldingsResponse? getAccountInstrumentHoldings,
    $1.GetAccountCashHoldingsResponse? getAccountCashHoldings,
    $1.GetAccountOrdersResponse? getAccountOrders,
    $1.GetAccountTradesResponse? getAccountTrades,
    $1.GetAccountSettlementsResponse? getAccountSettlements,
    $1.GetAccountTransactionsResponse? getAccountTransactions,
    $2.GetInstrumentListResponse? getInstrumentList,
    $2.GetInstrumentInfoBatchResponse? getInstrumentInfoBatch,
    $2.GetInstrumentOrdersResponse? getInstrumentOrders,
    $2.GetInstrumentTradesResponse? getInstrumentTrades,
    $2.GetInstrumentSettlementsResponse? getInstrumentSettlements,
    $3.GetMarketListResponse? getMarketList,
    $3.GetMarketCalendarResponse? getMarketCalendar,
    $4.GetVenueListResponse? getVenueList,
    $4.GetVenueCalendarResponse? getVenueCalendar,
    $5.GetOrderFeesResponse? getOrderFees,
    $6.GetParticipantInfoResponse? getParticipantInfo,
    $6.GetParticipantOrdersResponse? getParticipantOrders,
    $6.GetParticipantTradesResponse? getParticipantTrades,
    $6.GetParticipantSettlementsResponse? getParticipantSettlements,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (labels != null) result.labels.addEntries(labels);
    if (tags != null) result.tags.addAll(tags);
    if (metadata != null) result.metadata.addEntries(metadata);
    if (getAccountList != null) result.getAccountList = getAccountList;
    if (getAccountInfoBatch != null)
      result.getAccountInfoBatch = getAccountInfoBatch;
    if (getAccountInstrumentHoldings != null)
      result.getAccountInstrumentHoldings = getAccountInstrumentHoldings;
    if (getAccountCashHoldings != null)
      result.getAccountCashHoldings = getAccountCashHoldings;
    if (getAccountOrders != null) result.getAccountOrders = getAccountOrders;
    if (getAccountTrades != null) result.getAccountTrades = getAccountTrades;
    if (getAccountSettlements != null)
      result.getAccountSettlements = getAccountSettlements;
    if (getAccountTransactions != null)
      result.getAccountTransactions = getAccountTransactions;
    if (getInstrumentList != null) result.getInstrumentList = getInstrumentList;
    if (getInstrumentInfoBatch != null)
      result.getInstrumentInfoBatch = getInstrumentInfoBatch;
    if (getInstrumentOrders != null)
      result.getInstrumentOrders = getInstrumentOrders;
    if (getInstrumentTrades != null)
      result.getInstrumentTrades = getInstrumentTrades;
    if (getInstrumentSettlements != null)
      result.getInstrumentSettlements = getInstrumentSettlements;
    if (getMarketList != null) result.getMarketList = getMarketList;
    if (getMarketCalendar != null) result.getMarketCalendar = getMarketCalendar;
    if (getVenueList != null) result.getVenueList = getVenueList;
    if (getVenueCalendar != null) result.getVenueCalendar = getVenueCalendar;
    if (getOrderFees != null) result.getOrderFees = getOrderFees;
    if (getParticipantInfo != null)
      result.getParticipantInfo = getParticipantInfo;
    if (getParticipantOrders != null)
      result.getParticipantOrders = getParticipantOrders;
    if (getParticipantTrades != null)
      result.getParticipantTrades = getParticipantTrades;
    if (getParticipantSettlements != null)
      result.getParticipantSettlements = getParticipantSettlements;
    return result;
  }

  ExecutionResponseEvent._();

  factory ExecutionResponseEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExecutionResponseEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, ExecutionResponseEvent_Response>
      _ExecutionResponseEvent_ResponseByTag = {
    201: ExecutionResponseEvent_Response.getAccountList,
    202: ExecutionResponseEvent_Response.getAccountInfoBatch,
    203: ExecutionResponseEvent_Response.getAccountInstrumentHoldings,
    204: ExecutionResponseEvent_Response.getAccountCashHoldings,
    205: ExecutionResponseEvent_Response.getAccountOrders,
    206: ExecutionResponseEvent_Response.getAccountTrades,
    207: ExecutionResponseEvent_Response.getAccountSettlements,
    208: ExecutionResponseEvent_Response.getAccountTransactions,
    301: ExecutionResponseEvent_Response.getInstrumentList,
    302: ExecutionResponseEvent_Response.getInstrumentInfoBatch,
    303: ExecutionResponseEvent_Response.getInstrumentOrders,
    304: ExecutionResponseEvent_Response.getInstrumentTrades,
    305: ExecutionResponseEvent_Response.getInstrumentSettlements,
    401: ExecutionResponseEvent_Response.getMarketList,
    402: ExecutionResponseEvent_Response.getMarketCalendar,
    501: ExecutionResponseEvent_Response.getVenueList,
    503: ExecutionResponseEvent_Response.getVenueCalendar,
    601: ExecutionResponseEvent_Response.getOrderFees,
    701: ExecutionResponseEvent_Response.getParticipantInfo,
    702: ExecutionResponseEvent_Response.getParticipantOrders,
    703: ExecutionResponseEvent_Response.getParticipantTrades,
    704: ExecutionResponseEvent_Response.getParticipantSettlements,
    0: ExecutionResponseEvent_Response.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExecutionResponseEvent',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..oo(0, [
      201,
      202,
      203,
      204,
      205,
      206,
      207,
      208,
      301,
      302,
      303,
      304,
      305,
      401,
      402,
      501,
      503,
      601,
      701,
      702,
      703,
      704
    ])
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..m<$core.String, $core.String>(103, _omitFieldNames ? '' : 'labels',
        entryClassName: 'ExecutionResponseEvent.LabelsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..pPS(104, _omitFieldNames ? '' : 'tags')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'ExecutionResponseEvent.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..aOM<$1.GetAccountListResponse>(
        201, _omitFieldNames ? '' : 'getAccountList',
        subBuilder: $1.GetAccountListResponse.create)
    ..aOM<$1.GetAccountInfoBatchResponse>(
        202, _omitFieldNames ? '' : 'getAccountInfoBatch',
        subBuilder: $1.GetAccountInfoBatchResponse.create)
    ..aOM<$1.GetAccountInstrumentHoldingsResponse>(
        203, _omitFieldNames ? '' : 'getAccountInstrumentHoldings',
        subBuilder: $1.GetAccountInstrumentHoldingsResponse.create)
    ..aOM<$1.GetAccountCashHoldingsResponse>(
        204, _omitFieldNames ? '' : 'getAccountCashHoldings',
        subBuilder: $1.GetAccountCashHoldingsResponse.create)
    ..aOM<$1.GetAccountOrdersResponse>(
        205, _omitFieldNames ? '' : 'getAccountOrders',
        subBuilder: $1.GetAccountOrdersResponse.create)
    ..aOM<$1.GetAccountTradesResponse>(
        206, _omitFieldNames ? '' : 'getAccountTrades',
        subBuilder: $1.GetAccountTradesResponse.create)
    ..aOM<$1.GetAccountSettlementsResponse>(
        207, _omitFieldNames ? '' : 'getAccountSettlements',
        subBuilder: $1.GetAccountSettlementsResponse.create)
    ..aOM<$1.GetAccountTransactionsResponse>(
        208, _omitFieldNames ? '' : 'getAccountTransactions',
        subBuilder: $1.GetAccountTransactionsResponse.create)
    ..aOM<$2.GetInstrumentListResponse>(
        301, _omitFieldNames ? '' : 'getInstrumentList',
        subBuilder: $2.GetInstrumentListResponse.create)
    ..aOM<$2.GetInstrumentInfoBatchResponse>(
        302, _omitFieldNames ? '' : 'getInstrumentInfoBatch',
        subBuilder: $2.GetInstrumentInfoBatchResponse.create)
    ..aOM<$2.GetInstrumentOrdersResponse>(
        303, _omitFieldNames ? '' : 'getInstrumentOrders',
        subBuilder: $2.GetInstrumentOrdersResponse.create)
    ..aOM<$2.GetInstrumentTradesResponse>(
        304, _omitFieldNames ? '' : 'getInstrumentTrades',
        subBuilder: $2.GetInstrumentTradesResponse.create)
    ..aOM<$2.GetInstrumentSettlementsResponse>(
        305, _omitFieldNames ? '' : 'getInstrumentSettlements',
        subBuilder: $2.GetInstrumentSettlementsResponse.create)
    ..aOM<$3.GetMarketListResponse>(401, _omitFieldNames ? '' : 'getMarketList',
        subBuilder: $3.GetMarketListResponse.create)
    ..aOM<$3.GetMarketCalendarResponse>(
        402, _omitFieldNames ? '' : 'getMarketCalendar',
        subBuilder: $3.GetMarketCalendarResponse.create)
    ..aOM<$4.GetVenueListResponse>(501, _omitFieldNames ? '' : 'getVenueList',
        subBuilder: $4.GetVenueListResponse.create)
    ..aOM<$4.GetVenueCalendarResponse>(
        503, _omitFieldNames ? '' : 'getVenueCalendar',
        subBuilder: $4.GetVenueCalendarResponse.create)
    ..aOM<$5.GetOrderFeesResponse>(601, _omitFieldNames ? '' : 'getOrderFees',
        subBuilder: $5.GetOrderFeesResponse.create)
    ..aOM<$6.GetParticipantInfoResponse>(
        701, _omitFieldNames ? '' : 'getParticipantInfo',
        subBuilder: $6.GetParticipantInfoResponse.create)
    ..aOM<$6.GetParticipantOrdersResponse>(
        702, _omitFieldNames ? '' : 'getParticipantOrders',
        subBuilder: $6.GetParticipantOrdersResponse.create)
    ..aOM<$6.GetParticipantTradesResponse>(
        703, _omitFieldNames ? '' : 'getParticipantTrades',
        subBuilder: $6.GetParticipantTradesResponse.create)
    ..aOM<$6.GetParticipantSettlementsResponse>(
        704, _omitFieldNames ? '' : 'getParticipantSettlements',
        subBuilder: $6.GetParticipantSettlementsResponse.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExecutionResponseEvent clone() =>
      ExecutionResponseEvent()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExecutionResponseEvent copyWith(
          void Function(ExecutionResponseEvent) updates) =>
      super.copyWith((message) => updates(message as ExecutionResponseEvent))
          as ExecutionResponseEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExecutionResponseEvent create() => ExecutionResponseEvent._();
  @$core.override
  ExecutionResponseEvent createEmptyInstance() => create();
  static $pb.PbList<ExecutionResponseEvent> createRepeated() =>
      $pb.PbList<ExecutionResponseEvent>();
  @$core.pragma('dart2js:noInline')
  static ExecutionResponseEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExecutionResponseEvent>(create);
  static ExecutionResponseEvent? _defaultInstance;

  ExecutionResponseEvent_Response whichResponse() =>
      _ExecutionResponseEvent_ResponseByTag[$_whichOneof(0)]!;
  void clearResponse() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => $_clearField(1);

  @$pb.TagNumber(103)
  $pb.PbMap<$core.String, $core.String> get labels => $_getMap(1);

  @$pb.TagNumber(104)
  $pb.PbList<$core.String> get tags => $_getList(2);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(3);

  /// account responses
  @$pb.TagNumber(201)
  $1.GetAccountListResponse get getAccountList => $_getN(4);
  @$pb.TagNumber(201)
  set getAccountList($1.GetAccountListResponse value) => $_setField(201, value);
  @$pb.TagNumber(201)
  $core.bool hasGetAccountList() => $_has(4);
  @$pb.TagNumber(201)
  void clearGetAccountList() => $_clearField(201);
  @$pb.TagNumber(201)
  $1.GetAccountListResponse ensureGetAccountList() => $_ensure(4);

  @$pb.TagNumber(202)
  $1.GetAccountInfoBatchResponse get getAccountInfoBatch => $_getN(5);
  @$pb.TagNumber(202)
  set getAccountInfoBatch($1.GetAccountInfoBatchResponse value) =>
      $_setField(202, value);
  @$pb.TagNumber(202)
  $core.bool hasGetAccountInfoBatch() => $_has(5);
  @$pb.TagNumber(202)
  void clearGetAccountInfoBatch() => $_clearField(202);
  @$pb.TagNumber(202)
  $1.GetAccountInfoBatchResponse ensureGetAccountInfoBatch() => $_ensure(5);

  @$pb.TagNumber(203)
  $1.GetAccountInstrumentHoldingsResponse get getAccountInstrumentHoldings =>
      $_getN(6);
  @$pb.TagNumber(203)
  set getAccountInstrumentHoldings(
          $1.GetAccountInstrumentHoldingsResponse value) =>
      $_setField(203, value);
  @$pb.TagNumber(203)
  $core.bool hasGetAccountInstrumentHoldings() => $_has(6);
  @$pb.TagNumber(203)
  void clearGetAccountInstrumentHoldings() => $_clearField(203);
  @$pb.TagNumber(203)
  $1.GetAccountInstrumentHoldingsResponse
      ensureGetAccountInstrumentHoldings() => $_ensure(6);

  @$pb.TagNumber(204)
  $1.GetAccountCashHoldingsResponse get getAccountCashHoldings => $_getN(7);
  @$pb.TagNumber(204)
  set getAccountCashHoldings($1.GetAccountCashHoldingsResponse value) =>
      $_setField(204, value);
  @$pb.TagNumber(204)
  $core.bool hasGetAccountCashHoldings() => $_has(7);
  @$pb.TagNumber(204)
  void clearGetAccountCashHoldings() => $_clearField(204);
  @$pb.TagNumber(204)
  $1.GetAccountCashHoldingsResponse ensureGetAccountCashHoldings() =>
      $_ensure(7);

  @$pb.TagNumber(205)
  $1.GetAccountOrdersResponse get getAccountOrders => $_getN(8);
  @$pb.TagNumber(205)
  set getAccountOrders($1.GetAccountOrdersResponse value) =>
      $_setField(205, value);
  @$pb.TagNumber(205)
  $core.bool hasGetAccountOrders() => $_has(8);
  @$pb.TagNumber(205)
  void clearGetAccountOrders() => $_clearField(205);
  @$pb.TagNumber(205)
  $1.GetAccountOrdersResponse ensureGetAccountOrders() => $_ensure(8);

  @$pb.TagNumber(206)
  $1.GetAccountTradesResponse get getAccountTrades => $_getN(9);
  @$pb.TagNumber(206)
  set getAccountTrades($1.GetAccountTradesResponse value) =>
      $_setField(206, value);
  @$pb.TagNumber(206)
  $core.bool hasGetAccountTrades() => $_has(9);
  @$pb.TagNumber(206)
  void clearGetAccountTrades() => $_clearField(206);
  @$pb.TagNumber(206)
  $1.GetAccountTradesResponse ensureGetAccountTrades() => $_ensure(9);

  @$pb.TagNumber(207)
  $1.GetAccountSettlementsResponse get getAccountSettlements => $_getN(10);
  @$pb.TagNumber(207)
  set getAccountSettlements($1.GetAccountSettlementsResponse value) =>
      $_setField(207, value);
  @$pb.TagNumber(207)
  $core.bool hasGetAccountSettlements() => $_has(10);
  @$pb.TagNumber(207)
  void clearGetAccountSettlements() => $_clearField(207);
  @$pb.TagNumber(207)
  $1.GetAccountSettlementsResponse ensureGetAccountSettlements() =>
      $_ensure(10);

  @$pb.TagNumber(208)
  $1.GetAccountTransactionsResponse get getAccountTransactions => $_getN(11);
  @$pb.TagNumber(208)
  set getAccountTransactions($1.GetAccountTransactionsResponse value) =>
      $_setField(208, value);
  @$pb.TagNumber(208)
  $core.bool hasGetAccountTransactions() => $_has(11);
  @$pb.TagNumber(208)
  void clearGetAccountTransactions() => $_clearField(208);
  @$pb.TagNumber(208)
  $1.GetAccountTransactionsResponse ensureGetAccountTransactions() =>
      $_ensure(11);

  /// instrument responses
  @$pb.TagNumber(301)
  $2.GetInstrumentListResponse get getInstrumentList => $_getN(12);
  @$pb.TagNumber(301)
  set getInstrumentList($2.GetInstrumentListResponse value) =>
      $_setField(301, value);
  @$pb.TagNumber(301)
  $core.bool hasGetInstrumentList() => $_has(12);
  @$pb.TagNumber(301)
  void clearGetInstrumentList() => $_clearField(301);
  @$pb.TagNumber(301)
  $2.GetInstrumentListResponse ensureGetInstrumentList() => $_ensure(12);

  @$pb.TagNumber(302)
  $2.GetInstrumentInfoBatchResponse get getInstrumentInfoBatch => $_getN(13);
  @$pb.TagNumber(302)
  set getInstrumentInfoBatch($2.GetInstrumentInfoBatchResponse value) =>
      $_setField(302, value);
  @$pb.TagNumber(302)
  $core.bool hasGetInstrumentInfoBatch() => $_has(13);
  @$pb.TagNumber(302)
  void clearGetInstrumentInfoBatch() => $_clearField(302);
  @$pb.TagNumber(302)
  $2.GetInstrumentInfoBatchResponse ensureGetInstrumentInfoBatch() =>
      $_ensure(13);

  @$pb.TagNumber(303)
  $2.GetInstrumentOrdersResponse get getInstrumentOrders => $_getN(14);
  @$pb.TagNumber(303)
  set getInstrumentOrders($2.GetInstrumentOrdersResponse value) =>
      $_setField(303, value);
  @$pb.TagNumber(303)
  $core.bool hasGetInstrumentOrders() => $_has(14);
  @$pb.TagNumber(303)
  void clearGetInstrumentOrders() => $_clearField(303);
  @$pb.TagNumber(303)
  $2.GetInstrumentOrdersResponse ensureGetInstrumentOrders() => $_ensure(14);

  @$pb.TagNumber(304)
  $2.GetInstrumentTradesResponse get getInstrumentTrades => $_getN(15);
  @$pb.TagNumber(304)
  set getInstrumentTrades($2.GetInstrumentTradesResponse value) =>
      $_setField(304, value);
  @$pb.TagNumber(304)
  $core.bool hasGetInstrumentTrades() => $_has(15);
  @$pb.TagNumber(304)
  void clearGetInstrumentTrades() => $_clearField(304);
  @$pb.TagNumber(304)
  $2.GetInstrumentTradesResponse ensureGetInstrumentTrades() => $_ensure(15);

  @$pb.TagNumber(305)
  $2.GetInstrumentSettlementsResponse get getInstrumentSettlements =>
      $_getN(16);
  @$pb.TagNumber(305)
  set getInstrumentSettlements($2.GetInstrumentSettlementsResponse value) =>
      $_setField(305, value);
  @$pb.TagNumber(305)
  $core.bool hasGetInstrumentSettlements() => $_has(16);
  @$pb.TagNumber(305)
  void clearGetInstrumentSettlements() => $_clearField(305);
  @$pb.TagNumber(305)
  $2.GetInstrumentSettlementsResponse ensureGetInstrumentSettlements() =>
      $_ensure(16);

  /// market responses
  @$pb.TagNumber(401)
  $3.GetMarketListResponse get getMarketList => $_getN(17);
  @$pb.TagNumber(401)
  set getMarketList($3.GetMarketListResponse value) => $_setField(401, value);
  @$pb.TagNumber(401)
  $core.bool hasGetMarketList() => $_has(17);
  @$pb.TagNumber(401)
  void clearGetMarketList() => $_clearField(401);
  @$pb.TagNumber(401)
  $3.GetMarketListResponse ensureGetMarketList() => $_ensure(17);

  @$pb.TagNumber(402)
  $3.GetMarketCalendarResponse get getMarketCalendar => $_getN(18);
  @$pb.TagNumber(402)
  set getMarketCalendar($3.GetMarketCalendarResponse value) =>
      $_setField(402, value);
  @$pb.TagNumber(402)
  $core.bool hasGetMarketCalendar() => $_has(18);
  @$pb.TagNumber(402)
  void clearGetMarketCalendar() => $_clearField(402);
  @$pb.TagNumber(402)
  $3.GetMarketCalendarResponse ensureGetMarketCalendar() => $_ensure(18);

  /// venue responses
  @$pb.TagNumber(501)
  $4.GetVenueListResponse get getVenueList => $_getN(19);
  @$pb.TagNumber(501)
  set getVenueList($4.GetVenueListResponse value) => $_setField(501, value);
  @$pb.TagNumber(501)
  $core.bool hasGetVenueList() => $_has(19);
  @$pb.TagNumber(501)
  void clearGetVenueList() => $_clearField(501);
  @$pb.TagNumber(501)
  $4.GetVenueListResponse ensureGetVenueList() => $_ensure(19);

  @$pb.TagNumber(503)
  $4.GetVenueCalendarResponse get getVenueCalendar => $_getN(20);
  @$pb.TagNumber(503)
  set getVenueCalendar($4.GetVenueCalendarResponse value) =>
      $_setField(503, value);
  @$pb.TagNumber(503)
  $core.bool hasGetVenueCalendar() => $_has(20);
  @$pb.TagNumber(503)
  void clearGetVenueCalendar() => $_clearField(503);
  @$pb.TagNumber(503)
  $4.GetVenueCalendarResponse ensureGetVenueCalendar() => $_ensure(20);

  /// TODO: Determine if GetVenueInstrumentListingListResponse should be included
  /// GetVenueInstrumentListingListResponse get_venue_instrument_listing_list = 504;
  /// trading responses
  @$pb.TagNumber(601)
  $5.GetOrderFeesResponse get getOrderFees => $_getN(21);
  @$pb.TagNumber(601)
  set getOrderFees($5.GetOrderFeesResponse value) => $_setField(601, value);
  @$pb.TagNumber(601)
  $core.bool hasGetOrderFees() => $_has(21);
  @$pb.TagNumber(601)
  void clearGetOrderFees() => $_clearField(601);
  @$pb.TagNumber(601)
  $5.GetOrderFeesResponse ensureGetOrderFees() => $_ensure(21);

  /// participant responses
  @$pb.TagNumber(701)
  $6.GetParticipantInfoResponse get getParticipantInfo => $_getN(22);
  @$pb.TagNumber(701)
  set getParticipantInfo($6.GetParticipantInfoResponse value) =>
      $_setField(701, value);
  @$pb.TagNumber(701)
  $core.bool hasGetParticipantInfo() => $_has(22);
  @$pb.TagNumber(701)
  void clearGetParticipantInfo() => $_clearField(701);
  @$pb.TagNumber(701)
  $6.GetParticipantInfoResponse ensureGetParticipantInfo() => $_ensure(22);

  @$pb.TagNumber(702)
  $6.GetParticipantOrdersResponse get getParticipantOrders => $_getN(23);
  @$pb.TagNumber(702)
  set getParticipantOrders($6.GetParticipantOrdersResponse value) =>
      $_setField(702, value);
  @$pb.TagNumber(702)
  $core.bool hasGetParticipantOrders() => $_has(23);
  @$pb.TagNumber(702)
  void clearGetParticipantOrders() => $_clearField(702);
  @$pb.TagNumber(702)
  $6.GetParticipantOrdersResponse ensureGetParticipantOrders() => $_ensure(23);

  @$pb.TagNumber(703)
  $6.GetParticipantTradesResponse get getParticipantTrades => $_getN(24);
  @$pb.TagNumber(703)
  set getParticipantTrades($6.GetParticipantTradesResponse value) =>
      $_setField(703, value);
  @$pb.TagNumber(703)
  $core.bool hasGetParticipantTrades() => $_has(24);
  @$pb.TagNumber(703)
  void clearGetParticipantTrades() => $_clearField(703);
  @$pb.TagNumber(703)
  $6.GetParticipantTradesResponse ensureGetParticipantTrades() => $_ensure(24);

  @$pb.TagNumber(704)
  $6.GetParticipantSettlementsResponse get getParticipantSettlements =>
      $_getN(25);
  @$pb.TagNumber(704)
  set getParticipantSettlements($6.GetParticipantSettlementsResponse value) =>
      $_setField(704, value);
  @$pb.TagNumber(704)
  $core.bool hasGetParticipantSettlements() => $_has(25);
  @$pb.TagNumber(704)
  void clearGetParticipantSettlements() => $_clearField(704);
  @$pb.TagNumber(704)
  $6.GetParticipantSettlementsResponse ensureGetParticipantSettlements() =>
      $_ensure(25);
}

enum Event_CarryingObject { blob, executionUpdate, executionResponse, notSet }

class Event extends $pb.GeneratedMessage {
  factory Event({
    $core.String? id,
    $core.String? hash,
    $core.String? refSubscriptionId,
    $core.String? topic,
    $0.DateTime? generatedAtDt,
    EventTypeEnum? type,
    BlobEvent? blob,
    ExecutionUpdateEvent? executionUpdate,
    ExecutionResponseEvent? executionResponse,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? displayNames,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? descriptions,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? labels,
    $core.Iterable<$core.String>? tags,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (hash != null) result.hash = hash;
    if (refSubscriptionId != null) result.refSubscriptionId = refSubscriptionId;
    if (topic != null) result.topic = topic;
    if (generatedAtDt != null) result.generatedAtDt = generatedAtDt;
    if (type != null) result.type = type;
    if (blob != null) result.blob = blob;
    if (executionUpdate != null) result.executionUpdate = executionUpdate;
    if (executionResponse != null) result.executionResponse = executionResponse;
    if (displayNames != null) result.displayNames.addEntries(displayNames);
    if (descriptions != null) result.descriptions.addEntries(descriptions);
    if (labels != null) result.labels.addEntries(labels);
    if (tags != null) result.tags.addAll(tags);
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  Event._();

  factory Event.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Event.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Event_CarryingObject>
      _Event_CarryingObjectByTag = {
    7: Event_CarryingObject.blob,
    8: Event_CarryingObject.executionUpdate,
    9: Event_CarryingObject.executionResponse,
    0: Event_CarryingObject.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Event',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..oo(0, [7, 8, 9])
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'hash')
    ..aOS(3, _omitFieldNames ? '' : 'refSubscriptionId')
    ..aOS(4, _omitFieldNames ? '' : 'topic')
    ..aOM<$0.DateTime>(5, _omitFieldNames ? '' : 'generatedAtDt',
        subBuilder: $0.DateTime.create)
    ..e<EventTypeEnum>(6, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: EventTypeEnum.EVENT_TYPE_ENUM__UNKNOWN,
        valueOf: EventTypeEnum.valueOf,
        enumValues: EventTypeEnum.values)
    ..aOM<BlobEvent>(7, _omitFieldNames ? '' : 'blob',
        subBuilder: BlobEvent.create)
    ..aOM<ExecutionUpdateEvent>(8, _omitFieldNames ? '' : 'executionUpdate',
        subBuilder: ExecutionUpdateEvent.create)
    ..aOM<ExecutionResponseEvent>(9, _omitFieldNames ? '' : 'executionResponse',
        subBuilder: ExecutionResponseEvent.create)
    ..m<$core.String, $core.String>(101, _omitFieldNames ? '' : 'displayNames',
        entryClassName: 'Event.DisplayNamesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(102, _omitFieldNames ? '' : 'descriptions',
        entryClassName: 'Event.DescriptionsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(103, _omitFieldNames ? '' : 'labels',
        entryClassName: 'Event.LabelsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..pPS(104, _omitFieldNames ? '' : 'tags')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'Event.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Event clone() => Event()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Event copyWith(void Function(Event) updates) =>
      super.copyWith((message) => updates(message as Event)) as Event;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Event create() => Event._();
  @$core.override
  Event createEmptyInstance() => create();
  static $pb.PbList<Event> createRepeated() => $pb.PbList<Event>();
  @$core.pragma('dart2js:noInline')
  static Event getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Event>(create);
  static Event? _defaultInstance;

  Event_CarryingObject whichCarryingObject() =>
      _Event_CarryingObjectByTag[$_whichOneof(0)]!;
  void clearCarryingObject() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get hash => $_getSZ(1);
  @$pb.TagNumber(2)
  set hash($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearHash() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get refSubscriptionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set refSubscriptionId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRefSubscriptionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearRefSubscriptionId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get topic => $_getSZ(3);
  @$pb.TagNumber(4)
  set topic($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTopic() => $_has(3);
  @$pb.TagNumber(4)
  void clearTopic() => $_clearField(4);

  @$pb.TagNumber(5)
  $0.DateTime get generatedAtDt => $_getN(4);
  @$pb.TagNumber(5)
  set generatedAtDt($0.DateTime value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasGeneratedAtDt() => $_has(4);
  @$pb.TagNumber(5)
  void clearGeneratedAtDt() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.DateTime ensureGeneratedAtDt() => $_ensure(4);

  @$pb.TagNumber(6)
  EventTypeEnum get type => $_getN(5);
  @$pb.TagNumber(6)
  set type(EventTypeEnum value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasType() => $_has(5);
  @$pb.TagNumber(6)
  void clearType() => $_clearField(6);

  @$pb.TagNumber(7)
  BlobEvent get blob => $_getN(6);
  @$pb.TagNumber(7)
  set blob(BlobEvent value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasBlob() => $_has(6);
  @$pb.TagNumber(7)
  void clearBlob() => $_clearField(7);
  @$pb.TagNumber(7)
  BlobEvent ensureBlob() => $_ensure(6);

  @$pb.TagNumber(8)
  ExecutionUpdateEvent get executionUpdate => $_getN(7);
  @$pb.TagNumber(8)
  set executionUpdate(ExecutionUpdateEvent value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasExecutionUpdate() => $_has(7);
  @$pb.TagNumber(8)
  void clearExecutionUpdate() => $_clearField(8);
  @$pb.TagNumber(8)
  ExecutionUpdateEvent ensureExecutionUpdate() => $_ensure(7);

  @$pb.TagNumber(9)
  ExecutionResponseEvent get executionResponse => $_getN(8);
  @$pb.TagNumber(9)
  set executionResponse(ExecutionResponseEvent value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasExecutionResponse() => $_has(8);
  @$pb.TagNumber(9)
  void clearExecutionResponse() => $_clearField(9);
  @$pb.TagNumber(9)
  ExecutionResponseEvent ensureExecutionResponse() => $_ensure(8);

  @$pb.TagNumber(101)
  $pb.PbMap<$core.String, $core.String> get displayNames => $_getMap(9);

  @$pb.TagNumber(102)
  $pb.PbMap<$core.String, $core.String> get descriptions => $_getMap(10);

  @$pb.TagNumber(103)
  $pb.PbMap<$core.String, $core.String> get labels => $_getMap(11);

  @$pb.TagNumber(104)
  $pb.PbList<$core.String> get tags => $_getList(12);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(13);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
