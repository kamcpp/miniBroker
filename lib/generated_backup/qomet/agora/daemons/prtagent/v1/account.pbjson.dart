// This is a generated file - do not edit.
//
// Generated from qomet/agora/daemons/prtagent/v1/account.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use transactionTypeDescriptor instead')
const TransactionType$json = {
  '1': 'TransactionType',
  '2': [
    {'1': 'TRANSACTION_TYPE__UNKNOWN', '2': 0},
    {'1': 'TRANSACTION_TYPE__DEPOSIT_CASH', '2': 1},
    {'1': 'TRANSACTION_TYPE__DEPOSIT_ASSET', '2': 2},
    {'1': 'TRANSACTION_TYPE__WITHDRAW_CASH', '2': 3},
    {'1': 'TRANSACTION_TYPE__WITHDRAW_ASSET', '2': 4},
    {'1': 'TRANSACTION_TYPE__TRADE_BUY', '2': 5},
    {'1': 'TRANSACTION_TYPE__TRADE_SELL', '2': 6},
    {'1': 'TRANSACTION_TYPE__FEE', '2': 7},
    {'1': 'TRANSACTION_TYPE__SETTLEMENT', '2': 8},
    {'1': 'TRANSACTION_TYPE__TRANSFER_IN', '2': 9},
    {'1': 'TRANSACTION_TYPE__TRANSFER_OUT', '2': 10},
  ],
};

/// Descriptor for `TransactionType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List transactionTypeDescriptor = $convert.base64Decode(
    'Cg9UcmFuc2FjdGlvblR5cGUSHQoZVFJBTlNBQ1RJT05fVFlQRV9fVU5LTk9XThAAEiIKHlRSQU'
    '5TQUNUSU9OX1RZUEVfX0RFUE9TSVRfQ0FTSBABEiMKH1RSQU5TQUNUSU9OX1RZUEVfX0RFUE9T'
    'SVRfQVNTRVQQAhIjCh9UUkFOU0FDVElPTl9UWVBFX19XSVRIRFJBV19DQVNIEAMSJAogVFJBTl'
    'NBQ1RJT05fVFlQRV9fV0lUSERSQVdfQVNTRVQQBBIfChtUUkFOU0FDVElPTl9UWVBFX19UUkFE'
    'RV9CVVkQBRIgChxUUkFOU0FDVElPTl9UWVBFX19UUkFERV9TRUxMEAYSGQoVVFJBTlNBQ1RJT0'
    '5fVFlQRV9fRkVFEAcSIAocVFJBTlNBQ1RJT05fVFlQRV9fU0VUVExFTUVOVBAIEiEKHVRSQU5T'
    'QUNUSU9OX1RZUEVfX1RSQU5TRkVSX0lOEAkSIgoeVFJBTlNBQ1RJT05fVFlQRV9fVFJBTlNGRV'
    'JfT1VUEAo=');

@$core.Deprecated('Use accountDescriptor instead')
const Account$json = {
  '1': 'Account',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'external_id', '3': 2, '4': 1, '5': 9, '10': 'externalId'},
    {'1': 'metadata', '3': 3, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `Account`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountDescriptor = $convert.base64Decode(
    'CgdBY2NvdW50Eg4KAmlkGAEgASgJUgJpZBIfCgtleHRlcm5hbF9pZBgCIAEoCVIKZXh0ZXJuYW'
    'xJZBIaCghtZXRhZGF0YRgDIAEoCVIIbWV0YWRhdGE=');

@$core.Deprecated('Use newAccountRequestDescriptor instead')
const NewAccountRequest$json = {
  '1': 'NewAccountRequest',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {
      '1': 'external_account_id',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'externalAccountId'
    },
    {'1': 'aux_data', '3': 3, '4': 1, '5': 9, '10': 'auxData'},
  ],
};

/// Descriptor for `NewAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List newAccountRequestDescriptor = $convert.base64Decode(
    'ChFOZXdBY2NvdW50UmVxdWVzdBIkCg5yZWZfcmVxdWVzdF9pZBgBIAEoCVIMcmVmUmVxdWVzdE'
    'lkEi4KE2V4dGVybmFsX2FjY291bnRfaWQYAiABKAlSEWV4dGVybmFsQWNjb3VudElkEhkKCGF1'
    'eF9kYXRhGAMgASgJUgdhdXhEYXRh');

@$core.Deprecated('Use newAccountResponseDescriptor instead')
const NewAccountResponse$json = {
  '1': 'NewAccountResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'new_account_id', '3': 2, '4': 1, '5': 9, '10': 'newAccountId'},
  ],
};

/// Descriptor for `NewAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List newAccountResponseDescriptor = $convert.base64Decode(
    'ChJOZXdBY2NvdW50UmVzcG9uc2USJAoOcmVmX3JlcXVlc3RfaWQYASABKAlSDHJlZlJlcXVlc3'
    'RJZBIkCg5uZXdfYWNjb3VudF9pZBgCIAEoCVIMbmV3QWNjb3VudElk');

