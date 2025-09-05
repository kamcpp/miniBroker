// This is a generated file - do not edit.
//
// Generated from qomet/agora/daemons/prtagent/v1/market.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

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
    {'1': 'metadata', '3': 3, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'comments', '3': 4, '4': 3, '5': 9, '10': 'comments'},
  ],
};

/// Descriptor for `MarketDuration`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List marketDurationDescriptor = $convert.base64Decode(
    'Cg5NYXJrZXREdXJhdGlvbhJFCghkdXJhdGlvbhgBIAEoCzIpLnFvbWV0LmFnb3JhLmRhZW1vbn'
    'MucHJ0YWdlbnQudjEuRHVyYXRpb25SCGR1cmF0aW9uEkUKBnN0YXR1cxgCIAEoDjItLnFvbWV0'
    'LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuTWFya2V0U3RhdHVzUgZzdGF0dXMSGgoIbWV0YW'
    'RhdGEYAyABKAlSCG1ldGFkYXRhEhoKCGNvbW1lbnRzGAQgAygJUghjb21tZW50cw==');

@$core.Deprecated('Use marketCalendarDescriptor instead')
const MarketCalendar$json = {
  '1': 'MarketCalendar',
  '2': [
    {
      '1': 'market_identifiers',
      '3': 1,
      '4': 3,
      '5': 9,
      '10': 'marketIdentifiers'
    },
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
    'Cg5NYXJrZXRDYWxlbmRhchItChJtYXJrZXRfaWRlbnRpZmllcnMYASADKAlSEW1hcmtldElkZW'
    '50aWZpZXJzEkQKCmRhaWx5X29wZW4YAiABKAsyJS5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFn'
    'ZW50LnYxLlRpbWVSCWRhaWx5T3BlbhJGCgtkYWlseV9jbG9zZRgDIAEoCzIlLnFvbWV0LmFnb3'
    'JhLmRhZW1vbnMucHJ0YWdlbnQudjEuVGltZVIKZGFpbHlDbG9zZRJFCghjYWxlbmRhchgEIAMo'
    'CzIpLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuRHVyYXRpb25SCGNhbGVuZGFy');

@$core.Deprecated('Use getMarketListRequestDescriptor instead')
const GetMarketListRequest$json = {
  '1': 'GetMarketListRequest',
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

/// Descriptor for `GetMarketListRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketListRequestDescriptor = $convert.base64Decode(
    'ChRHZXRNYXJrZXRMaXN0UmVxdWVzdBIkCg5yZWZfcmVxdWVzdF9pZBgBIAEoCVIMcmVmUmVxdW'
    'VzdElkElEKCnBhZ2luYXRpb24YAiABKAsyMS5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50'
    'LnYxLlBhZ2luYXRpb25QYXJhbXNSCnBhZ2luYXRpb24=');

@$core.Deprecated('Use getMarketListResponseDescriptor instead')
const GetMarketListResponse$json = {
  '1': 'GetMarketListResponse',
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
      '1': 'markets',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Market',
      '10': 'markets'
    },
  ],
};

/// Descriptor for `GetMarketListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketListResponseDescriptor = $convert.base64Decode(
    'ChVHZXRNYXJrZXRMaXN0UmVzcG9uc2USJAoOcmVmX3JlcXVlc3RfaWQYASABKAlSDHJlZlJlcX'
    'Vlc3RJZBJYCg9wYWdpbmF0aW9uX2luZm8YAiABKAsyLy5xb21ldC5hZ29yYS5kYWVtb25zLnBy'
    'dGFnZW50LnYxLlBhZ2luYXRpb25JbmZvUg5wYWdpbmF0aW9uSW5mbxJBCgdtYXJrZXRzGAMgAy'
    'gLMicucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5NYXJrZXRSB21hcmtldHM=');

@$core.Deprecated('Use getMarketsInfoRequestDescriptor instead')
const GetMarketsInfoRequest$json = {
  '1': 'GetMarketsInfoRequest',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'market_ids', '3': 2, '4': 3, '5': 9, '10': 'marketIds'},
  ],
};

