// This is a generated file - do not edit.
//
// Generated from qomet/agora/daemons/prtagent/v1/agent.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use pingRequestDescriptor instead')
const PingRequest$json = {
  '1': 'PingRequest',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {
      '1': 'string_to_be_ponged',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'stringToBePonged'
    },
  ],
};

/// Descriptor for `PingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pingRequestDescriptor = $convert.base64Decode(
    'CgtQaW5nUmVxdWVzdBIkCg5yZWZfcmVxdWVzdF9pZBgBIAEoCVIMcmVmUmVxdWVzdElkEi0KE3'
    'N0cmluZ190b19iZV9wb25nZWQYAiABKAlSEHN0cmluZ1RvQmVQb25nZWQ=');

@$core.Deprecated('Use pingResponseDescriptor instead')
const PingResponse$json = {
  '1': 'PingResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'pong_string', '3': 2, '4': 1, '5': 9, '10': 'pongString'},
  ],
};

/// Descriptor for `PingResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pingResponseDescriptor = $convert.base64Decode(
    'CgxQaW5nUmVzcG9uc2USJAoOcmVmX3JlcXVlc3RfaWQYASABKAlSDHJlZlJlcXVlc3RJZBIfCg'
    'twb25nX3N0cmluZxgCIAEoCVIKcG9uZ1N0cmluZw==');

@$core.Deprecated('Use getParticipantInfoRequestDescriptor instead')
const GetParticipantInfoRequest$json = {
  '1': 'GetParticipantInfoRequest',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
  ],
};

/// Descriptor for `GetParticipantInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getParticipantInfoRequestDescriptor =
    $convert.base64Decode(
        'ChlHZXRQYXJ0aWNpcGFudEluZm9SZXF1ZXN0EiQKDnJlZl9yZXF1ZXN0X2lkGAEgASgJUgxyZW'
        'ZSZXF1ZXN0SWQ=');

@$core.Deprecated('Use getParticipantInfoResponseDescriptor instead')
const GetParticipantInfoResponse$json = {
  '1': 'GetParticipantInfoResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'identifier', '3': 2, '4': 1, '5': 9, '10': 'identifier'},
  ],
};

/// Descriptor for `GetParticipantInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getParticipantInfoResponseDescriptor =
    $convert.base64Decode(
        'ChpHZXRQYXJ0aWNpcGFudEluZm9SZXNwb25zZRIkCg5yZWZfcmVxdWVzdF9pZBgBIAEoCVIMcm'
        'VmUmVxdWVzdElkEh4KCmlkZW50aWZpZXIYAiABKAlSCmlkZW50aWZpZXI=');

