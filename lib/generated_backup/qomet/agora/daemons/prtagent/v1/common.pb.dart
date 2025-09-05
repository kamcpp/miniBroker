// This is a generated file - do not edit.
//
// Generated from qomet/agora/daemons/prtagent/v1/common.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../../../../google/protobuf/timestamp.pb.dart' as $0;
import 'common.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'common.pbenum.dart';

class TimeHMS extends $pb.GeneratedMessage {
  factory TimeHMS({
    $core.int? hour,
    $core.int? minute,
    $core.int? second,
    $core.int? subSecond,
  }) {
    final result = create();
    if (hour != null) result.hour = hour;
    if (minute != null) result.minute = minute;
    if (second != null) result.second = second;
    if (subSecond != null) result.subSecond = subSecond;
    return result;
  }

  TimeHMS._();

  factory TimeHMS.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TimeHMS.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TimeHMS',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'hour', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'minute', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'second', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'subSecond', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TimeHMS clone() => TimeHMS()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TimeHMS copyWith(void Function(TimeHMS) updates) =>
      super.copyWith((message) => updates(message as TimeHMS)) as TimeHMS;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TimeHMS create() => TimeHMS._();
  @$core.override
  TimeHMS createEmptyInstance() => create();
  static $pb.PbList<TimeHMS> createRepeated() => $pb.PbList<TimeHMS>();
  @$core.pragma('dart2js:noInline')
  static TimeHMS getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TimeHMS>(create);
  static TimeHMS? _defaultInstance;

