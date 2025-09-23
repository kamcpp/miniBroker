// This is a generated file - do not edit.
//
// Generated from fin_common.proto.

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
  static const AccountTypeEnum ACCOUNT_TYPE_ENUM__OMNIBUS =
      AccountTypeEnum._(1, _omitEnumNames ? '' : 'ACCOUNT_TYPE_ENUM__OMNIBUS');
  static const AccountTypeEnum ACCOUNT_TYPE_ENUM__SEGREGATED =
      AccountTypeEnum._(
          2, _omitEnumNames ? '' : 'ACCOUNT_TYPE_ENUM__SEGREGATED');
  static const AccountTypeEnum ACCOUNT_TYPE_ENUM__HOUSE =
      AccountTypeEnum._(3, _omitEnumNames ? '' : 'ACCOUNT_TYPE_ENUM__HOUSE');
  static const AccountTypeEnum ACCOUNT_TYPE_ENUM__CLIENT =
      AccountTypeEnum._(4, _omitEnumNames ? '' : 'ACCOUNT_TYPE_ENUM__CLIENT');
  static const AccountTypeEnum ACCOUNT_TYPE_ENUM__NOMINEE =
      AccountTypeEnum._(5, _omitEnumNames ? '' : 'ACCOUNT_TYPE_ENUM__NOMINEE');
  static const AccountTypeEnum ACCOUNT_TYPE_ENUM__COLLATERAL =
      AccountTypeEnum._(
          6, _omitEnumNames ? '' : 'ACCOUNT_TYPE_ENUM__COLLATERAL');
  static const AccountTypeEnum ACCOUNT_TYPE_ENUM__ESCROW =
      AccountTypeEnum._(7, _omitEnumNames ? '' : 'ACCOUNT_TYPE_ENUM__ESCROW');
  static const AccountTypeEnum ACCOUNT_TYPE_ENUM__ISSUER =
      AccountTypeEnum._(8, _omitEnumNames ? '' : 'ACCOUNT_TYPE_ENUM__ISSUER');
  static const AccountTypeEnum ACCOUNT_TYPE_ENUM__OTHER =
      AccountTypeEnum._(1000, _omitEnumNames ? '' : 'ACCOUNT_TYPE_ENUM__OTHER');

  static const $core.List<AccountTypeEnum> values = <AccountTypeEnum>[
    ACCOUNT_TYPE_ENUM__UNKNOWN,
    ACCOUNT_TYPE_ENUM__OMNIBUS,
    ACCOUNT_TYPE_ENUM__SEGREGATED,
    ACCOUNT_TYPE_ENUM__HOUSE,
    ACCOUNT_TYPE_ENUM__CLIENT,
    ACCOUNT_TYPE_ENUM__NOMINEE,
    ACCOUNT_TYPE_ENUM__COLLATERAL,
    ACCOUNT_TYPE_ENUM__ESCROW,
    ACCOUNT_TYPE_ENUM__ISSUER,
    ACCOUNT_TYPE_ENUM__OTHER,
  ];

  static final $core.Map<$core.int, AccountTypeEnum> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static AccountTypeEnum? valueOf($core.int value) => _byValue[value];

  const AccountTypeEnum._(super.value, super.name);
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
  static const AccountStatusEnum ACCOUNT_STATUS_ENUM__SUSPENDED =
      AccountStatusEnum._(
          3, _omitEnumNames ? '' : 'ACCOUNT_STATUS_ENUM__SUSPENDED');
  static const AccountStatusEnum ACCOUNT_STATUS_ENUM__BLOCKED =
      AccountStatusEnum._(
          4, _omitEnumNames ? '' : 'ACCOUNT_STATUS_ENUM__BLOCKED');
  static const AccountStatusEnum ACCOUNT_STATUS_ENUM__CLOSED =
      AccountStatusEnum._(
          5, _omitEnumNames ? '' : 'ACCOUNT_STATUS_ENUM__CLOSED');
  static const AccountStatusEnum ACCOUNT_STATUS_ENUM__PENDING =
      AccountStatusEnum._(
          6, _omitEnumNames ? '' : 'ACCOUNT_STATUS_ENUM__PENDING');
  static const AccountStatusEnum ACCOUNT_STATUS_ENUM__TERMINATED =
      AccountStatusEnum._(
          7, _omitEnumNames ? '' : 'ACCOUNT_STATUS_ENUM__TERMINATED');
  static const AccountStatusEnum ACCOUNT_STATUS_ENUM__OTHER =
      AccountStatusEnum._(
          1000, _omitEnumNames ? '' : 'ACCOUNT_STATUS_ENUM__OTHER');

  static const $core.List<AccountStatusEnum> values = <AccountStatusEnum>[
    ACCOUNT_STATUS_ENUM__UNKNOWN,
    ACCOUNT_STATUS_ENUM__ACTIVE,
    ACCOUNT_STATUS_ENUM__INACTIVE,
    ACCOUNT_STATUS_ENUM__SUSPENDED,
    ACCOUNT_STATUS_ENUM__BLOCKED,
    ACCOUNT_STATUS_ENUM__CLOSED,
    ACCOUNT_STATUS_ENUM__PENDING,
    ACCOUNT_STATUS_ENUM__TERMINATED,
    ACCOUNT_STATUS_ENUM__OTHER,
  ];

  static final $core.Map<$core.int, AccountStatusEnum> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static AccountStatusEnum? valueOf($core.int value) => _byValue[value];

  const AccountStatusEnum._(super.value, super.name);
}

