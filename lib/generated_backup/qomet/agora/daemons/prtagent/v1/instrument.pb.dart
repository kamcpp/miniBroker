// This is a generated file - do not edit.
//
// Generated from qomet/agora/daemons/prtagent/v1/instrument.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class InstrumentQuote extends $pb.GeneratedMessage {
  factory InstrumentQuote({
    $1.Instrument? instrument,
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
    ..aOM<$1.Instrument>(1, _omitFieldNames ? '' : 'instrument',
        subBuilder: $1.Instrument.create)
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
  $1.Instrument get instrument => $_getN(0);
  @$pb.TagNumber(1)
  set instrument($1.Instrument value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInstrument() => $_has(0);
  @$pb.TagNumber(1)
  void clearInstrument() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Instrument ensureInstrument() => $_ensure(0);

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
    $core.String? refRequestId,
    $core.String? metadata,
    InstrumentQuote? quote,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (metadata != null) result.metadata = metadata;
    if (quote != null) result.quote = quote;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'metadata')
    ..aOM<InstrumentQuote>(3, _omitFieldNames ? '' : 'quote',
        subBuilder: InstrumentQuote.create)
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get metadata => $_getSZ(1);
  @$pb.TagNumber(2)
  set metadata($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMetadata() => $_has(1);
  @$pb.TagNumber(2)
  void clearMetadata() => $_clearField(2);

  @$pb.TagNumber(3)
  InstrumentQuote get quote => $_getN(2);
  @$pb.TagNumber(3)
  set quote(InstrumentQuote value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasQuote() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuote() => $_clearField(3);
  @$pb.TagNumber(3)
  InstrumentQuote ensureQuote() => $_ensure(2);
}

class OhlcData extends $pb.GeneratedMessage {
  factory OhlcData({
    $1.Instrument? instrument,
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
    ..aOM<$1.Instrument>(3, _omitFieldNames ? '' : 'instrument',
        subBuilder: $1.Instrument.create)
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
  $1.Instrument get instrument => $_getN(0);
  @$pb.TagNumber(3)
  set instrument($1.Instrument value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasInstrument() => $_has(0);
  @$pb.TagNumber(3)
  void clearInstrument() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Instrument ensureInstrument() => $_ensure(0);

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
    $core.String? refRequestId,
    $core.String? metadata,
    OhlcData? ohlcData,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (metadata != null) result.metadata = metadata;
    if (ohlcData != null) result.ohlcData = ohlcData;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'metadata')
    ..aOM<OhlcData>(3, _omitFieldNames ? '' : 'ohlcData',
        subBuilder: OhlcData.create)
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get metadata => $_getSZ(1);
  @$pb.TagNumber(2)
  set metadata($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMetadata() => $_has(1);
  @$pb.TagNumber(2)
  void clearMetadata() => $_clearField(2);

  @$pb.TagNumber(3)
  OhlcData get ohlcData => $_getN(2);
  @$pb.TagNumber(3)
  set ohlcData(OhlcData value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasOhlcData() => $_has(2);
  @$pb.TagNumber(3)
  void clearOhlcData() => $_clearField(3);
  @$pb.TagNumber(3)
  OhlcData ensureOhlcData() => $_ensure(2);
}

class GetInstrumentsInfoRequest extends $pb.GeneratedMessage {
  factory GetInstrumentsInfoRequest({
    $core.String? refRequestId,
    $1.PaginationParams? pagination,
    $core.Iterable<$core.String>? instrumentIdAndSymbolRegexes,
    $core.Iterable<$1.InstrumentListingStatusType>? listingTypes,
    $core.String? metadata,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (pagination != null) result.pagination = pagination;
    if (instrumentIdAndSymbolRegexes != null)
      result.instrumentIdAndSymbolRegexes.addAll(instrumentIdAndSymbolRegexes);
    if (listingTypes != null) result.listingTypes.addAll(listingTypes);
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  GetInstrumentsInfoRequest._();

  factory GetInstrumentsInfoRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInstrumentsInfoRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInstrumentsInfoRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..pPS(3, _omitFieldNames ? '' : 'instrumentIdAndSymbolRegexes')
    ..pc<$1.InstrumentListingStatusType>(
        4, _omitFieldNames ? '' : 'listingTypes', $pb.PbFieldType.KE,
        valueOf: $1.InstrumentListingStatusType.valueOf,
        enumValues: $1.InstrumentListingStatusType.values,
        defaultEnumValue: $1.InstrumentListingStatusType
            .INSTRUMENT_LISTING_STATUS_TYPE__UNKNOWN)
    ..aOS(5, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInstrumentsInfoRequest clone() =>
      GetInstrumentsInfoRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInstrumentsInfoRequest copyWith(
          void Function(GetInstrumentsInfoRequest) updates) =>
      super.copyWith((message) => updates(message as GetInstrumentsInfoRequest))
          as GetInstrumentsInfoRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInstrumentsInfoRequest create() => GetInstrumentsInfoRequest._();
  @$core.override
  GetInstrumentsInfoRequest createEmptyInstance() => create();
  static $pb.PbList<GetInstrumentsInfoRequest> createRepeated() =>
      $pb.PbList<GetInstrumentsInfoRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInstrumentsInfoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInstrumentsInfoRequest>(create);
  static GetInstrumentsInfoRequest? _defaultInstance;

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
  $pb.PbList<$core.String> get instrumentIdAndSymbolRegexes => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<$1.InstrumentListingStatusType> get listingTypes => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get metadata => $_getSZ(4);
  @$pb.TagNumber(5)
  set metadata($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMetadata() => $_has(4);
  @$pb.TagNumber(5)
  void clearMetadata() => $_clearField(5);
}

class GetInstrumentsInfoResponse extends $pb.GeneratedMessage {
  factory GetInstrumentsInfoResponse({
    $core.String? refRequestId,
    $core.String? metadata,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<$1.Instrument>? instruments,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (metadata != null) result.metadata = metadata;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (instruments != null) result.instruments.addAll(instruments);
    return result;
  }

  GetInstrumentsInfoResponse._();

  factory GetInstrumentsInfoResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInstrumentsInfoResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInstrumentsInfoResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'metadata')
    ..aOM<$1.PaginationInfo>(3, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<$1.Instrument>(
        4, _omitFieldNames ? '' : 'instruments', $pb.PbFieldType.PM,
        subBuilder: $1.Instrument.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInstrumentsInfoResponse clone() =>
      GetInstrumentsInfoResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInstrumentsInfoResponse copyWith(
          void Function(GetInstrumentsInfoResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInstrumentsInfoResponse))
          as GetInstrumentsInfoResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInstrumentsInfoResponse create() => GetInstrumentsInfoResponse._();
  @$core.override
  GetInstrumentsInfoResponse createEmptyInstance() => create();
  static $pb.PbList<GetInstrumentsInfoResponse> createRepeated() =>
      $pb.PbList<GetInstrumentsInfoResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInstrumentsInfoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInstrumentsInfoResponse>(create);
  static GetInstrumentsInfoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get metadata => $_getSZ(1);
  @$pb.TagNumber(2)
  set metadata($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMetadata() => $_has(1);
  @$pb.TagNumber(2)
  void clearMetadata() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.PaginationInfo get paginationInfo => $_getN(2);
  @$pb.TagNumber(3)
  set paginationInfo($1.PaginationInfo value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPaginationInfo() => $_has(2);
  @$pb.TagNumber(3)
  void clearPaginationInfo() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.PaginationInfo ensurePaginationInfo() => $_ensure(2);

  @$pb.TagNumber(4)
  $pb.PbList<$1.Instrument> get instruments => $_getList(3);
}

class GetLatestQuoteRequest extends $pb.GeneratedMessage {
  factory GetLatestQuoteRequest({
    $core.String? refRequestId,
    $core.Iterable<$core.String>? instrumentIdAndSymbolRegexes,
    $core.String? metadata,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (instrumentIdAndSymbolRegexes != null)
      result.instrumentIdAndSymbolRegexes.addAll(instrumentIdAndSymbolRegexes);
    if (metadata != null) result.metadata = metadata;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..pPS(2, _omitFieldNames ? '' : 'instrumentIdAndSymbolRegexes')
    ..aOS(3, _omitFieldNames ? '' : 'metadata')
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get instrumentIdAndSymbolRegexes => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get metadata => $_getSZ(2);
  @$pb.TagNumber(3)
  set metadata($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMetadata() => $_has(2);
  @$pb.TagNumber(3)
  void clearMetadata() => $_clearField(3);
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
    $core.String? refRequestId,
    $core.Iterable<$core.String>? instrumentIdAndSymbolRegexes,
    LiveQuoteFetchParams? fetchParams,
    $core.String? metadata,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (instrumentIdAndSymbolRegexes != null)
      result.instrumentIdAndSymbolRegexes.addAll(instrumentIdAndSymbolRegexes);
    if (fetchParams != null) result.fetchParams = fetchParams;
    if (metadata != null) result.metadata = metadata;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..pPS(2, _omitFieldNames ? '' : 'instrumentIdAndSymbolRegexes')
    ..aOM<LiveQuoteFetchParams>(3, _omitFieldNames ? '' : 'fetchParams',
        subBuilder: LiveQuoteFetchParams.create)
    ..aOS(4, _omitFieldNames ? '' : 'metadata')
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

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

  @$pb.TagNumber(4)
  $core.String get metadata => $_getSZ(3);
  @$pb.TagNumber(4)
  set metadata($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMetadata() => $_has(3);
  @$pb.TagNumber(4)
  void clearMetadata() => $_clearField(4);
}

class GetHistoricalQuoteRequest extends $pb.GeneratedMessage {
  factory GetHistoricalQuoteRequest({
    $core.String? refRequestId,
    $1.PaginationParams? pagination,
    $core.Iterable<$core.String>? instrumentIdAndSymbolRegexes,
    $1.Duration? duration,
    $core.String? metadata,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (pagination != null) result.pagination = pagination;
    if (instrumentIdAndSymbolRegexes != null)
      result.instrumentIdAndSymbolRegexes.addAll(instrumentIdAndSymbolRegexes);
    if (duration != null) result.duration = duration;
    if (metadata != null) result.metadata = metadata;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..pPS(3, _omitFieldNames ? '' : 'instrumentIdAndSymbolRegexes')
    ..aOM<$1.Duration>(4, _omitFieldNames ? '' : 'duration',
        subBuilder: $1.Duration.create)
    ..aOS(5, _omitFieldNames ? '' : 'metadata')
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
  $core.String get metadata => $_getSZ(4);
  @$pb.TagNumber(5)
  set metadata($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMetadata() => $_has(4);
  @$pb.TagNumber(5)
  void clearMetadata() => $_clearField(5);
}

class GetHistoricalQuoteResponse extends $pb.GeneratedMessage {
  factory GetHistoricalQuoteResponse({
    $core.String? refRequestId,
    $core.String? metadata,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<InstrumentQuote>? quotes,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (metadata != null) result.metadata = metadata;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (quotes != null) result.quotes.addAll(quotes);
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'metadata')
    ..aOM<$1.PaginationInfo>(3, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<InstrumentQuote>(
        4, _omitFieldNames ? '' : 'quotes', $pb.PbFieldType.PM,
        subBuilder: InstrumentQuote.create)
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get metadata => $_getSZ(1);
  @$pb.TagNumber(2)
  set metadata($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMetadata() => $_has(1);
  @$pb.TagNumber(2)
  void clearMetadata() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.PaginationInfo get paginationInfo => $_getN(2);
  @$pb.TagNumber(3)
  set paginationInfo($1.PaginationInfo value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPaginationInfo() => $_has(2);
  @$pb.TagNumber(3)
  void clearPaginationInfo() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.PaginationInfo ensurePaginationInfo() => $_ensure(2);

  @$pb.TagNumber(4)
  $pb.PbList<InstrumentQuote> get quotes => $_getList(3);
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
    $core.String? refRequestId,
    $core.Iterable<$core.String>? instrumentIdAndSymbolRegexes,
    LiveOhlcDataFetchParams? fetchParams,
    $core.String? metadata,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (instrumentIdAndSymbolRegexes != null)
      result.instrumentIdAndSymbolRegexes.addAll(instrumentIdAndSymbolRegexes);
    if (fetchParams != null) result.fetchParams = fetchParams;
    if (metadata != null) result.metadata = metadata;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..pPS(2, _omitFieldNames ? '' : 'instrumentIdAndSymbolRegexes')
    ..aOM<LiveOhlcDataFetchParams>(3, _omitFieldNames ? '' : 'fetchParams',
        subBuilder: LiveOhlcDataFetchParams.create)
    ..aOS(4, _omitFieldNames ? '' : 'metadata')
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

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

  @$pb.TagNumber(4)
  $core.String get metadata => $_getSZ(3);
  @$pb.TagNumber(4)
  set metadata($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMetadata() => $_has(3);
  @$pb.TagNumber(4)
  void clearMetadata() => $_clearField(4);
}

class GetHistoricalOhlcDataRequest extends $pb.GeneratedMessage {
  factory GetHistoricalOhlcDataRequest({
    $core.String? refRequestId,
    $1.PaginationParams? pagination,
    $core.Iterable<$core.String>? instrumentIdAndSymbolRegexes,
    $1.Duration? duration,
    $core.String? metadata,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (pagination != null) result.pagination = pagination;
    if (instrumentIdAndSymbolRegexes != null)
      result.instrumentIdAndSymbolRegexes.addAll(instrumentIdAndSymbolRegexes);
    if (duration != null) result.duration = duration;
    if (metadata != null) result.metadata = metadata;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..pPS(3, _omitFieldNames ? '' : 'instrumentIdAndSymbolRegexes')
    ..aOM<$1.Duration>(4, _omitFieldNames ? '' : 'duration',
        subBuilder: $1.Duration.create)
    ..aOS(5, _omitFieldNames ? '' : 'metadata')
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
  $core.String get metadata => $_getSZ(4);
  @$pb.TagNumber(5)
  set metadata($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMetadata() => $_has(4);
  @$pb.TagNumber(5)
  void clearMetadata() => $_clearField(5);
}

class GetHistoricalOhlcDataResponse extends $pb.GeneratedMessage {
  factory GetHistoricalOhlcDataResponse({
    $core.String? refRequestId,
    $core.String? metadata,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<OhlcData>? ohlcDatas,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (metadata != null) result.metadata = metadata;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (ohlcDatas != null) result.ohlcDatas.addAll(ohlcDatas);
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'metadata')
    ..aOM<$1.PaginationInfo>(3, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<OhlcData>(4, _omitFieldNames ? '' : 'ohlcDatas', $pb.PbFieldType.PM,
        subBuilder: OhlcData.create)
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get metadata => $_getSZ(1);
  @$pb.TagNumber(2)
  set metadata($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMetadata() => $_has(1);
  @$pb.TagNumber(2)
  void clearMetadata() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.PaginationInfo get paginationInfo => $_getN(2);
  @$pb.TagNumber(3)
  set paginationInfo($1.PaginationInfo value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPaginationInfo() => $_has(2);
  @$pb.TagNumber(3)
  void clearPaginationInfo() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.PaginationInfo ensurePaginationInfo() => $_ensure(2);

  @$pb.TagNumber(4)
  $pb.PbList<OhlcData> get ohlcDatas => $_getList(3);
}

class OrderQueryFilter extends $pb.GeneratedMessage {
  factory OrderQueryFilter({
    $1.Time? fromTime,
    $1.Time? toTime,
    $1.OrderSide? side,
    $core.Iterable<$core.String>? orderTypes,
    $core.String? priceMin,
    $core.String? priceMax,
    $core.String? quantityMin,
    $core.String? quantityMax,
    $core.Iterable<$core.bool>? statusFilters,
    $core.String? creatorAddress,
  }) {
    final result = create();
    if (fromTime != null) result.fromTime = fromTime;
    if (toTime != null) result.toTime = toTime;
    if (side != null) result.side = side;
    if (orderTypes != null) result.orderTypes.addAll(orderTypes);
    if (priceMin != null) result.priceMin = priceMin;
    if (priceMax != null) result.priceMax = priceMax;
    if (quantityMin != null) result.quantityMin = quantityMin;
    if (quantityMax != null) result.quantityMax = quantityMax;
    if (statusFilters != null) result.statusFilters.addAll(statusFilters);
    if (creatorAddress != null) result.creatorAddress = creatorAddress;
    return result;
  }

  OrderQueryFilter._();

  factory OrderQueryFilter.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OrderQueryFilter.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OrderQueryFilter',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOM<$1.Time>(1, _omitFieldNames ? '' : 'fromTime',
        subBuilder: $1.Time.create)
    ..aOM<$1.Time>(2, _omitFieldNames ? '' : 'toTime',
        subBuilder: $1.Time.create)
    ..e<$1.OrderSide>(3, _omitFieldNames ? '' : 'side', $pb.PbFieldType.OE,
        defaultOrMaker: $1.OrderSide.ORDER_SIDE__UNKNOWN,
        valueOf: $1.OrderSide.valueOf,
        enumValues: $1.OrderSide.values)
    ..pPS(4, _omitFieldNames ? '' : 'orderTypes')
    ..aOS(5, _omitFieldNames ? '' : 'priceMin')
    ..aOS(6, _omitFieldNames ? '' : 'priceMax')
    ..aOS(7, _omitFieldNames ? '' : 'quantityMin')
    ..aOS(8, _omitFieldNames ? '' : 'quantityMax')
    ..p<$core.bool>(
        9, _omitFieldNames ? '' : 'statusFilters', $pb.PbFieldType.KB)
    ..aOS(10, _omitFieldNames ? '' : 'creatorAddress')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OrderQueryFilter clone() => OrderQueryFilter()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OrderQueryFilter copyWith(void Function(OrderQueryFilter) updates) =>
      super.copyWith((message) => updates(message as OrderQueryFilter))
          as OrderQueryFilter;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OrderQueryFilter create() => OrderQueryFilter._();
  @$core.override
  OrderQueryFilter createEmptyInstance() => create();
  static $pb.PbList<OrderQueryFilter> createRepeated() =>
      $pb.PbList<OrderQueryFilter>();
  @$core.pragma('dart2js:noInline')
  static OrderQueryFilter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OrderQueryFilter>(create);
  static OrderQueryFilter? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Time get fromTime => $_getN(0);
  @$pb.TagNumber(1)
  set fromTime($1.Time value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFromTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromTime() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Time ensureFromTime() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.Time get toTime => $_getN(1);
  @$pb.TagNumber(2)
  set toTime($1.Time value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasToTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearToTime() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Time ensureToTime() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.OrderSide get side => $_getN(2);
  @$pb.TagNumber(3)
  set side($1.OrderSide value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSide() => $_has(2);
  @$pb.TagNumber(3)
  void clearSide() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get orderTypes => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get priceMin => $_getSZ(4);
  @$pb.TagNumber(5)
  set priceMin($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPriceMin() => $_has(4);
  @$pb.TagNumber(5)
  void clearPriceMin() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get priceMax => $_getSZ(5);
  @$pb.TagNumber(6)
  set priceMax($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPriceMax() => $_has(5);
  @$pb.TagNumber(6)
  void clearPriceMax() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get quantityMin => $_getSZ(6);
  @$pb.TagNumber(7)
  set quantityMin($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasQuantityMin() => $_has(6);
  @$pb.TagNumber(7)
  void clearQuantityMin() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get quantityMax => $_getSZ(7);
  @$pb.TagNumber(8)
  set quantityMax($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasQuantityMax() => $_has(7);
  @$pb.TagNumber(8)
  void clearQuantityMax() => $_clearField(8);

  @$pb.TagNumber(9)
  $pb.PbList<$core.bool> get statusFilters => $_getList(8);

  @$pb.TagNumber(10)
  $core.String get creatorAddress => $_getSZ(9);
  @$pb.TagNumber(10)
  set creatorAddress($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCreatorAddress() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatorAddress() => $_clearField(10);
}

class GetInstrumentOrdersRequest extends $pb.GeneratedMessage {
  factory GetInstrumentOrdersRequest({
    $core.String? refRequestId,
    $1.PaginationParams? pagination,
    $core.Iterable<$core.String>? instrumentIdAndSymbolRegexes,
    OrderQueryFilter? orderQueryFilter,
    $core.String? metadata,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (pagination != null) result.pagination = pagination;
    if (instrumentIdAndSymbolRegexes != null)
      result.instrumentIdAndSymbolRegexes.addAll(instrumentIdAndSymbolRegexes);
    if (orderQueryFilter != null) result.orderQueryFilter = orderQueryFilter;
    if (metadata != null) result.metadata = metadata;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..pPS(3, _omitFieldNames ? '' : 'instrumentIdAndSymbolRegexes')
    ..aOM<OrderQueryFilter>(4, _omitFieldNames ? '' : 'orderQueryFilter',
        subBuilder: OrderQueryFilter.create)
    ..aOS(5, _omitFieldNames ? '' : 'metadata')
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
  $pb.PbList<$core.String> get instrumentIdAndSymbolRegexes => $_getList(2);

  @$pb.TagNumber(4)
  OrderQueryFilter get orderQueryFilter => $_getN(3);
  @$pb.TagNumber(4)
  set orderQueryFilter(OrderQueryFilter value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasOrderQueryFilter() => $_has(3);
  @$pb.TagNumber(4)
  void clearOrderQueryFilter() => $_clearField(4);
  @$pb.TagNumber(4)
  OrderQueryFilter ensureOrderQueryFilter() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get metadata => $_getSZ(4);
  @$pb.TagNumber(5)
  set metadata($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMetadata() => $_has(4);
  @$pb.TagNumber(5)
  void clearMetadata() => $_clearField(5);
}

class GetInstrumentOrdersResponse extends $pb.GeneratedMessage {
  factory GetInstrumentOrdersResponse({
    $core.String? refRequestId,
    $core.String? metadata,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<$1.Order>? orders,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (metadata != null) result.metadata = metadata;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (orders != null) result.orders.addAll(orders);
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'metadata')
    ..aOM<$1.PaginationInfo>(3, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<$1.Order>(4, _omitFieldNames ? '' : 'orders', $pb.PbFieldType.PM,
        subBuilder: $1.Order.create)
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get metadata => $_getSZ(1);
  @$pb.TagNumber(2)
  set metadata($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMetadata() => $_has(1);
  @$pb.TagNumber(2)
  void clearMetadata() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.PaginationInfo get paginationInfo => $_getN(2);
  @$pb.TagNumber(3)
  set paginationInfo($1.PaginationInfo value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPaginationInfo() => $_has(2);
  @$pb.TagNumber(3)
  void clearPaginationInfo() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.PaginationInfo ensurePaginationInfo() => $_ensure(2);

  @$pb.TagNumber(4)
  $pb.PbList<$1.Order> get orders => $_getList(3);
}

class TradeQueryFilter extends $pb.GeneratedMessage {
  factory TradeQueryFilter({
    $1.Time? fromTime,
    $1.Time? toTime,
    $core.String? priceMin,
    $core.String? priceMax,
    $core.String? volumeMin,
    $core.String? volumeMax,
    $core.Iterable<$core.String>? tradeTypes,
    $1.OrderSide? side,
  }) {
    final result = create();
    if (fromTime != null) result.fromTime = fromTime;
    if (toTime != null) result.toTime = toTime;
    if (priceMin != null) result.priceMin = priceMin;
    if (priceMax != null) result.priceMax = priceMax;
    if (volumeMin != null) result.volumeMin = volumeMin;
    if (volumeMax != null) result.volumeMax = volumeMax;
    if (tradeTypes != null) result.tradeTypes.addAll(tradeTypes);
    if (side != null) result.side = side;
    return result;
  }

  TradeQueryFilter._();

  factory TradeQueryFilter.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TradeQueryFilter.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TradeQueryFilter',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOM<$1.Time>(1, _omitFieldNames ? '' : 'fromTime',
        subBuilder: $1.Time.create)
    ..aOM<$1.Time>(2, _omitFieldNames ? '' : 'toTime',
        subBuilder: $1.Time.create)
    ..aOS(3, _omitFieldNames ? '' : 'priceMin')
    ..aOS(4, _omitFieldNames ? '' : 'priceMax')
    ..aOS(5, _omitFieldNames ? '' : 'volumeMin')
    ..aOS(6, _omitFieldNames ? '' : 'volumeMax')
    ..pPS(7, _omitFieldNames ? '' : 'tradeTypes')
    ..e<$1.OrderSide>(8, _omitFieldNames ? '' : 'side', $pb.PbFieldType.OE,
        defaultOrMaker: $1.OrderSide.ORDER_SIDE__UNKNOWN,
        valueOf: $1.OrderSide.valueOf,
        enumValues: $1.OrderSide.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TradeQueryFilter clone() => TradeQueryFilter()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TradeQueryFilter copyWith(void Function(TradeQueryFilter) updates) =>
      super.copyWith((message) => updates(message as TradeQueryFilter))
          as TradeQueryFilter;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TradeQueryFilter create() => TradeQueryFilter._();
  @$core.override
  TradeQueryFilter createEmptyInstance() => create();
  static $pb.PbList<TradeQueryFilter> createRepeated() =>
      $pb.PbList<TradeQueryFilter>();
  @$core.pragma('dart2js:noInline')
  static TradeQueryFilter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TradeQueryFilter>(create);
  static TradeQueryFilter? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Time get fromTime => $_getN(0);
  @$pb.TagNumber(1)
  set fromTime($1.Time value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFromTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromTime() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Time ensureFromTime() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.Time get toTime => $_getN(1);
  @$pb.TagNumber(2)
  set toTime($1.Time value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasToTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearToTime() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Time ensureToTime() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get priceMin => $_getSZ(2);
  @$pb.TagNumber(3)
  set priceMin($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPriceMin() => $_has(2);
  @$pb.TagNumber(3)
  void clearPriceMin() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get priceMax => $_getSZ(3);
  @$pb.TagNumber(4)
  set priceMax($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPriceMax() => $_has(3);
  @$pb.TagNumber(4)
  void clearPriceMax() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get volumeMin => $_getSZ(4);
  @$pb.TagNumber(5)
  set volumeMin($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasVolumeMin() => $_has(4);
  @$pb.TagNumber(5)
  void clearVolumeMin() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get volumeMax => $_getSZ(5);
  @$pb.TagNumber(6)
  set volumeMax($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasVolumeMax() => $_has(5);
  @$pb.TagNumber(6)
  void clearVolumeMax() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get tradeTypes => $_getList(6);

  @$pb.TagNumber(8)
  $1.OrderSide get side => $_getN(7);
  @$pb.TagNumber(8)
  set side($1.OrderSide value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasSide() => $_has(7);
  @$pb.TagNumber(8)
  void clearSide() => $_clearField(8);
}

class GetInstrumentTradesRequest extends $pb.GeneratedMessage {
  factory GetInstrumentTradesRequest({
    $core.String? refRequestId,
    $1.PaginationParams? pagination,
    $core.Iterable<$core.String>? instrumentIdAndSymbolRegexes,
    TradeQueryFilter? tradeQueryFilter,
    $core.String? metadata,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (pagination != null) result.pagination = pagination;
    if (instrumentIdAndSymbolRegexes != null)
      result.instrumentIdAndSymbolRegexes.addAll(instrumentIdAndSymbolRegexes);
    if (tradeQueryFilter != null) result.tradeQueryFilter = tradeQueryFilter;
    if (metadata != null) result.metadata = metadata;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..pPS(3, _omitFieldNames ? '' : 'instrumentIdAndSymbolRegexes')
    ..aOM<TradeQueryFilter>(4, _omitFieldNames ? '' : 'tradeQueryFilter',
        subBuilder: TradeQueryFilter.create)
    ..aOS(5, _omitFieldNames ? '' : 'metadata')
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
  $pb.PbList<$core.String> get instrumentIdAndSymbolRegexes => $_getList(2);

  @$pb.TagNumber(4)
  TradeQueryFilter get tradeQueryFilter => $_getN(3);
  @$pb.TagNumber(4)
  set tradeQueryFilter(TradeQueryFilter value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasTradeQueryFilter() => $_has(3);
  @$pb.TagNumber(4)
  void clearTradeQueryFilter() => $_clearField(4);
  @$pb.TagNumber(4)
  TradeQueryFilter ensureTradeQueryFilter() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get metadata => $_getSZ(4);
  @$pb.TagNumber(5)
  set metadata($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMetadata() => $_has(4);
  @$pb.TagNumber(5)
  void clearMetadata() => $_clearField(5);
}

class GetInstrumentTradesResponse extends $pb.GeneratedMessage {
  factory GetInstrumentTradesResponse({
    $core.String? refRequestId,
    $core.String? metadata,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<$1.Trade>? trades,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (metadata != null) result.metadata = metadata;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (trades != null) result.trades.addAll(trades);
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'metadata')
    ..aOM<$1.PaginationInfo>(3, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<$1.Trade>(4, _omitFieldNames ? '' : 'trades', $pb.PbFieldType.PM,
        subBuilder: $1.Trade.create)
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get metadata => $_getSZ(1);
  @$pb.TagNumber(2)
  set metadata($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMetadata() => $_has(1);
  @$pb.TagNumber(2)
  void clearMetadata() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.PaginationInfo get paginationInfo => $_getN(2);
  @$pb.TagNumber(3)
  set paginationInfo($1.PaginationInfo value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPaginationInfo() => $_has(2);
  @$pb.TagNumber(3)
  void clearPaginationInfo() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.PaginationInfo ensurePaginationInfo() => $_ensure(2);

  @$pb.TagNumber(4)
  $pb.PbList<$1.Trade> get trades => $_getList(3);
}

class SettlementQueryFilter extends $pb.GeneratedMessage {
  factory SettlementQueryFilter({
    $1.Time? fromTime,
    $1.Time? toTime,
    $1.ConfirmationStatus? status,
    $core.Iterable<$core.String>? settlementTypes,
    $core.Iterable<$core.String>? assetIdOrNameRegexes,
    $core.String? amountMin,
    $core.String? amountMax,
  }) {
    final result = create();
    if (fromTime != null) result.fromTime = fromTime;
    if (toTime != null) result.toTime = toTime;
    if (status != null) result.status = status;
    if (settlementTypes != null) result.settlementTypes.addAll(settlementTypes);
    if (assetIdOrNameRegexes != null)
      result.assetIdOrNameRegexes.addAll(assetIdOrNameRegexes);
    if (amountMin != null) result.amountMin = amountMin;
    if (amountMax != null) result.amountMax = amountMax;
    return result;
  }

  SettlementQueryFilter._();

  factory SettlementQueryFilter.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SettlementQueryFilter.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SettlementQueryFilter',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOM<$1.Time>(1, _omitFieldNames ? '' : 'fromTime',
        subBuilder: $1.Time.create)
    ..aOM<$1.Time>(2, _omitFieldNames ? '' : 'toTime',
        subBuilder: $1.Time.create)
    ..e<$1.ConfirmationStatus>(
        3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: $1.ConfirmationStatus.CONFIRMATION_STATUS__UNKNOWN,
        valueOf: $1.ConfirmationStatus.valueOf,
        enumValues: $1.ConfirmationStatus.values)
    ..pPS(4, _omitFieldNames ? '' : 'settlementTypes')
    ..pPS(5, _omitFieldNames ? '' : 'assetIdOrNameRegexes')
    ..aOS(6, _omitFieldNames ? '' : 'amountMin')
    ..aOS(7, _omitFieldNames ? '' : 'amountMax')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SettlementQueryFilter clone() =>
      SettlementQueryFilter()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SettlementQueryFilter copyWith(
          void Function(SettlementQueryFilter) updates) =>
      super.copyWith((message) => updates(message as SettlementQueryFilter))
          as SettlementQueryFilter;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SettlementQueryFilter create() => SettlementQueryFilter._();
  @$core.override
  SettlementQueryFilter createEmptyInstance() => create();
  static $pb.PbList<SettlementQueryFilter> createRepeated() =>
      $pb.PbList<SettlementQueryFilter>();
  @$core.pragma('dart2js:noInline')
  static SettlementQueryFilter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SettlementQueryFilter>(create);
  static SettlementQueryFilter? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Time get fromTime => $_getN(0);
  @$pb.TagNumber(1)
  set fromTime($1.Time value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFromTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromTime() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Time ensureFromTime() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.Time get toTime => $_getN(1);
  @$pb.TagNumber(2)
  set toTime($1.Time value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasToTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearToTime() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Time ensureToTime() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.ConfirmationStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status($1.ConfirmationStatus value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get settlementTypes => $_getList(3);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get assetIdOrNameRegexes => $_getList(4);

  @$pb.TagNumber(6)
  $core.String get amountMin => $_getSZ(5);
  @$pb.TagNumber(6)
  set amountMin($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmountMin() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmountMin() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get amountMax => $_getSZ(6);
  @$pb.TagNumber(7)
  set amountMax($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAmountMax() => $_has(6);
  @$pb.TagNumber(7)
  void clearAmountMax() => $_clearField(7);
}

class GetInstrumentSettlementsRequest extends $pb.GeneratedMessage {
  factory GetInstrumentSettlementsRequest({
    $core.String? refRequestId,
    $1.PaginationParams? pagination,
    $core.Iterable<$core.String>? instrumentIdAndSymbolRegexes,
    SettlementQueryFilter? settlementQueryFilter,
    $core.String? metadata,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (pagination != null) result.pagination = pagination;
    if (instrumentIdAndSymbolRegexes != null)
      result.instrumentIdAndSymbolRegexes.addAll(instrumentIdAndSymbolRegexes);
    if (settlementQueryFilter != null)
      result.settlementQueryFilter = settlementQueryFilter;
    if (metadata != null) result.metadata = metadata;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..pPS(3, _omitFieldNames ? '' : 'instrumentIdAndSymbolRegexes')
    ..aOM<SettlementQueryFilter>(
        4, _omitFieldNames ? '' : 'settlementQueryFilter',
        subBuilder: SettlementQueryFilter.create)
    ..aOS(5, _omitFieldNames ? '' : 'metadata')
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
  $pb.PbList<$core.String> get instrumentIdAndSymbolRegexes => $_getList(2);

  @$pb.TagNumber(4)
  SettlementQueryFilter get settlementQueryFilter => $_getN(3);
  @$pb.TagNumber(4)
  set settlementQueryFilter(SettlementQueryFilter value) =>
      $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasSettlementQueryFilter() => $_has(3);
  @$pb.TagNumber(4)
  void clearSettlementQueryFilter() => $_clearField(4);
  @$pb.TagNumber(4)
  SettlementQueryFilter ensureSettlementQueryFilter() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get metadata => $_getSZ(4);
  @$pb.TagNumber(5)
  set metadata($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMetadata() => $_has(4);
  @$pb.TagNumber(5)
  void clearMetadata() => $_clearField(5);
}

class GetInstrumentSettlementsResponse extends $pb.GeneratedMessage {
  factory GetInstrumentSettlementsResponse({
    $core.String? refRequestId,
    $core.String? metadata,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<$1.Settlement>? settlements,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (metadata != null) result.metadata = metadata;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (settlements != null) result.settlements.addAll(settlements);
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'metadata')
    ..aOM<$1.PaginationInfo>(3, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<$1.Settlement>(
        4, _omitFieldNames ? '' : 'settlements', $pb.PbFieldType.PM,
        subBuilder: $1.Settlement.create)
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get metadata => $_getSZ(1);
  @$pb.TagNumber(2)
  set metadata($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMetadata() => $_has(1);
  @$pb.TagNumber(2)
  void clearMetadata() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.PaginationInfo get paginationInfo => $_getN(2);
  @$pb.TagNumber(3)
  set paginationInfo($1.PaginationInfo value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPaginationInfo() => $_has(2);
  @$pb.TagNumber(3)
  void clearPaginationInfo() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.PaginationInfo ensurePaginationInfo() => $_ensure(2);

  @$pb.TagNumber(4)
  $pb.PbList<$1.Settlement> get settlements => $_getList(3);
}

class OrderbookQueryFilter extends $pb.GeneratedMessage {
  factory OrderbookQueryFilter({
    $core.bool? aggregated,
    $1.OrderSide? side,
    $core.int? depth,
    $core.String? priceMin,
    $core.String? priceMax,
    $core.bool? includeMyOrders,
    $core.String? groupByPriceIncrement,
  }) {
    final result = create();
    if (aggregated != null) result.aggregated = aggregated;
    if (side != null) result.side = side;
    if (depth != null) result.depth = depth;
    if (priceMin != null) result.priceMin = priceMin;
    if (priceMax != null) result.priceMax = priceMax;
    if (includeMyOrders != null) result.includeMyOrders = includeMyOrders;
    if (groupByPriceIncrement != null)
      result.groupByPriceIncrement = groupByPriceIncrement;
    return result;
  }

  OrderbookQueryFilter._();

  factory OrderbookQueryFilter.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OrderbookQueryFilter.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OrderbookQueryFilter',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'aggregated')
    ..e<$1.OrderSide>(2, _omitFieldNames ? '' : 'side', $pb.PbFieldType.OE,
        defaultOrMaker: $1.OrderSide.ORDER_SIDE__UNKNOWN,
        valueOf: $1.OrderSide.valueOf,
        enumValues: $1.OrderSide.values)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'depth', $pb.PbFieldType.OU3)
    ..aOS(4, _omitFieldNames ? '' : 'priceMin')
    ..aOS(5, _omitFieldNames ? '' : 'priceMax')
    ..aOB(6, _omitFieldNames ? '' : 'includeMyOrders')
    ..aOS(7, _omitFieldNames ? '' : 'groupByPriceIncrement')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OrderbookQueryFilter clone() =>
      OrderbookQueryFilter()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OrderbookQueryFilter copyWith(void Function(OrderbookQueryFilter) updates) =>
      super.copyWith((message) => updates(message as OrderbookQueryFilter))
          as OrderbookQueryFilter;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OrderbookQueryFilter create() => OrderbookQueryFilter._();
  @$core.override
  OrderbookQueryFilter createEmptyInstance() => create();
  static $pb.PbList<OrderbookQueryFilter> createRepeated() =>
      $pb.PbList<OrderbookQueryFilter>();
  @$core.pragma('dart2js:noInline')
  static OrderbookQueryFilter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OrderbookQueryFilter>(create);
  static OrderbookQueryFilter? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get aggregated => $_getBF(0);
  @$pb.TagNumber(1)
  set aggregated($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAggregated() => $_has(0);
  @$pb.TagNumber(1)
  void clearAggregated() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.OrderSide get side => $_getN(1);
  @$pb.TagNumber(2)
  set side($1.OrderSide value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasSide() => $_has(1);
  @$pb.TagNumber(2)
  void clearSide() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get depth => $_getIZ(2);
  @$pb.TagNumber(3)
  set depth($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDepth() => $_has(2);
  @$pb.TagNumber(3)
  void clearDepth() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get priceMin => $_getSZ(3);
  @$pb.TagNumber(4)
  set priceMin($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPriceMin() => $_has(3);
  @$pb.TagNumber(4)
  void clearPriceMin() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get priceMax => $_getSZ(4);
  @$pb.TagNumber(5)
  set priceMax($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPriceMax() => $_has(4);
  @$pb.TagNumber(5)
  void clearPriceMax() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get includeMyOrders => $_getBF(5);
  @$pb.TagNumber(6)
  set includeMyOrders($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIncludeMyOrders() => $_has(5);
  @$pb.TagNumber(6)
  void clearIncludeMyOrders() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get groupByPriceIncrement => $_getSZ(6);
  @$pb.TagNumber(7)
  set groupByPriceIncrement($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasGroupByPriceIncrement() => $_has(6);
  @$pb.TagNumber(7)
  void clearGroupByPriceIncrement() => $_clearField(7);
}

class GetOrderbookRequest extends $pb.GeneratedMessage {
  factory GetOrderbookRequest({
    $core.String? refRequestId,
    $1.PaginationParams? pagination,
    $core.String? instrumentId,
    OrderbookQueryFilter? orderbookQueryFilter,
    $core.String? metadata,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (pagination != null) result.pagination = pagination;
    if (instrumentId != null) result.instrumentId = instrumentId;
    if (orderbookQueryFilter != null)
      result.orderbookQueryFilter = orderbookQueryFilter;
    if (metadata != null) result.metadata = metadata;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..aOS(3, _omitFieldNames ? '' : 'instrumentId')
    ..aOM<OrderbookQueryFilter>(
        4, _omitFieldNames ? '' : 'orderbookQueryFilter',
        subBuilder: OrderbookQueryFilter.create)
    ..aOS(5, _omitFieldNames ? '' : 'metadata')
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
  $core.String get instrumentId => $_getSZ(2);
  @$pb.TagNumber(3)
  set instrumentId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInstrumentId() => $_has(2);
  @$pb.TagNumber(3)
  void clearInstrumentId() => $_clearField(3);

  @$pb.TagNumber(4)
  OrderbookQueryFilter get orderbookQueryFilter => $_getN(3);
  @$pb.TagNumber(4)
  set orderbookQueryFilter(OrderbookQueryFilter value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasOrderbookQueryFilter() => $_has(3);
  @$pb.TagNumber(4)
  void clearOrderbookQueryFilter() => $_clearField(4);
  @$pb.TagNumber(4)
  OrderbookQueryFilter ensureOrderbookQueryFilter() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get metadata => $_getSZ(4);
  @$pb.TagNumber(5)
  set metadata($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMetadata() => $_has(4);
  @$pb.TagNumber(5)
  void clearMetadata() => $_clearField(5);
}

class OrderList extends $pb.GeneratedMessage {
  factory OrderList({
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<$1.Order>? orders,
  }) {
    final result = create();
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (orders != null) result.orders.addAll(orders);
    return result;
  }

  OrderList._();

  factory OrderList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OrderList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OrderList',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOM<$1.PaginationInfo>(1, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<$1.Order>(2, _omitFieldNames ? '' : 'orders', $pb.PbFieldType.PM,
        subBuilder: $1.Order.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OrderList clone() => OrderList()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OrderList copyWith(void Function(OrderList) updates) =>
      super.copyWith((message) => updates(message as OrderList)) as OrderList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OrderList create() => OrderList._();
  @$core.override
  OrderList createEmptyInstance() => create();
  static $pb.PbList<OrderList> createRepeated() => $pb.PbList<OrderList>();
  @$core.pragma('dart2js:noInline')
  static OrderList getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OrderList>(create);
  static OrderList? _defaultInstance;

  @$pb.TagNumber(1)
  $1.PaginationInfo get paginationInfo => $_getN(0);
  @$pb.TagNumber(1)
  set paginationInfo($1.PaginationInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPaginationInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaginationInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.PaginationInfo ensurePaginationInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<$1.Order> get orders => $_getList(1);
}

class GetOrderbookResponse extends $pb.GeneratedMessage {
  factory GetOrderbookResponse({
    $core.String? refRequestId,
    $core.String? metadata,
    $1.Instrument? instrument,
    OrderList? buyList,
    OrderList? sellList,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (metadata != null) result.metadata = metadata;
    if (instrument != null) result.instrument = instrument;
    if (buyList != null) result.buyList = buyList;
    if (sellList != null) result.sellList = sellList;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'metadata')
    ..aOM<$1.Instrument>(3, _omitFieldNames ? '' : 'instrument',
        subBuilder: $1.Instrument.create)
    ..aOM<OrderList>(4, _omitFieldNames ? '' : 'buyList',
        subBuilder: OrderList.create)
    ..aOM<OrderList>(5, _omitFieldNames ? '' : 'sellList',
        subBuilder: OrderList.create)
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get metadata => $_getSZ(1);
  @$pb.TagNumber(2)
  set metadata($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMetadata() => $_has(1);
  @$pb.TagNumber(2)
  void clearMetadata() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.Instrument get instrument => $_getN(2);
  @$pb.TagNumber(3)
  set instrument($1.Instrument value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasInstrument() => $_has(2);
  @$pb.TagNumber(3)
  void clearInstrument() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Instrument ensureInstrument() => $_ensure(2);

  @$pb.TagNumber(4)
  OrderList get buyList => $_getN(3);
  @$pb.TagNumber(4)
  set buyList(OrderList value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasBuyList() => $_has(3);
  @$pb.TagNumber(4)
  void clearBuyList() => $_clearField(4);
  @$pb.TagNumber(4)
  OrderList ensureBuyList() => $_ensure(3);

  @$pb.TagNumber(5)
  OrderList get sellList => $_getN(4);
  @$pb.TagNumber(5)
  set sellList(OrderList value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasSellList() => $_has(4);
  @$pb.TagNumber(5)
  void clearSellList() => $_clearField(5);
  @$pb.TagNumber(5)
  OrderList ensureSellList() => $_ensure(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