@$core.Deprecated('Use getAccountInfoRequestDescriptor instead')
const GetAccountInfoRequest$json = {
  '1': 'GetAccountInfoRequest',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
  ],
};

/// Descriptor for `GetAccountInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountInfoRequestDescriptor = $convert.base64Decode(
    'ChVHZXRBY2NvdW50SW5mb1JlcXVlc3QSJAoOcmVmX3JlcXVlc3RfaWQYASABKAlSDHJlZlJlcX'
    'Vlc3RJZBIdCgphY2NvdW50X2lkGAIgASgJUglhY2NvdW50SWQ=');

@$core.Deprecated('Use getAccountInfoResponseDescriptor instead')
const GetAccountInfoResponse$json = {
  '1': 'GetAccountInfoResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {
      '1': 'account',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Account',
      '10': 'account'
    },
  ],
};

/// Descriptor for `GetAccountInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountInfoResponseDescriptor = $convert.base64Decode(
    'ChZHZXRBY2NvdW50SW5mb1Jlc3BvbnNlEiQKDnJlZl9yZXF1ZXN0X2lkGAEgASgJUgxyZWZSZX'
    'F1ZXN0SWQSQgoHYWNjb3VudBgCIAEoCzIoLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQu'
    'djEuQWNjb3VudFIHYWNjb3VudA==');

@$core.Deprecated('Use getAccountListRequestDescriptor instead')
const GetAccountListRequest$json = {
  '1': 'GetAccountListRequest',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {
      '1': 'pagination',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.PaginationParams',
      '10': 'pagination'
    },
  ],
};

/// Descriptor for `GetAccountListRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountListRequestDescriptor = $convert.base64Decode(
    'ChVHZXRBY2NvdW50TGlzdFJlcXVlc3QSJAoOcmVmX3JlcXVlc3RfaWQYASABKAlSDHJlZlJlcX'
    'Vlc3RJZBJRCgpwYWdpbmF0aW9uGAIgASgLMjEucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2Vu'
    'dC52MS5QYWdpbmF0aW9uUGFyYW1zUgpwYWdpbmF0aW9u');

@$core.Deprecated('Use getAccountListResponseDescriptor instead')
const GetAccountListResponse$json = {
  '1': 'GetAccountListResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {
      '1': 'pagination_info',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.PaginationInfo',
      '10': 'paginationInfo'
    },
    {
      '1': 'accounts',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Account',
      '10': 'accounts'
    },
  ],
};

/// Descriptor for `GetAccountListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountListResponseDescriptor = $convert.base64Decode(
    'ChZHZXRBY2NvdW50TGlzdFJlc3BvbnNlEiQKDnJlZl9yZXF1ZXN0X2lkGAEgASgJUgxyZWZSZX'
    'F1ZXN0SWQSWAoPcGFnaW5hdGlvbl9pbmZvGAIgASgLMi8ucW9tZXQuYWdvcmEuZGFlbW9ucy5w'
    'cnRhZ2VudC52MS5QYWdpbmF0aW9uSW5mb1IOcGFnaW5hdGlvbkluZm8SRAoIYWNjb3VudHMYAy'
    'ADKAsyKC5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkFjY291bnRSCGFjY291bnRz');

@$core.Deprecated('Use enableMarketForAccountRequestDescriptor instead')
const EnableMarketForAccountRequest$json = {
  '1': 'EnableMarketForAccountRequest',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'market_id', '3': 3, '4': 1, '5': 9, '10': 'marketId'},
    {'1': 'aux_data', '3': 4, '4': 1, '5': 9, '10': 'auxData'},
  ],
};

/// Descriptor for `EnableMarketForAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enableMarketForAccountRequestDescriptor =
    $convert.base64Decode(
        'Ch1FbmFibGVNYXJrZXRGb3JBY2NvdW50UmVxdWVzdBIkCg5yZWZfcmVxdWVzdF9pZBgBIAEoCV'
        'IMcmVmUmVxdWVzdElkEh0KCmFjY291bnRfaWQYAiABKAlSCWFjY291bnRJZBIbCgltYXJrZXRf'
        'aWQYAyABKAlSCG1hcmtldElkEhkKCGF1eF9kYXRhGAQgASgJUgdhdXhEYXRh');

@$core.Deprecated('Use enableMarketForAccountResponseDescriptor instead')
const EnableMarketForAccountResponse$json = {
  '1': 'EnableMarketForAccountResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
  ],
};

/// Descriptor for `EnableMarketForAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enableMarketForAccountResponseDescriptor =
    $convert.base64Decode(
        'Ch5FbmFibGVNYXJrZXRGb3JBY2NvdW50UmVzcG9uc2USJAoOcmVmX3JlcXVlc3RfaWQYASABKA'
        'lSDHJlZlJlcXVlc3RJZA==');

