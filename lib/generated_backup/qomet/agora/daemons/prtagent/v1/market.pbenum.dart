// This is a generated file - do not edit.
//
// Generated from qomet/agora/daemons/prtagent/v1/market.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class MarketStatus extends $pb.ProtobufEnum {
  static const MarketStatus MARKET_STATUS__UNKNOWN =
      MarketStatus._(0, _omitEnumNames ? '' : 'MARKET_STATUS__UNKNOWN');
  static const MarketStatus MARKET_STATUS__OPENING_AUCTION =
      MarketStatus._(1, _omitEnumNames ? '' : 'MARKET_STATUS__OPENING_AUCTION');
  static const MarketStatus MARKET_STATUS__PRE_OPEN =
      MarketStatus._(2, _omitEnumNames ? '' : 'MARKET_STATUS__PRE_OPEN');
  static const MarketStatus MARKET_STATUS__OPEN =
      MarketStatus._(3, _omitEnumNames ? '' : 'MARKET_STATUS__OPEN');
  static const MarketStatus MARKET_STATUS__PARTIALLY_OPEN =
      MarketStatus._(4, _omitEnumNames ? '' : 'MARKET_STATUS__PARTIALLY_OPEN');
  static const MarketStatus MARKET_STATUS__REPORTING =
      MarketStatus._(5, _omitEnumNames ? '' : 'MARKET_STATUS__REPORTING');
  static const MarketStatus MARKET_STATUS__CLOSING_AUCTION =
      MarketStatus._(6, _omitEnumNames ? '' : 'MARKET_STATUS__CLOSING_AUCTION');
  static const MarketStatus MARKET_STATUS__CLOSED =
      MarketStatus._(7, _omitEnumNames ? '' : 'MARKET_STATUS__CLOSED');
  static const MarketStatus MARKET_STATUS__CLOSED_ON_PUBLIC_HOLIDAY =
      MarketStatus._(
          8, _omitEnumNames ? '' : 'MARKET_STATUS__CLOSED_ON_PUBLIC_HOLIDAY');
  static const MarketStatus MARKET_STATUS__SUSPENDED =
      MarketStatus._(9, _omitEnumNames ? '' : 'MARKET_STATUS__SUSPENDED');
  static const MarketStatus MARKET_STATUS__MAINTENANCE =
      MarketStatus._(10, _omitEnumNames ? '' : 'MARKET_STATUS__MAINTENANCE');
  static const MarketStatus MARKET_STATUS__UNAVAILABLE =
      MarketStatus._(100, _omitEnumNames ? '' : 'MARKET_STATUS__UNAVAILABLE');

  static const $core.List<MarketStatus> values = <MarketStatus>[
    MARKET_STATUS__UNKNOWN,
    MARKET_STATUS__OPENING_AUCTION,
    MARKET_STATUS__PRE_OPEN,
    MARKET_STATUS__OPEN,
    MARKET_STATUS__PARTIALLY_OPEN,
    MARKET_STATUS__REPORTING,
    MARKET_STATUS__CLOSING_AUCTION,
    MARKET_STATUS__CLOSED,
    MARKET_STATUS__CLOSED_ON_PUBLIC_HOLIDAY,
    MARKET_STATUS__SUSPENDED,
    MARKET_STATUS__MAINTENANCE,
    MARKET_STATUS__UNAVAILABLE,
  ];

  static final $core.Map<$core.int, MarketStatus> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static MarketStatus? valueOf($core.int value) => _byValue[value];

  const MarketStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