class AccountToAccountRelationTypeEnum extends $pb.ProtobufEnum {
  static const AccountToAccountRelationTypeEnum
      ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__UNKNOWN =
      AccountToAccountRelationTypeEnum._(
          0,
          _omitEnumNames
              ? ''
              : 'ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__UNKNOWN');
  static const AccountToAccountRelationTypeEnum
      ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__PARENT_CHILD =
      AccountToAccountRelationTypeEnum._(
          1,
          _omitEnumNames
              ? ''
              : 'ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__PARENT_CHILD');
  static const AccountToAccountRelationTypeEnum
      ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__HOUSE_CLIENT =
      AccountToAccountRelationTypeEnum._(
          2,
          _omitEnumNames
              ? ''
              : 'ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__HOUSE_CLIENT');
  static const AccountToAccountRelationTypeEnum
      ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__NOMINEE_BENEFICIAL =
      AccountToAccountRelationTypeEnum._(
          3,
          _omitEnumNames
              ? ''
              : 'ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__NOMINEE_BENEFICIAL');
  static const AccountToAccountRelationTypeEnum
      ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__COLLATERAL_LINK =
      AccountToAccountRelationTypeEnum._(
          4,
          _omitEnumNames
              ? ''
              : 'ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__COLLATERAL_LINK');
  static const AccountToAccountRelationTypeEnum
      ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__ESCROW_CONDITIONAL =
      AccountToAccountRelationTypeEnum._(
          5,
          _omitEnumNames
              ? ''
              : 'ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__ESCROW_CONDITIONAL');
  static const AccountToAccountRelationTypeEnum
      ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__CROSS_PARTICIPANT =
      AccountToAccountRelationTypeEnum._(
          6,
          _omitEnumNames
              ? ''
              : 'ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__CROSS_PARTICIPANT');
  static const AccountToAccountRelationTypeEnum
      ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__ISSUANCE_FLOW =
      AccountToAccountRelationTypeEnum._(
          7,
          _omitEnumNames
              ? ''
              : 'ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__ISSUANCE_FLOW');
  static const AccountToAccountRelationTypeEnum
      ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__REPORTING_POOL =
      AccountToAccountRelationTypeEnum._(
          8,
          _omitEnumNames
              ? ''
              : 'ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__REPORTING_POOL');
  static const AccountToAccountRelationTypeEnum
      ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__OTHER =
      AccountToAccountRelationTypeEnum._(1000,
          _omitEnumNames ? '' : 'ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__OTHER');

  static const $core.List<AccountToAccountRelationTypeEnum> values =
      <AccountToAccountRelationTypeEnum>[
    ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__UNKNOWN,
    ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__PARENT_CHILD,
    ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__HOUSE_CLIENT,
    ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__NOMINEE_BENEFICIAL,
    ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__COLLATERAL_LINK,
    ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__ESCROW_CONDITIONAL,
    ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__CROSS_PARTICIPANT,
    ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__ISSUANCE_FLOW,
    ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__REPORTING_POOL,
    ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__OTHER,
  ];

  static final $core.Map<$core.int, AccountToAccountRelationTypeEnum> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static AccountToAccountRelationTypeEnum? valueOf($core.int value) =>
      _byValue[value];