@$core.Deprecated('Use assetHoldingsDescriptor instead')
const AssetHoldings$json = {
  '1': 'AssetHoldings',
  '2': [
    {
      '1': 'balances',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.AssetHoldings.BalancesEntry',
      '10': 'balances'
    },
  ],
  '3': [AssetHoldings_BalancesEntry$json],
};

@$core.Deprecated('Use assetHoldingsDescriptor instead')
const AssetHoldings_BalancesEntry$json = {
  '1': 'BalancesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 3, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `AssetHoldings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List assetHoldingsDescriptor = $convert.base64Decode(
    'Cg1Bc3NldEhvbGRpbmdzElgKCGJhbGFuY2VzGAEgAygLMjwucW9tZXQuYWdvcmEuZGFlbW9ucy'
    '5wcnRhZ2VudC52MS5Bc3NldEhvbGRpbmdzLkJhbGFuY2VzRW50cnlSCGJhbGFuY2VzGjsKDUJh'
    'bGFuY2VzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKANSBXZhbHVlOgI4AQ'
    '==');

@$core.Deprecated('Use getAccountMarketPortfolioRequestDescriptor instead')
const GetAccountMarketPortfolioRequest$json = {
  '1': 'GetAccountMarketPortfolioRequest',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'market_id', '3': 3, '4': 1, '5': 9, '10': 'marketId'},
    {'1': 'asset_ids', '3': 4, '4': 3, '5': 9, '10': 'assetIds'},
  ],
};

/// Descriptor for `GetAccountMarketPortfolioRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountMarketPortfolioRequestDescriptor =
    $convert.base64Decode(
        'CiBHZXRBY2NvdW50TWFya2V0UG9ydGZvbGlvUmVxdWVzdBIkCg5yZWZfcmVxdWVzdF9pZBgBIA'
        'EoCVIMcmVmUmVxdWVzdElkEh0KCmFjY291bnRfaWQYAiABKAlSCWFjY291bnRJZBIbCgltYXJr'
        'ZXRfaWQYAyABKAlSCG1hcmtldElkEhsKCWFzc2V0X2lkcxgEIAMoCVIIYXNzZXRJZHM=');

@$core.Deprecated('Use getAccountMarketPortfolioResponseDescriptor instead')
const GetAccountMarketPortfolioResponse$json = {
  '1': 'GetAccountMarketPortfolioResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {
      '1': 'created_at',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'createdAt'
    },
    {
      '1': 'portfolio',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.AssetHoldings',
      '10': 'portfolio'
    },
  ],
};

/// Descriptor for `GetAccountMarketPortfolioResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountMarketPortfolioResponseDescriptor = $convert.base64Decode(
    'CiFHZXRBY2NvdW50TWFya2V0UG9ydGZvbGlvUmVzcG9uc2USJAoOcmVmX3JlcXVlc3RfaWQYAS'
    'ABKAlSDHJlZlJlcXVlc3RJZBJECgpjcmVhdGVkX2F0GAIgASgLMiUucW9tZXQuYWdvcmEuZGFl'
    'bW9ucy5wcnRhZ2VudC52MS5UaW1lUgljcmVhdGVkQXQSTAoJcG9ydGZvbGlvGAMgASgLMi4ucW'
    '9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5Bc3NldEhvbGRpbmdzUglwb3J0Zm9saW8=');

@$core.Deprecated('Use getAccountCashHoldingsRequestDescriptor instead')
const GetAccountCashHoldingsRequest$json = {
  '1': 'GetAccountCashHoldingsRequest',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'cash_asset_ids', '3': 3, '4': 3, '5': 9, '10': 'cashAssetIds'},
  ],
};

/// Descriptor for `GetAccountCashHoldingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountCashHoldingsRequestDescriptor =
    $convert.base64Decode(
        'Ch1HZXRBY2NvdW50Q2FzaEhvbGRpbmdzUmVxdWVzdBIkCg5yZWZfcmVxdWVzdF9pZBgBIAEoCV'
        'IMcmVmUmVxdWVzdElkEh0KCmFjY291bnRfaWQYAiABKAlSCWFjY291bnRJZBIkCg5jYXNoX2Fz'
        'c2V0X2lkcxgDIAMoCVIMY2FzaEFzc2V0SWRz');

@$core.Deprecated('Use getAccountCashHoldingsResponseDescriptor instead')
const GetAccountCashHoldingsResponse$json = {
  '1': 'GetAccountCashHoldingsResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {
      '1': 'created_at',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'createdAt'
    },
    {
      '1': 'cash_holdings',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.AssetHoldings',
      '10': 'cashHoldings'
    },
  ],
};

