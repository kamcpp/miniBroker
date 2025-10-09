//
//  Generated code. Do not modify.
//  source: instrument.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use getInstrumentListRequestDescriptor instead')
const GetInstrumentListRequest$json = {
  '1': 'GetInstrumentListRequest',
  '2': [
    {'1': 'proposed_execution_id', '3': 1, '4': 1, '5': 9, '10': 'proposedExecutionId'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.PaginationParams', '10': 'pagination'},
    {'1': 'market_id_or_symbol_regex', '3': 3, '4': 1, '5': 9, '10': 'marketIdOrSymbolRegex'},
    {'1': 'venue_id_or_symbol_regex', '3': 4, '4': 1, '5': 9, '10': 'venueIdOrSymbolRegex'},
    {'1': 'instrument_id_or_symbol_regex', '3': 5, '4': 1, '5': 9, '10': 'instrumentIdOrSymbolRegex'},
    {'1': 'listing_types', '3': 6, '4': 3, '5': 14, '6': '.qomet.agora.daemons.prtagent.v1.InstrumentListingStatusEnum', '10': 'listingTypes'},
    {'1': 'aux_data', '3': 105, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.GetInstrumentListRequest.AuxDataEntry', '10': 'auxData'},
  ],
  '3': [GetInstrumentListRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use getInstrumentListRequestDescriptor instead')
const GetInstrumentListRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetInstrumentListRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInstrumentListRequestDescriptor = $convert.base64Decode(
    'ChhHZXRJbnN0cnVtZW50TGlzdFJlcXVlc3QSMgoVcHJvcG9zZWRfZXhlY3V0aW9uX2lkGAEgAS'
    'gJUhNwcm9wb3NlZEV4ZWN1dGlvbklkElEKCnBhZ2luYXRpb24YAiABKAsyMS5xb21ldC5hZ29y'
    'YS5kYWVtb25zLnBydGFnZW50LnYxLlBhZ2luYXRpb25QYXJhbXNSCnBhZ2luYXRpb24SOAoZbW'
    'Fya2V0X2lkX29yX3N5bWJvbF9yZWdleBgDIAEoCVIVbWFya2V0SWRPclN5bWJvbFJlZ2V4EjYK'
    'GHZlbnVlX2lkX29yX3N5bWJvbF9yZWdleBgEIAEoCVIUdmVudWVJZE9yU3ltYm9sUmVnZXgSQA'
    'odaW5zdHJ1bWVudF9pZF9vcl9zeW1ib2xfcmVnZXgYBSABKAlSGWluc3RydW1lbnRJZE9yU3lt'
    'Ym9sUmVnZXgSYQoNbGlzdGluZ190eXBlcxgGIAMoDjI8LnFvbWV0LmFnb3JhLmRhZW1vbnMucH'
    'J0YWdlbnQudjEuSW5zdHJ1bWVudExpc3RpbmdTdGF0dXNFbnVtUgxsaXN0aW5nVHlwZXMSYQoI'
    'YXV4X2RhdGEYaSADKAsyRi5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkdldEluc3'
    'RydW1lbnRMaXN0UmVxdWVzdC5BdXhEYXRhRW50cnlSB2F1eERhdGEaOgoMQXV4RGF0YUVudHJ5'
    'EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use getInstrumentListResponseDescriptor instead')
const GetInstrumentListResponse$json = {
  '1': 'GetInstrumentListResponse',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {'1': 'pagination_info', '3': 2, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.PaginationInfo', '10': 'paginationInfo'},
    {'1': 'instruments', '3': 3, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.Instrument', '10': 'instruments'},
    {'1': 'metadata', '3': 105, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.GetInstrumentListResponse.MetadataEntry', '10': 'metadata'},
  ],
  '3': [GetInstrumentListResponse_MetadataEntry$json],
};

@$core.Deprecated('Use getInstrumentListResponseDescriptor instead')
const GetInstrumentListResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetInstrumentListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInstrumentListResponseDescriptor = $convert.base64Decode(
    'ChlHZXRJbnN0cnVtZW50TGlzdFJlc3BvbnNlEigKEHJlZl9leGVjdXRpb25faWQYASABKAlSDn'
    'JlZkV4ZWN1dGlvbklkElgKD3BhZ2luYXRpb25faW5mbxgCIAEoCzIvLnFvbWV0LmFnb3JhLmRh'
    'ZW1vbnMucHJ0YWdlbnQudjEuUGFnaW5hdGlvbkluZm9SDnBhZ2luYXRpb25JbmZvEk0KC2luc3'
    'RydW1lbnRzGAMgAygLMisucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5JbnN0cnVt'
    'ZW50UgtpbnN0cnVtZW50cxJkCghtZXRhZGF0YRhpIAMoCzJILnFvbWV0LmFnb3JhLmRhZW1vbn'
    'MucHJ0YWdlbnQudjEuR2V0SW5zdHJ1bWVudExpc3RSZXNwb25zZS5NZXRhZGF0YUVudHJ5Ught'
    'ZXRhZGF0YRo7Cg1NZXRhZGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgAS'
    'gJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use getInstrumentInfoBatchRequestDescriptor instead')
const GetInstrumentInfoBatchRequest$json = {
  '1': 'GetInstrumentInfoBatchRequest',
  '2': [
    {'1': 'proposed_execution_id', '3': 1, '4': 1, '5': 9, '10': 'proposedExecutionId'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.PaginationParams', '10': 'pagination'},
    {'1': 'instrument_id_and_symbol_regexes', '3': 3, '4': 3, '5': 9, '10': 'instrumentIdAndSymbolRegexes'},
    {'1': 'listing_types', '3': 4, '4': 3, '5': 14, '6': '.qomet.agora.daemons.prtagent.v1.InstrumentListingStatusEnum', '10': 'listingTypes'},
    {'1': 'aux_data', '3': 105, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.GetInstrumentInfoBatchRequest.AuxDataEntry', '10': 'auxData'},
  ],
  '3': [GetInstrumentInfoBatchRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use getInstrumentInfoBatchRequestDescriptor instead')
const GetInstrumentInfoBatchRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetInstrumentInfoBatchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInstrumentInfoBatchRequestDescriptor = $convert.base64Decode(
    'Ch1HZXRJbnN0cnVtZW50SW5mb0JhdGNoUmVxdWVzdBIyChVwcm9wb3NlZF9leGVjdXRpb25faW'
    'QYASABKAlSE3Byb3Bvc2VkRXhlY3V0aW9uSWQSUQoKcGFnaW5hdGlvbhgCIAEoCzIxLnFvbWV0'
    'LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuUGFnaW5hdGlvblBhcmFtc1IKcGFnaW5hdGlvbh'
    'JGCiBpbnN0cnVtZW50X2lkX2FuZF9zeW1ib2xfcmVnZXhlcxgDIAMoCVIcaW5zdHJ1bWVudElk'
    'QW5kU3ltYm9sUmVnZXhlcxJhCg1saXN0aW5nX3R5cGVzGAQgAygOMjwucW9tZXQuYWdvcmEuZG'
    'FlbW9ucy5wcnRhZ2VudC52MS5JbnN0cnVtZW50TGlzdGluZ1N0YXR1c0VudW1SDGxpc3RpbmdU'
    'eXBlcxJmCghhdXhfZGF0YRhpIAMoCzJLLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudj'
    'EuR2V0SW5zdHJ1bWVudEluZm9CYXRjaFJlcXVlc3QuQXV4RGF0YUVudHJ5UgdhdXhEYXRhGjoK'
    'DEF1eERhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6Aj'
    'gB');

@$core.Deprecated('Use getInstrumentInfoBatchResponseDescriptor instead')
const GetInstrumentInfoBatchResponse$json = {
  '1': 'GetInstrumentInfoBatchResponse',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {'1': 'pagination_info', '3': 3, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.PaginationInfo', '10': 'paginationInfo'},
    {'1': 'instruments', '3': 4, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.Instrument', '10': 'instruments'},
    {'1': 'metadata', '3': 105, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.GetInstrumentInfoBatchResponse.MetadataEntry', '10': 'metadata'},
  ],
  '3': [GetInstrumentInfoBatchResponse_MetadataEntry$json],
};

@$core.Deprecated('Use getInstrumentInfoBatchResponseDescriptor instead')
const GetInstrumentInfoBatchResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetInstrumentInfoBatchResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInstrumentInfoBatchResponseDescriptor = $convert.base64Decode(
    'Ch5HZXRJbnN0cnVtZW50SW5mb0JhdGNoUmVzcG9uc2USKAoQcmVmX2V4ZWN1dGlvbl9pZBgBIA'
    'EoCVIOcmVmRXhlY3V0aW9uSWQSWAoPcGFnaW5hdGlvbl9pbmZvGAMgASgLMi8ucW9tZXQuYWdv'
    'cmEuZGFlbW9ucy5wcnRhZ2VudC52MS5QYWdpbmF0aW9uSW5mb1IOcGFnaW5hdGlvbkluZm8STQ'
    'oLaW5zdHJ1bWVudHMYBCADKAsyKy5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLklu'
    'c3RydW1lbnRSC2luc3RydW1lbnRzEmkKCG1ldGFkYXRhGGkgAygLMk0ucW9tZXQuYWdvcmEuZG'
    'FlbW9ucy5wcnRhZ2VudC52MS5HZXRJbnN0cnVtZW50SW5mb0JhdGNoUmVzcG9uc2UuTWV0YWRh'
    'dGFFbnRyeVIIbWV0YWRhdGEaOwoNTWV0YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCg'
    'V2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use getInstrumentOrdersRequestDescriptor instead')
const GetInstrumentOrdersRequest$json = {
  '1': 'GetInstrumentOrdersRequest',
  '2': [
    {'1': 'proposed_execution_id', '3': 1, '4': 1, '5': 9, '10': 'proposedExecutionId'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.PaginationParams', '10': 'pagination'},
    {'1': 'instrument_id_and_symbol_regexes', '3': 3, '4': 3, '5': 9, '10': 'instrumentIdAndSymbolRegexes'},
    {'1': 'order_query_filter', '3': 4, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.OrderQueryFilter', '10': 'orderQueryFilter'},
    {'1': 'aux_data', '3': 105, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.GetInstrumentOrdersRequest.AuxDataEntry', '10': 'auxData'},
  ],
  '3': [GetInstrumentOrdersRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use getInstrumentOrdersRequestDescriptor instead')
const GetInstrumentOrdersRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetInstrumentOrdersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInstrumentOrdersRequestDescriptor = $convert.base64Decode(
    'ChpHZXRJbnN0cnVtZW50T3JkZXJzUmVxdWVzdBIyChVwcm9wb3NlZF9leGVjdXRpb25faWQYAS'
    'ABKAlSE3Byb3Bvc2VkRXhlY3V0aW9uSWQSUQoKcGFnaW5hdGlvbhgCIAEoCzIxLnFvbWV0LmFn'
    'b3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuUGFnaW5hdGlvblBhcmFtc1IKcGFnaW5hdGlvbhJGCi'
    'BpbnN0cnVtZW50X2lkX2FuZF9zeW1ib2xfcmVnZXhlcxgDIAMoCVIcaW5zdHJ1bWVudElkQW5k'
    'U3ltYm9sUmVnZXhlcxJfChJvcmRlcl9xdWVyeV9maWx0ZXIYBCABKAsyMS5xb21ldC5hZ29yYS'
    '5kYWVtb25zLnBydGFnZW50LnYxLk9yZGVyUXVlcnlGaWx0ZXJSEG9yZGVyUXVlcnlGaWx0ZXIS'
    'YwoIYXV4X2RhdGEYaSADKAsySC5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkdldE'
    'luc3RydW1lbnRPcmRlcnNSZXF1ZXN0LkF1eERhdGFFbnRyeVIHYXV4RGF0YRo6CgxBdXhEYXRh'
    'RW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use getInstrumentOrdersResponseDescriptor instead')
const GetInstrumentOrdersResponse$json = {
  '1': 'GetInstrumentOrdersResponse',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {'1': 'pagination_info', '3': 2, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.PaginationInfo', '10': 'paginationInfo'},
    {'1': 'orders', '3': 3, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.Order', '10': 'orders'},
    {'1': 'metadata', '3': 105, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.GetInstrumentOrdersResponse.MetadataEntry', '10': 'metadata'},
  ],
  '3': [GetInstrumentOrdersResponse_MetadataEntry$json],
};

@$core.Deprecated('Use getInstrumentOrdersResponseDescriptor instead')
const GetInstrumentOrdersResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetInstrumentOrdersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInstrumentOrdersResponseDescriptor = $convert.base64Decode(
    'ChtHZXRJbnN0cnVtZW50T3JkZXJzUmVzcG9uc2USKAoQcmVmX2V4ZWN1dGlvbl9pZBgBIAEoCV'
    'IOcmVmRXhlY3V0aW9uSWQSWAoPcGFnaW5hdGlvbl9pbmZvGAIgASgLMi8ucW9tZXQuYWdvcmEu'
    'ZGFlbW9ucy5wcnRhZ2VudC52MS5QYWdpbmF0aW9uSW5mb1IOcGFnaW5hdGlvbkluZm8SPgoGb3'
    'JkZXJzGAMgAygLMiYucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5PcmRlclIGb3Jk'
    'ZXJzEmYKCG1ldGFkYXRhGGkgAygLMkoucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS'
    '5HZXRJbnN0cnVtZW50T3JkZXJzUmVzcG9uc2UuTWV0YWRhdGFFbnRyeVIIbWV0YWRhdGEaOwoN'
    'TWV0YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6Aj'
    'gB');

@$core.Deprecated('Use getInstrumentTradesRequestDescriptor instead')
const GetInstrumentTradesRequest$json = {
  '1': 'GetInstrumentTradesRequest',
  '2': [
    {'1': 'proposed_execution_id', '3': 1, '4': 1, '5': 9, '10': 'proposedExecutionId'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.PaginationParams', '10': 'pagination'},
    {'1': 'instrument_id_and_symbol_regexes', '3': 3, '4': 3, '5': 9, '10': 'instrumentIdAndSymbolRegexes'},
    {'1': 'trade_query_filter', '3': 4, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.TradeQueryFilter', '10': 'tradeQueryFilter'},
    {'1': 'aux_data', '3': 105, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.GetInstrumentTradesRequest.AuxDataEntry', '10': 'auxData'},
  ],
  '3': [GetInstrumentTradesRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use getInstrumentTradesRequestDescriptor instead')
const GetInstrumentTradesRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetInstrumentTradesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInstrumentTradesRequestDescriptor = $convert.base64Decode(
    'ChpHZXRJbnN0cnVtZW50VHJhZGVzUmVxdWVzdBIyChVwcm9wb3NlZF9leGVjdXRpb25faWQYAS'
    'ABKAlSE3Byb3Bvc2VkRXhlY3V0aW9uSWQSUQoKcGFnaW5hdGlvbhgCIAEoCzIxLnFvbWV0LmFn'
    'b3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuUGFnaW5hdGlvblBhcmFtc1IKcGFnaW5hdGlvbhJGCi'
    'BpbnN0cnVtZW50X2lkX2FuZF9zeW1ib2xfcmVnZXhlcxgDIAMoCVIcaW5zdHJ1bWVudElkQW5k'
    'U3ltYm9sUmVnZXhlcxJfChJ0cmFkZV9xdWVyeV9maWx0ZXIYBCABKAsyMS5xb21ldC5hZ29yYS'
    '5kYWVtb25zLnBydGFnZW50LnYxLlRyYWRlUXVlcnlGaWx0ZXJSEHRyYWRlUXVlcnlGaWx0ZXIS'
    'YwoIYXV4X2RhdGEYaSADKAsySC5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkdldE'
    'luc3RydW1lbnRUcmFkZXNSZXF1ZXN0LkF1eERhdGFFbnRyeVIHYXV4RGF0YRo6CgxBdXhEYXRh'
    'RW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use getInstrumentTradesResponseDescriptor instead')
const GetInstrumentTradesResponse$json = {
  '1': 'GetInstrumentTradesResponse',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {'1': 'pagination_info', '3': 2, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.PaginationInfo', '10': 'paginationInfo'},
    {'1': 'trades', '3': 3, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.Trade', '10': 'trades'},
    {'1': 'metadata', '3': 105, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.GetInstrumentTradesResponse.MetadataEntry', '10': 'metadata'},
  ],
  '3': [GetInstrumentTradesResponse_MetadataEntry$json],
};

@$core.Deprecated('Use getInstrumentTradesResponseDescriptor instead')
const GetInstrumentTradesResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetInstrumentTradesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInstrumentTradesResponseDescriptor = $convert.base64Decode(
    'ChtHZXRJbnN0cnVtZW50VHJhZGVzUmVzcG9uc2USKAoQcmVmX2V4ZWN1dGlvbl9pZBgBIAEoCV'
    'IOcmVmRXhlY3V0aW9uSWQSWAoPcGFnaW5hdGlvbl9pbmZvGAIgASgLMi8ucW9tZXQuYWdvcmEu'
    'ZGFlbW9ucy5wcnRhZ2VudC52MS5QYWdpbmF0aW9uSW5mb1IOcGFnaW5hdGlvbkluZm8SPgoGdH'
    'JhZGVzGAMgAygLMiYucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5UcmFkZVIGdHJh'
    'ZGVzEmYKCG1ldGFkYXRhGGkgAygLMkoucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS'
    '5HZXRJbnN0cnVtZW50VHJhZGVzUmVzcG9uc2UuTWV0YWRhdGFFbnRyeVIIbWV0YWRhdGEaOwoN'
    'TWV0YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6Aj'
    'gB');

@$core.Deprecated('Use getInstrumentSettlementsRequestDescriptor instead')
const GetInstrumentSettlementsRequest$json = {
  '1': 'GetInstrumentSettlementsRequest',
  '2': [
    {'1': 'proposed_execution_id', '3': 1, '4': 1, '5': 9, '10': 'proposedExecutionId'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.PaginationParams', '10': 'pagination'},
    {'1': 'instrument_id_and_symbol_regexes', '3': 3, '4': 3, '5': 9, '10': 'instrumentIdAndSymbolRegexes'},
    {'1': 'settlement_query_filter', '3': 4, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.SettlementQueryFilter', '10': 'settlementQueryFilter'},
    {'1': 'aux_data', '3': 105, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.GetInstrumentSettlementsRequest.AuxDataEntry', '10': 'auxData'},
  ],
  '3': [GetInstrumentSettlementsRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use getInstrumentSettlementsRequestDescriptor instead')
const GetInstrumentSettlementsRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetInstrumentSettlementsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInstrumentSettlementsRequestDescriptor = $convert.base64Decode(
    'Ch9HZXRJbnN0cnVtZW50U2V0dGxlbWVudHNSZXF1ZXN0EjIKFXByb3Bvc2VkX2V4ZWN1dGlvbl'
    '9pZBgBIAEoCVITcHJvcG9zZWRFeGVjdXRpb25JZBJRCgpwYWdpbmF0aW9uGAIgASgLMjEucW9t'
    'ZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5QYWdpbmF0aW9uUGFyYW1zUgpwYWdpbmF0aW'
    '9uEkYKIGluc3RydW1lbnRfaWRfYW5kX3N5bWJvbF9yZWdleGVzGAMgAygJUhxpbnN0cnVtZW50'
    'SWRBbmRTeW1ib2xSZWdleGVzEm4KF3NldHRsZW1lbnRfcXVlcnlfZmlsdGVyGAQgASgLMjYucW'
    '9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5TZXR0bGVtZW50UXVlcnlGaWx0ZXJSFXNl'
    'dHRsZW1lbnRRdWVyeUZpbHRlchJoCghhdXhfZGF0YRhpIAMoCzJNLnFvbWV0LmFnb3JhLmRhZW'
    '1vbnMucHJ0YWdlbnQudjEuR2V0SW5zdHJ1bWVudFNldHRsZW1lbnRzUmVxdWVzdC5BdXhEYXRh'
    'RW50cnlSB2F1eERhdGEaOgoMQXV4RGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbH'
    'VlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use getInstrumentSettlementsResponseDescriptor instead')
const GetInstrumentSettlementsResponse$json = {
  '1': 'GetInstrumentSettlementsResponse',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {'1': 'pagination_info', '3': 2, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.PaginationInfo', '10': 'paginationInfo'},
    {'1': 'settlements', '3': 3, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.Settlement', '10': 'settlements'},
    {'1': 'metadata', '3': 105, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.GetInstrumentSettlementsResponse.MetadataEntry', '10': 'metadata'},
  ],
  '3': [GetInstrumentSettlementsResponse_MetadataEntry$json],
};

@$core.Deprecated('Use getInstrumentSettlementsResponseDescriptor instead')
const GetInstrumentSettlementsResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetInstrumentSettlementsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInstrumentSettlementsResponseDescriptor = $convert.base64Decode(
    'CiBHZXRJbnN0cnVtZW50U2V0dGxlbWVudHNSZXNwb25zZRIoChByZWZfZXhlY3V0aW9uX2lkGA'
    'EgASgJUg5yZWZFeGVjdXRpb25JZBJYCg9wYWdpbmF0aW9uX2luZm8YAiABKAsyLy5xb21ldC5h'
    'Z29yYS5kYWVtb25zLnBydGFnZW50LnYxLlBhZ2luYXRpb25JbmZvUg5wYWdpbmF0aW9uSW5mbx'
    'JNCgtzZXR0bGVtZW50cxgDIAMoCzIrLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEu'
    'U2V0dGxlbWVudFILc2V0dGxlbWVudHMSawoIbWV0YWRhdGEYaSADKAsyTy5xb21ldC5hZ29yYS'
    '5kYWVtb25zLnBydGFnZW50LnYxLkdldEluc3RydW1lbnRTZXR0bGVtZW50c1Jlc3BvbnNlLk1l'
    'dGFkYXRhRW50cnlSCG1ldGFkYXRhGjsKDU1ldGFkYXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZX'
    'kSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