  const AccountToAccountRelationTypeEnum._(super.value, super.name);
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
  static const AssetClassEnum ASSET_CLASS_ENUM__EXTERNAL_INSTRUMENT =
      AssetClassEnum._(
          17, _omitEnumNames ? '' : 'ASSET_CLASS_ENUM__EXTERNAL_INSTRUMENT');
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
    ASSET_CLASS_ENUM__EXTERNAL_INSTRUMENT,
    ASSET_CLASS_ENUM__OTHER,
  ];

  static final $core.Map<$core.int, AssetClassEnum> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static AssetClassEnum? valueOf($core.int value) => _byValue[value];

  const AssetClassEnum._(super.value, super.name);
}

class ParticipantTypeEnum extends $pb.ProtobufEnum {
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__UNKNOWN =
      ParticipantTypeEnum._(
          0, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__UNKNOWN');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__INDIVIDUAL =
      ParticipantTypeEnum._(
          1, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__INDIVIDUAL');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__CORPORATE =
      ParticipantTypeEnum._(
          2, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__CORPORATE');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__GOVERMENTAL =
      ParticipantTypeEnum._(
          3, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__GOVERMENTAL');
  static const ParticipantTypeEnum
      PARTICIPANT_TYPE_ENUM__FINANCIAL_INSTITUTION = ParticipantTypeEnum._(4,
          _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__FINANCIAL_INSTITUTION');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__MARKET =
      ParticipantTypeEnum._(
          5, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__MARKET');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__VENUE =
      ParticipantTypeEnum._(
          6, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__VENUE');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__CUSTODIAN =
      ParticipantTypeEnum._(
          7, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__CUSTODIAN');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__BROKER_DEALER =
      ParticipantTypeEnum._(
          8, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__BROKER_DEALER');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__CLEARING_HOUSE =
      ParticipantTypeEnum._(
          9, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__CLEARING_HOUSE');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__CSD =
      ParticipantTypeEnum._(
          10, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__CSD');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__REGULATOR =
      ParticipantTypeEnum._(
          11, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__REGULATOR');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__EXTERNAL_PRINCIPAL =
      ParticipantTypeEnum._(12,
          _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__EXTERNAL_PRINCIPAL');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__INTERNAL_PRINCIPAL =
      ParticipantTypeEnum._(13,
          _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__INTERNAL_PRINCIPAL');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__SERVICE_PROVIDER =
      ParticipantTypeEnum._(
          14, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__SERVICE_PROVIDER');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__ISSUER =
      ParticipantTypeEnum._(
          15, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__ISSUER');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__INVESTOR =
      ParticipantTypeEnum._(
          16, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__INVESTOR');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__TRADER =
      ParticipantTypeEnum._(
          17, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__TRADER');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__MINER_VALIDATOR =
      ParticipantTypeEnum._(
          18, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__MINER_VALIDATOR');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__LIQUIDITY_PROVIDER =
      ParticipantTypeEnum._(19,
          _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__LIQUIDITY_PROVIDER');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__ORACLE =
      ParticipantTypeEnum._(
          20, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__ORACLE');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__AGENT =
      ParticipantTypeEnum._(
          21, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__AGENT');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__FUND_ADMINISTRATOR =
      ParticipantTypeEnum._(22,
          _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__FUND_ADMINISTRATOR');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__AUDITOR =
      ParticipantTypeEnum._(
          23, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__AUDITOR');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__LEGAL_ENTITY =
      ParticipantTypeEnum._(
          24, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__LEGAL_ENTITY');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__ACCOUNTING_ENTITY =
      ParticipantTypeEnum._(
          25, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__ACCOUNTING_ENTITY');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__TAX_ENTITY =
      ParticipantTypeEnum._(
          26, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__TAX_ENTITY');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__INSURANCE_ENTITY =
      ParticipantTypeEnum._(
          27, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__INSURANCE_ENTITY');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__PENSION_ENTITY =
      ParticipantTypeEnum._(
          28, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__PENSION_ENTITY');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__PAYMENT_ENTITY =
      ParticipantTypeEnum._(
          29, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__PAYMENT_ENTITY');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__TECHNOLOGY_PROVIDER =
      ParticipantTypeEnum._(30,
          _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__TECHNOLOGY_PROVIDER');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__DATA_PROVIDER =
      ParticipantTypeEnum._(
          31, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__DATA_PROVIDER');
  static const ParticipantTypeEnum PARTICIPANT_TYPE_ENUM__OTHER =
      ParticipantTypeEnum._(
          1000, _omitEnumNames ? '' : 'PARTICIPANT_TYPE_ENUM__OTHER');

  static const $core.List<ParticipantTypeEnum> values = <ParticipantTypeEnum>[
    PARTICIPANT_TYPE_ENUM__UNKNOWN,
    PARTICIPANT_TYPE_ENUM__INDIVIDUAL,
    PARTICIPANT_TYPE_ENUM__CORPORATE,
    PARTICIPANT_TYPE_ENUM__GOVERMENTAL,
    PARTICIPANT_TYPE_ENUM__FINANCIAL_INSTITUTION,
    PARTICIPANT_TYPE_ENUM__MARKET,
    PARTICIPANT_TYPE_ENUM__VENUE,
    PARTICIPANT_TYPE_ENUM__CUSTODIAN,
    PARTICIPANT_TYPE_ENUM__BROKER_DEALER,
    PARTICIPANT_TYPE_ENUM__CLEARING_HOUSE,
    PARTICIPANT_TYPE_ENUM__CSD,
    PARTICIPANT_TYPE_ENUM__REGULATOR,
    PARTICIPANT_TYPE_ENUM__EXTERNAL_PRINCIPAL,
    PARTICIPANT_TYPE_ENUM__INTERNAL_PRINCIPAL,
    PARTICIPANT_TYPE_ENUM__SERVICE_PROVIDER,
    PARTICIPANT_TYPE_ENUM__ISSUER,
    PARTICIPANT_TYPE_ENUM__INVESTOR,
    PARTICIPANT_TYPE_ENUM__TRADER,
    PARTICIPANT_TYPE_ENUM__MINER_VALIDATOR,
    PARTICIPANT_TYPE_ENUM__LIQUIDITY_PROVIDER,
    PARTICIPANT_TYPE_ENUM__ORACLE,
    PARTICIPANT_TYPE_ENUM__AGENT,
    PARTICIPANT_TYPE_ENUM__FUND_ADMINISTRATOR,
    PARTICIPANT_TYPE_ENUM__AUDITOR,
    PARTICIPANT_TYPE_ENUM__LEGAL_ENTITY,
    PARTICIPANT_TYPE_ENUM__ACCOUNTING_ENTITY,
    PARTICIPANT_TYPE_ENUM__TAX_ENTITY,
    PARTICIPANT_TYPE_ENUM__INSURANCE_ENTITY,
    PARTICIPANT_TYPE_ENUM__PENSION_ENTITY,
    PARTICIPANT_TYPE_ENUM__PAYMENT_ENTITY,
    PARTICIPANT_TYPE_ENUM__TECHNOLOGY_PROVIDER,
    PARTICIPANT_TYPE_ENUM__DATA_PROVIDER,
    PARTICIPANT_TYPE_ENUM__OTHER,
  ];

  static final $core.Map<$core.int, ParticipantTypeEnum> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static ParticipantTypeEnum? valueOf($core.int value) => _byValue[value];

  const ParticipantTypeEnum._(super.value, super.name);
}

class ParticipantToAssetRelationEnum extends $pb.ProtobufEnum {
  static const ParticipantToAssetRelationEnum
      PARTICIPANT_TO_ASSET_RELATION_ENUM__UNKNOWN =
      ParticipantToAssetRelationEnum._(0,
          _omitEnumNames ? '' : 'PARTICIPANT_TO_ASSET_RELATION_ENUM__UNKNOWN');
  static const ParticipantToAssetRelationEnum
      PARTICIPANT_TO_ASSET_RELATION_ENUM__ISSUER =
      ParticipantToAssetRelationEnum._(1,
          _omitEnumNames ? '' : 'PARTICIPANT_TO_ASSET_RELATION_ENUM__ISSUER');
  static const ParticipantToAssetRelationEnum
      PARTICIPANT_TO_ASSET_RELATION_ENUM__OWNER =
      ParticipantToAssetRelationEnum._(
          2, _omitEnumNames ? '' : 'PARTICIPANT_TO_ASSET_RELATION_ENUM__OWNER');
  static const ParticipantToAssetRelationEnum
      PARTICIPANT_TO_ASSET_RELATION_ENUM__SPONSOR =
      ParticipantToAssetRelationEnum._(3,
          _omitEnumNames ? '' : 'PARTICIPANT_TO_ASSET_RELATION_ENUM__SPONSOR');
  static const ParticipantToAssetRelationEnum
      PARTICIPANT_TO_ASSET_RELATION_ENUM__REGULATOR =
      ParticipantToAssetRelationEnum._(
          4,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_ASSET_RELATION_ENUM__REGULATOR');
  static const ParticipantToAssetRelationEnum
      PARTICIPANT_TO_ASSET_RELATION_ENUM__SUPERVISOR =
      ParticipantToAssetRelationEnum._(
          5,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_ASSET_RELATION_ENUM__SUPERVISOR');
  static const ParticipantToAssetRelationEnum
      PARTICIPANT_TO_ASSET_RELATION_ENUM__GOVERNOR =
      ParticipantToAssetRelationEnum._(6,
          _omitEnumNames ? '' : 'PARTICIPANT_TO_ASSET_RELATION_ENUM__GOVERNOR');
  static const ParticipantToAssetRelationEnum
      PARTICIPANT_TO_ASSET_RELATION_ENUM__CUSTODIAN =
      ParticipantToAssetRelationEnum._(
          7,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_ASSET_RELATION_ENUM__CUSTODIAN');
  static const ParticipantToAssetRelationEnum
      PARTICIPANT_TO_ASSET_RELATION_ENUM__BROKER =
      ParticipantToAssetRelationEnum._(8,
          _omitEnumNames ? '' : 'PARTICIPANT_TO_ASSET_RELATION_ENUM__BROKER');
  static const ParticipantToAssetRelationEnum
      PARTICIPANT_TO_ASSET_RELATION_ENUM__DEALER =
      ParticipantToAssetRelationEnum._(9,
          _omitEnumNames ? '' : 'PARTICIPANT_TO_ASSET_RELATION_ENUM__DEALER');
  static const ParticipantToAssetRelationEnum
      PARTICIPANT_TO_ASSET_RELATION_ENUM__MARKET =
      ParticipantToAssetRelationEnum._(10,
          _omitEnumNames ? '' : 'PARTICIPANT_TO_ASSET_RELATION_ENUM__MARKET');
  static const ParticipantToAssetRelationEnum
      PARTICIPANT_TO_ASSET_RELATION_ENUM__VENUE =
      ParticipantToAssetRelationEnum._(11,
          _omitEnumNames ? '' : 'PARTICIPANT_TO_ASSET_RELATION_ENUM__VENUE');
  static const ParticipantToAssetRelationEnum
      PARTICIPANT_TO_ASSET_RELATION_ENUM__AUDITOR =
      ParticipantToAssetRelationEnum._(12,
          _omitEnumNames ? '' : 'PARTICIPANT_TO_ASSET_RELATION_ENUM__AUDITOR');
  static const ParticipantToAssetRelationEnum
      PARTICIPANT_TO_ASSET_RELATION_ENUM__AGENT =
      ParticipantToAssetRelationEnum._(13,
          _omitEnumNames ? '' : 'PARTICIPANT_TO_ASSET_RELATION_ENUM__AGENT');
  static const ParticipantToAssetRelationEnum
      PARTICIPANT_TO_ASSET_RELATION_ENUM__ADVISOR =
      ParticipantToAssetRelationEnum._(14,
          _omitEnumNames ? '' : 'PARTICIPANT_TO_ASSET_RELATION_ENUM__ADVISOR');
  static const ParticipantToAssetRelationEnum
      PARTICIPANT_TO_ASSET_RELATION_ENUM__VALUATOR =
      ParticipantToAssetRelationEnum._(15,
          _omitEnumNames ? '' : 'PARTICIPANT_TO_ASSET_RELATION_ENUM__VALUATOR');
  static const ParticipantToAssetRelationEnum
      PARTICIPANT_TO_ASSET_RELATION_ENUM__ADMINISTRATOR =
      ParticipantToAssetRelationEnum._(
          16,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_ASSET_RELATION_ENUM__ADMINISTRATOR');
  static const ParticipantToAssetRelationEnum
      PARTICIPANT_TO_ASSET_RELATION_ENUM__MARKET_MAKER =
      ParticipantToAssetRelationEnum._(
          21,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_ASSET_RELATION_ENUM__MARKET_MAKER');
  static const ParticipantToAssetRelationEnum
      PARTICIPANT_TO_ASSET_RELATION_ENUM__LIQUIDITY_PROVIDER =
      ParticipantToAssetRelationEnum._(
          22,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_ASSET_RELATION_ENUM__LIQUIDITY_PROVIDER');
  static const ParticipantToAssetRelationEnum
      PARTICIPANT_TO_ASSET_RELATION_ENUM__ORACLE =
      ParticipantToAssetRelationEnum._(23,
          _omitEnumNames ? '' : 'PARTICIPANT_TO_ASSET_RELATION_ENUM__ORACLE');
  static const ParticipantToAssetRelationEnum
      PARTICIPANT_TO_ASSET_RELATION_ENUM__MINER_VALIDATOR =
      ParticipantToAssetRelationEnum._(
          24,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_ASSET_RELATION_ENUM__MINER_VALIDATOR');
  static const ParticipantToAssetRelationEnum
      PARTICIPANT_TO_ASSET_RELATION_ENUM__SERVICE_PROVIDER =
      ParticipantToAssetRelationEnum._(
          25,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_ASSET_RELATION_ENUM__SERVICE_PROVIDER');
  static const ParticipantToAssetRelationEnum
      PARTICIPANT_TO_ASSET_RELATION_ENUM__OTHER =
      ParticipantToAssetRelationEnum._(1000,
          _omitEnumNames ? '' : 'PARTICIPANT_TO_ASSET_RELATION_ENUM__OTHER');

  static const $core.List<ParticipantToAssetRelationEnum> values =
      <ParticipantToAssetRelationEnum>[
    PARTICIPANT_TO_ASSET_RELATION_ENUM__UNKNOWN,
    PARTICIPANT_TO_ASSET_RELATION_ENUM__ISSUER,
    PARTICIPANT_TO_ASSET_RELATION_ENUM__OWNER,
    PARTICIPANT_TO_ASSET_RELATION_ENUM__SPONSOR,
    PARTICIPANT_TO_ASSET_RELATION_ENUM__REGULATOR,
    PARTICIPANT_TO_ASSET_RELATION_ENUM__SUPERVISOR,
    PARTICIPANT_TO_ASSET_RELATION_ENUM__GOVERNOR,
    PARTICIPANT_TO_ASSET_RELATION_ENUM__CUSTODIAN,
    PARTICIPANT_TO_ASSET_RELATION_ENUM__BROKER,
    PARTICIPANT_TO_ASSET_RELATION_ENUM__DEALER,
    PARTICIPANT_TO_ASSET_RELATION_ENUM__MARKET,
    PARTICIPANT_TO_ASSET_RELATION_ENUM__VENUE,
    PARTICIPANT_TO_ASSET_RELATION_ENUM__AUDITOR,
    PARTICIPANT_TO_ASSET_RELATION_ENUM__AGENT,
    PARTICIPANT_TO_ASSET_RELATION_ENUM__ADVISOR,
    PARTICIPANT_TO_ASSET_RELATION_ENUM__VALUATOR,
    PARTICIPANT_TO_ASSET_RELATION_ENUM__ADMINISTRATOR,
    PARTICIPANT_TO_ASSET_RELATION_ENUM__MARKET_MAKER,
    PARTICIPANT_TO_ASSET_RELATION_ENUM__LIQUIDITY_PROVIDER,
    PARTICIPANT_TO_ASSET_RELATION_ENUM__ORACLE,
    PARTICIPANT_TO_ASSET_RELATION_ENUM__MINER_VALIDATOR,
    PARTICIPANT_TO_ASSET_RELATION_ENUM__SERVICE_PROVIDER,
    PARTICIPANT_TO_ASSET_RELATION_ENUM__OTHER,
  ];

  static final $core.Map<$core.int, ParticipantToAssetRelationEnum> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static ParticipantToAssetRelationEnum? valueOf($core.int value) =>
      _byValue[value];

  const ParticipantToAssetRelationEnum._(super.value, super.name);
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

class ParticipantToInstrumentRelationEnum extends $pb.ProtobufEnum {
  static const ParticipantToInstrumentRelationEnum
      PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__UNKNOWN =
      ParticipantToInstrumentRelationEnum._(
          0,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__UNKNOWN');
  static const ParticipantToInstrumentRelationEnum
      PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__ISSUER =
      ParticipantToInstrumentRelationEnum._(
          1,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__ISSUER');
  static const ParticipantToInstrumentRelationEnum
      PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__OWNER =
      ParticipantToInstrumentRelationEnum._(
          2,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__OWNER');
  static const ParticipantToInstrumentRelationEnum
      PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__SPONSOR =
      ParticipantToInstrumentRelationEnum._(
          3,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__SPONSOR');
  static const ParticipantToInstrumentRelationEnum
      PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__REGULATOR =
      ParticipantToInstrumentRelationEnum._(
          4,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__REGULATOR');
  static const ParticipantToInstrumentRelationEnum
      PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__SUPERVISOR =
      ParticipantToInstrumentRelationEnum._(
          5,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__SUPERVISOR');
  static const ParticipantToInstrumentRelationEnum
      PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__GOVERNOR =
      ParticipantToInstrumentRelationEnum._(
          6,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__GOVERNOR');
  static const ParticipantToInstrumentRelationEnum
      PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__CUSTODIAN =
      ParticipantToInstrumentRelationEnum._(
          7,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__CUSTODIAN');
  static const ParticipantToInstrumentRelationEnum
      PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__BROKER =
      ParticipantToInstrumentRelationEnum._(
          8,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__BROKER');
  static const ParticipantToInstrumentRelationEnum
      PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__DEALER =
      ParticipantToInstrumentRelationEnum._(
          9,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__DEALER');
  static const ParticipantToInstrumentRelationEnum
      PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__MARKET =
      ParticipantToInstrumentRelationEnum._(
          10,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__MARKET');
  static const ParticipantToInstrumentRelationEnum
      PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__VENUE =
      ParticipantToInstrumentRelationEnum._(
          11,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__VENUE');
  static const ParticipantToInstrumentRelationEnum
      PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__AUDITOR =
      ParticipantToInstrumentRelationEnum._(
          12,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__AUDITOR');
  static const ParticipantToInstrumentRelationEnum
      PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__AGENT =
      ParticipantToInstrumentRelationEnum._(
          13,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__AGENT');
  static const ParticipantToInstrumentRelationEnum
      PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__ADVISOR =
      ParticipantToInstrumentRelationEnum._(
          14,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__ADVISOR');
  static const ParticipantToInstrumentRelationEnum
      PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__ADMINISTRATOR =
      ParticipantToInstrumentRelationEnum._(
          16,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__ADMINISTRATOR');
  static const ParticipantToInstrumentRelationEnum
      PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__MARKET_MAKER =
      ParticipantToInstrumentRelationEnum._(
          21,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__MARKET_MAKER');
  static const ParticipantToInstrumentRelationEnum
      PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__LIQUIDITY_PROVIDER =
      ParticipantToInstrumentRelationEnum._(
          22,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__LIQUIDITY_PROVIDER');
  static const ParticipantToInstrumentRelationEnum
      PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__ORACLE =
      ParticipantToInstrumentRelationEnum._(
          23,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__ORACLE');
  static const ParticipantToInstrumentRelationEnum
      PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__MINER_VALIDATOR =
      ParticipantToInstrumentRelationEnum._(
          24,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__MINER_VALIDATOR');
  static const ParticipantToInstrumentRelationEnum
      PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__SERVICE_PROVIDER =
      ParticipantToInstrumentRelationEnum._(
          25,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__SERVICE_PROVIDER');
  static const ParticipantToInstrumentRelationEnum
      PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__OTHER =
      ParticipantToInstrumentRelationEnum._(
          1000,
          _omitEnumNames
              ? ''
              : 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__OTHER');

  static const $core.List<ParticipantToInstrumentRelationEnum> values =
      <ParticipantToInstrumentRelationEnum>[
    PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__UNKNOWN,
    PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__ISSUER,
    PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__OWNER,
    PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__SPONSOR,
    PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__REGULATOR,
    PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__SUPERVISOR,
    PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__GOVERNOR,
    PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__CUSTODIAN,
    PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__BROKER,
    PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__DEALER,
    PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__MARKET,
    PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__VENUE,
    PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__AUDITOR,
    PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__AGENT,
    PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__ADVISOR,
    PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__ADMINISTRATOR,
    PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__MARKET_MAKER,
    PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__LIQUIDITY_PROVIDER,
    PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__ORACLE,
    PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__MINER_VALIDATOR,
    PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__SERVICE_PROVIDER,
    PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__OTHER,
  ];

  static final $core.Map<$core.int, ParticipantToInstrumentRelationEnum>
      _byValue = $pb.ProtobufEnum.initByValue(values);
  static ParticipantToInstrumentRelationEnum? valueOf($core.int value) =>
      _byValue[value];

  const ParticipantToInstrumentRelationEnum._(super.value, super.name);
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
