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

import 'package:protobuf/protobuf.dart' as $pb;

class EventType extends $pb.ProtobufEnum {
  static const EventType EVENT_TYPE__UNKNOWN =
      EventType._(0, _omitEnumNames ? '' : 'EVENT_TYPE__UNKNOWN');
  static const EventType EVENT_TYPE__NEWS =
      EventType._(1, _omitEnumNames ? '' : 'EVENT_TYPE__NEWS');
  static const EventType EVENT_TYPE__ANNOUNCEMENT =
      EventType._(2, _omitEnumNames ? '' : 'EVENT_TYPE__ANNOUNCEMENT');
  static const EventType EVENT_TYPE__MARKET_UPDATE =
      EventType._(3, _omitEnumNames ? '' : 'EVENT_TYPE__MARKET_UPDATE');
  static const EventType EVENT_TYPE__TRADE_EXECUTION =
      EventType._(4, _omitEnumNames ? '' : 'EVENT_TYPE__TRADE_EXECUTION');
  static const EventType EVENT_TYPE__ORDER_PLACED =
      EventType._(5, _omitEnumNames ? '' : 'EVENT_TYPE__ORDER_PLACED');
  static const EventType EVENT_TYPE__ORDER_CANCELLED =
      EventType._(6, _omitEnumNames ? '' : 'EVENT_TYPE__ORDER_CANCELLED');
  static const EventType EVENT_TYPE__ORDER_FILLED =
      EventType._(7, _omitEnumNames ? '' : 'EVENT_TYPE__ORDER_FILLED');
  static const EventType EVENT_TYPE__ORDER_EXPIRED =
      EventType._(8, _omitEnumNames ? '' : 'EVENT_TYPE__ORDER_EXPIRED');
  static const EventType EVENT_TYPE__PRICE_UPDATE =
      EventType._(9, _omitEnumNames ? '' : 'EVENT_TYPE__PRICE_UPDATE');
  static const EventType EVENT_TYPE__REGULATORY =
      EventType._(10, _omitEnumNames ? '' : 'EVENT_TYPE__REGULATORY');
  static const EventType EVENT_TYPE__SYSTEM =
      EventType._(11, _omitEnumNames ? '' : 'EVENT_TYPE__SYSTEM');

  static const $core.List<EventType> values = <EventType>[
    EVENT_TYPE__UNKNOWN,
    EVENT_TYPE__NEWS,
    EVENT_TYPE__ANNOUNCEMENT,
    EVENT_TYPE__MARKET_UPDATE,
    EVENT_TYPE__TRADE_EXECUTION,
    EVENT_TYPE__ORDER_PLACED,
    EVENT_TYPE__ORDER_CANCELLED,
    EVENT_TYPE__ORDER_FILLED,
    EVENT_TYPE__ORDER_EXPIRED,
    EVENT_TYPE__PRICE_UPDATE,
    EVENT_TYPE__REGULATORY,
    EVENT_TYPE__SYSTEM,
  ];

  static final $core.List<EventType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 11);
  static EventType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const EventType._(super.value, super.name);
}

class AssetType extends $pb.ProtobufEnum {
  static const AssetType ASSET_TYPE__UNKNOWN =
      AssetType._(0, _omitEnumNames ? '' : 'ASSET_TYPE__UNKNOWN');
  static const AssetType ASSET_TYPE__CASH =
      AssetType._(1, _omitEnumNames ? '' : 'ASSET_TYPE__CASH');
  static const AssetType ASSET_TYPE__ON_CHAIN =
      AssetType._(2, _omitEnumNames ? '' : 'ASSET_TYPE__ON_CHAIN');
  static const AssetType ASSET_TYPE__RWA =
      AssetType._(3, _omitEnumNames ? '' : 'ASSET_TYPE__RWA');
  static const AssetType ASSET_TYPE__COMMODITY =
      AssetType._(4, _omitEnumNames ? '' : 'ASSET_TYPE__COMMODITY');
  static const AssetType ASSET_TYPE__EQUITY =
      AssetType._(5, _omitEnumNames ? '' : 'ASSET_TYPE__EQUITY');
  static const AssetType ASSET_TYPE__FIXED_INCOME =
      AssetType._(6, _omitEnumNames ? '' : 'ASSET_TYPE__FIXED_INCOME');
  static const AssetType ASSET_TYPE__DERIVATIVE =
      AssetType._(7, _omitEnumNames ? '' : 'ASSET_TYPE__DERIVATIVE');
  static const AssetType ASSET_TYPE__CRYPTO =
      AssetType._(8, _omitEnumNames ? '' : 'ASSET_TYPE__CRYPTO');
  static const AssetType ASSET_TYPE__STABLECOIN =
      AssetType._(9, _omitEnumNames ? '' : 'ASSET_TYPE__STABLECOIN');
  static const AssetType ASSET_TYPE__NFT =
      AssetType._(10, _omitEnumNames ? '' : 'ASSET_TYPE__NFT');

