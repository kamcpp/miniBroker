// This is a generated file - do not edit.
//
// Generated from fin_common.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use accountTypeEnumDescriptor instead')
const AccountTypeEnum$json = {
  '1': 'AccountTypeEnum',
  '2': [
    {'1': 'ACCOUNT_TYPE_ENUM__UNKNOWN', '2': 0},
    {'1': 'ACCOUNT_TYPE_ENUM__OMNIBUS', '2': 1},
    {'1': 'ACCOUNT_TYPE_ENUM__SEGREGATED', '2': 2},
    {'1': 'ACCOUNT_TYPE_ENUM__HOUSE', '2': 3},
    {'1': 'ACCOUNT_TYPE_ENUM__CLIENT', '2': 4},
    {'1': 'ACCOUNT_TYPE_ENUM__NOMINEE', '2': 5},
    {'1': 'ACCOUNT_TYPE_ENUM__COLLATERAL', '2': 6},
    {'1': 'ACCOUNT_TYPE_ENUM__ESCROW', '2': 7},
    {'1': 'ACCOUNT_TYPE_ENUM__ISSUER', '2': 8},
    {'1': 'ACCOUNT_TYPE_ENUM__OTHER', '2': 1000},
  ],
};

/// Descriptor for `AccountTypeEnum`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List accountTypeEnumDescriptor = $convert.base64Decode(
    'Cg9BY2NvdW50VHlwZUVudW0SHgoaQUNDT1VOVF9UWVBFX0VOVU1fX1VOS05PV04QABIeChpBQ0'
    'NPVU5UX1RZUEVfRU5VTV9fT01OSUJVUxABEiEKHUFDQ09VTlRfVFlQRV9FTlVNX19TRUdSRUdB'
    'VEVEEAISHAoYQUNDT1VOVF9UWVBFX0VOVU1fX0hPVVNFEAMSHQoZQUNDT1VOVF9UWVBFX0VOVU'
    '1fX0NMSUVOVBAEEh4KGkFDQ09VTlRfVFlQRV9FTlVNX19OT01JTkVFEAUSIQodQUNDT1VOVF9U'
    'WVBFX0VOVU1fX0NPTExBVEVSQUwQBhIdChlBQ0NPVU5UX1RZUEVfRU5VTV9fRVNDUk9XEAcSHQ'
    'oZQUNDT1VOVF9UWVBFX0VOVU1fX0lTU1VFUhAIEh0KGEFDQ09VTlRfVFlQRV9FTlVNX19PVEhF'
    'UhDoBw==');

@$core.Deprecated('Use accountStatusEnumDescriptor instead')
const AccountStatusEnum$json = {
  '1': 'AccountStatusEnum',
  '2': [
    {'1': 'ACCOUNT_STATUS_ENUM__UNKNOWN', '2': 0},
    {'1': 'ACCOUNT_STATUS_ENUM__ACTIVE', '2': 1},
    {'1': 'ACCOUNT_STATUS_ENUM__INACTIVE', '2': 2},
    {'1': 'ACCOUNT_STATUS_ENUM__SUSPENDED', '2': 3},
    {'1': 'ACCOUNT_STATUS_ENUM__BLOCKED', '2': 4},
    {'1': 'ACCOUNT_STATUS_ENUM__CLOSED', '2': 5},
    {'1': 'ACCOUNT_STATUS_ENUM__PENDING', '2': 6},
    {'1': 'ACCOUNT_STATUS_ENUM__TERMINATED', '2': 7},
    {'1': 'ACCOUNT_STATUS_ENUM__OTHER', '2': 1000},
  ],
};

/// Descriptor for `AccountStatusEnum`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List accountStatusEnumDescriptor = $convert.base64Decode(
    'ChFBY2NvdW50U3RhdHVzRW51bRIgChxBQ0NPVU5UX1NUQVRVU19FTlVNX19VTktOT1dOEAASHw'
    'obQUNDT1VOVF9TVEFUVVNfRU5VTV9fQUNUSVZFEAESIQodQUNDT1VOVF9TVEFUVVNfRU5VTV9f'
    'SU5BQ1RJVkUQAhIiCh5BQ0NPVU5UX1NUQVRVU19FTlVNX19TVVNQRU5ERUQQAxIgChxBQ0NPVU'
    '5UX1NUQVRVU19FTlVNX19CTE9DS0VEEAQSHwobQUNDT1VOVF9TVEFUVVNfRU5VTV9fQ0xPU0VE'
    'EAUSIAocQUNDT1VOVF9TVEFUVVNfRU5VTV9fUEVORElORxAGEiMKH0FDQ09VTlRfU1RBVFVTX0'
    'VOVU1fX1RFUk1JTkFURUQQBxIfChpBQ0NPVU5UX1NUQVRVU19FTlVNX19PVEhFUhDoBw==');

@$core.Deprecated('Use accountToAccountRelationTypeEnumDescriptor instead')
const AccountToAccountRelationTypeEnum$json = {
  '1': 'AccountToAccountRelationTypeEnum',
  '2': [
    {'1': 'ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__UNKNOWN', '2': 0},
    {'1': 'ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__PARENT_CHILD', '2': 1},
    {'1': 'ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__HOUSE_CLIENT', '2': 2},
    {'1': 'ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__NOMINEE_BENEFICIAL', '2': 3},
    {'1': 'ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__COLLATERAL_LINK', '2': 4},
    {'1': 'ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__ESCROW_CONDITIONAL', '2': 5},
    {'1': 'ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__CROSS_PARTICIPANT', '2': 6},
    {'1': 'ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__ISSUANCE_FLOW', '2': 7},
    {'1': 'ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__REPORTING_POOL', '2': 8},
    {'1': 'ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__OTHER', '2': 1000},
  ],
};

/// Descriptor for `AccountToAccountRelationTypeEnum`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List accountToAccountRelationTypeEnumDescriptor = $convert.base64Decode(
    'CiBBY2NvdW50VG9BY2NvdW50UmVsYXRpb25UeXBlRW51bRIyCi5BQ0NPVU5UX1RPX0FDQ09VTl'
    'RfUkVMQVRJT05fVFlQRV9FTlVNX19VTktOT1dOEAASNwozQUNDT1VOVF9UT19BQ0NPVU5UX1JF'
    'TEFUSU9OX1RZUEVfRU5VTV9fUEFSRU5UX0NISUxEEAESNwozQUNDT1VOVF9UT19BQ0NPVU5UX1'
    'JFTEFUSU9OX1RZUEVfRU5VTV9fSE9VU0VfQ0xJRU5UEAISPQo5QUNDT1VOVF9UT19BQ0NPVU5U'
    'X1JFTEFUSU9OX1RZUEVfRU5VTV9fTk9NSU5FRV9CRU5FRklDSUFMEAMSOgo2QUNDT1VOVF9UT1'
    '9BQ0NPVU5UX1JFTEFUSU9OX1RZUEVfRU5VTV9fQ09MTEFURVJBTF9MSU5LEAQSPQo5QUNDT1VO'
    'VF9UT19BQ0NPVU5UX1JFTEFUSU9OX1RZUEVfRU5VTV9fRVNDUk9XX0NPTkRJVElPTkFMEAUSPA'
    'o4QUNDT1VOVF9UT19BQ0NPVU5UX1JFTEFUSU9OX1RZUEVfRU5VTV9fQ1JPU1NfUEFSVElDSVBB'
    'TlQQBhI4CjRBQ0NPVU5UX1RPX0FDQ09VTlRfUkVMQVRJT05fVFlQRV9FTlVNX19JU1NVQU5DRV'
    '9GTE9XEAcSOQo1QUNDT1VOVF9UT19BQ0NPVU5UX1JFTEFUSU9OX1RZUEVfRU5VTV9fUkVQT1JU'
    'SU5HX1BPT0wQCBIxCixBQ0NPVU5UX1RPX0FDQ09VTlRfUkVMQVRJT05fVFlQRV9FTlVNX19PVE'
    'hFUhDoBw==');

@$core.Deprecated('Use finEntityTypeEnumDescriptor instead')
const FinEntityTypeEnum$json = {
  '1': 'FinEntityTypeEnum',
  '2': [
    {'1': 'FIN_ENTITY_TYPE_ENUM__UNKNOWN', '2': 0},
    {'1': 'FIN_ENTITY_TYPE_ENUM__PARTICIPANT', '2': 1},
    {'1': 'FIN_ENTITY_TYPE_ENUM__INSTRUMENT', '2': 2},
    {'1': 'FIN_ENTITY_TYPE_ENUM__MARKET', '2': 3},
    {'1': 'FIN_ENTITY_TYPE_ENUM__VENUE', '2': 4},
    {'1': 'FIN_ENTITY_TYPE_ENUM__OTHER', '2': 1000},
  ],
};

/// Descriptor for `FinEntityTypeEnum`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List finEntityTypeEnumDescriptor = $convert.base64Decode(
    'ChFGaW5FbnRpdHlUeXBlRW51bRIhCh1GSU5fRU5USVRZX1RZUEVfRU5VTV9fVU5LTk9XThAAEi'
    'UKIUZJTl9FTlRJVFlfVFlQRV9FTlVNX19QQVJUSUNJUEFOVBABEiQKIEZJTl9FTlRJVFlfVFlQ'
    'RV9FTlVNX19JTlNUUlVNRU5UEAISIAocRklOX0VOVElUWV9UWVBFX0VOVU1fX01BUktFVBADEh'
    '8KG0ZJTl9FTlRJVFlfVFlQRV9FTlVNX19WRU5VRRAEEiAKG0ZJTl9FTlRJVFlfVFlQRV9FTlVN'
    'X19PVEhFUhDoBw==');

@$core.Deprecated('Use assetClassEnumDescriptor instead')
const AssetClassEnum$json = {
  '1': 'AssetClassEnum',
  '2': [
    {'1': 'ASSET_CLASS_ENUM__UNKNOWN', '2': 0},
    {'1': 'ASSET_CLASS_ENUM__COMPANY', '2': 1},
    {'1': 'ASSET_CLASS_ENUM__GOVERMENTAL', '2': 2},
    {'1': 'ASSET_CLASS_ENUM__CURRENCY', '2': 3},
    {'1': 'ASSET_CLASS_ENUM__COMMODITY', '2': 4},
    {'1': 'ASSET_CLASS_ENUM__PRECIOUS_METALS', '2': 5},
    {'1': 'ASSET_CLASS_ENUM__INDUSTRIAL_METALS', '2': 6},
    {'1': 'ASSET_CLASS_ENUM__RWA', '2': 7},
    {'1': 'ASSET_CLASS_ENUM__STABLECOIN', '2': 9},
    {'1': 'ASSET_CLASS_ENUM__NFT', '2': 10},
    {'1': 'ASSET_CLASS_ENUM__REAL_ESTATE', '2': 11},
    {'1': 'ASSET_CLASS_ENUM__FUND', '2': 12},
    {'1': 'ASSET_CLASS_ENUM__INDEX', '2': 13},
    {'1': 'ASSET_CLASS_ENUM__CREDIT', '2': 14},
    {'1': 'ASSET_CLASS_ENUM__DIGITAL', '2': 15},
    {'1': 'ASSET_CLASS_ENUM__LEDGER_NATIVE_COIN', '2': 16},
    {'1': 'ASSET_CLASS_ENUM__EXTERNAL_INSTRUMENT', '2': 17},
    {'1': 'ASSET_CLASS_ENUM__OTHER', '2': 1000},
  ],
};

/// Descriptor for `AssetClassEnum`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List assetClassEnumDescriptor = $convert.base64Decode(
    'Cg5Bc3NldENsYXNzRW51bRIdChlBU1NFVF9DTEFTU19FTlVNX19VTktOT1dOEAASHQoZQVNTRV'
    'RfQ0xBU1NfRU5VTV9fQ09NUEFOWRABEiEKHUFTU0VUX0NMQVNTX0VOVU1fX0dPVkVSTUVOVEFM'
    'EAISHgoaQVNTRVRfQ0xBU1NfRU5VTV9fQ1VSUkVOQ1kQAxIfChtBU1NFVF9DTEFTU19FTlVNX1'
    '9DT01NT0RJVFkQBBIlCiFBU1NFVF9DTEFTU19FTlVNX19QUkVDSU9VU19NRVRBTFMQBRInCiNB'
    'U1NFVF9DTEFTU19FTlVNX19JTkRVU1RSSUFMX01FVEFMUxAGEhkKFUFTU0VUX0NMQVNTX0VOVU'
    '1fX1JXQRAHEiAKHEFTU0VUX0NMQVNTX0VOVU1fX1NUQUJMRUNPSU4QCRIZChVBU1NFVF9DTEFT'
    'U19FTlVNX19ORlQQChIhCh1BU1NFVF9DTEFTU19FTlVNX19SRUFMX0VTVEFURRALEhoKFkFTU0'
    'VUX0NMQVNTX0VOVU1fX0ZVTkQQDBIbChdBU1NFVF9DTEFTU19FTlVNX19JTkRFWBANEhwKGEFT'
    'U0VUX0NMQVNTX0VOVU1fX0NSRURJVBAOEh0KGUFTU0VUX0NMQVNTX0VOVU1fX0RJR0lUQUwQDx'
    'IoCiRBU1NFVF9DTEFTU19FTlVNX19MRURHRVJfTkFUSVZFX0NPSU4QEBIpCiVBU1NFVF9DTEFT'
    'U19FTlVNX19FWFRFUk5BTF9JTlNUUlVNRU5UEBESHAoXQVNTRVRfQ0xBU1NfRU5VTV9fT1RIRV'
    'IQ6Ac=');

@$core.Deprecated('Use participantTypeEnumDescriptor instead')
const ParticipantTypeEnum$json = {
  '1': 'ParticipantTypeEnum',
  '2': [
    {'1': 'PARTICIPANT_TYPE_ENUM__UNKNOWN', '2': 0},
    {'1': 'PARTICIPANT_TYPE_ENUM__INDIVIDUAL', '2': 1},
    {'1': 'PARTICIPANT_TYPE_ENUM__CORPORATE', '2': 2},
    {'1': 'PARTICIPANT_TYPE_ENUM__GOVERMENTAL', '2': 3},
    {'1': 'PARTICIPANT_TYPE_ENUM__FINANCIAL_INSTITUTION', '2': 4},
    {'1': 'PARTICIPANT_TYPE_ENUM__MARKET', '2': 5},
    {'1': 'PARTICIPANT_TYPE_ENUM__VENUE', '2': 6},
    {'1': 'PARTICIPANT_TYPE_ENUM__CUSTODIAN', '2': 7},
    {'1': 'PARTICIPANT_TYPE_ENUM__BROKER_DEALER', '2': 8},
    {'1': 'PARTICIPANT_TYPE_ENUM__CLEARING_HOUSE', '2': 9},
    {'1': 'PARTICIPANT_TYPE_ENUM__CSD', '2': 10},
    {'1': 'PARTICIPANT_TYPE_ENUM__REGULATOR', '2': 11},
    {'1': 'PARTICIPANT_TYPE_ENUM__EXTERNAL_PRINCIPAL', '2': 12},
    {'1': 'PARTICIPANT_TYPE_ENUM__INTERNAL_PRINCIPAL', '2': 13},
    {'1': 'PARTICIPANT_TYPE_ENUM__SERVICE_PROVIDER', '2': 14},
    {'1': 'PARTICIPANT_TYPE_ENUM__ISSUER', '2': 15},
    {'1': 'PARTICIPANT_TYPE_ENUM__INVESTOR', '2': 16},
    {'1': 'PARTICIPANT_TYPE_ENUM__TRADER', '2': 17},
    {'1': 'PARTICIPANT_TYPE_ENUM__MINER_VALIDATOR', '2': 18},
    {'1': 'PARTICIPANT_TYPE_ENUM__LIQUIDITY_PROVIDER', '2': 19},
    {'1': 'PARTICIPANT_TYPE_ENUM__ORACLE', '2': 20},
    {'1': 'PARTICIPANT_TYPE_ENUM__AGENT', '2': 21},
    {'1': 'PARTICIPANT_TYPE_ENUM__FUND_ADMINISTRATOR', '2': 22},
    {'1': 'PARTICIPANT_TYPE_ENUM__AUDITOR', '2': 23},
    {'1': 'PARTICIPANT_TYPE_ENUM__LEGAL_ENTITY', '2': 24},
    {'1': 'PARTICIPANT_TYPE_ENUM__ACCOUNTING_ENTITY', '2': 25},
    {'1': 'PARTICIPANT_TYPE_ENUM__TAX_ENTITY', '2': 26},
    {'1': 'PARTICIPANT_TYPE_ENUM__INSURANCE_ENTITY', '2': 27},
    {'1': 'PARTICIPANT_TYPE_ENUM__PENSION_ENTITY', '2': 28},
    {'1': 'PARTICIPANT_TYPE_ENUM__PAYMENT_ENTITY', '2': 29},
    {'1': 'PARTICIPANT_TYPE_ENUM__TECHNOLOGY_PROVIDER', '2': 30},
    {'1': 'PARTICIPANT_TYPE_ENUM__DATA_PROVIDER', '2': 31},
    {'1': 'PARTICIPANT_TYPE_ENUM__OTHER', '2': 1000},
  ],
};