/// Descriptor for `GetMarketsInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketsInfoRequestDescriptor = $convert.base64Decode(
    'ChVHZXRNYXJrZXRzSW5mb1JlcXVlc3QSJAoOcmVmX3JlcXVlc3RfaWQYASABKAlSDHJlZlJlcX'
    'Vlc3RJZBIdCgptYXJrZXRfaWRzGAIgAygJUgltYXJrZXRJZHM=');

@$core.Deprecated('Use getMarketsInfoResponseDescriptor instead')
const GetMarketsInfoResponse$json = {
  '1': 'GetMarketsInfoResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {
      '1': 'markets',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Market',
      '10': 'markets'
    },
  ],
};

/// Descriptor for `GetMarketsInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketsInfoResponseDescriptor = $convert.base64Decode(
    'ChZHZXRNYXJrZXRzSW5mb1Jlc3BvbnNlEiQKDnJlZl9yZXF1ZXN0X2lkGAEgASgJUgxyZWZSZX'
    'F1ZXN0SWQSQQoHbWFya2V0cxgCIAMoCzInLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQu'
    'djEuTWFya2V0UgdtYXJrZXRz');

@$core.Deprecated('Use getMarketCalendarRequestDescriptor instead')
const GetMarketCalendarRequest$json = {
  '1': 'GetMarketCalendarRequest',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'market_id', '3': 2, '4': 1, '5': 9, '10': 'marketId'},
  ],
};

/// Descriptor for `GetMarketCalendarRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketCalendarRequestDescriptor =
    $convert.base64Decode(
        'ChhHZXRNYXJrZXRDYWxlbmRhclJlcXVlc3QSJAoOcmVmX3JlcXVlc3RfaWQYASABKAlSDHJlZl'
        'JlcXVlc3RJZBIbCgltYXJrZXRfaWQYAiABKAlSCG1hcmtldElk');

@$core.Deprecated('Use getMarketCalendarResponseDescriptor instead')
const GetMarketCalendarResponse$json = {
  '1': 'GetMarketCalendarResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {
      '1': 'calendar',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.MarketCalendar',
      '10': 'calendar'
    },
  ],
};

/// Descriptor for `GetMarketCalendarResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketCalendarResponseDescriptor = $convert.base64Decode(
    'ChlHZXRNYXJrZXRDYWxlbmRhclJlc3BvbnNlEiQKDnJlZl9yZXF1ZXN0X2lkGAEgASgJUgxyZW'
    'ZSZXF1ZXN0SWQSSwoIY2FsZW5kYXIYAiABKAsyLy5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFn'
    'ZW50LnYxLk1hcmtldENhbGVuZGFyUghjYWxlbmRhcg==');

@$core.Deprecated('Use getMarketSupportedCurrenciesRequestDescriptor instead')
const GetMarketSupportedCurrenciesRequest$json = {
  '1': 'GetMarketSupportedCurrenciesRequest',
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
    {'1': 'market_id', '3': 3, '4': 1, '5': 9, '10': 'marketId'},
  ],
};

/// Descriptor for `GetMarketSupportedCurrenciesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketSupportedCurrenciesRequestDescriptor =
    $convert.base64Decode(
        'CiNHZXRNYXJrZXRTdXBwb3J0ZWRDdXJyZW5jaWVzUmVxdWVzdBIkCg5yZWZfcmVxdWVzdF9pZB'
        'gBIAEoCVIMcmVmUmVxdWVzdElkElEKCnBhZ2luYXRpb24YAiABKAsyMS5xb21ldC5hZ29yYS5k'
        'YWVtb25zLnBydGFnZW50LnYxLlBhZ2luYXRpb25QYXJhbXNSCnBhZ2luYXRpb24SGwoJbWFya2'
        'V0X2lkGAMgASgJUghtYXJrZXRJZA==');

@$core.Deprecated('Use getMarketSupportedCurrenciesResponseDescriptor instead')
const GetMarketSupportedCurrenciesResponse$json = {
  '1': 'GetMarketSupportedCurrenciesResponse',
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
      '1': 'currencies',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Asset',
      '10': 'currencies'
    },
  ],
};