@$core.Deprecated('Use getSupportedCurrenciesRequestDescriptor instead')
const GetSupportedCurrenciesRequest$json = {
  '1': 'GetSupportedCurrenciesRequest',
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

/// Descriptor for `GetSupportedCurrenciesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportedCurrenciesRequestDescriptor =
    $convert.base64Decode(
        'Ch1HZXRTdXBwb3J0ZWRDdXJyZW5jaWVzUmVxdWVzdBIkCg5yZWZfcmVxdWVzdF9pZBgBIAEoCV'
        'IMcmVmUmVxdWVzdElkElEKCnBhZ2luYXRpb24YAiABKAsyMS5xb21ldC5hZ29yYS5kYWVtb25z'
        'LnBydGFnZW50LnYxLlBhZ2luYXRpb25QYXJhbXNSCnBhZ2luYXRpb24=');

@$core.Deprecated('Use getSupportedCurrenciesResponseDescriptor instead')
const GetSupportedCurrenciesResponse$json = {
  '1': 'GetSupportedCurrenciesResponse',
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

/// Descriptor for `GetSupportedCurrenciesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportedCurrenciesResponseDescriptor = $convert.base64Decode(
    'Ch5HZXRTdXBwb3J0ZWRDdXJyZW5jaWVzUmVzcG9uc2USJAoOcmVmX3JlcXVlc3RfaWQYASABKA'
    'lSDHJlZlJlcXVlc3RJZBJYCg9wYWdpbmF0aW9uX2luZm8YAiABKAsyLy5xb21ldC5hZ29yYS5k'
    'YWVtb25zLnBydGFnZW50LnYxLlBhZ2luYXRpb25JbmZvUg5wYWdpbmF0aW9uSW5mbxJGCgpjdX'
    'JyZW5jaWVzGAMgAygLMiYucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5Bc3NldFIK'
    'Y3VycmVuY2llcw==');

@$core.Deprecated('Use getParticipantOrdersRequestDescriptor instead')
const GetParticipantOrdersRequest$json = {
  '1': 'GetParticipantOrdersRequest',
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
    {
      '1': 'account_id_or_name_regexes',
      '3': 3,
      '4': 3,
      '5': 9,
      '10': 'accountIdOrNameRegexes'
    },
    {
      '1': 'market_id_or_name_regexes',
      '3': 4,
      '4': 3,
      '5': 9,
      '10': 'marketIdOrNameRegexes'
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

/// Descriptor for `GetParticipantOrdersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getParticipantOrdersRequestDescriptor = $convert.base64Decode(
    'ChtHZXRQYXJ0aWNpcGFudE9yZGVyc1JlcXVlc3QSJAoOcmVmX3JlcXVlc3RfaWQYASABKAlSDH'
    'JlZlJlcXVlc3RJZBJRCgpwYWdpbmF0aW9uGAIgASgLMjEucW9tZXQuYWdvcmEuZGFlbW9ucy5w'
    'cnRhZ2VudC52MS5QYWdpbmF0aW9uUGFyYW1zUgpwYWdpbmF0aW9uEjoKGmFjY291bnRfaWRfb3'
    'JfbmFtZV9yZWdleGVzGAMgAygJUhZhY2NvdW50SWRPck5hbWVSZWdleGVzEjgKGW1hcmtldF9p'
    'ZF9vcl9uYW1lX3JlZ2V4ZXMYBCADKAlSFW1hcmtldElkT3JOYW1lUmVnZXhlcxJCCglmcm9tX3'
    'RpbWUYBSABKAsyJS5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLlRpbWVSCGZyb21U'
    'aW1lEj4KB3RvX3RpbWUYBiABKAsyJS5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLl'
    'RpbWVSBnRvVGltZRI+CgRzaWRlGAcgASgOMioucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2Vu'
    'dC52MS5PcmRlclNpZGVSBHNpZGUSJQoOc3RhdHVzX2ZpbHRlcnMYCCADKAhSDXN0YXR1c0ZpbH'
    'RlcnMSRAofaW5zdHJ1bWVudF9pZF9vcl9zeW1ib2xfcmVnZXhlcxgJIAMoCVIbaW5zdHJ1bWVu'
    'dElkT3JTeW1ib2xSZWdleGVz');

@$core.Deprecated('Use getParticipantOrdersResponseDescriptor instead')
const GetParticipantOrdersResponse$json = {
  '1': 'GetParticipantOrdersResponse',
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
      '1': 'account_summaries',
      '3': 4,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetParticipantOrdersResponse.AccountSummariesEntry',
      '10': 'accountSummaries'
    },
    {
      '1': 'created_at',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'createdAt'
    },
  ],
  '3': [GetParticipantOrdersResponse_AccountSummariesEntry$json],
};

@$core.Deprecated('Use getParticipantOrdersResponseDescriptor instead')
const GetParticipantOrdersResponse_AccountSummariesEntry$json = {
  '1': 'AccountSummariesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetParticipantOrdersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getParticipantOrdersResponseDescriptor = $convert.base64Decode(
    'ChxHZXRQYXJ0aWNpcGFudE9yZGVyc1Jlc3BvbnNlEiQKDnJlZl9yZXF1ZXN0X2lkGAEgASgJUg'
    'xyZWZSZXF1ZXN0SWQSWAoPcGFnaW5hdGlvbl9pbmZvGAIgASgLMi8ucW9tZXQuYWdvcmEuZGFl'
    'bW9ucy5wcnRhZ2VudC52MS5QYWdpbmF0aW9uSW5mb1IOcGFnaW5hdGlvbkluZm8SPgoGb3JkZX'
    'JzGAMgAygLMiYucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5PcmRlclIGb3JkZXJz'
    'EoABChFhY2NvdW50X3N1bW1hcmllcxgEIAMoCzJTLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YW'
    'dlbnQudjEuR2V0UGFydGljaXBhbnRPcmRlcnNSZXNwb25zZS5BY2NvdW50U3VtbWFyaWVzRW50'
    'cnlSEGFjY291bnRTdW1tYXJpZXMSRAoKY3JlYXRlZF9hdBgFIAEoCzIlLnFvbWV0LmFnb3JhLm'
    'RhZW1vbnMucHJ0YWdlbnQudjEuVGltZVIJY3JlYXRlZEF0GkMKFUFjY291bnRTdW1tYXJpZXNF'
    'bnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use getParticipantTradesRequestDescriptor instead')