/// Descriptor for `ParticipantTypeEnum`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List participantTypeEnumDescriptor = $convert.base64Decode(
    'ChNQYXJ0aWNpcGFudFR5cGVFbnVtEiIKHlBBUlRJQ0lQQU5UX1RZUEVfRU5VTV9fVU5LTk9XTh'
    'AAEiUKIVBBUlRJQ0lQQU5UX1RZUEVfRU5VTV9fSU5ESVZJRFVBTBABEiQKIFBBUlRJQ0lQQU5U'
    'X1RZUEVfRU5VTV9fQ09SUE9SQVRFEAISJgoiUEFSVElDSVBBTlRfVFlQRV9FTlVNX19HT1ZFUk'
    '1FTlRBTBADEjAKLFBBUlRJQ0lQQU5UX1RZUEVfRU5VTV9fRklOQU5DSUFMX0lOU1RJVFVUSU9O'
    'EAQSIQodUEFSVElDSVBBTlRfVFlQRV9FTlVNX19NQVJLRVQQBRIgChxQQVJUSUNJUEFOVF9UWV'
    'BFX0VOVU1fX1ZFTlVFEAYSJAogUEFSVElDSVBBTlRfVFlQRV9FTlVNX19DVVNUT0RJQU4QBxIo'
    'CiRQQVJUSUNJUEFOVF9UWVBFX0VOVU1fX0JST0tFUl9ERUFMRVIQCBIpCiVQQVJUSUNJUEFOVF'
    '9UWVBFX0VOVU1fX0NMRUFSSU5HX0hPVVNFEAkSHgoaUEFSVElDSVBBTlRfVFlQRV9FTlVNX19D'
    'U0QQChIkCiBQQVJUSUNJUEFOVF9UWVBFX0VOVU1fX1JFR1VMQVRPUhALEi0KKVBBUlRJQ0lQQU'
    '5UX1RZUEVfRU5VTV9fRVhURVJOQUxfUFJJTkNJUEFMEAwSLQopUEFSVElDSVBBTlRfVFlQRV9F'
    'TlVNX19JTlRFUk5BTF9QUklOQ0lQQUwQDRIrCidQQVJUSUNJUEFOVF9UWVBFX0VOVU1fX1NFUl'
    'ZJQ0VfUFJPVklERVIQDhIhCh1QQVJUSUNJUEFOVF9UWVBFX0VOVU1fX0lTU1VFUhAPEiMKH1BB'
    'UlRJQ0lQQU5UX1RZUEVfRU5VTV9fSU5WRVNUT1IQEBIhCh1QQVJUSUNJUEFOVF9UWVBFX0VOVU'
    '1fX1RSQURFUhAREioKJlBBUlRJQ0lQQU5UX1RZUEVfRU5VTV9fTUlORVJfVkFMSURBVE9SEBIS'
    'LQopUEFSVElDSVBBTlRfVFlQRV9FTlVNX19MSVFVSURJVFlfUFJPVklERVIQExIhCh1QQVJUSU'
    'NJUEFOVF9UWVBFX0VOVU1fX09SQUNMRRAUEiAKHFBBUlRJQ0lQQU5UX1RZUEVfRU5VTV9fQUdF'
    'TlQQFRItCilQQVJUSUNJUEFOVF9UWVBFX0VOVU1fX0ZVTkRfQURNSU5JU1RSQVRPUhAWEiIKHl'
    'BBUlRJQ0lQQU5UX1RZUEVfRU5VTV9fQVVESVRPUhAXEicKI1BBUlRJQ0lQQU5UX1RZUEVfRU5V'
    'TV9fTEVHQUxfRU5USVRZEBgSLAooUEFSVElDSVBBTlRfVFlQRV9FTlVNX19BQ0NPVU5USU5HX0'
    'VOVElUWRAZEiUKIVBBUlRJQ0lQQU5UX1RZUEVfRU5VTV9fVEFYX0VOVElUWRAaEisKJ1BBUlRJ'
    'Q0lQQU5UX1RZUEVfRU5VTV9fSU5TVVJBTkNFX0VOVElUWRAbEikKJVBBUlRJQ0lQQU5UX1RZUE'
    'VfRU5VTV9fUEVOU0lPTl9FTlRJVFkQHBIpCiVQQVJUSUNJUEFOVF9UWVBFX0VOVU1fX1BBWU1F'
    'TlRfRU5USVRZEB0SLgoqUEFSVElDSVBBTlRfVFlQRV9FTlVNX19URUNITk9MT0dZX1BST1ZJRE'
    'VSEB4SKAokUEFSVElDSVBBTlRfVFlQRV9FTlVNX19EQVRBX1BST1ZJREVSEB8SIQocUEFSVElD'
    'SVBBTlRfVFlQRV9FTlVNX19PVEhFUhDoBw==');

@$core.Deprecated('Use participantToAssetRelationEnumDescriptor instead')
const ParticipantToAssetRelationEnum$json = {
  '1': 'ParticipantToAssetRelationEnum',
  '2': [
    {'1': 'PARTICIPANT_TO_ASSET_RELATION_ENUM__UNKNOWN', '2': 0},
    {'1': 'PARTICIPANT_TO_ASSET_RELATION_ENUM__ISSUER', '2': 1},
    {'1': 'PARTICIPANT_TO_ASSET_RELATION_ENUM__OWNER', '2': 2},
    {'1': 'PARTICIPANT_TO_ASSET_RELATION_ENUM__SPONSOR', '2': 3},
    {'1': 'PARTICIPANT_TO_ASSET_RELATION_ENUM__REGULATOR', '2': 4},
    {'1': 'PARTICIPANT_TO_ASSET_RELATION_ENUM__SUPERVISOR', '2': 5},
    {'1': 'PARTICIPANT_TO_ASSET_RELATION_ENUM__GOVERNOR', '2': 6},
    {'1': 'PARTICIPANT_TO_ASSET_RELATION_ENUM__CUSTODIAN', '2': 7},
    {'1': 'PARTICIPANT_TO_ASSET_RELATION_ENUM__BROKER', '2': 8},
    {'1': 'PARTICIPANT_TO_ASSET_RELATION_ENUM__DEALER', '2': 9},
    {'1': 'PARTICIPANT_TO_ASSET_RELATION_ENUM__MARKET', '2': 10},
    {'1': 'PARTICIPANT_TO_ASSET_RELATION_ENUM__VENUE', '2': 11},
    {'1': 'PARTICIPANT_TO_ASSET_RELATION_ENUM__AUDITOR', '2': 12},
    {'1': 'PARTICIPANT_TO_ASSET_RELATION_ENUM__AGENT', '2': 13},
    {'1': 'PARTICIPANT_TO_ASSET_RELATION_ENUM__ADVISOR', '2': 14},
    {'1': 'PARTICIPANT_TO_ASSET_RELATION_ENUM__VALUATOR', '2': 15},
    {'1': 'PARTICIPANT_TO_ASSET_RELATION_ENUM__ADMINISTRATOR', '2': 16},
    {'1': 'PARTICIPANT_TO_ASSET_RELATION_ENUM__MARKET_MAKER', '2': 21},
    {'1': 'PARTICIPANT_TO_ASSET_RELATION_ENUM__LIQUIDITY_PROVIDER', '2': 22},
    {'1': 'PARTICIPANT_TO_ASSET_RELATION_ENUM__ORACLE', '2': 23},
    {'1': 'PARTICIPANT_TO_ASSET_RELATION_ENUM__MINER_VALIDATOR', '2': 24},
    {'1': 'PARTICIPANT_TO_ASSET_RELATION_ENUM__SERVICE_PROVIDER', '2': 25},
    {'1': 'PARTICIPANT_TO_ASSET_RELATION_ENUM__OTHER', '2': 1000},
  ],
};

/// Descriptor for `ParticipantToAssetRelationEnum`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List participantToAssetRelationEnumDescriptor = $convert.base64Decode(
    'Ch5QYXJ0aWNpcGFudFRvQXNzZXRSZWxhdGlvbkVudW0SLworUEFSVElDSVBBTlRfVE9fQVNTRV'
    'RfUkVMQVRJT05fRU5VTV9fVU5LTk9XThAAEi4KKlBBUlRJQ0lQQU5UX1RPX0FTU0VUX1JFTEFU'
    'SU9OX0VOVU1fX0lTU1VFUhABEi0KKVBBUlRJQ0lQQU5UX1RPX0FTU0VUX1JFTEFUSU9OX0VOVU'
    '1fX09XTkVSEAISLworUEFSVElDSVBBTlRfVE9fQVNTRVRfUkVMQVRJT05fRU5VTV9fU1BPTlNP'
    'UhADEjEKLVBBUlRJQ0lQQU5UX1RPX0FTU0VUX1JFTEFUSU9OX0VOVU1fX1JFR1VMQVRPUhAEEj'
    'IKLlBBUlRJQ0lQQU5UX1RPX0FTU0VUX1JFTEFUSU9OX0VOVU1fX1NVUEVSVklTT1IQBRIwCixQ'
    'QVJUSUNJUEFOVF9UT19BU1NFVF9SRUxBVElPTl9FTlVNX19HT1ZFUk5PUhAGEjEKLVBBUlRJQ0'
    'lQQU5UX1RPX0FTU0VUX1JFTEFUSU9OX0VOVU1fX0NVU1RPRElBThAHEi4KKlBBUlRJQ0lQQU5U'
    'X1RPX0FTU0VUX1JFTEFUSU9OX0VOVU1fX0JST0tFUhAIEi4KKlBBUlRJQ0lQQU5UX1RPX0FTU0'
    'VUX1JFTEFUSU9OX0VOVU1fX0RFQUxFUhAJEi4KKlBBUlRJQ0lQQU5UX1RPX0FTU0VUX1JFTEFU'
    'SU9OX0VOVU1fX01BUktFVBAKEi0KKVBBUlRJQ0lQQU5UX1RPX0FTU0VUX1JFTEFUSU9OX0VOVU'
    '1fX1ZFTlVFEAsSLworUEFSVElDSVBBTlRfVE9fQVNTRVRfUkVMQVRJT05fRU5VTV9fQVVESVRP'
    'UhAMEi0KKVBBUlRJQ0lQQU5UX1RPX0FTU0VUX1JFTEFUSU9OX0VOVU1fX0FHRU5UEA0SLworUE'
    'FSVElDSVBBTlRfVE9fQVNTRVRfUkVMQVRJT05fRU5VTV9fQURWSVNPUhAOEjAKLFBBUlRJQ0lQ'
    'QU5UX1RPX0FTU0VUX1JFTEFUSU9OX0VOVU1fX1ZBTFVBVE9SEA8SNQoxUEFSVElDSVBBTlRfVE'
    '9fQVNTRVRfUkVMQVRJT05fRU5VTV9fQURNSU5JU1RSQVRPUhAQEjQKMFBBUlRJQ0lQQU5UX1RP'
    'X0FTU0VUX1JFTEFUSU9OX0VOVU1fX01BUktFVF9NQUtFUhAVEjoKNlBBUlRJQ0lQQU5UX1RPX0'
    'FTU0VUX1JFTEFUSU9OX0VOVU1fX0xJUVVJRElUWV9QUk9WSURFUhAWEi4KKlBBUlRJQ0lQQU5U'
    'X1RPX0FTU0VUX1JFTEFUSU9OX0VOVU1fX09SQUNMRRAXEjcKM1BBUlRJQ0lQQU5UX1RPX0FTU0'
    'VUX1JFTEFUSU9OX0VOVU1fX01JTkVSX1ZBTElEQVRPUhAYEjgKNFBBUlRJQ0lQQU5UX1RPX0FT'
    'U0VUX1JFTEFUSU9OX0VOVU1fX1NFUlZJQ0VfUFJPVklERVIQGRIuCilQQVJUSUNJUEFOVF9UT1'
    '9BU1NFVF9SRUxBVElPTl9FTlVNX19PVEhFUhDoBw==');

@$core.Deprecated('Use instrumentClassEnumDescriptor instead')
const InstrumentClassEnum$json = {
  '1': 'InstrumentClassEnum',
  '2': [
    {'1': 'INSTRUMENT_CLASS_ENUM__UNKNOWN', '2': 0},
    {'1': 'INSTRUMENT_CLASS_ENUM__EQUITY_SHARE', '2': 1},
    {'1': 'INSTRUMENT_CLASS_ENUM__TOKENIZED_SECURITY', '2': 2},
    {'1': 'INSTRUMENT_CLASS_ENUM__FUND_UNIT', '2': 3},
    {'1': 'INSTRUMENT_CLASS_ENUM__ETF_SHARE', '2': 4},
    {'1': 'INSTRUMENT_CLASS_ENUM__BOND', '2': 5},
    {'1': 'INSTRUMENT_CLASS_ENUM__EQUITY_DERIVATIVE', '2': 6},
    {'1': 'INSTRUMENT_CLASS_ENUM__INDEX_DERIVATIVE', '2': 7},
    {'1': 'INSTRUMENT_CLASS_ENUM__FX', '2': 8},
    {'1': 'INSTRUMENT_CLASS_ENUM__WARRANT', '2': 9},
    {'1': 'INSTRUMENT_CLASS_ENUM__CFD', '2': 10},
    {'1': 'INSTRUMENT_CLASS_ENUM__OPTION', '2': 11},
    {'1': 'INSTRUMENT_CLASS_ENUM__FUTURE', '2': 12},
    {'1': 'INSTRUMENT_CLASS_ENUM__OTHER', '2': 1000},
  ],
};

/// Descriptor for `InstrumentClassEnum`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List instrumentClassEnumDescriptor = $convert.base64Decode(
    'ChNJbnN0cnVtZW50Q2xhc3NFbnVtEiIKHklOU1RSVU1FTlRfQ0xBU1NfRU5VTV9fVU5LTk9XTh'
    'AAEicKI0lOU1RSVU1FTlRfQ0xBU1NfRU5VTV9fRVFVSVRZX1NIQVJFEAESLQopSU5TVFJVTUVO'
    'VF9DTEFTU19FTlVNX19UT0tFTklaRURfU0VDVVJJVFkQAhIkCiBJTlNUUlVNRU5UX0NMQVNTX0'
    'VOVU1fX0ZVTkRfVU5JVBADEiQKIElOU1RSVU1FTlRfQ0xBU1NfRU5VTV9fRVRGX1NIQVJFEAQS'
    'HwobSU5TVFJVTUVOVF9DTEFTU19FTlVNX19CT05EEAUSLAooSU5TVFJVTUVOVF9DTEFTU19FTl'
    'VNX19FUVVJVFlfREVSSVZBVElWRRAGEisKJ0lOU1RSVU1FTlRfQ0xBU1NfRU5VTV9fSU5ERVhf'
    'REVSSVZBVElWRRAHEh0KGUlOU1RSVU1FTlRfQ0xBU1NfRU5VTV9fRlgQCBIiCh5JTlNUUlVNRU'
    '5UX0NMQVNTX0VOVU1fX1dBUlJBTlQQCRIeChpJTlNUUlVNRU5UX0NMQVNTX0VOVU1fX0NGRBAK'
    'EiEKHUlOU1RSVU1FTlRfQ0xBU1NfRU5VTV9fT1BUSU9OEAsSIQodSU5TVFJVTUVOVF9DTEFTU1'
    '9FTlVNX19GVVRVUkUQDBIhChxJTlNUUlVNRU5UX0NMQVNTX0VOVU1fX09USEVSEOgH');

