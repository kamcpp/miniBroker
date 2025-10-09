//
//  Generated code. Do not modify.
//  source: filter.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $1;
import 'fin_common.pb.dart' as $9;
import 'fin_common.pbenum.dart' as $9;

class OrderQueryFilter extends $pb.GeneratedMessage {
  factory OrderQueryFilter({
    $1.DateTime? fromDt,
    $1.DateTime? toDt,
    $9.OrderSide? side,
    $core.Iterable<$core.String>? orderTypes,
    $core.String? priceMin,
    $core.String? priceMax,
    $core.String? quantityMin,
    $core.String? quantityMax,
    $core.Iterable<$core.bool>? statusFilters,
    $core.String? creatorAddress,
  }) {
    final $result = create();
    if (fromDt != null) {
      $result.fromDt = fromDt;
    }
    if (toDt != null) {
      $result.toDt = toDt;
    }
    if (side != null) {
      $result.side = side;
    }
    if (orderTypes != null) {
      $result.orderTypes.addAll(orderTypes);
    }
    if (priceMin != null) {
      $result.priceMin = priceMin;
    }
    if (priceMax != null) {
      $result.priceMax = priceMax;
    }
    if (quantityMin != null) {
      $result.quantityMin = quantityMin;
    }
    if (quantityMax != null) {
      $result.quantityMax = quantityMax;
    }
    if (statusFilters != null) {
      $result.statusFilters.addAll(statusFilters);
    }
    if (creatorAddress != null) {
      $result.creatorAddress = creatorAddress;
    }
    return $result;
  }
  OrderQueryFilter._() : super();
  factory OrderQueryFilter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OrderQueryFilter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OrderQueryFilter', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOM<$1.DateTime>(1, _omitFieldNames ? '' : 'fromDt', subBuilder: $1.DateTime.create)
    ..aOM<$1.DateTime>(2, _omitFieldNames ? '' : 'toDt', subBuilder: $1.DateTime.create)
    ..e<$9.OrderSide>(3, _omitFieldNames ? '' : 'side', $pb.PbFieldType.OE, defaultOrMaker: $9.OrderSide.ORDER_SIDE__UNKNOWN, valueOf: $9.OrderSide.valueOf, enumValues: $9.OrderSide.values)
    ..pPS(4, _omitFieldNames ? '' : 'orderTypes')
    ..aOS(5, _omitFieldNames ? '' : 'priceMin')
    ..aOS(6, _omitFieldNames ? '' : 'priceMax')
    ..aOS(7, _omitFieldNames ? '' : 'quantityMin')
    ..aOS(8, _omitFieldNames ? '' : 'quantityMax')
    ..p<$core.bool>(9, _omitFieldNames ? '' : 'statusFilters', $pb.PbFieldType.KB)
    ..aOS(10, _omitFieldNames ? '' : 'creatorAddress')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OrderQueryFilter clone() => OrderQueryFilter()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OrderQueryFilter copyWith(void Function(OrderQueryFilter) updates) => super.copyWith((message) => updates(message as OrderQueryFilter)) as OrderQueryFilter;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OrderQueryFilter create() => OrderQueryFilter._();
  OrderQueryFilter createEmptyInstance() => create();
  static $pb.PbList<OrderQueryFilter> createRepeated() => $pb.PbList<OrderQueryFilter>();
  @$core.pragma('dart2js:noInline')
  static OrderQueryFilter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OrderQueryFilter>(create);
  static OrderQueryFilter? _defaultInstance;

