// This is a generated file - do not edit.
//
// Generated from qomet/agora/daemons/prtagent/v1/fin_common.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class AccountTypeEnum extends $pb.ProtobufEnum {
  static const AccountTypeEnum ACCOUNT_TYPE_ENUM__UNKNOWN =
      AccountTypeEnum._(0, _omitEnumNames ? '' : 'ACCOUNT_TYPE_ENUM__UNKNOWN');
  static const AccountTypeEnum ACCOUNT_TYPE_ENUM__CASH =
      AccountTypeEnum._(1, _omitEnumNames ? '' : 'ACCOUNT_TYPE_ENUM__CASH');
  static const AccountTypeEnum ACCOUNT_TYPE_ENUM__MARGIN =
      AccountTypeEnum._(2, _omitEnumNames ? '' : 'ACCOUNT_TYPE_ENUM__MARGIN');
  static const AccountTypeEnum ACCOUNT_TYPE_ENUM__CUSTODY =
      AccountTypeEnum._(3, _omitEnumNames ? '' : 'ACCOUNT_TYPE_ENUM__CUSTODY');
  static const AccountTypeEnum ACCOUNT_TYPE_ENUM__SETTLEMENT =
      AccountTypeEnum._(
          4, _omitEnumNames ? '' : 'ACCOUNT_TYPE_ENUM__SETTLEMENT');
  static const AccountTypeEnum ACCOUNT_TYPE_ENUM__TREASURY =
      AccountTypeEnum._(5, _omitEnumNames ? '' : 'ACCOUNT_TYPE_ENUM__TREASURY');
  static const AccountTypeEnum ACCOUNT_TYPE_ENUM__OTHER =
      AccountTypeEnum._(1000, _omitEnumNames ? '' : 'ACCOUNT_TYPE_ENUM__OTHER');

  static const $core.List<AccountTypeEnum> values = <AccountTypeEnum>[
    ACCOUNT_TYPE_ENUM__UNKNOWN,
    ACCOUNT_TYPE_ENUM__CASH,
    ACCOUNT_TYPE_ENUM__MARGIN,
    ACCOUNT_TYPE_ENUM__CUSTODY,
    ACCOUNT_TYPE_ENUM__SETTLEMENT,
    ACCOUNT_TYPE_ENUM__TREASURY,
    ACCOUNT_TYPE_ENUM__OTHER,
  ];

  static final $core.Map<$core.int, AccountTypeEnum> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static AccountTypeEnum? valueOf($core.int value) => _byValue[value];

  const AccountTypeEnum._(super.value, super.name);
}

class AccountStructureEnum extends $pb.ProtobufEnum {
  static const AccountStructureEnum ACCOUNT_STRUCTURE_ENUM__UNKNOWN =
      AccountStructureEnum._(
          0, _omitEnumNames ? '' : 'ACCOUNT_STRUCTURE_ENUM__UNKNOWN');
  static const AccountStructureEnum ACCOUNT_STRUCTURE_ENUM__SINGLE =
      AccountStructureEnum._(
          1, _omitEnumNames ? '' : 'ACCOUNT_STRUCTURE_ENUM__SINGLE');
  static const AccountStructureEnum ACCOUNT_STRUCTURE_ENUM__MASTER =
      AccountStructureEnum._(
          2, _omitEnumNames ? '' : 'ACCOUNT_STRUCTURE_ENUM__MASTER');
  static const AccountStructureEnum ACCOUNT_STRUCTURE_ENUM__SUB =
      AccountStructureEnum._(
          3, _omitEnumNames ? '' : 'ACCOUNT_STRUCTURE_ENUM__SUB');
  static const AccountStructureEnum ACCOUNT_STRUCTURE_ENUM__OTHER =
      AccountStructureEnum._(
          1000, _omitEnumNames ? '' : 'ACCOUNT_STRUCTURE_ENUM__OTHER');

  static const $core.List<AccountStructureEnum> values = <AccountStructureEnum>[
    ACCOUNT_STRUCTURE_ENUM__UNKNOWN,
    ACCOUNT_STRUCTURE_ENUM__SINGLE,
    ACCOUNT_STRUCTURE_ENUM__MASTER,
    ACCOUNT_STRUCTURE_ENUM__SUB,
    ACCOUNT_STRUCTURE_ENUM__OTHER,
  ];

  static final $core.Map<$core.int, AccountStructureEnum> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static AccountStructureEnum? valueOf($core.int value) => _byValue[value];

  const AccountStructureEnum._(super.value, super.name);
}

class AccountStatusEnum extends $pb.ProtobufEnum {
  static const AccountStatusEnum ACCOUNT_STATUS_ENUM__UNKNOWN =
      AccountStatusEnum._(
          0, _omitEnumNames ? '' : 'ACCOUNT_STATUS_ENUM__UNKNOWN');
  static const AccountStatusEnum ACCOUNT_STATUS_ENUM__ACTIVE =
      AccountStatusEnum._(
          1, _omitEnumNames ? '' : 'ACCOUNT_STATUS_ENUM__ACTIVE');
  static const AccountStatusEnum ACCOUNT_STATUS_ENUM__INACTIVE =
      AccountStatusEnum._(
          2, _omitEnumNames ? '' : 'ACCOUNT_STATUS_ENUM__INACTIVE');
  static const AccountStatusEnum ACCOUNT_STATUS_ENUM__FROZEN =
      AccountStatusEnum._(
          3, _omitEnumNames ? '' : 'ACCOUNT_STATUS_ENUM__FROZEN');
  static const AccountStatusEnum ACCOUNT_STATUS_ENUM__BLOCKED =
      AccountStatusEnum._(
          4, _omitEnumNames ? '' : 'ACCOUNT_STATUS_ENUM__BLOCKED');
  static const AccountStatusEnum ACCOUNT_STATUS_ENUM__CLOSED =
      AccountStatusEnum._(
          5, _omitEnumNames ? '' : 'ACCOUNT_STATUS_ENUM__CLOSED');
  static const AccountStatusEnum ACCOUNT_STATUS_ENUM__OTHER =
      AccountStatusEnum._(
          1000, _omitEnumNames ? '' : 'ACCOUNT_STATUS_ENUM__OTHER');

  static const $core.List<AccountStatusEnum> values = <AccountStatusEnum>[
    ACCOUNT_STATUS_ENUM__UNKNOWN,
    ACCOUNT_STATUS_ENUM__ACTIVE,
    ACCOUNT_STATUS_ENUM__INACTIVE,
    ACCOUNT_STATUS_ENUM__FROZEN,
    ACCOUNT_STATUS_ENUM__BLOCKED,
    ACCOUNT_STATUS_ENUM__CLOSED,
    ACCOUNT_STATUS_ENUM__OTHER,
  ];

  static final $core.Map<$core.int, AccountStatusEnum> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static AccountStatusEnum? valueOf($core.int value) => _byValue[value];

  const AccountStatusEnum._(super.value, super.name);
}

