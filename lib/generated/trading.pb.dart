//
//  Generated code. Do not modify.
//  source: trading.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $1;
import 'filter.pb.dart' as $10;
import 'fin_common.pb.dart' as $9;
import 'fin_common.pbenum.dart' as $9;

class InstrumentQuote extends $pb.GeneratedMessage {
  factory InstrumentQuote({
    $9.Instrument? instrument,
    $core.String? amount,
  }) {
    final $result = create();
    if (instrument != null) {
      $result.instrument = instrument;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    return $result;
  }
  InstrumentQuote._() : super();
  factory InstrumentQuote.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InstrumentQuote.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InstrumentQuote', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOM<$9.Instrument>(1, _omitFieldNames ? '' : 'instrument', subBuilder: $9.Instrument.create)
    ..aOS(2, _omitFieldNames ? '' : 'amount')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InstrumentQuote clone() => InstrumentQuote()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InstrumentQuote copyWith(void Function(InstrumentQuote) updates) => super.copyWith((message) => updates(message as InstrumentQuote)) as InstrumentQuote;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstrumentQuote create() => InstrumentQuote._();
  InstrumentQuote createEmptyInstance() => create();
  static $pb.PbList<InstrumentQuote> createRepeated() => $pb.PbList<InstrumentQuote>();
  @$core.pragma('dart2js:noInline')
  static InstrumentQuote getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InstrumentQuote>(create);
  static InstrumentQuote? _defaultInstance;

  @$pb.TagNumber(1)
  $9.Instrument get instrument => $_getN(0);
  @$pb.TagNumber(1)
  set instrument($9.Instrument v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInstrument() => $_has(0);
  @$pb.TagNumber(1)
  void clearInstrument() => clearField(1);
  @$pb.TagNumber(1)
  $9.Instrument ensureInstrument() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get amount => $_getSZ(1);
  @$pb.TagNumber(2)
  set amount($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);
}

class InstrumentQuoteResponse extends $pb.GeneratedMessage {
  factory InstrumentQuoteResponse({
    $core.String? refExecutionId,
    InstrumentQuote? quote,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (refExecutionId != null) {
      $result.refExecutionId = refExecutionId;
    }
    if (quote != null) {
      $result.quote = quote;
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  InstrumentQuoteResponse._() : super();
  factory InstrumentQuoteResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InstrumentQuoteResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InstrumentQuoteResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<InstrumentQuote>(3, _omitFieldNames ? '' : 'quote', subBuilder: InstrumentQuote.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'InstrumentQuoteResponse.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InstrumentQuoteResponse clone() => InstrumentQuoteResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InstrumentQuoteResponse copyWith(void Function(InstrumentQuoteResponse) updates) => super.copyWith((message) => updates(message as InstrumentQuoteResponse)) as InstrumentQuoteResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstrumentQuoteResponse create() => InstrumentQuoteResponse._();
  InstrumentQuoteResponse createEmptyInstance() => create();
  static $pb.PbList<InstrumentQuoteResponse> createRepeated() => $pb.PbList<InstrumentQuoteResponse>();
  @$core.pragma('dart2js:noInline')
  static InstrumentQuoteResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InstrumentQuoteResponse>(create);
  static InstrumentQuoteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => clearField(1);

  @$pb.TagNumber(3)
  InstrumentQuote get quote => $_getN(1);
  @$pb.TagNumber(3)
  set quote(InstrumentQuote v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasQuote() => $_has(1);
  @$pb.TagNumber(3)
  void clearQuote() => clearField(3);
  @$pb.TagNumber(3)
  InstrumentQuote ensureQuote() => $_ensure(1);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(2);
}

class OhlcData extends $pb.GeneratedMessage {
  factory OhlcData({
    $9.Instrument? instrument,
    $1.Duration? duration,
    $core.String? open,
    $core.String? high,
    $core.String? low,
    $core.String? close,
    $core.String? volume,
  }) {
    final $result = create();
    if (instrument != null) {
      $result.instrument = instrument;
    }
    if (duration != null) {
      $result.duration = duration;
    }
    if (open != null) {
      $result.open = open;
    }
    if (high != null) {
      $result.high = high;
    }
    if (low != null) {
      $result.low = low;
    }
    if (close != null) {
      $result.close = close;
    }
    if (volume != null) {
      $result.volume = volume;
    }
    return $result;
  }
  OhlcData._() : super();
  factory OhlcData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OhlcData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OhlcData', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOM<$9.Instrument>(3, _omitFieldNames ? '' : 'instrument', subBuilder: $9.Instrument.create)
    ..aOM<$1.Duration>(4, _omitFieldNames ? '' : 'duration', subBuilder: $1.Duration.create)
    ..aOS(5, _omitFieldNames ? '' : 'open')
    ..aOS(6, _omitFieldNames ? '' : 'high')
    ..aOS(7, _omitFieldNames ? '' : 'low')
    ..aOS(8, _omitFieldNames ? '' : 'close')
    ..aOS(9, _omitFieldNames ? '' : 'volume')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OhlcData clone() => OhlcData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OhlcData copyWith(void Function(OhlcData) updates) => super.copyWith((message) => updates(message as OhlcData)) as OhlcData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OhlcData create() => OhlcData._();
  OhlcData createEmptyInstance() => create();
  static $pb.PbList<OhlcData> createRepeated() => $pb.PbList<OhlcData>();
  @$core.pragma('dart2js:noInline')
  static OhlcData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OhlcData>(create);
  static OhlcData? _defaultInstance;

  @$pb.TagNumber(3)
  $9.Instrument get instrument => $_getN(0);
  @$pb.TagNumber(3)
  set instrument($9.Instrument v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasInstrument() => $_has(0);
  @$pb.TagNumber(3)
  void clearInstrument() => clearField(3);
  @$pb.TagNumber(3)
  $9.Instrument ensureInstrument() => $_ensure(0);

  @$pb.TagNumber(4)
  $1.Duration get duration => $_getN(1);
  @$pb.TagNumber(4)
  set duration($1.Duration v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasDuration() => $_has(1);
  @$pb.TagNumber(4)
  void clearDuration() => clearField(4);
  @$pb.TagNumber(4)
  $1.Duration ensureDuration() => $_ensure(1);

  @$pb.TagNumber(5)
  $core.String get open => $_getSZ(2);
  @$pb.TagNumber(5)
  set open($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(5)
  $core.bool hasOpen() => $_has(2);
  @$pb.TagNumber(5)
  void clearOpen() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get high => $_getSZ(3);
  @$pb.TagNumber(6)
  set high($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(6)
  $core.bool hasHigh() => $_has(3);
  @$pb.TagNumber(6)
  void clearHigh() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get low => $_getSZ(4);
  @$pb.TagNumber(7)
  set low($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(7)
  $core.bool hasLow() => $_has(4);
  @$pb.TagNumber(7)
  void clearLow() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get close => $_getSZ(5);
  @$pb.TagNumber(8)
  set close($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(8)
  $core.bool hasClose() => $_has(5);
  @$pb.TagNumber(8)
  void clearClose() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get volume => $_getSZ(6);
  @$pb.TagNumber(9)
  set volume($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(9)
  $core.bool hasVolume() => $_has(6);
  @$pb.TagNumber(9)
  void clearVolume() => clearField(9);
}

class OhlcDataResponse extends $pb.GeneratedMessage {
  factory OhlcDataResponse({
    $core.String? refExecutionId,
    OhlcData? ohlcData,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (refExecutionId != null) {
      $result.refExecutionId = refExecutionId;
    }
    if (ohlcData != null) {
      $result.ohlcData = ohlcData;
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  OhlcDataResponse._() : super();
  factory OhlcDataResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OhlcDataResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OhlcDataResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<OhlcData>(3, _omitFieldNames ? '' : 'ohlcData', subBuilder: OhlcData.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'OhlcDataResponse.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OhlcDataResponse clone() => OhlcDataResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OhlcDataResponse copyWith(void Function(OhlcDataResponse) updates) => super.copyWith((message) => updates(message as OhlcDataResponse)) as OhlcDataResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OhlcDataResponse create() => OhlcDataResponse._();
  OhlcDataResponse createEmptyInstance() => create();
  static $pb.PbList<OhlcDataResponse> createRepeated() => $pb.PbList<OhlcDataResponse>();
  @$core.pragma('dart2js:noInline')
  static OhlcDataResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OhlcDataResponse>(create);
  static OhlcDataResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => clearField(1);

  @$pb.TagNumber(3)
  OhlcData get ohlcData => $_getN(1);
  @$pb.TagNumber(3)
  set ohlcData(OhlcData v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasOhlcData() => $_has(1);
  @$pb.TagNumber(3)
  void clearOhlcData() => clearField(3);
  @$pb.TagNumber(3)
  OhlcData ensureOhlcData() => $_ensure(1);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(2);
}

class GetLatestQuoteRequest extends $pb.GeneratedMessage {
  factory GetLatestQuoteRequest({
    $core.String? proposedExecutionId,
    $core.Iterable<$core.String>? instrumentIdAndSymbolRegexes,
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (instrumentIdAndSymbolRegexes != null) {
      $result.instrumentIdAndSymbolRegexes.addAll(instrumentIdAndSymbolRegexes);
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  GetLatestQuoteRequest._() : super();
  factory GetLatestQuoteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetLatestQuoteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetLatestQuoteRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..pPS(2, _omitFieldNames ? '' : 'instrumentIdAndSymbolRegexes')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'GetLatestQuoteRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetLatestQuoteRequest clone() => GetLatestQuoteRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetLatestQuoteRequest copyWith(void Function(GetLatestQuoteRequest) updates) => super.copyWith((message) => updates(message as GetLatestQuoteRequest)) as GetLatestQuoteRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLatestQuoteRequest create() => GetLatestQuoteRequest._();
  GetLatestQuoteRequest createEmptyInstance() => create();
  static $pb.PbList<GetLatestQuoteRequest> createRepeated() => $pb.PbList<GetLatestQuoteRequest>();
  @$core.pragma('dart2js:noInline')
  static GetLatestQuoteRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetLatestQuoteRequest>(create);
  static GetLatestQuoteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get instrumentIdAndSymbolRegexes => $_getList(1);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(2);
}

class LiveQuoteFetchParams extends $pb.GeneratedMessage {
  factory LiveQuoteFetchParams({
    $core.int? updateIntervalMs,
    $core.int? maxDurationMs,
    $core.bool? includeDepth,
    $core.int? depthLevels,
    $core.bool? includeTrades,
  }) {
    final $result = create();
    if (updateIntervalMs != null) {
      $result.updateIntervalMs = updateIntervalMs;
    }
    if (maxDurationMs != null) {
      $result.maxDurationMs = maxDurationMs;
    }
    if (includeDepth != null) {
      $result.includeDepth = includeDepth;
    }
    if (depthLevels != null) {
      $result.depthLevels = depthLevels;
    }
    if (includeTrades != null) {
      $result.includeTrades = includeTrades;
    }
    return $result;
  }
  LiveQuoteFetchParams._() : super();
  factory LiveQuoteFetchParams.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LiveQuoteFetchParams.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LiveQuoteFetchParams', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'updateIntervalMs', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'maxDurationMs', $pb.PbFieldType.OU3)
    ..aOB(3, _omitFieldNames ? '' : 'includeDepth')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'depthLevels', $pb.PbFieldType.OU3)
    ..aOB(5, _omitFieldNames ? '' : 'includeTrades')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LiveQuoteFetchParams clone() => LiveQuoteFetchParams()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LiveQuoteFetchParams copyWith(void Function(LiveQuoteFetchParams) updates) => super.copyWith((message) => updates(message as LiveQuoteFetchParams)) as LiveQuoteFetchParams;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LiveQuoteFetchParams create() => LiveQuoteFetchParams._();
  LiveQuoteFetchParams createEmptyInstance() => create();
  static $pb.PbList<LiveQuoteFetchParams> createRepeated() => $pb.PbList<LiveQuoteFetchParams>();
  @$core.pragma('dart2js:noInline')
  static LiveQuoteFetchParams getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LiveQuoteFetchParams>(create);
  static LiveQuoteFetchParams? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get updateIntervalMs => $_getIZ(0);
  @$pb.TagNumber(1)
  set updateIntervalMs($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUpdateIntervalMs() => $_has(0);
  @$pb.TagNumber(1)
  void clearUpdateIntervalMs() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get maxDurationMs => $_getIZ(1);
  @$pb.TagNumber(2)
  set maxDurationMs($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMaxDurationMs() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxDurationMs() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get includeDepth => $_getBF(2);
  @$pb.TagNumber(3)
  set includeDepth($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIncludeDepth() => $_has(2);
  @$pb.TagNumber(3)
  void clearIncludeDepth() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get depthLevels => $_getIZ(3);
  @$pb.TagNumber(4)
  set depthLevels($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDepthLevels() => $_has(3);
  @$pb.TagNumber(4)
  void clearDepthLevels() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get includeTrades => $_getBF(4);
  @$pb.TagNumber(5)
  set includeTrades($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIncludeTrades() => $_has(4);
  @$pb.TagNumber(5)
  void clearIncludeTrades() => clearField(5);
}

class FetchLiveQuoteRequest extends $pb.GeneratedMessage {
  factory FetchLiveQuoteRequest({
    $core.String? proposedExecutionId,
    $core.Iterable<$core.String>? instrumentIdAndSymbolRegexes,
    LiveQuoteFetchParams? fetchParams,
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (instrumentIdAndSymbolRegexes != null) {
      $result.instrumentIdAndSymbolRegexes.addAll(instrumentIdAndSymbolRegexes);
    }
    if (fetchParams != null) {
      $result.fetchParams = fetchParams;
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  FetchLiveQuoteRequest._() : super();
  factory FetchLiveQuoteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FetchLiveQuoteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FetchLiveQuoteRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..pPS(2, _omitFieldNames ? '' : 'instrumentIdAndSymbolRegexes')
    ..aOM<LiveQuoteFetchParams>(3, _omitFieldNames ? '' : 'fetchParams', subBuilder: LiveQuoteFetchParams.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'FetchLiveQuoteRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FetchLiveQuoteRequest clone() => FetchLiveQuoteRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FetchLiveQuoteRequest copyWith(void Function(FetchLiveQuoteRequest) updates) => super.copyWith((message) => updates(message as FetchLiveQuoteRequest)) as FetchLiveQuoteRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FetchLiveQuoteRequest create() => FetchLiveQuoteRequest._();
  FetchLiveQuoteRequest createEmptyInstance() => create();
  static $pb.PbList<FetchLiveQuoteRequest> createRepeated() => $pb.PbList<FetchLiveQuoteRequest>();
  @$core.pragma('dart2js:noInline')
  static FetchLiveQuoteRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FetchLiveQuoteRequest>(create);
  static FetchLiveQuoteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get instrumentIdAndSymbolRegexes => $_getList(1);

  @$pb.TagNumber(3)
  LiveQuoteFetchParams get fetchParams => $_getN(2);
  @$pb.TagNumber(3)
  set fetchParams(LiveQuoteFetchParams v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasFetchParams() => $_has(2);
  @$pb.TagNumber(3)
  void clearFetchParams() => clearField(3);
  @$pb.TagNumber(3)
  LiveQuoteFetchParams ensureFetchParams() => $_ensure(2);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(3);
}

class GetHistoricalQuoteRequest extends $pb.GeneratedMessage {
  factory GetHistoricalQuoteRequest({
    $core.String? proposedExecutionId,
    $1.PaginationParams? pagination,
    $core.Iterable<$core.String>? instrumentIdAndSymbolRegexes,
    $1.Duration? duration,
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    if (instrumentIdAndSymbolRegexes != null) {
      $result.instrumentIdAndSymbolRegexes.addAll(instrumentIdAndSymbolRegexes);
    }
    if (duration != null) {
      $result.duration = duration;
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  GetHistoricalQuoteRequest._() : super();
  factory GetHistoricalQuoteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetHistoricalQuoteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetHistoricalQuoteRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination', subBuilder: $1.PaginationParams.create)
    ..pPS(3, _omitFieldNames ? '' : 'instrumentIdAndSymbolRegexes')
    ..aOM<$1.Duration>(4, _omitFieldNames ? '' : 'duration', subBuilder: $1.Duration.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'GetHistoricalQuoteRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetHistoricalQuoteRequest clone() => GetHistoricalQuoteRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetHistoricalQuoteRequest copyWith(void Function(GetHistoricalQuoteRequest) updates) => super.copyWith((message) => updates(message as GetHistoricalQuoteRequest)) as GetHistoricalQuoteRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetHistoricalQuoteRequest create() => GetHistoricalQuoteRequest._();
  GetHistoricalQuoteRequest createEmptyInstance() => create();
  static $pb.PbList<GetHistoricalQuoteRequest> createRepeated() => $pb.PbList<GetHistoricalQuoteRequest>();
  @$core.pragma('dart2js:noInline')
  static GetHistoricalQuoteRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetHistoricalQuoteRequest>(create);
  static GetHistoricalQuoteRequest? _defaultInstance;

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
  $core.List<$core.String> get instrumentIdAndSymbolRegexes => $_getList(2);

  @$pb.TagNumber(4)
  $1.Duration get duration => $_getN(3);
  @$pb.TagNumber(4)
  set duration($1.Duration v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasDuration() => $_has(3);
  @$pb.TagNumber(4)
  void clearDuration() => clearField(4);
  @$pb.TagNumber(4)
  $1.Duration ensureDuration() => $_ensure(3);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(4);
}

class GetHistoricalQuoteResponse extends $pb.GeneratedMessage {
  factory GetHistoricalQuoteResponse({
    $core.String? refExecutionId,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<InstrumentQuote>? quotes,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (refExecutionId != null) {
      $result.refExecutionId = refExecutionId;
    }
    if (paginationInfo != null) {
      $result.paginationInfo = paginationInfo;
    }
    if (quotes != null) {
      $result.quotes.addAll(quotes);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  GetHistoricalQuoteResponse._() : super();
  factory GetHistoricalQuoteResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetHistoricalQuoteResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetHistoricalQuoteResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo', subBuilder: $1.PaginationInfo.create)
    ..pc<InstrumentQuote>(3, _omitFieldNames ? '' : 'quotes', $pb.PbFieldType.PM, subBuilder: InstrumentQuote.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'GetHistoricalQuoteResponse.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetHistoricalQuoteResponse clone() => GetHistoricalQuoteResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetHistoricalQuoteResponse copyWith(void Function(GetHistoricalQuoteResponse) updates) => super.copyWith((message) => updates(message as GetHistoricalQuoteResponse)) as GetHistoricalQuoteResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetHistoricalQuoteResponse create() => GetHistoricalQuoteResponse._();
  GetHistoricalQuoteResponse createEmptyInstance() => create();
  static $pb.PbList<GetHistoricalQuoteResponse> createRepeated() => $pb.PbList<GetHistoricalQuoteResponse>();
  @$core.pragma('dart2js:noInline')
  static GetHistoricalQuoteResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetHistoricalQuoteResponse>(create);
  static GetHistoricalQuoteResponse? _defaultInstance;

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
  $core.List<InstrumentQuote> get quotes => $_getList(2);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(3);
}

class LiveOhlcDataFetchParams extends $pb.GeneratedMessage {
  factory LiveOhlcDataFetchParams({
    $core.int? updateIntervalMs,
    $core.int? maxDurationMs,
    $core.String? period,
    $core.bool? includeVolume,
    $core.bool? includeIndicators,
  }) {
    final $result = create();
    if (updateIntervalMs != null) {
      $result.updateIntervalMs = updateIntervalMs;
    }
    if (maxDurationMs != null) {
      $result.maxDurationMs = maxDurationMs;
    }
    if (period != null) {
      $result.period = period;
    }
    if (includeVolume != null) {
      $result.includeVolume = includeVolume;
    }
    if (includeIndicators != null) {
      $result.includeIndicators = includeIndicators;
    }
    return $result;
  }
  LiveOhlcDataFetchParams._() : super();
  factory LiveOhlcDataFetchParams.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LiveOhlcDataFetchParams.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LiveOhlcDataFetchParams', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'updateIntervalMs', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'maxDurationMs', $pb.PbFieldType.OU3)
    ..aOS(3, _omitFieldNames ? '' : 'period')
    ..aOB(4, _omitFieldNames ? '' : 'includeVolume')
    ..aOB(5, _omitFieldNames ? '' : 'includeIndicators')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LiveOhlcDataFetchParams clone() => LiveOhlcDataFetchParams()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LiveOhlcDataFetchParams copyWith(void Function(LiveOhlcDataFetchParams) updates) => super.copyWith((message) => updates(message as LiveOhlcDataFetchParams)) as LiveOhlcDataFetchParams;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LiveOhlcDataFetchParams create() => LiveOhlcDataFetchParams._();
  LiveOhlcDataFetchParams createEmptyInstance() => create();
  static $pb.PbList<LiveOhlcDataFetchParams> createRepeated() => $pb.PbList<LiveOhlcDataFetchParams>();
  @$core.pragma('dart2js:noInline')
  static LiveOhlcDataFetchParams getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LiveOhlcDataFetchParams>(create);
  static LiveOhlcDataFetchParams? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get updateIntervalMs => $_getIZ(0);
  @$pb.TagNumber(1)
  set updateIntervalMs($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUpdateIntervalMs() => $_has(0);
  @$pb.TagNumber(1)
  void clearUpdateIntervalMs() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get maxDurationMs => $_getIZ(1);
  @$pb.TagNumber(2)
  set maxDurationMs($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMaxDurationMs() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxDurationMs() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get period => $_getSZ(2);
  @$pb.TagNumber(3)
  set period($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPeriod() => $_has(2);
  @$pb.TagNumber(3)
  void clearPeriod() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get includeVolume => $_getBF(3);
  @$pb.TagNumber(4)
  set includeVolume($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIncludeVolume() => $_has(3);
  @$pb.TagNumber(4)
  void clearIncludeVolume() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get includeIndicators => $_getBF(4);
  @$pb.TagNumber(5)
  set includeIndicators($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIncludeIndicators() => $_has(4);
  @$pb.TagNumber(5)
  void clearIncludeIndicators() => clearField(5);
}

class FetchLiveOhlcDataRequest extends $pb.GeneratedMessage {
  factory FetchLiveOhlcDataRequest({
    $core.String? proposedExecutionId,
    $core.Iterable<$core.String>? instrumentIdAndSymbolRegexes,
    LiveOhlcDataFetchParams? fetchParams,
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (instrumentIdAndSymbolRegexes != null) {
      $result.instrumentIdAndSymbolRegexes.addAll(instrumentIdAndSymbolRegexes);
    }
    if (fetchParams != null) {
      $result.fetchParams = fetchParams;
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  FetchLiveOhlcDataRequest._() : super();
  factory FetchLiveOhlcDataRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FetchLiveOhlcDataRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FetchLiveOhlcDataRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..pPS(2, _omitFieldNames ? '' : 'instrumentIdAndSymbolRegexes')
    ..aOM<LiveOhlcDataFetchParams>(3, _omitFieldNames ? '' : 'fetchParams', subBuilder: LiveOhlcDataFetchParams.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'FetchLiveOhlcDataRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FetchLiveOhlcDataRequest clone() => FetchLiveOhlcDataRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FetchLiveOhlcDataRequest copyWith(void Function(FetchLiveOhlcDataRequest) updates) => super.copyWith((message) => updates(message as FetchLiveOhlcDataRequest)) as FetchLiveOhlcDataRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FetchLiveOhlcDataRequest create() => FetchLiveOhlcDataRequest._();
  FetchLiveOhlcDataRequest createEmptyInstance() => create();
  static $pb.PbList<FetchLiveOhlcDataRequest> createRepeated() => $pb.PbList<FetchLiveOhlcDataRequest>();
  @$core.pragma('dart2js:noInline')
  static FetchLiveOhlcDataRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FetchLiveOhlcDataRequest>(create);
  static FetchLiveOhlcDataRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get instrumentIdAndSymbolRegexes => $_getList(1);

  @$pb.TagNumber(3)
  LiveOhlcDataFetchParams get fetchParams => $_getN(2);
  @$pb.TagNumber(3)
  set fetchParams(LiveOhlcDataFetchParams v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasFetchParams() => $_has(2);
  @$pb.TagNumber(3)
  void clearFetchParams() => clearField(3);
  @$pb.TagNumber(3)
  LiveOhlcDataFetchParams ensureFetchParams() => $_ensure(2);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(3);
}

class GetHistoricalOhlcDataRequest extends $pb.GeneratedMessage {
  factory GetHistoricalOhlcDataRequest({
    $core.String? proposedExecutionId,
    $1.PaginationParams? pagination,
    $core.Iterable<$core.String>? instrumentIdAndSymbolRegexes,
    $1.Duration? duration,
    $core.String? period,
    $core.bool? includeVolume,
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    if (instrumentIdAndSymbolRegexes != null) {
      $result.instrumentIdAndSymbolRegexes.addAll(instrumentIdAndSymbolRegexes);
    }
    if (duration != null) {
      $result.duration = duration;
    }
    if (period != null) {
      $result.period = period;
    }
    if (includeVolume != null) {
      $result.includeVolume = includeVolume;
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  GetHistoricalOhlcDataRequest._() : super();
  factory GetHistoricalOhlcDataRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetHistoricalOhlcDataRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetHistoricalOhlcDataRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination', subBuilder: $1.PaginationParams.create)
    ..pPS(3, _omitFieldNames ? '' : 'instrumentIdAndSymbolRegexes')
    ..aOM<$1.Duration>(4, _omitFieldNames ? '' : 'duration', subBuilder: $1.Duration.create)
    ..aOS(5, _omitFieldNames ? '' : 'period')
    ..aOB(6, _omitFieldNames ? '' : 'includeVolume')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'GetHistoricalOhlcDataRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetHistoricalOhlcDataRequest clone() => GetHistoricalOhlcDataRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetHistoricalOhlcDataRequest copyWith(void Function(GetHistoricalOhlcDataRequest) updates) => super.copyWith((message) => updates(message as GetHistoricalOhlcDataRequest)) as GetHistoricalOhlcDataRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetHistoricalOhlcDataRequest create() => GetHistoricalOhlcDataRequest._();
  GetHistoricalOhlcDataRequest createEmptyInstance() => create();
  static $pb.PbList<GetHistoricalOhlcDataRequest> createRepeated() => $pb.PbList<GetHistoricalOhlcDataRequest>();
  @$core.pragma('dart2js:noInline')
  static GetHistoricalOhlcDataRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetHistoricalOhlcDataRequest>(create);
  static GetHistoricalOhlcDataRequest? _defaultInstance;

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
  $core.List<$core.String> get instrumentIdAndSymbolRegexes => $_getList(2);

  @$pb.TagNumber(4)
  $1.Duration get duration => $_getN(3);
  @$pb.TagNumber(4)
  set duration($1.Duration v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasDuration() => $_has(3);
  @$pb.TagNumber(4)
  void clearDuration() => clearField(4);
  @$pb.TagNumber(4)
  $1.Duration ensureDuration() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get period => $_getSZ(4);
  @$pb.TagNumber(5)
  set period($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPeriod() => $_has(4);
  @$pb.TagNumber(5)
  void clearPeriod() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get includeVolume => $_getBF(5);
  @$pb.TagNumber(6)
  set includeVolume($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIncludeVolume() => $_has(5);
  @$pb.TagNumber(6)
  void clearIncludeVolume() => clearField(6);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(6);
}

class GetHistoricalOhlcDataResponse extends $pb.GeneratedMessage {
  factory GetHistoricalOhlcDataResponse({
    $core.String? refExecutionId,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<OhlcData>? ohlcDatas,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (refExecutionId != null) {
      $result.refExecutionId = refExecutionId;
    }
    if (paginationInfo != null) {
      $result.paginationInfo = paginationInfo;
    }
    if (ohlcDatas != null) {
      $result.ohlcDatas.addAll(ohlcDatas);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  GetHistoricalOhlcDataResponse._() : super();
  factory GetHistoricalOhlcDataResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetHistoricalOhlcDataResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetHistoricalOhlcDataResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo', subBuilder: $1.PaginationInfo.create)
    ..pc<OhlcData>(3, _omitFieldNames ? '' : 'ohlcDatas', $pb.PbFieldType.PM, subBuilder: OhlcData.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'GetHistoricalOhlcDataResponse.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetHistoricalOhlcDataResponse clone() => GetHistoricalOhlcDataResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetHistoricalOhlcDataResponse copyWith(void Function(GetHistoricalOhlcDataResponse) updates) => super.copyWith((message) => updates(message as GetHistoricalOhlcDataResponse)) as GetHistoricalOhlcDataResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetHistoricalOhlcDataResponse create() => GetHistoricalOhlcDataResponse._();
  GetHistoricalOhlcDataResponse createEmptyInstance() => create();
  static $pb.PbList<GetHistoricalOhlcDataResponse> createRepeated() => $pb.PbList<GetHistoricalOhlcDataResponse>();
  @$core.pragma('dart2js:noInline')
  static GetHistoricalOhlcDataResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetHistoricalOhlcDataResponse>(create);
  static GetHistoricalOhlcDataResponse? _defaultInstance;

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
  $core.List<OhlcData> get ohlcDatas => $_getList(2);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(3);
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
    final $result = create();
    if (baseFee != null) {
      $result.baseFee = baseFee;
    }
    if (percentageFee != null) {
      $result.percentageFee = percentageFee;
    }
    if (minimumFee != null) {
      $result.minimumFee = minimumFee;
    }
    if (maximumFee != null) {
      $result.maximumFee = maximumFee;
    }
    if (makerFee != null) {
      $result.makerFee = makerFee;
    }
    if (takerFee != null) {
      $result.takerFee = takerFee;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (feeTier != null) {
      $result.feeTier = feeTier;
    }
    if (discountRate != null) {
      $result.discountRate = discountRate;
    }
    if (totalEstimatedFee != null) {
      $result.totalEstimatedFee = totalEstimatedFee;
    }
    return $result;
  }
  FeeStructure._() : super();
  factory FeeStructure.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FeeStructure.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FeeStructure', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
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
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FeeStructure clone() => FeeStructure()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FeeStructure copyWith(void Function(FeeStructure) updates) => super.copyWith((message) => updates(message as FeeStructure)) as FeeStructure;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FeeStructure create() => FeeStructure._();
  FeeStructure createEmptyInstance() => create();
  static $pb.PbList<FeeStructure> createRepeated() => $pb.PbList<FeeStructure>();
  @$core.pragma('dart2js:noInline')
  static FeeStructure getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FeeStructure>(create);
  static FeeStructure? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get baseFee => $_getSZ(0);
  @$pb.TagNumber(1)
  set baseFee($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBaseFee() => $_has(0);
  @$pb.TagNumber(1)
  void clearBaseFee() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get percentageFee => $_getSZ(1);
  @$pb.TagNumber(2)
  set percentageFee($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPercentageFee() => $_has(1);
  @$pb.TagNumber(2)
  void clearPercentageFee() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get minimumFee => $_getSZ(2);
  @$pb.TagNumber(3)
  set minimumFee($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMinimumFee() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinimumFee() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get maximumFee => $_getSZ(3);
  @$pb.TagNumber(4)
  set maximumFee($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMaximumFee() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaximumFee() => clearField(4);

  @$pb.TagNumber(6)
  $core.String get makerFee => $_getSZ(4);
  @$pb.TagNumber(6)
  set makerFee($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(6)
  $core.bool hasMakerFee() => $_has(4);
  @$pb.TagNumber(6)
  void clearMakerFee() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get takerFee => $_getSZ(5);
  @$pb.TagNumber(7)
  set takerFee($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasTakerFee() => $_has(5);
  @$pb.TagNumber(7)
  void clearTakerFee() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(8)
  set currency($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(8)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(8)
  void clearCurrency() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get feeTier => $_getSZ(7);
  @$pb.TagNumber(9)
  set feeTier($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(9)
  $core.bool hasFeeTier() => $_has(7);
  @$pb.TagNumber(9)
  void clearFeeTier() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get discountRate => $_getSZ(8);
  @$pb.TagNumber(10)
  set discountRate($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(10)
  $core.bool hasDiscountRate() => $_has(8);
  @$pb.TagNumber(10)
  void clearDiscountRate() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get totalEstimatedFee => $_getSZ(9);
  @$pb.TagNumber(11)
  set totalEstimatedFee($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(11)
  $core.bool hasTotalEstimatedFee() => $_has(9);
  @$pb.TagNumber(11)
  void clearTotalEstimatedFee() => clearField(11);
}

class GetOrderFeesRequest extends $pb.GeneratedMessage {
  factory GetOrderFeesRequest({
    $core.String? proposedExecutionId,
    $core.String? accountIid,
    $core.String? feePayerAccountIid,
    $core.String? instrumentListingIid,
    $core.String? orderType,
    $9.OrderSide? side,
    $core.String? quantity,
    $core.String? price,
    $core.String? timeInForce,
    $core.bool? isPostOnly,
    $core.bool? isReduceOnly,
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (accountIid != null) {
      $result.accountIid = accountIid;
    }
    if (feePayerAccountIid != null) {
      $result.feePayerAccountIid = feePayerAccountIid;
    }
    if (instrumentListingIid != null) {
      $result.instrumentListingIid = instrumentListingIid;
    }
    if (orderType != null) {
      $result.orderType = orderType;
    }
    if (side != null) {
      $result.side = side;
    }
    if (quantity != null) {
      $result.quantity = quantity;
    }
    if (price != null) {
      $result.price = price;
    }
    if (timeInForce != null) {
      $result.timeInForce = timeInForce;
    }
    if (isPostOnly != null) {
      $result.isPostOnly = isPostOnly;
    }
    if (isReduceOnly != null) {
      $result.isReduceOnly = isReduceOnly;
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  GetOrderFeesRequest._() : super();
  factory GetOrderFeesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOrderFeesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetOrderFeesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'accountIid')
    ..aOS(3, _omitFieldNames ? '' : 'feePayerAccountIid')
    ..aOS(4, _omitFieldNames ? '' : 'instrumentListingIid')
    ..aOS(5, _omitFieldNames ? '' : 'orderType')
    ..e<$9.OrderSide>(6, _omitFieldNames ? '' : 'side', $pb.PbFieldType.OE, defaultOrMaker: $9.OrderSide.ORDER_SIDE__UNKNOWN, valueOf: $9.OrderSide.valueOf, enumValues: $9.OrderSide.values)
    ..aOS(7, _omitFieldNames ? '' : 'quantity')
    ..aOS(8, _omitFieldNames ? '' : 'price')
    ..aOS(9, _omitFieldNames ? '' : 'timeInForce')
    ..aOB(10, _omitFieldNames ? '' : 'isPostOnly')
    ..aOB(11, _omitFieldNames ? '' : 'isReduceOnly')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'GetOrderFeesRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOrderFeesRequest clone() => GetOrderFeesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOrderFeesRequest copyWith(void Function(GetOrderFeesRequest) updates) => super.copyWith((message) => updates(message as GetOrderFeesRequest)) as GetOrderFeesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOrderFeesRequest create() => GetOrderFeesRequest._();
  GetOrderFeesRequest createEmptyInstance() => create();
  static $pb.PbList<GetOrderFeesRequest> createRepeated() => $pb.PbList<GetOrderFeesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOrderFeesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOrderFeesRequest>(create);
  static GetOrderFeesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountIid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountIid() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get feePayerAccountIid => $_getSZ(2);
  @$pb.TagNumber(3)
  set feePayerAccountIid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFeePayerAccountIid() => $_has(2);
  @$pb.TagNumber(3)
  void clearFeePayerAccountIid() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get instrumentListingIid => $_getSZ(3);
  @$pb.TagNumber(4)
  set instrumentListingIid($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasInstrumentListingIid() => $_has(3);
  @$pb.TagNumber(4)
  void clearInstrumentListingIid() => clearField(4);

  /// Order details for fee calculation
  @$pb.TagNumber(5)
  $core.String get orderType => $_getSZ(4);
  @$pb.TagNumber(5)
  set orderType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasOrderType() => $_has(4);
  @$pb.TagNumber(5)
  void clearOrderType() => clearField(5);

  @$pb.TagNumber(6)
  $9.OrderSide get side => $_getN(5);
  @$pb.TagNumber(6)
  set side($9.OrderSide v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasSide() => $_has(5);
  @$pb.TagNumber(6)
  void clearSide() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get quantity => $_getSZ(6);
  @$pb.TagNumber(7)
  set quantity($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasQuantity() => $_has(6);
  @$pb.TagNumber(7)
  void clearQuantity() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get price => $_getSZ(7);
  @$pb.TagNumber(8)
  set price($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPrice() => $_has(7);
  @$pb.TagNumber(8)
  void clearPrice() => clearField(8);

  /// Optional parameters that might affect fees
  @$pb.TagNumber(9)
  $core.String get timeInForce => $_getSZ(8);
  @$pb.TagNumber(9)
  set timeInForce($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasTimeInForce() => $_has(8);
  @$pb.TagNumber(9)
  void clearTimeInForce() => clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isPostOnly => $_getBF(9);
  @$pb.TagNumber(10)
  set isPostOnly($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasIsPostOnly() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsPostOnly() => clearField(10);

  @$pb.TagNumber(11)
  $core.bool get isReduceOnly => $_getBF(10);
  @$pb.TagNumber(11)
  set isReduceOnly($core.bool v) { $_setBool(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasIsReduceOnly() => $_has(10);
  @$pb.TagNumber(11)
  void clearIsReduceOnly() => clearField(11);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(11);
}

class GetOrderFeesResponse extends $pb.GeneratedMessage {
  factory GetOrderFeesResponse({
    $core.String? refExecutionId,
    FeeStructure? feeStructure,
    $core.Iterable<$core.String>? feeNotes,
    $1.DateTime? feeValidUntilDt,
    $core.String? msg,
    $core.Map<$core.String, $core.String>? feeBreakdown,
    $core.Iterable<FeeStructure>? alternativeFeeOptions,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (refExecutionId != null) {
      $result.refExecutionId = refExecutionId;
    }
    if (feeStructure != null) {
      $result.feeStructure = feeStructure;
    }
    if (feeNotes != null) {
      $result.feeNotes.addAll(feeNotes);
    }
    if (feeValidUntilDt != null) {
      $result.feeValidUntilDt = feeValidUntilDt;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    if (feeBreakdown != null) {
      $result.feeBreakdown.addAll(feeBreakdown);
    }
    if (alternativeFeeOptions != null) {
      $result.alternativeFeeOptions.addAll(alternativeFeeOptions);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  GetOrderFeesResponse._() : super();
  factory GetOrderFeesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOrderFeesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetOrderFeesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<FeeStructure>(2, _omitFieldNames ? '' : 'feeStructure', subBuilder: FeeStructure.create)
    ..pPS(3, _omitFieldNames ? '' : 'feeNotes')
    ..aOM<$1.DateTime>(4, _omitFieldNames ? '' : 'feeValidUntilDt', subBuilder: $1.DateTime.create)
    ..aOS(5, _omitFieldNames ? '' : 'msg')
    ..m<$core.String, $core.String>(6, _omitFieldNames ? '' : 'feeBreakdown', entryClassName: 'GetOrderFeesResponse.FeeBreakdownEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..pc<FeeStructure>(7, _omitFieldNames ? '' : 'alternativeFeeOptions', $pb.PbFieldType.PM, subBuilder: FeeStructure.create)
    ..m<$core.String, $core.String>(8, _omitFieldNames ? '' : 'metadata', entryClassName: 'GetOrderFeesResponse.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOrderFeesResponse clone() => GetOrderFeesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOrderFeesResponse copyWith(void Function(GetOrderFeesResponse) updates) => super.copyWith((message) => updates(message as GetOrderFeesResponse)) as GetOrderFeesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOrderFeesResponse create() => GetOrderFeesResponse._();
  GetOrderFeesResponse createEmptyInstance() => create();
  static $pb.PbList<GetOrderFeesResponse> createRepeated() => $pb.PbList<GetOrderFeesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOrderFeesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOrderFeesResponse>(create);
  static GetOrderFeesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  FeeStructure get feeStructure => $_getN(1);
  @$pb.TagNumber(2)
  set feeStructure(FeeStructure v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasFeeStructure() => $_has(1);
  @$pb.TagNumber(2)
  void clearFeeStructure() => clearField(2);
  @$pb.TagNumber(2)
  FeeStructure ensureFeeStructure() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.List<$core.String> get feeNotes => $_getList(2);

  @$pb.TagNumber(4)
  $1.DateTime get feeValidUntilDt => $_getN(3);
  @$pb.TagNumber(4)
  set feeValidUntilDt($1.DateTime v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasFeeValidUntilDt() => $_has(3);
  @$pb.TagNumber(4)
  void clearFeeValidUntilDt() => clearField(4);
  @$pb.TagNumber(4)
  $1.DateTime ensureFeeValidUntilDt() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get msg => $_getSZ(4);
  @$pb.TagNumber(5)
  set msg($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMsg() => $_has(4);
  @$pb.TagNumber(5)
  void clearMsg() => clearField(5);

  @$pb.TagNumber(6)
  $core.Map<$core.String, $core.String> get feeBreakdown => $_getMap(5);

  @$pb.TagNumber(7)
  $core.List<FeeStructure> get alternativeFeeOptions => $_getList(6);

  @$pb.TagNumber(8)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(7);
}

class CreateOrderAsyncRequest extends $pb.GeneratedMessage {
  factory CreateOrderAsyncRequest({
    $core.String? proposedExecutionId,
    $core.String? accountIid,
    $core.String? feePayerAccountIid,
    $core.String? instrumentListingIid,
    $core.String? orderType,
    $9.OrderSide? side,
    $core.String? quantity,
    $core.String? price,
    $core.String? timeInForce,
    $1.DateTime? expireDt,
    $core.String? participantOrderIid,
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (accountIid != null) {
      $result.accountIid = accountIid;
    }
    if (feePayerAccountIid != null) {
      $result.feePayerAccountIid = feePayerAccountIid;
    }
    if (instrumentListingIid != null) {
      $result.instrumentListingIid = instrumentListingIid;
    }
    if (orderType != null) {
      $result.orderType = orderType;
    }
    if (side != null) {
      $result.side = side;
    }
    if (quantity != null) {
      $result.quantity = quantity;
    }
    if (price != null) {
      $result.price = price;
    }
    if (timeInForce != null) {
      $result.timeInForce = timeInForce;
    }
    if (expireDt != null) {
      $result.expireDt = expireDt;
    }
    if (participantOrderIid != null) {
      $result.participantOrderIid = participantOrderIid;
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  CreateOrderAsyncRequest._() : super();
  factory CreateOrderAsyncRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateOrderAsyncRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateOrderAsyncRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'accountIid')
    ..aOS(3, _omitFieldNames ? '' : 'feePayerAccountIid')
    ..aOS(4, _omitFieldNames ? '' : 'instrumentListingIid')
    ..aOS(5, _omitFieldNames ? '' : 'orderType')
    ..e<$9.OrderSide>(6, _omitFieldNames ? '' : 'side', $pb.PbFieldType.OE, defaultOrMaker: $9.OrderSide.ORDER_SIDE__UNKNOWN, valueOf: $9.OrderSide.valueOf, enumValues: $9.OrderSide.values)
    ..aOS(7, _omitFieldNames ? '' : 'quantity')
    ..aOS(8, _omitFieldNames ? '' : 'price')
    ..aOS(9, _omitFieldNames ? '' : 'timeInForce')
    ..aOM<$1.DateTime>(10, _omitFieldNames ? '' : 'expireDt', subBuilder: $1.DateTime.create)
    ..aOS(11, _omitFieldNames ? '' : 'participantOrderIid')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'CreateOrderAsyncRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateOrderAsyncRequest clone() => CreateOrderAsyncRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateOrderAsyncRequest copyWith(void Function(CreateOrderAsyncRequest) updates) => super.copyWith((message) => updates(message as CreateOrderAsyncRequest)) as CreateOrderAsyncRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateOrderAsyncRequest create() => CreateOrderAsyncRequest._();
  CreateOrderAsyncRequest createEmptyInstance() => create();
  static $pb.PbList<CreateOrderAsyncRequest> createRepeated() => $pb.PbList<CreateOrderAsyncRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateOrderAsyncRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateOrderAsyncRequest>(create);
  static CreateOrderAsyncRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountIid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountIid() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get feePayerAccountIid => $_getSZ(2);
  @$pb.TagNumber(3)
  set feePayerAccountIid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFeePayerAccountIid() => $_has(2);
  @$pb.TagNumber(3)
  void clearFeePayerAccountIid() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get instrumentListingIid => $_getSZ(3);
  @$pb.TagNumber(4)
  set instrumentListingIid($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasInstrumentListingIid() => $_has(3);
  @$pb.TagNumber(4)
  void clearInstrumentListingIid() => clearField(4);

  /// Order details
  @$pb.TagNumber(5)
  $core.String get orderType => $_getSZ(4);
  @$pb.TagNumber(5)
  set orderType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasOrderType() => $_has(4);
  @$pb.TagNumber(5)
  void clearOrderType() => clearField(5);

  @$pb.TagNumber(6)
  $9.OrderSide get side => $_getN(5);
  @$pb.TagNumber(6)
  set side($9.OrderSide v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasSide() => $_has(5);
  @$pb.TagNumber(6)
  void clearSide() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get quantity => $_getSZ(6);
  @$pb.TagNumber(7)
  set quantity($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasQuantity() => $_has(6);
  @$pb.TagNumber(7)
  void clearQuantity() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get price => $_getSZ(7);
  @$pb.TagNumber(8)
  set price($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPrice() => $_has(7);
  @$pb.TagNumber(8)
  void clearPrice() => clearField(8);

  /// Time constraints
  @$pb.TagNumber(9)
  $core.String get timeInForce => $_getSZ(8);
  @$pb.TagNumber(9)
  set timeInForce($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasTimeInForce() => $_has(8);
  @$pb.TagNumber(9)
  void clearTimeInForce() => clearField(9);

  @$pb.TagNumber(10)
  $1.DateTime get expireDt => $_getN(9);
  @$pb.TagNumber(10)
  set expireDt($1.DateTime v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasExpireDt() => $_has(9);
  @$pb.TagNumber(10)
  void clearExpireDt() => clearField(10);
  @$pb.TagNumber(10)
  $1.DateTime ensureExpireDt() => $_ensure(9);

  /// Additional parameters
  @$pb.TagNumber(11)
  $core.String get participantOrderIid => $_getSZ(10);
  @$pb.TagNumber(11)
  set participantOrderIid($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasParticipantOrderIid() => $_has(10);
  @$pb.TagNumber(11)
  void clearParticipantOrderIid() => clearField(11);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(11);
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
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (oldParticipantOrderId != null) {
      $result.oldParticipantOrderId = oldParticipantOrderId;
    }
    if (newParticipantOrderId != null) {
      $result.newParticipantOrderId = newParticipantOrderId;
    }
    if (newQuantity != null) {
      $result.newQuantity = newQuantity;
    }
    if (newPrice != null) {
      $result.newPrice = newPrice;
    }
    if (newExpireTime != null) {
      $result.newExpireTime = newExpireTime;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  ReplaceOrderAsyncRequest._() : super();
  factory ReplaceOrderAsyncRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReplaceOrderAsyncRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReplaceOrderAsyncRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'oldParticipantOrderId')
    ..aOS(3, _omitFieldNames ? '' : 'newParticipantOrderId')
    ..aOS(4, _omitFieldNames ? '' : 'newQuantity')
    ..aOS(5, _omitFieldNames ? '' : 'newPrice')
    ..aOM<$1.Time>(6, _omitFieldNames ? '' : 'newExpireTime', subBuilder: $1.Time.create)
    ..aOS(7, _omitFieldNames ? '' : 'reason')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'ReplaceOrderAsyncRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReplaceOrderAsyncRequest clone() => ReplaceOrderAsyncRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReplaceOrderAsyncRequest copyWith(void Function(ReplaceOrderAsyncRequest) updates) => super.copyWith((message) => updates(message as ReplaceOrderAsyncRequest)) as ReplaceOrderAsyncRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReplaceOrderAsyncRequest create() => ReplaceOrderAsyncRequest._();
  ReplaceOrderAsyncRequest createEmptyInstance() => create();
  static $pb.PbList<ReplaceOrderAsyncRequest> createRepeated() => $pb.PbList<ReplaceOrderAsyncRequest>();
  @$core.pragma('dart2js:noInline')
  static ReplaceOrderAsyncRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReplaceOrderAsyncRequest>(create);
  static ReplaceOrderAsyncRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get oldParticipantOrderId => $_getSZ(1);
  @$pb.TagNumber(2)
  set oldParticipantOrderId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOldParticipantOrderId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOldParticipantOrderId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get newParticipantOrderId => $_getSZ(2);
  @$pb.TagNumber(3)
  set newParticipantOrderId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNewParticipantOrderId() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewParticipantOrderId() => clearField(3);

  /// Fields that can be modified
  @$pb.TagNumber(4)
  $core.String get newQuantity => $_getSZ(3);
  @$pb.TagNumber(4)
  set newQuantity($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNewQuantity() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewQuantity() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get newPrice => $_getSZ(4);
  @$pb.TagNumber(5)
  set newPrice($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNewPrice() => $_has(4);
  @$pb.TagNumber(5)
  void clearNewPrice() => clearField(5);

  @$pb.TagNumber(6)
  $1.Time get newExpireTime => $_getN(5);
  @$pb.TagNumber(6)
  set newExpireTime($1.Time v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasNewExpireTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearNewExpireTime() => clearField(6);
  @$pb.TagNumber(6)
  $1.Time ensureNewExpireTime() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get reason => $_getSZ(6);
  @$pb.TagNumber(7)
  set reason($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasReason() => $_has(6);
  @$pb.TagNumber(7)
  void clearReason() => clearField(7);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(7);
}

class CancelOrderAsyncRequest extends $pb.GeneratedMessage {
  factory CancelOrderAsyncRequest({
    $core.String? proposedExecutionId,
    $core.String? participantOrderId,
    $core.String? reason,
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (participantOrderId != null) {
      $result.participantOrderId = participantOrderId;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  CancelOrderAsyncRequest._() : super();
  factory CancelOrderAsyncRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelOrderAsyncRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CancelOrderAsyncRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'participantOrderId')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'CancelOrderAsyncRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelOrderAsyncRequest clone() => CancelOrderAsyncRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelOrderAsyncRequest copyWith(void Function(CancelOrderAsyncRequest) updates) => super.copyWith((message) => updates(message as CancelOrderAsyncRequest)) as CancelOrderAsyncRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelOrderAsyncRequest create() => CancelOrderAsyncRequest._();
  CancelOrderAsyncRequest createEmptyInstance() => create();
  static $pb.PbList<CancelOrderAsyncRequest> createRepeated() => $pb.PbList<CancelOrderAsyncRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelOrderAsyncRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelOrderAsyncRequest>(create);
  static CancelOrderAsyncRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get participantOrderId => $_getSZ(1);
  @$pb.TagNumber(2)
  set participantOrderId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasParticipantOrderId() => $_has(1);
  @$pb.TagNumber(2)
  void clearParticipantOrderId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => clearField(3);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(3);
}

class GetOrderbookRequest extends $pb.GeneratedMessage {
  factory GetOrderbookRequest({
    $core.String? proposedExecutionId,
    $1.PaginationParams? pagination,
    $core.String? instrumentIid,
    $10.OrderbookQueryFilter? orderbookQueryFilter,
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    if (instrumentIid != null) {
      $result.instrumentIid = instrumentIid;
    }
    if (orderbookQueryFilter != null) {
      $result.orderbookQueryFilter = orderbookQueryFilter;
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  GetOrderbookRequest._() : super();
  factory GetOrderbookRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOrderbookRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetOrderbookRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination', subBuilder: $1.PaginationParams.create)
    ..aOS(3, _omitFieldNames ? '' : 'instrumentIid')
    ..aOM<$10.OrderbookQueryFilter>(4, _omitFieldNames ? '' : 'orderbookQueryFilter', subBuilder: $10.OrderbookQueryFilter.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'GetOrderbookRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOrderbookRequest clone() => GetOrderbookRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOrderbookRequest copyWith(void Function(GetOrderbookRequest) updates) => super.copyWith((message) => updates(message as GetOrderbookRequest)) as GetOrderbookRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOrderbookRequest create() => GetOrderbookRequest._();
  GetOrderbookRequest createEmptyInstance() => create();
  static $pb.PbList<GetOrderbookRequest> createRepeated() => $pb.PbList<GetOrderbookRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOrderbookRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOrderbookRequest>(create);
  static GetOrderbookRequest? _defaultInstance;

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
  $core.String get instrumentIid => $_getSZ(2);
  @$pb.TagNumber(3)
  set instrumentIid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasInstrumentIid() => $_has(2);
  @$pb.TagNumber(3)
  void clearInstrumentIid() => clearField(3);

  @$pb.TagNumber(4)
  $10.OrderbookQueryFilter get orderbookQueryFilter => $_getN(3);
  @$pb.TagNumber(4)
  set orderbookQueryFilter($10.OrderbookQueryFilter v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasOrderbookQueryFilter() => $_has(3);
  @$pb.TagNumber(4)
  void clearOrderbookQueryFilter() => clearField(4);
  @$pb.TagNumber(4)
  $10.OrderbookQueryFilter ensureOrderbookQueryFilter() => $_ensure(3);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(4);
}

class GetOrderbookResponse extends $pb.GeneratedMessage {
  factory GetOrderbookResponse({
    $core.String? refExecutionId,
    $1.DateTime? generatedAtDt,
    $9.Instrument? instrument,
    $10.OrderList? buyList,
    $10.OrderList? sellList,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (refExecutionId != null) {
      $result.refExecutionId = refExecutionId;
    }
    if (generatedAtDt != null) {
      $result.generatedAtDt = generatedAtDt;
    }
    if (instrument != null) {
      $result.instrument = instrument;
    }
    if (buyList != null) {
      $result.buyList = buyList;
    }
    if (sellList != null) {
      $result.sellList = sellList;
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  GetOrderbookResponse._() : super();
  factory GetOrderbookResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOrderbookResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetOrderbookResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.DateTime>(2, _omitFieldNames ? '' : 'generatedAtDt', subBuilder: $1.DateTime.create)
    ..aOM<$9.Instrument>(3, _omitFieldNames ? '' : 'instrument', subBuilder: $9.Instrument.create)
    ..aOM<$10.OrderList>(4, _omitFieldNames ? '' : 'buyList', subBuilder: $10.OrderList.create)
    ..aOM<$10.OrderList>(5, _omitFieldNames ? '' : 'sellList', subBuilder: $10.OrderList.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'GetOrderbookResponse.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOrderbookResponse clone() => GetOrderbookResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOrderbookResponse copyWith(void Function(GetOrderbookResponse) updates) => super.copyWith((message) => updates(message as GetOrderbookResponse)) as GetOrderbookResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOrderbookResponse create() => GetOrderbookResponse._();
  GetOrderbookResponse createEmptyInstance() => create();
  static $pb.PbList<GetOrderbookResponse> createRepeated() => $pb.PbList<GetOrderbookResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOrderbookResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOrderbookResponse>(create);
  static GetOrderbookResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $1.DateTime get generatedAtDt => $_getN(1);
  @$pb.TagNumber(2)
  set generatedAtDt($1.DateTime v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasGeneratedAtDt() => $_has(1);
  @$pb.TagNumber(2)
  void clearGeneratedAtDt() => clearField(2);
  @$pb.TagNumber(2)
  $1.DateTime ensureGeneratedAtDt() => $_ensure(1);

  @$pb.TagNumber(3)
  $9.Instrument get instrument => $_getN(2);
  @$pb.TagNumber(3)
  set instrument($9.Instrument v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasInstrument() => $_has(2);
  @$pb.TagNumber(3)
  void clearInstrument() => clearField(3);
  @$pb.TagNumber(3)
  $9.Instrument ensureInstrument() => $_ensure(2);

  @$pb.TagNumber(4)
  $10.OrderList get buyList => $_getN(3);
  @$pb.TagNumber(4)
  set buyList($10.OrderList v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasBuyList() => $_has(3);
  @$pb.TagNumber(4)
  void clearBuyList() => clearField(4);
  @$pb.TagNumber(4)
  $10.OrderList ensureBuyList() => $_ensure(3);

  @$pb.TagNumber(5)
  $10.OrderList get sellList => $_getN(4);
  @$pb.TagNumber(5)
  set sellList($10.OrderList v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasSellList() => $_has(4);
  @$pb.TagNumber(5)
  void clearSellList() => clearField(5);
  @$pb.TagNumber(5)
  $10.OrderList ensureSellList() => $_ensure(4);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(5);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