/// Descriptor for `GetAccountCashHoldingsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountCashHoldingsResponseDescriptor = $convert.base64Decode(
    'Ch5HZXRBY2NvdW50Q2FzaEhvbGRpbmdzUmVzcG9uc2USJAoOcmVmX3JlcXVlc3RfaWQYASABKA'
    'lSDHJlZlJlcXVlc3RJZBJECgpjcmVhdGVkX2F0GAIgASgLMiUucW9tZXQuYWdvcmEuZGFlbW9u'
    'cy5wcnRhZ2VudC52MS5UaW1lUgljcmVhdGVkQXQSUwoNY2FzaF9ob2xkaW5ncxgDIAEoCzIuLn'
    'FvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuQXNzZXRIb2xkaW5nc1IMY2FzaEhvbGRp'
    'bmdz');

@$core.Deprecated('Use depositCashRequestDescriptor instead')
const DepositCashRequest$json = {
  '1': 'DepositCashRequest',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'currency_asset_id', '3': 3, '4': 1, '5': 9, '10': 'currencyAssetId'},
    {'1': 'amount', '3': 4, '4': 1, '5': 9, '10': 'amount'},
    {'1': 'aux_data', '3': 5, '4': 1, '5': 9, '10': 'auxData'},
  ],
};

/// Descriptor for `DepositCashRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List depositCashRequestDescriptor = $convert.base64Decode(
    'ChJEZXBvc2l0Q2FzaFJlcXVlc3QSJAoOcmVmX3JlcXVlc3RfaWQYASABKAlSDHJlZlJlcXVlc3'
    'RJZBIdCgphY2NvdW50X2lkGAIgASgJUglhY2NvdW50SWQSKgoRY3VycmVuY3lfYXNzZXRfaWQY'
    'AyABKAlSD2N1cnJlbmN5QXNzZXRJZBIWCgZhbW91bnQYBCABKAlSBmFtb3VudBIZCghhdXhfZG'
    'F0YRgFIAEoCVIHYXV4RGF0YQ==');

@$core.Deprecated('Use depositCashResponseDescriptor instead')
const DepositCashResponse$json = {
  '1': 'DepositCashResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
  ],
};

/// Descriptor for `DepositCashResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List depositCashResponseDescriptor = $convert.base64Decode(
    'ChNEZXBvc2l0Q2FzaFJlc3BvbnNlEiQKDnJlZl9yZXF1ZXN0X2lkGAEgASgJUgxyZWZSZXF1ZX'
    'N0SWQ=');

@$core.Deprecated('Use depositAssetRequestDescriptor instead')
const DepositAssetRequest$json = {
  '1': 'DepositAssetRequest',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'asset_id', '3': 3, '4': 1, '5': 9, '10': 'assetId'},
    {'1': 'amount', '3': 4, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'aux_data', '3': 5, '4': 1, '5': 9, '10': 'auxData'},
  ],
};

/// Descriptor for `DepositAssetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List depositAssetRequestDescriptor = $convert.base64Decode(
    'ChNEZXBvc2l0QXNzZXRSZXF1ZXN0EiQKDnJlZl9yZXF1ZXN0X2lkGAEgASgJUgxyZWZSZXF1ZX'
    'N0SWQSHQoKYWNjb3VudF9pZBgCIAEoCVIJYWNjb3VudElkEhkKCGFzc2V0X2lkGAMgASgJUgdh'
    'c3NldElkEhYKBmFtb3VudBgEIAEoA1IGYW1vdW50EhkKCGF1eF9kYXRhGAUgASgJUgdhdXhEYX'
    'Rh');

@$core.Deprecated('Use depositAssetResponseDescriptor instead')
const DepositAssetResponse$json = {
  '1': 'DepositAssetResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
  ],
};

/// Descriptor for `DepositAssetResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List depositAssetResponseDescriptor = $convert.base64Decode(
    'ChREZXBvc2l0QXNzZXRSZXNwb25zZRIkCg5yZWZfcmVxdWVzdF9pZBgBIAEoCVIMcmVmUmVxdW'
    'VzdElk');

@$core.Deprecated('Use withdrawCashRequestDescriptor instead')
const WithdrawCashRequest$json = {
  '1': 'WithdrawCashRequest',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'currency_asset_id', '3': 3, '4': 1, '5': 9, '10': 'currencyAssetId'},
    {'1': 'amount', '3': 4, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'aux_data', '3': 5, '4': 1, '5': 9, '10': 'auxData'},
  ],
};

/// Descriptor for `WithdrawCashRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawCashRequestDescriptor = $convert.base64Decode(
    'ChNXaXRoZHJhd0Nhc2hSZXF1ZXN0EiQKDnJlZl9yZXF1ZXN0X2lkGAEgASgJUgxyZWZSZXF1ZX'
    'N0SWQSHQoKYWNjb3VudF9pZBgCIAEoCVIJYWNjb3VudElkEioKEWN1cnJlbmN5X2Fzc2V0X2lk'
    'GAMgASgJUg9jdXJyZW5jeUFzc2V0SWQSFgoGYW1vdW50GAQgASgDUgZhbW91bnQSGQoIYXV4X2'
    'RhdGEYBSABKAlSB2F1eERhdGE=');