class AccountClassEnum extends $pb.ProtobufEnum {
  static const AccountClassEnum ACCOUNT_CLASS_ENUM__UNKNOWN =
      AccountClassEnum._(
          0, _omitEnumNames ? '' : 'ACCOUNT_CLASS_ENUM__UNKNOWN');
  static const AccountClassEnum ACCOUNT_CLASS_ENUM__CLIENT =
      AccountClassEnum._(1, _omitEnumNames ? '' : 'ACCOUNT_CLASS_ENUM__CLIENT');
  static const AccountClassEnum ACCOUNT_CLASS_ENUM__HOUSE =
      AccountClassEnum._(2, _omitEnumNames ? '' : 'ACCOUNT_CLASS_ENUM__HOUSE');
  static const AccountClassEnum ACCOUNT_CLASS_ENUM__PROPRIETARY =
      AccountClassEnum._(
          3, _omitEnumNames ? '' : 'ACCOUNT_CLASS_ENUM__PROPRIETARY');
  static const AccountClassEnum ACCOUNT_CLASS_ENUM__OTHER = AccountClassEnum._(
      1000, _omitEnumNames ? '' : 'ACCOUNT_CLASS_ENUM__OTHER');

  static const $core.List<AccountClassEnum> values = <AccountClassEnum>[
    ACCOUNT_CLASS_ENUM__UNKNOWN,
    ACCOUNT_CLASS_ENUM__CLIENT,
    ACCOUNT_CLASS_ENUM__HOUSE,
    ACCOUNT_CLASS_ENUM__PROPRIETARY,
    ACCOUNT_CLASS_ENUM__OTHER,
  ];

  static final $core.Map<$core.int, AccountClassEnum> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static AccountClassEnum? valueOf($core.int value) => _byValue[value];

  const AccountClassEnum._(super.value, super.name);
}

class AccountNature extends $pb.ProtobufEnum {
  static const AccountNature ACCOUNT_NATURE__UNKNOWN =
      AccountNature._(0, _omitEnumNames ? '' : 'ACCOUNT_NATURE__UNKNOWN');
  static const AccountNature ACCOUNT_NATURE__INDIVIDUAL =
      AccountNature._(1, _omitEnumNames ? '' : 'ACCOUNT_NATURE__INDIVIDUAL');
  static const AccountNature ACCOUNT_NATURE__JOINT =
      AccountNature._(2, _omitEnumNames ? '' : 'ACCOUNT_NATURE__JOINT');
  static const AccountNature ACCOUNT_NATURE__CORPORATE =
      AccountNature._(3, _omitEnumNames ? '' : 'ACCOUNT_NATURE__CORPORATE');
  static const AccountNature ACCOUNT_NATURE__TRUST =
      AccountNature._(4, _omitEnumNames ? '' : 'ACCOUNT_NATURE__TRUST');
  static const AccountNature ACCOUNT_NATURE__FUND =
      AccountNature._(5, _omitEnumNames ? '' : 'ACCOUNT_NATURE__FUND');
  static const AccountNature ACCOUNT_NATURE__OTHER =
      AccountNature._(1000, _omitEnumNames ? '' : 'ACCOUNT_NATURE__OTHER');

  static const $core.List<AccountNature> values = <AccountNature>[
    ACCOUNT_NATURE__UNKNOWN,
    ACCOUNT_NATURE__INDIVIDUAL,
    ACCOUNT_NATURE__JOINT,
    ACCOUNT_NATURE__CORPORATE,
    ACCOUNT_NATURE__TRUST,
    ACCOUNT_NATURE__FUND,
    ACCOUNT_NATURE__OTHER,
  ];

  static final $core.Map<$core.int, AccountNature> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static AccountNature? valueOf($core.int value) => _byValue[value];

  const AccountNature._(super.value, super.name);
}

class FinEntityTypeEnum extends $pb.ProtobufEnum {
  static const FinEntityTypeEnum FIN_ENTITY_TYPE_ENUM__UNKNOWN =
      FinEntityTypeEnum._(
          0, _omitEnumNames ? '' : 'FIN_ENTITY_TYPE_ENUM__UNKNOWN');
  static const FinEntityTypeEnum FIN_ENTITY_TYPE_ENUM__PARTICIPANT =
      FinEntityTypeEnum._(
          1, _omitEnumNames ? '' : 'FIN_ENTITY_TYPE_ENUM__PARTICIPANT');
  static const FinEntityTypeEnum FIN_ENTITY_TYPE_ENUM__INSTRUMENT =
      FinEntityTypeEnum._(
          2, _omitEnumNames ? '' : 'FIN_ENTITY_TYPE_ENUM__INSTRUMENT');
  static const FinEntityTypeEnum FIN_ENTITY_TYPE_ENUM__MARKET =
      FinEntityTypeEnum._(
          3, _omitEnumNames ? '' : 'FIN_ENTITY_TYPE_ENUM__MARKET');
  static const FinEntityTypeEnum FIN_ENTITY_TYPE_ENUM__VENUE =
      FinEntityTypeEnum._(
          4, _omitEnumNames ? '' : 'FIN_ENTITY_TYPE_ENUM__VENUE');
  static const FinEntityTypeEnum FIN_ENTITY_TYPE_ENUM__OTHER =
      FinEntityTypeEnum._(
          1000, _omitEnumNames ? '' : 'FIN_ENTITY_TYPE_ENUM__OTHER');

  static const $core.List<FinEntityTypeEnum> values = <FinEntityTypeEnum>[
    FIN_ENTITY_TYPE_ENUM__UNKNOWN,
    FIN_ENTITY_TYPE_ENUM__PARTICIPANT,
    FIN_ENTITY_TYPE_ENUM__INSTRUMENT,
    FIN_ENTITY_TYPE_ENUM__MARKET,
    FIN_ENTITY_TYPE_ENUM__VENUE,
    FIN_ENTITY_TYPE_ENUM__OTHER,
  ];

  static final $core.Map<$core.int, FinEntityTypeEnum> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static FinEntityTypeEnum? valueOf($core.int value) => _byValue[value];

  const FinEntityTypeEnum._(super.value, super.name);
}

