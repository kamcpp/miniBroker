// This is a generated file - do not edit.
//
// Generated from participant.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use getParticipantInfoRequestDescriptor instead')
const GetParticipantInfoRequest$json = {
  '1': 'GetParticipantInfoRequest',
  '2': [
    {
      '1': 'proposed_execution_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'proposedExecutionId'
    },
    {
      '1': 'aux_data',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetParticipantInfoRequest.AuxDataEntry',
      '10': 'auxData'
    },
  ],
  '3': [GetParticipantInfoRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use getParticipantInfoRequestDescriptor instead')
const GetParticipantInfoRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetParticipantInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getParticipantInfoRequestDescriptor = $convert.base64Decode(
    'ChlHZXRQYXJ0aWNpcGFudEluZm9SZXF1ZXN0EjIKFXByb3Bvc2VkX2V4ZWN1dGlvbl9pZBgBIA'
    'EoCVITcHJvcG9zZWRFeGVjdXRpb25JZBJiCghhdXhfZGF0YRhpIAMoCzJHLnFvbWV0LmFnb3Jh'
    'LmRhZW1vbnMucHJ0YWdlbnQudjEuR2V0UGFydGljaXBhbnRJbmZvUmVxdWVzdC5BdXhEYXRhRW'
    '50cnlSB2F1eERhdGEaOgoMQXV4RGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVl'
    'GAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use getParticipantInfoResponseDescriptor instead')
const GetParticipantInfoResponse$json = {
  '1': 'GetParticipantInfoResponse',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {
      '1': 'participant',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Participant',
      '10': 'participant'
    },
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetParticipantInfoResponse.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [GetParticipantInfoResponse_MetadataEntry$json],
};

@$core.Deprecated('Use getParticipantInfoResponseDescriptor instead')
const GetParticipantInfoResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetParticipantInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getParticipantInfoResponseDescriptor = $convert.base64Decode(
    'ChpHZXRQYXJ0aWNpcGFudEluZm9SZXNwb25zZRIoChByZWZfZXhlY3V0aW9uX2lkGAEgASgJUg'
    '5yZWZFeGVjdXRpb25JZBJOCgtwYXJ0aWNpcGFudBgCIAEoCzIsLnFvbWV0LmFnb3JhLmRhZW1v'
    'bnMucHJ0YWdlbnQudjEuUGFydGljaXBhbnRSC3BhcnRpY2lwYW50EmUKCG1ldGFkYXRhGGkgAy'
    'gLMkkucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5HZXRQYXJ0aWNpcGFudEluZm9S'
    'ZXNwb25zZS5NZXRhZGF0YUVudHJ5UghtZXRhZGF0YRo7Cg1NZXRhZGF0YUVudHJ5EhAKA2tleR'
    'gBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use getParticipantOrdersRequestDescriptor instead')
const GetParticipantOrdersRequest$json = {
  '1': 'GetParticipantOrdersRequest',
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
      '1': 'venue_id_or_symbol_regexes',
      '3': 5,
      '4': 3,
      '5': 9,
      '10': 'venueIdOrSymbolRegexes'
    },
    {
      '1': 'participant_id_or_symbol_regexes',
      '3': 6,
      '4': 3,
      '5': 9,
      '10': 'participantIdOrSymbolRegexes'
    },
    {
      '1': 'instrument_id_or_symbol_regexes',
      '3': 7,
      '4': 3,
      '5': 9,
      '10': 'instrumentIdOrSymbolRegexes'
    },
    {
      '1': 'from_dt',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'fromDt'
    },
    {
      '1': 'to_dt',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'toDt'
    },
    {
      '1': 'side',
      '3': 10,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.OrderSide',
      '10': 'side'
    },
    {'1': 'status_filters', '3': 11, '4': 3, '5': 8, '10': 'statusFilters'},
    {
      '1': 'aux_data',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetParticipantOrdersRequest.AuxDataEntry',
      '10': 'auxData'
    },
  ],
  '3': [GetParticipantOrdersRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use getParticipantOrdersRequestDescriptor instead')
const GetParticipantOrdersRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetParticipantOrdersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getParticipantOrdersRequestDescriptor = $convert.base64Decode(
    'ChtHZXRQYXJ0aWNpcGFudE9yZGVyc1JlcXVlc3QSMgoVcHJvcG9zZWRfZXhlY3V0aW9uX2lkGA'
    'EgASgJUhNwcm9wb3NlZEV4ZWN1dGlvbklkElEKCnBhZ2luYXRpb24YAiABKAsyMS5xb21ldC5h'
    'Z29yYS5kYWVtb25zLnBydGFnZW50LnYxLlBhZ2luYXRpb25QYXJhbXNSCnBhZ2luYXRpb24SOg'
    'oaYWNjb3VudF9pZF9vcl9uYW1lX3JlZ2V4ZXMYAyADKAlSFmFjY291bnRJZE9yTmFtZVJlZ2V4'
    'ZXMSOAoZbWFya2V0X2lkX29yX25hbWVfcmVnZXhlcxgEIAMoCVIVbWFya2V0SWRPck5hbWVSZW'
    'dleGVzEjoKGnZlbnVlX2lkX29yX3N5bWJvbF9yZWdleGVzGAUgAygJUhZ2ZW51ZUlkT3JTeW1i'
    'b2xSZWdleGVzEkYKIHBhcnRpY2lwYW50X2lkX29yX3N5bWJvbF9yZWdleGVzGAYgAygJUhxwYX'
    'J0aWNpcGFudElkT3JTeW1ib2xSZWdleGVzEkQKH2luc3RydW1lbnRfaWRfb3Jfc3ltYm9sX3Jl'
    'Z2V4ZXMYByADKAlSG2luc3RydW1lbnRJZE9yU3ltYm9sUmVnZXhlcxJCCgdmcm9tX2R0GAggAS'
    'gLMikucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5EYXRlVGltZVIGZnJvbUR0Ej4K'
    'BXRvX2R0GAkgASgLMikucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5EYXRlVGltZV'
    'IEdG9EdBI+CgRzaWRlGAogASgOMioucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5P'
    'cmRlclNpZGVSBHNpZGUSJQoOc3RhdHVzX2ZpbHRlcnMYCyADKAhSDXN0YXR1c0ZpbHRlcnMSZA'
    'oIYXV4X2RhdGEYaSADKAsySS5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkdldFBh'
    'cnRpY2lwYW50T3JkZXJzUmVxdWVzdC5BdXhEYXRhRW50cnlSB2F1eERhdGEaOgoMQXV4RGF0YU'
    'VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use getParticipantOrdersResponseDescriptor instead')
const GetParticipantOrdersResponse$json = {
  '1': 'GetParticipantOrdersResponse',
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
      '1': 'generated_at_dt',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'generatedAtDt'
    },
    {
      '1': 'orders',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Order',
      '10': 'orders'
    },
    {
      '1': 'account_summaries',
      '3': 5,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetParticipantOrdersResponse.AccountSummariesEntry',
      '10': 'accountSummaries'
    },
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetParticipantOrdersResponse.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [
    GetParticipantOrdersResponse_AccountSummariesEntry$json,
    GetParticipantOrdersResponse_MetadataEntry$json
  ],
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

@$core.Deprecated('Use getParticipantOrdersResponseDescriptor instead')
const GetParticipantOrdersResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetParticipantOrdersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getParticipantOrdersResponseDescriptor = $convert.base64Decode(
    'ChxHZXRQYXJ0aWNpcGFudE9yZGVyc1Jlc3BvbnNlEigKEHJlZl9leGVjdXRpb25faWQYASABKA'
    'lSDnJlZkV4ZWN1dGlvbklkElgKD3BhZ2luYXRpb25faW5mbxgCIAEoCzIvLnFvbWV0LmFnb3Jh'
    'LmRhZW1vbnMucHJ0YWdlbnQudjEuUGFnaW5hdGlvbkluZm9SDnBhZ2luYXRpb25JbmZvElEKD2'
    'dlbmVyYXRlZF9hdF9kdBgDIAEoCzIpLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEu'
    'RGF0ZVRpbWVSDWdlbmVyYXRlZEF0RHQSPgoGb3JkZXJzGAQgAygLMiYucW9tZXQuYWdvcmEuZG'
    'FlbW9ucy5wcnRhZ2VudC52MS5PcmRlclIGb3JkZXJzEoABChFhY2NvdW50X3N1bW1hcmllcxgF'
    'IAMoCzJTLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuR2V0UGFydGljaXBhbnRPcm'
    'RlcnNSZXNwb25zZS5BY2NvdW50U3VtbWFyaWVzRW50cnlSEGFjY291bnRTdW1tYXJpZXMSZwoI'
    'bWV0YWRhdGEYaSADKAsySy5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkdldFBhcn'
    'RpY2lwYW50T3JkZXJzUmVzcG9uc2UuTWV0YWRhdGFFbnRyeVIIbWV0YWRhdGEaQwoVQWNjb3Vu'
    'dFN1bW1hcmllc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZT'
    'oCOAEaOwoNTWV0YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIF'
    'dmFsdWU6AjgB');

@$core.Deprecated('Use getParticipantTradesRequestDescriptor instead')
const GetParticipantTradesRequest$json = {
  '1': 'GetParticipantTradesRequest',
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
      '1': 'venue_id_or_symbol_regexes',
      '3': 5,
      '4': 3,
      '5': 9,
      '10': 'venueIdOrSymbolRegexes'
    },
    {
      '1': 'participant_id_or_symbol_regexes',
      '3': 6,
      '4': 3,
      '5': 9,
      '10': 'participantIdOrSymbolRegexes'
    },
    {
      '1': 'instrument_id_or_symbol_regexes',
      '3': 7,
      '4': 3,
      '5': 9,
      '10': 'instrumentIdOrSymbolRegexes'
    },
    {
      '1': 'from_dt',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'fromDt'
    },
    {
      '1': 'to_dt',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'toDt'
    },
    {
      '1': 'side',
      '3': 10,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.OrderSide',
      '10': 'side'
    },
    {
      '1': 'aux_data',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetParticipantTradesRequest.AuxDataEntry',
      '10': 'auxData'
    },
  ],
  '3': [GetParticipantTradesRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use getParticipantTradesRequestDescriptor instead')
const GetParticipantTradesRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetParticipantTradesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getParticipantTradesRequestDescriptor = $convert.base64Decode(
    'ChtHZXRQYXJ0aWNpcGFudFRyYWRlc1JlcXVlc3QSMgoVcHJvcG9zZWRfZXhlY3V0aW9uX2lkGA'
    'EgASgJUhNwcm9wb3NlZEV4ZWN1dGlvbklkElEKCnBhZ2luYXRpb24YAiABKAsyMS5xb21ldC5h'
    'Z29yYS5kYWVtb25zLnBydGFnZW50LnYxLlBhZ2luYXRpb25QYXJhbXNSCnBhZ2luYXRpb24SOg'
    'oaYWNjb3VudF9pZF9vcl9uYW1lX3JlZ2V4ZXMYAyADKAlSFmFjY291bnRJZE9yTmFtZVJlZ2V4'
    'ZXMSOAoZbWFya2V0X2lkX29yX25hbWVfcmVnZXhlcxgEIAMoCVIVbWFya2V0SWRPck5hbWVSZW'
    'dleGVzEjoKGnZlbnVlX2lkX29yX3N5bWJvbF9yZWdleGVzGAUgAygJUhZ2ZW51ZUlkT3JTeW1i'
    'b2xSZWdleGVzEkYKIHBhcnRpY2lwYW50X2lkX29yX3N5bWJvbF9yZWdleGVzGAYgAygJUhxwYX'
    'J0aWNpcGFudElkT3JTeW1ib2xSZWdleGVzEkQKH2luc3RydW1lbnRfaWRfb3Jfc3ltYm9sX3Jl'
    'Z2V4ZXMYByADKAlSG2luc3RydW1lbnRJZE9yU3ltYm9sUmVnZXhlcxJCCgdmcm9tX2R0GAggAS'
    'gLMikucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5EYXRlVGltZVIGZnJvbUR0Ej4K'
    'BXRvX2R0GAkgASgLMikucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5EYXRlVGltZV'
    'IEdG9EdBI+CgRzaWRlGAogASgOMioucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5P'
    'cmRlclNpZGVSBHNpZGUSZAoIYXV4X2RhdGEYaSADKAsySS5xb21ldC5hZ29yYS5kYWVtb25zLn'
    'BydGFnZW50LnYxLkdldFBhcnRpY2lwYW50VHJhZGVzUmVxdWVzdC5BdXhEYXRhRW50cnlSB2F1'
    'eERhdGEaOgoMQXV4RGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUg'
    'V2YWx1ZToCOAE=');

@$core.Deprecated('Use getParticipantTradesResponseDescriptor instead')
const GetParticipantTradesResponse$json = {
  '1': 'GetParticipantTradesResponse',
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
      '1': 'generated_at_dt',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'generatedAtDt'
    },
    {
      '1': 'trades',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Trade',
      '10': 'trades'
    },
    {
      '1': 'account_summaries',
      '3': 5,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetParticipantTradesResponse.AccountSummariesEntry',
      '10': 'accountSummaries'
    },
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetParticipantTradesResponse.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [
    GetParticipantTradesResponse_AccountSummariesEntry$json,
    GetParticipantTradesResponse_MetadataEntry$json
  ],
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

@$core.Deprecated('Use getParticipantTradesResponseDescriptor instead')
const GetParticipantTradesResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetParticipantTradesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getParticipantTradesResponseDescriptor = $convert.base64Decode(
    'ChxHZXRQYXJ0aWNpcGFudFRyYWRlc1Jlc3BvbnNlEigKEHJlZl9leGVjdXRpb25faWQYASABKA'
    'lSDnJlZkV4ZWN1dGlvbklkElgKD3BhZ2luYXRpb25faW5mbxgCIAEoCzIvLnFvbWV0LmFnb3Jh'
    'LmRhZW1vbnMucHJ0YWdlbnQudjEuUGFnaW5hdGlvbkluZm9SDnBhZ2luYXRpb25JbmZvElEKD2'
    'dlbmVyYXRlZF9hdF9kdBgDIAEoCzIpLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEu'
    'RGF0ZVRpbWVSDWdlbmVyYXRlZEF0RHQSPgoGdHJhZGVzGAQgAygLMiYucW9tZXQuYWdvcmEuZG'
    'FlbW9ucy5wcnRhZ2VudC52MS5UcmFkZVIGdHJhZGVzEoABChFhY2NvdW50X3N1bW1hcmllcxgF'
    'IAMoCzJTLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuR2V0UGFydGljaXBhbnRUcm'
    'FkZXNSZXNwb25zZS5BY2NvdW50U3VtbWFyaWVzRW50cnlSEGFjY291bnRTdW1tYXJpZXMSZwoI'
    'bWV0YWRhdGEYaSADKAsySy5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkdldFBhcn'
    'RpY2lwYW50VHJhZGVzUmVzcG9uc2UuTWV0YWRhdGFFbnRyeVIIbWV0YWRhdGEaQwoVQWNjb3Vu'
    'dFN1bW1hcmllc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZT'
    'oCOAEaOwoNTWV0YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIF'
    'dmFsdWU6AjgB');

@$core.Deprecated('Use getParticipantSettlementsRequestDescriptor instead')
const GetParticipantSettlementsRequest$json = {
  '1': 'GetParticipantSettlementsRequest',
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
      '1': 'venue_id_or_symbol_regexes',
      '3': 5,
      '4': 3,
      '5': 9,
      '10': 'venueIdOrSymbolRegexes'
    },
    {
      '1': 'participant_id_or_symbol_regexes',
      '3': 6,
      '4': 3,
      '5': 9,
      '10': 'participantIdOrSymbolRegexes'
    },
    {
      '1': 'instrument_id_or_symbol_regexes',
      '3': 7,
      '4': 3,
      '5': 9,
      '10': 'instrumentIdOrSymbolRegexes'
    },
    {
      '1': 'from_dt',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'fromDt'
    },
    {
      '1': 'to_dt',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'toDt'
    },
    {
      '1': 'status',
      '3': 10,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.ConfirmationStatus',
      '10': 'status'
    },
    {
      '1': 'aux_data',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetParticipantSettlementsRequest.AuxDataEntry',
      '10': 'auxData'
    },
  ],
  '3': [GetParticipantSettlementsRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use getParticipantSettlementsRequestDescriptor instead')
const GetParticipantSettlementsRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetParticipantSettlementsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getParticipantSettlementsRequestDescriptor = $convert.base64Decode(
    'CiBHZXRQYXJ0aWNpcGFudFNldHRsZW1lbnRzUmVxdWVzdBIyChVwcm9wb3NlZF9leGVjdXRpb2'
    '5faWQYASABKAlSE3Byb3Bvc2VkRXhlY3V0aW9uSWQSUQoKcGFnaW5hdGlvbhgCIAEoCzIxLnFv'
    'bWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuUGFnaW5hdGlvblBhcmFtc1IKcGFnaW5hdG'
    'lvbhI6ChphY2NvdW50X2lkX29yX25hbWVfcmVnZXhlcxgDIAMoCVIWYWNjb3VudElkT3JOYW1l'
    'UmVnZXhlcxI4ChltYXJrZXRfaWRfb3JfbmFtZV9yZWdleGVzGAQgAygJUhVtYXJrZXRJZE9yTm'
    'FtZVJlZ2V4ZXMSOgoadmVudWVfaWRfb3Jfc3ltYm9sX3JlZ2V4ZXMYBSADKAlSFnZlbnVlSWRP'
    'clN5bWJvbFJlZ2V4ZXMSRgogcGFydGljaXBhbnRfaWRfb3Jfc3ltYm9sX3JlZ2V4ZXMYBiADKA'
    'lSHHBhcnRpY2lwYW50SWRPclN5bWJvbFJlZ2V4ZXMSRAofaW5zdHJ1bWVudF9pZF9vcl9zeW1i'
    'b2xfcmVnZXhlcxgHIAMoCVIbaW5zdHJ1bWVudElkT3JTeW1ib2xSZWdleGVzEkIKB2Zyb21fZH'
    'QYCCABKAsyKS5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkRhdGVUaW1lUgZmcm9t'
    'RHQSPgoFdG9fZHQYCSABKAsyKS5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkRhdG'
    'VUaW1lUgR0b0R0EksKBnN0YXR1cxgKIAEoDjIzLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdl'
    'bnQudjEuQ29uZmlybWF0aW9uU3RhdHVzUgZzdGF0dXMSaQoIYXV4X2RhdGEYaSADKAsyTi5xb2'
    '1ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkdldFBhcnRpY2lwYW50U2V0dGxlbWVudHNS'
    'ZXF1ZXN0LkF1eERhdGFFbnRyeVIHYXV4RGF0YRo6CgxBdXhEYXRhRW50cnkSEAoDa2V5GAEgAS'
    'gJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use getParticipantSettlementsResponseDescriptor instead')
const GetParticipantSettlementsResponse$json = {
  '1': 'GetParticipantSettlementsResponse',
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
      '1': 'generated_at_dt',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'generatedAtDt'
    },
    {
      '1': 'settlements',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Settlement',
      '10': 'settlements'
    },
    {
      '1': 'account_summaries',
      '3': 5,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetParticipantSettlementsResponse.AccountSummariesEntry',
      '10': 'accountSummaries'
    },
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetParticipantSettlementsResponse.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [
    GetParticipantSettlementsResponse_AccountSummariesEntry$json,
    GetParticipantSettlementsResponse_MetadataEntry$json
  ],
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

@$core.Deprecated('Use getParticipantSettlementsResponseDescriptor instead')
const GetParticipantSettlementsResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetParticipantSettlementsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getParticipantSettlementsResponseDescriptor = $convert.base64Decode(
    'CiFHZXRQYXJ0aWNpcGFudFNldHRsZW1lbnRzUmVzcG9uc2USKAoQcmVmX2V4ZWN1dGlvbl9pZB'
    'gBIAEoCVIOcmVmRXhlY3V0aW9uSWQSWAoPcGFnaW5hdGlvbl9pbmZvGAIgASgLMi8ucW9tZXQu'
    'YWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5QYWdpbmF0aW9uSW5mb1IOcGFnaW5hdGlvbkluZm'
    '8SUQoPZ2VuZXJhdGVkX2F0X2R0GAMgASgLMikucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2Vu'
    'dC52MS5EYXRlVGltZVINZ2VuZXJhdGVkQXREdBJNCgtzZXR0bGVtZW50cxgEIAMoCzIrLnFvbW'
    'V0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuU2V0dGxlbWVudFILc2V0dGxlbWVudHMShQEK'
    'EWFjY291bnRfc3VtbWFyaWVzGAUgAygLMlgucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC'
    '52MS5HZXRQYXJ0aWNpcGFudFNldHRsZW1lbnRzUmVzcG9uc2UuQWNjb3VudFN1bW1hcmllc0Vu'
    'dHJ5UhBhY2NvdW50U3VtbWFyaWVzEmwKCG1ldGFkYXRhGGkgAygLMlAucW9tZXQuYWdvcmEuZG'
    'FlbW9ucy5wcnRhZ2VudC52MS5HZXRQYXJ0aWNpcGFudFNldHRsZW1lbnRzUmVzcG9uc2UuTWV0'
    'YWRhdGFFbnRyeVIIbWV0YWRhdGEaQwoVQWNjb3VudFN1bW1hcmllc0VudHJ5EhAKA2tleRgBIA'
    'EoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAEaOwoNTWV0YWRhdGFFbnRyeRIQCgNr'
    'ZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');
