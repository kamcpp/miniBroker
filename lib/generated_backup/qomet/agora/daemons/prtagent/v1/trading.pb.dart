// This is a generated file - do not edit.
//
// Generated from trading.proto.

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

class InstrumentQuote extends $pb.GeneratedMessage {
  factory InstrumentQuote({
    $2.Instrument? instrument,
    $core.String? amount,
  }) {
    final result = create();
    if (instrument != null) result.instrument = instrument;
    if (amount != null) result.amount = amount;
    return result;
  }

  InstrumentQuote._();

  factory InstrumentQuote.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InstrumentQuote.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InstrumentQuote',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOM<$2.Instrument>(1, _omitFieldNames ? '' : 'instrument',
        subBuilder: $2.Instrument.create)
    ..aOS(2, _omitFieldNames ? '' : 'amount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstrumentQuote clone() => InstrumentQuote()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstrumentQuote copyWith(void Function(InstrumentQuote) updates) =>
      super.copyWith((message) => updates(message as InstrumentQuote))
          as InstrumentQuote;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstrumentQuote create() => InstrumentQuote._();
  @$core.override
  InstrumentQuote createEmptyInstance() => create();
  static $pb.PbList<InstrumentQuote> createRepeated() =>
      $pb.PbList<InstrumentQuote>();
  @$core.pragma('dart2js:noInline')
  static InstrumentQuote getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InstrumentQuote>(create);
  static InstrumentQuote? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Instrument get instrument => $_getN(0);
  @$pb.TagNumber(1)
  set instrument($2.Instrument value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInstrument() => $_has(0);
  @$pb.TagNumber(1)
  void clearInstrument() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.Instrument ensureInstrument() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get amount => $_getSZ(1);
  @$pb.TagNumber(2)
  set amount($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);
}

class InstrumentQuoteResponse extends $pb.GeneratedMessage {
  factory InstrumentQuoteResponse({
    $core.String? refExecutionId,
    InstrumentQuote? quote,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (quote != null) result.quote = quote;
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  InstrumentQuoteResponse._();

  factory InstrumentQuoteResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InstrumentQuoteResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InstrumentQuoteResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<InstrumentQuote>(3, _omitFieldNames ? '' : 'quote',
        subBuilder: InstrumentQuote.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'InstrumentQuoteResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstrumentQuoteResponse clone() =>
      InstrumentQuoteResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstrumentQuoteResponse copyWith(
          void Function(InstrumentQuoteResponse) updates) =>
      super.copyWith((message) => updates(message as InstrumentQuoteResponse))
          as InstrumentQuoteResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstrumentQuoteResponse create() => InstrumentQuoteResponse._();
  @$core.override
  InstrumentQuoteResponse createEmptyInstance() => create();
  static $pb.PbList<InstrumentQuoteResponse> createRepeated() =>
      $pb.PbList<InstrumentQuoteResponse>();
  @$core.pragma('dart2js:noInline')
  static InstrumentQuoteResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InstrumentQuoteResponse>(create);
  static InstrumentQuoteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => $_clearField(1);

  @$pb.TagNumber(3)
  InstrumentQuote get quote => $_getN(1);
  @$pb.TagNumber(3)
  set quote(InstrumentQuote value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasQuote() => $_has(1);
  @$pb.TagNumber(3)
  void clearQuote() => $_clearField(3);
  @$pb.TagNumber(3)
  InstrumentQuote ensureQuote() => $_ensure(1);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(2);
}

class OhlcData extends $pb.GeneratedMessage {
  factory OhlcData({
    $2.Instrument? instrument,
    $1.Duration? duration,
    $core.String? open,
    $core.String? high,
    $core.String? low,
    $core.String? close,
    $core.String? volume,
  }) {
    final result = create();
    if (instrument != null) result.instrument = instrument;
    if (duration != null) result.duration = duration;
    if (open != null) result.open = open;
    if (high != null) result.high = high;
    if (low != null) result.low = low;
    if (close != null) result.close = close;
    if (volume != null) result.volume = volume;
    return result;
  }

  OhlcData._();

  factory OhlcData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OhlcData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OhlcData',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOM<$2.Instrument>(3, _omitFieldNames ? '' : 'instrument',
        subBuilder: $2.Instrument.create)
    ..aOM<$1.Duration>(4, _omitFieldNames ? '' : 'duration',
        subBuilder: $1.Duration.create)
    ..aOS(5, _omitFieldNames ? '' : 'open')
    ..aOS(6, _omitFieldNames ? '' : 'high')
    ..aOS(7, _omitFieldNames ? '' : 'low')
    ..aOS(8, _omitFieldNames ? '' : 'close')
    ..aOS(9, _omitFieldNames ? '' : 'volume')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OhlcData clone() => OhlcData()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OhlcData copyWith(void Function(OhlcData) updates) =>
      super.copyWith((message) => updates(message as OhlcData)) as OhlcData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OhlcData create() => OhlcData._();
  @$core.override
  OhlcData createEmptyInstance() => create();
  static $pb.PbList<OhlcData> createRepeated() => $pb.PbList<OhlcData>();
  @$core.pragma('dart2js:noInline')
  static OhlcData getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OhlcData>(create);
  static OhlcData? _defaultInstance;

  @$pb.TagNumber(3)
  $2.Instrument get instrument => $_getN(0);
  @$pb.TagNumber(3)
  set instrument($2.Instrument value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasInstrument() => $_has(0);
  @$pb.TagNumber(3)
  void clearInstrument() => $_clearField(3);
  @$pb.TagNumber(3)
  $2.Instrument ensureInstrument() => $_ensure(0);

  @$pb.TagNumber(4)
  $1.Duration get duration => $_getN(1);
  @$pb.TagNumber(4)
  set duration($1.Duration value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasDuration() => $_has(1);
  @$pb.TagNumber(4)
  void clearDuration() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Duration ensureDuration() => $_ensure(1);

  @$pb.TagNumber(5)
  $core.String get open => $_getSZ(2);
  @$pb.TagNumber(5)
  set open($core.String value) => $_setString(2, value);
  @$pb.TagNumber(5)
  $core.bool hasOpen() => $_has(2);
  @$pb.TagNumber(5)
  void clearOpen() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get high => $_getSZ(3);
  @$pb.TagNumber(6)
  set high($core.String value) => $_setString(3, value);
  @$pb.TagNumber(6)
  $core.bool hasHigh() => $_has(3);
  @$pb.TagNumber(6)
  void clearHigh() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get low => $_getSZ(4);
  @$pb.TagNumber(7)
  set low($core.String value) => $_setString(4, value);
  @$pb.TagNumber(7)
  $core.bool hasLow() => $_has(4);
  @$pb.TagNumber(7)
  void clearLow() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get close => $_getSZ(5);
  @$pb.TagNumber(8)
  set close($core.String value) => $_setString(5, value);
  @$pb.TagNumber(8)
  $core.bool hasClose() => $_has(5);
  @$pb.TagNumber(8)
  void clearClose() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get volume => $_getSZ(6);
  @$pb.TagNumber(9)
  set volume($core.String value) => $_setString(6, value);
  @$pb.TagNumber(9)
  $core.bool hasVolume() => $_has(6);
  @$pb.TagNumber(9)
  void clearVolume() => $_clearField(9);
}

class OhlcDataResponse extends $pb.GeneratedMessage {
  factory OhlcDataResponse({
    $core.String? refExecutionId,
    OhlcData? ohlcData,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (ohlcData != null) result.ohlcData = ohlcData;
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  OhlcDataResponse._();

  factory OhlcDataResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OhlcDataResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OhlcDataResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<OhlcData>(3, _omitFieldNames ? '' : 'ohlcData',
        subBuilder: OhlcData.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'OhlcDataResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OhlcDataResponse clone() => OhlcDataResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OhlcDataResponse copyWith(void Function(OhlcDataResponse) updates) =>
      super.copyWith((message) => updates(message as OhlcDataResponse))
          as OhlcDataResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OhlcDataResponse create() => OhlcDataResponse._();
  @$core.override
  OhlcDataResponse createEmptyInstance() => create();
  static $pb.PbList<OhlcDataResponse> createRepeated() =>
      $pb.PbList<OhlcDataResponse>();
  @$core.pragma('dart2js:noInline')
  static OhlcDataResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OhlcDataResponse>(create);
  static OhlcDataResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => $_clearField(1);

  @$pb.TagNumber(3)
  OhlcData get ohlcData => $_getN(1);
  @$pb.TagNumber(3)
  set ohlcData(OhlcData value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasOhlcData() => $_has(1);
  @$pb.TagNumber(3)
  void clearOhlcData() => $_clearField(3);
  @$pb.TagNumber(3)
  OhlcData ensureOhlcData() => $_ensure(1);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(2);
}

class GetLatestQuoteRequest extends $pb.GeneratedMessage {
  factory GetLatestQuoteRequest({
    $core.String? proposedExecutionId,
    $core.Iterable<$core.String>? instrumentIdAndSymbolRegexes,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (instrumentIdAndSymbolRegexes != null)
      result.instrumentIdAndSymbolRegexes.addAll(instrumentIdAndSymbolRegexes);
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  GetLatestQuoteRequest._();

  factory GetLatestQuoteRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetLatestQuoteRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetLatestQuoteRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..pPS(2, _omitFieldNames ? '' : 'instrumentIdAndSymbolRegexes')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'GetLatestQuoteRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLatestQuoteRequest clone() =>
      GetLatestQuoteRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLatestQuoteRequest copyWith(
          void Function(GetLatestQuoteRequest) updates) =>
      super.copyWith((message) => updates(message as GetLatestQuoteRequest))
          as GetLatestQuoteRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLatestQuoteRequest create() => GetLatestQuoteRequest._();
  @$core.override
  GetLatestQuoteRequest createEmptyInstance() => create();
  static $pb.PbList<GetLatestQuoteRequest> createRepeated() =>
      $pb.PbList<GetLatestQuoteRequest>();
  @$core.pragma('dart2js:noInline')
  static GetLatestQuoteRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetLatestQuoteRequest>(create);
  static GetLatestQuoteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get instrumentIdAndSymbolRegexes => $_getList(1);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(2);
}

class LiveQuoteFetchParams extends $pb.GeneratedMessage {
  factory LiveQuoteFetchParams({
    $core.int? updateIntervalMs,
    $core.int? maxDurationMs,
    $core.bool? includeDepth,
    $core.int? depthLevels,
    $core.bool? includeTrades,
  }) {
    final result = create();
    if (updateIntervalMs != null) result.updateIntervalMs = updateIntervalMs;
    if (maxDurationMs != null) result.maxDurationMs = maxDurationMs;
    if (includeDepth != null) result.includeDepth = includeDepth;
    if (depthLevels != null) result.depthLevels = depthLevels;
    if (includeTrades != null) result.includeTrades = includeTrades;
    return result;
  }

  LiveQuoteFetchParams._();

  factory LiveQuoteFetchParams.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LiveQuoteFetchParams.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LiveQuoteFetchParams',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1, _omitFieldNames ? '' : 'updateIntervalMs', $pb.PbFieldType.OU3)
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'maxDurationMs', $pb.PbFieldType.OU3)
    ..aOB(3, _omitFieldNames ? '' : 'includeDepth')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'depthLevels', $pb.PbFieldType.OU3)
    ..aOB(5, _omitFieldNames ? '' : 'includeTrades')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LiveQuoteFetchParams clone() =>
      LiveQuoteFetchParams()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LiveQuoteFetchParams copyWith(void Function(LiveQuoteFetchParams) updates) =>
      super.copyWith((message) => updates(message as LiveQuoteFetchParams))
          as LiveQuoteFetchParams;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LiveQuoteFetchParams create() => LiveQuoteFetchParams._();
  @$core.override
  LiveQuoteFetchParams createEmptyInstance() => create();
  static $pb.PbList<LiveQuoteFetchParams> createRepeated() =>
      $pb.PbList<LiveQuoteFetchParams>();
  @$core.pragma('dart2js:noInline')
  static LiveQuoteFetchParams getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LiveQuoteFetchParams>(create);
  static LiveQuoteFetchParams? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get updateIntervalMs => $_getIZ(0);
  @$pb.TagNumber(1)
  set updateIntervalMs($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUpdateIntervalMs() => $_has(0);
  @$pb.TagNumber(1)
  void clearUpdateIntervalMs() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get maxDurationMs => $_getIZ(1);
  @$pb.TagNumber(2)
  set maxDurationMs($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMaxDurationMs() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxDurationMs() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get includeDepth => $_getBF(2);
  @$pb.TagNumber(3)
  set includeDepth($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIncludeDepth() => $_has(2);
  @$pb.TagNumber(3)
  void clearIncludeDepth() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get depthLevels => $_getIZ(3);
  @$pb.TagNumber(4)
  set depthLevels($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDepthLevels() => $_has(3);
  @$pb.TagNumber(4)
  void clearDepthLevels() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get includeTrades => $_getBF(4);
  @$pb.TagNumber(5)
  set includeTrades($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIncludeTrades() => $_has(4);
  @$pb.TagNumber(5)
  void clearIncludeTrades() => $_clearField(5);
}

class FetchLiveQuoteRequest extends $pb.GeneratedMessage {
  factory FetchLiveQuoteRequest({
    $core.String? proposedExecutionId,
    $core.Iterable<$core.String>? instrumentIdAndSymbolRegexes,
    LiveQuoteFetchParams? fetchParams,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (instrumentIdAndSymbolRegexes != null)
      result.instrumentIdAndSymbolRegexes.addAll(instrumentIdAndSymbolRegexes);
    if (fetchParams != null) result.fetchParams = fetchParams;
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  FetchLiveQuoteRequest._();

  factory FetchLiveQuoteRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FetchLiveQuoteRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchLiveQuoteRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..pPS(2, _omitFieldNames ? '' : 'instrumentIdAndSymbolRegexes')
    ..aOM<LiveQuoteFetchParams>(3, _omitFieldNames ? '' : 'fetchParams',
        subBuilder: LiveQuoteFetchParams.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'FetchLiveQuoteRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchLiveQuoteRequest clone() =>
      FetchLiveQuoteRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchLiveQuoteRequest copyWith(
          void Function(FetchLiveQuoteRequest) updates) =>
      super.copyWith((message) => updates(message as FetchLiveQuoteRequest))
          as FetchLiveQuoteRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FetchLiveQuoteRequest create() => FetchLiveQuoteRequest._();
  @$core.override
  FetchLiveQuoteRequest createEmptyInstance() => create();
  static $pb.PbList<FetchLiveQuoteRequest> createRepeated() =>
      $pb.PbList<FetchLiveQuoteRequest>();
  @$core.pragma('dart2js:noInline')
  static FetchLiveQuoteRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchLiveQuoteRequest>(create);
  static FetchLiveQuoteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get instrumentIdAndSymbolRegexes => $_getList(1);

  @$pb.TagNumber(3)
  LiveQuoteFetchParams get fetchParams => $_getN(2);
  @$pb.TagNumber(3)
  set fetchParams(LiveQuoteFetchParams value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasFetchParams() => $_has(2);
  @$pb.TagNumber(3)
  void clearFetchParams() => $_clearField(3);
  @$pb.TagNumber(3)
  LiveQuoteFetchParams ensureFetchParams() => $_ensure(2);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(3);
}

class GetHistoricalQuoteRequest extends $pb.GeneratedMessage {
  factory GetHistoricalQuoteRequest({
    $core.String? proposedExecutionId,
    $1.PaginationParams? pagination,
    $core.Iterable<$core.String>? instrumentIdAndSymbolRegexes,
    $1.Duration? duration,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (pagination != null) result.pagination = pagination;
    if (instrumentIdAndSymbolRegexes != null)
      result.instrumentIdAndSymbolRegexes.addAll(instrumentIdAndSymbolRegexes);
    if (duration != null) result.duration = duration;
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  GetHistoricalQuoteRequest._();

  factory GetHistoricalQuoteRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetHistoricalQuoteRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetHistoricalQuoteRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..pPS(3, _omitFieldNames ? '' : 'instrumentIdAndSymbolRegexes')
    ..aOM<$1.Duration>(4, _omitFieldNames ? '' : 'duration',
        subBuilder: $1.Duration.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'GetHistoricalQuoteRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetHistoricalQuoteRequest clone() =>
      GetHistoricalQuoteRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetHistoricalQuoteRequest copyWith(
          void Function(GetHistoricalQuoteRequest) updates) =>
      super.copyWith((message) => updates(message as GetHistoricalQuoteRequest))
          as GetHistoricalQuoteRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetHistoricalQuoteRequest create() => GetHistoricalQuoteRequest._();
  @$core.override
  GetHistoricalQuoteRequest createEmptyInstance() => create();
  static $pb.PbList<GetHistoricalQuoteRequest> createRepeated() =>
      $pb.PbList<GetHistoricalQuoteRequest>();
  @$core.pragma('dart2js:noInline')
  static GetHistoricalQuoteRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetHistoricalQuoteRequest>(create);
  static GetHistoricalQuoteRequest? _defaultInstance;

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
  $1.Duration get duration => $_getN(3);
  @$pb.TagNumber(4)
  set duration($1.Duration value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasDuration() => $_has(3);
  @$pb.TagNumber(4)
  void clearDuration() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Duration ensureDuration() => $_ensure(3);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(4);
}

class GetHistoricalQuoteResponse extends $pb.GeneratedMessage {
  factory GetHistoricalQuoteResponse({
    $core.String? refExecutionId,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<InstrumentQuote>? quotes,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (quotes != null) result.quotes.addAll(quotes);
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  GetHistoricalQuoteResponse._();

  factory GetHistoricalQuoteResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetHistoricalQuoteResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetHistoricalQuoteResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<InstrumentQuote>(
        3, _omitFieldNames ? '' : 'quotes', $pb.PbFieldType.PM,
        subBuilder: InstrumentQuote.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'GetHistoricalQuoteResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetHistoricalQuoteResponse clone() =>
      GetHistoricalQuoteResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetHistoricalQuoteResponse copyWith(
          void Function(GetHistoricalQuoteResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetHistoricalQuoteResponse))
          as GetHistoricalQuoteResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetHistoricalQuoteResponse create() => GetHistoricalQuoteResponse._();
  @$core.override
  GetHistoricalQuoteResponse createEmptyInstance() => create();
  static $pb.PbList<GetHistoricalQuoteResponse> createRepeated() =>
      $pb.PbList<GetHistoricalQuoteResponse>();
  @$core.pragma('dart2js:noInline')
  static GetHistoricalQuoteResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetHistoricalQuoteResponse>(create);
  static GetHistoricalQuoteResponse? _defaultInstance;

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
  $pb.PbList<InstrumentQuote> get quotes => $_getList(2);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(3);
}

class LiveOhlcDataFetchParams extends $pb.GeneratedMessage {
  factory LiveOhlcDataFetchParams({
    $core.int? updateIntervalMs,
    $core.int? maxDurationMs,
    $core.String? period,
    $core.bool? includeVolume,
    $core.bool? includeIndicators,
  }) {
    final result = create();
    if (updateIntervalMs != null) result.updateIntervalMs = updateIntervalMs;
    if (maxDurationMs != null) result.maxDurationMs = maxDurationMs;
    if (period != null) result.period = period;
    if (includeVolume != null) result.includeVolume = includeVolume;
    if (includeIndicators != null) result.includeIndicators = includeIndicators;
    return result;
  }

  LiveOhlcDataFetchParams._();

  factory LiveOhlcDataFetchParams.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LiveOhlcDataFetchParams.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LiveOhlcDataFetchParams',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1, _omitFieldNames ? '' : 'updateIntervalMs', $pb.PbFieldType.OU3)
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'maxDurationMs', $pb.PbFieldType.OU3)
    ..aOS(3, _omitFieldNames ? '' : 'period')
    ..aOB(4, _omitFieldNames ? '' : 'includeVolume')
    ..aOB(5, _omitFieldNames ? '' : 'includeIndicators')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LiveOhlcDataFetchParams clone() =>
      LiveOhlcDataFetchParams()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LiveOhlcDataFetchParams copyWith(
          void Function(LiveOhlcDataFetchParams) updates) =>
      super.copyWith((message) => updates(message as LiveOhlcDataFetchParams))
          as LiveOhlcDataFetchParams;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LiveOhlcDataFetchParams create() => LiveOhlcDataFetchParams._();
  @$core.override
  LiveOhlcDataFetchParams createEmptyInstance() => create();
  static $pb.PbList<LiveOhlcDataFetchParams> createRepeated() =>
      $pb.PbList<LiveOhlcDataFetchParams>();
  @$core.pragma('dart2js:noInline')
  static LiveOhlcDataFetchParams getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LiveOhlcDataFetchParams>(create);
  static LiveOhlcDataFetchParams? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get updateIntervalMs => $_getIZ(0);
  @$pb.TagNumber(1)
  set updateIntervalMs($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUpdateIntervalMs() => $_has(0);
  @$pb.TagNumber(1)
  void clearUpdateIntervalMs() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get maxDurationMs => $_getIZ(1);
  @$pb.TagNumber(2)
  set maxDurationMs($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMaxDurationMs() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxDurationMs() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get period => $_getSZ(2);
  @$pb.TagNumber(3)
  set period($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPeriod() => $_has(2);
  @$pb.TagNumber(3)
  void clearPeriod() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get includeVolume => $_getBF(3);
  @$pb.TagNumber(4)
  set includeVolume($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIncludeVolume() => $_has(3);
  @$pb.TagNumber(4)
  void clearIncludeVolume() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get includeIndicators => $_getBF(4);
  @$pb.TagNumber(5)
  set includeIndicators($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIncludeIndicators() => $_has(4);
  @$pb.TagNumber(5)
  void clearIncludeIndicators() => $_clearField(5);
}

class FetchLiveOhlcDataRequest extends $pb.GeneratedMessage {
  factory FetchLiveOhlcDataRequest({
    $core.String? proposedExecutionId,
    $core.Iterable<$core.String>? instrumentIdAndSymbolRegexes,
    LiveOhlcDataFetchParams? fetchParams,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (instrumentIdAndSymbolRegexes != null)
      result.instrumentIdAndSymbolRegexes.addAll(instrumentIdAndSymbolRegexes);
    if (fetchParams != null) result.fetchParams = fetchParams;
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  FetchLiveOhlcDataRequest._();

  factory FetchLiveOhlcDataRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FetchLiveOhlcDataRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchLiveOhlcDataRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..pPS(2, _omitFieldNames ? '' : 'instrumentIdAndSymbolRegexes')
    ..aOM<LiveOhlcDataFetchParams>(3, _omitFieldNames ? '' : 'fetchParams',
        subBuilder: LiveOhlcDataFetchParams.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'FetchLiveOhlcDataRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchLiveOhlcDataRequest clone() =>
      FetchLiveOhlcDataRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchLiveOhlcDataRequest copyWith(
          void Function(FetchLiveOhlcDataRequest) updates) =>
      super.copyWith((message) => updates(message as FetchLiveOhlcDataRequest))
          as FetchLiveOhlcDataRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FetchLiveOhlcDataRequest create() => FetchLiveOhlcDataRequest._();
  @$core.override
  FetchLiveOhlcDataRequest createEmptyInstance() => create();
  static $pb.PbList<FetchLiveOhlcDataRequest> createRepeated() =>
      $pb.PbList<FetchLiveOhlcDataRequest>();
  @$core.pragma('dart2js:noInline')
  static FetchLiveOhlcDataRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchLiveOhlcDataRequest>(create);
  static FetchLiveOhlcDataRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get instrumentIdAndSymbolRegexes => $_getList(1);

  @$pb.TagNumber(3)
  LiveOhlcDataFetchParams get fetchParams => $_getN(2);
  @$pb.TagNumber(3)
  set fetchParams(LiveOhlcDataFetchParams value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasFetchParams() => $_has(2);
  @$pb.TagNumber(3)
  void clearFetchParams() => $_clearField(3);
  @$pb.TagNumber(3)
  LiveOhlcDataFetchParams ensureFetchParams() => $_ensure(2);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(3);
}

class GetHistoricalOhlcDataRequest extends $pb.GeneratedMessage {
  factory GetHistoricalOhlcDataRequest({
    $core.String? proposedExecutionId,
    $1.PaginationParams? pagination,
    $core.Iterable<$core.String>? instrumentIdAndSymbolRegexes,
    $1.Duration? duration,
    $core.String? period,
    $core.bool? includeVolume,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (pagination != null) result.pagination = pagination;
    if (instrumentIdAndSymbolRegexes != null)
      result.instrumentIdAndSymbolRegexes.addAll(instrumentIdAndSymbolRegexes);
    if (duration != null) result.duration = duration;
    if (period != null) result.period = period;
    if (includeVolume != null) result.includeVolume = includeVolume;
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  GetHistoricalOhlcDataRequest._();

  factory GetHistoricalOhlcDataRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetHistoricalOhlcDataRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetHistoricalOhlcDataRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..pPS(3, _omitFieldNames ? '' : 'instrumentIdAndSymbolRegexes')
    ..aOM<$1.Duration>(4, _omitFieldNames ? '' : 'duration',
        subBuilder: $1.Duration.create)
    ..aOS(5, _omitFieldNames ? '' : 'period')
    ..aOB(6, _omitFieldNames ? '' : 'includeVolume')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'GetHistoricalOhlcDataRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetHistoricalOhlcDataRequest clone() =>
      GetHistoricalOhlcDataRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetHistoricalOhlcDataRequest copyWith(
          void Function(GetHistoricalOhlcDataRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetHistoricalOhlcDataRequest))
          as GetHistoricalOhlcDataRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetHistoricalOhlcDataRequest create() =>
      GetHistoricalOhlcDataRequest._();
  @$core.override
  GetHistoricalOhlcDataRequest createEmptyInstance() => create();
  static $pb.PbList<GetHistoricalOhlcDataRequest> createRepeated() =>
      $pb.PbList<GetHistoricalOhlcDataRequest>();
  @$core.pragma('dart2js:noInline')
  static GetHistoricalOhlcDataRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetHistoricalOhlcDataRequest>(create);
  static GetHistoricalOhlcDataRequest? _defaultInstance;

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
  $1.Duration get duration => $_getN(3);
  @$pb.TagNumber(4)
  set duration($1.Duration value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasDuration() => $_has(3);
  @$pb.TagNumber(4)
  void clearDuration() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Duration ensureDuration() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get period => $_getSZ(4);
  @$pb.TagNumber(5)
  set period($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPeriod() => $_has(4);
  @$pb.TagNumber(5)
  void clearPeriod() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get includeVolume => $_getBF(5);
  @$pb.TagNumber(6)
  set includeVolume($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIncludeVolume() => $_has(5);
  @$pb.TagNumber(6)
  void clearIncludeVolume() => $_clearField(6);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(6);
}

class GetHistoricalOhlcDataResponse extends $pb.GeneratedMessage {
  factory GetHistoricalOhlcDataResponse({
    $core.String? refExecutionId,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<OhlcData>? ohlcDatas,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (ohlcDatas != null) result.ohlcDatas.addAll(ohlcDatas);
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  GetHistoricalOhlcDataResponse._();

  factory GetHistoricalOhlcDataResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetHistoricalOhlcDataResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetHistoricalOhlcDataResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<OhlcData>(3, _omitFieldNames ? '' : 'ohlcDatas', $pb.PbFieldType.PM,
        subBuilder: OhlcData.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'GetHistoricalOhlcDataResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetHistoricalOhlcDataResponse clone() =>
      GetHistoricalOhlcDataResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetHistoricalOhlcDataResponse copyWith(
          void Function(GetHistoricalOhlcDataResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetHistoricalOhlcDataResponse))
          as GetHistoricalOhlcDataResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetHistoricalOhlcDataResponse create() =>
      GetHistoricalOhlcDataResponse._();
  @$core.override
  GetHistoricalOhlcDataResponse createEmptyInstance() => create();
  static $pb.PbList<GetHistoricalOhlcDataResponse> createRepeated() =>
      $pb.PbList<GetHistoricalOhlcDataResponse>();
  @$core.pragma('dart2js:noInline')
  static GetHistoricalOhlcDataResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetHistoricalOhlcDataResponse>(create);
  static GetHistoricalOhlcDataResponse? _defaultInstance;

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
  $pb.PbList<OhlcData> get ohlcDatas => $_getList(2);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(3);
}

class FeeStructure extends $pb.GeneratedMessage {
  factory FeeStructure({
    $core.String? baseFee,
    $core.String? percentageFee,
    $core.String? minimumFee,
    $core.String? maximumFee,
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

  @$pb.TagNumber(6)
  $core.String get makerFee => $_getSZ(4);
  @$pb.TagNumber(6)
  set makerFee($core.String value) => $_setString(4, value);
  @$pb.TagNumber(6)
  $core.bool hasMakerFee() => $_has(4);
  @$pb.TagNumber(6)
  void clearMakerFee() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get takerFee => $_getSZ(5);
  @$pb.TagNumber(7)
  set takerFee($core.String value) => $_setString(5, value);
  @$pb.TagNumber(7)
  $core.bool hasTakerFee() => $_has(5);
  @$pb.TagNumber(7)
  void clearTakerFee() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(8)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(8)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(8)
  void clearCurrency() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get feeTier => $_getSZ(7);
  @$pb.TagNumber(9)
  set feeTier($core.String value) => $_setString(7, value);
  @$pb.TagNumber(9)
  $core.bool hasFeeTier() => $_has(7);
  @$pb.TagNumber(9)
  void clearFeeTier() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get discountRate => $_getSZ(8);
  @$pb.TagNumber(10)
  set discountRate($core.String value) => $_setString(8, value);
  @$pb.TagNumber(10)
  $core.bool hasDiscountRate() => $_has(8);
  @$pb.TagNumber(10)
  void clearDiscountRate() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get totalEstimatedFee => $_getSZ(9);
  @$pb.TagNumber(11)
  set totalEstimatedFee($core.String value) => $_setString(9, value);
  @$pb.TagNumber(11)
  $core.bool hasTotalEstimatedFee() => $_has(9);
  @$pb.TagNumber(11)
  void clearTotalEstimatedFee() => $_clearField(11);
}

class GetOrderFeesRequest extends $pb.GeneratedMessage {
  factory GetOrderFeesRequest({
    $core.String? proposedExecutionId,
    $core.String? accountIid,
    $core.String? feePayerAccountIid,
    $core.String? instrumentListingIid,
    $core.String? orderType,
    $2.OrderSide? side,
    $core.String? quantity,
    $core.String? price,
    $core.String? timeInForce,
    $core.bool? isPostOnly,
    $core.bool? isReduceOnly,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (accountIid != null) result.accountIid = accountIid;
    if (feePayerAccountIid != null)
      result.feePayerAccountIid = feePayerAccountIid;
    if (instrumentListingIid != null)
      result.instrumentListingIid = instrumentListingIid;
    if (orderType != null) result.orderType = orderType;
    if (side != null) result.side = side;
    if (quantity != null) result.quantity = quantity;
    if (price != null) result.price = price;
    if (timeInForce != null) result.timeInForce = timeInForce;
    if (isPostOnly != null) result.isPostOnly = isPostOnly;
    if (isReduceOnly != null) result.isReduceOnly = isReduceOnly;
    if (auxData != null) result.auxData.addEntries(auxData);
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
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'accountIid')
    ..aOS(3, _omitFieldNames ? '' : 'feePayerAccountIid')
    ..aOS(4, _omitFieldNames ? '' : 'instrumentListingIid')
    ..aOS(5, _omitFieldNames ? '' : 'orderType')
    ..e<$2.OrderSide>(6, _omitFieldNames ? '' : 'side', $pb.PbFieldType.OE,
        defaultOrMaker: $2.OrderSide.ORDER_SIDE__UNKNOWN,
        valueOf: $2.OrderSide.valueOf,
        enumValues: $2.OrderSide.values)
    ..aOS(7, _omitFieldNames ? '' : 'quantity')
    ..aOS(8, _omitFieldNames ? '' : 'price')
    ..aOS(9, _omitFieldNames ? '' : 'timeInForce')
    ..aOB(10, _omitFieldNames ? '' : 'isPostOnly')
    ..aOB(11, _omitFieldNames ? '' : 'isReduceOnly')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'GetOrderFeesRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
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
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountIid($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountIid() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get feePayerAccountIid => $_getSZ(2);
  @$pb.TagNumber(3)
  set feePayerAccountIid($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFeePayerAccountIid() => $_has(2);
  @$pb.TagNumber(3)
  void clearFeePayerAccountIid() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get instrumentListingIid => $_getSZ(3);
  @$pb.TagNumber(4)
  set instrumentListingIid($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInstrumentListingIid() => $_has(3);
  @$pb.TagNumber(4)
  void clearInstrumentListingIid() => $_clearField(4);

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
  $2.OrderSide get side => $_getN(5);
  @$pb.TagNumber(6)
  set side($2.OrderSide value) => $_setField(6, value);
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
  $core.bool get isReduceOnly => $_getBF(10);
  @$pb.TagNumber(11)
  set isReduceOnly($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasIsReduceOnly() => $_has(10);
  @$pb.TagNumber(11)
  void clearIsReduceOnly() => $_clearField(11);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(11);
}

class GetOrderFeesResponse extends $pb.GeneratedMessage {
  factory GetOrderFeesResponse({
    $core.String? refExecutionId,
    FeeStructure? feeStructure,
    $core.Iterable<$core.String>? feeNotes,
    $1.DateTime? feeValidUntilDt,
    $core.String? msg,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? feeBreakdown,
    $core.Iterable<FeeStructure>? alternativeFeeOptions,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (feeStructure != null) result.feeStructure = feeStructure;
    if (feeNotes != null) result.feeNotes.addAll(feeNotes);
    if (feeValidUntilDt != null) result.feeValidUntilDt = feeValidUntilDt;
    if (msg != null) result.msg = msg;
    if (feeBreakdown != null) result.feeBreakdown.addEntries(feeBreakdown);
    if (alternativeFeeOptions != null)
      result.alternativeFeeOptions.addAll(alternativeFeeOptions);
    if (metadata != null) result.metadata.addEntries(metadata);
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
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<FeeStructure>(2, _omitFieldNames ? '' : 'feeStructure',
        subBuilder: FeeStructure.create)
    ..pPS(3, _omitFieldNames ? '' : 'feeNotes')
    ..aOM<$1.DateTime>(4, _omitFieldNames ? '' : 'feeValidUntilDt',
        subBuilder: $1.DateTime.create)
    ..aOS(5, _omitFieldNames ? '' : 'msg')
    ..m<$core.String, $core.String>(6, _omitFieldNames ? '' : 'feeBreakdown',
        entryClassName: 'GetOrderFeesResponse.FeeBreakdownEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..pc<FeeStructure>(
        7, _omitFieldNames ? '' : 'alternativeFeeOptions', $pb.PbFieldType.PM,
        subBuilder: FeeStructure.create)
    ..m<$core.String, $core.String>(8, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'GetOrderFeesResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
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
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => $_clearField(1);

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

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get feeNotes => $_getList(2);

  @$pb.TagNumber(4)
  $1.DateTime get feeValidUntilDt => $_getN(3);
  @$pb.TagNumber(4)
  set feeValidUntilDt($1.DateTime value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasFeeValidUntilDt() => $_has(3);
  @$pb.TagNumber(4)
  void clearFeeValidUntilDt() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.DateTime ensureFeeValidUntilDt() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get msg => $_getSZ(4);
  @$pb.TagNumber(5)
  set msg($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMsg() => $_has(4);
  @$pb.TagNumber(5)
  void clearMsg() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbMap<$core.String, $core.String> get feeBreakdown => $_getMap(5);

  @$pb.TagNumber(7)
  $pb.PbList<FeeStructure> get alternativeFeeOptions => $_getList(6);

  @$pb.TagNumber(8)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(7);
}

class CreateOrderAsyncRequest extends $pb.GeneratedMessage {
  factory CreateOrderAsyncRequest({
    $core.String? proposedExecutionId,
    $core.String? accountIid,
    $core.String? feePayerAccountIid,
    $core.String? instrumentListingIid,
    $core.String? orderType,
    $2.OrderSide? side,
    $core.String? quantity,
    $core.String? price,
    $core.String? timeInForce,
    $1.DateTime? expireDt,
    $core.String? participantOrderIid,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (accountIid != null) result.accountIid = accountIid;
    if (feePayerAccountIid != null)
      result.feePayerAccountIid = feePayerAccountIid;
    if (instrumentListingIid != null)
      result.instrumentListingIid = instrumentListingIid;
    if (orderType != null) result.orderType = orderType;
    if (side != null) result.side = side;
    if (quantity != null) result.quantity = quantity;
    if (price != null) result.price = price;
    if (timeInForce != null) result.timeInForce = timeInForce;
    if (expireDt != null) result.expireDt = expireDt;
    if (participantOrderIid != null)
      result.participantOrderIid = participantOrderIid;
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  CreateOrderAsyncRequest._();

  factory CreateOrderAsyncRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateOrderAsyncRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateOrderAsyncRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'accountIid')
    ..aOS(3, _omitFieldNames ? '' : 'feePayerAccountIid')
    ..aOS(4, _omitFieldNames ? '' : 'instrumentListingIid')
    ..aOS(5, _omitFieldNames ? '' : 'orderType')
    ..e<$2.OrderSide>(6, _omitFieldNames ? '' : 'side', $pb.PbFieldType.OE,
        defaultOrMaker: $2.OrderSide.ORDER_SIDE__UNKNOWN,
        valueOf: $2.OrderSide.valueOf,
        enumValues: $2.OrderSide.values)
    ..aOS(7, _omitFieldNames ? '' : 'quantity')
    ..aOS(8, _omitFieldNames ? '' : 'price')
    ..aOS(9, _omitFieldNames ? '' : 'timeInForce')
    ..aOM<$1.DateTime>(10, _omitFieldNames ? '' : 'expireDt',
        subBuilder: $1.DateTime.create)
    ..aOS(11, _omitFieldNames ? '' : 'participantOrderIid')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'CreateOrderAsyncRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateOrderAsyncRequest clone() =>
      CreateOrderAsyncRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateOrderAsyncRequest copyWith(
          void Function(CreateOrderAsyncRequest) updates) =>
      super.copyWith((message) => updates(message as CreateOrderAsyncRequest))
          as CreateOrderAsyncRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateOrderAsyncRequest create() => CreateOrderAsyncRequest._();
  @$core.override
  CreateOrderAsyncRequest createEmptyInstance() => create();
  static $pb.PbList<CreateOrderAsyncRequest> createRepeated() =>
      $pb.PbList<CreateOrderAsyncRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateOrderAsyncRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateOrderAsyncRequest>(create);
  static CreateOrderAsyncRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountIid($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountIid() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get feePayerAccountIid => $_getSZ(2);
  @$pb.TagNumber(3)
  set feePayerAccountIid($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFeePayerAccountIid() => $_has(2);
  @$pb.TagNumber(3)
  void clearFeePayerAccountIid() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get instrumentListingIid => $_getSZ(3);
  @$pb.TagNumber(4)
  set instrumentListingIid($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInstrumentListingIid() => $_has(3);
  @$pb.TagNumber(4)
  void clearInstrumentListingIid() => $_clearField(4);

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
  $2.OrderSide get side => $_getN(5);
  @$pb.TagNumber(6)
  set side($2.OrderSide value) => $_setField(6, value);
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
  $1.DateTime get expireDt => $_getN(9);
  @$pb.TagNumber(10)
  set expireDt($1.DateTime value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasExpireDt() => $_has(9);
  @$pb.TagNumber(10)
  void clearExpireDt() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.DateTime ensureExpireDt() => $_ensure(9);

  /// Additional parameters
  @$pb.TagNumber(11)
  $core.String get participantOrderIid => $_getSZ(10);
  @$pb.TagNumber(11)
  set participantOrderIid($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasParticipantOrderIid() => $_has(10);
  @$pb.TagNumber(11)
  void clearParticipantOrderIid() => $_clearField(11);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(11);
}

class ReplaceOrderAsyncRequest extends $pb.GeneratedMessage {
  factory ReplaceOrderAsyncRequest({
    $core.String? proposedExecutionId,
    $core.String? oldParticipantOrderId,
    $core.String? newParticipantOrderId,
    $core.String? newQuantity,
    $core.String? newPrice,
    $1.Time? newExpireTime,
    $core.String? reason,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (oldParticipantOrderId != null)
      result.oldParticipantOrderId = oldParticipantOrderId;
    if (newParticipantOrderId != null)
      result.newParticipantOrderId = newParticipantOrderId;
    if (newQuantity != null) result.newQuantity = newQuantity;
    if (newPrice != null) result.newPrice = newPrice;
    if (newExpireTime != null) result.newExpireTime = newExpireTime;
    if (reason != null) result.reason = reason;
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  ReplaceOrderAsyncRequest._();

  factory ReplaceOrderAsyncRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReplaceOrderAsyncRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReplaceOrderAsyncRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'oldParticipantOrderId')
    ..aOS(3, _omitFieldNames ? '' : 'newParticipantOrderId')
    ..aOS(4, _omitFieldNames ? '' : 'newQuantity')
    ..aOS(5, _omitFieldNames ? '' : 'newPrice')
    ..aOM<$1.Time>(6, _omitFieldNames ? '' : 'newExpireTime',
        subBuilder: $1.Time.create)
    ..aOS(7, _omitFieldNames ? '' : 'reason')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'ReplaceOrderAsyncRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReplaceOrderAsyncRequest clone() =>
      ReplaceOrderAsyncRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReplaceOrderAsyncRequest copyWith(
          void Function(ReplaceOrderAsyncRequest) updates) =>
      super.copyWith((message) => updates(message as ReplaceOrderAsyncRequest))
          as ReplaceOrderAsyncRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReplaceOrderAsyncRequest create() => ReplaceOrderAsyncRequest._();
  @$core.override
  ReplaceOrderAsyncRequest createEmptyInstance() => create();
  static $pb.PbList<ReplaceOrderAsyncRequest> createRepeated() =>
      $pb.PbList<ReplaceOrderAsyncRequest>();
  @$core.pragma('dart2js:noInline')
  static ReplaceOrderAsyncRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReplaceOrderAsyncRequest>(create);
  static ReplaceOrderAsyncRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get oldParticipantOrderId => $_getSZ(1);
  @$pb.TagNumber(2)
  set oldParticipantOrderId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOldParticipantOrderId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOldParticipantOrderId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get newParticipantOrderId => $_getSZ(2);
  @$pb.TagNumber(3)
  set newParticipantOrderId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNewParticipantOrderId() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewParticipantOrderId() => $_clearField(3);

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

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(7);
}

class CancelOrderAsyncRequest extends $pb.GeneratedMessage {
  factory CancelOrderAsyncRequest({
    $core.String? proposedExecutionId,
    $core.String? participantOrderId,
    $core.String? reason,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (participantOrderId != null)
      result.participantOrderId = participantOrderId;
    if (reason != null) result.reason = reason;
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  CancelOrderAsyncRequest._();

  factory CancelOrderAsyncRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelOrderAsyncRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelOrderAsyncRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'participantOrderId')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'CancelOrderAsyncRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelOrderAsyncRequest clone() =>
      CancelOrderAsyncRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelOrderAsyncRequest copyWith(
          void Function(CancelOrderAsyncRequest) updates) =>
      super.copyWith((message) => updates(message as CancelOrderAsyncRequest))
          as CancelOrderAsyncRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelOrderAsyncRequest create() => CancelOrderAsyncRequest._();
  @$core.override
  CancelOrderAsyncRequest createEmptyInstance() => create();
  static $pb.PbList<CancelOrderAsyncRequest> createRepeated() =>
      $pb.PbList<CancelOrderAsyncRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelOrderAsyncRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelOrderAsyncRequest>(create);
  static CancelOrderAsyncRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get participantOrderId => $_getSZ(1);
  @$pb.TagNumber(2)
  set participantOrderId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasParticipantOrderId() => $_has(1);
  @$pb.TagNumber(2)
  void clearParticipantOrderId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(3);
}

class GetOrderbookRequest extends $pb.GeneratedMessage {
  factory GetOrderbookRequest({
    $core.String? proposedExecutionId,
    $1.PaginationParams? pagination,
    $core.String? instrumentIid,
    $3.OrderbookQueryFilter? orderbookQueryFilter,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (pagination != null) result.pagination = pagination;
    if (instrumentIid != null) result.instrumentIid = instrumentIid;
    if (orderbookQueryFilter != null)
      result.orderbookQueryFilter = orderbookQueryFilter;
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  GetOrderbookRequest._();

  factory GetOrderbookRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOrderbookRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOrderbookRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..aOS(3, _omitFieldNames ? '' : 'instrumentIid')
    ..aOM<$3.OrderbookQueryFilter>(
        4, _omitFieldNames ? '' : 'orderbookQueryFilter',
        subBuilder: $3.OrderbookQueryFilter.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'GetOrderbookRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrderbookRequest clone() => GetOrderbookRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrderbookRequest copyWith(void Function(GetOrderbookRequest) updates) =>
      super.copyWith((message) => updates(message as GetOrderbookRequest))
          as GetOrderbookRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOrderbookRequest create() => GetOrderbookRequest._();
  @$core.override
  GetOrderbookRequest createEmptyInstance() => create();
  static $pb.PbList<GetOrderbookRequest> createRepeated() =>
      $pb.PbList<GetOrderbookRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOrderbookRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOrderbookRequest>(create);
  static GetOrderbookRequest? _defaultInstance;

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
  $core.String get instrumentIid => $_getSZ(2);
  @$pb.TagNumber(3)
  set instrumentIid($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInstrumentIid() => $_has(2);
  @$pb.TagNumber(3)
  void clearInstrumentIid() => $_clearField(3);

  @$pb.TagNumber(4)
  $3.OrderbookQueryFilter get orderbookQueryFilter => $_getN(3);
  @$pb.TagNumber(4)
  set orderbookQueryFilter($3.OrderbookQueryFilter value) =>
      $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasOrderbookQueryFilter() => $_has(3);
  @$pb.TagNumber(4)
  void clearOrderbookQueryFilter() => $_clearField(4);
  @$pb.TagNumber(4)
  $3.OrderbookQueryFilter ensureOrderbookQueryFilter() => $_ensure(3);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(4);
}

class GetOrderbookResponse extends $pb.GeneratedMessage {
  factory GetOrderbookResponse({
    $core.String? refExecutionId,
    $1.DateTime? generatedAtDt,
    $2.Instrument? instrument,
    $3.OrderList? buyList,
    $3.OrderList? sellList,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (generatedAtDt != null) result.generatedAtDt = generatedAtDt;
    if (instrument != null) result.instrument = instrument;
    if (buyList != null) result.buyList = buyList;
    if (sellList != null) result.sellList = sellList;
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  GetOrderbookResponse._();

  factory GetOrderbookResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOrderbookResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOrderbookResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.DateTime>(2, _omitFieldNames ? '' : 'generatedAtDt',
        subBuilder: $1.DateTime.create)
    ..aOM<$2.Instrument>(3, _omitFieldNames ? '' : 'instrument',
        subBuilder: $2.Instrument.create)
    ..aOM<$3.OrderList>(4, _omitFieldNames ? '' : 'buyList',
        subBuilder: $3.OrderList.create)
    ..aOM<$3.OrderList>(5, _omitFieldNames ? '' : 'sellList',
        subBuilder: $3.OrderList.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'GetOrderbookResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrderbookResponse clone() =>
      GetOrderbookResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrderbookResponse copyWith(void Function(GetOrderbookResponse) updates) =>
      super.copyWith((message) => updates(message as GetOrderbookResponse))
          as GetOrderbookResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOrderbookResponse create() => GetOrderbookResponse._();
  @$core.override
  GetOrderbookResponse createEmptyInstance() => create();
  static $pb.PbList<GetOrderbookResponse> createRepeated() =>
      $pb.PbList<GetOrderbookResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOrderbookResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOrderbookResponse>(create);
  static GetOrderbookResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.DateTime get generatedAtDt => $_getN(1);
  @$pb.TagNumber(2)
  set generatedAtDt($1.DateTime value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasGeneratedAtDt() => $_has(1);
  @$pb.TagNumber(2)
  void clearGeneratedAtDt() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.DateTime ensureGeneratedAtDt() => $_ensure(1);

  @$pb.TagNumber(3)
  $2.Instrument get instrument => $_getN(2);
  @$pb.TagNumber(3)
  set instrument($2.Instrument value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasInstrument() => $_has(2);
  @$pb.TagNumber(3)
  void clearInstrument() => $_clearField(3);
  @$pb.TagNumber(3)
  $2.Instrument ensureInstrument() => $_ensure(2);

  @$pb.TagNumber(4)
  $3.OrderList get buyList => $_getN(3);
  @$pb.TagNumber(4)
  set buyList($3.OrderList value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasBuyList() => $_has(3);
  @$pb.TagNumber(4)
  void clearBuyList() => $_clearField(4);
  @$pb.TagNumber(4)
  $3.OrderList ensureBuyList() => $_ensure(3);

  @$pb.TagNumber(5)
  $3.OrderList get sellList => $_getN(4);
  @$pb.TagNumber(5)
  set sellList($3.OrderList value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasSellList() => $_has(4);
  @$pb.TagNumber(5)
  void clearSellList() => $_clearField(5);
  @$pb.TagNumber(5)
  $3.OrderList ensureSellList() => $_ensure(4);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(5);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