class AssetClassEnum extends $pb.ProtobufEnum {
  static const AssetClassEnum ASSET_CLASS_ENUM__UNKNOWN =
      AssetClassEnum._(0, _omitEnumNames ? '' : 'ASSET_CLASS_ENUM__UNKNOWN');
  static const AssetClassEnum ASSET_CLASS_ENUM__COMPANY =
      AssetClassEnum._(1, _omitEnumNames ? '' : 'ASSET_CLASS_ENUM__COMPANY');
  static const AssetClassEnum ASSET_CLASS_ENUM__GOVERMENTAL = AssetClassEnum._(
      2, _omitEnumNames ? '' : 'ASSET_CLASS_ENUM__GOVERMENTAL');
  static const AssetClassEnum ASSET_CLASS_ENUM__CURRENCY =
      AssetClassEnum._(3, _omitEnumNames ? '' : 'ASSET_CLASS_ENUM__CURRENCY');
  static const AssetClassEnum ASSET_CLASS_ENUM__COMMODITY =
      AssetClassEnum._(4, _omitEnumNames ? '' : 'ASSET_CLASS_ENUM__COMMODITY');
  static const AssetClassEnum ASSET_CLASS_ENUM__PRECIOUS_METALS =
      AssetClassEnum._(
          5, _omitEnumNames ? '' : 'ASSET_CLASS_ENUM__PRECIOUS_METALS');
  static const AssetClassEnum ASSET_CLASS_ENUM__INDUSTRIAL_METALS =
      AssetClassEnum._(
          6, _omitEnumNames ? '' : 'ASSET_CLASS_ENUM__INDUSTRIAL_METALS');
  static const AssetClassEnum ASSET_CLASS_ENUM__RWA =
      AssetClassEnum._(7, _omitEnumNames ? '' : 'ASSET_CLASS_ENUM__RWA');
  static const AssetClassEnum ASSET_CLASS_ENUM__STABLECOIN =
      AssetClassEnum._(9, _omitEnumNames ? '' : 'ASSET_CLASS_ENUM__STABLECOIN');
  static const AssetClassEnum ASSET_CLASS_ENUM__NFT =
      AssetClassEnum._(10, _omitEnumNames ? '' : 'ASSET_CLASS_ENUM__NFT');
  static const AssetClassEnum ASSET_CLASS_ENUM__REAL_ESTATE = AssetClassEnum._(
      11, _omitEnumNames ? '' : 'ASSET_CLASS_ENUM__REAL_ESTATE');
  static const AssetClassEnum ASSET_CLASS_ENUM__FUND =
      AssetClassEnum._(12, _omitEnumNames ? '' : 'ASSET_CLASS_ENUM__FUND');
  static const AssetClassEnum ASSET_CLASS_ENUM__INDEX =
      AssetClassEnum._(13, _omitEnumNames ? '' : 'ASSET_CLASS_ENUM__INDEX');
  static const AssetClassEnum ASSET_CLASS_ENUM__CREDIT =
      AssetClassEnum._(14, _omitEnumNames ? '' : 'ASSET_CLASS_ENUM__CREDIT');
  static const AssetClassEnum ASSET_CLASS_ENUM__DIGITAL =
      AssetClassEnum._(15, _omitEnumNames ? '' : 'ASSET_CLASS_ENUM__DIGITAL');
  static const AssetClassEnum ASSET_CLASS_ENUM__LEDGER_NATIVE_COIN =
      AssetClassEnum._(
          16, _omitEnumNames ? '' : 'ASSET_CLASS_ENUM__LEDGER_NATIVE_COIN');
  static const AssetClassEnum ASSET_CLASS_ENUM__OTHER =
      AssetClassEnum._(1000, _omitEnumNames ? '' : 'ASSET_CLASS_ENUM__OTHER');

  static const $core.List<AssetClassEnum> values = <AssetClassEnum>[
    ASSET_CLASS_ENUM__UNKNOWN,
    ASSET_CLASS_ENUM__COMPANY,
    ASSET_CLASS_ENUM__GOVERMENTAL,
    ASSET_CLASS_ENUM__CURRENCY,
    ASSET_CLASS_ENUM__COMMODITY,
    ASSET_CLASS_ENUM__PRECIOUS_METALS,
    ASSET_CLASS_ENUM__INDUSTRIAL_METALS,
    ASSET_CLASS_ENUM__RWA,
    ASSET_CLASS_ENUM__STABLECOIN,
    ASSET_CLASS_ENUM__NFT,
    ASSET_CLASS_ENUM__REAL_ESTATE,
    ASSET_CLASS_ENUM__FUND,
    ASSET_CLASS_ENUM__INDEX,
    ASSET_CLASS_ENUM__CREDIT,
    ASSET_CLASS_ENUM__DIGITAL,
    ASSET_CLASS_ENUM__LEDGER_NATIVE_COIN,
    ASSET_CLASS_ENUM__OTHER,
  ];

  static final $core.Map<$core.int, AssetClassEnum> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static AssetClassEnum? valueOf($core.int value) => _byValue[value];

  const AssetClassEnum._(super.value, super.name);
}

class ParticipantAssetRelationEnum extends $pb.ProtobufEnum {
  static const ParticipantAssetRelationEnum
      PARTICIPANT_ASSET_RELATION_ENUM__UNKNOWN = ParticipantAssetRelationEnum._(
          0, _omitEnumNames ? '' : 'PARTICIPANT_ASSET_RELATION_ENUM__UNKNOWN');
  static const ParticipantAssetRelationEnum
      PARTICIPANT_ASSET_RELATION_ENUM__ISSUER = ParticipantAssetRelationEnum._(
          1, _omitEnumNames ? '' : 'PARTICIPANT_ASSET_RELATION_ENUM__ISSUER');
  static const ParticipantAssetRelationEnum
      PARTICIPANT_ASSET_RELATION_ENUM__OWNER = ParticipantAssetRelationEnum._(
          2, _omitEnumNames ? '' : 'PARTICIPANT_ASSET_RELATION_ENUM__OWNER');
  static const ParticipantAssetRelationEnum
      PARTICIPANT_ASSET_RELATION_ENUM__SPONSOR = ParticipantAssetRelationEnum._(
          3, _omitEnumNames ? '' : 'PARTICIPANT_ASSET_RELATION_ENUM__SPONSOR');
  static const ParticipantAssetRelationEnum
      PARTICIPANT_ASSET_RELATION_ENUM__REGULATOR =
      ParticipantAssetRelationEnum._(4,
          _omitEnumNames ? '' : 'PARTICIPANT_ASSET_RELATION_ENUM__REGULATOR');
  static const ParticipantAssetRelationEnum
      PARTICIPANT_ASSET_RELATION_ENUM__SUPERVISOR =
      ParticipantAssetRelationEnum._(5,
          _omitEnumNames ? '' : 'PARTICIPANT_ASSET_RELATION_ENUM__SUPERVISOR');
  static const ParticipantAssetRelationEnum
      PARTICIPANT_ASSET_RELATION_ENUM__GOVERNOR =
      ParticipantAssetRelationEnum._(
          6, _omitEnumNames ? '' : 'PARTICIPANT_ASSET_RELATION_ENUM__GOVERNOR');
  static const ParticipantAssetRelationEnum
      PARTICIPANT_ASSET_RELATION_ENUM__OTHER = ParticipantAssetRelationEnum._(
          1000, _omitEnumNames ? '' : 'PARTICIPANT_ASSET_RELATION_ENUM__OTHER');

  static const $core.List<ParticipantAssetRelationEnum> values =
      <ParticipantAssetRelationEnum>[
    PARTICIPANT_ASSET_RELATION_ENUM__UNKNOWN,
    PARTICIPANT_ASSET_RELATION_ENUM__ISSUER,
    PARTICIPANT_ASSET_RELATION_ENUM__OWNER,
    PARTICIPANT_ASSET_RELATION_ENUM__SPONSOR,
    PARTICIPANT_ASSET_RELATION_ENUM__REGULATOR,
    PARTICIPANT_ASSET_RELATION_ENUM__SUPERVISOR,
    PARTICIPANT_ASSET_RELATION_ENUM__GOVERNOR,
    PARTICIPANT_ASSET_RELATION_ENUM__OTHER,
  ];

  static final $core.Map<$core.int, ParticipantAssetRelationEnum> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static ParticipantAssetRelationEnum? valueOf($core.int value) =>
      _byValue[value];

  const ParticipantAssetRelationEnum._(super.value, super.name);
}

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