@$core.Deprecated('Use withdrawCashResponseDescriptor instead')
const WithdrawCashResponse$json = {
  '1': 'WithdrawCashResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
  ],
};

/// Descriptor for `WithdrawCashResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawCashResponseDescriptor = $convert.base64Decode(
    'ChRXaXRoZHJhd0Nhc2hSZXNwb25zZRIkCg5yZWZfcmVxdWVzdF9pZBgBIAEoCVIMcmVmUmVxdW'
    'VzdElk');

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
      '6': '.qomet.agora.daemons.prtagent.v1.TransactionType',
      '10': 'type'
    },
    {'1': 'operation', '3': 5, '4': 1, '5': 9, '10': 'operation'},
    {'1': 'account_id', '3': 6, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'from_account', '3': 7, '4': 1, '5': 9, '10': 'fromAccount'},
    {'1': 'to_account', '3': 8, '4': 1, '5': 9, '10': 'toAccount'},
    {'1': 'from_reserve_id', '3': 9, '4': 1, '5': 9, '10': 'fromReserveId'},
    {'1': 'to_reserve_id', '3': 10, '4': 1, '5': 9, '10': 'toReserveId'},
    {'1': 'from_stash', '3': 11, '4': 1, '5': 9, '10': 'fromStash'},
    {'1': 'to_stash', '3': 12, '4': 1, '5': 9, '10': 'toStash'},
    {'1': 'asset_id', '3': 13, '4': 1, '5': 9, '10': 'assetId'},
    {'1': 'amount', '3': 14, '4': 1, '5': 9, '10': 'amount'},
    {'1': 'reference_id', '3': 15, '4': 1, '5': 9, '10': 'referenceId'},
    {'1': 'reference_type', '3': 16, '4': 1, '5': 9, '10': 'referenceType'},
    {'1': 'description', '3': 17, '4': 1, '5': 9, '10': 'description'},
    {'1': 'metadata', '3': 18, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `Transaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionDescriptor = $convert.base64Decode(
    'CgtUcmFuc2FjdGlvbhIlCg50cmFuc2FjdGlvbl9pZBgBIAEoCVINdHJhbnNhY3Rpb25JZBIpCh'
    'B0cmFuc2FjdGlvbl9oYXNoGAIgASgJUg90cmFuc2FjdGlvbkhhc2gSQwoJdGltZXN0YW1wGAMg'
    'ASgLMiUucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5UaW1lUgl0aW1lc3RhbXASRA'
    'oEdHlwZRgEIAEoDjIwLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuVHJhbnNhY3Rp'
    'b25UeXBlUgR0eXBlEhwKCW9wZXJhdGlvbhgFIAEoCVIJb3BlcmF0aW9uEh0KCmFjY291bnRfaW'
    'QYBiABKAlSCWFjY291bnRJZBIhCgxmcm9tX2FjY291bnQYByABKAlSC2Zyb21BY2NvdW50Eh0K'
    'CnRvX2FjY291bnQYCCABKAlSCXRvQWNjb3VudBImCg9mcm9tX3Jlc2VydmVfaWQYCSABKAlSDW'
    'Zyb21SZXNlcnZlSWQSIgoNdG9fcmVzZXJ2ZV9pZBgKIAEoCVILdG9SZXNlcnZlSWQSHQoKZnJv'
    'bV9zdGFzaBgLIAEoCVIJZnJvbVN0YXNoEhkKCHRvX3N0YXNoGAwgASgJUgd0b1N0YXNoEhkKCG'
    'Fzc2V0X2lkGA0gASgJUgdhc3NldElkEhYKBmFtb3VudBgOIAEoCVIGYW1vdW50EiEKDHJlZmVy'
    'ZW5jZV9pZBgPIAEoCVILcmVmZXJlbmNlSWQSJQoOcmVmZXJlbmNlX3R5cGUYECABKAlSDXJlZm'
    'VyZW5jZVR5cGUSIAoLZGVzY3JpcHRpb24YESABKAlSC2Rlc2NyaXB0aW9uEhoKCG1ldGFkYXRh'
    'GBIgASgJUghtZXRhZGF0YQ==');

@$core.Deprecated('Use getAccountOrdersRequestDescriptor instead')
const GetAccountOrdersRequest$json = {
  '1': 'GetAccountOrdersRequest',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    {
      '1': 'market_id_or_name_regexes',
      '3': 3,
      '4': 3,
      '5': 9,
      '10': 'marketIdOrNameRegexes'
    },
    {
      '1': 'pagination',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.PaginationParams',
      '10': 'pagination'
    },
    {
      '1': 'from_time',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'fromTime'
    },
    {
      '1': 'to_time',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'toTime'
    },
    {
      '1': 'side',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.OrderSide',
      '10': 'side'
    },
    {'1': 'status_filters', '3': 8, '4': 3, '5': 8, '10': 'statusFilters'},
    {
      '1': 'instrument_id_or_symbol_regexes',
      '3': 9,
      '4': 3,
      '5': 9,
      '10': 'instrumentIdOrSymbolRegexes'
    },
  ],
};

/// Descriptor for `GetAccountOrdersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountOrdersRequestDescriptor = $convert.base64Decode(
    'ChdHZXRBY2NvdW50T3JkZXJzUmVxdWVzdBIkCg5yZWZfcmVxdWVzdF9pZBgBIAEoCVIMcmVmUm'
    'VxdWVzdElkEh0KCmFjY291bnRfaWQYAiABKAlSCWFjY291bnRJZBI4ChltYXJrZXRfaWRfb3Jf'
    'bmFtZV9yZWdleGVzGAMgAygJUhVtYXJrZXRJZE9yTmFtZVJlZ2V4ZXMSUQoKcGFnaW5hdGlvbh'
    'gEIAEoCzIxLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuUGFnaW5hdGlvblBhcmFt'
    'c1IKcGFnaW5hdGlvbhJCCglmcm9tX3RpbWUYBSABKAsyJS5xb21ldC5hZ29yYS5kYWVtb25zLn'
    'BydGFnZW50LnYxLlRpbWVSCGZyb21UaW1lEj4KB3RvX3RpbWUYBiABKAsyJS5xb21ldC5hZ29y'
    'YS5kYWVtb25zLnBydGFnZW50LnYxLlRpbWVSBnRvVGltZRI+CgRzaWRlGAcgASgOMioucW9tZX'
    'QuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5PcmRlclNpZGVSBHNpZGUSJQoOc3RhdHVzX2Zp'
    'bHRlcnMYCCADKAhSDXN0YXR1c0ZpbHRlcnMSRAofaW5zdHJ1bWVudF9pZF9vcl9zeW1ib2xfcm'
    'VnZXhlcxgJIAMoCVIbaW5zdHJ1bWVudElkT3JTeW1ib2xSZWdleGVz');

@$core.Deprecated('Use getAccountOrdersResponseDescriptor instead')
const GetAccountOrdersResponse$json = {
  '1': 'GetAccountOrdersResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {
      '1': 'pagination_info',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.PaginationInfo',
      '10': 'paginationInfo'
    },
    {
      '1': 'orders',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Order',
      '10': 'orders'
    },
    {
      '1': 'created_at',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'createdAt'
    },
  ],
};

