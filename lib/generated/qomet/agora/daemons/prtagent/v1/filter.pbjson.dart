// This is a generated file - do not edit.
//
// Generated from qomet/agora/daemons/prtagent/v1/filter.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use orderQueryFilterDescriptor instead')
const OrderQueryFilter$json = {
  '1': 'OrderQueryFilter',
  '2': [
    {
      '1': 'from_dt',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'fromDt'
    },
    {
      '1': 'to_dt',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'toDt'
    },
    {
      '1': 'side',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.OrderSide',
      '10': 'side'
    },
    {'1': 'order_types', '3': 4, '4': 3, '5': 9, '10': 'orderTypes'},
    {'1': 'price_min', '3': 5, '4': 1, '5': 9, '10': 'priceMin'},
    {'1': 'price_max', '3': 6, '4': 1, '5': 9, '10': 'priceMax'},
    {'1': 'quantity_min', '3': 7, '4': 1, '5': 9, '10': 'quantityMin'},
    {'1': 'quantity_max', '3': 8, '4': 1, '5': 9, '10': 'quantityMax'},
    {'1': 'status_filters', '3': 9, '4': 3, '5': 8, '10': 'statusFilters'},
    {'1': 'creator_address', '3': 10, '4': 1, '5': 9, '10': 'creatorAddress'},
  ],
};

/// Descriptor for `OrderQueryFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List orderQueryFilterDescriptor = $convert.base64Decode(
    'ChBPcmRlclF1ZXJ5RmlsdGVyEkIKB2Zyb21fZHQYASABKAsyKS5xb21ldC5hZ29yYS5kYWVtb2'
    '5zLnBydGFnZW50LnYxLkRhdGVUaW1lUgZmcm9tRHQSPgoFdG9fZHQYAiABKAsyKS5xb21ldC5h'
    'Z29yYS5kYWVtb25zLnBydGFnZW50LnYxLkRhdGVUaW1lUgR0b0R0Ej4KBHNpZGUYAyABKA4yKi'
    '5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLk9yZGVyU2lkZVIEc2lkZRIfCgtvcmRl'
    'cl90eXBlcxgEIAMoCVIKb3JkZXJUeXBlcxIbCglwcmljZV9taW4YBSABKAlSCHByaWNlTWluEh'
    'sKCXByaWNlX21heBgGIAEoCVIIcHJpY2VNYXgSIQoMcXVhbnRpdHlfbWluGAcgASgJUgtxdWFu'
    'dGl0eU1pbhIhCgxxdWFudGl0eV9tYXgYCCABKAlSC3F1YW50aXR5TWF4EiUKDnN0YXR1c19maW'
    'x0ZXJzGAkgAygIUg1zdGF0dXNGaWx0ZXJzEicKD2NyZWF0b3JfYWRkcmVzcxgKIAEoCVIOY3Jl'
    'YXRvckFkZHJlc3M=');

@$core.Deprecated('Use tradeQueryFilterDescriptor instead')
const TradeQueryFilter$json = {
  '1': 'TradeQueryFilter',
  '2': [
    {
      '1': 'from_dt',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'fromDt'
    },
    {
      '1': 'to_dt',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'toDt'
    },
    {'1': 'price_min', '3': 3, '4': 1, '5': 9, '10': 'priceMin'},
    {'1': 'price_max', '3': 4, '4': 1, '5': 9, '10': 'priceMax'},
    {'1': 'volume_min', '3': 5, '4': 1, '5': 9, '10': 'volumeMin'},
    {'1': 'volume_max', '3': 6, '4': 1, '5': 9, '10': 'volumeMax'},
    {'1': 'trade_types', '3': 7, '4': 3, '5': 9, '10': 'tradeTypes'},
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

/// Descriptor for `TradeQueryFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tradeQueryFilterDescriptor = $convert.base64Decode(
    'ChBUcmFkZVF1ZXJ5RmlsdGVyEkIKB2Zyb21fZHQYASABKAsyKS5xb21ldC5hZ29yYS5kYWVtb2'
    '5zLnBydGFnZW50LnYxLkRhdGVUaW1lUgZmcm9tRHQSPgoFdG9fZHQYAiABKAsyKS5xb21ldC5h'
    'Z29yYS5kYWVtb25zLnBydGFnZW50LnYxLkRhdGVUaW1lUgR0b0R0EhsKCXByaWNlX21pbhgDIA'
    'EoCVIIcHJpY2VNaW4SGwoJcHJpY2VfbWF4GAQgASgJUghwcmljZU1heBIdCgp2b2x1bWVfbWlu'
    'GAUgASgJUgl2b2x1bWVNaW4SHQoKdm9sdW1lX21heBgGIAEoCVIJdm9sdW1lTWF4Eh8KC3RyYW'
    'RlX3R5cGVzGAcgAygJUgp0cmFkZVR5cGVzEj4KBHNpZGUYCCABKA4yKi5xb21ldC5hZ29yYS5k'
    'YWVtb25zLnBydGFnZW50LnYxLk9yZGVyU2lkZVIEc2lkZQ==');

@$core.Deprecated('Use settlementQueryFilterDescriptor instead')
const SettlementQueryFilter$json = {
  '1': 'SettlementQueryFilter',
  '2': [
    {
      '1': 'from_dt',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'fromDt'
    },
    {
      '1': 'to_dt',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'toDt'
    },
    {
      '1': 'status',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.ConfirmationStatus',
      '10': 'status'
    },
    {'1': 'settlement_types', '3': 4, '4': 3, '5': 9, '10': 'settlementTypes'},
    {
      '1': 'asset_id_or_name_regexes',
      '3': 5,
      '4': 3,
      '5': 9,
      '10': 'assetIdOrNameRegexes'
    },
    {'1': 'amount_min', '3': 6, '4': 1, '5': 9, '10': 'amountMin'},
    {'1': 'amount_max', '3': 7, '4': 1, '5': 9, '10': 'amountMax'},
  ],
};

/// Descriptor for `SettlementQueryFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List settlementQueryFilterDescriptor = $convert.base64Decode(
    'ChVTZXR0bGVtZW50UXVlcnlGaWx0ZXISQgoHZnJvbV9kdBgBIAEoCzIpLnFvbWV0LmFnb3JhLm'
    'RhZW1vbnMucHJ0YWdlbnQudjEuRGF0ZVRpbWVSBmZyb21EdBI+CgV0b19kdBgCIAEoCzIpLnFv'
    'bWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuRGF0ZVRpbWVSBHRvRHQSSwoGc3RhdHVzGA'
    'MgASgOMjMucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5Db25maXJtYXRpb25TdGF0'
    'dXNSBnN0YXR1cxIpChBzZXR0bGVtZW50X3R5cGVzGAQgAygJUg9zZXR0bGVtZW50VHlwZXMSNg'
    'oYYXNzZXRfaWRfb3JfbmFtZV9yZWdleGVzGAUgAygJUhRhc3NldElkT3JOYW1lUmVnZXhlcxId'
    'CgphbW91bnRfbWluGAYgASgJUglhbW91bnRNaW4SHQoKYW1vdW50X21heBgHIAEoCVIJYW1vdW'
    '50TWF4');