  static const $core.List<AssetType> values = <AssetType>[
    ASSET_TYPE__UNKNOWN,
    ASSET_TYPE__CASH,
    ASSET_TYPE__ON_CHAIN,
    ASSET_TYPE__RWA,
    ASSET_TYPE__COMMODITY,
    ASSET_TYPE__EQUITY,
    ASSET_TYPE__FIXED_INCOME,
    ASSET_TYPE__DERIVATIVE,
    ASSET_TYPE__CRYPTO,
    ASSET_TYPE__STABLECOIN,
    ASSET_TYPE__NFT,
  ];

  static final $core.List<AssetType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 10);
  static AssetType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const AssetType._(super.value, super.name);
}

class InstrumentType extends $pb.ProtobufEnum {
  static const InstrumentType INSTRUMENT_TYPE__UNKNOWN =
      InstrumentType._(0, _omitEnumNames ? '' : 'INSTRUMENT_TYPE__UNKNOWN');
  static const InstrumentType INSTRUMENT_TYPE__SPOT =
      InstrumentType._(1, _omitEnumNames ? '' : 'INSTRUMENT_TYPE__SPOT');
  static const InstrumentType INSTRUMENT_TYPE__FUTURE =
      InstrumentType._(2, _omitEnumNames ? '' : 'INSTRUMENT_TYPE__FUTURE');
  static const InstrumentType INSTRUMENT_TYPE__OPTION =
      InstrumentType._(3, _omitEnumNames ? '' : 'INSTRUMENT_TYPE__OPTION');
  static const InstrumentType INSTRUMENT_TYPE__SWAP =
      InstrumentType._(4, _omitEnumNames ? '' : 'INSTRUMENT_TYPE__SWAP');
  static const InstrumentType INSTRUMENT_TYPE__FORWARD =
      InstrumentType._(5, _omitEnumNames ? '' : 'INSTRUMENT_TYPE__FORWARD');
  static const InstrumentType INSTRUMENT_TYPE__BOND =
      InstrumentType._(6, _omitEnumNames ? '' : 'INSTRUMENT_TYPE__BOND');
  static const InstrumentType INSTRUMENT_TYPE__INDEX =
      InstrumentType._(7, _omitEnumNames ? '' : 'INSTRUMENT_TYPE__INDEX');
  static const InstrumentType INSTRUMENT_TYPE__ETF =
      InstrumentType._(8, _omitEnumNames ? '' : 'INSTRUMENT_TYPE__ETF');
  static const InstrumentType INSTRUMENT_TYPE__PERPETUAL =
      InstrumentType._(9, _omitEnumNames ? '' : 'INSTRUMENT_TYPE__PERPETUAL');
  static const InstrumentType INSTRUMENT_TYPE__CFD =
      InstrumentType._(10, _omitEnumNames ? '' : 'INSTRUMENT_TYPE__CFD');

  static const $core.List<InstrumentType> values = <InstrumentType>[
    INSTRUMENT_TYPE__UNKNOWN,
    INSTRUMENT_TYPE__SPOT,
    INSTRUMENT_TYPE__FUTURE,
    INSTRUMENT_TYPE__OPTION,
    INSTRUMENT_TYPE__SWAP,
    INSTRUMENT_TYPE__FORWARD,
    INSTRUMENT_TYPE__BOND,
    INSTRUMENT_TYPE__INDEX,
    INSTRUMENT_TYPE__ETF,
    INSTRUMENT_TYPE__PERPETUAL,
    INSTRUMENT_TYPE__CFD,
  ];

  static final $core.List<InstrumentType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 10);
  static InstrumentType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const InstrumentType._(super.value, super.name);
}

class InstrumentListingStatusType extends $pb.ProtobufEnum {
  static const InstrumentListingStatusType
      INSTRUMENT_LISTING_STATUS_TYPE__UNKNOWN = InstrumentListingStatusType._(
          0, _omitEnumNames ? '' : 'INSTRUMENT_LISTING_STATUS_TYPE__UNKNOWN');
  static const InstrumentListingStatusType
      INSTRUMENT_LISTING_STATUS_TYPE__LISTED = InstrumentListingStatusType._(
          1, _omitEnumNames ? '' : 'INSTRUMENT_LISTING_STATUS_TYPE__LISTED');
  static const InstrumentListingStatusType
      INSTRUMENT_LISTING_STATUS_TYPE__SUSPENDED = InstrumentListingStatusType._(
          2, _omitEnumNames ? '' : 'INSTRUMENT_LISTING_STATUS_TYPE__SUSPENDED');
  static const InstrumentListingStatusType
      INSTRUMENT_LISTING_STATUS_TYPE__DELISTED = InstrumentListingStatusType._(
          3, _omitEnumNames ? '' : 'INSTRUMENT_LISTING_STATUS_TYPE__DELISTED');
  static const InstrumentListingStatusType
      INSTRUMENT_LISTING_STATUS_TYPE__PENDING = InstrumentListingStatusType._(
          4, _omitEnumNames ? '' : 'INSTRUMENT_LISTING_STATUS_TYPE__PENDING');
  static const InstrumentListingStatusType
      INSTRUMENT_LISTING_STATUS_TYPE__HALTED = InstrumentListingStatusType._(
          5, _omitEnumNames ? '' : 'INSTRUMENT_LISTING_STATUS_TYPE__HALTED');
  static const InstrumentListingStatusType
      INSTRUMENT_LISTING_STATUS_TYPE__CLOSED = InstrumentListingStatusType._(
          6, _omitEnumNames ? '' : 'INSTRUMENT_LISTING_STATUS_TYPE__CLOSED');
  static const InstrumentListingStatusType
      INSTRUMENT_LISTING_STATUS_TYPE__PRE_LISTING =
      InstrumentListingStatusType._(7,
          _omitEnumNames ? '' : 'INSTRUMENT_LISTING_STATUS_TYPE__PRE_LISTING');