class VenueTypeEnum extends $pb.ProtobufEnum {
  static const VenueTypeEnum VENUE_TYPE_ENUM__UNKNOWN =
      VenueTypeEnum._(0, _omitEnumNames ? '' : 'VENUE_TYPE_ENUM__UNKNOWN');
  static const VenueTypeEnum VENUE_TYPE_ENUM__EXCHANGE =
      VenueTypeEnum._(1, _omitEnumNames ? '' : 'VENUE_TYPE_ENUM__EXCHANGE');
  static const VenueTypeEnum VENUE_TYPE_ENUM__OTHER =
      VenueTypeEnum._(1000, _omitEnumNames ? '' : 'VENUE_TYPE_ENUM__OTHER');

  static const $core.List<VenueTypeEnum> values = <VenueTypeEnum>[
    VENUE_TYPE_ENUM__UNKNOWN,
    VENUE_TYPE_ENUM__EXCHANGE,
    VENUE_TYPE_ENUM__OTHER,
  ];

  static final $core.Map<$core.int, VenueTypeEnum> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static VenueTypeEnum? valueOf($core.int value) => _byValue[value];

  const VenueTypeEnum._(super.value, super.name);
}

class VenueStatus extends $pb.ProtobufEnum {
  static const VenueStatus VENUE_STATUS__UNKNOWN =
      VenueStatus._(0, _omitEnumNames ? '' : 'VENUE_STATUS__UNKNOWN');
  static const VenueStatus VENUE_STATUS__OPENING_AUCTION =
      VenueStatus._(1, _omitEnumNames ? '' : 'VENUE_STATUS__OPENING_AUCTION');
  static const VenueStatus VENUE_STATUS__PRE_OPEN =
      VenueStatus._(2, _omitEnumNames ? '' : 'VENUE_STATUS__PRE_OPEN');
  static const VenueStatus VENUE_STATUS__OPEN =
      VenueStatus._(3, _omitEnumNames ? '' : 'VENUE_STATUS__OPEN');
  static const VenueStatus VENUE_STATUS__PARTIALLY_OPEN =
      VenueStatus._(4, _omitEnumNames ? '' : 'VENUE_STATUS__PARTIALLY_OPEN');
  static const VenueStatus VENUE_STATUS__REPORTING =
      VenueStatus._(5, _omitEnumNames ? '' : 'VENUE_STATUS__REPORTING');
  static const VenueStatus VENUE_STATUS__CLOSING_AUCTION =
      VenueStatus._(6, _omitEnumNames ? '' : 'VENUE_STATUS__CLOSING_AUCTION');
  static const VenueStatus VENUE_STATUS__CLOSED =
      VenueStatus._(7, _omitEnumNames ? '' : 'VENUE_STATUS__CLOSED');
  static const VenueStatus VENUE_STATUS__CLOSED_ON_PUBLIC_HOLIDAY =
      VenueStatus._(
          8, _omitEnumNames ? '' : 'VENUE_STATUS__CLOSED_ON_PUBLIC_HOLIDAY');
  static const VenueStatus VENUE_STATUS__SUSPENDED =
      VenueStatus._(9, _omitEnumNames ? '' : 'VENUE_STATUS__SUSPENDED');
  static const VenueStatus VENUE_STATUS__MAINTENANCE =
      VenueStatus._(10, _omitEnumNames ? '' : 'VENUE_STATUS__MAINTENANCE');
  static const VenueStatus VENUE_STATUS__UNAVAILABLE =
      VenueStatus._(100, _omitEnumNames ? '' : 'VENUE_STATUS__UNAVAILABLE');

  static const $core.List<VenueStatus> values = <VenueStatus>[
    VENUE_STATUS__UNKNOWN,
    VENUE_STATUS__OPENING_AUCTION,
    VENUE_STATUS__PRE_OPEN,
    VENUE_STATUS__OPEN,
    VENUE_STATUS__PARTIALLY_OPEN,
    VENUE_STATUS__REPORTING,
    VENUE_STATUS__CLOSING_AUCTION,
    VENUE_STATUS__CLOSED,
    VENUE_STATUS__CLOSED_ON_PUBLIC_HOLIDAY,
    VENUE_STATUS__SUSPENDED,
    VENUE_STATUS__MAINTENANCE,
    VENUE_STATUS__UNAVAILABLE,
  ];

  static final $core.Map<$core.int, VenueStatus> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static VenueStatus? valueOf($core.int value) => _byValue[value];

  const VenueStatus._(super.value, super.name);
}

class InstrumentClassEnum extends $pb.ProtobufEnum {
  static const InstrumentClassEnum INSTRUMENT_CLASS_ENUM__UNKNOWN =
      InstrumentClassEnum._(
          0, _omitEnumNames ? '' : 'INSTRUMENT_CLASS_ENUM__UNKNOWN');
  static const InstrumentClassEnum INSTRUMENT_CLASS_ENUM__EQUITY_SHARE =
      InstrumentClassEnum._(
          1, _omitEnumNames ? '' : 'INSTRUMENT_CLASS_ENUM__EQUITY_SHARE');
  static const InstrumentClassEnum INSTRUMENT_CLASS_ENUM__TOKENIZED_SECURITY =
      InstrumentClassEnum._(
          2, _omitEnumNames ? '' : 'INSTRUMENT_CLASS_ENUM__TOKENIZED_SECURITY');
  static const InstrumentClassEnum INSTRUMENT_CLASS_ENUM__FUND_UNIT =
      InstrumentClassEnum._(
          3, _omitEnumNames ? '' : 'INSTRUMENT_CLASS_ENUM__FUND_UNIT');
  static const InstrumentClassEnum INSTRUMENT_CLASS_ENUM__ETF_SHARE =
      InstrumentClassEnum._(
          4, _omitEnumNames ? '' : 'INSTRUMENT_CLASS_ENUM__ETF_SHARE');
  static const InstrumentClassEnum INSTRUMENT_CLASS_ENUM__BOND =
      InstrumentClassEnum._(
          5, _omitEnumNames ? '' : 'INSTRUMENT_CLASS_ENUM__BOND');
  static const InstrumentClassEnum INSTRUMENT_CLASS_ENUM__EQUITY_DERIVATIVE =
      InstrumentClassEnum._(
          6, _omitEnumNames ? '' : 'INSTRUMENT_CLASS_ENUM__EQUITY_DERIVATIVE');
  static const InstrumentClassEnum INSTRUMENT_CLASS_ENUM__INDEX_DERIVATIVE =
      InstrumentClassEnum._(
          7, _omitEnumNames ? '' : 'INSTRUMENT_CLASS_ENUM__INDEX_DERIVATIVE');
  static const InstrumentClassEnum INSTRUMENT_CLASS_ENUM__FX =
      InstrumentClassEnum._(
          8, _omitEnumNames ? '' : 'INSTRUMENT_CLASS_ENUM__FX');
  static const InstrumentClassEnum INSTRUMENT_CLASS_ENUM__WARRANT =
      InstrumentClassEnum._(
          9, _omitEnumNames ? '' : 'INSTRUMENT_CLASS_ENUM__WARRANT');
  static const InstrumentClassEnum INSTRUMENT_CLASS_ENUM__CFD =
      InstrumentClassEnum._(
          10, _omitEnumNames ? '' : 'INSTRUMENT_CLASS_ENUM__CFD');
  static const InstrumentClassEnum INSTRUMENT_CLASS_ENUM__OPTION =
      InstrumentClassEnum._(
          11, _omitEnumNames ? '' : 'INSTRUMENT_CLASS_ENUM__OPTION');
  static const InstrumentClassEnum INSTRUMENT_CLASS_ENUM__FUTURE =
      InstrumentClassEnum._(
          12, _omitEnumNames ? '' : 'INSTRUMENT_CLASS_ENUM__FUTURE');
  static const InstrumentClassEnum INSTRUMENT_CLASS_ENUM__OTHER =
      InstrumentClassEnum._(
          1000, _omitEnumNames ? '' : 'INSTRUMENT_CLASS_ENUM__OTHER');