/// Descriptor for `GetAccountOrdersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountOrdersResponseDescriptor = $convert.base64Decode(
    'ChhHZXRBY2NvdW50T3JkZXJzUmVzcG9uc2USJAoOcmVmX3JlcXVlc3RfaWQYASABKAlSDHJlZl'
    'JlcXVlc3RJZBJYCg9wYWdpbmF0aW9uX2luZm8YAiABKAsyLy5xb21ldC5hZ29yYS5kYWVtb25z'
    'LnBydGFnZW50LnYxLlBhZ2luYXRpb25JbmZvUg5wYWdpbmF0aW9uSW5mbxI+CgZvcmRlcnMYAy'
    'ADKAsyJi5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLk9yZGVyUgZvcmRlcnMSRAoK'
    'Y3JlYXRlZF9hdBgEIAEoCzIlLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuVGltZV'
    'IJY3JlYXRlZEF0');

@$core.Deprecated('Use getAccountTradesRequestDescriptor instead')
const GetAccountTradesRequest$json = {
  '1': 'GetAccountTradesRequest',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    {
      '1': 'market_id_or_name_regexes',
      '3': 3,
      '4': 3,
      '5': 9,
      '10': 'marketIdOrNameRegexes'
    },
    {
      '1': 'pagination',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.PaginationParams',
      '10': 'pagination'
    },
    {
      '1': 'from_time',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'fromTime'
    },
    {
      '1': 'to_time',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'toTime'
    },
    {
      '1': 'instrument_id_or_symbol_regexes',
      '3': 7,
      '4': 3,
      '5': 9,
      '10': 'instrumentIdOrSymbolRegexes'
    },
    {
      '1': 'side',
      '3': 8,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.OrderSide',
      '10': 'side'
    },
  ],
};