/// Descriptor for `GetMarketSupportedCurrenciesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketSupportedCurrenciesResponseDescriptor =
    $convert.base64Decode(
        'CiRHZXRNYXJrZXRTdXBwb3J0ZWRDdXJyZW5jaWVzUmVzcG9uc2USJAoOcmVmX3JlcXVlc3RfaW'
        'QYASABKAlSDHJlZlJlcXVlc3RJZBJYCg9wYWdpbmF0aW9uX2luZm8YAiABKAsyLy5xb21ldC5h'
        'Z29yYS5kYWVtb25zLnBydGFnZW50LnYxLlBhZ2luYXRpb25JbmZvUg5wYWdpbmF0aW9uSW5mbx'
        'JGCgpjdXJyZW5jaWVzGAMgAygLMiYucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5B'
        'c3NldFIKY3VycmVuY2llcw==');

@$core.Deprecated('Use getMarketInstrumentListRequestDescriptor instead')
const GetMarketInstrumentListRequest$json = {
  '1': 'GetMarketInstrumentListRequest',
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
    {'1': 'market_id', '3': 3, '4': 1, '5': 9, '10': 'marketId'},
    {
      '1': 'instrument_id_regex',
      '3': 4,
      '4': 1,
      '5': 9,
      '10': 'instrumentIdRegex'
    },
  ],
};

/// Descriptor for `GetMarketInstrumentListRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketInstrumentListRequestDescriptor = $convert.base64Decode(
    'Ch5HZXRNYXJrZXRJbnN0cnVtZW50TGlzdFJlcXVlc3QSJAoOcmVmX3JlcXVlc3RfaWQYASABKA'
    'lSDHJlZlJlcXVlc3RJZBJRCgpwYWdpbmF0aW9uGAIgASgLMjEucW9tZXQuYWdvcmEuZGFlbW9u'
    'cy5wcnRhZ2VudC52MS5QYWdpbmF0aW9uUGFyYW1zUgpwYWdpbmF0aW9uEhsKCW1hcmtldF9pZB'
    'gDIAEoCVIIbWFya2V0SWQSLgoTaW5zdHJ1bWVudF9pZF9yZWdleBgEIAEoCVIRaW5zdHJ1bWVu'
    'dElkUmVnZXg=');

@$core.Deprecated('Use getMarketInstrumentListResponseDescriptor instead')
const GetMarketInstrumentListResponse$json = {
  '1': 'GetMarketInstrumentListResponse',
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
      '1': 'instruments',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Instrument',
      '10': 'instruments'
    },
  ],
};

/// Descriptor for `GetMarketInstrumentListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketInstrumentListResponseDescriptor = $convert.base64Decode(
    'Ch9HZXRNYXJrZXRJbnN0cnVtZW50TGlzdFJlc3BvbnNlEiQKDnJlZl9yZXF1ZXN0X2lkGAEgAS'
    'gJUgxyZWZSZXF1ZXN0SWQSWAoPcGFnaW5hdGlvbl9pbmZvGAIgASgLMi8ucW9tZXQuYWdvcmEu'
    'ZGFlbW9ucy5wcnRhZ2VudC52MS5QYWdpbmF0aW9uSW5mb1IOcGFnaW5hdGlvbkluZm8STQoLaW'
    '5zdHJ1bWVudHMYAyADKAsyKy5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkluc3Ry'
    'dW1lbnRSC2luc3RydW1lbnRz');

@$core.Deprecated('Use feeStructureDescriptor instead')
const FeeStructure$json = {
  '1': 'FeeStructure',
  '2': [
    {'1': 'base_fee', '3': 1, '4': 1, '5': 9, '10': 'baseFee'},
    {'1': 'percentage_fee', '3': 2, '4': 1, '5': 9, '10': 'percentageFee'},
    {'1': 'minimum_fee', '3': 3, '4': 1, '5': 9, '10': 'minimumFee'},
    {'1': 'maximum_fee', '3': 4, '4': 1, '5': 9, '10': 'maximumFee'},
    {'1': 'gas_fee_estimate', '3': 5, '4': 1, '5': 9, '10': 'gasFeeEstimate'},
    {'1': 'maker_fee', '3': 6, '4': 1, '5': 9, '10': 'makerFee'},
    {'1': 'taker_fee', '3': 7, '4': 1, '5': 9, '10': 'takerFee'},
    {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'fee_tier', '3': 9, '4': 1, '5': 9, '10': 'feeTier'},
    {'1': 'discount_rate', '3': 10, '4': 1, '5': 9, '10': 'discountRate'},
    {
      '1': 'total_estimated_fee',
      '3': 11,
      '4': 1,
      '5': 9,
      '10': 'totalEstimatedFee'
    },
  ],
};