const GetParticipantTradesRequest$json = {
  '1': 'GetParticipantTradesRequest',
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
    {
      '1': 'account_id_or_name_regexes',
      '3': 3,
      '4': 3,
      '5': 9,
      '10': 'accountIdOrNameRegexes'
    },
    {
      '1': 'market_id_or_name_regexes',
      '3': 4,
      '4': 3,
      '5': 9,
      '10': 'marketIdOrNameRegexes'
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
    {
      '1': 'instrument_id_or_symbol_regexes',
      '3': 8,
      '4': 3,
      '5': 9,
      '10': 'instrumentIdOrSymbolRegexes'
    },
  ],
};

/// Descriptor for `GetParticipantTradesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getParticipantTradesRequestDescriptor = $convert.base64Decode(
    'ChtHZXRQYXJ0aWNpcGFudFRyYWRlc1JlcXVlc3QSJAoOcmVmX3JlcXVlc3RfaWQYASABKAlSDH'
    'JlZlJlcXVlc3RJZBJRCgpwYWdpbmF0aW9uGAIgASgLMjEucW9tZXQuYWdvcmEuZGFlbW9ucy5w'
    'cnRhZ2VudC52MS5QYWdpbmF0aW9uUGFyYW1zUgpwYWdpbmF0aW9uEjoKGmFjY291bnRfaWRfb3'
    'JfbmFtZV9yZWdleGVzGAMgAygJUhZhY2NvdW50SWRPck5hbWVSZWdleGVzEjgKGW1hcmtldF9p'
    'ZF9vcl9uYW1lX3JlZ2V4ZXMYBCADKAlSFW1hcmtldElkT3JOYW1lUmVnZXhlcxJCCglmcm9tX3'
    'RpbWUYBSABKAsyJS5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLlRpbWVSCGZyb21U'
    'aW1lEj4KB3RvX3RpbWUYBiABKAsyJS5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLl'
    'RpbWVSBnRvVGltZRI+CgRzaWRlGAcgASgOMioucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2Vu'
    'dC52MS5PcmRlclNpZGVSBHNpZGUSRAofaW5zdHJ1bWVudF9pZF9vcl9zeW1ib2xfcmVnZXhlcx'
    'gIIAMoCVIbaW5zdHJ1bWVudElkT3JTeW1ib2xSZWdleGVz');

@$core.Deprecated('Use getParticipantTradesResponseDescriptor instead')
const GetParticipantTradesResponse$json = {
  '1': 'GetParticipantTradesResponse',
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
      '1': 'account_summaries',
      '3': 4,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetParticipantTradesResponse.AccountSummariesEntry',
      '10': 'accountSummaries'
    },
    {
      '1': 'created_at',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'createdAt'
    },
  ],
  '3': [GetParticipantTradesResponse_AccountSummariesEntry$json],
};

@$core.Deprecated('Use getParticipantTradesResponseDescriptor instead')
const GetParticipantTradesResponse_AccountSummariesEntry$json = {
  '1': 'AccountSummariesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetParticipantTradesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getParticipantTradesResponseDescriptor = $convert.base64Decode(
    'ChxHZXRQYXJ0aWNpcGFudFRyYWRlc1Jlc3BvbnNlEiQKDnJlZl9yZXF1ZXN0X2lkGAEgASgJUg'
    'xyZWZSZXF1ZXN0SWQSWAoPcGFnaW5hdGlvbl9pbmZvGAIgASgLMi8ucW9tZXQuYWdvcmEuZGFl'
    'bW9ucy5wcnRhZ2VudC52MS5QYWdpbmF0aW9uSW5mb1IOcGFnaW5hdGlvbkluZm8SPgoGdHJhZG'
    'VzGAMgAygLMiYucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5UcmFkZVIGdHJhZGVz'
    'EoABChFhY2NvdW50X3N1bW1hcmllcxgEIAMoCzJTLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YW'
    'dlbnQudjEuR2V0UGFydGljaXBhbnRUcmFkZXNSZXNwb25zZS5BY2NvdW50U3VtbWFyaWVzRW50'
    'cnlSEGFjY291bnRTdW1tYXJpZXMSRAoKY3JlYXRlZF9hdBgFIAEoCzIlLnFvbWV0LmFnb3JhLm'
    'RhZW1vbnMucHJ0YWdlbnQudjEuVGltZVIJY3JlYXRlZEF0GkMKFUFjY291bnRTdW1tYXJpZXNF'
    'bnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use getParticipantSettlementsRequestDescriptor instead')