@$core.Deprecated('Use orderbookQueryFilterDescriptor instead')
const OrderbookQueryFilter$json = {
  '1': 'OrderbookQueryFilter',
  '2': [
    {'1': 'aggregated', '3': 1, '4': 1, '5': 8, '10': 'aggregated'},
    {
      '1': 'side',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.OrderSide',
      '10': 'side'
    },
    {'1': 'depth', '3': 3, '4': 1, '5': 13, '10': 'depth'},
    {'1': 'price_min', '3': 4, '4': 1, '5': 9, '10': 'priceMin'},
    {'1': 'price_max', '3': 5, '4': 1, '5': 9, '10': 'priceMax'},
    {'1': 'include_my_orders', '3': 6, '4': 1, '5': 8, '10': 'includeMyOrders'},
    {
      '1': 'group_by_price_increment',
      '3': 7,
      '4': 1,
      '5': 9,
      '10': 'groupByPriceIncrement'
    },
  ],
};

/// Descriptor for `OrderbookQueryFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List orderbookQueryFilterDescriptor = $convert.base64Decode(
    'ChRPcmRlcmJvb2tRdWVyeUZpbHRlchIeCgphZ2dyZWdhdGVkGAEgASgIUgphZ2dyZWdhdGVkEj'
    '4KBHNpZGUYAiABKA4yKi5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLk9yZGVyU2lk'
    'ZVIEc2lkZRIUCgVkZXB0aBgDIAEoDVIFZGVwdGgSGwoJcHJpY2VfbWluGAQgASgJUghwcmljZU'
    '1pbhIbCglwcmljZV9tYXgYBSABKAlSCHByaWNlTWF4EioKEWluY2x1ZGVfbXlfb3JkZXJzGAYg'
    'ASgIUg9pbmNsdWRlTXlPcmRlcnMSNwoYZ3JvdXBfYnlfcHJpY2VfaW5jcmVtZW50GAcgASgJUh'
    'Vncm91cEJ5UHJpY2VJbmNyZW1lbnQ=');

@$core.Deprecated('Use orderListDescriptor instead')
const OrderList$json = {
  '1': 'OrderList',
  '2': [
    {
      '1': 'pagination_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.PaginationInfo',
      '10': 'paginationInfo'
    },
    {
      '1': 'orders',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Order',
      '10': 'orders'
    },
  ],
};

/// Descriptor for `OrderList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List orderListDescriptor = $convert.base64Decode(
    'CglPcmRlckxpc3QSWAoPcGFnaW5hdGlvbl9pbmZvGAEgASgLMi8ucW9tZXQuYWdvcmEuZGFlbW'
    '9ucy5wcnRhZ2VudC52MS5QYWdpbmF0aW9uSW5mb1IOcGFnaW5hdGlvbkluZm8SPgoGb3JkZXJz'
    'GAIgAygLMiYucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5PcmRlclIGb3JkZXJz');