/// Descriptor for `FeeStructure`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List feeStructureDescriptor = $convert.base64Decode(
    'CgxGZWVTdHJ1Y3R1cmUSGQoIYmFzZV9mZWUYASABKAlSB2Jhc2VGZWUSJQoOcGVyY2VudGFnZV'
    '9mZWUYAiABKAlSDXBlcmNlbnRhZ2VGZWUSHwoLbWluaW11bV9mZWUYAyABKAlSCm1pbmltdW1G'
    'ZWUSHwoLbWF4aW11bV9mZWUYBCABKAlSCm1heGltdW1GZWUSKAoQZ2FzX2ZlZV9lc3RpbWF0ZR'
    'gFIAEoCVIOZ2FzRmVlRXN0aW1hdGUSGwoJbWFrZXJfZmVlGAYgASgJUghtYWtlckZlZRIbCgl0'
    'YWtlcl9mZWUYByABKAlSCHRha2VyRmVlEhoKCGN1cnJlbmN5GAggASgJUghjdXJyZW5jeRIZCg'
    'hmZWVfdGllchgJIAEoCVIHZmVlVGllchIjCg1kaXNjb3VudF9yYXRlGAogASgJUgxkaXNjb3Vu'
    'dFJhdGUSLgoTdG90YWxfZXN0aW1hdGVkX2ZlZRgLIAEoCVIRdG90YWxFc3RpbWF0ZWRGZWU=');