/// Descriptor for `GetAccountTradesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountTradesRequestDescriptor = $convert.base64Decode(
    'ChdHZXRBY2NvdW50VHJhZGVzUmVxdWVzdBIkCg5yZWZfcmVxdWVzdF9pZBgBIAEoCVIMcmVmUm'
    'VxdWVzdElkEh0KCmFjY291bnRfaWQYAiABKAlSCWFjY291bnRJZBI4ChltYXJrZXRfaWRfb3Jf'
    'bmFtZV9yZWdleGVzGAMgAygJUhVtYXJrZXRJZE9yTmFtZVJlZ2V4ZXMSUQoKcGFnaW5hdGlvbh'
    'gEIAEoCzIxLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuUGFnaW5hdGlvblBhcmFt'
    'c1IKcGFnaW5hdGlvbhJCCglmcm9tX3RpbWUYBSABKAsyJS5xb21ldC5hZ29yYS5kYWVtb25zLn'
    'BydGFnZW50LnYxLlRpbWVSCGZyb21UaW1lEj4KB3RvX3RpbWUYBiABKAsyJS5xb21ldC5hZ29y'
    'YS5kYWVtb25zLnBydGFnZW50LnYxLlRpbWVSBnRvVGltZRJECh9pbnN0cnVtZW50X2lkX29yX3'
    'N5bWJvbF9yZWdleGVzGAcgAygJUhtpbnN0cnVtZW50SWRPclN5bWJvbFJlZ2V4ZXMSPgoEc2lk'
    'ZRgIIAEoDjIqLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuT3JkZXJTaWRlUgRzaW'
    'Rl');

@$core.Deprecated('Use getAccountTradesResponseDescriptor instead')
const GetAccountTradesResponse$json = {
  '1': 'GetAccountTradesResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {
      '1': 'pagination_info',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.PaginationInfo',
      '10': 'paginationInfo'
    },
    {
      '1': 'trades',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Trade',
      '10': 'trades'
    },
    {
      '1': 'created_at',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'createdAt'
    },
  ],
};

/// Descriptor for `GetAccountTradesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountTradesResponseDescriptor = $convert.base64Decode(
    'ChhHZXRBY2NvdW50VHJhZGVzUmVzcG9uc2USJAoOcmVmX3JlcXVlc3RfaWQYASABKAlSDHJlZl'
    'JlcXVlc3RJZBJYCg9wYWdpbmF0aW9uX2luZm8YAiABKAsyLy5xb21ldC5hZ29yYS5kYWVtb25z'
    'LnBydGFnZW50LnYxLlBhZ2luYXRpb25JbmZvUg5wYWdpbmF0aW9uSW5mbxI+CgZ0cmFkZXMYAy'
    'ADKAsyJi5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLlRyYWRlUgZ0cmFkZXMSRAoK'
    'Y3JlYXRlZF9hdBgEIAEoCzIlLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuVGltZV'
    'IJY3JlYXRlZEF0');

@$core.Deprecated('Use getAccountSettlementsRequestDescriptor instead')
const GetAccountSettlementsRequest$json = {
  '1': 'GetAccountSettlementsRequest',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    {
      '1': 'market_id_or_name_regexes',
      '3': 3,
      '4': 3,
      '5': 9,
      '10': 'marketIdOrNameRegexes'
    },
    {
      '1': 'pagination',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.PaginationParams',
      '10': 'pagination'
    },
    {
      '1': 'from_time',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'fromTime'
    },
    {
      '1': 'to_time',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'toTime'
    },
    {
      '1': 'status',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.ConfirmationStatus',
      '10': 'status'
    },
    {
      '1': 'asset_id_or_name_regexes',
      '3': 8,
      '4': 3,
      '5': 9,
      '10': 'assetIdOrNameRegexes'
    },
  ],
};

/// Descriptor for `GetAccountSettlementsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountSettlementsRequestDescriptor = $convert.base64Decode(
    'ChxHZXRBY2NvdW50U2V0dGxlbWVudHNSZXF1ZXN0EiQKDnJlZl9yZXF1ZXN0X2lkGAEgASgJUg'
    'xyZWZSZXF1ZXN0SWQSHQoKYWNjb3VudF9pZBgCIAEoCVIJYWNjb3VudElkEjgKGW1hcmtldF9p'
    'ZF9vcl9uYW1lX3JlZ2V4ZXMYAyADKAlSFW1hcmtldElkT3JOYW1lUmVnZXhlcxJRCgpwYWdpbm'
    'F0aW9uGAQgASgLMjEucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5QYWdpbmF0aW9u'
    'UGFyYW1zUgpwYWdpbmF0aW9uEkIKCWZyb21fdGltZRgFIAEoCzIlLnFvbWV0LmFnb3JhLmRhZW'
    '1vbnMucHJ0YWdlbnQudjEuVGltZVIIZnJvbVRpbWUSPgoHdG9fdGltZRgGIAEoCzIlLnFvbWV0'
    'LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuVGltZVIGdG9UaW1lEksKBnN0YXR1cxgHIAEoDj'
    'IzLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuQ29uZmlybWF0aW9uU3RhdHVzUgZz'
    'dGF0dXMSNgoYYXNzZXRfaWRfb3JfbmFtZV9yZWdleGVzGAggAygJUhRhc3NldElkT3JOYW1lUm'
    'VnZXhlcw==');

@$core.Deprecated('Use getAccountSettlementsResponseDescriptor instead')
const GetAccountSettlementsResponse$json = {
  '1': 'GetAccountSettlementsResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {
      '1': 'pagination_info',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.PaginationInfo',
      '10': 'paginationInfo'
    },
    {
      '1': 'settlements',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Settlement',
      '10': 'settlements'
    },
    {
      '1': 'created_at',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'createdAt'
    },
  ],
};