  static const $core.List<InstrumentListingStatusType> values =
      <InstrumentListingStatusType>[
    INSTRUMENT_LISTING_STATUS_TYPE__UNKNOWN,
    INSTRUMENT_LISTING_STATUS_TYPE__LISTED,
    INSTRUMENT_LISTING_STATUS_TYPE__SUSPENDED,
    INSTRUMENT_LISTING_STATUS_TYPE__DELISTED,
    INSTRUMENT_LISTING_STATUS_TYPE__PENDING,
    INSTRUMENT_LISTING_STATUS_TYPE__HALTED,
    INSTRUMENT_LISTING_STATUS_TYPE__CLOSED,
    INSTRUMENT_LISTING_STATUS_TYPE__PRE_LISTING,
  ];

  static final $core.List<InstrumentListingStatusType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 7);
  static InstrumentListingStatusType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const InstrumentListingStatusType._(super.value, super.name);
}

class ConfirmationStatus extends $pb.ProtobufEnum {
  static const ConfirmationStatus CONFIRMATION_STATUS__UNKNOWN =
      ConfirmationStatus._(
          0, _omitEnumNames ? '' : 'CONFIRMATION_STATUS__UNKNOWN');
  static const ConfirmationStatus CONFIRMATION_STATUS__CONFIRMED =
      ConfirmationStatus._(
          1, _omitEnumNames ? '' : 'CONFIRMATION_STATUS__CONFIRMED');
  static const ConfirmationStatus CONFIRMATION_STATUS__PENDING =
      ConfirmationStatus._(
          2, _omitEnumNames ? '' : 'CONFIRMATION_STATUS__PENDING');
  static const ConfirmationStatus CONFIRMATION_STATUS__DECLINED =
      ConfirmationStatus._(
          3, _omitEnumNames ? '' : 'CONFIRMATION_STATUS__DECLINED');

  static const $core.List<ConfirmationStatus> values = <ConfirmationStatus>[
    CONFIRMATION_STATUS__UNKNOWN,
    CONFIRMATION_STATUS__CONFIRMED,
    CONFIRMATION_STATUS__PENDING,
    CONFIRMATION_STATUS__DECLINED,
  ];

  static final $core.List<ConfirmationStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static ConfirmationStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ConfirmationStatus._(super.value, super.name);
}

class OrderSide extends $pb.ProtobufEnum {
  static const OrderSide ORDER_SIDE__UNKNOWN =
      OrderSide._(0, _omitEnumNames ? '' : 'ORDER_SIDE__UNKNOWN');
  static const OrderSide ORDER_SIDE__BUY =
      OrderSide._(1, _omitEnumNames ? '' : 'ORDER_SIDE__BUY');
  static const OrderSide ORDER_SIDE__SELL =
      OrderSide._(2, _omitEnumNames ? '' : 'ORDER_SIDE__SELL');
  static const OrderSide ORDER_SIDE__BOTH =
      OrderSide._(3, _omitEnumNames ? '' : 'ORDER_SIDE__BOTH');
  static const OrderSide ORDER_SIDE__NO_SIDE =
      OrderSide._(4, _omitEnumNames ? '' : 'ORDER_SIDE__NO_SIDE');

  static const OrderSide ORDER_SIDE__BID = ORDER_SIDE__BUY;
  static const OrderSide ORDER_SIDE__CALL = ORDER_SIDE__BUY;
  static const OrderSide ORDER_SIDE__ASK = ORDER_SIDE__SELL;
  static const OrderSide ORDER_SIDE__PUT = ORDER_SIDE__SELL;

  static const $core.List<OrderSide> values = <OrderSide>[
    ORDER_SIDE__UNKNOWN,
    ORDER_SIDE__BUY,
    ORDER_SIDE__SELL,
    ORDER_SIDE__BOTH,
    ORDER_SIDE__NO_SIDE,
  ];

  static final $core.List<OrderSide?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static OrderSide? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const OrderSide._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
