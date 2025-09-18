// This is a generated file - do not edit.
//
// Generated from market.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use getMarketListRequestDescriptor instead')
const GetMarketListRequest$json = {
  '1': 'GetMarketListRequest',
  '2': [
    {
      '1': 'proposed_execution_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'proposedExecutionId'
    },
    {
      '1': 'pagination',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.PaginationParams',
      '10': 'pagination'
    },
    {
      '1': 'market_id_or_symbol_regex',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'marketIdOrSymbolRegex'
    },
    {
      '1': 'aux_data',
      '3': 105,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.GetMarketListRequest.AuxDataEntry',
      '10': 'auxData'
    },
  ],
  '3': [GetMarketListRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use getMarketListRequestDescriptor instead')
const GetMarketListRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetMarketListRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketListRequestDescriptor = $convert.base64Decode(
    'ChRHZXRNYXJrZXRMaXN0UmVxdWVzdBIyChVwcm9wb3NlZF9leGVjdXRpb25faWQYASABKAlSE3'
    'Byb3Bvc2VkRXhlY3V0aW9uSWQSUQoKcGFnaW5hdGlvbhgCIAEoCzIxLnFvbWV0LmFnb3JhLmRh'
    'ZW1vbnMucHJ0YWdlbnQudjEuUGFnaW5hdGlvblBhcmFtc1IKcGFnaW5hdGlvbhI4ChltYXJrZX'
    'RfaWRfb3Jfc3ltYm9sX3JlZ2V4GAMgASgJUhVtYXJrZXRJZE9yU3ltYm9sUmVnZXgSXQoIYXV4'
    'X2RhdGEYaSADKAsyQi5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkdldE1hcmtldE'
    'xpc3RSZXF1ZXN0LkF1eERhdGFFbnRyeVIHYXV4RGF0YRo6CgxBdXhEYXRhRW50cnkSEAoDa2V5'
    'GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use getMarketListResponseDescriptor instead')
const GetMarketListResponse$json = {
  '1': 'GetMarketListResponse',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
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
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetMarketListResponse.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [GetMarketListResponse_MetadataEntry$json],
};

@$core.Deprecated('Use getMarketListResponseDescriptor instead')
const GetMarketListResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetMarketListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketListResponseDescriptor = $convert.base64Decode(
    'ChVHZXRNYXJrZXRMaXN0UmVzcG9uc2USKAoQcmVmX2V4ZWN1dGlvbl9pZBgBIAEoCVIOcmVmRX'
    'hlY3V0aW9uSWQSWAoPcGFnaW5hdGlvbl9pbmZvGAIgASgLMi8ucW9tZXQuYWdvcmEuZGFlbW9u'
    'cy5wcnRhZ2VudC52MS5QYWdpbmF0aW9uSW5mb1IOcGFnaW5hdGlvbkluZm8SQQoHbWFya2V0cx'
    'gDIAMoCzInLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuTWFya2V0UgdtYXJrZXRz'
    'EmAKCG1ldGFkYXRhGGkgAygLMkQucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5HZX'
    'RNYXJrZXRMaXN0UmVzcG9uc2UuTWV0YWRhdGFFbnRyeVIIbWV0YWRhdGEaOwoNTWV0YWRhdGFF'
    'bnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use getMarketCalendarRequestDescriptor instead')
const GetMarketCalendarRequest$json = {
  '1': 'GetMarketCalendarRequest',
  '2': [
    {
      '1': 'proposed_execution_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'proposedExecutionId'
    },
    {'1': 'market_id', '3': 2, '4': 1, '5': 9, '10': 'marketId'},
    {
      '1': 'aux_data',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetMarketCalendarRequest.AuxDataEntry',
      '10': 'auxData'
    },
  ],
  '3': [GetMarketCalendarRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use getMarketCalendarRequestDescriptor instead')
const GetMarketCalendarRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetMarketCalendarRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketCalendarRequestDescriptor = $convert.base64Decode(
    'ChhHZXRNYXJrZXRDYWxlbmRhclJlcXVlc3QSMgoVcHJvcG9zZWRfZXhlY3V0aW9uX2lkGAEgAS'
    'gJUhNwcm9wb3NlZEV4ZWN1dGlvbklkEhsKCW1hcmtldF9pZBgCIAEoCVIIbWFya2V0SWQSYQoI'
    'YXV4X2RhdGEYaSADKAsyRi5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkdldE1hcm'
    'tldENhbGVuZGFyUmVxdWVzdC5BdXhEYXRhRW50cnlSB2F1eERhdGEaOgoMQXV4RGF0YUVudHJ5'
    'EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use getMarketCalendarResponseDescriptor instead')
const GetMarketCalendarResponse$json = {
  '1': 'GetMarketCalendarResponse',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {
      '1': 'calendar',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.MarketCalendar',
      '10': 'calendar'
    },
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetMarketCalendarResponse.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [GetMarketCalendarResponse_MetadataEntry$json],
};

@$core.Deprecated('Use getMarketCalendarResponseDescriptor instead')
const GetMarketCalendarResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetMarketCalendarResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketCalendarResponseDescriptor = $convert.base64Decode(
    'ChlHZXRNYXJrZXRDYWxlbmRhclJlc3BvbnNlEigKEHJlZl9leGVjdXRpb25faWQYASABKAlSDn'
    'JlZkV4ZWN1dGlvbklkEksKCGNhbGVuZGFyGAIgASgLMi8ucW9tZXQuYWdvcmEuZGFlbW9ucy5w'
    'cnRhZ2VudC52MS5NYXJrZXRDYWxlbmRhclIIY2FsZW5kYXISZAoIbWV0YWRhdGEYaSADKAsySC'
    '5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkdldE1hcmtldENhbGVuZGFyUmVzcG9u'
    'c2UuTWV0YWRhdGFFbnRyeVIIbWV0YWRhdGEaOwoNTWV0YWRhdGFFbnRyeRIQCgNrZXkYASABKA'
    'lSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');