const GetParticipantSettlementsRequest$json = {
  '1': 'GetParticipantSettlementsRequest',
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
    {
      '1': 'account_id_or_name_regexes',
      '3': 3,
      '4': 3,
      '5': 9,
      '10': 'accountIdOrNameRegexes'
    },
    {
      '1': 'market_id_or_name_regexes',
      '3': 4,
      '4': 3,
      '5': 9,
      '10': 'marketIdOrNameRegexes'
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

/// Descriptor for `GetParticipantSettlementsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getParticipantSettlementsRequestDescriptor = $convert.base64Decode(
    'CiBHZXRQYXJ0aWNpcGFudFNldHRsZW1lbnRzUmVxdWVzdBIkCg5yZWZfcmVxdWVzdF9pZBgBIA'
    'EoCVIMcmVmUmVxdWVzdElkElEKCnBhZ2luYXRpb24YAiABKAsyMS5xb21ldC5hZ29yYS5kYWVt'
    'b25zLnBydGFnZW50LnYxLlBhZ2luYXRpb25QYXJhbXNSCnBhZ2luYXRpb24SOgoaYWNjb3VudF'
    '9pZF9vcl9uYW1lX3JlZ2V4ZXMYAyADKAlSFmFjY291bnRJZE9yTmFtZVJlZ2V4ZXMSOAoZbWFy'
    'a2V0X2lkX29yX25hbWVfcmVnZXhlcxgEIAMoCVIVbWFya2V0SWRPck5hbWVSZWdleGVzEkIKCW'
    'Zyb21fdGltZRgFIAEoCzIlLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuVGltZVII'
    'ZnJvbVRpbWUSPgoHdG9fdGltZRgGIAEoCzIlLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbn'
    'QudjEuVGltZVIGdG9UaW1lEksKBnN0YXR1cxgHIAEoDjIzLnFvbWV0LmFnb3JhLmRhZW1vbnMu'
    'cHJ0YWdlbnQudjEuQ29uZmlybWF0aW9uU3RhdHVzUgZzdGF0dXMSNgoYYXNzZXRfaWRfb3Jfbm'
    'FtZV9yZWdleGVzGAggAygJUhRhc3NldElkT3JOYW1lUmVnZXhlcw==');

@$core.Deprecated('Use getParticipantSettlementsResponseDescriptor instead')
const GetParticipantSettlementsResponse$json = {
  '1': 'GetParticipantSettlementsResponse',
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
      '1': 'account_summaries',
      '3': 4,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetParticipantSettlementsResponse.AccountSummariesEntry',
      '10': 'accountSummaries'
    },
    {
      '1': 'created_at',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'createdAt'
    },
  ],
  '3': [GetParticipantSettlementsResponse_AccountSummariesEntry$json],
};

@$core.Deprecated('Use getParticipantSettlementsResponseDescriptor instead')
const GetParticipantSettlementsResponse_AccountSummariesEntry$json = {
  '1': 'AccountSummariesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetParticipantSettlementsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getParticipantSettlementsResponseDescriptor = $convert.base64Decode(
    'CiFHZXRQYXJ0aWNpcGFudFNldHRsZW1lbnRzUmVzcG9uc2USJAoOcmVmX3JlcXVlc3RfaWQYAS'
    'ABKAlSDHJlZlJlcXVlc3RJZBJYCg9wYWdpbmF0aW9uX2luZm8YAiABKAsyLy5xb21ldC5hZ29y'
    'YS5kYWVtb25zLnBydGFnZW50LnYxLlBhZ2luYXRpb25JbmZvUg5wYWdpbmF0aW9uSW5mbxJNCg'
    'tzZXR0bGVtZW50cxgDIAMoCzIrLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuU2V0'
    'dGxlbWVudFILc2V0dGxlbWVudHMShQEKEWFjY291bnRfc3VtbWFyaWVzGAQgAygLMlgucW9tZX'
    'QuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5HZXRQYXJ0aWNpcGFudFNldHRsZW1lbnRzUmVz'
    'cG9uc2UuQWNjb3VudFN1bW1hcmllc0VudHJ5UhBhY2NvdW50U3VtbWFyaWVzEkQKCmNyZWF0ZW'
    'RfYXQYBSABKAsyJS5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLlRpbWVSCWNyZWF0'
    'ZWRBdBpDChVBY2NvdW50U3VtbWFyaWVzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdW'
    'UYAiABKAlSBXZhbHVlOgI4AQ==');