  /// 0 to 23
  @$pb.TagNumber(1)
  $core.int get hour => $_getIZ(0);
  @$pb.TagNumber(1)
  set hour($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHour() => $_has(0);
  @$pb.TagNumber(1)
  void clearHour() => $_clearField(1);

  /// 0 to 59
  @$pb.TagNumber(2)
  $core.int get minute => $_getIZ(1);
  @$pb.TagNumber(2)
  set minute($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMinute() => $_has(1);
  @$pb.TagNumber(2)
  void clearMinute() => $_clearField(2);

  /// 0 to 60
  @$pb.TagNumber(3)
  $core.int get second => $_getIZ(2);
  @$pb.TagNumber(3)
  set second($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSecond() => $_has(2);
  @$pb.TagNumber(3)
  void clearSecond() => $_clearField(3);

  /// 0 to 999,999,999
  @$pb.TagNumber(4)
  $core.int get subSecond => $_getIZ(3);
  @$pb.TagNumber(4)
  set subSecond($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSubSecond() => $_has(3);
  @$pb.TagNumber(4)
  void clearSubSecond() => $_clearField(4);
}

enum Time_Value { hms, ts, notSet }

class Time extends $pb.GeneratedMessage {
  factory Time({
    TimeHMS? hms,
    $0.Timestamp? ts,
  }) {
    final result = create();
    if (hms != null) result.hms = hms;
    if (ts != null) result.ts = ts;
    return result;
  }

  Time._();

  factory Time.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Time.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Time_Value> _Time_ValueByTag = {
    1: Time_Value.hms,
    2: Time_Value.ts,
    0: Time_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Time',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<TimeHMS>(1, _omitFieldNames ? '' : 'hms', subBuilder: TimeHMS.create)
    ..aOM<$0.Timestamp>(2, _omitFieldNames ? '' : 'ts',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Time clone() => Time()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Time copyWith(void Function(Time) updates) =>
      super.copyWith((message) => updates(message as Time)) as Time;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Time create() => Time._();
  @$core.override
  Time createEmptyInstance() => create();
  static $pb.PbList<Time> createRepeated() => $pb.PbList<Time>();
  @$core.pragma('dart2js:noInline')
  static Time getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Time>(create);
  static Time? _defaultInstance;

  Time_Value whichValue() => _Time_ValueByTag[$_whichOneof(0)]!;
  void clearValue() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  TimeHMS get hms => $_getN(0);
  @$pb.TagNumber(1)
  set hms(TimeHMS value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasHms() => $_has(0);
  @$pb.TagNumber(1)
  void clearHms() => $_clearField(1);
  @$pb.TagNumber(1)
  TimeHMS ensureHms() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.Timestamp get ts => $_getN(1);
  @$pb.TagNumber(2)
  set ts($0.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasTs() => $_has(1);
  @$pb.TagNumber(2)
  void clearTs() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Timestamp ensureTs() => $_ensure(1);
}

class Date extends $pb.GeneratedMessage {
  factory Date({
    $core.int? year,
    $core.int? month,
    $core.int? day,
  }) {
    final result = create();
    if (year != null) result.year = year;
    if (month != null) result.month = month;
    if (day != null) result.day = day;
    return result;
  }

  Date._();

  factory Date.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Date.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Date',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'year', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'month', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'day', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Date clone() => Date()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Date copyWith(void Function(Date) updates) =>
      super.copyWith((message) => updates(message as Date)) as Date;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Date create() => Date._();
  @$core.override
  Date createEmptyInstance() => create();
  static $pb.PbList<Date> createRepeated() => $pb.PbList<Date>();
  @$core.pragma('dart2js:noInline')
  static Date getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Date>(create);
  static Date? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get year => $_getIZ(0);
  @$pb.TagNumber(1)
  set year($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasYear() => $_has(0);
  @$pb.TagNumber(1)
  void clearYear() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get month => $_getIZ(1);
  @$pb.TagNumber(2)
  set month($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMonth() => $_has(1);
  @$pb.TagNumber(2)
  void clearMonth() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get day => $_getIZ(2);
  @$pb.TagNumber(3)
  set day($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDay() => $_has(2);
  @$pb.TagNumber(3)
  void clearDay() => $_clearField(3);
}

class DateTime extends $pb.GeneratedMessage {
  factory DateTime({
    Date? date,
    Time? time,
  }) {
    final result = create();
    if (date != null) result.date = date;
    if (time != null) result.time = time;
    return result;
  }

  DateTime._();

  factory DateTime.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DateTime.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DateTime',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOM<Date>(1, _omitFieldNames ? '' : 'date', subBuilder: Date.create)
    ..aOM<Time>(2, _omitFieldNames ? '' : 'time', subBuilder: Time.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DateTime clone() => DateTime()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DateTime copyWith(void Function(DateTime) updates) =>
      super.copyWith((message) => updates(message as DateTime)) as DateTime;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DateTime create() => DateTime._();
  @$core.override
  DateTime createEmptyInstance() => create();
  static $pb.PbList<DateTime> createRepeated() => $pb.PbList<DateTime>();
  @$core.pragma('dart2js:noInline')
  static DateTime getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DateTime>(create);
  static DateTime? _defaultInstance;

  @$pb.TagNumber(1)
  Date get date => $_getN(0);
  @$pb.TagNumber(1)
  set date(Date value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearDate() => $_clearField(1);
  @$pb.TagNumber(1)
  Date ensureDate() => $_ensure(0);

  @$pb.TagNumber(2)
  Time get time => $_getN(1);
  @$pb.TagNumber(2)
  set time(Time value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearTime() => $_clearField(2);
  @$pb.TagNumber(2)
  Time ensureTime() => $_ensure(1);
}

enum Duration_Start { startTime, startDate, startDt, notSet }

enum Duration_End { endTime, endDate, endDt, notSet }

class Duration extends $pb.GeneratedMessage {
  factory Duration({
    $core.Iterable<$core.String>? identifiers,
    $core.Iterable<$core.String>? names,
    $core.String? description,
    $core.String? metadata,
    Time? startTime,
    Date? startDate,
    DateTime? startDt,
    Time? endTime,
    Date? endDate,
    DateTime? endDt,
  }) {
    final result = create();
    if (identifiers != null) result.identifiers.addAll(identifiers);
    if (names != null) result.names.addAll(names);
    if (description != null) result.description = description;
    if (metadata != null) result.metadata = metadata;
    if (startTime != null) result.startTime = startTime;
    if (startDate != null) result.startDate = startDate;
    if (startDt != null) result.startDt = startDt;
    if (endTime != null) result.endTime = endTime;
    if (endDate != null) result.endDate = endDate;
    if (endDt != null) result.endDt = endDt;
    return result;
  }

  Duration._();

  factory Duration.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Duration.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Duration_Start> _Duration_StartByTag = {
    5: Duration_Start.startTime,
    6: Duration_Start.startDate,
    7: Duration_Start.startDt,
    0: Duration_Start.notSet
  };
  static const $core.Map<$core.int, Duration_End> _Duration_EndByTag = {
    8: Duration_End.endTime,
    9: Duration_End.endDate,
    10: Duration_End.endDt,
    0: Duration_End.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Duration',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..oo(0, [5, 6, 7])
    ..oo(1, [8, 9, 10])
    ..pPS(1, _omitFieldNames ? '' : 'identifiers')
    ..pPS(2, _omitFieldNames ? '' : 'names')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'metadata')
    ..aOM<Time>(5, _omitFieldNames ? '' : 'startTime', subBuilder: Time.create)
    ..aOM<Date>(6, _omitFieldNames ? '' : 'startDate', subBuilder: Date.create)
    ..aOM<DateTime>(7, _omitFieldNames ? '' : 'startDt',
        subBuilder: DateTime.create)
    ..aOM<Time>(8, _omitFieldNames ? '' : 'endTime', subBuilder: Time.create)
    ..aOM<Date>(9, _omitFieldNames ? '' : 'endDate', subBuilder: Date.create)
    ..aOM<DateTime>(10, _omitFieldNames ? '' : 'endDt',
        subBuilder: DateTime.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Duration clone() => Duration()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Duration copyWith(void Function(Duration) updates) =>
      super.copyWith((message) => updates(message as Duration)) as Duration;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Duration create() => Duration._();
  @$core.override
  Duration createEmptyInstance() => create();
  static $pb.PbList<Duration> createRepeated() => $pb.PbList<Duration>();
  @$core.pragma('dart2js:noInline')
  static Duration getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Duration>(create);
  static Duration? _defaultInstance;

  Duration_Start whichStart() => _Duration_StartByTag[$_whichOneof(0)]!;
  void clearStart() => $_clearField($_whichOneof(0));

  Duration_End whichEnd() => _Duration_EndByTag[$_whichOneof(1)]!;
  void clearEnd() => $_clearField($_whichOneof(1));

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get identifiers => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get names => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get metadata => $_getSZ(3);
  @$pb.TagNumber(4)
  set metadata($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMetadata() => $_has(3);
  @$pb.TagNumber(4)
  void clearMetadata() => $_clearField(4);

  @$pb.TagNumber(5)
  Time get startTime => $_getN(4);
  @$pb.TagNumber(5)
  set startTime(Time value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasStartTime() => $_has(4);
  @$pb.TagNumber(5)
  void clearStartTime() => $_clearField(5);
  @$pb.TagNumber(5)
  Time ensureStartTime() => $_ensure(4);

  @$pb.TagNumber(6)
  Date get startDate => $_getN(5);
  @$pb.TagNumber(6)
  set startDate(Date value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasStartDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearStartDate() => $_clearField(6);
  @$pb.TagNumber(6)
  Date ensureStartDate() => $_ensure(5);

  @$pb.TagNumber(7)
  DateTime get startDt => $_getN(6);
  @$pb.TagNumber(7)
  set startDt(DateTime value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasStartDt() => $_has(6);
  @$pb.TagNumber(7)
  void clearStartDt() => $_clearField(7);
  @$pb.TagNumber(7)
  DateTime ensureStartDt() => $_ensure(6);

  @$pb.TagNumber(8)
  Time get endTime => $_getN(7);
  @$pb.TagNumber(8)
  set endTime(Time value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasEndTime() => $_has(7);
  @$pb.TagNumber(8)
  void clearEndTime() => $_clearField(8);
  @$pb.TagNumber(8)
  Time ensureEndTime() => $_ensure(7);

  @$pb.TagNumber(9)
  Date get endDate => $_getN(8);
  @$pb.TagNumber(9)
  set endDate(Date value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasEndDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearEndDate() => $_clearField(9);
  @$pb.TagNumber(9)
  Date ensureEndDate() => $_ensure(8);

  @$pb.TagNumber(10)
  DateTime get endDt => $_getN(9);
  @$pb.TagNumber(10)
  set endDt(DateTime value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasEndDt() => $_has(9);
  @$pb.TagNumber(10)
  void clearEndDt() => $_clearField(10);
  @$pb.TagNumber(10)
  DateTime ensureEndDt() => $_ensure(9);
}

class PaginationParams extends $pb.GeneratedMessage {
  factory PaginationParams({
    $core.int? pageNr,
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final result = create();
    if (pageNr != null) result.pageNr = pageNr;
    if (pageSize != null) result.pageSize = pageSize;
    if (pageToken != null) result.pageToken = pageToken;
    return result;
  }

  PaginationParams._();

  factory PaginationParams.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaginationParams.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaginationParams',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'pageNr', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaginationParams clone() => PaginationParams()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaginationParams copyWith(void Function(PaginationParams) updates) =>
      super.copyWith((message) => updates(message as PaginationParams))
          as PaginationParams;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaginationParams create() => PaginationParams._();
  @$core.override
  PaginationParams createEmptyInstance() => create();
  static $pb.PbList<PaginationParams> createRepeated() =>
      $pb.PbList<PaginationParams>();
  @$core.pragma('dart2js:noInline')
  static PaginationParams getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PaginationParams>(create);
  static PaginationParams? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pageNr => $_getIZ(0);
  @$pb.TagNumber(1)
  set pageNr($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPageNr() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageNr() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get pageToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set pageToken($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPageToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageToken() => $_clearField(3);
}

class PaginationInfo extends $pb.GeneratedMessage {
  factory PaginationInfo({
    $fixnum.Int64? totalCount,
    $core.String? nextPageToken,
  }) {
    final result = create();
    if (totalCount != null) result.totalCount = totalCount;
    if (nextPageToken != null) result.nextPageToken = nextPageToken;
    return result;
  }

  PaginationInfo._();

  factory PaginationInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaginationInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaginationInfo',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'totalCount')
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaginationInfo clone() => PaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaginationInfo copyWith(void Function(PaginationInfo) updates) =>
      super.copyWith((message) => updates(message as PaginationInfo))
          as PaginationInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaginationInfo create() => PaginationInfo._();
  @$core.override
  PaginationInfo createEmptyInstance() => create();
  static $pb.PbList<PaginationInfo> createRepeated() =>
      $pb.PbList<PaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static PaginationInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PaginationInfo>(create);
  static PaginationInfo? _defaultInstance;

  ///
  ///  -1 means that the total_count cannot be computed or it is unavailable.
  @$pb.TagNumber(1)
  $fixnum.Int64 get totalCount => $_getI64(0);
  @$pb.TagNumber(1)
  set totalCount($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalCount() => $_clearField(1);

  ///
  ///  missing or empty value means that no token is avilable for the next page.
  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);
}

class ZonedIdentifier extends $pb.GeneratedMessage {
  factory ZonedIdentifier({
    $core.String? zone,
    $core.String? standardOrFormat,
    $core.Iterable<$core.String>? identifiers,
    $core.String? description,
    $core.String? metadata,
  }) {
    final result = create();
    if (zone != null) result.zone = zone;
    if (standardOrFormat != null) result.standardOrFormat = standardOrFormat;
    if (identifiers != null) result.identifiers.addAll(identifiers);
    if (description != null) result.description = description;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  ZonedIdentifier._();

  factory ZonedIdentifier.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ZonedIdentifier.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ZonedIdentifier',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'zone')
    ..aOS(2, _omitFieldNames ? '' : 'standardOrFormat')
    ..pPS(3, _omitFieldNames ? '' : 'identifiers')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aOS(5, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ZonedIdentifier clone() => ZonedIdentifier()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ZonedIdentifier copyWith(void Function(ZonedIdentifier) updates) =>
      super.copyWith((message) => updates(message as ZonedIdentifier))
          as ZonedIdentifier;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ZonedIdentifier create() => ZonedIdentifier._();
  @$core.override
  ZonedIdentifier createEmptyInstance() => create();
  static $pb.PbList<ZonedIdentifier> createRepeated() =>
      $pb.PbList<ZonedIdentifier>();
  @$core.pragma('dart2js:noInline')
  static ZonedIdentifier getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ZonedIdentifier>(create);
  static ZonedIdentifier? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get zone => $_getSZ(0);
  @$pb.TagNumber(1)
  set zone($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasZone() => $_has(0);
  @$pb.TagNumber(1)
  void clearZone() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get standardOrFormat => $_getSZ(1);
  @$pb.TagNumber(2)
  set standardOrFormat($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStandardOrFormat() => $_has(1);
  @$pb.TagNumber(2)
  void clearStandardOrFormat() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get identifiers => $_getList(2);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get metadata => $_getSZ(4);
  @$pb.TagNumber(5)
  set metadata($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMetadata() => $_has(4);
  @$pb.TagNumber(5)
  void clearMetadata() => $_clearField(5);
}

class StringValue extends $pb.GeneratedMessage {
  factory StringValue({
    $core.String? value,
    $core.bool? caseInsensitive,
  }) {
    final result = create();
    if (value != null) result.value = value;
    if (caseInsensitive != null) result.caseInsensitive = caseInsensitive;
    return result;
  }

  StringValue._();

  factory StringValue.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StringValue.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StringValue',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'value')
    ..aOB(2, _omitFieldNames ? '' : 'caseInsensitive')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StringValue clone() => StringValue()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StringValue copyWith(void Function(StringValue) updates) =>
      super.copyWith((message) => updates(message as StringValue))
          as StringValue;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StringValue create() => StringValue._();
  @$core.override
  StringValue createEmptyInstance() => create();
  static $pb.PbList<StringValue> createRepeated() => $pb.PbList<StringValue>();
  @$core.pragma('dart2js:noInline')
  static StringValue getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StringValue>(create);
  static StringValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get value => $_getSZ(0);
  @$pb.TagNumber(1)
  set value($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get caseInsensitive => $_getBF(1);
  @$pb.TagNumber(2)
  set caseInsensitive($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCaseInsensitive() => $_has(1);
  @$pb.TagNumber(2)
  void clearCaseInsensitive() => $_clearField(2);
}

class EventSubscriptionParams extends $pb.GeneratedMessage {
  factory EventSubscriptionParams({
    $core.String? refSubscriptionId,
    $core.Iterable<$core.String>? topics,
    $core.String? typeRegex,
  }) {
    final result = create();
    if (refSubscriptionId != null) result.refSubscriptionId = refSubscriptionId;
    if (topics != null) result.topics.addAll(topics);
    if (typeRegex != null) result.typeRegex = typeRegex;
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
    ..aOS(1, _omitFieldNames ? '' : 'refSubscriptionId')
    ..pPS(2, _omitFieldNames ? '' : 'topics')
    ..aOS(3, _omitFieldNames ? '' : 'typeRegex')
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
  $core.String get refSubscriptionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refSubscriptionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefSubscriptionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefSubscriptionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get topics => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get typeRegex => $_getSZ(2);
  @$pb.TagNumber(3)
  set typeRegex($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTypeRegex() => $_has(2);
  @$pb.TagNumber(3)
  void clearTypeRegex() => $_clearField(3);
}

class Event extends $pb.GeneratedMessage {
  factory Event({
    $core.String? refSubscriptionId,
    $core.String? topic,
    $core.String? type,
    $core.String? data,
  }) {
    final result = create();
    if (refSubscriptionId != null) result.refSubscriptionId = refSubscriptionId;
    if (topic != null) result.topic = topic;
    if (type != null) result.type = type;
    if (data != null) result.data = data;
    return result;
  }

  Event._();

  factory Event.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Event.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Event',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refSubscriptionId')
    ..aOS(2, _omitFieldNames ? '' : 'topic')
    ..aOS(3, _omitFieldNames ? '' : 'type')
    ..aOS(4, _omitFieldNames ? '' : 'data')
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

  @$pb.TagNumber(1)
  $core.String get refSubscriptionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refSubscriptionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefSubscriptionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefSubscriptionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get topic => $_getSZ(1);
  @$pb.TagNumber(2)
  set topic($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTopic() => $_has(1);
  @$pb.TagNumber(2)
  void clearTopic() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get data => $_getSZ(3);
  @$pb.TagNumber(4)
  set data($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasData() => $_has(3);
  @$pb.TagNumber(4)
  void clearData() => $_clearField(4);
}

class ZonedSymbol extends $pb.GeneratedMessage {
  factory ZonedSymbol({
    $core.String? zone,
    $core.String? standardOrFormat,
    $core.Iterable<StringValue>? symbols,
    $core.String? description,
    $core.String? metadata,
  }) {
    final result = create();
    if (zone != null) result.zone = zone;
    if (standardOrFormat != null) result.standardOrFormat = standardOrFormat;
    if (symbols != null) result.symbols.addAll(symbols);
    if (description != null) result.description = description;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  ZonedSymbol._();

  factory ZonedSymbol.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ZonedSymbol.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ZonedSymbol',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'zone')
    ..aOS(2, _omitFieldNames ? '' : 'standardOrFormat')
    ..pc<StringValue>(3, _omitFieldNames ? '' : 'symbols', $pb.PbFieldType.PM,
        subBuilder: StringValue.create)
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aOS(5, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ZonedSymbol clone() => ZonedSymbol()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ZonedSymbol copyWith(void Function(ZonedSymbol) updates) =>
      super.copyWith((message) => updates(message as ZonedSymbol))
          as ZonedSymbol;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ZonedSymbol create() => ZonedSymbol._();
  @$core.override
  ZonedSymbol createEmptyInstance() => create();
  static $pb.PbList<ZonedSymbol> createRepeated() => $pb.PbList<ZonedSymbol>();
  @$core.pragma('dart2js:noInline')
  static ZonedSymbol getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ZonedSymbol>(create);
  static ZonedSymbol? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get zone => $_getSZ(0);
  @$pb.TagNumber(1)
  set zone($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasZone() => $_has(0);
  @$pb.TagNumber(1)
  void clearZone() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get standardOrFormat => $_getSZ(1);
  @$pb.TagNumber(2)
  set standardOrFormat($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStandardOrFormat() => $_has(1);
  @$pb.TagNumber(2)
  void clearStandardOrFormat() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<StringValue> get symbols => $_getList(2);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get metadata => $_getSZ(4);
  @$pb.TagNumber(5)
  set metadata($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMetadata() => $_has(4);
  @$pb.TagNumber(5)
  void clearMetadata() => $_clearField(5);
}

class ZonedAssetType extends $pb.GeneratedMessage {
  factory ZonedAssetType({
    $core.String? zone,
    $core.Iterable<AssetType>? types,
    $core.String? description,
    $core.String? metadata,
  }) {
    final result = create();
    if (zone != null) result.zone = zone;
    if (types != null) result.types.addAll(types);
    if (description != null) result.description = description;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  ZonedAssetType._();

  factory ZonedAssetType.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ZonedAssetType.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ZonedAssetType',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'zone')
    ..pc<AssetType>(2, _omitFieldNames ? '' : 'types', $pb.PbFieldType.KE,
        valueOf: AssetType.valueOf,
        enumValues: AssetType.values,
        defaultEnumValue: AssetType.ASSET_TYPE__UNKNOWN)
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ZonedAssetType clone() => ZonedAssetType()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ZonedAssetType copyWith(void Function(ZonedAssetType) updates) =>
      super.copyWith((message) => updates(message as ZonedAssetType))
          as ZonedAssetType;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ZonedAssetType create() => ZonedAssetType._();
  @$core.override
  ZonedAssetType createEmptyInstance() => create();
  static $pb.PbList<ZonedAssetType> createRepeated() =>
      $pb.PbList<ZonedAssetType>();
  @$core.pragma('dart2js:noInline')
  static ZonedAssetType getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ZonedAssetType>(create);
  static ZonedAssetType? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get zone => $_getSZ(0);
  @$pb.TagNumber(1)
  set zone($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasZone() => $_has(0);
  @$pb.TagNumber(1)
  void clearZone() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<AssetType> get types => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get metadata => $_getSZ(3);
  @$pb.TagNumber(4)
  set metadata($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMetadata() => $_has(3);
  @$pb.TagNumber(4)
  void clearMetadata() => $_clearField(4);
}

class Asset extends $pb.GeneratedMessage {
  factory Asset({
    $core.Iterable<ZonedIdentifier>? zonedIdentifiers,
    $core.Iterable<ZonedSymbol>? zonedSymbols,
    $core.Iterable<ZonedAssetType>? zonedAssetTypes,
    $core.int? decimals,
    $core.bool? disabled,
    $core.String? description,
    $core.String? metadata,
  }) {
    final result = create();
    if (zonedIdentifiers != null)
      result.zonedIdentifiers.addAll(zonedIdentifiers);
    if (zonedSymbols != null) result.zonedSymbols.addAll(zonedSymbols);
    if (zonedAssetTypes != null) result.zonedAssetTypes.addAll(zonedAssetTypes);
    if (decimals != null) result.decimals = decimals;
    if (disabled != null) result.disabled = disabled;
    if (description != null) result.description = description;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  Asset._();

  factory Asset.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Asset.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Asset',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..pc<ZonedIdentifier>(
        1, _omitFieldNames ? '' : 'zonedIdentifiers', $pb.PbFieldType.PM,
        subBuilder: ZonedIdentifier.create)
    ..pc<ZonedSymbol>(
        2, _omitFieldNames ? '' : 'zonedSymbols', $pb.PbFieldType.PM,
        subBuilder: ZonedSymbol.create)
    ..pc<ZonedAssetType>(
        3, _omitFieldNames ? '' : 'zonedAssetTypes', $pb.PbFieldType.PM,
        subBuilder: ZonedAssetType.create)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'decimals', $pb.PbFieldType.O3)
    ..aOB(5, _omitFieldNames ? '' : 'disabled')
    ..aOS(6, _omitFieldNames ? '' : 'description')
    ..aOS(7, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Asset clone() => Asset()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Asset copyWith(void Function(Asset) updates) =>
      super.copyWith((message) => updates(message as Asset)) as Asset;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Asset create() => Asset._();
  @$core.override
  Asset createEmptyInstance() => create();
  static $pb.PbList<Asset> createRepeated() => $pb.PbList<Asset>();
  @$core.pragma('dart2js:noInline')
  static Asset getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Asset>(create);
  static Asset? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ZonedIdentifier> get zonedIdentifiers => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<ZonedSymbol> get zonedSymbols => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<ZonedAssetType> get zonedAssetTypes => $_getList(2);

  @$pb.TagNumber(4)
  $core.int get decimals => $_getIZ(3);
  @$pb.TagNumber(4)
  set decimals($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDecimals() => $_has(3);
  @$pb.TagNumber(4)
  void clearDecimals() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get disabled => $_getBF(4);
  @$pb.TagNumber(5)
  set disabled($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDisabled() => $_has(4);
  @$pb.TagNumber(5)
  void clearDisabled() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get metadata => $_getSZ(6);
  @$pb.TagNumber(7)
  set metadata($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasMetadata() => $_has(6);
  @$pb.TagNumber(7)
  void clearMetadata() => $_clearField(7);
}

class Market extends $pb.GeneratedMessage {
  factory Market({
    $core.Iterable<$core.String>? identifiers,
    $core.Iterable<$core.String>? names,
    $core.String? description,
    $core.String? metadata,
  }) {
    final result = create();
    if (identifiers != null) result.identifiers.addAll(identifiers);
    if (names != null) result.names.addAll(names);
    if (description != null) result.description = description;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  Market._();

  factory Market.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Market.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Market',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'identifiers')
    ..pPS(2, _omitFieldNames ? '' : 'names')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Market clone() => Market()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Market copyWith(void Function(Market) updates) =>
      super.copyWith((message) => updates(message as Market)) as Market;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Market create() => Market._();
  @$core.override
  Market createEmptyInstance() => create();
  static $pb.PbList<Market> createRepeated() => $pb.PbList<Market>();
  @$core.pragma('dart2js:noInline')
  static Market getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Market>(create);
  static Market? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get identifiers => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get names => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get metadata => $_getSZ(3);
  @$pb.TagNumber(4)
  set metadata($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMetadata() => $_has(3);
  @$pb.TagNumber(4)
  void clearMetadata() => $_clearField(4);
}

class ZonedInstrumentType extends $pb.GeneratedMessage {
  factory ZonedInstrumentType({
    $core.String? zone,
    $core.Iterable<InstrumentType>? types,
    $core.String? description,
    $core.String? metadata,
  }) {
    final result = create();
    if (zone != null) result.zone = zone;
    if (types != null) result.types.addAll(types);
    if (description != null) result.description = description;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  ZonedInstrumentType._();

  factory ZonedInstrumentType.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ZonedInstrumentType.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ZonedInstrumentType',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'zone')
    ..pc<InstrumentType>(2, _omitFieldNames ? '' : 'types', $pb.PbFieldType.KE,
        valueOf: InstrumentType.valueOf,
        enumValues: InstrumentType.values,
        defaultEnumValue: InstrumentType.INSTRUMENT_TYPE__UNKNOWN)
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ZonedInstrumentType clone() => ZonedInstrumentType()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ZonedInstrumentType copyWith(void Function(ZonedInstrumentType) updates) =>
      super.copyWith((message) => updates(message as ZonedInstrumentType))
          as ZonedInstrumentType;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ZonedInstrumentType create() => ZonedInstrumentType._();
  @$core.override
  ZonedInstrumentType createEmptyInstance() => create();
  static $pb.PbList<ZonedInstrumentType> createRepeated() =>
      $pb.PbList<ZonedInstrumentType>();
  @$core.pragma('dart2js:noInline')
  static ZonedInstrumentType getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ZonedInstrumentType>(create);
  static ZonedInstrumentType? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get zone => $_getSZ(0);
  @$pb.TagNumber(1)
  set zone($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasZone() => $_has(0);
  @$pb.TagNumber(1)
  void clearZone() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<InstrumentType> get types => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get metadata => $_getSZ(3);
  @$pb.TagNumber(4)
  set metadata($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMetadata() => $_has(3);
  @$pb.TagNumber(4)
  void clearMetadata() => $_clearField(4);
}

class Instrument extends $pb.GeneratedMessage {
  factory Instrument({
    $core.Iterable<ZonedIdentifier>? zonedIdentifiers,
    $core.Iterable<ZonedSymbol>? zonedSymbols,
    $core.Iterable<ZonedInstrumentType>? zonedInstrumentTypes,
    Market? market,
    Asset? theAsset,
    Asset? currency,
    InstrumentListingStatusType? listingStatusType,
    $core.String? description,
    $core.String? metadata,
  }) {
    final result = create();
    if (zonedIdentifiers != null)
      result.zonedIdentifiers.addAll(zonedIdentifiers);
    if (zonedSymbols != null) result.zonedSymbols.addAll(zonedSymbols);
    if (zonedInstrumentTypes != null)
      result.zonedInstrumentTypes.addAll(zonedInstrumentTypes);
    if (market != null) result.market = market;
    if (theAsset != null) result.theAsset = theAsset;
    if (currency != null) result.currency = currency;
    if (listingStatusType != null) result.listingStatusType = listingStatusType;
    if (description != null) result.description = description;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  Instrument._();

  factory Instrument.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Instrument.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Instrument',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..pc<ZonedIdentifier>(
        1, _omitFieldNames ? '' : 'zonedIdentifiers', $pb.PbFieldType.PM,
        subBuilder: ZonedIdentifier.create)
    ..pc<ZonedSymbol>(
        2, _omitFieldNames ? '' : 'zonedSymbols', $pb.PbFieldType.PM,
        subBuilder: ZonedSymbol.create)
    ..pc<ZonedInstrumentType>(
        3, _omitFieldNames ? '' : 'zonedInstrumentTypes', $pb.PbFieldType.PM,
        subBuilder: ZonedInstrumentType.create)
    ..aOM<Market>(4, _omitFieldNames ? '' : 'market', subBuilder: Market.create)
    ..aOM<Asset>(5, _omitFieldNames ? '' : 'theAsset', subBuilder: Asset.create)
    ..aOM<Asset>(6, _omitFieldNames ? '' : 'currency', subBuilder: Asset.create)
    ..e<InstrumentListingStatusType>(
        7, _omitFieldNames ? '' : 'listingStatusType', $pb.PbFieldType.OE,
        defaultOrMaker:
            InstrumentListingStatusType.INSTRUMENT_LISTING_STATUS_TYPE__UNKNOWN,
        valueOf: InstrumentListingStatusType.valueOf,
        enumValues: InstrumentListingStatusType.values)
    ..aOS(8, _omitFieldNames ? '' : 'description')
    ..aOS(9, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Instrument clone() => Instrument()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Instrument copyWith(void Function(Instrument) updates) =>
      super.copyWith((message) => updates(message as Instrument)) as Instrument;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Instrument create() => Instrument._();
  @$core.override
  Instrument createEmptyInstance() => create();
  static $pb.PbList<Instrument> createRepeated() => $pb.PbList<Instrument>();
  @$core.pragma('dart2js:noInline')
  static Instrument getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Instrument>(create);
  static Instrument? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ZonedIdentifier> get zonedIdentifiers => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<ZonedSymbol> get zonedSymbols => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<ZonedInstrumentType> get zonedInstrumentTypes => $_getList(2);

  @$pb.TagNumber(4)
  Market get market => $_getN(3);
  @$pb.TagNumber(4)
  set market(Market value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasMarket() => $_has(3);
  @$pb.TagNumber(4)
  void clearMarket() => $_clearField(4);
  @$pb.TagNumber(4)
  Market ensureMarket() => $_ensure(3);

  @$pb.TagNumber(5)
  Asset get theAsset => $_getN(4);
  @$pb.TagNumber(5)
  set theAsset(Asset value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasTheAsset() => $_has(4);
  @$pb.TagNumber(5)
  void clearTheAsset() => $_clearField(5);
  @$pb.TagNumber(5)
  Asset ensureTheAsset() => $_ensure(4);

  @$pb.TagNumber(6)
  Asset get currency => $_getN(5);
  @$pb.TagNumber(6)
  set currency(Asset value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => $_clearField(6);
  @$pb.TagNumber(6)
  Asset ensureCurrency() => $_ensure(5);

  @$pb.TagNumber(7)
  InstrumentListingStatusType get listingStatusType => $_getN(6);
  @$pb.TagNumber(7)
  set listingStatusType(InstrumentListingStatusType value) =>
      $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasListingStatusType() => $_has(6);
  @$pb.TagNumber(7)
  void clearListingStatusType() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get description => $_getSZ(7);
  @$pb.TagNumber(8)
  set description($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDescription() => $_has(7);
  @$pb.TagNumber(8)
  void clearDescription() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get metadata => $_getSZ(8);
  @$pb.TagNumber(9)
  set metadata($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasMetadata() => $_has(8);
  @$pb.TagNumber(9)
  void clearMetadata() => $_clearField(9);
}

class Order extends $pb.GeneratedMessage {
  factory Order({
    $core.String? orderId,
    $core.String? orderHash,
    $core.String? participantId,
    $core.String? participantOrderId,
    $core.String? participantAccountId,
    $core.String? investorAccountId,
    $core.String? executorAccountId,
    $core.String? orderType,
    OrderSide? side,
    $core.String? symbol,
    $core.String? currency,
    $core.String? quantity,
    $core.String? remainingQuantity,
    $core.String? price,
    $core.String? volume,
    $core.String? remainingVolume,
    $core.String? slippage,
    $core.String? timeInForce,
    $core.String? createTimestamp,
    $core.String? effectiveTimestamp,
    $core.String? expireTimestamp,
    $core.bool? isOffer,
    $core.bool? isDirectlyFillable,
    $core.bool? isBid,
    $core.bool? isFilled,
    $core.bool? isCancelled,
    $core.bool? isExpired,
    $core.String? creatorAddress,
    $core.String? trezorStashId,
    $core.String? offerIds,
    $core.String? parentDirectOrderId,
    $core.String? alarmAbi,
    $core.String? alarmData,
    $core.String? data,
    $core.String? dataEncoding,
    $core.String? participantData,
  }) {
    final result = create();
    if (orderId != null) result.orderId = orderId;
    if (orderHash != null) result.orderHash = orderHash;
    if (participantId != null) result.participantId = participantId;
    if (participantOrderId != null)
      result.participantOrderId = participantOrderId;
    if (participantAccountId != null)
      result.participantAccountId = participantAccountId;
    if (investorAccountId != null) result.investorAccountId = investorAccountId;
    if (executorAccountId != null) result.executorAccountId = executorAccountId;
    if (orderType != null) result.orderType = orderType;
    if (side != null) result.side = side;
    if (symbol != null) result.symbol = symbol;
    if (currency != null) result.currency = currency;
    if (quantity != null) result.quantity = quantity;
    if (remainingQuantity != null) result.remainingQuantity = remainingQuantity;
    if (price != null) result.price = price;
    if (volume != null) result.volume = volume;
    if (remainingVolume != null) result.remainingVolume = remainingVolume;
    if (slippage != null) result.slippage = slippage;
    if (timeInForce != null) result.timeInForce = timeInForce;
    if (createTimestamp != null) result.createTimestamp = createTimestamp;
    if (effectiveTimestamp != null)
      result.effectiveTimestamp = effectiveTimestamp;
    if (expireTimestamp != null) result.expireTimestamp = expireTimestamp;
    if (isOffer != null) result.isOffer = isOffer;
    if (isDirectlyFillable != null)
      result.isDirectlyFillable = isDirectlyFillable;
    if (isBid != null) result.isBid = isBid;
    if (isFilled != null) result.isFilled = isFilled;
    if (isCancelled != null) result.isCancelled = isCancelled;
    if (isExpired != null) result.isExpired = isExpired;
    if (creatorAddress != null) result.creatorAddress = creatorAddress;
    if (trezorStashId != null) result.trezorStashId = trezorStashId;
    if (offerIds != null) result.offerIds = offerIds;
    if (parentDirectOrderId != null)
      result.parentDirectOrderId = parentDirectOrderId;
    if (alarmAbi != null) result.alarmAbi = alarmAbi;
    if (alarmData != null) result.alarmData = alarmData;
    if (data != null) result.data = data;
    if (dataEncoding != null) result.dataEncoding = dataEncoding;
    if (participantData != null) result.participantData = participantData;
    return result;
  }

  Order._();

  factory Order.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Order.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Order',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'orderId')
    ..aOS(2, _omitFieldNames ? '' : 'orderHash')
    ..aOS(3, _omitFieldNames ? '' : 'participantId')
    ..aOS(4, _omitFieldNames ? '' : 'participantOrderId')
    ..aOS(5, _omitFieldNames ? '' : 'participantAccountId')
    ..aOS(6, _omitFieldNames ? '' : 'investorAccountId')
    ..aOS(7, _omitFieldNames ? '' : 'executorAccountId')
    ..aOS(8, _omitFieldNames ? '' : 'orderType')
    ..e<OrderSide>(9, _omitFieldNames ? '' : 'side', $pb.PbFieldType.OE,
        defaultOrMaker: OrderSide.ORDER_SIDE__UNKNOWN,
        valueOf: OrderSide.valueOf,
        enumValues: OrderSide.values)
    ..aOS(10, _omitFieldNames ? '' : 'symbol')
    ..aOS(11, _omitFieldNames ? '' : 'currency')
    ..aOS(12, _omitFieldNames ? '' : 'quantity')
    ..aOS(13, _omitFieldNames ? '' : 'remainingQuantity')
    ..aOS(14, _omitFieldNames ? '' : 'price')
    ..aOS(15, _omitFieldNames ? '' : 'volume')
    ..aOS(16, _omitFieldNames ? '' : 'remainingVolume')
    ..aOS(17, _omitFieldNames ? '' : 'slippage')
    ..aOS(18, _omitFieldNames ? '' : 'timeInForce')
    ..aOS(19, _omitFieldNames ? '' : 'createTimestamp')
    ..aOS(20, _omitFieldNames ? '' : 'effectiveTimestamp')
    ..aOS(21, _omitFieldNames ? '' : 'expireTimestamp')
    ..aOB(22, _omitFieldNames ? '' : 'isOffer')
    ..aOB(23, _omitFieldNames ? '' : 'isDirectlyFillable')
    ..aOB(24, _omitFieldNames ? '' : 'isBid')
    ..aOB(25, _omitFieldNames ? '' : 'isFilled')
    ..aOB(26, _omitFieldNames ? '' : 'isCancelled')
    ..aOB(27, _omitFieldNames ? '' : 'isExpired')
    ..aOS(28, _omitFieldNames ? '' : 'creatorAddress')
    ..aOS(29, _omitFieldNames ? '' : 'trezorStashId')
    ..aOS(30, _omitFieldNames ? '' : 'offerIds')
    ..aOS(31, _omitFieldNames ? '' : 'parentDirectOrderId')
    ..aOS(32, _omitFieldNames ? '' : 'alarmAbi')
    ..aOS(33, _omitFieldNames ? '' : 'alarmData')
    ..aOS(34, _omitFieldNames ? '' : 'data')
    ..aOS(35, _omitFieldNames ? '' : 'dataEncoding')
    ..aOS(36, _omitFieldNames ? '' : 'participantData')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Order clone() => Order()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Order copyWith(void Function(Order) updates) =>
      super.copyWith((message) => updates(message as Order)) as Order;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Order create() => Order._();
  @$core.override
  Order createEmptyInstance() => create();
  static $pb.PbList<Order> createRepeated() => $pb.PbList<Order>();
  @$core.pragma('dart2js:noInline')
  static Order getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Order>(create);
  static Order? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get orderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set orderId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOrderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrderId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get orderHash => $_getSZ(1);
  @$pb.TagNumber(2)
  set orderHash($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOrderHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrderHash() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get participantId => $_getSZ(2);
  @$pb.TagNumber(3)
  set participantId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasParticipantId() => $_has(2);
  @$pb.TagNumber(3)
  void clearParticipantId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get participantOrderId => $_getSZ(3);
  @$pb.TagNumber(4)
  set participantOrderId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasParticipantOrderId() => $_has(3);
  @$pb.TagNumber(4)
  void clearParticipantOrderId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get participantAccountId => $_getSZ(4);
  @$pb.TagNumber(5)
  set participantAccountId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasParticipantAccountId() => $_has(4);
  @$pb.TagNumber(5)
  void clearParticipantAccountId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get investorAccountId => $_getSZ(5);
  @$pb.TagNumber(6)
  set investorAccountId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasInvestorAccountId() => $_has(5);
  @$pb.TagNumber(6)
  void clearInvestorAccountId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get executorAccountId => $_getSZ(6);
  @$pb.TagNumber(7)
  set executorAccountId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasExecutorAccountId() => $_has(6);
  @$pb.TagNumber(7)
  void clearExecutorAccountId() => $_clearField(7);

  /// Order details
  @$pb.TagNumber(8)
  $core.String get orderType => $_getSZ(7);
  @$pb.TagNumber(8)
  set orderType($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasOrderType() => $_has(7);
  @$pb.TagNumber(8)
  void clearOrderType() => $_clearField(8);

  @$pb.TagNumber(9)
  OrderSide get side => $_getN(8);
  @$pb.TagNumber(9)
  set side(OrderSide value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasSide() => $_has(8);
  @$pb.TagNumber(9)
  void clearSide() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get symbol => $_getSZ(9);
  @$pb.TagNumber(10)
  set symbol($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasSymbol() => $_has(9);
  @$pb.TagNumber(10)
  void clearSymbol() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get currency => $_getSZ(10);
  @$pb.TagNumber(11)
  set currency($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCurrency() => $_has(10);
  @$pb.TagNumber(11)
  void clearCurrency() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get quantity => $_getSZ(11);
  @$pb.TagNumber(12)
  set quantity($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasQuantity() => $_has(11);
  @$pb.TagNumber(12)
  void clearQuantity() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get remainingQuantity => $_getSZ(12);
  @$pb.TagNumber(13)
  set remainingQuantity($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasRemainingQuantity() => $_has(12);
  @$pb.TagNumber(13)
  void clearRemainingQuantity() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get price => $_getSZ(13);
  @$pb.TagNumber(14)
  set price($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasPrice() => $_has(13);
  @$pb.TagNumber(14)
  void clearPrice() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get volume => $_getSZ(14);
  @$pb.TagNumber(15)
  set volume($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasVolume() => $_has(14);
  @$pb.TagNumber(15)
  void clearVolume() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get remainingVolume => $_getSZ(15);
  @$pb.TagNumber(16)
  set remainingVolume($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasRemainingVolume() => $_has(15);
  @$pb.TagNumber(16)
  void clearRemainingVolume() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get slippage => $_getSZ(16);
  @$pb.TagNumber(17)
  set slippage($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasSlippage() => $_has(16);
  @$pb.TagNumber(17)
  void clearSlippage() => $_clearField(17);

  /// Time fields
  @$pb.TagNumber(18)
  $core.String get timeInForce => $_getSZ(17);
  @$pb.TagNumber(18)
  set timeInForce($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasTimeInForce() => $_has(17);
  @$pb.TagNumber(18)
  void clearTimeInForce() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get createTimestamp => $_getSZ(18);
  @$pb.TagNumber(19)
  set createTimestamp($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasCreateTimestamp() => $_has(18);
  @$pb.TagNumber(19)
  void clearCreateTimestamp() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get effectiveTimestamp => $_getSZ(19);
  @$pb.TagNumber(20)
  set effectiveTimestamp($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasEffectiveTimestamp() => $_has(19);
  @$pb.TagNumber(20)
  void clearEffectiveTimestamp() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.String get expireTimestamp => $_getSZ(20);
  @$pb.TagNumber(21)
  set expireTimestamp($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasExpireTimestamp() => $_has(20);
  @$pb.TagNumber(21)
  void clearExpireTimestamp() => $_clearField(21);

  /// Status flags
  @$pb.TagNumber(22)
  $core.bool get isOffer => $_getBF(21);
  @$pb.TagNumber(22)
  set isOffer($core.bool value) => $_setBool(21, value);
  @$pb.TagNumber(22)
  $core.bool hasIsOffer() => $_has(21);
  @$pb.TagNumber(22)
  void clearIsOffer() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.bool get isDirectlyFillable => $_getBF(22);
  @$pb.TagNumber(23)
  set isDirectlyFillable($core.bool value) => $_setBool(22, value);
  @$pb.TagNumber(23)
  $core.bool hasIsDirectlyFillable() => $_has(22);
  @$pb.TagNumber(23)
  void clearIsDirectlyFillable() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.bool get isBid => $_getBF(23);
  @$pb.TagNumber(24)
  set isBid($core.bool value) => $_setBool(23, value);
  @$pb.TagNumber(24)
  $core.bool hasIsBid() => $_has(23);
  @$pb.TagNumber(24)
  void clearIsBid() => $_clearField(24);

  @$pb.TagNumber(25)
  $core.bool get isFilled => $_getBF(24);
  @$pb.TagNumber(25)
  set isFilled($core.bool value) => $_setBool(24, value);
  @$pb.TagNumber(25)
  $core.bool hasIsFilled() => $_has(24);
  @$pb.TagNumber(25)
  void clearIsFilled() => $_clearField(25);

  @$pb.TagNumber(26)
  $core.bool get isCancelled => $_getBF(25);
  @$pb.TagNumber(26)
  set isCancelled($core.bool value) => $_setBool(25, value);
  @$pb.TagNumber(26)
  $core.bool hasIsCancelled() => $_has(25);
  @$pb.TagNumber(26)
  void clearIsCancelled() => $_clearField(26);

  @$pb.TagNumber(27)
  $core.bool get isExpired => $_getBF(26);
  @$pb.TagNumber(27)
  set isExpired($core.bool value) => $_setBool(26, value);
  @$pb.TagNumber(27)
  $core.bool hasIsExpired() => $_has(26);
  @$pb.TagNumber(27)
  void clearIsExpired() => $_clearField(27);

  /// Additional data
  @$pb.TagNumber(28)
  $core.String get creatorAddress => $_getSZ(27);
  @$pb.TagNumber(28)
  set creatorAddress($core.String value) => $_setString(27, value);
  @$pb.TagNumber(28)
  $core.bool hasCreatorAddress() => $_has(27);
  @$pb.TagNumber(28)
  void clearCreatorAddress() => $_clearField(28);

  @$pb.TagNumber(29)
  $core.String get trezorStashId => $_getSZ(28);
  @$pb.TagNumber(29)
  set trezorStashId($core.String value) => $_setString(28, value);
  @$pb.TagNumber(29)
  $core.bool hasTrezorStashId() => $_has(28);
  @$pb.TagNumber(29)
  void clearTrezorStashId() => $_clearField(29);

  @$pb.TagNumber(30)
  $core.String get offerIds => $_getSZ(29);
  @$pb.TagNumber(30)
  set offerIds($core.String value) => $_setString(29, value);
  @$pb.TagNumber(30)
  $core.bool hasOfferIds() => $_has(29);
  @$pb.TagNumber(30)
  void clearOfferIds() => $_clearField(30);

  @$pb.TagNumber(31)
  $core.String get parentDirectOrderId => $_getSZ(30);
  @$pb.TagNumber(31)
  set parentDirectOrderId($core.String value) => $_setString(30, value);
  @$pb.TagNumber(31)
  $core.bool hasParentDirectOrderId() => $_has(30);
  @$pb.TagNumber(31)
  void clearParentDirectOrderId() => $_clearField(31);

  @$pb.TagNumber(32)
  $core.String get alarmAbi => $_getSZ(31);
  @$pb.TagNumber(32)
  set alarmAbi($core.String value) => $_setString(31, value);
  @$pb.TagNumber(32)
  $core.bool hasAlarmAbi() => $_has(31);
  @$pb.TagNumber(32)
  void clearAlarmAbi() => $_clearField(32);

  @$pb.TagNumber(33)
  $core.String get alarmData => $_getSZ(32);
  @$pb.TagNumber(33)
  set alarmData($core.String value) => $_setString(32, value);
  @$pb.TagNumber(33)
  $core.bool hasAlarmData() => $_has(32);
  @$pb.TagNumber(33)
  void clearAlarmData() => $_clearField(33);

  @$pb.TagNumber(34)
  $core.String get data => $_getSZ(33);
  @$pb.TagNumber(34)
  set data($core.String value) => $_setString(33, value);
  @$pb.TagNumber(34)
  $core.bool hasData() => $_has(33);
  @$pb.TagNumber(34)
  void clearData() => $_clearField(34);

  @$pb.TagNumber(35)
  $core.String get dataEncoding => $_getSZ(34);
  @$pb.TagNumber(35)
  set dataEncoding($core.String value) => $_setString(34, value);
  @$pb.TagNumber(35)
  $core.bool hasDataEncoding() => $_has(34);
  @$pb.TagNumber(35)
  void clearDataEncoding() => $_clearField(35);

  @$pb.TagNumber(36)
  $core.String get participantData => $_getSZ(35);
  @$pb.TagNumber(36)
  set participantData($core.String value) => $_setString(35, value);
  @$pb.TagNumber(36)
  $core.bool hasParticipantData() => $_has(35);
  @$pb.TagNumber(36)
  void clearParticipantData() => $_clearField(36);
}

class Trade extends $pb.GeneratedMessage {
  factory Trade({
    $core.String? tradeId,
    $core.String? tradeHash,
    $core.String? timestamp,
    $core.String? creatorAddress,
    $core.String? tradeType,
    $core.bool? isBuy,
    $core.String? bidOrderId,
    $core.String? askOrderId,
    $core.String? quantity,
    $core.String? price,
    $core.String? volume,
    $core.String? bidFee,
    $core.String? askFee,
    $core.String? dataAbi,
    $core.String? data,
  }) {
    final result = create();
    if (tradeId != null) result.tradeId = tradeId;
    if (tradeHash != null) result.tradeHash = tradeHash;
    if (timestamp != null) result.timestamp = timestamp;
    if (creatorAddress != null) result.creatorAddress = creatorAddress;
    if (tradeType != null) result.tradeType = tradeType;
    if (isBuy != null) result.isBuy = isBuy;
    if (bidOrderId != null) result.bidOrderId = bidOrderId;
    if (askOrderId != null) result.askOrderId = askOrderId;
    if (quantity != null) result.quantity = quantity;
    if (price != null) result.price = price;
    if (volume != null) result.volume = volume;
    if (bidFee != null) result.bidFee = bidFee;
    if (askFee != null) result.askFee = askFee;
    if (dataAbi != null) result.dataAbi = dataAbi;
    if (data != null) result.data = data;
    return result;
  }

  Trade._();

  factory Trade.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Trade.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Trade',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'tradeId')
    ..aOS(2, _omitFieldNames ? '' : 'tradeHash')
    ..aOS(3, _omitFieldNames ? '' : 'timestamp')
    ..aOS(4, _omitFieldNames ? '' : 'creatorAddress')
    ..aOS(5, _omitFieldNames ? '' : 'tradeType')
    ..aOB(6, _omitFieldNames ? '' : 'isBuy')
    ..aOS(7, _omitFieldNames ? '' : 'bidOrderId')
    ..aOS(8, _omitFieldNames ? '' : 'askOrderId')
    ..aOS(9, _omitFieldNames ? '' : 'quantity')
    ..aOS(10, _omitFieldNames ? '' : 'price')
    ..aOS(11, _omitFieldNames ? '' : 'volume')
    ..aOS(12, _omitFieldNames ? '' : 'bidFee')
    ..aOS(13, _omitFieldNames ? '' : 'askFee')
    ..aOS(14, _omitFieldNames ? '' : 'dataAbi')
    ..aOS(15, _omitFieldNames ? '' : 'data')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Trade clone() => Trade()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Trade copyWith(void Function(Trade) updates) =>
      super.copyWith((message) => updates(message as Trade)) as Trade;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Trade create() => Trade._();
  @$core.override
  Trade createEmptyInstance() => create();
  static $pb.PbList<Trade> createRepeated() => $pb.PbList<Trade>();
  @$core.pragma('dart2js:noInline')
  static Trade getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Trade>(create);
  static Trade? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get tradeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set tradeId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTradeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTradeId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get tradeHash => $_getSZ(1);
  @$pb.TagNumber(2)
  set tradeHash($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTradeHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearTradeHash() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get timestamp => $_getSZ(2);
  @$pb.TagNumber(3)
  set timestamp($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get creatorAddress => $_getSZ(3);
  @$pb.TagNumber(4)
  set creatorAddress($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCreatorAddress() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatorAddress() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get tradeType => $_getSZ(4);
  @$pb.TagNumber(5)
  set tradeType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTradeType() => $_has(4);
  @$pb.TagNumber(5)
  void clearTradeType() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isBuy => $_getBF(5);
  @$pb.TagNumber(6)
  set isBuy($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIsBuy() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsBuy() => $_clearField(6);

  /// Order references
  @$pb.TagNumber(7)
  $core.String get bidOrderId => $_getSZ(6);
  @$pb.TagNumber(7)
  set bidOrderId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBidOrderId() => $_has(6);
  @$pb.TagNumber(7)
  void clearBidOrderId() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get askOrderId => $_getSZ(7);
  @$pb.TagNumber(8)
  set askOrderId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasAskOrderId() => $_has(7);
  @$pb.TagNumber(8)
  void clearAskOrderId() => $_clearField(8);

  /// Trade details
  @$pb.TagNumber(9)
  $core.String get quantity => $_getSZ(8);
  @$pb.TagNumber(9)
  set quantity($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasQuantity() => $_has(8);
  @$pb.TagNumber(9)
  void clearQuantity() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get price => $_getSZ(9);
  @$pb.TagNumber(10)
  set price($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasPrice() => $_has(9);
  @$pb.TagNumber(10)
  void clearPrice() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get volume => $_getSZ(10);
  @$pb.TagNumber(11)
  set volume($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasVolume() => $_has(10);
  @$pb.TagNumber(11)
  void clearVolume() => $_clearField(11);

  /// Fees
  @$pb.TagNumber(12)
  $core.String get bidFee => $_getSZ(11);
  @$pb.TagNumber(12)
  set bidFee($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasBidFee() => $_has(11);
  @$pb.TagNumber(12)
  void clearBidFee() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get askFee => $_getSZ(12);
  @$pb.TagNumber(13)
  set askFee($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasAskFee() => $_has(12);
  @$pb.TagNumber(13)
  void clearAskFee() => $_clearField(13);

  /// Additional data
  @$pb.TagNumber(14)
  $core.String get dataAbi => $_getSZ(13);
  @$pb.TagNumber(14)
  set dataAbi($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasDataAbi() => $_has(13);
  @$pb.TagNumber(14)
  void clearDataAbi() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get data => $_getSZ(14);
  @$pb.TagNumber(15)
  set data($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasData() => $_has(14);
  @$pb.TagNumber(15)
  void clearData() => $_clearField(15);
}

class Settlement extends $pb.GeneratedMessage {
  factory Settlement({
    $core.String? settlementId,
    $core.String? settlementHash,
    $core.String? timestamp,
    $core.String? tradeId,
    $core.String? tradeHash,
    ConfirmationStatus? confirmationStatus,
    $core.String? settlementType,
    $core.String? buyerAccount,
    $core.String? sellerAccount,
    $core.String? assetTransferred,
    $core.String? amountTransferred,
    $core.String? currencyTransferred,
    $core.String? currencyAmount,
    $core.String? ledgerId,
    $core.String? vaultAddress,
    $core.String? reserveId,
    $core.String? failureReason,
    $core.String? data,
  }) {
    final result = create();
    if (settlementId != null) result.settlementId = settlementId;
    if (settlementHash != null) result.settlementHash = settlementHash;
    if (timestamp != null) result.timestamp = timestamp;
    if (tradeId != null) result.tradeId = tradeId;
    if (tradeHash != null) result.tradeHash = tradeHash;
    if (confirmationStatus != null)
      result.confirmationStatus = confirmationStatus;
    if (settlementType != null) result.settlementType = settlementType;
    if (buyerAccount != null) result.buyerAccount = buyerAccount;
    if (sellerAccount != null) result.sellerAccount = sellerAccount;
    if (assetTransferred != null) result.assetTransferred = assetTransferred;
    if (amountTransferred != null) result.amountTransferred = amountTransferred;
    if (currencyTransferred != null)
      result.currencyTransferred = currencyTransferred;
    if (currencyAmount != null) result.currencyAmount = currencyAmount;
    if (ledgerId != null) result.ledgerId = ledgerId;
    if (vaultAddress != null) result.vaultAddress = vaultAddress;
    if (reserveId != null) result.reserveId = reserveId;
    if (failureReason != null) result.failureReason = failureReason;
    if (data != null) result.data = data;
    return result;
  }

  Settlement._();

  factory Settlement.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Settlement.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Settlement',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'settlementId')
    ..aOS(2, _omitFieldNames ? '' : 'settlementHash')
    ..aOS(3, _omitFieldNames ? '' : 'timestamp')
    ..aOS(4, _omitFieldNames ? '' : 'tradeId')
    ..aOS(5, _omitFieldNames ? '' : 'tradeHash')
    ..e<ConfirmationStatus>(
        6, _omitFieldNames ? '' : 'confirmationStatus', $pb.PbFieldType.OE,
        defaultOrMaker: ConfirmationStatus.CONFIRMATION_STATUS__UNKNOWN,
        valueOf: ConfirmationStatus.valueOf,
        enumValues: ConfirmationStatus.values)
    ..aOS(7, _omitFieldNames ? '' : 'settlementType')
    ..aOS(8, _omitFieldNames ? '' : 'buyerAccount')
    ..aOS(9, _omitFieldNames ? '' : 'sellerAccount')
    ..aOS(10, _omitFieldNames ? '' : 'assetTransferred')
    ..aOS(11, _omitFieldNames ? '' : 'amountTransferred')
    ..aOS(12, _omitFieldNames ? '' : 'currencyTransferred')
    ..aOS(13, _omitFieldNames ? '' : 'currencyAmount')
    ..aOS(14, _omitFieldNames ? '' : 'ledgerId')
    ..aOS(15, _omitFieldNames ? '' : 'vaultAddress')
    ..aOS(16, _omitFieldNames ? '' : 'reserveId')
    ..aOS(17, _omitFieldNames ? '' : 'failureReason')
    ..aOS(18, _omitFieldNames ? '' : 'data')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Settlement clone() => Settlement()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Settlement copyWith(void Function(Settlement) updates) =>
      super.copyWith((message) => updates(message as Settlement)) as Settlement;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Settlement create() => Settlement._();
  @$core.override
  Settlement createEmptyInstance() => create();
  static $pb.PbList<Settlement> createRepeated() => $pb.PbList<Settlement>();
  @$core.pragma('dart2js:noInline')
  static Settlement getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Settlement>(create);
  static Settlement? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get settlementId => $_getSZ(0);
  @$pb.TagNumber(1)
  set settlementId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSettlementId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSettlementId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get settlementHash => $_getSZ(1);
  @$pb.TagNumber(2)
  set settlementHash($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSettlementHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearSettlementHash() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get timestamp => $_getSZ(2);
  @$pb.TagNumber(3)
  set timestamp($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => $_clearField(3);

  /// Trade reference
  @$pb.TagNumber(4)
  $core.String get tradeId => $_getSZ(3);
  @$pb.TagNumber(4)
  set tradeId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTradeId() => $_has(3);
  @$pb.TagNumber(4)
  void clearTradeId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get tradeHash => $_getSZ(4);
  @$pb.TagNumber(5)
  set tradeHash($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTradeHash() => $_has(4);
  @$pb.TagNumber(5)
  void clearTradeHash() => $_clearField(5);

  /// Settlement status
  @$pb.TagNumber(6)
  ConfirmationStatus get confirmationStatus => $_getN(5);
  @$pb.TagNumber(6)
  set confirmationStatus(ConfirmationStatus value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasConfirmationStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearConfirmationStatus() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get settlementType => $_getSZ(6);
  @$pb.TagNumber(7)
  set settlementType($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSettlementType() => $_has(6);
  @$pb.TagNumber(7)
  void clearSettlementType() => $_clearField(7);

  /// Parties involved
  @$pb.TagNumber(8)
  $core.String get buyerAccount => $_getSZ(7);
  @$pb.TagNumber(8)
  set buyerAccount($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasBuyerAccount() => $_has(7);
  @$pb.TagNumber(8)
  void clearBuyerAccount() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get sellerAccount => $_getSZ(8);
  @$pb.TagNumber(9)
  set sellerAccount($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasSellerAccount() => $_has(8);
  @$pb.TagNumber(9)
  void clearSellerAccount() => $_clearField(9);

  /// Settlement details
  @$pb.TagNumber(10)
  $core.String get assetTransferred => $_getSZ(9);
  @$pb.TagNumber(10)
  set assetTransferred($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasAssetTransferred() => $_has(9);
  @$pb.TagNumber(10)
  void clearAssetTransferred() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get amountTransferred => $_getSZ(10);
  @$pb.TagNumber(11)
  set amountTransferred($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasAmountTransferred() => $_has(10);
  @$pb.TagNumber(11)
  void clearAmountTransferred() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get currencyTransferred => $_getSZ(11);
  @$pb.TagNumber(12)
  set currencyTransferred($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCurrencyTransferred() => $_has(11);
  @$pb.TagNumber(12)
  void clearCurrencyTransferred() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get currencyAmount => $_getSZ(12);
  @$pb.TagNumber(13)
  set currencyAmount($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasCurrencyAmount() => $_has(12);
  @$pb.TagNumber(13)
  void clearCurrencyAmount() => $_clearField(13);

  /// Settlement location
  @$pb.TagNumber(14)
  $core.String get ledgerId => $_getSZ(13);
  @$pb.TagNumber(14)
  set ledgerId($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasLedgerId() => $_has(13);
  @$pb.TagNumber(14)
  void clearLedgerId() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get vaultAddress => $_getSZ(14);
  @$pb.TagNumber(15)
  set vaultAddress($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasVaultAddress() => $_has(14);
  @$pb.TagNumber(15)
  void clearVaultAddress() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get reserveId => $_getSZ(15);
  @$pb.TagNumber(16)
  set reserveId($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasReserveId() => $_has(15);
  @$pb.TagNumber(16)
  void clearReserveId() => $_clearField(16);

  /// Additional data
  @$pb.TagNumber(17)
  $core.String get failureReason => $_getSZ(16);
  @$pb.TagNumber(17)
  set failureReason($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasFailureReason() => $_has(16);
  @$pb.TagNumber(17)
  void clearFailureReason() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get data => $_getSZ(17);
  @$pb.TagNumber(18)
  set data($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasData() => $_has(17);
  @$pb.TagNumber(18)
  void clearData() => $_clearField(18);
}

class OrderEvent extends $pb.GeneratedMessage {
  factory OrderEvent({
    $core.String? orderEventId,
    $core.String? orderEventHash,
    $core.String? orderEventTimestamp,
    $core.String? orderEventType,
    $core.String? orderEventVersion,
    Order? order,
    Order? otherOrder,
    Trade? trade,
    $core.String? chainId,
    $core.String? chainName,
    $core.String? engineAddress,
    $core.String? indexTimestamp,
    $core.String? indexBlockTimestamp,
    $core.String? indexBlockNumber,
    $core.String? indexTxHash,
    $fixnum.Int64? indexTxLogIdx,
    $core.String? pairId,
    $core.String? pairBaseTokenSymbol,
    $core.String? pairQuoteTokenSymbol,
    $core.String? commandId,
    $core.String? commandRequestId,
    $core.String? commandTimestamp,
    $core.String? commandOrigin,
    $core.String? commandParticipantId,
    $core.String? commandOperation,
    $core.String? orderEventData,
  }) {
    final result = create();
    if (orderEventId != null) result.orderEventId = orderEventId;
    if (orderEventHash != null) result.orderEventHash = orderEventHash;
    if (orderEventTimestamp != null)
      result.orderEventTimestamp = orderEventTimestamp;
    if (orderEventType != null) result.orderEventType = orderEventType;
    if (orderEventVersion != null) result.orderEventVersion = orderEventVersion;
    if (order != null) result.order = order;
    if (otherOrder != null) result.otherOrder = otherOrder;
    if (trade != null) result.trade = trade;
    if (chainId != null) result.chainId = chainId;
    if (chainName != null) result.chainName = chainName;
    if (engineAddress != null) result.engineAddress = engineAddress;
    if (indexTimestamp != null) result.indexTimestamp = indexTimestamp;
    if (indexBlockTimestamp != null)
      result.indexBlockTimestamp = indexBlockTimestamp;
    if (indexBlockNumber != null) result.indexBlockNumber = indexBlockNumber;
    if (indexTxHash != null) result.indexTxHash = indexTxHash;
    if (indexTxLogIdx != null) result.indexTxLogIdx = indexTxLogIdx;
    if (pairId != null) result.pairId = pairId;
    if (pairBaseTokenSymbol != null)
      result.pairBaseTokenSymbol = pairBaseTokenSymbol;
    if (pairQuoteTokenSymbol != null)
      result.pairQuoteTokenSymbol = pairQuoteTokenSymbol;
    if (commandId != null) result.commandId = commandId;
    if (commandRequestId != null) result.commandRequestId = commandRequestId;
    if (commandTimestamp != null) result.commandTimestamp = commandTimestamp;
    if (commandOrigin != null) result.commandOrigin = commandOrigin;
    if (commandParticipantId != null)
      result.commandParticipantId = commandParticipantId;
    if (commandOperation != null) result.commandOperation = commandOperation;
    if (orderEventData != null) result.orderEventData = orderEventData;
    return result;
  }

  OrderEvent._();

  factory OrderEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OrderEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OrderEvent',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'orderEventId')
    ..aOS(2, _omitFieldNames ? '' : 'orderEventHash')
    ..aOS(3, _omitFieldNames ? '' : 'orderEventTimestamp')
    ..aOS(4, _omitFieldNames ? '' : 'orderEventType')
    ..aOS(5, _omitFieldNames ? '' : 'orderEventVersion')
    ..aOM<Order>(6, _omitFieldNames ? '' : 'order', subBuilder: Order.create)
    ..aOM<Order>(7, _omitFieldNames ? '' : 'otherOrder',
        subBuilder: Order.create)
    ..aOM<Trade>(8, _omitFieldNames ? '' : 'trade', subBuilder: Trade.create)
    ..aOS(9, _omitFieldNames ? '' : 'chainId')
    ..aOS(10, _omitFieldNames ? '' : 'chainName')
    ..aOS(11, _omitFieldNames ? '' : 'engineAddress')
    ..aOS(12, _omitFieldNames ? '' : 'indexTimestamp')
    ..aOS(13, _omitFieldNames ? '' : 'indexBlockTimestamp')
    ..aOS(14, _omitFieldNames ? '' : 'indexBlockNumber')
    ..aOS(15, _omitFieldNames ? '' : 'indexTxHash')
    ..aInt64(16, _omitFieldNames ? '' : 'indexTxLogIdx')
    ..aOS(17, _omitFieldNames ? '' : 'pairId')
    ..aOS(18, _omitFieldNames ? '' : 'pairBaseTokenSymbol')
    ..aOS(19, _omitFieldNames ? '' : 'pairQuoteTokenSymbol')
    ..aOS(20, _omitFieldNames ? '' : 'commandId')
    ..aOS(21, _omitFieldNames ? '' : 'commandRequestId')
    ..aOS(22, _omitFieldNames ? '' : 'commandTimestamp')
    ..aOS(23, _omitFieldNames ? '' : 'commandOrigin')
    ..aOS(24, _omitFieldNames ? '' : 'commandParticipantId')
    ..aOS(25, _omitFieldNames ? '' : 'commandOperation')
    ..aOS(26, _omitFieldNames ? '' : 'orderEventData')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OrderEvent clone() => OrderEvent()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OrderEvent copyWith(void Function(OrderEvent) updates) =>
      super.copyWith((message) => updates(message as OrderEvent)) as OrderEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OrderEvent create() => OrderEvent._();
  @$core.override
  OrderEvent createEmptyInstance() => create();
  static $pb.PbList<OrderEvent> createRepeated() => $pb.PbList<OrderEvent>();
  @$core.pragma('dart2js:noInline')
  static OrderEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OrderEvent>(create);
  static OrderEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get orderEventId => $_getSZ(0);
  @$pb.TagNumber(1)
  set orderEventId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOrderEventId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrderEventId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get orderEventHash => $_getSZ(1);
  @$pb.TagNumber(2)
  set orderEventHash($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOrderEventHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrderEventHash() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get orderEventTimestamp => $_getSZ(2);
  @$pb.TagNumber(3)
  set orderEventTimestamp($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOrderEventTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearOrderEventTimestamp() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get orderEventType => $_getSZ(3);
  @$pb.TagNumber(4)
  set orderEventType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOrderEventType() => $_has(3);
  @$pb.TagNumber(4)
  void clearOrderEventType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get orderEventVersion => $_getSZ(4);
  @$pb.TagNumber(5)
  set orderEventVersion($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasOrderEventVersion() => $_has(4);
  @$pb.TagNumber(5)
  void clearOrderEventVersion() => $_clearField(5);

  /// Order reference
  @$pb.TagNumber(6)
  Order get order => $_getN(5);
  @$pb.TagNumber(6)
  set order(Order value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasOrder() => $_has(5);
  @$pb.TagNumber(6)
  void clearOrder() => $_clearField(6);
  @$pb.TagNumber(6)
  Order ensureOrder() => $_ensure(5);

  @$pb.TagNumber(7)
  Order get otherOrder => $_getN(6);
  @$pb.TagNumber(7)
  set otherOrder(Order value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasOtherOrder() => $_has(6);
  @$pb.TagNumber(7)
  void clearOtherOrder() => $_clearField(7);
  @$pb.TagNumber(7)
  Order ensureOtherOrder() => $_ensure(6);

  /// Trade reference (if applicable)
  @$pb.TagNumber(8)
  Trade get trade => $_getN(7);
  @$pb.TagNumber(8)
  set trade(Trade value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasTrade() => $_has(7);
  @$pb.TagNumber(8)
  void clearTrade() => $_clearField(8);
  @$pb.TagNumber(8)
  Trade ensureTrade() => $_ensure(7);

  /// Chain and indexing information
  @$pb.TagNumber(9)
  $core.String get chainId => $_getSZ(8);
  @$pb.TagNumber(9)
  set chainId($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasChainId() => $_has(8);
  @$pb.TagNumber(9)
  void clearChainId() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get chainName => $_getSZ(9);
  @$pb.TagNumber(10)
  set chainName($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasChainName() => $_has(9);
  @$pb.TagNumber(10)
  void clearChainName() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get engineAddress => $_getSZ(10);
  @$pb.TagNumber(11)
  set engineAddress($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasEngineAddress() => $_has(10);
  @$pb.TagNumber(11)
  void clearEngineAddress() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get indexTimestamp => $_getSZ(11);
  @$pb.TagNumber(12)
  set indexTimestamp($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasIndexTimestamp() => $_has(11);
  @$pb.TagNumber(12)
  void clearIndexTimestamp() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get indexBlockTimestamp => $_getSZ(12);
  @$pb.TagNumber(13)
  set indexBlockTimestamp($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasIndexBlockTimestamp() => $_has(12);
  @$pb.TagNumber(13)
  void clearIndexBlockTimestamp() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get indexBlockNumber => $_getSZ(13);
  @$pb.TagNumber(14)
  set indexBlockNumber($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasIndexBlockNumber() => $_has(13);
  @$pb.TagNumber(14)
  void clearIndexBlockNumber() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get indexTxHash => $_getSZ(14);
  @$pb.TagNumber(15)
  set indexTxHash($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasIndexTxHash() => $_has(14);
  @$pb.TagNumber(15)
  void clearIndexTxHash() => $_clearField(15);

  @$pb.TagNumber(16)
  $fixnum.Int64 get indexTxLogIdx => $_getI64(15);
  @$pb.TagNumber(16)
  set indexTxLogIdx($fixnum.Int64 value) => $_setInt64(15, value);
  @$pb.TagNumber(16)
  $core.bool hasIndexTxLogIdx() => $_has(15);
  @$pb.TagNumber(16)
  void clearIndexTxLogIdx() => $_clearField(16);

  /// Pair information
  @$pb.TagNumber(17)
  $core.String get pairId => $_getSZ(16);
  @$pb.TagNumber(17)
  set pairId($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasPairId() => $_has(16);
  @$pb.TagNumber(17)
  void clearPairId() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get pairBaseTokenSymbol => $_getSZ(17);
  @$pb.TagNumber(18)
  set pairBaseTokenSymbol($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasPairBaseTokenSymbol() => $_has(17);
  @$pb.TagNumber(18)
  void clearPairBaseTokenSymbol() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get pairQuoteTokenSymbol => $_getSZ(18);
  @$pb.TagNumber(19)
  set pairQuoteTokenSymbol($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasPairQuoteTokenSymbol() => $_has(18);
  @$pb.TagNumber(19)
  void clearPairQuoteTokenSymbol() => $_clearField(19);

  /// Command information (for audit)
  @$pb.TagNumber(20)
  $core.String get commandId => $_getSZ(19);
  @$pb.TagNumber(20)
  set commandId($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasCommandId() => $_has(19);
  @$pb.TagNumber(20)
  void clearCommandId() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.String get commandRequestId => $_getSZ(20);
  @$pb.TagNumber(21)
  set commandRequestId($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasCommandRequestId() => $_has(20);
  @$pb.TagNumber(21)
  void clearCommandRequestId() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.String get commandTimestamp => $_getSZ(21);
  @$pb.TagNumber(22)
  set commandTimestamp($core.String value) => $_setString(21, value);
  @$pb.TagNumber(22)
  $core.bool hasCommandTimestamp() => $_has(21);
  @$pb.TagNumber(22)
  void clearCommandTimestamp() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.String get commandOrigin => $_getSZ(22);
  @$pb.TagNumber(23)
  set commandOrigin($core.String value) => $_setString(22, value);
  @$pb.TagNumber(23)
  $core.bool hasCommandOrigin() => $_has(22);
  @$pb.TagNumber(23)
  void clearCommandOrigin() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.String get commandParticipantId => $_getSZ(23);
  @$pb.TagNumber(24)
  set commandParticipantId($core.String value) => $_setString(23, value);
  @$pb.TagNumber(24)
  $core.bool hasCommandParticipantId() => $_has(23);
  @$pb.TagNumber(24)
  void clearCommandParticipantId() => $_clearField(24);

  @$pb.TagNumber(25)
  $core.String get commandOperation => $_getSZ(24);
  @$pb.TagNumber(25)
  set commandOperation($core.String value) => $_setString(24, value);
  @$pb.TagNumber(25)
  $core.bool hasCommandOperation() => $_has(24);
  @$pb.TagNumber(25)
  void clearCommandOperation() => $_clearField(25);

  /// Additional event data
  @$pb.TagNumber(26)
  $core.String get orderEventData => $_getSZ(25);
  @$pb.TagNumber(26)
  set orderEventData($core.String value) => $_setString(25, value);
  @$pb.TagNumber(26)
  $core.bool hasOrderEventData() => $_has(25);
  @$pb.TagNumber(26)
  void clearOrderEventData() => $_clearField(26);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