@$core.Deprecated('Use participantToInstrumentRelationEnumDescriptor instead')
const ParticipantToInstrumentRelationEnum$json = {
  '1': 'ParticipantToInstrumentRelationEnum',
  '2': [
    {'1': 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__UNKNOWN', '2': 0},
    {'1': 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__ISSUER', '2': 1},
    {'1': 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__OWNER', '2': 2},
    {'1': 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__SPONSOR', '2': 3},
    {'1': 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__REGULATOR', '2': 4},
    {'1': 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__SUPERVISOR', '2': 5},
    {'1': 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__GOVERNOR', '2': 6},
    {'1': 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__CUSTODIAN', '2': 7},
    {'1': 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__BROKER', '2': 8},
    {'1': 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__DEALER', '2': 9},
    {'1': 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__MARKET', '2': 10},
    {'1': 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__VENUE', '2': 11},
    {'1': 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__AUDITOR', '2': 12},
    {'1': 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__AGENT', '2': 13},
    {'1': 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__ADVISOR', '2': 14},
    {'1': 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__ADMINISTRATOR', '2': 16},
    {'1': 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__MARKET_MAKER', '2': 21},
    {
      '1': 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__LIQUIDITY_PROVIDER',
      '2': 22
    },
    {'1': 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__ORACLE', '2': 23},
    {'1': 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__MINER_VALIDATOR', '2': 24},
    {'1': 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__SERVICE_PROVIDER', '2': 25},
    {'1': 'PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__OTHER', '2': 1000},
  ],
};

/// Descriptor for `ParticipantToInstrumentRelationEnum`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List participantToInstrumentRelationEnumDescriptor = $convert.base64Decode(
    'CiNQYXJ0aWNpcGFudFRvSW5zdHJ1bWVudFJlbGF0aW9uRW51bRI0CjBQQVJUSUNJUEFOVF9UT1'
    '9JTlNUUlVNRU5UX1JFTEFUSU9OX0VOVU1fX1VOS05PV04QABIzCi9QQVJUSUNJUEFOVF9UT19J'
    'TlNUUlVNRU5UX1JFTEFUSU9OX0VOVU1fX0lTU1VFUhABEjIKLlBBUlRJQ0lQQU5UX1RPX0lOU1'
    'RSVU1FTlRfUkVMQVRJT05fRU5VTV9fT1dORVIQAhI0CjBQQVJUSUNJUEFOVF9UT19JTlNUUlVN'
    'RU5UX1JFTEFUSU9OX0VOVU1fX1NQT05TT1IQAxI2CjJQQVJUSUNJUEFOVF9UT19JTlNUUlVNRU'
    '5UX1JFTEFUSU9OX0VOVU1fX1JFR1VMQVRPUhAEEjcKM1BBUlRJQ0lQQU5UX1RPX0lOU1RSVU1F'
    'TlRfUkVMQVRJT05fRU5VTV9fU1VQRVJWSVNPUhAFEjUKMVBBUlRJQ0lQQU5UX1RPX0lOU1RSVU'
    '1FTlRfUkVMQVRJT05fRU5VTV9fR09WRVJOT1IQBhI2CjJQQVJUSUNJUEFOVF9UT19JTlNUUlVN'
    'RU5UX1JFTEFUSU9OX0VOVU1fX0NVU1RPRElBThAHEjMKL1BBUlRJQ0lQQU5UX1RPX0lOU1RSVU'
    '1FTlRfUkVMQVRJT05fRU5VTV9fQlJPS0VSEAgSMwovUEFSVElDSVBBTlRfVE9fSU5TVFJVTUVO'
    'VF9SRUxBVElPTl9FTlVNX19ERUFMRVIQCRIzCi9QQVJUSUNJUEFOVF9UT19JTlNUUlVNRU5UX1'
    'JFTEFUSU9OX0VOVU1fX01BUktFVBAKEjIKLlBBUlRJQ0lQQU5UX1RPX0lOU1RSVU1FTlRfUkVM'
    'QVRJT05fRU5VTV9fVkVOVUUQCxI0CjBQQVJUSUNJUEFOVF9UT19JTlNUUlVNRU5UX1JFTEFUSU'
    '9OX0VOVU1fX0FVRElUT1IQDBIyCi5QQVJUSUNJUEFOVF9UT19JTlNUUlVNRU5UX1JFTEFUSU9O'
    'X0VOVU1fX0FHRU5UEA0SNAowUEFSVElDSVBBTlRfVE9fSU5TVFJVTUVOVF9SRUxBVElPTl9FTl'
    'VNX19BRFZJU09SEA4SOgo2UEFSVElDSVBBTlRfVE9fSU5TVFJVTUVOVF9SRUxBVElPTl9FTlVN'
    'X19BRE1JTklTVFJBVE9SEBASOQo1UEFSVElDSVBBTlRfVE9fSU5TVFJVTUVOVF9SRUxBVElPTl'
    '9FTlVNX19NQVJLRVRfTUFLRVIQFRI/CjtQQVJUSUNJUEFOVF9UT19JTlNUUlVNRU5UX1JFTEFU'
    'SU9OX0VOVU1fX0xJUVVJRElUWV9QUk9WSURFUhAWEjMKL1BBUlRJQ0lQQU5UX1RPX0lOU1RSVU'
    '1FTlRfUkVMQVRJT05fRU5VTV9fT1JBQ0xFEBcSPAo4UEFSVElDSVBBTlRfVE9fSU5TVFJVTUVO'
    'VF9SRUxBVElPTl9FTlVNX19NSU5FUl9WQUxJREFUT1IQGBI9CjlQQVJUSUNJUEFOVF9UT19JTl'
    'NUUlVNRU5UX1JFTEFUSU9OX0VOVU1fX1NFUlZJQ0VfUFJPVklERVIQGRIzCi5QQVJUSUNJUEFO'
    'VF9UT19JTlNUUlVNRU5UX1JFTEFUSU9OX0VOVU1fX09USEVSEOgH');

@$core.Deprecated('Use marketStatusDescriptor instead')
const MarketStatus$json = {
  '1': 'MarketStatus',
  '2': [
    {'1': 'MARKET_STATUS__UNKNOWN', '2': 0},
    {'1': 'MARKET_STATUS__OPENING_AUCTION', '2': 1},
    {'1': 'MARKET_STATUS__PRE_OPEN', '2': 2},
    {'1': 'MARKET_STATUS__OPEN', '2': 3},
    {'1': 'MARKET_STATUS__PARTIALLY_OPEN', '2': 4},
    {'1': 'MARKET_STATUS__REPORTING', '2': 5},
    {'1': 'MARKET_STATUS__CLOSING_AUCTION', '2': 6},
    {'1': 'MARKET_STATUS__CLOSED', '2': 7},
    {'1': 'MARKET_STATUS__CLOSED_ON_PUBLIC_HOLIDAY', '2': 8},
    {'1': 'MARKET_STATUS__SUSPENDED', '2': 9},
    {'1': 'MARKET_STATUS__MAINTENANCE', '2': 10},
    {'1': 'MARKET_STATUS__UNAVAILABLE', '2': 100},
  ],
};

/// Descriptor for `MarketStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List marketStatusDescriptor = $convert.base64Decode(
    'CgxNYXJrZXRTdGF0dXMSGgoWTUFSS0VUX1NUQVRVU19fVU5LTk9XThAAEiIKHk1BUktFVF9TVE'
    'FUVVNfX09QRU5JTkdfQVVDVElPThABEhsKF01BUktFVF9TVEFUVVNfX1BSRV9PUEVOEAISFwoT'
    'TUFSS0VUX1NUQVRVU19fT1BFThADEiEKHU1BUktFVF9TVEFUVVNfX1BBUlRJQUxMWV9PUEVOEA'
    'QSHAoYTUFSS0VUX1NUQVRVU19fUkVQT1JUSU5HEAUSIgoeTUFSS0VUX1NUQVRVU19fQ0xPU0lO'
    'R19BVUNUSU9OEAYSGQoVTUFSS0VUX1NUQVRVU19fQ0xPU0VEEAcSKwonTUFSS0VUX1NUQVRVU1'
    '9fQ0xPU0VEX09OX1BVQkxJQ19IT0xJREFZEAgSHAoYTUFSS0VUX1NUQVRVU19fU1VTUEVOREVE'
    'EAkSHgoaTUFSS0VUX1NUQVRVU19fTUFJTlRFTkFOQ0UQChIeChpNQVJLRVRfU1RBVFVTX19VTk'
    'FWQUlMQUJMRRBk');

@$core.Deprecated('Use venueTypeEnumDescriptor instead')
const VenueTypeEnum$json = {
  '1': 'VenueTypeEnum',
  '2': [
    {'1': 'VENUE_TYPE_ENUM__UNKNOWN', '2': 0},
    {'1': 'VENUE_TYPE_ENUM__EXCHANGE', '2': 1},
    {'1': 'VENUE_TYPE_ENUM__OTHER', '2': 1000},
  ],
};

/// Descriptor for `VenueTypeEnum`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List venueTypeEnumDescriptor = $convert.base64Decode(
    'Cg1WZW51ZVR5cGVFbnVtEhwKGFZFTlVFX1RZUEVfRU5VTV9fVU5LTk9XThAAEh0KGVZFTlVFX1'
    'RZUEVfRU5VTV9fRVhDSEFOR0UQARIbChZWRU5VRV9UWVBFX0VOVU1fX09USEVSEOgH');

@$core.Deprecated('Use venueStatusDescriptor instead')
const VenueStatus$json = {
  '1': 'VenueStatus',
  '2': [
    {'1': 'VENUE_STATUS__UNKNOWN', '2': 0},
    {'1': 'VENUE_STATUS__OPENING_AUCTION', '2': 1},
    {'1': 'VENUE_STATUS__PRE_OPEN', '2': 2},
    {'1': 'VENUE_STATUS__OPEN', '2': 3},
    {'1': 'VENUE_STATUS__PARTIALLY_OPEN', '2': 4},
    {'1': 'VENUE_STATUS__REPORTING', '2': 5},
    {'1': 'VENUE_STATUS__CLOSING_AUCTION', '2': 6},
    {'1': 'VENUE_STATUS__CLOSED', '2': 7},
    {'1': 'VENUE_STATUS__CLOSED_ON_PUBLIC_HOLIDAY', '2': 8},
    {'1': 'VENUE_STATUS__SUSPENDED', '2': 9},
    {'1': 'VENUE_STATUS__MAINTENANCE', '2': 10},
    {'1': 'VENUE_STATUS__UNAVAILABLE', '2': 100},
  ],
};

/// Descriptor for `VenueStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List venueStatusDescriptor = $convert.base64Decode(
    'CgtWZW51ZVN0YXR1cxIZChVWRU5VRV9TVEFUVVNfX1VOS05PV04QABIhCh1WRU5VRV9TVEFUVV'
    'NfX09QRU5JTkdfQVVDVElPThABEhoKFlZFTlVFX1NUQVRVU19fUFJFX09QRU4QAhIWChJWRU5V'
    'RV9TVEFUVVNfX09QRU4QAxIgChxWRU5VRV9TVEFUVVNfX1BBUlRJQUxMWV9PUEVOEAQSGwoXVk'
    'VOVUVfU1RBVFVTX19SRVBPUlRJTkcQBRIhCh1WRU5VRV9TVEFUVVNfX0NMT1NJTkdfQVVDVElP'
    'ThAGEhgKFFZFTlVFX1NUQVRVU19fQ0xPU0VEEAcSKgomVkVOVUVfU1RBVFVTX19DTE9TRURfT0'
    '5fUFVCTElDX0hPTElEQVkQCBIbChdWRU5VRV9TVEFUVVNfX1NVU1BFTkRFRBAJEh0KGVZFTlVF'
    'X1NUQVRVU19fTUFJTlRFTkFOQ0UQChIdChlWRU5VRV9TVEFUVVNfX1VOQVZBSUxBQkxFEGQ=');

@$core.Deprecated('Use instrumentListingStatusEnumDescriptor instead')
const InstrumentListingStatusEnum$json = {
  '1': 'InstrumentListingStatusEnum',
  '2': [
    {'1': 'INSTRUMENT_LISTING_STATUS_ENUM__UNKNOWN', '2': 0},
    {'1': 'INSTRUMENT_LISTING_STATUS_ENUM__WHEN_ISSUED', '2': 1},
    {'1': 'INSTRUMENT_LISTING_STATUS_ENUM__PRE_LISTING', '2': 2},
    {'1': 'INSTRUMENT_LISTING_STATUS_ENUM__LISTED', '2': 3},
    {'1': 'INSTRUMENT_LISTING_STATUS_ENUM__SUSPENDED', '2': 4},
    {'1': 'INSTRUMENT_LISTING_STATUS_ENUM__HALTED', '2': 5},
    {'1': 'INSTRUMENT_LISTING_STATUS_ENUM__MATURED', '2': 6},
    {'1': 'INSTRUMENT_LISTING_STATUS_ENUM__EXPIRED', '2': 7},
    {'1': 'INSTRUMENT_LISTING_STATUS_ENUM__MERGED', '2': 8},
    {'1': 'INSTRUMENT_LISTING_STATUS_ENUM__DELISTED', '2': 9},
    {'1': 'INSTRUMENT_LISTING_STATUS_ENUM__LIQUIDATED', '2': 10},
    {'1': 'INSTRUMENT_LISTING_STATUS_ENUM__TEST', '2': 11},
    {'1': 'INSTRUMENT_LISTING_STATUS_ENUM__OTHER', '2': 1000},
  ],
};

/// Descriptor for `InstrumentListingStatusEnum`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List instrumentListingStatusEnumDescriptor = $convert.base64Decode(
    'ChtJbnN0cnVtZW50TGlzdGluZ1N0YXR1c0VudW0SKwonSU5TVFJVTUVOVF9MSVNUSU5HX1NUQV'
    'RVU19FTlVNX19VTktOT1dOEAASLworSU5TVFJVTUVOVF9MSVNUSU5HX1NUQVRVU19FTlVNX19X'
    'SEVOX0lTU1VFRBABEi8KK0lOU1RSVU1FTlRfTElTVElOR19TVEFUVVNfRU5VTV9fUFJFX0xJU1'
    'RJTkcQAhIqCiZJTlNUUlVNRU5UX0xJU1RJTkdfU1RBVFVTX0VOVU1fX0xJU1RFRBADEi0KKUlO'
    'U1RSVU1FTlRfTElTVElOR19TVEFUVVNfRU5VTV9fU1VTUEVOREVEEAQSKgomSU5TVFJVTUVOVF'
    '9MSVNUSU5HX1NUQVRVU19FTlVNX19IQUxURUQQBRIrCidJTlNUUlVNRU5UX0xJU1RJTkdfU1RB'
    'VFVTX0VOVU1fX01BVFVSRUQQBhIrCidJTlNUUlVNRU5UX0xJU1RJTkdfU1RBVFVTX0VOVU1fX0'
    'VYUElSRUQQBxIqCiZJTlNUUlVNRU5UX0xJU1RJTkdfU1RBVFVTX0VOVU1fX01FUkdFRBAIEiwK'
    'KElOU1RSVU1FTlRfTElTVElOR19TVEFUVVNfRU5VTV9fREVMSVNURUQQCRIuCipJTlNUUlVNRU'
    '5UX0xJU1RJTkdfU1RBVFVTX0VOVU1fX0xJUVVJREFURUQQChIoCiRJTlNUUlVNRU5UX0xJU1RJ'
    'TkdfU1RBVFVTX0VOVU1fX1RFU1QQCxIqCiVJTlNUUlVNRU5UX0xJU1RJTkdfU1RBVFVTX0VOVU'
    '1fX09USEVSEOgH');

@$core.Deprecated('Use confirmationStatusDescriptor instead')
const ConfirmationStatus$json = {
  '1': 'ConfirmationStatus',
  '2': [
    {'1': 'CONFIRMATION_STATUS__UNKNOWN', '2': 0},
    {'1': 'CONFIRMATION_STATUS__CONFIRMED', '2': 1},
    {'1': 'CONFIRMATION_STATUS__PENDING', '2': 2},
    {'1': 'CONFIRMATION_STATUS__DECLINED', '2': 3},
  ],
};

/// Descriptor for `ConfirmationStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List confirmationStatusDescriptor = $convert.base64Decode(
    'ChJDb25maXJtYXRpb25TdGF0dXMSIAocQ09ORklSTUFUSU9OX1NUQVRVU19fVU5LTk9XThAAEi'
    'IKHkNPTkZJUk1BVElPTl9TVEFUVVNfX0NPTkZJUk1FRBABEiAKHENPTkZJUk1BVElPTl9TVEFU'
    'VVNfX1BFTkRJTkcQAhIhCh1DT05GSVJNQVRJT05fU1RBVFVTX19ERUNMSU5FRBAD');

@$core.Deprecated('Use orderSideDescriptor instead')
const OrderSide$json = {
  '1': 'OrderSide',
  '2': [
    {'1': 'ORDER_SIDE__UNKNOWN', '2': 0},
    {'1': 'ORDER_SIDE__BUY', '2': 1},
    {'1': 'ORDER_SIDE__BID', '2': 1},
    {'1': 'ORDER_SIDE__CALL', '2': 1},
    {'1': 'ORDER_SIDE__SELL', '2': 2},
    {'1': 'ORDER_SIDE__ASK', '2': 2},
    {'1': 'ORDER_SIDE__PUT', '2': 2},
    {'1': 'ORDER_SIDE__BOTH', '2': 3},
    {'1': 'ORDER_SIDE__NO_SIDE', '2': 4},
  ],
  '3': {'2': true},
};

/// Descriptor for `OrderSide`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List orderSideDescriptor = $convert.base64Decode(
    'CglPcmRlclNpZGUSFwoTT1JERVJfU0lERV9fVU5LTk9XThAAEhMKD09SREVSX1NJREVfX0JVWR'
    'ABEhMKD09SREVSX1NJREVfX0JJRBABEhQKEE9SREVSX1NJREVfX0NBTEwQARIUChBPUkRFUl9T'
    'SURFX19TRUxMEAISEwoPT1JERVJfU0lERV9fQVNLEAISEwoPT1JERVJfU0lERV9fUFVUEAISFA'
    'oQT1JERVJfU0lERV9fQk9USBADEhcKE09SREVSX1NJREVfX05PX1NJREUQBBoCEAE=');

@$core.Deprecated('Use transactionTypeEnumDescriptor instead')
const TransactionTypeEnum$json = {
  '1': 'TransactionTypeEnum',
  '2': [
    {'1': 'TRANSACTION_TYPE_ENUM__UNKNOWN', '2': 0},
    {'1': 'TRANSACTION_TYPE_ENUM__DEPOSIT_CASH', '2': 1},
    {'1': 'TRANSACTION_TYPE_ENUM__DEPOSIT_ASSET', '2': 2},
    {'1': 'TRANSACTION_TYPE_ENUM__WITHDRAW_CASH', '2': 3},
    {'1': 'TRANSACTION_TYPE_ENUM__WITHDRAW_ASSET', '2': 4},
    {'1': 'TRANSACTION_TYPE_ENUM__TRADE_BUY', '2': 5},
    {'1': 'TRANSACTION_TYPE_ENUM__TRADE_SELL', '2': 6},
    {'1': 'TRANSACTION_TYPE_ENUM__FEE', '2': 7},
    {'1': 'TRANSACTION_TYPE_ENUM__SETTLEMENT', '2': 8},
    {'1': 'TRANSACTION_TYPE_ENUM__TRANSFER_IN', '2': 9},
    {'1': 'TRANSACTION_TYPE_ENUM__TRANSFER_OUT', '2': 10},
    {'1': 'TRANSACTION_TYPE_ENUM__OTHER', '2': 1000},
  ],
};

/// Descriptor for `TransactionTypeEnum`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List transactionTypeEnumDescriptor = $convert.base64Decode(
    'ChNUcmFuc2FjdGlvblR5cGVFbnVtEiIKHlRSQU5TQUNUSU9OX1RZUEVfRU5VTV9fVU5LTk9XTh'
    'AAEicKI1RSQU5TQUNUSU9OX1RZUEVfRU5VTV9fREVQT1NJVF9DQVNIEAESKAokVFJBTlNBQ1RJ'
    'T05fVFlQRV9FTlVNX19ERVBPU0lUX0FTU0VUEAISKAokVFJBTlNBQ1RJT05fVFlQRV9FTlVNX1'
    '9XSVRIRFJBV19DQVNIEAMSKQolVFJBTlNBQ1RJT05fVFlQRV9FTlVNX19XSVRIRFJBV19BU1NF'
    'VBAEEiQKIFRSQU5TQUNUSU9OX1RZUEVfRU5VTV9fVFJBREVfQlVZEAUSJQohVFJBTlNBQ1RJT0'
    '5fVFlQRV9FTlVNX19UUkFERV9TRUxMEAYSHgoaVFJBTlNBQ1RJT05fVFlQRV9FTlVNX19GRUUQ'
    'BxIlCiFUUkFOU0FDVElPTl9UWVBFX0VOVU1fX1NFVFRMRU1FTlQQCBImCiJUUkFOU0FDVElPTl'
    '9UWVBFX0VOVU1fX1RSQU5TRkVSX0lOEAkSJwojVFJBTlNBQ1RJT05fVFlQRV9FTlVNX19UUkFO'
    'U0ZFUl9PVVQQChIhChxUUkFOU0FDVElPTl9UWVBFX0VOVU1fX09USEVSEOgH');

@$core.Deprecated('Use accountDescriptor instead')
const Account$json = {
  '1': 'Account',
  '2': [
    {'1': 'iid', '3': 1, '4': 1, '5': 9, '10': 'iid'},
    {
      '1': 'identifiers',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.FinIdentifier',
      '10': 'identifiers'
    },
    {
      '1': 'external_account_id',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'externalAccountId'
    },
    {
      '1': 'account_type',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.AccountTypeEnum',
      '10': 'accountType'
    },
    {
      '1': 'account_status',
      '3': 8,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.AccountStatusEnum',
      '10': 'accountStatus'
    },
    {
      '1': 'display_names',
      '3': 101,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Account.DisplayNamesEntry',
      '10': 'displayNames'
    },
    {
      '1': 'descriptions',
      '3': 102,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Account.DescriptionsEntry',
      '10': 'descriptions'
    },
    {
      '1': 'labels',
      '3': 103,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Account.LabelsEntry',
      '10': 'labels'
    },
    {'1': 'tags', '3': 104, '4': 3, '5': 9, '10': 'tags'},
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Account.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [
    Account_DisplayNamesEntry$json,
    Account_DescriptionsEntry$json,
    Account_LabelsEntry$json,
    Account_MetadataEntry$json
  ],
};

@$core.Deprecated('Use accountDescriptor instead')
const Account_DisplayNamesEntry$json = {
  '1': 'DisplayNamesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use accountDescriptor instead')
const Account_DescriptionsEntry$json = {
  '1': 'DescriptionsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use accountDescriptor instead')
const Account_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use accountDescriptor instead')
const Account_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Account`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountDescriptor = $convert.base64Decode(
    'CgdBY2NvdW50EhAKA2lpZBgBIAEoCVIDaWlkElAKC2lkZW50aWZpZXJzGAIgAygLMi4ucW9tZX'
    'QuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5GaW5JZGVudGlmaWVyUgtpZGVudGlmaWVycxIu'
    'ChNleHRlcm5hbF9hY2NvdW50X2lkGAMgASgJUhFleHRlcm5hbEFjY291bnRJZBJTCgxhY2NvdW'
    '50X3R5cGUYBCABKA4yMC5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkFjY291bnRU'
    'eXBlRW51bVILYWNjb3VudFR5cGUSWQoOYWNjb3VudF9zdGF0dXMYCCABKA4yMi5xb21ldC5hZ2'
    '9yYS5kYWVtb25zLnBydGFnZW50LnYxLkFjY291bnRTdGF0dXNFbnVtUg1hY2NvdW50U3RhdHVz'
    'El8KDWRpc3BsYXlfbmFtZXMYZSADKAsyOi5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50Ln'
    'YxLkFjY291bnQuRGlzcGxheU5hbWVzRW50cnlSDGRpc3BsYXlOYW1lcxJeCgxkZXNjcmlwdGlv'
    'bnMYZiADKAsyOi5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkFjY291bnQuRGVzY3'
    'JpcHRpb25zRW50cnlSDGRlc2NyaXB0aW9ucxJMCgZsYWJlbHMYZyADKAsyNC5xb21ldC5hZ29y'
    'YS5kYWVtb25zLnBydGFnZW50LnYxLkFjY291bnQuTGFiZWxzRW50cnlSBmxhYmVscxISCgR0YW'
    'dzGGggAygJUgR0YWdzElIKCG1ldGFkYXRhGGkgAygLMjYucW9tZXQuYWdvcmEuZGFlbW9ucy5w'
    'cnRhZ2VudC52MS5BY2NvdW50Lk1ldGFkYXRhRW50cnlSCG1ldGFkYXRhGj8KEURpc3BsYXlOYW'
    '1lc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAEaPwoR'
    'RGVzY3JpcHRpb25zRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbH'
    'VlOgI4ARo5CgtMYWJlbHNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIF'
    'dmFsdWU6AjgBGjsKDU1ldGFkYXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAi'
    'ABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use accountToAccountRelationDescriptor instead')
const AccountToAccountRelation$json = {
  '1': 'AccountToAccountRelation',
  '2': [
    {'1': 'iid', '3': 1, '4': 1, '5': 9, '10': 'iid'},
    {'1': 'from_account_iid', '3': 2, '4': 1, '5': 9, '10': 'fromAccountIid'},
    {'1': 'to_account_iid', '3': 3, '4': 1, '5': 9, '10': 'toAccountIid'},
    {
      '1': 'relation_type',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.AccountToAccountRelationTypeEnum',
      '10': 'relationType'
    },
    {
      '1': 'effective_from_dt',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'effectiveFromDt'
    },
    {
      '1': 'effective_to_dt',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'effectiveToDt'
    },
    {
      '1': 'display_names',
      '3': 101,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.AccountToAccountRelation.DisplayNamesEntry',
      '10': 'displayNames'
    },
    {
      '1': 'descriptions',
      '3': 102,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.AccountToAccountRelation.DescriptionsEntry',
      '10': 'descriptions'
    },
    {
      '1': 'labels',
      '3': 103,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.AccountToAccountRelation.LabelsEntry',
      '10': 'labels'
    },
    {'1': 'tags', '3': 104, '4': 3, '5': 9, '10': 'tags'},
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.AccountToAccountRelation.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [
    AccountToAccountRelation_DisplayNamesEntry$json,
    AccountToAccountRelation_DescriptionsEntry$json,
    AccountToAccountRelation_LabelsEntry$json,
    AccountToAccountRelation_MetadataEntry$json
  ],
};

@$core.Deprecated('Use accountToAccountRelationDescriptor instead')
const AccountToAccountRelation_DisplayNamesEntry$json = {
  '1': 'DisplayNamesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use accountToAccountRelationDescriptor instead')
const AccountToAccountRelation_DescriptionsEntry$json = {
  '1': 'DescriptionsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use accountToAccountRelationDescriptor instead')
const AccountToAccountRelation_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use accountToAccountRelationDescriptor instead')
const AccountToAccountRelation_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `AccountToAccountRelation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountToAccountRelationDescriptor = $convert.base64Decode(
    'ChhBY2NvdW50VG9BY2NvdW50UmVsYXRpb24SEAoDaWlkGAEgASgJUgNpaWQSKAoQZnJvbV9hY2'
    'NvdW50X2lpZBgCIAEoCVIOZnJvbUFjY291bnRJaWQSJAoOdG9fYWNjb3VudF9paWQYAyABKAlS'
    'DHRvQWNjb3VudElpZBJmCg1yZWxhdGlvbl90eXBlGAQgASgOMkEucW9tZXQuYWdvcmEuZGFlbW'
    '9ucy5wcnRhZ2VudC52MS5BY2NvdW50VG9BY2NvdW50UmVsYXRpb25UeXBlRW51bVIMcmVsYXRp'
    'b25UeXBlElUKEWVmZmVjdGl2ZV9mcm9tX2R0GAUgASgLMikucW9tZXQuYWdvcmEuZGFlbW9ucy'
    '5wcnRhZ2VudC52MS5EYXRlVGltZVIPZWZmZWN0aXZlRnJvbUR0ElEKD2VmZmVjdGl2ZV90b19k'
    'dBgGIAEoCzIpLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuRGF0ZVRpbWVSDWVmZm'
    'VjdGl2ZVRvRHQScAoNZGlzcGxheV9uYW1lcxhlIAMoCzJLLnFvbWV0LmFnb3JhLmRhZW1vbnMu'
    'cHJ0YWdlbnQudjEuQWNjb3VudFRvQWNjb3VudFJlbGF0aW9uLkRpc3BsYXlOYW1lc0VudHJ5Ug'
    'xkaXNwbGF5TmFtZXMSbwoMZGVzY3JpcHRpb25zGGYgAygLMksucW9tZXQuYWdvcmEuZGFlbW9u'
    'cy5wcnRhZ2VudC52MS5BY2NvdW50VG9BY2NvdW50UmVsYXRpb24uRGVzY3JpcHRpb25zRW50cn'
    'lSDGRlc2NyaXB0aW9ucxJdCgZsYWJlbHMYZyADKAsyRS5xb21ldC5hZ29yYS5kYWVtb25zLnBy'
    'dGFnZW50LnYxLkFjY291bnRUb0FjY291bnRSZWxhdGlvbi5MYWJlbHNFbnRyeVIGbGFiZWxzEh'
    'IKBHRhZ3MYaCADKAlSBHRhZ3MSYwoIbWV0YWRhdGEYaSADKAsyRy5xb21ldC5hZ29yYS5kYWVt'
    'b25zLnBydGFnZW50LnYxLkFjY291bnRUb0FjY291bnRSZWxhdGlvbi5NZXRhZGF0YUVudHJ5Ug'
    'htZXRhZGF0YRo/ChFEaXNwbGF5TmFtZXNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1'
    'ZRgCIAEoCVIFdmFsdWU6AjgBGj8KEURlc2NyaXB0aW9uc0VudHJ5EhAKA2tleRgBIAEoCVIDa2'
    'V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAEaOQoLTGFiZWxzRW50cnkSEAoDa2V5GAEgASgJ'
    'UgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4ARo7Cg1NZXRhZGF0YUVudHJ5EhAKA2tleR'
    'gBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use finIdentifierDescriptor instead')
const FinIdentifier$json = {
  '1': 'FinIdentifier',
  '2': [
    {
      '1': 'fin_entity_type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.FinEntityTypeEnum',
      '10': 'finEntityType'
    },
    {'1': 'scheme', '3': 2, '4': 1, '5': 9, '10': 'scheme'},
    {
      '1': 'standard_or_format',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'standardOrFormat'
    },
    {
      '1': 'ids',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.StringValue',
      '10': 'ids'
    },
    {'1': 'is_primary', '3': 5, '4': 1, '5': 8, '10': 'isPrimary'},
    {
      '1': 'display_names',
      '3': 101,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.FinIdentifier.DisplayNamesEntry',
      '10': 'displayNames'
    },
    {
      '1': 'descriptions',
      '3': 102,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.FinIdentifier.DescriptionsEntry',
      '10': 'descriptions'
    },
    {
      '1': 'labels',
      '3': 103,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.FinIdentifier.LabelsEntry',
      '10': 'labels'
    },
    {'1': 'tags', '3': 104, '4': 3, '5': 9, '10': 'tags'},
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.FinIdentifier.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [
    FinIdentifier_DisplayNamesEntry$json,
    FinIdentifier_DescriptionsEntry$json,
    FinIdentifier_LabelsEntry$json,
    FinIdentifier_MetadataEntry$json
  ],
};

@$core.Deprecated('Use finIdentifierDescriptor instead')
const FinIdentifier_DisplayNamesEntry$json = {
  '1': 'DisplayNamesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use finIdentifierDescriptor instead')
const FinIdentifier_DescriptionsEntry$json = {
  '1': 'DescriptionsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use finIdentifierDescriptor instead')
const FinIdentifier_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use finIdentifierDescriptor instead')
const FinIdentifier_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `FinIdentifier`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List finIdentifierDescriptor = $convert.base64Decode(
    'Cg1GaW5JZGVudGlmaWVyEloKD2Zpbl9lbnRpdHlfdHlwZRgBIAEoDjIyLnFvbWV0LmFnb3JhLm'
    'RhZW1vbnMucHJ0YWdlbnQudjEuRmluRW50aXR5VHlwZUVudW1SDWZpbkVudGl0eVR5cGUSFgoG'
    'c2NoZW1lGAIgASgJUgZzY2hlbWUSLAoSc3RhbmRhcmRfb3JfZm9ybWF0GAMgASgJUhBzdGFuZG'
    'FyZE9yRm9ybWF0Ej4KA2lkcxgEIAMoCzIsLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQu'
    'djEuU3RyaW5nVmFsdWVSA2lkcxIdCgppc19wcmltYXJ5GAUgASgIUglpc1ByaW1hcnkSZQoNZG'
    'lzcGxheV9uYW1lcxhlIAMoCzJALnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuRmlu'
    'SWRlbnRpZmllci5EaXNwbGF5TmFtZXNFbnRyeVIMZGlzcGxheU5hbWVzEmQKDGRlc2NyaXB0aW'
    '9ucxhmIAMoCzJALnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuRmluSWRlbnRpZmll'
    'ci5EZXNjcmlwdGlvbnNFbnRyeVIMZGVzY3JpcHRpb25zElIKBmxhYmVscxhnIAMoCzI6LnFvbW'
    'V0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuRmluSWRlbnRpZmllci5MYWJlbHNFbnRyeVIG'
    'bGFiZWxzEhIKBHRhZ3MYaCADKAlSBHRhZ3MSWAoIbWV0YWRhdGEYaSADKAsyPC5xb21ldC5hZ2'
    '9yYS5kYWVtb25zLnBydGFnZW50LnYxLkZpbklkZW50aWZpZXIuTWV0YWRhdGFFbnRyeVIIbWV0'
    'YWRhdGEaPwoRRGlzcGxheU5hbWVzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAi'
    'ABKAlSBXZhbHVlOgI4ARo/ChFEZXNjcmlwdGlvbnNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIU'
    'CgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBGjkKC0xhYmVsc0VudHJ5EhAKA2tleRgBIAEoCVIDa2'
    'V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAEaOwoNTWV0YWRhdGFFbnRyeRIQCgNrZXkYASAB'
    'KAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use finAssetClassDescriptor instead')
const FinAssetClass$json = {
  '1': 'FinAssetClass',
  '2': [
    {'1': 'schema', '3': 1, '4': 1, '5': 9, '10': 'schema'},
    {
      '1': 'classes',
      '3': 2,
      '4': 3,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.AssetClassEnum',
      '10': 'classes'
    },
    {
      '1': 'display_names',
      '3': 101,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.FinAssetClass.DisplayNamesEntry',
      '10': 'displayNames'
    },
    {
      '1': 'descriptions',
      '3': 102,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.FinAssetClass.DescriptionsEntry',
      '10': 'descriptions'
    },
    {
      '1': 'labels',
      '3': 103,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.FinAssetClass.LabelsEntry',
      '10': 'labels'
    },
    {'1': 'tags', '3': 104, '4': 3, '5': 9, '10': 'tags'},
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.FinAssetClass.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [
    FinAssetClass_DisplayNamesEntry$json,
    FinAssetClass_DescriptionsEntry$json,
    FinAssetClass_LabelsEntry$json,
    FinAssetClass_MetadataEntry$json
  ],
};

@$core.Deprecated('Use finAssetClassDescriptor instead')
const FinAssetClass_DisplayNamesEntry$json = {
  '1': 'DisplayNamesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use finAssetClassDescriptor instead')
const FinAssetClass_DescriptionsEntry$json = {
  '1': 'DescriptionsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use finAssetClassDescriptor instead')
const FinAssetClass_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use finAssetClassDescriptor instead')
const FinAssetClass_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `FinAssetClass`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List finAssetClassDescriptor = $convert.base64Decode(
    'Cg1GaW5Bc3NldENsYXNzEhYKBnNjaGVtYRgBIAEoCVIGc2NoZW1hEkkKB2NsYXNzZXMYAiADKA'
    '4yLy5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkFzc2V0Q2xhc3NFbnVtUgdjbGFz'
    'c2VzEmUKDWRpc3BsYXlfbmFtZXMYZSADKAsyQC5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW'
    '50LnYxLkZpbkFzc2V0Q2xhc3MuRGlzcGxheU5hbWVzRW50cnlSDGRpc3BsYXlOYW1lcxJkCgxk'
    'ZXNjcmlwdGlvbnMYZiADKAsyQC5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkZpbk'
    'Fzc2V0Q2xhc3MuRGVzY3JpcHRpb25zRW50cnlSDGRlc2NyaXB0aW9ucxJSCgZsYWJlbHMYZyAD'
    'KAsyOi5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkZpbkFzc2V0Q2xhc3MuTGFiZW'
    'xzRW50cnlSBmxhYmVscxISCgR0YWdzGGggAygJUgR0YWdzElgKCG1ldGFkYXRhGGkgAygLMjwu'
    'cW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5GaW5Bc3NldENsYXNzLk1ldGFkYXRhRW'
    '50cnlSCG1ldGFkYXRhGj8KEURpc3BsYXlOYW1lc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQK'
    'BXZhbHVlGAIgASgJUgV2YWx1ZToCOAEaPwoRRGVzY3JpcHRpb25zRW50cnkSEAoDa2V5GAEgAS'
    'gJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4ARo5CgtMYWJlbHNFbnRyeRIQCgNrZXkY'
    'ASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBGjsKDU1ldGFkYXRhRW50cnkSEA'
    'oDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use assetDescriptor instead')
const Asset$json = {
  '1': 'Asset',
  '2': [
    {'1': 'iid', '3': 1, '4': 1, '5': 9, '10': 'iid'},
    {
      '1': 'identifiers',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.FinIdentifier',
      '10': 'identifiers'
    },
    {
      '1': 'classes',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.FinAssetClass',
      '10': 'classes'
    },
    {
      '1': 'display_names',
      '3': 101,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Asset.DisplayNamesEntry',
      '10': 'displayNames'
    },
    {
      '1': 'descriptions',
      '3': 102,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Asset.DescriptionsEntry',
      '10': 'descriptions'
    },
    {
      '1': 'labels',
      '3': 103,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Asset.LabelsEntry',
      '10': 'labels'
    },
    {'1': 'tags', '3': 104, '4': 3, '5': 9, '10': 'tags'},
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Asset.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [
    Asset_DisplayNamesEntry$json,
    Asset_DescriptionsEntry$json,
    Asset_LabelsEntry$json,
    Asset_MetadataEntry$json
  ],
};

@$core.Deprecated('Use assetDescriptor instead')
const Asset_DisplayNamesEntry$json = {
  '1': 'DisplayNamesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use assetDescriptor instead')
const Asset_DescriptionsEntry$json = {
  '1': 'DescriptionsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use assetDescriptor instead')
const Asset_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use assetDescriptor instead')
const Asset_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Asset`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List assetDescriptor = $convert.base64Decode(
    'CgVBc3NldBIQCgNpaWQYASABKAlSA2lpZBJQCgtpZGVudGlmaWVycxgCIAMoCzIuLnFvbWV0Lm'
    'Fnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuRmluSWRlbnRpZmllclILaWRlbnRpZmllcnMSSAoH'
    'Y2xhc3NlcxgDIAMoCzIuLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuRmluQXNzZX'
    'RDbGFzc1IHY2xhc3NlcxJdCg1kaXNwbGF5X25hbWVzGGUgAygLMjgucW9tZXQuYWdvcmEuZGFl'
    'bW9ucy5wcnRhZ2VudC52MS5Bc3NldC5EaXNwbGF5TmFtZXNFbnRyeVIMZGlzcGxheU5hbWVzEl'
    'wKDGRlc2NyaXB0aW9ucxhmIAMoCzI4LnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEu'
    'QXNzZXQuRGVzY3JpcHRpb25zRW50cnlSDGRlc2NyaXB0aW9ucxJKCgZsYWJlbHMYZyADKAsyMi'
    '5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkFzc2V0LkxhYmVsc0VudHJ5UgZsYWJl'
    'bHMSEgoEdGFncxhoIAMoCVIEdGFncxJQCghtZXRhZGF0YRhpIAMoCzI0LnFvbWV0LmFnb3JhLm'
    'RhZW1vbnMucHJ0YWdlbnQudjEuQXNzZXQuTWV0YWRhdGFFbnRyeVIIbWV0YWRhdGEaPwoRRGlz'
    'cGxheU5hbWVzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOg'
    'I4ARo/ChFEZXNjcmlwdGlvbnNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEo'
    'CVIFdmFsdWU6AjgBGjkKC0xhYmVsc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGA'
    'IgASgJUgV2YWx1ZToCOAEaOwoNTWV0YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2'
    'YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use participantDescriptor instead')
const Participant$json = {
  '1': 'Participant',
  '2': [
    {'1': 'iid', '3': 1, '4': 1, '5': 9, '10': 'iid'},
    {
      '1': 'identifiers',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.FinIdentifier',
      '10': 'identifiers'
    },
    {
      '1': 'types',
      '3': 3,
      '4': 3,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.ParticipantTypeEnum',
      '10': 'types'
    },
    {
      '1': 'display_names',
      '3': 101,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Participant.DisplayNamesEntry',
      '10': 'displayNames'
    },
    {
      '1': 'descriptions',
      '3': 102,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Participant.DescriptionsEntry',
      '10': 'descriptions'
    },
    {
      '1': 'labels',
      '3': 103,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Participant.LabelsEntry',
      '10': 'labels'
    },
    {'1': 'tags', '3': 104, '4': 3, '5': 9, '10': 'tags'},
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Participant.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [
    Participant_DisplayNamesEntry$json,
    Participant_DescriptionsEntry$json,
    Participant_LabelsEntry$json,
    Participant_MetadataEntry$json
  ],
};

@$core.Deprecated('Use participantDescriptor instead')
const Participant_DisplayNamesEntry$json = {
  '1': 'DisplayNamesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use participantDescriptor instead')
const Participant_DescriptionsEntry$json = {
  '1': 'DescriptionsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use participantDescriptor instead')
const Participant_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use participantDescriptor instead')
const Participant_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Participant`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List participantDescriptor = $convert.base64Decode(
    'CgtQYXJ0aWNpcGFudBIQCgNpaWQYASABKAlSA2lpZBJQCgtpZGVudGlmaWVycxgCIAMoCzIuLn'
    'FvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuRmluSWRlbnRpZmllclILaWRlbnRpZmll'
    'cnMSSgoFdHlwZXMYAyADKA4yNC5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLlBhcn'
    'RpY2lwYW50VHlwZUVudW1SBXR5cGVzEmMKDWRpc3BsYXlfbmFtZXMYZSADKAsyPi5xb21ldC5h'
    'Z29yYS5kYWVtb25zLnBydGFnZW50LnYxLlBhcnRpY2lwYW50LkRpc3BsYXlOYW1lc0VudHJ5Ug'
    'xkaXNwbGF5TmFtZXMSYgoMZGVzY3JpcHRpb25zGGYgAygLMj4ucW9tZXQuYWdvcmEuZGFlbW9u'
    'cy5wcnRhZ2VudC52MS5QYXJ0aWNpcGFudC5EZXNjcmlwdGlvbnNFbnRyeVIMZGVzY3JpcHRpb2'
    '5zElAKBmxhYmVscxhnIAMoCzI4LnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuUGFy'
    'dGljaXBhbnQuTGFiZWxzRW50cnlSBmxhYmVscxISCgR0YWdzGGggAygJUgR0YWdzElYKCG1ldG'
    'FkYXRhGGkgAygLMjoucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5QYXJ0aWNpcGFu'
    'dC5NZXRhZGF0YUVudHJ5UghtZXRhZGF0YRo/ChFEaXNwbGF5TmFtZXNFbnRyeRIQCgNrZXkYAS'
    'ABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBGj8KEURlc2NyaXB0aW9uc0VudHJ5'
    'EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAEaOQoLTGFiZWxzRW'
    '50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4ARo7Cg1NZXRh'
    'ZGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use participantToAssetRelationDescriptor instead')
const ParticipantToAssetRelation$json = {
  '1': 'ParticipantToAssetRelation',
  '2': [
    {'1': 'iid', '3': 1, '4': 1, '5': 9, '10': 'iid'},
    {'1': 'participant_iid', '3': 2, '4': 1, '5': 9, '10': 'participantIid'},
    {'1': 'asset_iid', '3': 3, '4': 1, '5': 9, '10': 'assetIid'},
    {
      '1': 'relations',
      '3': 4,
      '4': 3,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.ParticipantToAssetRelationEnum',
      '10': 'relations'
    },
    {
      '1': 'effective_from_dt',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'effectiveFromDt'
    },
    {
      '1': 'effective_to_dt',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'effectiveToDt'
    },
    {'1': 'weight', '3': 7, '4': 1, '5': 9, '10': 'weight'},
    {
      '1': 'display_names',
      '3': 101,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.ParticipantToAssetRelation.DisplayNamesEntry',
      '10': 'displayNames'
    },
    {
      '1': 'descriptions',
      '3': 102,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.ParticipantToAssetRelation.DescriptionsEntry',
      '10': 'descriptions'
    },
    {
      '1': 'labels',
      '3': 103,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.ParticipantToAssetRelation.LabelsEntry',
      '10': 'labels'
    },
    {'1': 'tags', '3': 104, '4': 3, '5': 9, '10': 'tags'},
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.ParticipantToAssetRelation.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [
    ParticipantToAssetRelation_DisplayNamesEntry$json,
    ParticipantToAssetRelation_DescriptionsEntry$json,
    ParticipantToAssetRelation_LabelsEntry$json,
    ParticipantToAssetRelation_MetadataEntry$json
  ],
};

@$core.Deprecated('Use participantToAssetRelationDescriptor instead')
const ParticipantToAssetRelation_DisplayNamesEntry$json = {
  '1': 'DisplayNamesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use participantToAssetRelationDescriptor instead')
const ParticipantToAssetRelation_DescriptionsEntry$json = {
  '1': 'DescriptionsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use participantToAssetRelationDescriptor instead')
const ParticipantToAssetRelation_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use participantToAssetRelationDescriptor instead')
const ParticipantToAssetRelation_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ParticipantToAssetRelation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List participantToAssetRelationDescriptor = $convert.base64Decode(
    'ChpQYXJ0aWNpcGFudFRvQXNzZXRSZWxhdGlvbhIQCgNpaWQYASABKAlSA2lpZBInCg9wYXJ0aW'
    'NpcGFudF9paWQYAiABKAlSDnBhcnRpY2lwYW50SWlkEhsKCWFzc2V0X2lpZBgDIAEoCVIIYXNz'
    'ZXRJaWQSXQoJcmVsYXRpb25zGAQgAygOMj8ucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC'
    '52MS5QYXJ0aWNpcGFudFRvQXNzZXRSZWxhdGlvbkVudW1SCXJlbGF0aW9ucxJVChFlZmZlY3Rp'
    'dmVfZnJvbV9kdBgFIAEoCzIpLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuRGF0ZV'
    'RpbWVSD2VmZmVjdGl2ZUZyb21EdBJRCg9lZmZlY3RpdmVfdG9fZHQYBiABKAsyKS5xb21ldC5h'
    'Z29yYS5kYWVtb25zLnBydGFnZW50LnYxLkRhdGVUaW1lUg1lZmZlY3RpdmVUb0R0EhYKBndlaW'
    'dodBgHIAEoCVIGd2VpZ2h0EnIKDWRpc3BsYXlfbmFtZXMYZSADKAsyTS5xb21ldC5hZ29yYS5k'
    'YWVtb25zLnBydGFnZW50LnYxLlBhcnRpY2lwYW50VG9Bc3NldFJlbGF0aW9uLkRpc3BsYXlOYW'
    '1lc0VudHJ5UgxkaXNwbGF5TmFtZXMScQoMZGVzY3JpcHRpb25zGGYgAygLMk0ucW9tZXQuYWdv'
    'cmEuZGFlbW9ucy5wcnRhZ2VudC52MS5QYXJ0aWNpcGFudFRvQXNzZXRSZWxhdGlvbi5EZXNjcm'
    'lwdGlvbnNFbnRyeVIMZGVzY3JpcHRpb25zEl8KBmxhYmVscxhnIAMoCzJHLnFvbWV0LmFnb3Jh'
    'LmRhZW1vbnMucHJ0YWdlbnQudjEuUGFydGljaXBhbnRUb0Fzc2V0UmVsYXRpb24uTGFiZWxzRW'
    '50cnlSBmxhYmVscxISCgR0YWdzGGggAygJUgR0YWdzEmUKCG1ldGFkYXRhGGkgAygLMkkucW9t'
    'ZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5QYXJ0aWNpcGFudFRvQXNzZXRSZWxhdGlvbi'
    '5NZXRhZGF0YUVudHJ5UghtZXRhZGF0YRo/ChFEaXNwbGF5TmFtZXNFbnRyeRIQCgNrZXkYASAB'
    'KAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBGj8KEURlc2NyaXB0aW9uc0VudHJ5Eh'
    'AKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAEaOQoLTGFiZWxzRW50'
    'cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4ARo7Cg1NZXRhZG'
    'F0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use finInstrumentClassDescriptor instead')
const FinInstrumentClass$json = {
  '1': 'FinInstrumentClass',
  '2': [
    {'1': 'schema', '3': 1, '4': 1, '5': 9, '10': 'schema'},
    {
      '1': 'classes',
      '3': 2,
      '4': 3,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.InstrumentClassEnum',
      '10': 'classes'
    },
    {
      '1': 'display_names',
      '3': 101,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.FinInstrumentClass.DisplayNamesEntry',
      '10': 'displayNames'
    },
    {
      '1': 'descriptions',
      '3': 102,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.FinInstrumentClass.DescriptionsEntry',
      '10': 'descriptions'
    },
    {
      '1': 'labels',
      '3': 103,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.FinInstrumentClass.LabelsEntry',
      '10': 'labels'
    },
    {'1': 'tags', '3': 104, '4': 3, '5': 9, '10': 'tags'},
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.FinInstrumentClass.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [
    FinInstrumentClass_DisplayNamesEntry$json,
    FinInstrumentClass_DescriptionsEntry$json,
    FinInstrumentClass_LabelsEntry$json,
    FinInstrumentClass_MetadataEntry$json
  ],
};

@$core.Deprecated('Use finInstrumentClassDescriptor instead')
const FinInstrumentClass_DisplayNamesEntry$json = {
  '1': 'DisplayNamesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use finInstrumentClassDescriptor instead')
const FinInstrumentClass_DescriptionsEntry$json = {
  '1': 'DescriptionsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use finInstrumentClassDescriptor instead')
const FinInstrumentClass_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use finInstrumentClassDescriptor instead')
const FinInstrumentClass_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `FinInstrumentClass`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List finInstrumentClassDescriptor = $convert.base64Decode(
    'ChJGaW5JbnN0cnVtZW50Q2xhc3MSFgoGc2NoZW1hGAEgASgJUgZzY2hlbWESTgoHY2xhc3Nlcx'
    'gCIAMoDjI0LnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuSW5zdHJ1bWVudENsYXNz'
    'RW51bVIHY2xhc3NlcxJqCg1kaXNwbGF5X25hbWVzGGUgAygLMkUucW9tZXQuYWdvcmEuZGFlbW'
    '9ucy5wcnRhZ2VudC52MS5GaW5JbnN0cnVtZW50Q2xhc3MuRGlzcGxheU5hbWVzRW50cnlSDGRp'
    'c3BsYXlOYW1lcxJpCgxkZXNjcmlwdGlvbnMYZiADKAsyRS5xb21ldC5hZ29yYS5kYWVtb25zLn'
    'BydGFnZW50LnYxLkZpbkluc3RydW1lbnRDbGFzcy5EZXNjcmlwdGlvbnNFbnRyeVIMZGVzY3Jp'
    'cHRpb25zElcKBmxhYmVscxhnIAMoCzI/LnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudj'
    'EuRmluSW5zdHJ1bWVudENsYXNzLkxhYmVsc0VudHJ5UgZsYWJlbHMSEgoEdGFncxhoIAMoCVIE'
    'dGFncxJdCghtZXRhZGF0YRhpIAMoCzJBLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudj'
    'EuRmluSW5zdHJ1bWVudENsYXNzLk1ldGFkYXRhRW50cnlSCG1ldGFkYXRhGj8KEURpc3BsYXlO'
    'YW1lc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAEaPw'
    'oRRGVzY3JpcHRpb25zRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZh'
    'bHVlOgI4ARo5CgtMYWJlbHNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCV'
    'IFdmFsdWU6AjgBGjsKDU1ldGFkYXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUY'
    'AiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use oneOfIdOrParticipantDescriptor instead')
const OneOfIdOrParticipant$json = {
  '1': 'OneOfIdOrParticipant',
  '2': [
    {'1': 'iid', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'iid'},
    {
      '1': 'obj',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Participant',
      '9': 0,
      '10': 'obj'
    },
  ],
  '8': [
    {'1': 'participant'},
  ],
};

/// Descriptor for `OneOfIdOrParticipant`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List oneOfIdOrParticipantDescriptor = $convert.base64Decode(
    'ChRPbmVPZklkT3JQYXJ0aWNpcGFudBISCgNpaWQYASABKAlIAFIDaWlkEkAKA29iahgCIAEoCz'
    'IsLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuUGFydGljaXBhbnRIAFIDb2JqQg0K'
    'C3BhcnRpY2lwYW50');

@$core.Deprecated('Use instrumentDescriptor instead')
const Instrument$json = {
  '1': 'Instrument',
  '2': [
    {'1': 'iid', '3': 1, '4': 1, '5': 9, '10': 'iid'},
    {
      '1': 'identifiers',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.FinIdentifier',
      '10': 'identifiers'
    },
    {'1': 'cfi_code', '3': 3, '4': 1, '5': 9, '10': 'cfiCode'},
    {
      '1': 'classes',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.FinInstrumentClass',
      '10': 'classes'
    },
    {
      '1': 'maturity_dt',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'maturityDt'
    },
    {'1': 'asset_iid', '3': 6, '4': 1, '5': 9, '9': 0, '10': 'assetIid'},
    {
      '1': 'asset_obj',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Asset',
      '9': 0,
      '10': 'assetObj'
    },
    {
      '1': 'issue_dt',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'issueDt'
    },
    {
      '1': 'issuers',
      '3': 9,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.OneOfIdOrParticipant',
      '10': 'issuers'
    },
    {
      '1': 'issue_country_code',
      '3': 10,
      '4': 1,
      '5': 9,
      '10': 'issueCountryCode'
    },
    {'1': 'issue_currency', '3': 11, '4': 1, '5': 9, '10': 'issueCurrency'},
    {
      '1': 'issue_initial_units',
      '3': 12,
      '4': 1,
      '5': 9,
      '10': 'issueInitialUnits'
    },
    {
      '1': 'issue_divisibility',
      '3': 13,
      '4': 1,
      '5': 9,
      '10': 'issueDivisibility'
    },
    {
      '1': 'issue_initial_authorized_units',
      '3': 14,
      '4': 1,
      '5': 9,
      '10': 'issueInitialAuthorizedUnits'
    },
    {
      '1': 'display_names',
      '3': 101,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Instrument.DisplayNamesEntry',
      '10': 'displayNames'
    },
    {
      '1': 'descriptions',
      '3': 102,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Instrument.DescriptionsEntry',
      '10': 'descriptions'
    },
    {
      '1': 'labels',
      '3': 103,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Instrument.LabelsEntry',
      '10': 'labels'
    },
    {'1': 'tags', '3': 104, '4': 3, '5': 9, '10': 'tags'},
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Instrument.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [
    Instrument_DisplayNamesEntry$json,
    Instrument_DescriptionsEntry$json,
    Instrument_LabelsEntry$json,
    Instrument_MetadataEntry$json
  ],
  '8': [
    {'1': 'asset'},
  ],
};

@$core.Deprecated('Use instrumentDescriptor instead')
const Instrument_DisplayNamesEntry$json = {
  '1': 'DisplayNamesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use instrumentDescriptor instead')
const Instrument_DescriptionsEntry$json = {
  '1': 'DescriptionsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use instrumentDescriptor instead')
const Instrument_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use instrumentDescriptor instead')
const Instrument_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Instrument`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List instrumentDescriptor = $convert.base64Decode(
    'CgpJbnN0cnVtZW50EhAKA2lpZBgBIAEoCVIDaWlkElAKC2lkZW50aWZpZXJzGAIgAygLMi4ucW'
    '9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5GaW5JZGVudGlmaWVyUgtpZGVudGlmaWVy'
    'cxIZCghjZmlfY29kZRgDIAEoCVIHY2ZpQ29kZRJNCgdjbGFzc2VzGAQgAygLMjMucW9tZXQuYW'
    'dvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5GaW5JbnN0cnVtZW50Q2xhc3NSB2NsYXNzZXMSSgoL'
    'bWF0dXJpdHlfZHQYBSABKAsyKS5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkRhdG'
    'VUaW1lUgptYXR1cml0eUR0Eh0KCWFzc2V0X2lpZBgGIAEoCUgAUghhc3NldElpZBJFCglhc3Nl'
    'dF9vYmoYByABKAsyJi5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkFzc2V0SABSCG'
    'Fzc2V0T2JqEkQKCGlzc3VlX2R0GAggASgLMikucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2Vu'
    'dC52MS5EYXRlVGltZVIHaXNzdWVEdBJPCgdpc3N1ZXJzGAkgAygLMjUucW9tZXQuYWdvcmEuZG'
    'FlbW9ucy5wcnRhZ2VudC52MS5PbmVPZklkT3JQYXJ0aWNpcGFudFIHaXNzdWVycxIsChJpc3N1'
    'ZV9jb3VudHJ5X2NvZGUYCiABKAlSEGlzc3VlQ291bnRyeUNvZGUSJQoOaXNzdWVfY3VycmVuY3'
    'kYCyABKAlSDWlzc3VlQ3VycmVuY3kSLgoTaXNzdWVfaW5pdGlhbF91bml0cxgMIAEoCVIRaXNz'
    'dWVJbml0aWFsVW5pdHMSLQoSaXNzdWVfZGl2aXNpYmlsaXR5GA0gASgJUhFpc3N1ZURpdmlzaW'
    'JpbGl0eRJDCh5pc3N1ZV9pbml0aWFsX2F1dGhvcml6ZWRfdW5pdHMYDiABKAlSG2lzc3VlSW5p'
    'dGlhbEF1dGhvcml6ZWRVbml0cxJiCg1kaXNwbGF5X25hbWVzGGUgAygLMj0ucW9tZXQuYWdvcm'
    'EuZGFlbW9ucy5wcnRhZ2VudC52MS5JbnN0cnVtZW50LkRpc3BsYXlOYW1lc0VudHJ5UgxkaXNw'
    'bGF5TmFtZXMSYQoMZGVzY3JpcHRpb25zGGYgAygLMj0ucW9tZXQuYWdvcmEuZGFlbW9ucy5wcn'
    'RhZ2VudC52MS5JbnN0cnVtZW50LkRlc2NyaXB0aW9uc0VudHJ5UgxkZXNjcmlwdGlvbnMSTwoG'
    'bGFiZWxzGGcgAygLMjcucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5JbnN0cnVtZW'
    '50LkxhYmVsc0VudHJ5UgZsYWJlbHMSEgoEdGFncxhoIAMoCVIEdGFncxJVCghtZXRhZGF0YRhp'
    'IAMoCzI5LnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuSW5zdHJ1bWVudC5NZXRhZG'
    'F0YUVudHJ5UghtZXRhZGF0YRo/ChFEaXNwbGF5TmFtZXNFbnRyeRIQCgNrZXkYASABKAlSA2tl'
    'eRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBGj8KEURlc2NyaXB0aW9uc0VudHJ5EhAKA2tleR'
    'gBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAEaOQoLTGFiZWxzRW50cnkSEAoD'
    'a2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4ARo7Cg1NZXRhZGF0YUVudH'
    'J5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAFCBwoFYXNzZXQ=');

@$core.Deprecated('Use participantToInstrumentRelationDescriptor instead')
const ParticipantToInstrumentRelation$json = {
  '1': 'ParticipantToInstrumentRelation',
  '2': [
    {'1': 'iid', '3': 1, '4': 1, '5': 9, '10': 'iid'},
    {'1': 'participant_iid', '3': 2, '4': 1, '5': 9, '10': 'participantIid'},
    {'1': 'instrument_iid', '3': 3, '4': 1, '5': 9, '10': 'instrumentIid'},
    {
      '1': 'relations',
      '3': 4,
      '4': 3,
      '5': 14,
      '6':
          '.qomet.agora.daemons.prtagent.v1.ParticipantToInstrumentRelationEnum',
      '10': 'relations'
    },
    {
      '1': 'effective_from_dt',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'effectiveFromDt'
    },
    {
      '1': 'effective_to_dt',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'effectiveToDt'
    },
    {'1': 'weight', '3': 7, '4': 1, '5': 9, '10': 'weight'},
    {
      '1': 'display_names',
      '3': 101,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.ParticipantToInstrumentRelation.DisplayNamesEntry',
      '10': 'displayNames'
    },
    {
      '1': 'descriptions',
      '3': 102,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.ParticipantToInstrumentRelation.DescriptionsEntry',
      '10': 'descriptions'
    },
    {
      '1': 'labels',
      '3': 103,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.ParticipantToInstrumentRelation.LabelsEntry',
      '10': 'labels'
    },
    {'1': 'tags', '3': 104, '4': 3, '5': 9, '10': 'tags'},
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.ParticipantToInstrumentRelation.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [
    ParticipantToInstrumentRelation_DisplayNamesEntry$json,
    ParticipantToInstrumentRelation_DescriptionsEntry$json,
    ParticipantToInstrumentRelation_LabelsEntry$json,
    ParticipantToInstrumentRelation_MetadataEntry$json
  ],
};

@$core.Deprecated('Use participantToInstrumentRelationDescriptor instead')
const ParticipantToInstrumentRelation_DisplayNamesEntry$json = {
  '1': 'DisplayNamesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use participantToInstrumentRelationDescriptor instead')
const ParticipantToInstrumentRelation_DescriptionsEntry$json = {
  '1': 'DescriptionsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use participantToInstrumentRelationDescriptor instead')
const ParticipantToInstrumentRelation_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use participantToInstrumentRelationDescriptor instead')
const ParticipantToInstrumentRelation_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ParticipantToInstrumentRelation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List participantToInstrumentRelationDescriptor = $convert.base64Decode(
    'Ch9QYXJ0aWNpcGFudFRvSW5zdHJ1bWVudFJlbGF0aW9uEhAKA2lpZBgBIAEoCVIDaWlkEicKD3'
    'BhcnRpY2lwYW50X2lpZBgCIAEoCVIOcGFydGljaXBhbnRJaWQSJQoOaW5zdHJ1bWVudF9paWQY'
    'AyABKAlSDWluc3RydW1lbnRJaWQSYgoJcmVsYXRpb25zGAQgAygOMkQucW9tZXQuYWdvcmEuZG'
    'FlbW9ucy5wcnRhZ2VudC52MS5QYXJ0aWNpcGFudFRvSW5zdHJ1bWVudFJlbGF0aW9uRW51bVIJ'
    'cmVsYXRpb25zElUKEWVmZmVjdGl2ZV9mcm9tX2R0GAUgASgLMikucW9tZXQuYWdvcmEuZGFlbW'
    '9ucy5wcnRhZ2VudC52MS5EYXRlVGltZVIPZWZmZWN0aXZlRnJvbUR0ElEKD2VmZmVjdGl2ZV90'
    'b19kdBgGIAEoCzIpLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuRGF0ZVRpbWVSDW'
    'VmZmVjdGl2ZVRvRHQSFgoGd2VpZ2h0GAcgASgJUgZ3ZWlnaHQSdwoNZGlzcGxheV9uYW1lcxhl'
    'IAMoCzJSLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuUGFydGljaXBhbnRUb0luc3'
    'RydW1lbnRSZWxhdGlvbi5EaXNwbGF5TmFtZXNFbnRyeVIMZGlzcGxheU5hbWVzEnYKDGRlc2Ny'
    'aXB0aW9ucxhmIAMoCzJSLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuUGFydGljaX'
    'BhbnRUb0luc3RydW1lbnRSZWxhdGlvbi5EZXNjcmlwdGlvbnNFbnRyeVIMZGVzY3JpcHRpb25z'
    'EmQKBmxhYmVscxhnIAMoCzJMLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuUGFydG'
    'ljaXBhbnRUb0luc3RydW1lbnRSZWxhdGlvbi5MYWJlbHNFbnRyeVIGbGFiZWxzEhIKBHRhZ3MY'
    'aCADKAlSBHRhZ3MSagoIbWV0YWRhdGEYaSADKAsyTi5xb21ldC5hZ29yYS5kYWVtb25zLnBydG'
    'FnZW50LnYxLlBhcnRpY2lwYW50VG9JbnN0cnVtZW50UmVsYXRpb24uTWV0YWRhdGFFbnRyeVII'
    'bWV0YWRhdGEaPwoRRGlzcGxheU5hbWVzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdW'
    'UYAiABKAlSBXZhbHVlOgI4ARo/ChFEZXNjcmlwdGlvbnNFbnRyeRIQCgNrZXkYASABKAlSA2tl'
    'eRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBGjkKC0xhYmVsc0VudHJ5EhAKA2tleRgBIAEoCV'
    'IDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAEaOwoNTWV0YWRhdGFFbnRyeRIQCgNrZXkY'
    'ASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use holdingsDescriptor instead')
const Holdings$json = {
  '1': 'Holdings',
  '2': [
    {
      '1': 'instrument_iid',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'instrumentIid'
    },
    {
      '1': 'currency_code',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'currencyCode'
    },
    {'1': 'total_units', '3': 3, '4': 1, '5': 9, '10': 'totalUnits'},
    {
      '1': 'stash_units',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Holdings.StashUnitsEntry',
      '10': 'stashUnits'
    },
  ],
  '3': [Holdings_StashUnitsEntry$json],
  '8': [
    {'1': 'asset_id'},
  ],
};

@$core.Deprecated('Use holdingsDescriptor instead')
const Holdings_StashUnitsEntry$json = {
  '1': 'StashUnitsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Holdings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List holdingsDescriptor = $convert.base64Decode(
    'CghIb2xkaW5ncxInCg5pbnN0cnVtZW50X2lpZBgBIAEoCUgAUg1pbnN0cnVtZW50SWlkEiUKDW'
    'N1cnJlbmN5X2NvZGUYAiABKAlIAFIMY3VycmVuY3lDb2RlEh8KC3RvdGFsX3VuaXRzGAMgASgJ'
    'Ugp0b3RhbFVuaXRzEloKC3N0YXNoX3VuaXRzGAQgAygLMjkucW9tZXQuYWdvcmEuZGFlbW9ucy'
    '5wcnRhZ2VudC52MS5Ib2xkaW5ncy5TdGFzaFVuaXRzRW50cnlSCnN0YXNoVW5pdHMaPQoPU3Rh'
    'c2hVbml0c0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOA'
    'FCCgoIYXNzZXRfaWQ=');

@$core.Deprecated('Use portfolioDescriptor instead')
const Portfolio$json = {
  '1': 'Portfolio',
  '2': [
    {'1': 'account_iid', '3': 1, '4': 1, '5': 9, '10': 'accountIid'},
    {
      '1': 'generated_at_dt',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'generatedAtDt'
    },
    {
      '1': 'holdings',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Portfolio.HoldingsEntry',
      '10': 'holdings'
    },
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Portfolio.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [Portfolio_HoldingsEntry$json, Portfolio_MetadataEntry$json],
};

@$core.Deprecated('Use portfolioDescriptor instead')
const Portfolio_HoldingsEntry$json = {
  '1': 'HoldingsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Holdings',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use portfolioDescriptor instead')
const Portfolio_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Portfolio`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List portfolioDescriptor = $convert.base64Decode(
    'CglQb3J0Zm9saW8SHwoLYWNjb3VudF9paWQYASABKAlSCmFjY291bnRJaWQSUQoPZ2VuZXJhdG'
    'VkX2F0X2R0GAIgASgLMikucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5EYXRlVGlt'
    'ZVINZ2VuZXJhdGVkQXREdBJUCghob2xkaW5ncxgDIAMoCzI4LnFvbWV0LmFnb3JhLmRhZW1vbn'
    'MucHJ0YWdlbnQudjEuUG9ydGZvbGlvLkhvbGRpbmdzRW50cnlSCGhvbGRpbmdzElQKCG1ldGFk'
    'YXRhGGkgAygLMjgucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5Qb3J0Zm9saW8uTW'
    'V0YWRhdGFFbnRyeVIIbWV0YWRhdGEaZgoNSG9sZGluZ3NFbnRyeRIQCgNrZXkYASABKAlSA2tl'
    'eRI/CgV2YWx1ZRgCIAEoCzIpLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuSG9sZG'
    'luZ3NSBXZhbHVlOgI4ARo7Cg1NZXRhZGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZh'
    'bHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use marketDescriptor instead')
const Market$json = {
  '1': 'Market',
  '2': [
    {'1': 'iid', '3': 1, '4': 1, '5': 9, '10': 'iid'},
    {
      '1': 'identifiers',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.FinIdentifier',
      '10': 'identifiers'
    },
    {
      '1': 'dominant_currency',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'dominantCurrency'
    },
    {'1': 'country_code', '3': 4, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'city_code', '3': 5, '4': 1, '5': 9, '10': 'cityCode'},
    {'1': 'website_url', '3': 6, '4': 1, '5': 9, '10': 'websiteUrl'},
    {'1': 'timezone', '3': 7, '4': 1, '5': 9, '10': 'timezone'},
    {
      '1': 'trading_hours',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Duration',
      '10': 'tradingHours'
    },
    {'1': 'trading_days', '3': 9, '4': 3, '5': 9, '10': 'tradingDays'},
    {
      '1': 'status',
      '3': 10,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.MarketStatus',
      '10': 'status'
    },
    {
      '1': 'display_names',
      '3': 101,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Market.DisplayNamesEntry',
      '10': 'displayNames'
    },
    {
      '1': 'descriptions',
      '3': 102,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Market.DescriptionsEntry',
      '10': 'descriptions'
    },
    {
      '1': 'labels',
      '3': 103,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Market.LabelsEntry',
      '10': 'labels'
    },
    {'1': 'tags', '3': 104, '4': 3, '5': 9, '10': 'tags'},
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Market.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [
    Market_DisplayNamesEntry$json,
    Market_DescriptionsEntry$json,
    Market_LabelsEntry$json,
    Market_MetadataEntry$json
  ],
};

@$core.Deprecated('Use marketDescriptor instead')
const Market_DisplayNamesEntry$json = {
  '1': 'DisplayNamesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use marketDescriptor instead')
const Market_DescriptionsEntry$json = {
  '1': 'DescriptionsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use marketDescriptor instead')
const Market_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use marketDescriptor instead')
const Market_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Market`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List marketDescriptor = $convert.base64Decode(
    'CgZNYXJrZXQSEAoDaWlkGAEgASgJUgNpaWQSUAoLaWRlbnRpZmllcnMYAiADKAsyLi5xb21ldC'
    '5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkZpbklkZW50aWZpZXJSC2lkZW50aWZpZXJzEisK'
    'EWRvbWluYW50X2N1cnJlbmN5GAMgASgJUhBkb21pbmFudEN1cnJlbmN5EiEKDGNvdW50cnlfY2'
    '9kZRgEIAEoCVILY291bnRyeUNvZGUSGwoJY2l0eV9jb2RlGAUgASgJUghjaXR5Q29kZRIfCgt3'
    'ZWJzaXRlX3VybBgGIAEoCVIKd2Vic2l0ZVVybBIaCgh0aW1lem9uZRgHIAEoCVIIdGltZXpvbm'
    'USTgoNdHJhZGluZ19ob3VycxgIIAEoCzIpLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQu'
    'djEuRHVyYXRpb25SDHRyYWRpbmdIb3VycxIhCgx0cmFkaW5nX2RheXMYCSADKAlSC3RyYWRpbm'
    'dEYXlzEkUKBnN0YXR1cxgKIAEoDjItLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEu'
    'TWFya2V0U3RhdHVzUgZzdGF0dXMSXgoNZGlzcGxheV9uYW1lcxhlIAMoCzI5LnFvbWV0LmFnb3'
    'JhLmRhZW1vbnMucHJ0YWdlbnQudjEuTWFya2V0LkRpc3BsYXlOYW1lc0VudHJ5UgxkaXNwbGF5'
    'TmFtZXMSXQoMZGVzY3JpcHRpb25zGGYgAygLMjkucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2'
    'VudC52MS5NYXJrZXQuRGVzY3JpcHRpb25zRW50cnlSDGRlc2NyaXB0aW9ucxJLCgZsYWJlbHMY'
    'ZyADKAsyMy5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLk1hcmtldC5MYWJlbHNFbn'
    'RyeVIGbGFiZWxzEhIKBHRhZ3MYaCADKAlSBHRhZ3MSUQoIbWV0YWRhdGEYaSADKAsyNS5xb21l'
    'dC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLk1hcmtldC5NZXRhZGF0YUVudHJ5UghtZXRhZG'
    'F0YRo/ChFEaXNwbGF5TmFtZXNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEo'
    'CVIFdmFsdWU6AjgBGj8KEURlc2NyaXB0aW9uc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBX'
    'ZhbHVlGAIgASgJUgV2YWx1ZToCOAEaOQoLTGFiZWxzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkS'
    'FAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4ARo7Cg1NZXRhZGF0YUVudHJ5EhAKA2tleRgBIAEoCV'
    'IDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use marketDurationDescriptor instead')
const MarketDuration$json = {
  '1': 'MarketDuration',
  '2': [
    {
      '1': 'duration',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Duration',
      '10': 'duration'
    },
    {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.MarketStatus',
      '10': 'status'
    },
    {'1': 'comments', '3': 3, '4': 3, '5': 9, '10': 'comments'},
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.MarketDuration.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [MarketDuration_MetadataEntry$json],
};

@$core.Deprecated('Use marketDurationDescriptor instead')
const MarketDuration_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `MarketDuration`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List marketDurationDescriptor = $convert.base64Decode(
    'Cg5NYXJrZXREdXJhdGlvbhJFCghkdXJhdGlvbhgBIAEoCzIpLnFvbWV0LmFnb3JhLmRhZW1vbn'
    'MucHJ0YWdlbnQudjEuRHVyYXRpb25SCGR1cmF0aW9uEkUKBnN0YXR1cxgCIAEoDjItLnFvbWV0'
    'LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuTWFya2V0U3RhdHVzUgZzdGF0dXMSGgoIY29tbW'
    'VudHMYAyADKAlSCGNvbW1lbnRzElkKCG1ldGFkYXRhGGkgAygLMj0ucW9tZXQuYWdvcmEuZGFl'
    'bW9ucy5wcnRhZ2VudC52MS5NYXJrZXREdXJhdGlvbi5NZXRhZGF0YUVudHJ5UghtZXRhZGF0YR'
    'o7Cg1NZXRhZGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1'
    'ZToCOAE=');

@$core.Deprecated('Use marketCalendarDescriptor instead')
const MarketCalendar$json = {
  '1': 'MarketCalendar',
  '2': [
    {'1': 'market_iid', '3': 1, '4': 1, '5': 9, '10': 'marketIid'},
    {
      '1': 'daily_open',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'dailyOpen'
    },
    {
      '1': 'daily_close',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'dailyClose'
    },
    {
      '1': 'calendar',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Duration',
      '10': 'calendar'
    },
  ],
};

/// Descriptor for `MarketCalendar`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List marketCalendarDescriptor = $convert.base64Decode(
    'Cg5NYXJrZXRDYWxlbmRhchIdCgptYXJrZXRfaWlkGAEgASgJUgltYXJrZXRJaWQSRAoKZGFpbH'
    'lfb3BlbhgCIAEoCzIlLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuVGltZVIJZGFp'
    'bHlPcGVuEkYKC2RhaWx5X2Nsb3NlGAMgASgLMiUucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2'
    'VudC52MS5UaW1lUgpkYWlseUNsb3NlEkUKCGNhbGVuZGFyGAQgAygLMikucW9tZXQuYWdvcmEu'
    'ZGFlbW9ucy5wcnRhZ2VudC52MS5EdXJhdGlvblIIY2FsZW5kYXI=');

@$core.Deprecated('Use venueDescriptor instead')
const Venue$json = {
  '1': 'Venue',
  '2': [
    {'1': 'iid', '3': 1, '4': 1, '5': 9, '10': 'iid'},
    {
      '1': 'identifiers',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.FinIdentifier',
      '10': 'identifiers'
    },
    {'1': 'market_iid', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'marketIid'},
    {
      '1': 'market_obj',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Market',
      '9': 0,
      '10': 'marketObj'
    },
    {
      '1': 'dominant_currency',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'dominantCurrency'
    },
    {
      '1': 'venue_type',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.VenueTypeEnum',
      '10': 'venueType'
    },
    {
      '1': 'established_dt',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'establishedDt'
    },
    {'1': 'country_code', '3': 8, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'city_code', '3': 9, '4': 1, '5': 9, '10': 'cityCode'},
    {'1': 'website_url', '3': 10, '4': 1, '5': 9, '10': 'websiteUrl'},
    {'1': 'timezone', '3': 11, '4': 1, '5': 9, '10': 'timezone'},
    {
      '1': 'trading_hours',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Duration',
      '10': 'tradingHours'
    },
    {'1': 'trading_days', '3': 13, '4': 3, '5': 9, '10': 'tradingDays'},
    {
      '1': 'status',
      '3': 14,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.VenueStatus',
      '10': 'status'
    },
    {
      '1': 'settlement_depositories',
      '3': 15,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.OneOfIdOrParticipant',
      '10': 'settlementDepositories'
    },
    {
      '1': 'clearing_houses',
      '3': 16,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.OneOfIdOrParticipant',
      '10': 'clearingHouses'
    },
    {
      '1': 'regulators',
      '3': 17,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.OneOfIdOrParticipant',
      '10': 'regulators'
    },
    {
      '1': 'display_names',
      '3': 101,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Venue.DisplayNamesEntry',
      '10': 'displayNames'
    },
    {
      '1': 'descriptions',
      '3': 102,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Venue.DescriptionsEntry',
      '10': 'descriptions'
    },
    {
      '1': 'labels',
      '3': 103,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Venue.LabelsEntry',
      '10': 'labels'
    },
    {'1': 'tags', '3': 104, '4': 3, '5': 9, '10': 'tags'},
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Venue.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [
    Venue_DisplayNamesEntry$json,
    Venue_DescriptionsEntry$json,
    Venue_LabelsEntry$json,
    Venue_MetadataEntry$json
  ],
  '8': [
    {'1': 'market'},
  ],
};

@$core.Deprecated('Use venueDescriptor instead')
const Venue_DisplayNamesEntry$json = {
  '1': 'DisplayNamesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use venueDescriptor instead')
const Venue_DescriptionsEntry$json = {
  '1': 'DescriptionsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use venueDescriptor instead')
const Venue_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use venueDescriptor instead')
const Venue_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Venue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List venueDescriptor = $convert.base64Decode(
    'CgVWZW51ZRIQCgNpaWQYASABKAlSA2lpZBJQCgtpZGVudGlmaWVycxgCIAMoCzIuLnFvbWV0Lm'
    'Fnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuRmluSWRlbnRpZmllclILaWRlbnRpZmllcnMSHwoK'
    'bWFya2V0X2lpZBgDIAEoCUgAUgltYXJrZXRJaWQSSAoKbWFya2V0X29iahgEIAEoCzInLnFvbW'
    'V0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuTWFya2V0SABSCW1hcmtldE9iahIrChFkb21p'
    'bmFudF9jdXJyZW5jeRgFIAEoCVIQZG9taW5hbnRDdXJyZW5jeRJNCgp2ZW51ZV90eXBlGAYgAS'
    'gOMi4ucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5WZW51ZVR5cGVFbnVtUgl2ZW51'
    'ZVR5cGUSUAoOZXN0YWJsaXNoZWRfZHQYByABKAsyKS5xb21ldC5hZ29yYS5kYWVtb25zLnBydG'
    'FnZW50LnYxLkRhdGVUaW1lUg1lc3RhYmxpc2hlZER0EiEKDGNvdW50cnlfY29kZRgIIAEoCVIL'
    'Y291bnRyeUNvZGUSGwoJY2l0eV9jb2RlGAkgASgJUghjaXR5Q29kZRIfCgt3ZWJzaXRlX3VybB'
    'gKIAEoCVIKd2Vic2l0ZVVybBIaCgh0aW1lem9uZRgLIAEoCVIIdGltZXpvbmUSTgoNdHJhZGlu'
    'Z19ob3VycxgMIAEoCzIpLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuRHVyYXRpb2'
    '5SDHRyYWRpbmdIb3VycxIhCgx0cmFkaW5nX2RheXMYDSADKAlSC3RyYWRpbmdEYXlzEkQKBnN0'
    'YXR1cxgOIAEoDjIsLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuVmVudWVTdGF0dX'
    'NSBnN0YXR1cxJuChdzZXR0bGVtZW50X2RlcG9zaXRvcmllcxgPIAMoCzI1LnFvbWV0LmFnb3Jh'
    'LmRhZW1vbnMucHJ0YWdlbnQudjEuT25lT2ZJZE9yUGFydGljaXBhbnRSFnNldHRsZW1lbnREZX'
    'Bvc2l0b3JpZXMSXgoPY2xlYXJpbmdfaG91c2VzGBAgAygLMjUucW9tZXQuYWdvcmEuZGFlbW9u'
    'cy5wcnRhZ2VudC52MS5PbmVPZklkT3JQYXJ0aWNpcGFudFIOY2xlYXJpbmdIb3VzZXMSVQoKcm'
    'VndWxhdG9ycxgRIAMoCzI1LnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuT25lT2ZJ'
    'ZE9yUGFydGljaXBhbnRSCnJlZ3VsYXRvcnMSXQoNZGlzcGxheV9uYW1lcxhlIAMoCzI4LnFvbW'
    'V0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuVmVudWUuRGlzcGxheU5hbWVzRW50cnlSDGRp'
    'c3BsYXlOYW1lcxJcCgxkZXNjcmlwdGlvbnMYZiADKAsyOC5xb21ldC5hZ29yYS5kYWVtb25zLn'
    'BydGFnZW50LnYxLlZlbnVlLkRlc2NyaXB0aW9uc0VudHJ5UgxkZXNjcmlwdGlvbnMSSgoGbGFi'
    'ZWxzGGcgAygLMjIucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5WZW51ZS5MYWJlbH'
    'NFbnRyeVIGbGFiZWxzEhIKBHRhZ3MYaCADKAlSBHRhZ3MSUAoIbWV0YWRhdGEYaSADKAsyNC5x'
    'b21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLlZlbnVlLk1ldGFkYXRhRW50cnlSCG1ldG'
    'FkYXRhGj8KEURpc3BsYXlOYW1lc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIg'
    'ASgJUgV2YWx1ZToCOAEaPwoRRGVzY3JpcHRpb25zRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFA'
    'oFdmFsdWUYAiABKAlSBXZhbHVlOgI4ARo5CgtMYWJlbHNFbnRyeRIQCgNrZXkYASABKAlSA2tl'
    'eRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBGjsKDU1ldGFkYXRhRW50cnkSEAoDa2V5GAEgAS'
    'gJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AUIICgZtYXJrZXQ=');

@$core.Deprecated('Use instrumentListingDescriptor instead')
const InstrumentListing$json = {
  '1': 'InstrumentListing',
  '2': [
    {'1': 'iid', '3': 1, '4': 1, '5': 9, '10': 'iid'},
    {
      '1': 'local_identifiers',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.FinIdentifier',
      '10': 'localIdentifiers'
    },
    {
      '1': 'instrument_iid',
      '3': 4,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'instrumentIid'
    },
    {
      '1': 'instrument_obj',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Instrument',
      '9': 0,
      '10': 'instrumentObj'
    },
    {'1': 'venue_iid', '3': 6, '4': 1, '5': 9, '9': 1, '10': 'venueIid'},
    {
      '1': 'venue_obj',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Venue',
      '9': 1,
      '10': 'venueObj'
    },
    {
      '1': 'listing_dt',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'listingDt'
    },
    {
      '1': 'effective_from_dt',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'effectiveFromDt'
    },
    {
      '1': 'effective_to_dt',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'effectiveToDt'
    },
    {
      '1': 'status',
      '3': 11,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.InstrumentListingStatusEnum',
      '10': 'status'
    },
    {'1': 'lot_size', '3': 12, '4': 1, '5': 9, '10': 'lotSize'},
    {'1': 'tick_size', '3': 13, '4': 1, '5': 9, '10': 'tickSize'},
    {'1': 'currency', '3': 14, '4': 1, '5': 9, '10': 'currency'},
    {
      '1': 'display_names',
      '3': 101,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.InstrumentListing.DisplayNamesEntry',
      '10': 'displayNames'
    },
    {
      '1': 'descriptions',
      '3': 102,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.InstrumentListing.DescriptionsEntry',
      '10': 'descriptions'
    },
    {
      '1': 'labels',
      '3': 103,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.InstrumentListing.LabelsEntry',
      '10': 'labels'
    },
    {'1': 'tags', '3': 104, '4': 3, '5': 9, '10': 'tags'},
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.InstrumentListing.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [
    InstrumentListing_DisplayNamesEntry$json,
    InstrumentListing_DescriptionsEntry$json,
    InstrumentListing_LabelsEntry$json,
    InstrumentListing_MetadataEntry$json
  ],
  '8': [
    {'1': 'instrument'},
    {'1': 'venue'},
  ],
};

@$core.Deprecated('Use instrumentListingDescriptor instead')
const InstrumentListing_DisplayNamesEntry$json = {
  '1': 'DisplayNamesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use instrumentListingDescriptor instead')
const InstrumentListing_DescriptionsEntry$json = {
  '1': 'DescriptionsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use instrumentListingDescriptor instead')
const InstrumentListing_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use instrumentListingDescriptor instead')
const InstrumentListing_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `InstrumentListing`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List instrumentListingDescriptor = $convert.base64Decode(
    'ChFJbnN0cnVtZW50TGlzdGluZxIQCgNpaWQYASABKAlSA2lpZBJbChFsb2NhbF9pZGVudGlmaW'
    'VycxgCIAMoCzIuLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuRmluSWRlbnRpZmll'
    'clIQbG9jYWxJZGVudGlmaWVycxInCg5pbnN0cnVtZW50X2lpZBgEIAEoCUgAUg1pbnN0cnVtZW'
    '50SWlkElQKDmluc3RydW1lbnRfb2JqGAUgASgLMisucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRh'
    'Z2VudC52MS5JbnN0cnVtZW50SABSDWluc3RydW1lbnRPYmoSHQoJdmVudWVfaWlkGAYgASgJSA'
    'FSCHZlbnVlSWlkEkUKCXZlbnVlX29iahgHIAEoCzImLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0'
    'YWdlbnQudjEuVmVudWVIAVIIdmVudWVPYmoSSAoKbGlzdGluZ19kdBgIIAEoCzIpLnFvbWV0Lm'
    'Fnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuRGF0ZVRpbWVSCWxpc3RpbmdEdBJVChFlZmZlY3Rp'
    'dmVfZnJvbV9kdBgJIAEoCzIpLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuRGF0ZV'
    'RpbWVSD2VmZmVjdGl2ZUZyb21EdBJRCg9lZmZlY3RpdmVfdG9fZHQYCiABKAsyKS5xb21ldC5h'
    'Z29yYS5kYWVtb25zLnBydGFnZW50LnYxLkRhdGVUaW1lUg1lZmZlY3RpdmVUb0R0ElQKBnN0YX'
    'R1cxgLIAEoDjI8LnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuSW5zdHJ1bWVudExp'
    'c3RpbmdTdGF0dXNFbnVtUgZzdGF0dXMSGQoIbG90X3NpemUYDCABKAlSB2xvdFNpemUSGwoJdG'
    'lja19zaXplGA0gASgJUgh0aWNrU2l6ZRIaCghjdXJyZW5jeRgOIAEoCVIIY3VycmVuY3kSaQoN'
    'ZGlzcGxheV9uYW1lcxhlIAMoCzJELnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuSW'
    '5zdHJ1bWVudExpc3RpbmcuRGlzcGxheU5hbWVzRW50cnlSDGRpc3BsYXlOYW1lcxJoCgxkZXNj'
    'cmlwdGlvbnMYZiADKAsyRC5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkluc3RydW'
    '1lbnRMaXN0aW5nLkRlc2NyaXB0aW9uc0VudHJ5UgxkZXNjcmlwdGlvbnMSVgoGbGFiZWxzGGcg'
    'AygLMj4ucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5JbnN0cnVtZW50TGlzdGluZy'
    '5MYWJlbHNFbnRyeVIGbGFiZWxzEhIKBHRhZ3MYaCADKAlSBHRhZ3MSXAoIbWV0YWRhdGEYaSAD'
    'KAsyQC5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkluc3RydW1lbnRMaXN0aW5nLk'
    '1ldGFkYXRhRW50cnlSCG1ldGFkYXRhGj8KEURpc3BsYXlOYW1lc0VudHJ5EhAKA2tleRgBIAEo'
    'CVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAEaPwoRRGVzY3JpcHRpb25zRW50cnkSEA'
    'oDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4ARo5CgtMYWJlbHNFbnRy'
    'eRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBGjsKDU1ldGFkYX'
    'RhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AUIMCgpp'
    'bnN0cnVtZW50QgcKBXZlbnVl');

@$core.Deprecated('Use venueDurationDescriptor instead')
const VenueDuration$json = {
  '1': 'VenueDuration',
  '2': [
    {
      '1': 'duration',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Duration',
      '10': 'duration'
    },
    {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.VenueStatus',
      '10': 'status'
    },
    {'1': 'metadata', '3': 3, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'comments', '3': 4, '4': 3, '5': 9, '10': 'comments'},
  ],
};

/// Descriptor for `VenueDuration`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List venueDurationDescriptor = $convert.base64Decode(
    'Cg1WZW51ZUR1cmF0aW9uEkUKCGR1cmF0aW9uGAEgASgLMikucW9tZXQuYWdvcmEuZGFlbW9ucy'
    '5wcnRhZ2VudC52MS5EdXJhdGlvblIIZHVyYXRpb24SRAoGc3RhdHVzGAIgASgOMiwucW9tZXQu'
    'YWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5WZW51ZVN0YXR1c1IGc3RhdHVzEhoKCG1ldGFkYX'
    'RhGAMgASgJUghtZXRhZGF0YRIaCghjb21tZW50cxgEIAMoCVIIY29tbWVudHM=');

@$core.Deprecated('Use venueCalendarDescriptor instead')
const VenueCalendar$json = {
  '1': 'VenueCalendar',
  '2': [
    {'1': 'venue_iid', '3': 1, '4': 1, '5': 9, '10': 'venueIid'},
    {
      '1': 'daily_open',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'dailyOpen'
    },
    {
      '1': 'daily_close',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'dailyClose'
    },
    {
      '1': 'calendar',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.VenueDuration',
      '10': 'calendar'
    },
  ],
};

/// Descriptor for `VenueCalendar`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List venueCalendarDescriptor = $convert.base64Decode(
    'Cg1WZW51ZUNhbGVuZGFyEhsKCXZlbnVlX2lpZBgBIAEoCVIIdmVudWVJaWQSRAoKZGFpbHlfb3'
    'BlbhgCIAEoCzIlLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuVGltZVIJZGFpbHlP'
    'cGVuEkYKC2RhaWx5X2Nsb3NlGAMgASgLMiUucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC'
    '52MS5UaW1lUgpkYWlseUNsb3NlEkoKCGNhbGVuZGFyGAQgAygLMi4ucW9tZXQuYWdvcmEuZGFl'
    'bW9ucy5wcnRhZ2VudC52MS5WZW51ZUR1cmF0aW9uUghjYWxlbmRhcg==');

@$core.Deprecated('Use orderDescriptor instead')
const Order$json = {
  '1': 'Order',
  '2': [
    {'1': 'order_id', '3': 1, '4': 1, '5': 9, '10': 'orderId'},
    {'1': 'order_hash', '3': 2, '4': 1, '5': 9, '10': 'orderHash'},
    {'1': 'participant_iid', '3': 3, '4': 1, '5': 9, '10': 'participantIid'},
    {
      '1': 'participant_order_id',
      '3': 4,
      '4': 1,
      '5': 9,
      '10': 'participantOrderId'
    },
    {
      '1': 'participant_account_iid',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'participantAccountIid'
    },
    {
      '1': 'investor_account_iid',
      '3': 6,
      '4': 1,
      '5': 9,
      '10': 'investorAccountIid'
    },
    {
      '1': 'executor_account_iid',
      '3': 7,
      '4': 1,
      '5': 9,
      '10': 'executorAccountIid'
    },
    {'1': 'order_type', '3': 8, '4': 1, '5': 9, '10': 'orderType'},
    {
      '1': 'side',
      '3': 9,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.OrderSide',
      '10': 'side'
    },
    {'1': 'symbol', '3': 10, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'currency', '3': 11, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'quantity', '3': 12, '4': 1, '5': 9, '10': 'quantity'},
    {
      '1': 'remaining_quantity',
      '3': 13,
      '4': 1,
      '5': 9,
      '10': 'remainingQuantity'
    },
    {'1': 'price', '3': 14, '4': 1, '5': 9, '10': 'price'},
    {'1': 'volume', '3': 15, '4': 1, '5': 9, '10': 'volume'},
    {'1': 'remaining_volume', '3': 16, '4': 1, '5': 9, '10': 'remainingVolume'},
    {'1': 'slippage', '3': 17, '4': 1, '5': 9, '10': 'slippage'},
    {'1': 'time_in_force', '3': 18, '4': 1, '5': 9, '10': 'timeInForce'},
    {'1': 'create_timestamp', '3': 19, '4': 1, '5': 9, '10': 'createTimestamp'},
    {
      '1': 'effective_timestamp',
      '3': 20,
      '4': 1,
      '5': 9,
      '10': 'effectiveTimestamp'
    },
    {'1': 'expire_timestamp', '3': 21, '4': 1, '5': 9, '10': 'expireTimestamp'},
    {'1': 'is_offer', '3': 22, '4': 1, '5': 8, '10': 'isOffer'},
    {
      '1': 'is_directly_fillable',
      '3': 23,
      '4': 1,
      '5': 8,
      '10': 'isDirectlyFillable'
    },
    {'1': 'is_bid', '3': 24, '4': 1, '5': 8, '10': 'isBid'},
    {'1': 'is_filled', '3': 25, '4': 1, '5': 8, '10': 'isFilled'},
    {'1': 'is_cancelled', '3': 26, '4': 1, '5': 8, '10': 'isCancelled'},
    {'1': 'is_expired', '3': 27, '4': 1, '5': 8, '10': 'isExpired'},
    {'1': 'creator_address', '3': 28, '4': 1, '5': 9, '10': 'creatorAddress'},
    {'1': 'trezor_stash_id', '3': 29, '4': 1, '5': 9, '10': 'trezorStashId'},
    {'1': 'offer_ids', '3': 30, '4': 1, '5': 9, '10': 'offerIds'},
    {
      '1': 'parent_direct_order_id',
      '3': 31,
      '4': 1,
      '5': 9,
      '10': 'parentDirectOrderId'
    },
    {'1': 'alarm_abi', '3': 32, '4': 1, '5': 9, '10': 'alarmAbi'},
    {'1': 'alarm_data', '3': 33, '4': 1, '5': 9, '10': 'alarmData'},
    {'1': 'data', '3': 34, '4': 1, '5': 9, '10': 'data'},
    {'1': 'data_encoding', '3': 35, '4': 1, '5': 9, '10': 'dataEncoding'},
    {'1': 'participant_data', '3': 36, '4': 1, '5': 9, '10': 'participantData'},
  ],
};

/// Descriptor for `Order`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List orderDescriptor = $convert.base64Decode(
    'CgVPcmRlchIZCghvcmRlcl9pZBgBIAEoCVIHb3JkZXJJZBIdCgpvcmRlcl9oYXNoGAIgASgJUg'
    'lvcmRlckhhc2gSJwoPcGFydGljaXBhbnRfaWlkGAMgASgJUg5wYXJ0aWNpcGFudElpZBIwChRw'
    'YXJ0aWNpcGFudF9vcmRlcl9pZBgEIAEoCVIScGFydGljaXBhbnRPcmRlcklkEjYKF3BhcnRpY2'
    'lwYW50X2FjY291bnRfaWlkGAUgASgJUhVwYXJ0aWNpcGFudEFjY291bnRJaWQSMAoUaW52ZXN0'
    'b3JfYWNjb3VudF9paWQYBiABKAlSEmludmVzdG9yQWNjb3VudElpZBIwChRleGVjdXRvcl9hY2'
    'NvdW50X2lpZBgHIAEoCVISZXhlY3V0b3JBY2NvdW50SWlkEh0KCm9yZGVyX3R5cGUYCCABKAlS'
    'CW9yZGVyVHlwZRI+CgRzaWRlGAkgASgOMioucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC'
    '52MS5PcmRlclNpZGVSBHNpZGUSFgoGc3ltYm9sGAogASgJUgZzeW1ib2wSGgoIY3VycmVuY3kY'
    'CyABKAlSCGN1cnJlbmN5EhoKCHF1YW50aXR5GAwgASgJUghxdWFudGl0eRItChJyZW1haW5pbm'
    'dfcXVhbnRpdHkYDSABKAlSEXJlbWFpbmluZ1F1YW50aXR5EhQKBXByaWNlGA4gASgJUgVwcmlj'
    'ZRIWCgZ2b2x1bWUYDyABKAlSBnZvbHVtZRIpChByZW1haW5pbmdfdm9sdW1lGBAgASgJUg9yZW'
    '1haW5pbmdWb2x1bWUSGgoIc2xpcHBhZ2UYESABKAlSCHNsaXBwYWdlEiIKDXRpbWVfaW5fZm9y'
    'Y2UYEiABKAlSC3RpbWVJbkZvcmNlEikKEGNyZWF0ZV90aW1lc3RhbXAYEyABKAlSD2NyZWF0ZV'
    'RpbWVzdGFtcBIvChNlZmZlY3RpdmVfdGltZXN0YW1wGBQgASgJUhJlZmZlY3RpdmVUaW1lc3Rh'
    'bXASKQoQZXhwaXJlX3RpbWVzdGFtcBgVIAEoCVIPZXhwaXJlVGltZXN0YW1wEhkKCGlzX29mZm'
    'VyGBYgASgIUgdpc09mZmVyEjAKFGlzX2RpcmVjdGx5X2ZpbGxhYmxlGBcgASgIUhJpc0RpcmVj'
    'dGx5RmlsbGFibGUSFQoGaXNfYmlkGBggASgIUgVpc0JpZBIbCglpc19maWxsZWQYGSABKAhSCG'
    'lzRmlsbGVkEiEKDGlzX2NhbmNlbGxlZBgaIAEoCFILaXNDYW5jZWxsZWQSHQoKaXNfZXhwaXJl'
    'ZBgbIAEoCFIJaXNFeHBpcmVkEicKD2NyZWF0b3JfYWRkcmVzcxgcIAEoCVIOY3JlYXRvckFkZH'
    'Jlc3MSJgoPdHJlem9yX3N0YXNoX2lkGB0gASgJUg10cmV6b3JTdGFzaElkEhsKCW9mZmVyX2lk'
    'cxgeIAEoCVIIb2ZmZXJJZHMSMwoWcGFyZW50X2RpcmVjdF9vcmRlcl9pZBgfIAEoCVITcGFyZW'
    '50RGlyZWN0T3JkZXJJZBIbCglhbGFybV9hYmkYICABKAlSCGFsYXJtQWJpEh0KCmFsYXJtX2Rh'
    'dGEYISABKAlSCWFsYXJtRGF0YRISCgRkYXRhGCIgASgJUgRkYXRhEiMKDWRhdGFfZW5jb2Rpbm'
    'cYIyABKAlSDGRhdGFFbmNvZGluZxIpChBwYXJ0aWNpcGFudF9kYXRhGCQgASgJUg9wYXJ0aWNp'
    'cGFudERhdGE=');

@$core.Deprecated('Use tradeDescriptor instead')
const Trade$json = {
  '1': 'Trade',
  '2': [
    {'1': 'trade_id', '3': 1, '4': 1, '5': 9, '10': 'tradeId'},
    {'1': 'trade_hash', '3': 2, '4': 1, '5': 9, '10': 'tradeHash'},
    {'1': 'timestamp', '3': 3, '4': 1, '5': 9, '10': 'timestamp'},
    {'1': 'creator_address', '3': 4, '4': 1, '5': 9, '10': 'creatorAddress'},
    {'1': 'trade_type', '3': 5, '4': 1, '5': 9, '10': 'tradeType'},
    {'1': 'is_buy', '3': 6, '4': 1, '5': 8, '10': 'isBuy'},
    {'1': 'bid_order_id', '3': 7, '4': 1, '5': 9, '10': 'bidOrderId'},
    {'1': 'ask_order_id', '3': 8, '4': 1, '5': 9, '10': 'askOrderId'},
    {'1': 'quantity', '3': 9, '4': 1, '5': 9, '10': 'quantity'},
    {'1': 'price', '3': 10, '4': 1, '5': 9, '10': 'price'},
    {'1': 'volume', '3': 11, '4': 1, '5': 9, '10': 'volume'},
    {'1': 'bid_fee', '3': 12, '4': 1, '5': 9, '10': 'bidFee'},
    {'1': 'ask_fee', '3': 13, '4': 1, '5': 9, '10': 'askFee'},
    {'1': 'data_abi', '3': 14, '4': 1, '5': 9, '10': 'dataAbi'},
    {'1': 'data', '3': 15, '4': 1, '5': 9, '10': 'data'},
  ],
};

/// Descriptor for `Trade`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tradeDescriptor = $convert.base64Decode(
    'CgVUcmFkZRIZCgh0cmFkZV9pZBgBIAEoCVIHdHJhZGVJZBIdCgp0cmFkZV9oYXNoGAIgASgJUg'
    'l0cmFkZUhhc2gSHAoJdGltZXN0YW1wGAMgASgJUgl0aW1lc3RhbXASJwoPY3JlYXRvcl9hZGRy'
    'ZXNzGAQgASgJUg5jcmVhdG9yQWRkcmVzcxIdCgp0cmFkZV90eXBlGAUgASgJUgl0cmFkZVR5cG'
    'USFQoGaXNfYnV5GAYgASgIUgVpc0J1eRIgCgxiaWRfb3JkZXJfaWQYByABKAlSCmJpZE9yZGVy'
    'SWQSIAoMYXNrX29yZGVyX2lkGAggASgJUgphc2tPcmRlcklkEhoKCHF1YW50aXR5GAkgASgJUg'
    'hxdWFudGl0eRIUCgVwcmljZRgKIAEoCVIFcHJpY2USFgoGdm9sdW1lGAsgASgJUgZ2b2x1bWUS'
    'FwoHYmlkX2ZlZRgMIAEoCVIGYmlkRmVlEhcKB2Fza19mZWUYDSABKAlSBmFza0ZlZRIZCghkYX'
    'RhX2FiaRgOIAEoCVIHZGF0YUFiaRISCgRkYXRhGA8gASgJUgRkYXRh');

@$core.Deprecated('Use settlementDescriptor instead')
const Settlement$json = {
  '1': 'Settlement',
  '2': [
    {'1': 'settlement_id', '3': 1, '4': 1, '5': 9, '10': 'settlementId'},
    {'1': 'settlement_hash', '3': 2, '4': 1, '5': 9, '10': 'settlementHash'},
    {'1': 'timestamp', '3': 3, '4': 1, '5': 9, '10': 'timestamp'},
    {'1': 'trade_id', '3': 4, '4': 1, '5': 9, '10': 'tradeId'},
    {'1': 'trade_hash', '3': 5, '4': 1, '5': 9, '10': 'tradeHash'},
    {
      '1': 'confirmation_status',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.ConfirmationStatus',
      '10': 'confirmationStatus'
    },
    {'1': 'settlement_type', '3': 7, '4': 1, '5': 9, '10': 'settlementType'},
    {'1': 'buyer_account', '3': 8, '4': 1, '5': 9, '10': 'buyerAccount'},
    {'1': 'seller_account', '3': 9, '4': 1, '5': 9, '10': 'sellerAccount'},
    {
      '1': 'asset_transferred',
      '3': 10,
      '4': 1,
      '5': 9,
      '10': 'assetTransferred'
    },
    {
      '1': 'amount_transferred',
      '3': 11,
      '4': 1,
      '5': 9,
      '10': 'amountTransferred'
    },
    {
      '1': 'currency_transferred',
      '3': 12,
      '4': 1,
      '5': 9,
      '10': 'currencyTransferred'
    },
    {'1': 'currency_amount', '3': 13, '4': 1, '5': 9, '10': 'currencyAmount'},
    {'1': 'ledger_id', '3': 14, '4': 1, '5': 9, '10': 'ledgerId'},
    {'1': 'vault_address', '3': 15, '4': 1, '5': 9, '10': 'vaultAddress'},
    {'1': 'reserve_id', '3': 16, '4': 1, '5': 9, '10': 'reserveId'},
    {'1': 'failure_reason', '3': 17, '4': 1, '5': 9, '10': 'failureReason'},
    {'1': 'data', '3': 18, '4': 1, '5': 9, '10': 'data'},
  ],
};

/// Descriptor for `Settlement`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List settlementDescriptor = $convert.base64Decode(
    'CgpTZXR0bGVtZW50EiMKDXNldHRsZW1lbnRfaWQYASABKAlSDHNldHRsZW1lbnRJZBInCg9zZX'
    'R0bGVtZW50X2hhc2gYAiABKAlSDnNldHRsZW1lbnRIYXNoEhwKCXRpbWVzdGFtcBgDIAEoCVIJ'
    'dGltZXN0YW1wEhkKCHRyYWRlX2lkGAQgASgJUgd0cmFkZUlkEh0KCnRyYWRlX2hhc2gYBSABKA'
    'lSCXRyYWRlSGFzaBJkChNjb25maXJtYXRpb25fc3RhdHVzGAYgASgOMjMucW9tZXQuYWdvcmEu'
    'ZGFlbW9ucy5wcnRhZ2VudC52MS5Db25maXJtYXRpb25TdGF0dXNSEmNvbmZpcm1hdGlvblN0YX'
    'R1cxInCg9zZXR0bGVtZW50X3R5cGUYByABKAlSDnNldHRsZW1lbnRUeXBlEiMKDWJ1eWVyX2Fj'
    'Y291bnQYCCABKAlSDGJ1eWVyQWNjb3VudBIlCg5zZWxsZXJfYWNjb3VudBgJIAEoCVINc2VsbG'
    'VyQWNjb3VudBIrChFhc3NldF90cmFuc2ZlcnJlZBgKIAEoCVIQYXNzZXRUcmFuc2ZlcnJlZBIt'
    'ChJhbW91bnRfdHJhbnNmZXJyZWQYCyABKAlSEWFtb3VudFRyYW5zZmVycmVkEjEKFGN1cnJlbm'
    'N5X3RyYW5zZmVycmVkGAwgASgJUhNjdXJyZW5jeVRyYW5zZmVycmVkEicKD2N1cnJlbmN5X2Ft'
    'b3VudBgNIAEoCVIOY3VycmVuY3lBbW91bnQSGwoJbGVkZ2VyX2lkGA4gASgJUghsZWRnZXJJZB'
    'IjCg12YXVsdF9hZGRyZXNzGA8gASgJUgx2YXVsdEFkZHJlc3MSHQoKcmVzZXJ2ZV9pZBgQIAEo'
    'CVIJcmVzZXJ2ZUlkEiUKDmZhaWx1cmVfcmVhc29uGBEgASgJUg1mYWlsdXJlUmVhc29uEhIKBG'
    'RhdGEYEiABKAlSBGRhdGE=');

@$core.Deprecated('Use orderEventDescriptor instead')
const OrderEvent$json = {
  '1': 'OrderEvent',
  '2': [
    {'1': 'order_event_id', '3': 1, '4': 1, '5': 9, '10': 'orderEventId'},
    {'1': 'order_event_hash', '3': 2, '4': 1, '5': 9, '10': 'orderEventHash'},
    {
      '1': 'order_event_timestamp',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'orderEventTimestamp'
    },
    {'1': 'order_event_type', '3': 4, '4': 1, '5': 9, '10': 'orderEventType'},
    {
      '1': 'order_event_version',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'orderEventVersion'
    },
    {
      '1': 'order',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Order',
      '10': 'order'
    },
    {
      '1': 'other_order',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Order',
      '10': 'otherOrder'
    },
    {
      '1': 'trade',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Trade',
      '10': 'trade'
    },
    {'1': 'chain_id', '3': 9, '4': 1, '5': 9, '10': 'chainId'},
    {'1': 'chain_name', '3': 10, '4': 1, '5': 9, '10': 'chainName'},
    {'1': 'engine_address', '3': 11, '4': 1, '5': 9, '10': 'engineAddress'},
    {'1': 'index_timestamp', '3': 12, '4': 1, '5': 9, '10': 'indexTimestamp'},
    {
      '1': 'index_block_timestamp',
      '3': 13,
      '4': 1,
      '5': 9,
      '10': 'indexBlockTimestamp'
    },
    {
      '1': 'index_block_number',
      '3': 14,
      '4': 1,
      '5': 9,
      '10': 'indexBlockNumber'
    },
    {'1': 'index_tx_hash', '3': 15, '4': 1, '5': 9, '10': 'indexTxHash'},
    {'1': 'index_tx_log_idx', '3': 16, '4': 1, '5': 3, '10': 'indexTxLogIdx'},
    {'1': 'pair_id', '3': 17, '4': 1, '5': 9, '10': 'pairId'},
    {
      '1': 'pair_base_token_symbol',
      '3': 18,
      '4': 1,
      '5': 9,
      '10': 'pairBaseTokenSymbol'
    },
    {
      '1': 'pair_quote_token_symbol',
      '3': 19,
      '4': 1,
      '5': 9,
      '10': 'pairQuoteTokenSymbol'
    },
    {'1': 'command_id', '3': 20, '4': 1, '5': 9, '10': 'commandId'},
    {
      '1': 'command_request_id',
      '3': 21,
      '4': 1,
      '5': 9,
      '10': 'commandRequestId'
    },
    {
      '1': 'command_timestamp',
      '3': 22,
      '4': 1,
      '5': 9,
      '10': 'commandTimestamp'
    },
    {'1': 'command_origin', '3': 23, '4': 1, '5': 9, '10': 'commandOrigin'},
    {
      '1': 'command_participant_id',
      '3': 24,
      '4': 1,
      '5': 9,
      '10': 'commandParticipantId'
    },
    {
      '1': 'command_operation',
      '3': 25,
      '4': 1,
      '5': 9,
      '10': 'commandOperation'
    },
    {'1': 'order_event_data', '3': 26, '4': 1, '5': 9, '10': 'orderEventData'},
  ],
};

/// Descriptor for `OrderEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List orderEventDescriptor = $convert.base64Decode(
    'CgpPcmRlckV2ZW50EiQKDm9yZGVyX2V2ZW50X2lkGAEgASgJUgxvcmRlckV2ZW50SWQSKAoQb3'
    'JkZXJfZXZlbnRfaGFzaBgCIAEoCVIOb3JkZXJFdmVudEhhc2gSMgoVb3JkZXJfZXZlbnRfdGlt'
    'ZXN0YW1wGAMgASgJUhNvcmRlckV2ZW50VGltZXN0YW1wEigKEG9yZGVyX2V2ZW50X3R5cGUYBC'
    'ABKAlSDm9yZGVyRXZlbnRUeXBlEi4KE29yZGVyX2V2ZW50X3ZlcnNpb24YBSABKAlSEW9yZGVy'
    'RXZlbnRWZXJzaW9uEjwKBW9yZGVyGAYgASgLMiYucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2'
    'VudC52MS5PcmRlclIFb3JkZXISRwoLb3RoZXJfb3JkZXIYByABKAsyJi5xb21ldC5hZ29yYS5k'
    'YWVtb25zLnBydGFnZW50LnYxLk9yZGVyUgpvdGhlck9yZGVyEjwKBXRyYWRlGAggASgLMiYucW'
    '9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5UcmFkZVIFdHJhZGUSGQoIY2hhaW5faWQY'
    'CSABKAlSB2NoYWluSWQSHQoKY2hhaW5fbmFtZRgKIAEoCVIJY2hhaW5OYW1lEiUKDmVuZ2luZV'
    '9hZGRyZXNzGAsgASgJUg1lbmdpbmVBZGRyZXNzEicKD2luZGV4X3RpbWVzdGFtcBgMIAEoCVIO'
    'aW5kZXhUaW1lc3RhbXASMgoVaW5kZXhfYmxvY2tfdGltZXN0YW1wGA0gASgJUhNpbmRleEJsb2'
    'NrVGltZXN0YW1wEiwKEmluZGV4X2Jsb2NrX251bWJlchgOIAEoCVIQaW5kZXhCbG9ja051bWJl'
    'chIiCg1pbmRleF90eF9oYXNoGA8gASgJUgtpbmRleFR4SGFzaBInChBpbmRleF90eF9sb2dfaW'
    'R4GBAgASgDUg1pbmRleFR4TG9nSWR4EhcKB3BhaXJfaWQYESABKAlSBnBhaXJJZBIzChZwYWly'
    'X2Jhc2VfdG9rZW5fc3ltYm9sGBIgASgJUhNwYWlyQmFzZVRva2VuU3ltYm9sEjUKF3BhaXJfcX'
    'VvdGVfdG9rZW5fc3ltYm9sGBMgASgJUhRwYWlyUXVvdGVUb2tlblN5bWJvbBIdCgpjb21tYW5k'
    'X2lkGBQgASgJUgljb21tYW5kSWQSLAoSY29tbWFuZF9yZXF1ZXN0X2lkGBUgASgJUhBjb21tYW'
    '5kUmVxdWVzdElkEisKEWNvbW1hbmRfdGltZXN0YW1wGBYgASgJUhBjb21tYW5kVGltZXN0YW1w'
    'EiUKDmNvbW1hbmRfb3JpZ2luGBcgASgJUg1jb21tYW5kT3JpZ2luEjQKFmNvbW1hbmRfcGFydG'
    'ljaXBhbnRfaWQYGCABKAlSFGNvbW1hbmRQYXJ0aWNpcGFudElkEisKEWNvbW1hbmRfb3BlcmF0'
    'aW9uGBkgASgJUhBjb21tYW5kT3BlcmF0aW9uEigKEG9yZGVyX2V2ZW50X2RhdGEYGiABKAlSDm'
    '9yZGVyRXZlbnREYXRh');

@$core.Deprecated('Use transactionDescriptor instead')
const Transaction$json = {
  '1': 'Transaction',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'transaction_hash', '3': 2, '4': 1, '5': 9, '10': 'transactionHash'},
    {
      '1': 'timestamp',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'timestamp'
    },
    {
      '1': 'type',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.TransactionTypeEnum',
      '10': 'type'
    },
    {'1': 'operation', '3': 5, '4': 1, '5': 9, '10': 'operation'},
    {'1': 'account_iid', '3': 6, '4': 1, '5': 9, '10': 'accountIid'},
    {'1': 'from_account_iid', '3': 7, '4': 1, '5': 9, '10': 'fromAccountIid'},
    {'1': 'to_account_iid', '3': 8, '4': 1, '5': 9, '10': 'toAccountIid'},
    {'1': 'from_reserve_id', '3': 9, '4': 1, '5': 9, '10': 'fromReserveId'},
    {'1': 'to_reserve_id', '3': 10, '4': 1, '5': 9, '10': 'toReserveId'},
    {'1': 'from_stash', '3': 11, '4': 1, '5': 9, '10': 'fromStash'},
    {'1': 'to_stash', '3': 12, '4': 1, '5': 9, '10': 'toStash'},
    {'1': 'asset_iid', '3': 13, '4': 1, '5': 9, '10': 'assetIid'},
    {'1': 'amount', '3': 14, '4': 1, '5': 9, '10': 'amount'},
    {'1': 'reference_id', '3': 15, '4': 1, '5': 9, '10': 'referenceId'},
    {'1': 'reference_type', '3': 16, '4': 1, '5': 9, '10': 'referenceType'},
    {
      '1': 'display_names',
      '3': 101,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Transaction.DisplayNamesEntry',
      '10': 'displayNames'
    },
    {
      '1': 'descriptions',
      '3': 102,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Transaction.DescriptionsEntry',
      '10': 'descriptions'
    },
    {
      '1': 'labels',
      '3': 103,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Transaction.LabelsEntry',
      '10': 'labels'
    },
    {'1': 'tags', '3': 104, '4': 3, '5': 9, '10': 'tags'},
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Transaction.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [
    Transaction_DisplayNamesEntry$json,
    Transaction_DescriptionsEntry$json,
    Transaction_LabelsEntry$json,
    Transaction_MetadataEntry$json
  ],
};

@$core.Deprecated('Use transactionDescriptor instead')
const Transaction_DisplayNamesEntry$json = {
  '1': 'DisplayNamesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use transactionDescriptor instead')
const Transaction_DescriptionsEntry$json = {
  '1': 'DescriptionsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use transactionDescriptor instead')
const Transaction_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use transactionDescriptor instead')
const Transaction_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Transaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionDescriptor = $convert.base64Decode(
    'CgtUcmFuc2FjdGlvbhIlCg50cmFuc2FjdGlvbl9pZBgBIAEoCVINdHJhbnNhY3Rpb25JZBIpCh'
    'B0cmFuc2FjdGlvbl9oYXNoGAIgASgJUg90cmFuc2FjdGlvbkhhc2gSQwoJdGltZXN0YW1wGAMg'
    'ASgLMiUucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5UaW1lUgl0aW1lc3RhbXASSA'
    'oEdHlwZRgEIAEoDjI0LnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuVHJhbnNhY3Rp'
    'b25UeXBlRW51bVIEdHlwZRIcCglvcGVyYXRpb24YBSABKAlSCW9wZXJhdGlvbhIfCgthY2NvdW'
    '50X2lpZBgGIAEoCVIKYWNjb3VudElpZBIoChBmcm9tX2FjY291bnRfaWlkGAcgASgJUg5mcm9t'
    'QWNjb3VudElpZBIkCg50b19hY2NvdW50X2lpZBgIIAEoCVIMdG9BY2NvdW50SWlkEiYKD2Zyb2'
    '1fcmVzZXJ2ZV9pZBgJIAEoCVINZnJvbVJlc2VydmVJZBIiCg10b19yZXNlcnZlX2lkGAogASgJ'
    'Ugt0b1Jlc2VydmVJZBIdCgpmcm9tX3N0YXNoGAsgASgJUglmcm9tU3Rhc2gSGQoIdG9fc3Rhc2'
    'gYDCABKAlSB3RvU3Rhc2gSGwoJYXNzZXRfaWlkGA0gASgJUghhc3NldElpZBIWCgZhbW91bnQY'
    'DiABKAlSBmFtb3VudBIhCgxyZWZlcmVuY2VfaWQYDyABKAlSC3JlZmVyZW5jZUlkEiUKDnJlZm'
    'VyZW5jZV90eXBlGBAgASgJUg1yZWZlcmVuY2VUeXBlEmMKDWRpc3BsYXlfbmFtZXMYZSADKAsy'
    'Pi5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLlRyYW5zYWN0aW9uLkRpc3BsYXlOYW'
    '1lc0VudHJ5UgxkaXNwbGF5TmFtZXMSYgoMZGVzY3JpcHRpb25zGGYgAygLMj4ucW9tZXQuYWdv'
    'cmEuZGFlbW9ucy5wcnRhZ2VudC52MS5UcmFuc2FjdGlvbi5EZXNjcmlwdGlvbnNFbnRyeVIMZG'
    'VzY3JpcHRpb25zElAKBmxhYmVscxhnIAMoCzI4LnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdl'
    'bnQudjEuVHJhbnNhY3Rpb24uTGFiZWxzRW50cnlSBmxhYmVscxISCgR0YWdzGGggAygJUgR0YW'
    'dzElYKCG1ldGFkYXRhGGkgAygLMjoucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5U'
    'cmFuc2FjdGlvbi5NZXRhZGF0YUVudHJ5UghtZXRhZGF0YRo/ChFEaXNwbGF5TmFtZXNFbnRyeR'
    'IQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBGj8KEURlc2NyaXB0'
    'aW9uc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAEaOQ'
    'oLTGFiZWxzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4'
    'ARo7Cg1NZXRhZGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YW'
    'x1ZToCOAE=');