  @$pb.TagNumber(1)
  $1.DateTime get fromDt => $_getN(0);
  @$pb.TagNumber(1)
  set fromDt($1.DateTime v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFromDt() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromDt() => clearField(1);
  @$pb.TagNumber(1)
  $1.DateTime ensureFromDt() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.DateTime get toDt => $_getN(1);
  @$pb.TagNumber(2)
  set toDt($1.DateTime v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasToDt() => $_has(1);
  @$pb.TagNumber(2)
  void clearToDt() => clearField(2);
  @$pb.TagNumber(2)
  $1.DateTime ensureToDt() => $_ensure(1);

  @$pb.TagNumber(3)
  $9.OrderSide get side => $_getN(2);
  @$pb.TagNumber(3)
  set side($9.OrderSide v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasSide() => $_has(2);
  @$pb.TagNumber(3)
  void clearSide() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.String> get orderTypes => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get priceMin => $_getSZ(4);
  @$pb.TagNumber(5)
  set priceMin($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPriceMin() => $_has(4);
  @$pb.TagNumber(5)
  void clearPriceMin() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get priceMax => $_getSZ(5);
  @$pb.TagNumber(6)
  set priceMax($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPriceMax() => $_has(5);
  @$pb.TagNumber(6)
  void clearPriceMax() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get quantityMin => $_getSZ(6);
  @$pb.TagNumber(7)
  set quantityMin($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasQuantityMin() => $_has(6);
  @$pb.TagNumber(7)
  void clearQuantityMin() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get quantityMax => $_getSZ(7);
  @$pb.TagNumber(8)
  set quantityMax($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasQuantityMax() => $_has(7);
  @$pb.TagNumber(8)
  void clearQuantityMax() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<$core.bool> get statusFilters => $_getList(8);

  @$pb.TagNumber(10)
  $core.String get creatorAddress => $_getSZ(9);
  @$pb.TagNumber(10)
  set creatorAddress($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreatorAddress() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatorAddress() => clearField(10);
}

class TradeQueryFilter extends $pb.GeneratedMessage {
  factory TradeQueryFilter({
    $1.DateTime? fromDt,
    $1.DateTime? toDt,
    $core.String? priceMin,
    $core.String? priceMax,
    $core.String? volumeMin,
    $core.String? volumeMax,
    $core.Iterable<$core.String>? tradeTypes,
    $9.OrderSide? side,
  }) {
    final $result = create();
    if (fromDt != null) {
      $result.fromDt = fromDt;
    }
    if (toDt != null) {
      $result.toDt = toDt;
    }
    if (priceMin != null) {
      $result.priceMin = priceMin;
    }
    if (priceMax != null) {
      $result.priceMax = priceMax;
    }
    if (volumeMin != null) {
      $result.volumeMin = volumeMin;
    }
    if (volumeMax != null) {
      $result.volumeMax = volumeMax;
    }
    if (tradeTypes != null) {
      $result.tradeTypes.addAll(tradeTypes);
    }
    if (side != null) {
      $result.side = side;
    }
    return $result;
  }
  TradeQueryFilter._() : super();
  factory TradeQueryFilter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TradeQueryFilter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TradeQueryFilter', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOM<$1.DateTime>(1, _omitFieldNames ? '' : 'fromDt', subBuilder: $1.DateTime.create)
    ..aOM<$1.DateTime>(2, _omitFieldNames ? '' : 'toDt', subBuilder: $1.DateTime.create)
    ..aOS(3, _omitFieldNames ? '' : 'priceMin')
    ..aOS(4, _omitFieldNames ? '' : 'priceMax')
    ..aOS(5, _omitFieldNames ? '' : 'volumeMin')
    ..aOS(6, _omitFieldNames ? '' : 'volumeMax')
    ..pPS(7, _omitFieldNames ? '' : 'tradeTypes')
    ..e<$9.OrderSide>(8, _omitFieldNames ? '' : 'side', $pb.PbFieldType.OE, defaultOrMaker: $9.OrderSide.ORDER_SIDE__UNKNOWN, valueOf: $9.OrderSide.valueOf, enumValues: $9.OrderSide.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TradeQueryFilter clone() => TradeQueryFilter()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TradeQueryFilter copyWith(void Function(TradeQueryFilter) updates) => super.copyWith((message) => updates(message as TradeQueryFilter)) as TradeQueryFilter;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TradeQueryFilter create() => TradeQueryFilter._();
  TradeQueryFilter createEmptyInstance() => create();
  static $pb.PbList<TradeQueryFilter> createRepeated() => $pb.PbList<TradeQueryFilter>();
  @$core.pragma('dart2js:noInline')
  static TradeQueryFilter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TradeQueryFilter>(create);
  static TradeQueryFilter? _defaultInstance;

  @$pb.TagNumber(1)
  $1.DateTime get fromDt => $_getN(0);
  @$pb.TagNumber(1)
  set fromDt($1.DateTime v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFromDt() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromDt() => clearField(1);
  @$pb.TagNumber(1)
  $1.DateTime ensureFromDt() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.DateTime get toDt => $_getN(1);
  @$pb.TagNumber(2)
  set toDt($1.DateTime v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasToDt() => $_has(1);
  @$pb.TagNumber(2)
  void clearToDt() => clearField(2);
  @$pb.TagNumber(2)
  $1.DateTime ensureToDt() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get priceMin => $_getSZ(2);
  @$pb.TagNumber(3)
  set priceMin($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPriceMin() => $_has(2);
  @$pb.TagNumber(3)
  void clearPriceMin() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get priceMax => $_getSZ(3);
  @$pb.TagNumber(4)
  set priceMax($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPriceMax() => $_has(3);
  @$pb.TagNumber(4)
  void clearPriceMax() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get volumeMin => $_getSZ(4);
  @$pb.TagNumber(5)
  set volumeMin($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasVolumeMin() => $_has(4);
  @$pb.TagNumber(5)
  void clearVolumeMin() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get volumeMax => $_getSZ(5);
  @$pb.TagNumber(6)
  set volumeMax($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasVolumeMax() => $_has(5);
  @$pb.TagNumber(6)
  void clearVolumeMax() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.String> get tradeTypes => $_getList(6);

  @$pb.TagNumber(8)
  $9.OrderSide get side => $_getN(7);
  @$pb.TagNumber(8)
  set side($9.OrderSide v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasSide() => $_has(7);
  @$pb.TagNumber(8)
  void clearSide() => clearField(8);
}

class SettlementQueryFilter extends $pb.GeneratedMessage {
  factory SettlementQueryFilter({
    $1.DateTime? fromDt,
    $1.DateTime? toDt,
    $9.ConfirmationStatus? status,
    $core.Iterable<$core.String>? settlementTypes,
    $core.Iterable<$core.String>? assetIdOrNameRegexes,
    $core.String? amountMin,
    $core.String? amountMax,
  }) {
    final $result = create();
    if (fromDt != null) {
      $result.fromDt = fromDt;
    }
    if (toDt != null) {
      $result.toDt = toDt;
    }
    if (status != null) {
      $result.status = status;
    }
    if (settlementTypes != null) {
      $result.settlementTypes.addAll(settlementTypes);
    }
    if (assetIdOrNameRegexes != null) {
      $result.assetIdOrNameRegexes.addAll(assetIdOrNameRegexes);
    }
    if (amountMin != null) {
      $result.amountMin = amountMin;
    }
    if (amountMax != null) {
      $result.amountMax = amountMax;
    }
    return $result;
  }
  SettlementQueryFilter._() : super();
  factory SettlementQueryFilter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SettlementQueryFilter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SettlementQueryFilter', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOM<$1.DateTime>(1, _omitFieldNames ? '' : 'fromDt', subBuilder: $1.DateTime.create)
    ..aOM<$1.DateTime>(2, _omitFieldNames ? '' : 'toDt', subBuilder: $1.DateTime.create)
    ..e<$9.ConfirmationStatus>(3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: $9.ConfirmationStatus.CONFIRMATION_STATUS__UNKNOWN, valueOf: $9.ConfirmationStatus.valueOf, enumValues: $9.ConfirmationStatus.values)
    ..pPS(4, _omitFieldNames ? '' : 'settlementTypes')
    ..pPS(5, _omitFieldNames ? '' : 'assetIdOrNameRegexes')
    ..aOS(6, _omitFieldNames ? '' : 'amountMin')
    ..aOS(7, _omitFieldNames ? '' : 'amountMax')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SettlementQueryFilter clone() => SettlementQueryFilter()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SettlementQueryFilter copyWith(void Function(SettlementQueryFilter) updates) => super.copyWith((message) => updates(message as SettlementQueryFilter)) as SettlementQueryFilter;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SettlementQueryFilter create() => SettlementQueryFilter._();
  SettlementQueryFilter createEmptyInstance() => create();
  static $pb.PbList<SettlementQueryFilter> createRepeated() => $pb.PbList<SettlementQueryFilter>();
  @$core.pragma('dart2js:noInline')
  static SettlementQueryFilter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SettlementQueryFilter>(create);
  static SettlementQueryFilter? _defaultInstance;

  @$pb.TagNumber(1)
  $1.DateTime get fromDt => $_getN(0);
  @$pb.TagNumber(1)
  set fromDt($1.DateTime v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFromDt() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromDt() => clearField(1);
  @$pb.TagNumber(1)
  $1.DateTime ensureFromDt() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.DateTime get toDt => $_getN(1);
  @$pb.TagNumber(2)
  set toDt($1.DateTime v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasToDt() => $_has(1);
  @$pb.TagNumber(2)
  void clearToDt() => clearField(2);
  @$pb.TagNumber(2)
  $1.DateTime ensureToDt() => $_ensure(1);

  @$pb.TagNumber(3)
  $9.ConfirmationStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status($9.ConfirmationStatus v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.String> get settlementTypes => $_getList(3);

  @$pb.TagNumber(5)
  $core.List<$core.String> get assetIdOrNameRegexes => $_getList(4);

  @$pb.TagNumber(6)
  $core.String get amountMin => $_getSZ(5);
  @$pb.TagNumber(6)
  set amountMin($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAmountMin() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmountMin() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get amountMax => $_getSZ(6);
  @$pb.TagNumber(7)
  set amountMax($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAmountMax() => $_has(6);
  @$pb.TagNumber(7)
  void clearAmountMax() => clearField(7);
}

class OrderbookQueryFilter extends $pb.GeneratedMessage {
  factory OrderbookQueryFilter({
    $core.bool? aggregated,
    $9.OrderSide? side,
    $core.int? depth,
    $core.String? priceMin,
    $core.String? priceMax,
    $core.bool? includeMyOrders,
    $core.String? groupByPriceIncrement,
  }) {
    final $result = create();
    if (aggregated != null) {
      $result.aggregated = aggregated;
    }
    if (side != null) {
      $result.side = side;
    }
    if (depth != null) {
      $result.depth = depth;
    }
    if (priceMin != null) {
      $result.priceMin = priceMin;
    }
    if (priceMax != null) {
      $result.priceMax = priceMax;
    }
    if (includeMyOrders != null) {
      $result.includeMyOrders = includeMyOrders;
    }
    if (groupByPriceIncrement != null) {
      $result.groupByPriceIncrement = groupByPriceIncrement;
    }
    return $result;
  }
  OrderbookQueryFilter._() : super();
  factory OrderbookQueryFilter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OrderbookQueryFilter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OrderbookQueryFilter', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'aggregated')
    ..e<$9.OrderSide>(2, _omitFieldNames ? '' : 'side', $pb.PbFieldType.OE, defaultOrMaker: $9.OrderSide.ORDER_SIDE__UNKNOWN, valueOf: $9.OrderSide.valueOf, enumValues: $9.OrderSide.values)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'depth', $pb.PbFieldType.OU3)
    ..aOS(4, _omitFieldNames ? '' : 'priceMin')
    ..aOS(5, _omitFieldNames ? '' : 'priceMax')
    ..aOB(6, _omitFieldNames ? '' : 'includeMyOrders')
    ..aOS(7, _omitFieldNames ? '' : 'groupByPriceIncrement')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OrderbookQueryFilter clone() => OrderbookQueryFilter()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OrderbookQueryFilter copyWith(void Function(OrderbookQueryFilter) updates) => super.copyWith((message) => updates(message as OrderbookQueryFilter)) as OrderbookQueryFilter;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OrderbookQueryFilter create() => OrderbookQueryFilter._();
  OrderbookQueryFilter createEmptyInstance() => create();
  static $pb.PbList<OrderbookQueryFilter> createRepeated() => $pb.PbList<OrderbookQueryFilter>();
  @$core.pragma('dart2js:noInline')
  static OrderbookQueryFilter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OrderbookQueryFilter>(create);
  static OrderbookQueryFilter? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get aggregated => $_getBF(0);
  @$pb.TagNumber(1)
  set aggregated($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAggregated() => $_has(0);
  @$pb.TagNumber(1)
  void clearAggregated() => clearField(1);

  @$pb.TagNumber(2)
  $9.OrderSide get side => $_getN(1);
  @$pb.TagNumber(2)
  set side($9.OrderSide v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSide() => $_has(1);
  @$pb.TagNumber(2)
  void clearSide() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get depth => $_getIZ(2);
  @$pb.TagNumber(3)
  set depth($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDepth() => $_has(2);
  @$pb.TagNumber(3)
  void clearDepth() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get priceMin => $_getSZ(3);
  @$pb.TagNumber(4)
  set priceMin($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPriceMin() => $_has(3);
  @$pb.TagNumber(4)
  void clearPriceMin() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get priceMax => $_getSZ(4);
  @$pb.TagNumber(5)
  set priceMax($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPriceMax() => $_has(4);
  @$pb.TagNumber(5)
  void clearPriceMax() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get includeMyOrders => $_getBF(5);
  @$pb.TagNumber(6)
  set includeMyOrders($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIncludeMyOrders() => $_has(5);
  @$pb.TagNumber(6)
  void clearIncludeMyOrders() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get groupByPriceIncrement => $_getSZ(6);
  @$pb.TagNumber(7)
  set groupByPriceIncrement($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasGroupByPriceIncrement() => $_has(6);
  @$pb.TagNumber(7)
  void clearGroupByPriceIncrement() => clearField(7);
}

class OrderList extends $pb.GeneratedMessage {
  factory OrderList({
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<$9.Order>? orders,
  }) {
    final $result = create();
    if (paginationInfo != null) {
      $result.paginationInfo = paginationInfo;
    }
    if (orders != null) {
      $result.orders.addAll(orders);
    }
    return $result;
  }
  OrderList._() : super();
  factory OrderList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OrderList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OrderList', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOM<$1.PaginationInfo>(1, _omitFieldNames ? '' : 'paginationInfo', subBuilder: $1.PaginationInfo.create)
    ..pc<$9.Order>(2, _omitFieldNames ? '' : 'orders', $pb.PbFieldType.PM, subBuilder: $9.Order.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OrderList clone() => OrderList()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OrderList copyWith(void Function(OrderList) updates) => super.copyWith((message) => updates(message as OrderList)) as OrderList;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OrderList create() => OrderList._();
  OrderList createEmptyInstance() => create();
  static $pb.PbList<OrderList> createRepeated() => $pb.PbList<OrderList>();
  @$core.pragma('dart2js:noInline')
  static OrderList getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OrderList>(create);
  static OrderList? _defaultInstance;

  @$pb.TagNumber(1)
  $1.PaginationInfo get paginationInfo => $_getN(0);
  @$pb.TagNumber(1)
  set paginationInfo($1.PaginationInfo v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaginationInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaginationInfo() => clearField(1);
  @$pb.TagNumber(1)
  $1.PaginationInfo ensurePaginationInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$9.Order> get orders => $_getList(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
