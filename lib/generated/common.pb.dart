// This is a generated file - do not edit.
//
// Generated from common.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'common.pbenum.dart';

class Blob extends $pb.GeneratedMessage {
  factory Blob({
    $core.String? encoding,
    $core.String? structType,
    $core.String? data,
  }) {
    final result = create();
    if (encoding != null) result.encoding = encoding;
    if (structType != null) result.structType = structType;
    if (data != null) result.data = data;
    return result;
  }

  Blob._();

  factory Blob.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Blob.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Blob',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'encoding')
    ..aOS(2, _omitFieldNames ? '' : 'structType')
    ..aOS(3, _omitFieldNames ? '' : 'data')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Blob clone() => Blob()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Blob copyWith(void Function(Blob) updates) =>
      super.copyWith((message) => updates(message as Blob)) as Blob;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Blob create() => Blob._();
  @$core.override
  Blob createEmptyInstance() => create();
  static $pb.PbList<Blob> createRepeated() => $pb.PbList<Blob>();
  @$core.pragma('dart2js:noInline')
  static Blob getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Blob>(create);
  static Blob? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get encoding => $_getSZ(0);
  @$pb.TagNumber(1)
  set encoding($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEncoding() => $_has(0);
  @$pb.TagNumber(1)
  void clearEncoding() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get structType => $_getSZ(1);
  @$pb.TagNumber(2)
  set structType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStructType() => $_has(1);
  @$pb.TagNumber(2)
  void clearStructType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get data => $_getSZ(2);
  @$pb.TagNumber(3)
  set data($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasData() => $_has(2);
  @$pb.TagNumber(3)
  void clearData() => $_clearField(3);
}

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

  @$pb.TagNumber(1)
  $core.int get hour => $_getIZ(0);
  @$pb.TagNumber(1)
  set hour($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHour() => $_has(0);
  @$pb.TagNumber(1)
  void clearHour() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get minute => $_getIZ(1);
  @$pb.TagNumber(2)
  set minute($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMinute() => $_has(1);
  @$pb.TagNumber(2)
  void clearMinute() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get second => $_getIZ(2);
  @$pb.TagNumber(3)
  set second($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSecond() => $_has(2);
  @$pb.TagNumber(3)
  void clearSecond() => $_clearField(3);

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
    $core.String? ts,
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
    ..aOS(2, _omitFieldNames ? '' : 'ts')
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
  $core.String get ts => $_getSZ(1);
  @$pb.TagNumber(2)
  set ts($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTs() => $_has(1);
  @$pb.TagNumber(2)
  void clearTs() => $_clearField(2);
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
    Time? startTime,
    Date? startDate,
    DateTime? startDt,
    Time? endTime,
    Date? endDate,
    DateTime? endDt,
    $core.String? displayName,
    $core.String? description,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? labels,
    $core.Iterable<$core.String>? tags,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (identifiers != null) result.identifiers.addAll(identifiers);
    if (names != null) result.names.addAll(names);
    if (startTime != null) result.startTime = startTime;
    if (startDate != null) result.startDate = startDate;
    if (startDt != null) result.startDt = startDt;
    if (endTime != null) result.endTime = endTime;
    if (endDate != null) result.endDate = endDate;
    if (endDt != null) result.endDt = endDt;
    if (displayName != null) result.displayName = displayName;
    if (description != null) result.description = description;
    if (labels != null) result.labels.addEntries(labels);
    if (tags != null) result.tags.addAll(tags);
    if (metadata != null) result.metadata.addEntries(metadata);
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
    ..aOM<Time>(5, _omitFieldNames ? '' : 'startTime', subBuilder: Time.create)
    ..aOM<Date>(6, _omitFieldNames ? '' : 'startDate', subBuilder: Date.create)
    ..aOM<DateTime>(7, _omitFieldNames ? '' : 'startDt',
        subBuilder: DateTime.create)
    ..aOM<Time>(8, _omitFieldNames ? '' : 'endTime', subBuilder: Time.create)
    ..aOM<Date>(9, _omitFieldNames ? '' : 'endDate', subBuilder: Date.create)
    ..aOM<DateTime>(10, _omitFieldNames ? '' : 'endDt',
        subBuilder: DateTime.create)
    ..aOS(101, _omitFieldNames ? '' : 'displayName')
    ..aOS(102, _omitFieldNames ? '' : 'description')
    ..m<$core.String, $core.String>(103, _omitFieldNames ? '' : 'labels',
        entryClassName: 'Duration.LabelsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..pPS(104, _omitFieldNames ? '' : 'tags')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'Duration.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
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

  @$pb.TagNumber(5)
  Time get startTime => $_getN(2);
  @$pb.TagNumber(5)
  set startTime(Time value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasStartTime() => $_has(2);
  @$pb.TagNumber(5)
  void clearStartTime() => $_clearField(5);
  @$pb.TagNumber(5)
  Time ensureStartTime() => $_ensure(2);

  @$pb.TagNumber(6)
  Date get startDate => $_getN(3);
  @$pb.TagNumber(6)
  set startDate(Date value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasStartDate() => $_has(3);
  @$pb.TagNumber(6)
  void clearStartDate() => $_clearField(6);
  @$pb.TagNumber(6)
  Date ensureStartDate() => $_ensure(3);

  @$pb.TagNumber(7)
  DateTime get startDt => $_getN(4);
  @$pb.TagNumber(7)
  set startDt(DateTime value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasStartDt() => $_has(4);
  @$pb.TagNumber(7)
  void clearStartDt() => $_clearField(7);
  @$pb.TagNumber(7)
  DateTime ensureStartDt() => $_ensure(4);

  @$pb.TagNumber(8)
  Time get endTime => $_getN(5);
  @$pb.TagNumber(8)
  set endTime(Time value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasEndTime() => $_has(5);
  @$pb.TagNumber(8)
  void clearEndTime() => $_clearField(8);
  @$pb.TagNumber(8)
  Time ensureEndTime() => $_ensure(5);

  @$pb.TagNumber(9)
  Date get endDate => $_getN(6);
  @$pb.TagNumber(9)
  set endDate(Date value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasEndDate() => $_has(6);
  @$pb.TagNumber(9)
  void clearEndDate() => $_clearField(9);
  @$pb.TagNumber(9)
  Date ensureEndDate() => $_ensure(6);

  @$pb.TagNumber(10)
  DateTime get endDt => $_getN(7);
  @$pb.TagNumber(10)
  set endDt(DateTime value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasEndDt() => $_has(7);
  @$pb.TagNumber(10)
  void clearEndDt() => $_clearField(10);
  @$pb.TagNumber(10)
  DateTime ensureEndDt() => $_ensure(7);

  @$pb.TagNumber(101)
  $core.String get displayName => $_getSZ(8);
  @$pb.TagNumber(101)
  set displayName($core.String value) => $_setString(8, value);
  @$pb.TagNumber(101)
  $core.bool hasDisplayName() => $_has(8);
  @$pb.TagNumber(101)
  void clearDisplayName() => $_clearField(101);

  @$pb.TagNumber(102)
  $core.String get description => $_getSZ(9);
  @$pb.TagNumber(102)
  set description($core.String value) => $_setString(9, value);
  @$pb.TagNumber(102)
  $core.bool hasDescription() => $_has(9);
  @$pb.TagNumber(102)
  void clearDescription() => $_clearField(102);

  @$pb.TagNumber(103)
  $pb.PbMap<$core.String, $core.String> get labels => $_getMap(10);

  @$pb.TagNumber(104)
  $pb.PbList<$core.String> get tags => $_getList(11);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(12);
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

  @$pb.TagNumber(1)
  $fixnum.Int64 get totalCount => $_getI64(0);
  @$pb.TagNumber(1)
  set totalCount($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalCount() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);
}

class StringValue extends $pb.GeneratedMessage {
  factory StringValue({
    $core.String? value,
    $core.bool? caseInsensitive,
    $core.String? encoding,
  }) {
    final result = create();
    if (value != null) result.value = value;
    if (caseInsensitive != null) result.caseInsensitive = caseInsensitive;
    if (encoding != null) result.encoding = encoding;
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
    ..aOS(3, _omitFieldNames ? '' : 'encoding')
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

  @$pb.TagNumber(3)
  $core.String get encoding => $_getSZ(2);
  @$pb.TagNumber(3)
  set encoding($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEncoding() => $_has(2);
  @$pb.TagNumber(3)
  void clearEncoding() => $_clearField(3);
}

class ExecutionAsyncResponse extends $pb.GeneratedMessage {
  factory ExecutionAsyncResponse({
    $core.String? id,
    $core.String? refExecutionId,
    DateTime? generatedAtDt,
    AsyncResponseStatusEnum? asyncStatus,
    $core.String? msg,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>?
        asyncResponseData,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (generatedAtDt != null) result.generatedAtDt = generatedAtDt;
    if (asyncStatus != null) result.asyncStatus = asyncStatus;
    if (msg != null) result.msg = msg;
    if (asyncResponseData != null)
      result.asyncResponseData.addEntries(asyncResponseData);
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  ExecutionAsyncResponse._();

  factory ExecutionAsyncResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExecutionAsyncResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExecutionAsyncResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<DateTime>(3, _omitFieldNames ? '' : 'generatedAtDt',
        subBuilder: DateTime.create)
    ..e<AsyncResponseStatusEnum>(
        4, _omitFieldNames ? '' : 'asyncStatus', $pb.PbFieldType.OE,
        defaultOrMaker: AsyncResponseStatusEnum.ASYNC_RESPONSE_STATUS__UNKNOWN,
        valueOf: AsyncResponseStatusEnum.valueOf,
        enumValues: AsyncResponseStatusEnum.values)
    ..aOS(5, _omitFieldNames ? '' : 'msg')
    ..m<$core.String, $core.String>(
        100, _omitFieldNames ? '' : 'asyncResponseData',
        entryClassName: 'ExecutionAsyncResponse.AsyncResponseDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(1001, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'ExecutionAsyncResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExecutionAsyncResponse clone() =>
      ExecutionAsyncResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExecutionAsyncResponse copyWith(
          void Function(ExecutionAsyncResponse) updates) =>
      super.copyWith((message) => updates(message as ExecutionAsyncResponse))
          as ExecutionAsyncResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExecutionAsyncResponse create() => ExecutionAsyncResponse._();
  @$core.override
  ExecutionAsyncResponse createEmptyInstance() => create();
  static $pb.PbList<ExecutionAsyncResponse> createRepeated() =>
      $pb.PbList<ExecutionAsyncResponse>();
  @$core.pragma('dart2js:noInline')
  static ExecutionAsyncResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExecutionAsyncResponse>(create);
  static ExecutionAsyncResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get refExecutionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set refExecutionId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRefExecutionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRefExecutionId() => $_clearField(2);

  @$pb.TagNumber(3)
  DateTime get generatedAtDt => $_getN(2);
  @$pb.TagNumber(3)
  set generatedAtDt(DateTime value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasGeneratedAtDt() => $_has(2);
  @$pb.TagNumber(3)
  void clearGeneratedAtDt() => $_clearField(3);
  @$pb.TagNumber(3)
  DateTime ensureGeneratedAtDt() => $_ensure(2);

  @$pb.TagNumber(4)
  AsyncResponseStatusEnum get asyncStatus => $_getN(3);
  @$pb.TagNumber(4)
  set asyncStatus(AsyncResponseStatusEnum value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasAsyncStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearAsyncStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get msg => $_getSZ(4);
  @$pb.TagNumber(5)
  set msg($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMsg() => $_has(4);
  @$pb.TagNumber(5)
  void clearMsg() => $_clearField(5);

  @$pb.TagNumber(100)
  $pb.PbMap<$core.String, $core.String> get asyncResponseData => $_getMap(5);

  @$pb.TagNumber(1001)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(6);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
