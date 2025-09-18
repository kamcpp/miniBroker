// This is a generated file - do not edit.
//
// Generated from filter.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $0;
import 'fin_common.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class OrderQueryFilter extends $pb.GeneratedMessage {
  factory OrderQueryFilter({
    $0.DateTime? fromDt,
    $0.DateTime? toDt,
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
    if (fromDt != null) result.fromDt = fromDt;
    if (toDt != null) result.toDt = toDt;
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
    ..aOM<$0.DateTime>(1, _omitFieldNames ? '' : 'fromDt',
        subBuilder: $0.DateTime.create)
    ..aOM<$0.DateTime>(2, _omitFieldNames ? '' : 'toDt',
        subBuilder: $0.DateTime.create)
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
  $0.DateTime get fromDt => $_getN(0);
  @$pb.TagNumber(1)
  set fromDt($0.DateTime value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFromDt() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromDt() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.DateTime ensureFromDt() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.DateTime get toDt => $_getN(1);
  @$pb.TagNumber(2)
  set toDt($0.DateTime value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasToDt() => $_has(1);
  @$pb.TagNumber(2)
  void clearToDt() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.DateTime ensureToDt() => $_ensure(1);

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

class TradeQueryFilter extends $pb.GeneratedMessage {
  factory TradeQueryFilter({
    $0.DateTime? fromDt,
    $0.DateTime? toDt,
    $core.String? priceMin,
    $core.String? priceMax,
    $core.String? volumeMin,
    $core.String? volumeMax,
    $core.Iterable<$core.String>? tradeTypes,
    $1.OrderSide? side,
  }) {
    final result = create();
    if (fromDt != null) result.fromDt = fromDt;
    if (toDt != null) result.toDt = toDt;
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
    ..aOM<$0.DateTime>(1, _omitFieldNames ? '' : 'fromDt',
        subBuilder: $0.DateTime.create)
    ..aOM<$0.DateTime>(2, _omitFieldNames ? '' : 'toDt',
        subBuilder: $0.DateTime.create)
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
  $0.DateTime get fromDt => $_getN(0);
  @$pb.TagNumber(1)
  set fromDt($0.DateTime value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFromDt() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromDt() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.DateTime ensureFromDt() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.DateTime get toDt => $_getN(1);
  @$pb.TagNumber(2)
  set toDt($0.DateTime value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasToDt() => $_has(1);
  @$pb.TagNumber(2)
  void clearToDt() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.DateTime ensureToDt() => $_ensure(1);

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

class SettlementQueryFilter extends $pb.GeneratedMessage {
  factory SettlementQueryFilter({
    $0.DateTime? fromDt,
    $0.DateTime? toDt,
    $1.ConfirmationStatus? status,
    $core.Iterable<$core.String>? settlementTypes,
    $core.Iterable<$core.String>? assetIdOrNameRegexes,
    $core.String? amountMin,
    $core.String? amountMax,
  }) {
    final result = create();
    if (fromDt != null) result.fromDt = fromDt;
    if (toDt != null) result.toDt = toDt;
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
    ..aOM<$0.DateTime>(1, _omitFieldNames ? '' : 'fromDt',
        subBuilder: $0.DateTime.create)
    ..aOM<$0.DateTime>(2, _omitFieldNames ? '' : 'toDt',
        subBuilder: $0.DateTime.create)
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
  $0.DateTime get fromDt => $_getN(0);
  @$pb.TagNumber(1)
  set fromDt($0.DateTime value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFromDt() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromDt() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.DateTime ensureFromDt() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.DateTime get toDt => $_getN(1);
  @$pb.TagNumber(2)
  set toDt($0.DateTime value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasToDt() => $_has(1);
  @$pb.TagNumber(2)
  void clearToDt() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.DateTime ensureToDt() => $_ensure(1);

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

class OrderList extends $pb.GeneratedMessage {
  factory OrderList({
    $0.PaginationInfo? paginationInfo,
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
    ..aOM<$0.PaginationInfo>(1, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $0.PaginationInfo.create)
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
  $0.PaginationInfo get paginationInfo => $_getN(0);
  @$pb.TagNumber(1)
  set paginationInfo($0.PaginationInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPaginationInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaginationInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.PaginationInfo ensurePaginationInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<$1.Order> get orders => $_getList(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