  static const $core.List<InstrumentClassEnum> values = <InstrumentClassEnum>[
    INSTRUMENT_CLASS_ENUM__UNKNOWN,
    INSTRUMENT_CLASS_ENUM__EQUITY_SHARE,
    INSTRUMENT_CLASS_ENUM__TOKENIZED_SECURITY,
    INSTRUMENT_CLASS_ENUM__FUND_UNIT,
    INSTRUMENT_CLASS_ENUM__ETF_SHARE,
    INSTRUMENT_CLASS_ENUM__BOND,
    INSTRUMENT_CLASS_ENUM__EQUITY_DERIVATIVE,
    INSTRUMENT_CLASS_ENUM__INDEX_DERIVATIVE,
    INSTRUMENT_CLASS_ENUM__FX,
    INSTRUMENT_CLASS_ENUM__WARRANT,
    INSTRUMENT_CLASS_ENUM__CFD,
    INSTRUMENT_CLASS_ENUM__OPTION,
    INSTRUMENT_CLASS_ENUM__FUTURE,
    INSTRUMENT_CLASS_ENUM__OTHER,
  ];

  static final $core.Map<$core.int, InstrumentClassEnum> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static InstrumentClassEnum? valueOf($core.int value) => _byValue[value];

  const InstrumentClassEnum._(super.value, super.name);
}

