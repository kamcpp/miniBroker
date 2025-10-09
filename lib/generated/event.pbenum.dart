//
//  Generated code. Do not modify.
//  source: event.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class EventTypeEnum extends $pb.ProtobufEnum {
  static const EventTypeEnum EVENT_TYPE_ENUM__UNKNOWN = EventTypeEnum._(0, _omitEnumNames ? '' : 'EVENT_TYPE_ENUM__UNKNOWN');
  static const EventTypeEnum EVENT_TYPE_ENUM__NEWS = EventTypeEnum._(1, _omitEnumNames ? '' : 'EVENT_TYPE_ENUM__NEWS');
  static const EventTypeEnum EVENT_TYPE_ENUM__ANNOUNCEMENT = EventTypeEnum._(2, _omitEnumNames ? '' : 'EVENT_TYPE_ENUM__ANNOUNCEMENT');
  static const EventTypeEnum EVENT_TYPE_ENUM__MARKET_UPDATE = EventTypeEnum._(3, _omitEnumNames ? '' : 'EVENT_TYPE_ENUM__MARKET_UPDATE');
  static const EventTypeEnum EVENT_TYPE_ENUM__TRADE_EXECUTION = EventTypeEnum._(4, _omitEnumNames ? '' : 'EVENT_TYPE_ENUM__TRADE_EXECUTION');
  static const EventTypeEnum EVENT_TYPE_ENUM__ORDER_PLACED = EventTypeEnum._(5, _omitEnumNames ? '' : 'EVENT_TYPE_ENUM__ORDER_PLACED');
  static const EventTypeEnum EVENT_TYPE_ENUM__ORDER_CANCELLED = EventTypeEnum._(6, _omitEnumNames ? '' : 'EVENT_TYPE_ENUM__ORDER_CANCELLED');
  static const EventTypeEnum EVENT_TYPE_ENUM__ORDER_FILLED = EventTypeEnum._(7, _omitEnumNames ? '' : 'EVENT_TYPE_ENUM__ORDER_FILLED');
  static const EventTypeEnum EVENT_TYPE_ENUM__ORDER_EXPIRED = EventTypeEnum._(8, _omitEnumNames ? '' : 'EVENT_TYPE_ENUM__ORDER_EXPIRED');
  static const EventTypeEnum EVENT_TYPE_ENUM__PRICE_UPDATE = EventTypeEnum._(9, _omitEnumNames ? '' : 'EVENT_TYPE_ENUM__PRICE_UPDATE');
  static const EventTypeEnum EVENT_TYPE_ENUM__REGULATORY = EventTypeEnum._(10, _omitEnumNames ? '' : 'EVENT_TYPE_ENUM__REGULATORY');
  static const EventTypeEnum EVENT_TYPE_ENUM__SYSTEM = EventTypeEnum._(11, _omitEnumNames ? '' : 'EVENT_TYPE_ENUM__SYSTEM');
  static const EventTypeEnum EVENT_TYPE_ENUM__EXECUTION_UPDATE = EventTypeEnum._(12, _omitEnumNames ? '' : 'EVENT_TYPE_ENUM__EXECUTION_UPDATE');
  static const EventTypeEnum EVENT_TYPE_ENUM__EXECUTION_RESPONSE = EventTypeEnum._(13, _omitEnumNames ? '' : 'EVENT_TYPE_ENUM__EXECUTION_RESPONSE');
  static const EventTypeEnum EVENT_TYPE_ENUM__OTHER = EventTypeEnum._(1000, _omitEnumNames ? '' : 'EVENT_TYPE_ENUM__OTHER');

  static const $core.List<EventTypeEnum> values = <EventTypeEnum> [
    EVENT_TYPE_ENUM__UNKNOWN,
    EVENT_TYPE_ENUM__NEWS,
    EVENT_TYPE_ENUM__ANNOUNCEMENT,
    EVENT_TYPE_ENUM__MARKET_UPDATE,
    EVENT_TYPE_ENUM__TRADE_EXECUTION,
    EVENT_TYPE_ENUM__ORDER_PLACED,
    EVENT_TYPE_ENUM__ORDER_CANCELLED,
    EVENT_TYPE_ENUM__ORDER_FILLED,
    EVENT_TYPE_ENUM__ORDER_EXPIRED,
    EVENT_TYPE_ENUM__PRICE_UPDATE,
    EVENT_TYPE_ENUM__REGULATORY,
    EVENT_TYPE_ENUM__SYSTEM,
    EVENT_TYPE_ENUM__EXECUTION_UPDATE,
    EVENT_TYPE_ENUM__EXECUTION_RESPONSE,
    EVENT_TYPE_ENUM__OTHER,
  ];

  static final $core.Map<$core.int, EventTypeEnum> _byValue = $pb.ProtobufEnum.initByValue(values);
  static EventTypeEnum? valueOf($core.int value) => _byValue[value];

  const EventTypeEnum._($core.int v, $core.String n) : super(v, n);
}

class ExecutionUpdateEventTypeEnum extends $pb.ProtobufEnum {
  static const ExecutionUpdateEventTypeEnum EXECUTION_UPDATE_EVENT_TYPE_ENUM__UNKNOWN = ExecutionUpdateEventTypeEnum._(0, _omitEnumNames ? '' : 'EXECUTION_UPDATE_EVENT_TYPE_ENUM__UNKNOWN');
  static const ExecutionUpdateEventTypeEnum EXECUTION_UPDATE_EVENT_TYPE_ENUM__NEW_EXECUTION_FLOW = ExecutionUpdateEventTypeEnum._(1, _omitEnumNames ? '' : 'EXECUTION_UPDATE_EVENT_TYPE_ENUM__NEW_EXECUTION_FLOW');
  static const ExecutionUpdateEventTypeEnum EXECUTION_UPDATE_EVENT_TYPE_ENUM__FLOW_PROGRESS_REPORT = ExecutionUpdateEventTypeEnum._(2, _omitEnumNames ? '' : 'EXECUTION_UPDATE_EVENT_TYPE_ENUM__FLOW_PROGRESS_REPORT');
  static const ExecutionUpdateEventTypeEnum EXECUTION_UPDATE_EVENT_TYPE_ENUM__EXECUTION_COMPLETED = ExecutionUpdateEventTypeEnum._(3, _omitEnumNames ? '' : 'EXECUTION_UPDATE_EVENT_TYPE_ENUM__EXECUTION_COMPLETED');
  static const ExecutionUpdateEventTypeEnum EXECUTION_UPDATE_EVENT_TYPE_ENUM__OTHER = ExecutionUpdateEventTypeEnum._(1000, _omitEnumNames ? '' : 'EXECUTION_UPDATE_EVENT_TYPE_ENUM__OTHER');

  static const $core.List<ExecutionUpdateEventTypeEnum> values = <ExecutionUpdateEventTypeEnum> [
    EXECUTION_UPDATE_EVENT_TYPE_ENUM__UNKNOWN,
    EXECUTION_UPDATE_EVENT_TYPE_ENUM__NEW_EXECUTION_FLOW,
    EXECUTION_UPDATE_EVENT_TYPE_ENUM__FLOW_PROGRESS_REPORT,
    EXECUTION_UPDATE_EVENT_TYPE_ENUM__EXECUTION_COMPLETED,
    EXECUTION_UPDATE_EVENT_TYPE_ENUM__OTHER,
  ];

  static final $core.Map<$core.int, ExecutionUpdateEventTypeEnum> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ExecutionUpdateEventTypeEnum? valueOf($core.int value) => _byValue[value];

  const ExecutionUpdateEventTypeEnum._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