/// Descriptor for `GetAccountSettlementsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountSettlementsResponseDescriptor = $convert.base64Decode(
    'Ch1HZXRBY2NvdW50U2V0dGxlbWVudHNSZXNwb25zZRIkCg5yZWZfcmVxdWVzdF9pZBgBIAEoCV'
    'IMcmVmUmVxdWVzdElkElgKD3BhZ2luYXRpb25faW5mbxgCIAEoCzIvLnFvbWV0LmFnb3JhLmRh'
    'ZW1vbnMucHJ0YWdlbnQudjEuUGFnaW5hdGlvbkluZm9SDnBhZ2luYXRpb25JbmZvEk0KC3NldH'
    'RsZW1lbnRzGAMgAygLMisucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5TZXR0bGVt'
    'ZW50UgtzZXR0bGVtZW50cxJECgpjcmVhdGVkX2F0GAQgASgLMiUucW9tZXQuYWdvcmEuZGFlbW'
    '9ucy5wcnRhZ2VudC52MS5UaW1lUgljcmVhdGVkQXQ=');

@$core.Deprecated('Use getAccountTransactionsRequestDescriptor instead')
const GetAccountTransactionsRequest$json = {
  '1': 'GetAccountTransactionsRequest',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    {
      '1': 'pagination',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.PaginationParams',
      '10': 'pagination'
    },
    {
      '1': 'from_time',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'fromTime'
    },
    {
      '1': 'to_time',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'toTime'
    },
    {
      '1': 'transaction_types',
      '3': 6,
      '4': 3,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.TransactionType',
      '10': 'transactionTypes'
    },
    {
      '1': 'asset_id_or_name_regexes',
      '3': 7,
      '4': 3,
      '5': 9,
      '10': 'assetIdOrNameRegexes'
    },
  ],
};

/// Descriptor for `GetAccountTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountTransactionsRequestDescriptor = $convert.base64Decode(
    'Ch1HZXRBY2NvdW50VHJhbnNhY3Rpb25zUmVxdWVzdBIkCg5yZWZfcmVxdWVzdF9pZBgBIAEoCV'
    'IMcmVmUmVxdWVzdElkEh0KCmFjY291bnRfaWQYAiABKAlSCWFjY291bnRJZBJRCgpwYWdpbmF0'
    'aW9uGAMgASgLMjEucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5QYWdpbmF0aW9uUG'
    'FyYW1zUgpwYWdpbmF0aW9uEkIKCWZyb21fdGltZRgEIAEoCzIlLnFvbWV0LmFnb3JhLmRhZW1v'
    'bnMucHJ0YWdlbnQudjEuVGltZVIIZnJvbVRpbWUSPgoHdG9fdGltZRgFIAEoCzIlLnFvbWV0Lm'
    'Fnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuVGltZVIGdG9UaW1lEl0KEXRyYW5zYWN0aW9uX3R5'
    'cGVzGAYgAygOMjAucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5UcmFuc2FjdGlvbl'
    'R5cGVSEHRyYW5zYWN0aW9uVHlwZXMSNgoYYXNzZXRfaWRfb3JfbmFtZV9yZWdleGVzGAcgAygJ'
    'UhRhc3NldElkT3JOYW1lUmVnZXhlcw==');

@$core.Deprecated('Use getAccountTransactionsResponseDescriptor instead')
const GetAccountTransactionsResponse$json = {
  '1': 'GetAccountTransactionsResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {
      '1': 'pagination_info',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.PaginationInfo',
      '10': 'paginationInfo'
    },
    {
      '1': 'transactions',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Transaction',
      '10': 'transactions'
    },
    {
      '1': 'created_at',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'createdAt'
    },
  ],
};

/// Descriptor for `GetAccountTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountTransactionsResponseDescriptor = $convert.base64Decode(
    'Ch5HZXRBY2NvdW50VHJhbnNhY3Rpb25zUmVzcG9uc2USJAoOcmVmX3JlcXVlc3RfaWQYASABKA'
    'lSDHJlZlJlcXVlc3RJZBJYCg9wYWdpbmF0aW9uX2luZm8YAiABKAsyLy5xb21ldC5hZ29yYS5k'
    'YWVtb25zLnBydGFnZW50LnYxLlBhZ2luYXRpb25JbmZvUg5wYWdpbmF0aW9uSW5mbxJQCgx0cm'
    'Fuc2FjdGlvbnMYAyADKAsyLC5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLlRyYW5z'
    'YWN0aW9uUgx0cmFuc2FjdGlvbnMSRAoKY3JlYXRlZF9hdBgEIAEoCzIlLnFvbWV0LmFnb3JhLm'
    'RhZW1vbnMucHJ0YWdlbnQudjEuVGltZVIJY3JlYXRlZEF0');