class InstrumentCfiC1ClassEnum extends $pb.ProtobufEnum {
  static const InstrumentCfiC1ClassEnum INSTRUMENT_CFI_C1_CLASS_ENUM__UNKNOWN =
      InstrumentCfiC1ClassEnum._(
          0, _omitEnumNames ? '' : 'INSTRUMENT_CFI_C1_CLASS_ENUM__UNKNOWN');
  static const InstrumentCfiC1ClassEnum
      INSTRUMENT_CFI_C1_CLASS_ENUM__EQUITY__E = InstrumentCfiC1ClassEnum._(
          2, _omitEnumNames ? '' : 'INSTRUMENT_CFI_C1_CLASS_ENUM__EQUITY__E');
  static const InstrumentCfiC1ClassEnum INSTRUMENT_CFI_C1_CLASS_ENUM__DEBT__D =
      InstrumentCfiC1ClassEnum._(
          1, _omitEnumNames ? '' : 'INSTRUMENT_CFI_C1_CLASS_ENUM__DEBT__D');
  static const InstrumentCfiC1ClassEnum
      INSTRUMENT_CFI_C1_CLASS_ENUM__COLLECTIVE_INVESTMENT_VEHICLE__C =
      InstrumentCfiC1ClassEnum._(
          6,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C1_CLASS_ENUM__COLLECTIVE_INVESTMENT_VEHICLE__C');
  static const InstrumentCfiC1ClassEnum
      INSTRUMENT_CFI_C1_CLASS_ENUM__RIGHTS_WARRANT__R =
      InstrumentCfiC1ClassEnum._(
          4,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C1_CLASS_ENUM__RIGHTS_WARRANT__R');
  static const InstrumentCfiC1ClassEnum
      INSTRUMENT_CFI_C1_CLASS_ENUM__OPTION__O = InstrumentCfiC1ClassEnum._(
          3, _omitEnumNames ? '' : 'INSTRUMENT_CFI_C1_CLASS_ENUM__OPTION__O');
  static const InstrumentCfiC1ClassEnum
      INSTRUMENT_CFI_C1_CLASS_ENUM__FUTURE__F = InstrumentCfiC1ClassEnum._(
          5, _omitEnumNames ? '' : 'INSTRUMENT_CFI_C1_CLASS_ENUM__FUTURE__F');
  static const InstrumentCfiC1ClassEnum INSTRUMENT_CFI_C1_CLASS_ENUM__SWAPS__S =
      InstrumentCfiC1ClassEnum._(
          7, _omitEnumNames ? '' : 'INSTRUMENT_CFI_C1_CLASS_ENUM__SWAPS__S');
  static const InstrumentCfiC1ClassEnum
      INSTRUMENT_CFI_C1_CLASS_ENUM__HEDGE_OTHER__H = InstrumentCfiC1ClassEnum._(
          8,
          _omitEnumNames ? '' : 'INSTRUMENT_CFI_C1_CLASS_ENUM__HEDGE_OTHER__H');
  static const InstrumentCfiC1ClassEnum INSTRUMENT_CFI_C1_CLASS_ENUM__OTHER =
      InstrumentCfiC1ClassEnum._(
          1000, _omitEnumNames ? '' : 'INSTRUMENT_CFI_C1_CLASS_ENUM__OTHER');

  static const $core.List<InstrumentCfiC1ClassEnum> values =
      <InstrumentCfiC1ClassEnum>[
    INSTRUMENT_CFI_C1_CLASS_ENUM__UNKNOWN,
    INSTRUMENT_CFI_C1_CLASS_ENUM__EQUITY__E,
    INSTRUMENT_CFI_C1_CLASS_ENUM__DEBT__D,
    INSTRUMENT_CFI_C1_CLASS_ENUM__COLLECTIVE_INVESTMENT_VEHICLE__C,
    INSTRUMENT_CFI_C1_CLASS_ENUM__RIGHTS_WARRANT__R,
    INSTRUMENT_CFI_C1_CLASS_ENUM__OPTION__O,
    INSTRUMENT_CFI_C1_CLASS_ENUM__FUTURE__F,
    INSTRUMENT_CFI_C1_CLASS_ENUM__SWAPS__S,
    INSTRUMENT_CFI_C1_CLASS_ENUM__HEDGE_OTHER__H,
    INSTRUMENT_CFI_C1_CLASS_ENUM__OTHER,
  ];

  static final $core.Map<$core.int, InstrumentCfiC1ClassEnum> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static InstrumentCfiC1ClassEnum? valueOf($core.int value) => _byValue[value];

  const InstrumentCfiC1ClassEnum._(super.value, super.name);
}

class InstrumentCfiC2ClassEnum extends $pb.ProtobufEnum {
  static const InstrumentCfiC2ClassEnum INSTRUMENT_CFI_C2_CLASS_ENUM__UNKNOWN =
      InstrumentCfiC2ClassEnum._(
          0, _omitEnumNames ? '' : 'INSTRUMENT_CFI_C2_CLASS_ENUM__UNKNOWN');

  /// Equity (E) C2 codes
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__COMMON_ORDINARY_SHARES__ES =
      InstrumentCfiC2ClassEnum._(
          1,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__COMMON_ORDINARY_SHARES__ES');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__PREFERRED_PREFERENCE_SHARES__EP =
      InstrumentCfiC2ClassEnum._(
          2,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__PREFERRED_PREFERENCE_SHARES__EP');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__COMMON_CONDITIONAL_ENTITLEMENT__EC =
      InstrumentCfiC2ClassEnum._(
          3,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__COMMON_CONDITIONAL_ENTITLEMENT__EC');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__PREFERRED_CONDITIONAL_ENTITLEMENT__EF =
      InstrumentCfiC2ClassEnum._(
          4,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__PREFERRED_CONDITIONAL_ENTITLEMENT__EF');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__PREFERRED_SHARES__ER =
      InstrumentCfiC2ClassEnum._(
          5,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__PREFERRED_SHARES__ER');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__UNITS_UNCLASSIFIED__EU =
      InstrumentCfiC2ClassEnum._(
          6,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__UNITS_UNCLASSIFIED__EU');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__OTHERS_MISCELLANEOUS__EM =
      InstrumentCfiC2ClassEnum._(
          7,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__OTHERS_MISCELLANEOUS__EM');

  /// Debt (D) C2 codes
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__BONDS__DB = InstrumentCfiC2ClassEnum._(
          8, _omitEnumNames ? '' : 'INSTRUMENT_CFI_C2_CLASS_ENUM__BONDS__DB');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__CONVERTIBLE_BONDS__DC =
      InstrumentCfiC2ClassEnum._(
          9,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__CONVERTIBLE_BONDS__DC');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__BONDS_WITH_WARRANTS_ATTACHED__DW =
      InstrumentCfiC2ClassEnum._(
          10,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__BONDS_WITH_WARRANTS_ATTACHED__DW');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__MEDIUM_TERM_NOTES__DT =
      InstrumentCfiC2ClassEnum._(
          11,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__MEDIUM_TERM_NOTES__DT');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__MONEY_MARKETS__DY =
      InstrumentCfiC2ClassEnum._(
          12,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__MONEY_MARKETS__DY');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__MUNICIPAL_BONDS__DN =
      InstrumentCfiC2ClassEnum._(
          13,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__MUNICIPAL_BONDS__DN');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__DEPOSITS__DD = InstrumentCfiC2ClassEnum._(
          14,
          _omitEnumNames ? '' : 'INSTRUMENT_CFI_C2_CLASS_ENUM__DEPOSITS__DD');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__OTHERS_DEBT__DM =
      InstrumentCfiC2ClassEnum._(
          15,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__OTHERS_DEBT__DM');

  /// Rights (R) C2 codes
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__ALLOTMENT_RIGHTS__RA =
      InstrumentCfiC2ClassEnum._(
          16,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__ALLOTMENT_RIGHTS__RA');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__SUBSCRIPTION_RIGHTS__RS =
      InstrumentCfiC2ClassEnum._(
          17,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__SUBSCRIPTION_RIGHTS__RS');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__PURCHASE_RIGHTS__RP =
      InstrumentCfiC2ClassEnum._(
          18,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__PURCHASE_RIGHTS__RP');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__WARRANT_RIGHTS__RW =
      InstrumentCfiC2ClassEnum._(
          19,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__WARRANT_RIGHTS__RW');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__OTHERS_RIGHTS__RM =
      InstrumentCfiC2ClassEnum._(
          20,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__OTHERS_RIGHTS__RM');

  /// Options (O) C2 codes
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__CALL_OPTIONS__OC =
      InstrumentCfiC2ClassEnum._(
          21,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__CALL_OPTIONS__OC');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__PUT_OPTIONS__OP =
      InstrumentCfiC2ClassEnum._(
          22,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__PUT_OPTIONS__OP');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__OTHERS_OPTIONS__OM =
      InstrumentCfiC2ClassEnum._(
          23,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__OTHERS_OPTIONS__OM');

  /// Futures (F) C2 codes
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__FINANCIAL_FUTURES__FF =
      InstrumentCfiC2ClassEnum._(
          24,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__FINANCIAL_FUTURES__FF');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__COMMODITY_FUTURES__FC =
      InstrumentCfiC2ClassEnum._(
          25,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__COMMODITY_FUTURES__FC');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__OTHERS_FUTURES__FM =
      InstrumentCfiC2ClassEnum._(
          26,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__OTHERS_FUTURES__FM');

  /// Collective Investment Vehicles (C) C2 codes
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__STANDARD_OPEN_END__CO =
      InstrumentCfiC2ClassEnum._(
          27,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__STANDARD_OPEN_END__CO');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__STANDARD_CLOSED_END__CC =
      InstrumentCfiC2ClassEnum._(
          28,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__STANDARD_CLOSED_END__CC');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__NON_STANDARD__CN =
      InstrumentCfiC2ClassEnum._(
          29,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__NON_STANDARD__CN');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__OTHERS_COLLECTIVE__CM =
      InstrumentCfiC2ClassEnum._(
          30,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__OTHERS_COLLECTIVE__CM');

  /// Swaps (S) C2 codes
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__CREDIT_DEFAULT_SWAPS__SC =
      InstrumentCfiC2ClassEnum._(
          31,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__CREDIT_DEFAULT_SWAPS__SC');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__INTEREST_RATE_SWAPS__SI =
      InstrumentCfiC2ClassEnum._(
          32,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__INTEREST_RATE_SWAPS__SI');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__CURRENCY_SWAPS__SR =
      InstrumentCfiC2ClassEnum._(
          33,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__CURRENCY_SWAPS__SR');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__COMMODITY_SWAPS__SO =
      InstrumentCfiC2ClassEnum._(
          34,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__COMMODITY_SWAPS__SO');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__EQUITY_SWAPS__SE =
      InstrumentCfiC2ClassEnum._(
          35,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__EQUITY_SWAPS__SE');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__TOTAL_RETURN_SWAPS__ST =
      InstrumentCfiC2ClassEnum._(
          36,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__TOTAL_RETURN_SWAPS__ST');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__OTHERS_SWAPS__SM =
      InstrumentCfiC2ClassEnum._(
          37,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__OTHERS_SWAPS__SM');

  /// Non-listed and complex listed (H) C2 codes
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__NON_LISTED__HN = InstrumentCfiC2ClassEnum._(
          38,
          _omitEnumNames ? '' : 'INSTRUMENT_CFI_C2_CLASS_ENUM__NON_LISTED__HN');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__COMPLEX_LISTED__HC =
      InstrumentCfiC2ClassEnum._(
          39,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__COMPLEX_LISTED__HC');
  static const InstrumentCfiC2ClassEnum
      INSTRUMENT_CFI_C2_CLASS_ENUM__OTHERS_HEDGE__HM =
      InstrumentCfiC2ClassEnum._(
          40,
          _omitEnumNames
              ? ''
              : 'INSTRUMENT_CFI_C2_CLASS_ENUM__OTHERS_HEDGE__HM');
  static const InstrumentCfiC2ClassEnum INSTRUMENT_CFI_C2_CLASS_ENUM__OTHER =
      InstrumentCfiC2ClassEnum._(
          1000, _omitEnumNames ? '' : 'INSTRUMENT_CFI_C2_CLASS_ENUM__OTHER');

  static const $core.List<InstrumentCfiC2ClassEnum> values =
      <InstrumentCfiC2ClassEnum>[
    INSTRUMENT_CFI_C2_CLASS_ENUM__UNKNOWN,
    INSTRUMENT_CFI_C2_CLASS_ENUM__COMMON_ORDINARY_SHARES__ES,
    INSTRUMENT_CFI_C2_CLASS_ENUM__PREFERRED_PREFERENCE_SHARES__EP,
    INSTRUMENT_CFI_C2_CLASS_ENUM__COMMON_CONDITIONAL_ENTITLEMENT__EC,
    INSTRUMENT_CFI_C2_CLASS_ENUM__PREFERRED_CONDITIONAL_ENTITLEMENT__EF,
    INSTRUMENT_CFI_C2_CLASS_ENUM__PREFERRED_SHARES__ER,
    INSTRUMENT_CFI_C2_CLASS_ENUM__UNITS_UNCLASSIFIED__EU,
    INSTRUMENT_CFI_C2_CLASS_ENUM__OTHERS_MISCELLANEOUS__EM,
    INSTRUMENT_CFI_C2_CLASS_ENUM__BONDS__DB,
    INSTRUMENT_CFI_C2_CLASS_ENUM__CONVERTIBLE_BONDS__DC,
    INSTRUMENT_CFI_C2_CLASS_ENUM__BONDS_WITH_WARRANTS_ATTACHED__DW,
    INSTRUMENT_CFI_C2_CLASS_ENUM__MEDIUM_TERM_NOTES__DT,
    INSTRUMENT_CFI_C2_CLASS_ENUM__MONEY_MARKETS__DY,
    INSTRUMENT_CFI_C2_CLASS_ENUM__MUNICIPAL_BONDS__DN,
    INSTRUMENT_CFI_C2_CLASS_ENUM__DEPOSITS__DD,
    INSTRUMENT_CFI_C2_CLASS_ENUM__OTHERS_DEBT__DM,
    INSTRUMENT_CFI_C2_CLASS_ENUM__ALLOTMENT_RIGHTS__RA,
    INSTRUMENT_CFI_C2_CLASS_ENUM__SUBSCRIPTION_RIGHTS__RS,
    INSTRUMENT_CFI_C2_CLASS_ENUM__PURCHASE_RIGHTS__RP,
    INSTRUMENT_CFI_C2_CLASS_ENUM__WARRANT_RIGHTS__RW,
    INSTRUMENT_CFI_C2_CLASS_ENUM__OTHERS_RIGHTS__RM,
    INSTRUMENT_CFI_C2_CLASS_ENUM__CALL_OPTIONS__OC,
    INSTRUMENT_CFI_C2_CLASS_ENUM__PUT_OPTIONS__OP,
    INSTRUMENT_CFI_C2_CLASS_ENUM__OTHERS_OPTIONS__OM,
    INSTRUMENT_CFI_C2_CLASS_ENUM__FINANCIAL_FUTURES__FF,
    INSTRUMENT_CFI_C2_CLASS_ENUM__COMMODITY_FUTURES__FC,
    INSTRUMENT_CFI_C2_CLASS_ENUM__OTHERS_FUTURES__FM,
    INSTRUMENT_CFI_C2_CLASS_ENUM__STANDARD_OPEN_END__CO,
    INSTRUMENT_CFI_C2_CLASS_ENUM__STANDARD_CLOSED_END__CC,
    INSTRUMENT_CFI_C2_CLASS_ENUM__NON_STANDARD__CN,
    INSTRUMENT_CFI_C2_CLASS_ENUM__OTHERS_COLLECTIVE__CM,
    INSTRUMENT_CFI_C2_CLASS_ENUM__CREDIT_DEFAULT_SWAPS__SC,
    INSTRUMENT_CFI_C2_CLASS_ENUM__INTEREST_RATE_SWAPS__SI,
    INSTRUMENT_CFI_C2_CLASS_ENUM__CURRENCY_SWAPS__SR,
    INSTRUMENT_CFI_C2_CLASS_ENUM__COMMODITY_SWAPS__SO,
    INSTRUMENT_CFI_C2_CLASS_ENUM__EQUITY_SWAPS__SE,
    INSTRUMENT_CFI_C2_CLASS_ENUM__TOTAL_RETURN_SWAPS__ST,
    INSTRUMENT_CFI_C2_CLASS_ENUM__OTHERS_SWAPS__SM,
    INSTRUMENT_CFI_C2_CLASS_ENUM__NON_LISTED__HN,
    INSTRUMENT_CFI_C2_CLASS_ENUM__COMPLEX_LISTED__HC,
    INSTRUMENT_CFI_C2_CLASS_ENUM__OTHERS_HEDGE__HM,
    INSTRUMENT_CFI_C2_CLASS_ENUM__OTHER,
  ];

  static final $core.Map<$core.int, InstrumentCfiC2ClassEnum> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static InstrumentCfiC2ClassEnum? valueOf($core.int value) => _byValue[value];

  const InstrumentCfiC2ClassEnum._(super.value, super.name);
}

class InstrumentListingStatusEnum extends $pb.ProtobufEnum {
  static const InstrumentListingStatusEnum
      INSTRUMENT_LISTING_STATUS_ENUM__UNKNOWN = InstrumentListingStatusEnum._(
          0, _omitEnumNames ? '' : 'INSTRUMENT_LISTING_STATUS_ENUM__UNKNOWN');
  static const InstrumentListingStatusEnum
      INSTRUMENT_LISTING_STATUS_ENUM__WHEN_ISSUED =
      InstrumentListingStatusEnum._(1,
          _omitEnumNames ? '' : 'INSTRUMENT_LISTING_STATUS_ENUM__WHEN_ISSUED');
  static const InstrumentListingStatusEnum
      INSTRUMENT_LISTING_STATUS_ENUM__PRE_LISTING =
      InstrumentListingStatusEnum._(2,
          _omitEnumNames ? '' : 'INSTRUMENT_LISTING_STATUS_ENUM__PRE_LISTING');
  static const InstrumentListingStatusEnum
      INSTRUMENT_LISTING_STATUS_ENUM__LISTED = InstrumentListingStatusEnum._(
          3, _omitEnumNames ? '' : 'INSTRUMENT_LISTING_STATUS_ENUM__LISTED');
  static const InstrumentListingStatusEnum
      INSTRUMENT_LISTING_STATUS_ENUM__SUSPENDED = InstrumentListingStatusEnum._(
          4, _omitEnumNames ? '' : 'INSTRUMENT_LISTING_STATUS_ENUM__SUSPENDED');
  static const InstrumentListingStatusEnum
      INSTRUMENT_LISTING_STATUS_ENUM__HALTED = InstrumentListingStatusEnum._(
          5, _omitEnumNames ? '' : 'INSTRUMENT_LISTING_STATUS_ENUM__HALTED');
  static const InstrumentListingStatusEnum
      INSTRUMENT_LISTING_STATUS_ENUM__MATURED = InstrumentListingStatusEnum._(
          6, _omitEnumNames ? '' : 'INSTRUMENT_LISTING_STATUS_ENUM__MATURED');
  static const InstrumentListingStatusEnum
      INSTRUMENT_LISTING_STATUS_ENUM__EXPIRED = InstrumentListingStatusEnum._(
          7, _omitEnumNames ? '' : 'INSTRUMENT_LISTING_STATUS_ENUM__EXPIRED');
  static const InstrumentListingStatusEnum
      INSTRUMENT_LISTING_STATUS_ENUM__MERGED = InstrumentListingStatusEnum._(
          8, _omitEnumNames ? '' : 'INSTRUMENT_LISTING_STATUS_ENUM__MERGED');
  static const InstrumentListingStatusEnum
      INSTRUMENT_LISTING_STATUS_ENUM__DELISTED = InstrumentListingStatusEnum._(
          9, _omitEnumNames ? '' : 'INSTRUMENT_LISTING_STATUS_ENUM__DELISTED');
  static const InstrumentListingStatusEnum
      INSTRUMENT_LISTING_STATUS_ENUM__LIQUIDATED =
      InstrumentListingStatusEnum._(10,
          _omitEnumNames ? '' : 'INSTRUMENT_LISTING_STATUS_ENUM__LIQUIDATED');
  static const InstrumentListingStatusEnum
      INSTRUMENT_LISTING_STATUS_ENUM__TEST = InstrumentListingStatusEnum._(
          11, _omitEnumNames ? '' : 'INSTRUMENT_LISTING_STATUS_ENUM__TEST');
  static const InstrumentListingStatusEnum
      INSTRUMENT_LISTING_STATUS_ENUM__OTHER = InstrumentListingStatusEnum._(
          1000, _omitEnumNames ? '' : 'INSTRUMENT_LISTING_STATUS_ENUM__OTHER');

  static const $core.List<InstrumentListingStatusEnum> values =
      <InstrumentListingStatusEnum>[
    INSTRUMENT_LISTING_STATUS_ENUM__UNKNOWN,
    INSTRUMENT_LISTING_STATUS_ENUM__WHEN_ISSUED,
    INSTRUMENT_LISTING_STATUS_ENUM__PRE_LISTING,
    INSTRUMENT_LISTING_STATUS_ENUM__LISTED,
    INSTRUMENT_LISTING_STATUS_ENUM__SUSPENDED,
    INSTRUMENT_LISTING_STATUS_ENUM__HALTED,
    INSTRUMENT_LISTING_STATUS_ENUM__MATURED,
    INSTRUMENT_LISTING_STATUS_ENUM__EXPIRED,
    INSTRUMENT_LISTING_STATUS_ENUM__MERGED,
    INSTRUMENT_LISTING_STATUS_ENUM__DELISTED,
    INSTRUMENT_LISTING_STATUS_ENUM__LIQUIDATED,
    INSTRUMENT_LISTING_STATUS_ENUM__TEST,
    INSTRUMENT_LISTING_STATUS_ENUM__OTHER,
  ];

  static final $core.Map<$core.int, InstrumentListingStatusEnum> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static InstrumentListingStatusEnum? valueOf($core.int value) =>
      _byValue[value];

  const InstrumentListingStatusEnum._(super.value, super.name);
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

class TransactionTypeEnum extends $pb.ProtobufEnum {
  static const TransactionTypeEnum TRANSACTION_TYPE_ENUM__UNKNOWN =
      TransactionTypeEnum._(
          0, _omitEnumNames ? '' : 'TRANSACTION_TYPE_ENUM__UNKNOWN');
  static const TransactionTypeEnum TRANSACTION_TYPE_ENUM__DEPOSIT_CASH =
      TransactionTypeEnum._(
          1, _omitEnumNames ? '' : 'TRANSACTION_TYPE_ENUM__DEPOSIT_CASH');
  static const TransactionTypeEnum TRANSACTION_TYPE_ENUM__DEPOSIT_ASSET =
      TransactionTypeEnum._(
          2, _omitEnumNames ? '' : 'TRANSACTION_TYPE_ENUM__DEPOSIT_ASSET');
  static const TransactionTypeEnum TRANSACTION_TYPE_ENUM__WITHDRAW_CASH =
      TransactionTypeEnum._(
          3, _omitEnumNames ? '' : 'TRANSACTION_TYPE_ENUM__WITHDRAW_CASH');
  static const TransactionTypeEnum TRANSACTION_TYPE_ENUM__WITHDRAW_ASSET =
      TransactionTypeEnum._(
          4, _omitEnumNames ? '' : 'TRANSACTION_TYPE_ENUM__WITHDRAW_ASSET');
  static const TransactionTypeEnum TRANSACTION_TYPE_ENUM__TRADE_BUY =
      TransactionTypeEnum._(
          5, _omitEnumNames ? '' : 'TRANSACTION_TYPE_ENUM__TRADE_BUY');
  static const TransactionTypeEnum TRANSACTION_TYPE_ENUM__TRADE_SELL =
      TransactionTypeEnum._(
          6, _omitEnumNames ? '' : 'TRANSACTION_TYPE_ENUM__TRADE_SELL');
  static const TransactionTypeEnum TRANSACTION_TYPE_ENUM__FEE =
      TransactionTypeEnum._(
          7, _omitEnumNames ? '' : 'TRANSACTION_TYPE_ENUM__FEE');
  static const TransactionTypeEnum TRANSACTION_TYPE_ENUM__SETTLEMENT =
      TransactionTypeEnum._(
          8, _omitEnumNames ? '' : 'TRANSACTION_TYPE_ENUM__SETTLEMENT');
  static const TransactionTypeEnum TRANSACTION_TYPE_ENUM__TRANSFER_IN =
      TransactionTypeEnum._(
          9, _omitEnumNames ? '' : 'TRANSACTION_TYPE_ENUM__TRANSFER_IN');
  static const TransactionTypeEnum TRANSACTION_TYPE_ENUM__TRANSFER_OUT =
      TransactionTypeEnum._(
          10, _omitEnumNames ? '' : 'TRANSACTION_TYPE_ENUM__TRANSFER_OUT');
  static const TransactionTypeEnum TRANSACTION_TYPE_ENUM__OTHER =
      TransactionTypeEnum._(
          1000, _omitEnumNames ? '' : 'TRANSACTION_TYPE_ENUM__OTHER');

  static const $core.List<TransactionTypeEnum> values = <TransactionTypeEnum>[
    TRANSACTION_TYPE_ENUM__UNKNOWN,
    TRANSACTION_TYPE_ENUM__DEPOSIT_CASH,
    TRANSACTION_TYPE_ENUM__DEPOSIT_ASSET,
    TRANSACTION_TYPE_ENUM__WITHDRAW_CASH,
    TRANSACTION_TYPE_ENUM__WITHDRAW_ASSET,
    TRANSACTION_TYPE_ENUM__TRADE_BUY,
    TRANSACTION_TYPE_ENUM__TRADE_SELL,
    TRANSACTION_TYPE_ENUM__FEE,
    TRANSACTION_TYPE_ENUM__SETTLEMENT,
    TRANSACTION_TYPE_ENUM__TRANSFER_IN,
    TRANSACTION_TYPE_ENUM__TRANSFER_OUT,
    TRANSACTION_TYPE_ENUM__OTHER,
  ];

  static final $core.Map<$core.int, TransactionTypeEnum> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static TransactionTypeEnum? valueOf($core.int value) => _byValue[value];

  const TransactionTypeEnum._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
