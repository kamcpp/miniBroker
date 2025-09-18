// This is a generated file - do not edit.
//
// Generated from venue.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use getVenueListRequestDescriptor instead')
const GetVenueListRequest$json = {
  '1': 'GetVenueListRequest',
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
      '1': 'venue_id_or_symbol_regex',
      '3': 4,
      '4': 1,
      '5': 9,
      '10': 'venueIdOrSymbolRegex'
    },
    {
      '1': 'aux_data',
      '3': 105,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.GetVenueListRequest.AuxDataEntry',
      '10': 'auxData'
    },
  ],
  '3': [GetVenueListRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use getVenueListRequestDescriptor instead')
const GetVenueListRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetVenueListRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVenueListRequestDescriptor = $convert.base64Decode(
    'ChNHZXRWZW51ZUxpc3RSZXF1ZXN0EjIKFXByb3Bvc2VkX2V4ZWN1dGlvbl9pZBgBIAEoCVITcH'
    'JvcG9zZWRFeGVjdXRpb25JZBJRCgpwYWdpbmF0aW9uGAIgASgLMjEucW9tZXQuYWdvcmEuZGFl'
    'bW9ucy5wcnRhZ2VudC52MS5QYWdpbmF0aW9uUGFyYW1zUgpwYWdpbmF0aW9uEjgKGW1hcmtldF'
    '9pZF9vcl9zeW1ib2xfcmVnZXgYAyABKAlSFW1hcmtldElkT3JTeW1ib2xSZWdleBI2Chh2ZW51'
    'ZV9pZF9vcl9zeW1ib2xfcmVnZXgYBCABKAlSFHZlbnVlSWRPclN5bWJvbFJlZ2V4ElwKCGF1eF'
    '9kYXRhGGkgAygLMkEucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5HZXRWZW51ZUxp'
    'c3RSZXF1ZXN0LkF1eERhdGFFbnRyeVIHYXV4RGF0YRo6CgxBdXhEYXRhRW50cnkSEAoDa2V5GA'
    'EgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use getVenueListResponseDescriptor instead')
const GetVenueListResponse$json = {
  '1': 'GetVenueListResponse',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {
      '1': 'pagination',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.PaginationInfo',
      '10': 'pagination'
    },
    {
      '1': 'venues',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Venue',
      '10': 'venues'
    },
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetVenueListResponse.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [GetVenueListResponse_MetadataEntry$json],
};

@$core.Deprecated('Use getVenueListResponseDescriptor instead')
const GetVenueListResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetVenueListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVenueListResponseDescriptor = $convert.base64Decode(
    'ChRHZXRWZW51ZUxpc3RSZXNwb25zZRIoChByZWZfZXhlY3V0aW9uX2lkGAEgASgJUg5yZWZFeG'
    'VjdXRpb25JZBJPCgpwYWdpbmF0aW9uGAIgASgLMi8ucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRh'
    'Z2VudC52MS5QYWdpbmF0aW9uSW5mb1IKcGFnaW5hdGlvbhI+CgZ2ZW51ZXMYAyADKAsyJi5xb2'
    '1ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLlZlbnVlUgZ2ZW51ZXMSXwoIbWV0YWRhdGEY'
    'aSADKAsyQy5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkdldFZlbnVlTGlzdFJlc3'
    'BvbnNlLk1ldGFkYXRhRW50cnlSCG1ldGFkYXRhGjsKDU1ldGFkYXRhRW50cnkSEAoDa2V5GAEg'
    'ASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use getVenueCalendarRequestDescriptor instead')
const GetVenueCalendarRequest$json = {
  '1': 'GetVenueCalendarRequest',
  '2': [
    {
      '1': 'proposed_execution_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'proposedExecutionId'
    },
    {'1': 'venue_iid', '3': 2, '4': 1, '5': 9, '10': 'venueIid'},
    {
      '1': 'aux_data',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetVenueCalendarRequest.AuxDataEntry',
      '10': 'auxData'
    },
  ],
  '3': [GetVenueCalendarRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use getVenueCalendarRequestDescriptor instead')
const GetVenueCalendarRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetVenueCalendarRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVenueCalendarRequestDescriptor = $convert.base64Decode(
    'ChdHZXRWZW51ZUNhbGVuZGFyUmVxdWVzdBIyChVwcm9wb3NlZF9leGVjdXRpb25faWQYASABKA'
    'lSE3Byb3Bvc2VkRXhlY3V0aW9uSWQSGwoJdmVudWVfaWlkGAIgASgJUgh2ZW51ZUlpZBJgCghh'
    'dXhfZGF0YRhpIAMoCzJFLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuR2V0VmVudW'
    'VDYWxlbmRhclJlcXVlc3QuQXV4RGF0YUVudHJ5UgdhdXhEYXRhGjoKDEF1eERhdGFFbnRyeRIQ'
    'CgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use getVenueCalendarResponseDescriptor instead')
const GetVenueCalendarResponse$json = {
  '1': 'GetVenueCalendarResponse',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {
      '1': 'calendar',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.VenueCalendar',
      '10': 'calendar'
    },
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetVenueCalendarResponse.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [GetVenueCalendarResponse_MetadataEntry$json],
};

@$core.Deprecated('Use getVenueCalendarResponseDescriptor instead')
const GetVenueCalendarResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetVenueCalendarResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVenueCalendarResponseDescriptor = $convert.base64Decode(
    'ChhHZXRWZW51ZUNhbGVuZGFyUmVzcG9uc2USKAoQcmVmX2V4ZWN1dGlvbl9pZBgBIAEoCVIOcm'
    'VmRXhlY3V0aW9uSWQSSgoIY2FsZW5kYXIYAiABKAsyLi5xb21ldC5hZ29yYS5kYWVtb25zLnBy'
    'dGFnZW50LnYxLlZlbnVlQ2FsZW5kYXJSCGNhbGVuZGFyEmMKCG1ldGFkYXRhGGkgAygLMkcucW'
    '9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5HZXRWZW51ZUNhbGVuZGFyUmVzcG9uc2Uu'
    'TWV0YWRhdGFFbnRyeVIIbWV0YWRhdGEaOwoNTWV0YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2'
    'tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');
