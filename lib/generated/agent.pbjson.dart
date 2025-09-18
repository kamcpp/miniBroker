// This is a generated file - do not edit.
//
// Generated from agent.proto.

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
    {
      '1': 'proposed_execution_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'proposedExecutionId'
    },
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
    'CgtQaW5nUmVxdWVzdBIyChVwcm9wb3NlZF9leGVjdXRpb25faWQYASABKAlSE3Byb3Bvc2VkRX'
    'hlY3V0aW9uSWQSLQoTc3RyaW5nX3RvX2JlX3BvbmdlZBgCIAEoCVIQc3RyaW5nVG9CZVBvbmdl'
    'ZA==');

@$core.Deprecated('Use pingResponseDescriptor instead')
const PingResponse$json = {
  '1': 'PingResponse',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {'1': 'pong_string', '3': 2, '4': 1, '5': 9, '10': 'pongString'},
  ],
};

/// Descriptor for `PingResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pingResponseDescriptor = $convert.base64Decode(
    'CgxQaW5nUmVzcG9uc2USKAoQcmVmX2V4ZWN1dGlvbl9pZBgBIAEoCVIOcmVmRXhlY3V0aW9uSW'
    'QSHwoLcG9uZ19zdHJpbmcYAiABKAlSCnBvbmdTdHJpbmc=');

@$core.Deprecated('Use getSupportedCurrenciesRequestDescriptor instead')
const GetSupportedCurrenciesRequest$json = {
  '1': 'GetSupportedCurrenciesRequest',
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
      '1': 'aux_data',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetSupportedCurrenciesRequest.AuxDataEntry',
      '10': 'auxData'
    },
  ],
  '3': [GetSupportedCurrenciesRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use getSupportedCurrenciesRequestDescriptor instead')
const GetSupportedCurrenciesRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetSupportedCurrenciesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportedCurrenciesRequestDescriptor = $convert.base64Decode(
    'Ch1HZXRTdXBwb3J0ZWRDdXJyZW5jaWVzUmVxdWVzdBIyChVwcm9wb3NlZF9leGVjdXRpb25faW'
    'QYASABKAlSE3Byb3Bvc2VkRXhlY3V0aW9uSWQSUQoKcGFnaW5hdGlvbhgCIAEoCzIxLnFvbWV0'
    'LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuUGFnaW5hdGlvblBhcmFtc1IKcGFnaW5hdGlvbh'
    'JmCghhdXhfZGF0YRhpIAMoCzJLLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuR2V0'
    'U3VwcG9ydGVkQ3VycmVuY2llc1JlcXVlc3QuQXV4RGF0YUVudHJ5UgdhdXhEYXRhGjoKDEF1eE'
    'RhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use getSupportedCurrenciesResponseDescriptor instead')
const GetSupportedCurrenciesResponse$json = {
  '1': 'GetSupportedCurrenciesResponse',
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
      '1': 'currencies',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Asset',
      '10': 'currencies'
    },
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetSupportedCurrenciesResponse.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [GetSupportedCurrenciesResponse_MetadataEntry$json],
};

@$core.Deprecated('Use getSupportedCurrenciesResponseDescriptor instead')
const GetSupportedCurrenciesResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetSupportedCurrenciesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportedCurrenciesResponseDescriptor = $convert.base64Decode(
    'Ch5HZXRTdXBwb3J0ZWRDdXJyZW5jaWVzUmVzcG9uc2USKAoQcmVmX2V4ZWN1dGlvbl9pZBgBIA'
    'EoCVIOcmVmRXhlY3V0aW9uSWQSWAoPcGFnaW5hdGlvbl9pbmZvGAIgASgLMi8ucW9tZXQuYWdv'
    'cmEuZGFlbW9ucy5wcnRhZ2VudC52MS5QYWdpbmF0aW9uSW5mb1IOcGFnaW5hdGlvbkluZm8SRg'
    'oKY3VycmVuY2llcxgDIAMoCzImLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuQXNz'
    'ZXRSCmN1cnJlbmNpZXMSaQoIbWV0YWRhdGEYaSADKAsyTS5xb21ldC5hZ29yYS5kYWVtb25zLn'
    'BydGFnZW50LnYxLkdldFN1cHBvcnRlZEN1cnJlbmNpZXNSZXNwb25zZS5NZXRhZGF0YUVudHJ5'
    'UghtZXRhZGF0YRo7Cg1NZXRhZGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGA'
    'IgASgJUgV2YWx1ZToCOAE=');