@$core.Deprecated('Use getOrderFeesRequestDescriptor instead')
const GetOrderFeesRequest$json = {
  '1': 'GetOrderFeesRequest',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    {
      '1': 'fee_payer_account_id',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'feePayerAccountId'
    },
    {'1': 'instrument_id', '3': 4, '4': 1, '5': 9, '10': 'instrumentId'},
    {'1': 'order_type', '3': 5, '4': 1, '5': 9, '10': 'orderType'},
    {
      '1': 'side',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.OrderSide',
      '10': 'side'
    },
    {'1': 'quantity', '3': 7, '4': 1, '5': 9, '10': 'quantity'},
    {'1': 'price', '3': 8, '4': 1, '5': 9, '10': 'price'},
    {'1': 'time_in_force', '3': 9, '4': 1, '5': 9, '10': 'timeInForce'},
    {'1': 'is_post_only', '3': 10, '4': 1, '5': 8, '10': 'isPostOnly'},
    {'1': 'metadata', '3': 11, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `GetOrderFeesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrderFeesRequestDescriptor = $convert.base64Decode(
    'ChNHZXRPcmRlckZlZXNSZXF1ZXN0EiQKDnJlZl9yZXF1ZXN0X2lkGAEgASgJUgxyZWZSZXF1ZX'
    'N0SWQSHQoKYWNjb3VudF9pZBgCIAEoCVIJYWNjb3VudElkEi8KFGZlZV9wYXllcl9hY2NvdW50'
    'X2lkGAMgASgJUhFmZWVQYXllckFjY291bnRJZBIjCg1pbnN0cnVtZW50X2lkGAQgASgJUgxpbn'
    'N0cnVtZW50SWQSHQoKb3JkZXJfdHlwZRgFIAEoCVIJb3JkZXJUeXBlEj4KBHNpZGUYBiABKA4y'
    'Ki5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLk9yZGVyU2lkZVIEc2lkZRIaCghxdW'
    'FudGl0eRgHIAEoCVIIcXVhbnRpdHkSFAoFcHJpY2UYCCABKAlSBXByaWNlEiIKDXRpbWVfaW5f'
    'Zm9yY2UYCSABKAlSC3RpbWVJbkZvcmNlEiAKDGlzX3Bvc3Rfb25seRgKIAEoCFIKaXNQb3N0T2'
    '5seRIaCghtZXRhZGF0YRgLIAEoCVIIbWV0YWRhdGE=');

@$core.Deprecated('Use getOrderFeesResponseDescriptor instead')
const GetOrderFeesResponse$json = {
  '1': 'GetOrderFeesResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {
      '1': 'fee_structure',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.FeeStructure',
      '10': 'feeStructure'
    },
    {'1': 'fee_notes', '3': 3, '4': 3, '5': 9, '10': 'feeNotes'},
    {
      '1': 'fee_valid_until',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'feeValidUntil'
    },
    {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'fee_breakdown',
      '3': 6,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetOrderFeesResponse.FeeBreakdownEntry',
      '10': 'feeBreakdown'
    },
    {
      '1': 'alternative_fee_options',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.FeeStructure',
      '10': 'alternativeFeeOptions'
    },
  ],
  '3': [GetOrderFeesResponse_FeeBreakdownEntry$json],
};

@$core.Deprecated('Use getOrderFeesResponseDescriptor instead')
const GetOrderFeesResponse_FeeBreakdownEntry$json = {
  '1': 'FeeBreakdownEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetOrderFeesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrderFeesResponseDescriptor = $convert.base64Decode(
    'ChRHZXRPcmRlckZlZXNSZXNwb25zZRIkCg5yZWZfcmVxdWVzdF9pZBgBIAEoCVIMcmVmUmVxdW'
    'VzdElkElIKDWZlZV9zdHJ1Y3R1cmUYAiABKAsyLS5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFn'
    'ZW50LnYxLkZlZVN0cnVjdHVyZVIMZmVlU3RydWN0dXJlEhsKCWZlZV9ub3RlcxgDIAMoCVIIZm'
    'VlTm90ZXMSTQoPZmVlX3ZhbGlkX3VudGlsGAQgASgLMiUucW9tZXQuYWdvcmEuZGFlbW9ucy5w'
    'cnRhZ2VudC52MS5UaW1lUg1mZWVWYWxpZFVudGlsEhgKB21lc3NhZ2UYBSABKAlSB21lc3NhZ2'
    'USbAoNZmVlX2JyZWFrZG93bhgGIAMoCzJHLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQu'
    'djEuR2V0T3JkZXJGZWVzUmVzcG9uc2UuRmVlQnJlYWtkb3duRW50cnlSDGZlZUJyZWFrZG93bh'
    'JlChdhbHRlcm5hdGl2ZV9mZWVfb3B0aW9ucxgHIAMoCzItLnFvbWV0LmFnb3JhLmRhZW1vbnMu'
    'cHJ0YWdlbnQudjEuRmVlU3RydWN0dXJlUhVhbHRlcm5hdGl2ZUZlZU9wdGlvbnMaPwoRRmVlQn'
    'JlYWtkb3duRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4'
    'AQ==');

@$core.Deprecated('Use createOrderRequestDescriptor instead')
const CreateOrderRequest$json = {
  '1': 'CreateOrderRequest',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    {
      '1': 'fee_payer_account_id',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'feePayerAccountId'
    },
    {'1': 'instrument_id', '3': 4, '4': 1, '5': 9, '10': 'instrumentId'},
    {'1': 'order_type', '3': 5, '4': 1, '5': 9, '10': 'orderType'},
    {
      '1': 'side',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.OrderSide',
      '10': 'side'
    },
    {'1': 'quantity', '3': 7, '4': 1, '5': 9, '10': 'quantity'},
    {'1': 'price', '3': 8, '4': 1, '5': 9, '10': 'price'},
    {'1': 'time_in_force', '3': 9, '4': 1, '5': 9, '10': 'timeInForce'},
    {
      '1': 'expire_time',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'expireTime'
    },
    {
      '1': 'participant_order_id',
      '3': 11,
      '4': 1,
      '5': 9,
      '10': 'participantOrderId'
    },
    {'1': 'metadata', '3': 12, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'aux_data', '3': 13, '4': 1, '5': 9, '10': 'auxData'},
  ],
};

/// Descriptor for `CreateOrderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createOrderRequestDescriptor = $convert.base64Decode(
    'ChJDcmVhdGVPcmRlclJlcXVlc3QSJAoOcmVmX3JlcXVlc3RfaWQYASABKAlSDHJlZlJlcXVlc3'
    'RJZBIdCgphY2NvdW50X2lkGAIgASgJUglhY2NvdW50SWQSLwoUZmVlX3BheWVyX2FjY291bnRf'
    'aWQYAyABKAlSEWZlZVBheWVyQWNjb3VudElkEiMKDWluc3RydW1lbnRfaWQYBCABKAlSDGluc3'
    'RydW1lbnRJZBIdCgpvcmRlcl90eXBlGAUgASgJUglvcmRlclR5cGUSPgoEc2lkZRgGIAEoDjIq'
    'LnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuT3JkZXJTaWRlUgRzaWRlEhoKCHF1YW'
    '50aXR5GAcgASgJUghxdWFudGl0eRIUCgVwcmljZRgIIAEoCVIFcHJpY2USIgoNdGltZV9pbl9m'
    'b3JjZRgJIAEoCVILdGltZUluRm9yY2USRgoLZXhwaXJlX3RpbWUYCiABKAsyJS5xb21ldC5hZ2'
    '9yYS5kYWVtb25zLnBydGFnZW50LnYxLlRpbWVSCmV4cGlyZVRpbWUSMAoUcGFydGljaXBhbnRf'
    'b3JkZXJfaWQYCyABKAlSEnBhcnRpY2lwYW50T3JkZXJJZBIaCghtZXRhZGF0YRgMIAEoCVIIbW'
    'V0YWRhdGESGQoIYXV4X2RhdGEYDSABKAlSB2F1eERhdGE=');

@$core.Deprecated('Use createOrderResponseDescriptor instead')
const CreateOrderResponse$json = {
  '1': 'CreateOrderResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'proposed_order_id', '3': 2, '4': 1, '5': 9, '10': 'proposedOrderId'},
    {'1': 'agent_order_id', '3': 3, '4': 1, '5': 9, '10': 'agentOrderId'},
    {'1': 'order_hash', '3': 4, '4': 1, '5': 9, '10': 'orderHash'},
    {
      '1': 'status',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.ConfirmationStatus',
      '10': 'status'
    },
    {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateOrderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createOrderResponseDescriptor = $convert.base64Decode(
    'ChNDcmVhdGVPcmRlclJlc3BvbnNlEiQKDnJlZl9yZXF1ZXN0X2lkGAEgASgJUgxyZWZSZXF1ZX'
    'N0SWQSKgoRcHJvcG9zZWRfb3JkZXJfaWQYAiABKAlSD3Byb3Bvc2VkT3JkZXJJZBIkCg5hZ2Vu'
    'dF9vcmRlcl9pZBgDIAEoCVIMYWdlbnRPcmRlcklkEh0KCm9yZGVyX2hhc2gYBCABKAlSCW9yZG'
    'VySGFzaBJLCgZzdGF0dXMYBSABKA4yMy5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYx'
    'LkNvbmZpcm1hdGlvblN0YXR1c1IGc3RhdHVzEhgKB21lc3NhZ2UYBiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use replaceOrderRequestDescriptor instead')
const ReplaceOrderRequest$json = {
  '1': 'ReplaceOrderRequest',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'proposed_order_id', '3': 2, '4': 1, '5': 9, '10': 'proposedOrderId'},
    {
      '1': 'new_proposed_order_id',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'newProposedOrderId'
    },
    {'1': 'new_quantity', '3': 4, '4': 1, '5': 9, '10': 'newQuantity'},
    {'1': 'new_price', '3': 5, '4': 1, '5': 9, '10': 'newPrice'},
    {
      '1': 'new_expire_time',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'newExpireTime'
    },
    {'1': 'reason', '3': 7, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'metadata', '3': 8, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `ReplaceOrderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List replaceOrderRequestDescriptor = $convert.base64Decode(
    'ChNSZXBsYWNlT3JkZXJSZXF1ZXN0EiQKDnJlZl9yZXF1ZXN0X2lkGAEgASgJUgxyZWZSZXF1ZX'
    'N0SWQSKgoRcHJvcG9zZWRfb3JkZXJfaWQYAiABKAlSD3Byb3Bvc2VkT3JkZXJJZBIxChVuZXdf'
    'cHJvcG9zZWRfb3JkZXJfaWQYAyABKAlSEm5ld1Byb3Bvc2VkT3JkZXJJZBIhCgxuZXdfcXVhbn'
    'RpdHkYBCABKAlSC25ld1F1YW50aXR5EhsKCW5ld19wcmljZRgFIAEoCVIIbmV3UHJpY2USTQoP'
    'bmV3X2V4cGlyZV90aW1lGAYgASgLMiUucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS'
    '5UaW1lUg1uZXdFeHBpcmVUaW1lEhYKBnJlYXNvbhgHIAEoCVIGcmVhc29uEhoKCG1ldGFkYXRh'
    'GAggASgJUghtZXRhZGF0YQ==');

@$core.Deprecated('Use replaceOrderResponseDescriptor instead')
const ReplaceOrderResponse$json = {
  '1': 'ReplaceOrderResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {
      '1': 'original_proposed_order_id',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'originalProposedOrderId'
    },
    {
      '1': 'new_proposed_order_id',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'newProposedOrderId'
    },
    {'1': 'new_order_hash', '3': 4, '4': 1, '5': 9, '10': 'newOrderHash'},
    {
      '1': 'status',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.ConfirmationStatus',
      '10': 'status'
    },
    {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ReplaceOrderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List replaceOrderResponseDescriptor = $convert.base64Decode(
    'ChRSZXBsYWNlT3JkZXJSZXNwb25zZRIkCg5yZWZfcmVxdWVzdF9pZBgBIAEoCVIMcmVmUmVxdW'
    'VzdElkEjsKGm9yaWdpbmFsX3Byb3Bvc2VkX29yZGVyX2lkGAIgASgJUhdvcmlnaW5hbFByb3Bv'
    'c2VkT3JkZXJJZBIxChVuZXdfcHJvcG9zZWRfb3JkZXJfaWQYAyABKAlSEm5ld1Byb3Bvc2VkT3'
    'JkZXJJZBIkCg5uZXdfb3JkZXJfaGFzaBgEIAEoCVIMbmV3T3JkZXJIYXNoEksKBnN0YXR1cxgF'
    'IAEoDjIzLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuQ29uZmlybWF0aW9uU3RhdH'
    'VzUgZzdGF0dXMSGAoHbWVzc2FnZRgGIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use cancelOrderRequestDescriptor instead')
const CancelOrderRequest$json = {
  '1': 'CancelOrderRequest',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'proposed_order_id', '3': 2, '4': 1, '5': 9, '10': 'proposedOrderId'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'metadata', '3': 4, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `CancelOrderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelOrderRequestDescriptor = $convert.base64Decode(
    'ChJDYW5jZWxPcmRlclJlcXVlc3QSJAoOcmVmX3JlcXVlc3RfaWQYASABKAlSDHJlZlJlcXVlc3'
    'RJZBIqChFwcm9wb3NlZF9vcmRlcl9pZBgCIAEoCVIPcHJvcG9zZWRPcmRlcklkEhYKBnJlYXNv'
    'bhgDIAEoCVIGcmVhc29uEhoKCG1ldGFkYXRhGAQgASgJUghtZXRhZGF0YQ==');

@$core.Deprecated('Use cancelOrderResponseDescriptor instead')
const CancelOrderResponse$json = {
  '1': 'CancelOrderResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {
      '1': 'cancelled_proposed_order_id',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'cancelledProposedOrderId'
    },
    {
      '1': 'cancellation_hash',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'cancellationHash'
    },
    {
      '1': 'status',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.ConfirmationStatus',
      '10': 'status'
    },
    {
      '1': 'cancelled_at',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'cancelledAt'
    },
    {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CancelOrderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelOrderResponseDescriptor = $convert.base64Decode(
    'ChNDYW5jZWxPcmRlclJlc3BvbnNlEiQKDnJlZl9yZXF1ZXN0X2lkGAEgASgJUgxyZWZSZXF1ZX'
    'N0SWQSPQobY2FuY2VsbGVkX3Byb3Bvc2VkX29yZGVyX2lkGAIgASgJUhhjYW5jZWxsZWRQcm9w'
    'b3NlZE9yZGVySWQSKwoRY2FuY2VsbGF0aW9uX2hhc2gYAyABKAlSEGNhbmNlbGxhdGlvbkhhc2'
    'gSSwoGc3RhdHVzGAQgASgOMjMucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5Db25m'
    'aXJtYXRpb25TdGF0dXNSBnN0YXR1cxJICgxjYW5jZWxsZWRfYXQYBSABKAsyJS5xb21ldC5hZ2'
    '9yYS5kYWVtb25zLnBydGFnZW50LnYxLlRpbWVSC2NhbmNlbGxlZEF0EhgKB21lc3NhZ2UYBiAB'
    'KAlSB21lc3NhZ2U=');
