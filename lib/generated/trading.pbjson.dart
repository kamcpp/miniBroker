//
//  Generated code. Do not modify.
//  source: trading.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use instrumentQuoteDescriptor instead')
const InstrumentQuote$json = {
  '1': 'InstrumentQuote',
  '2': [
    {'1': 'instrument', '3': 1, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.Instrument', '10': 'instrument'},
    {'1': 'amount', '3': 2, '4': 1, '5': 9, '10': 'amount'},
  ],
};

/// Descriptor for `InstrumentQuote`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List instrumentQuoteDescriptor = $convert.base64Decode(
    'Cg9JbnN0cnVtZW50UXVvdGUSSwoKaW5zdHJ1bWVudBgBIAEoCzIrLnFvbWV0LmFnb3JhLmRhZW'
    '1vbnMucHJ0YWdlbnQudjEuSW5zdHJ1bWVudFIKaW5zdHJ1bWVudBIWCgZhbW91bnQYAiABKAlS'
    'BmFtb3VudA==');

@$core.Deprecated('Use instrumentQuoteResponseDescriptor instead')
const InstrumentQuoteResponse$json = {
  '1': 'InstrumentQuoteResponse',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {'1': 'quote', '3': 3, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.InstrumentQuote', '10': 'quote'},
    {'1': 'metadata', '3': 105, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.InstrumentQuoteResponse.MetadataEntry', '10': 'metadata'},
  ],
  '3': [InstrumentQuoteResponse_MetadataEntry$json],
};

@$core.Deprecated('Use instrumentQuoteResponseDescriptor instead')
const InstrumentQuoteResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `InstrumentQuoteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List instrumentQuoteResponseDescriptor = $convert.base64Decode(
    'ChdJbnN0cnVtZW50UXVvdGVSZXNwb25zZRIoChByZWZfZXhlY3V0aW9uX2lkGAEgASgJUg5yZW'
    'ZFeGVjdXRpb25JZBJGCgVxdW90ZRgDIAEoCzIwLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdl'
    'bnQudjEuSW5zdHJ1bWVudFF1b3RlUgVxdW90ZRJiCghtZXRhZGF0YRhpIAMoCzJGLnFvbWV0Lm'
    'Fnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuSW5zdHJ1bWVudFF1b3RlUmVzcG9uc2UuTWV0YWRh'
    'dGFFbnRyeVIIbWV0YWRhdGEaOwoNTWV0YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCg'
    'V2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use ohlcDataDescriptor instead')
const OhlcData$json = {
  '1': 'OhlcData',
  '2': [
    {'1': 'instrument', '3': 3, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.Instrument', '10': 'instrument'},
    {'1': 'duration', '3': 4, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.Duration', '10': 'duration'},
    {'1': 'open', '3': 5, '4': 1, '5': 9, '10': 'open'},
    {'1': 'high', '3': 6, '4': 1, '5': 9, '10': 'high'},
    {'1': 'low', '3': 7, '4': 1, '5': 9, '10': 'low'},
    {'1': 'close', '3': 8, '4': 1, '5': 9, '10': 'close'},
    {'1': 'volume', '3': 9, '4': 1, '5': 9, '10': 'volume'},
  ],
};

/// Descriptor for `OhlcData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ohlcDataDescriptor = $convert.base64Decode(
    'CghPaGxjRGF0YRJLCgppbnN0cnVtZW50GAMgASgLMisucW9tZXQuYWdvcmEuZGFlbW9ucy5wcn'
    'RhZ2VudC52MS5JbnN0cnVtZW50UgppbnN0cnVtZW50EkUKCGR1cmF0aW9uGAQgASgLMikucW9t'
    'ZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5EdXJhdGlvblIIZHVyYXRpb24SEgoEb3Blbh'
    'gFIAEoCVIEb3BlbhISCgRoaWdoGAYgASgJUgRoaWdoEhAKA2xvdxgHIAEoCVIDbG93EhQKBWNs'
    'b3NlGAggASgJUgVjbG9zZRIWCgZ2b2x1bWUYCSABKAlSBnZvbHVtZQ==');

@$core.Deprecated('Use ohlcDataResponseDescriptor instead')
const OhlcDataResponse$json = {
  '1': 'OhlcDataResponse',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {'1': 'ohlc_data', '3': 3, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.OhlcData', '10': 'ohlcData'},
    {'1': 'metadata', '3': 105, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.OhlcDataResponse.MetadataEntry', '10': 'metadata'},
  ],
  '3': [OhlcDataResponse_MetadataEntry$json],
};

@$core.Deprecated('Use ohlcDataResponseDescriptor instead')
const OhlcDataResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `OhlcDataResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ohlcDataResponseDescriptor = $convert.base64Decode(
    'ChBPaGxjRGF0YVJlc3BvbnNlEigKEHJlZl9leGVjdXRpb25faWQYASABKAlSDnJlZkV4ZWN1dG'
    'lvbklkEkYKCW9obGNfZGF0YRgDIAEoCzIpLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQu'
    'djEuT2hsY0RhdGFSCG9obGNEYXRhElsKCG1ldGFkYXRhGGkgAygLMj8ucW9tZXQuYWdvcmEuZG'
    'FlbW9ucy5wcnRhZ2VudC52MS5PaGxjRGF0YVJlc3BvbnNlLk1ldGFkYXRhRW50cnlSCG1ldGFk'
    'YXRhGjsKDU1ldGFkYXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBX'
    'ZhbHVlOgI4AQ==');

@$core.Deprecated('Use getLatestQuoteRequestDescriptor instead')
const GetLatestQuoteRequest$json = {
  '1': 'GetLatestQuoteRequest',
  '2': [
    {'1': 'proposed_execution_id', '3': 1, '4': 1, '5': 9, '10': 'proposedExecutionId'},
    {'1': 'instrument_id_and_symbol_regexes', '3': 2, '4': 3, '5': 9, '10': 'instrumentIdAndSymbolRegexes'},
    {'1': 'aux_data', '3': 105, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.GetLatestQuoteRequest.AuxDataEntry', '10': 'auxData'},
  ],
  '3': [GetLatestQuoteRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use getLatestQuoteRequestDescriptor instead')
const GetLatestQuoteRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetLatestQuoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLatestQuoteRequestDescriptor = $convert.base64Decode(
    'ChVHZXRMYXRlc3RRdW90ZVJlcXVlc3QSMgoVcHJvcG9zZWRfZXhlY3V0aW9uX2lkGAEgASgJUh'
    'Nwcm9wb3NlZEV4ZWN1dGlvbklkEkYKIGluc3RydW1lbnRfaWRfYW5kX3N5bWJvbF9yZWdleGVz'
    'GAIgAygJUhxpbnN0cnVtZW50SWRBbmRTeW1ib2xSZWdleGVzEl4KCGF1eF9kYXRhGGkgAygLMk'
    'MucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5HZXRMYXRlc3RRdW90ZVJlcXVlc3Qu'
    'QXV4RGF0YUVudHJ5UgdhdXhEYXRhGjoKDEF1eERhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleR'
    'IUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use liveQuoteFetchParamsDescriptor instead')
const LiveQuoteFetchParams$json = {
  '1': 'LiveQuoteFetchParams',
  '2': [
    {'1': 'update_interval_ms', '3': 1, '4': 1, '5': 13, '10': 'updateIntervalMs'},
    {'1': 'max_duration_ms', '3': 2, '4': 1, '5': 13, '10': 'maxDurationMs'},
    {'1': 'include_depth', '3': 3, '4': 1, '5': 8, '10': 'includeDepth'},
    {'1': 'depth_levels', '3': 4, '4': 1, '5': 13, '10': 'depthLevels'},
    {'1': 'include_trades', '3': 5, '4': 1, '5': 8, '10': 'includeTrades'},
  ],
};

/// Descriptor for `LiveQuoteFetchParams`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List liveQuoteFetchParamsDescriptor = $convert.base64Decode(
    'ChRMaXZlUXVvdGVGZXRjaFBhcmFtcxIsChJ1cGRhdGVfaW50ZXJ2YWxfbXMYASABKA1SEHVwZG'
    'F0ZUludGVydmFsTXMSJgoPbWF4X2R1cmF0aW9uX21zGAIgASgNUg1tYXhEdXJhdGlvbk1zEiMK'
    'DWluY2x1ZGVfZGVwdGgYAyABKAhSDGluY2x1ZGVEZXB0aBIhCgxkZXB0aF9sZXZlbHMYBCABKA'
    '1SC2RlcHRoTGV2ZWxzEiUKDmluY2x1ZGVfdHJhZGVzGAUgASgIUg1pbmNsdWRlVHJhZGVz');

@$core.Deprecated('Use fetchLiveQuoteRequestDescriptor instead')
const FetchLiveQuoteRequest$json = {
  '1': 'FetchLiveQuoteRequest',
  '2': [
    {'1': 'proposed_execution_id', '3': 1, '4': 1, '5': 9, '10': 'proposedExecutionId'},
    {'1': 'instrument_id_and_symbol_regexes', '3': 2, '4': 3, '5': 9, '10': 'instrumentIdAndSymbolRegexes'},
    {'1': 'fetch_params', '3': 3, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.LiveQuoteFetchParams', '10': 'fetchParams'},
    {'1': 'aux_data', '3': 105, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.FetchLiveQuoteRequest.AuxDataEntry', '10': 'auxData'},
  ],
  '3': [FetchLiveQuoteRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use fetchLiveQuoteRequestDescriptor instead')
const FetchLiveQuoteRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `FetchLiveQuoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchLiveQuoteRequestDescriptor = $convert.base64Decode(
    'ChVGZXRjaExpdmVRdW90ZVJlcXVlc3QSMgoVcHJvcG9zZWRfZXhlY3V0aW9uX2lkGAEgASgJUh'
    'Nwcm9wb3NlZEV4ZWN1dGlvbklkEkYKIGluc3RydW1lbnRfaWRfYW5kX3N5bWJvbF9yZWdleGVz'
    'GAIgAygJUhxpbnN0cnVtZW50SWRBbmRTeW1ib2xSZWdleGVzElgKDGZldGNoX3BhcmFtcxgDIA'
    'EoCzI1LnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuTGl2ZVF1b3RlRmV0Y2hQYXJh'
    'bXNSC2ZldGNoUGFyYW1zEl4KCGF1eF9kYXRhGGkgAygLMkMucW9tZXQuYWdvcmEuZGFlbW9ucy'
    '5wcnRhZ2VudC52MS5GZXRjaExpdmVRdW90ZVJlcXVlc3QuQXV4RGF0YUVudHJ5UgdhdXhEYXRh'
    'GjoKDEF1eERhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdW'
    'U6AjgB');

@$core.Deprecated('Use getHistoricalQuoteRequestDescriptor instead')
const GetHistoricalQuoteRequest$json = {
  '1': 'GetHistoricalQuoteRequest',
  '2': [
    {'1': 'proposed_execution_id', '3': 1, '4': 1, '5': 9, '10': 'proposedExecutionId'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.PaginationParams', '10': 'pagination'},
    {'1': 'instrument_id_and_symbol_regexes', '3': 3, '4': 3, '5': 9, '10': 'instrumentIdAndSymbolRegexes'},
    {'1': 'duration', '3': 4, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.Duration', '9': 0, '10': 'duration', '17': true},
    {'1': 'aux_data', '3': 105, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.GetHistoricalQuoteRequest.AuxDataEntry', '10': 'auxData'},
  ],
  '3': [GetHistoricalQuoteRequest_AuxDataEntry$json],
  '8': [
    {'1': '_duration'},
  ],
};

@$core.Deprecated('Use getHistoricalQuoteRequestDescriptor instead')
const GetHistoricalQuoteRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetHistoricalQuoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getHistoricalQuoteRequestDescriptor = $convert.base64Decode(
    'ChlHZXRIaXN0b3JpY2FsUXVvdGVSZXF1ZXN0EjIKFXByb3Bvc2VkX2V4ZWN1dGlvbl9pZBgBIA'
    'EoCVITcHJvcG9zZWRFeGVjdXRpb25JZBJRCgpwYWdpbmF0aW9uGAIgASgLMjEucW9tZXQuYWdv'
    'cmEuZGFlbW9ucy5wcnRhZ2VudC52MS5QYWdpbmF0aW9uUGFyYW1zUgpwYWdpbmF0aW9uEkYKIG'
    'luc3RydW1lbnRfaWRfYW5kX3N5bWJvbF9yZWdleGVzGAMgAygJUhxpbnN0cnVtZW50SWRBbmRT'
    'eW1ib2xSZWdleGVzEkoKCGR1cmF0aW9uGAQgASgLMikucW9tZXQuYWdvcmEuZGFlbW9ucy5wcn'
    'RhZ2VudC52MS5EdXJhdGlvbkgAUghkdXJhdGlvbogBARJiCghhdXhfZGF0YRhpIAMoCzJHLnFv'
    'bWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuR2V0SGlzdG9yaWNhbFF1b3RlUmVxdWVzdC'
    '5BdXhEYXRhRW50cnlSB2F1eERhdGEaOgoMQXV4RGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5'
    'EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAFCCwoJX2R1cmF0aW9u');

@$core.Deprecated('Use getHistoricalQuoteResponseDescriptor instead')
const GetHistoricalQuoteResponse$json = {
  '1': 'GetHistoricalQuoteResponse',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {'1': 'pagination_info', '3': 2, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.PaginationInfo', '10': 'paginationInfo'},
    {'1': 'quotes', '3': 3, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.InstrumentQuote', '10': 'quotes'},
    {'1': 'metadata', '3': 105, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.GetHistoricalQuoteResponse.MetadataEntry', '10': 'metadata'},
  ],
  '3': [GetHistoricalQuoteResponse_MetadataEntry$json],
};

@$core.Deprecated('Use getHistoricalQuoteResponseDescriptor instead')
const GetHistoricalQuoteResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetHistoricalQuoteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getHistoricalQuoteResponseDescriptor = $convert.base64Decode(
    'ChpHZXRIaXN0b3JpY2FsUXVvdGVSZXNwb25zZRIoChByZWZfZXhlY3V0aW9uX2lkGAEgASgJUg'
    '5yZWZFeGVjdXRpb25JZBJYCg9wYWdpbmF0aW9uX2luZm8YAiABKAsyLy5xb21ldC5hZ29yYS5k'
    'YWVtb25zLnBydGFnZW50LnYxLlBhZ2luYXRpb25JbmZvUg5wYWdpbmF0aW9uSW5mbxJICgZxdW'
    '90ZXMYAyADKAsyMC5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkluc3RydW1lbnRR'
    'dW90ZVIGcXVvdGVzEmUKCG1ldGFkYXRhGGkgAygLMkkucW9tZXQuYWdvcmEuZGFlbW9ucy5wcn'
    'RhZ2VudC52MS5HZXRIaXN0b3JpY2FsUXVvdGVSZXNwb25zZS5NZXRhZGF0YUVudHJ5UghtZXRh'
    'ZGF0YRo7Cg1NZXRhZGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUg'
    'V2YWx1ZToCOAE=');

@$core.Deprecated('Use liveOhlcDataFetchParamsDescriptor instead')
const LiveOhlcDataFetchParams$json = {
  '1': 'LiveOhlcDataFetchParams',
  '2': [
    {'1': 'update_interval_ms', '3': 1, '4': 1, '5': 13, '10': 'updateIntervalMs'},
    {'1': 'max_duration_ms', '3': 2, '4': 1, '5': 13, '10': 'maxDurationMs'},
    {'1': 'period', '3': 3, '4': 1, '5': 9, '10': 'period'},
    {'1': 'include_volume', '3': 4, '4': 1, '5': 8, '10': 'includeVolume'},
    {'1': 'include_indicators', '3': 5, '4': 1, '5': 8, '10': 'includeIndicators'},
  ],
};

/// Descriptor for `LiveOhlcDataFetchParams`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List liveOhlcDataFetchParamsDescriptor = $convert.base64Decode(
    'ChdMaXZlT2hsY0RhdGFGZXRjaFBhcmFtcxIsChJ1cGRhdGVfaW50ZXJ2YWxfbXMYASABKA1SEH'
    'VwZGF0ZUludGVydmFsTXMSJgoPbWF4X2R1cmF0aW9uX21zGAIgASgNUg1tYXhEdXJhdGlvbk1z'
    'EhYKBnBlcmlvZBgDIAEoCVIGcGVyaW9kEiUKDmluY2x1ZGVfdm9sdW1lGAQgASgIUg1pbmNsdW'
    'RlVm9sdW1lEi0KEmluY2x1ZGVfaW5kaWNhdG9ycxgFIAEoCFIRaW5jbHVkZUluZGljYXRvcnM=');

@$core.Deprecated('Use fetchLiveOhlcDataRequestDescriptor instead')
const FetchLiveOhlcDataRequest$json = {
  '1': 'FetchLiveOhlcDataRequest',
  '2': [
    {'1': 'proposed_execution_id', '3': 1, '4': 1, '5': 9, '10': 'proposedExecutionId'},
    {'1': 'instrument_id_and_symbol_regexes', '3': 2, '4': 3, '5': 9, '10': 'instrumentIdAndSymbolRegexes'},
    {'1': 'fetch_params', '3': 3, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.LiveOhlcDataFetchParams', '10': 'fetchParams'},
    {'1': 'aux_data', '3': 105, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.FetchLiveOhlcDataRequest.AuxDataEntry', '10': 'auxData'},
  ],
  '3': [FetchLiveOhlcDataRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use fetchLiveOhlcDataRequestDescriptor instead')
const FetchLiveOhlcDataRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `FetchLiveOhlcDataRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchLiveOhlcDataRequestDescriptor = $convert.base64Decode(
    'ChhGZXRjaExpdmVPaGxjRGF0YVJlcXVlc3QSMgoVcHJvcG9zZWRfZXhlY3V0aW9uX2lkGAEgAS'
    'gJUhNwcm9wb3NlZEV4ZWN1dGlvbklkEkYKIGluc3RydW1lbnRfaWRfYW5kX3N5bWJvbF9yZWdl'
    'eGVzGAIgAygJUhxpbnN0cnVtZW50SWRBbmRTeW1ib2xSZWdleGVzElsKDGZldGNoX3BhcmFtcx'
    'gDIAEoCzI4LnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuTGl2ZU9obGNEYXRhRmV0'
    'Y2hQYXJhbXNSC2ZldGNoUGFyYW1zEmEKCGF1eF9kYXRhGGkgAygLMkYucW9tZXQuYWdvcmEuZG'
    'FlbW9ucy5wcnRhZ2VudC52MS5GZXRjaExpdmVPaGxjRGF0YVJlcXVlc3QuQXV4RGF0YUVudHJ5'
    'UgdhdXhEYXRhGjoKDEF1eERhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIA'
    'EoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use getHistoricalOhlcDataRequestDescriptor instead')
const GetHistoricalOhlcDataRequest$json = {
  '1': 'GetHistoricalOhlcDataRequest',
  '2': [
    {'1': 'proposed_execution_id', '3': 1, '4': 1, '5': 9, '10': 'proposedExecutionId'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.PaginationParams', '10': 'pagination'},
    {'1': 'instrument_id_and_symbol_regexes', '3': 3, '4': 3, '5': 9, '10': 'instrumentIdAndSymbolRegexes'},
    {'1': 'duration', '3': 4, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.Duration', '9': 0, '10': 'duration', '17': true},
    {'1': 'period', '3': 5, '4': 1, '5': 9, '10': 'period'},
    {'1': 'include_volume', '3': 6, '4': 1, '5': 8, '10': 'includeVolume'},
    {'1': 'aux_data', '3': 105, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.GetHistoricalOhlcDataRequest.AuxDataEntry', '10': 'auxData'},
  ],
  '3': [GetHistoricalOhlcDataRequest_AuxDataEntry$json],
  '8': [
    {'1': '_duration'},
  ],
};

@$core.Deprecated('Use getHistoricalOhlcDataRequestDescriptor instead')
const GetHistoricalOhlcDataRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetHistoricalOhlcDataRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getHistoricalOhlcDataRequestDescriptor = $convert.base64Decode(
    'ChxHZXRIaXN0b3JpY2FsT2hsY0RhdGFSZXF1ZXN0EjIKFXByb3Bvc2VkX2V4ZWN1dGlvbl9pZB'
    'gBIAEoCVITcHJvcG9zZWRFeGVjdXRpb25JZBJRCgpwYWdpbmF0aW9uGAIgASgLMjEucW9tZXQu'
    'YWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5QYWdpbmF0aW9uUGFyYW1zUgpwYWdpbmF0aW9uEk'
    'YKIGluc3RydW1lbnRfaWRfYW5kX3N5bWJvbF9yZWdleGVzGAMgAygJUhxpbnN0cnVtZW50SWRB'
    'bmRTeW1ib2xSZWdleGVzEkoKCGR1cmF0aW9uGAQgASgLMikucW9tZXQuYWdvcmEuZGFlbW9ucy'
    '5wcnRhZ2VudC52MS5EdXJhdGlvbkgAUghkdXJhdGlvbogBARIWCgZwZXJpb2QYBSABKAlSBnBl'
    'cmlvZBIlCg5pbmNsdWRlX3ZvbHVtZRgGIAEoCFINaW5jbHVkZVZvbHVtZRJlCghhdXhfZGF0YR'
    'hpIAMoCzJKLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuR2V0SGlzdG9yaWNhbE9o'
    'bGNEYXRhUmVxdWVzdC5BdXhEYXRhRW50cnlSB2F1eERhdGEaOgoMQXV4RGF0YUVudHJ5EhAKA2'
    'tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAFCCwoJX2R1cmF0aW9u');

@$core.Deprecated('Use getHistoricalOhlcDataResponseDescriptor instead')
const GetHistoricalOhlcDataResponse$json = {
  '1': 'GetHistoricalOhlcDataResponse',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {'1': 'pagination_info', '3': 2, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.PaginationInfo', '10': 'paginationInfo'},
    {'1': 'ohlc_datas', '3': 3, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.OhlcData', '10': 'ohlcDatas'},
    {'1': 'metadata', '3': 105, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.GetHistoricalOhlcDataResponse.MetadataEntry', '10': 'metadata'},
  ],
  '3': [GetHistoricalOhlcDataResponse_MetadataEntry$json],
};

@$core.Deprecated('Use getHistoricalOhlcDataResponseDescriptor instead')
const GetHistoricalOhlcDataResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetHistoricalOhlcDataResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getHistoricalOhlcDataResponseDescriptor = $convert.base64Decode(
    'Ch1HZXRIaXN0b3JpY2FsT2hsY0RhdGFSZXNwb25zZRIoChByZWZfZXhlY3V0aW9uX2lkGAEgAS'
    'gJUg5yZWZFeGVjdXRpb25JZBJYCg9wYWdpbmF0aW9uX2luZm8YAiABKAsyLy5xb21ldC5hZ29y'
    'YS5kYWVtb25zLnBydGFnZW50LnYxLlBhZ2luYXRpb25JbmZvUg5wYWdpbmF0aW9uSW5mbxJICg'
    'pvaGxjX2RhdGFzGAMgAygLMikucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5PaGxj'
    'RGF0YVIJb2hsY0RhdGFzEmgKCG1ldGFkYXRhGGkgAygLMkwucW9tZXQuYWdvcmEuZGFlbW9ucy'
    '5wcnRhZ2VudC52MS5HZXRIaXN0b3JpY2FsT2hsY0RhdGFSZXNwb25zZS5NZXRhZGF0YUVudHJ5'
    'UghtZXRhZGF0YRo7Cg1NZXRhZGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGA'
    'IgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use feeStructureDescriptor instead')
const FeeStructure$json = {
  '1': 'FeeStructure',
  '2': [
    {'1': 'base_fee', '3': 1, '4': 1, '5': 9, '10': 'baseFee'},
    {'1': 'percentage_fee', '3': 2, '4': 1, '5': 9, '10': 'percentageFee'},
    {'1': 'minimum_fee', '3': 3, '4': 1, '5': 9, '10': 'minimumFee'},
    {'1': 'maximum_fee', '3': 4, '4': 1, '5': 9, '10': 'maximumFee'},
    {'1': 'maker_fee', '3': 6, '4': 1, '5': 9, '10': 'makerFee'},
    {'1': 'taker_fee', '3': 7, '4': 1, '5': 9, '10': 'takerFee'},
    {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'fee_tier', '3': 9, '4': 1, '5': 9, '10': 'feeTier'},
    {'1': 'discount_rate', '3': 10, '4': 1, '5': 9, '10': 'discountRate'},
    {'1': 'total_estimated_fee', '3': 11, '4': 1, '5': 9, '10': 'totalEstimatedFee'},
  ],
};

/// Descriptor for `FeeStructure`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List feeStructureDescriptor = $convert.base64Decode(
    'CgxGZWVTdHJ1Y3R1cmUSGQoIYmFzZV9mZWUYASABKAlSB2Jhc2VGZWUSJQoOcGVyY2VudGFnZV'
    '9mZWUYAiABKAlSDXBlcmNlbnRhZ2VGZWUSHwoLbWluaW11bV9mZWUYAyABKAlSCm1pbmltdW1G'
    'ZWUSHwoLbWF4aW11bV9mZWUYBCABKAlSCm1heGltdW1GZWUSGwoJbWFrZXJfZmVlGAYgASgJUg'
    'htYWtlckZlZRIbCgl0YWtlcl9mZWUYByABKAlSCHRha2VyRmVlEhoKCGN1cnJlbmN5GAggASgJ'
    'UghjdXJyZW5jeRIZCghmZWVfdGllchgJIAEoCVIHZmVlVGllchIjCg1kaXNjb3VudF9yYXRlGA'
    'ogASgJUgxkaXNjb3VudFJhdGUSLgoTdG90YWxfZXN0aW1hdGVkX2ZlZRgLIAEoCVIRdG90YWxF'
    'c3RpbWF0ZWRGZWU=');

@$core.Deprecated('Use getOrderFeesRequestDescriptor instead')
const GetOrderFeesRequest$json = {
  '1': 'GetOrderFeesRequest',
  '2': [
    {'1': 'proposed_execution_id', '3': 1, '4': 1, '5': 9, '10': 'proposedExecutionId'},
    {'1': 'account_iid', '3': 2, '4': 1, '5': 9, '10': 'accountIid'},
    {'1': 'fee_payer_account_iid', '3': 3, '4': 1, '5': 9, '10': 'feePayerAccountIid'},
    {'1': 'instrument_listing_iid', '3': 4, '4': 1, '5': 9, '10': 'instrumentListingIid'},
    {'1': 'order_type', '3': 5, '4': 1, '5': 9, '10': 'orderType'},
    {'1': 'side', '3': 6, '4': 1, '5': 14, '6': '.qomet.agora.daemons.prtagent.v1.OrderSide', '10': 'side'},
    {'1': 'quantity', '3': 7, '4': 1, '5': 9, '10': 'quantity'},
    {'1': 'price', '3': 8, '4': 1, '5': 9, '10': 'price'},
    {'1': 'time_in_force', '3': 9, '4': 1, '5': 9, '10': 'timeInForce'},
    {'1': 'is_post_only', '3': 10, '4': 1, '5': 8, '10': 'isPostOnly'},
    {'1': 'is_reduce_only', '3': 11, '4': 1, '5': 8, '10': 'isReduceOnly'},
    {'1': 'aux_data', '3': 105, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.GetOrderFeesRequest.AuxDataEntry', '10': 'auxData'},
  ],
  '3': [GetOrderFeesRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use getOrderFeesRequestDescriptor instead')
const GetOrderFeesRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetOrderFeesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrderFeesRequestDescriptor = $convert.base64Decode(
    'ChNHZXRPcmRlckZlZXNSZXF1ZXN0EjIKFXByb3Bvc2VkX2V4ZWN1dGlvbl9pZBgBIAEoCVITcH'
    'JvcG9zZWRFeGVjdXRpb25JZBIfCgthY2NvdW50X2lpZBgCIAEoCVIKYWNjb3VudElpZBIxChVm'
    'ZWVfcGF5ZXJfYWNjb3VudF9paWQYAyABKAlSEmZlZVBheWVyQWNjb3VudElpZBI0ChZpbnN0cn'
    'VtZW50X2xpc3RpbmdfaWlkGAQgASgJUhRpbnN0cnVtZW50TGlzdGluZ0lpZBIdCgpvcmRlcl90'
    'eXBlGAUgASgJUglvcmRlclR5cGUSPgoEc2lkZRgGIAEoDjIqLnFvbWV0LmFnb3JhLmRhZW1vbn'
    'MucHJ0YWdlbnQudjEuT3JkZXJTaWRlUgRzaWRlEhoKCHF1YW50aXR5GAcgASgJUghxdWFudGl0'
    'eRIUCgVwcmljZRgIIAEoCVIFcHJpY2USIgoNdGltZV9pbl9mb3JjZRgJIAEoCVILdGltZUluRm'
    '9yY2USIAoMaXNfcG9zdF9vbmx5GAogASgIUgppc1Bvc3RPbmx5EiQKDmlzX3JlZHVjZV9vbmx5'
    'GAsgASgIUgxpc1JlZHVjZU9ubHkSXAoIYXV4X2RhdGEYaSADKAsyQS5xb21ldC5hZ29yYS5kYW'
    'Vtb25zLnBydGFnZW50LnYxLkdldE9yZGVyRmVlc1JlcXVlc3QuQXV4RGF0YUVudHJ5UgdhdXhE'
    'YXRhGjoKDEF1eERhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdm'
    'FsdWU6AjgB');

@$core.Deprecated('Use getOrderFeesResponseDescriptor instead')
const GetOrderFeesResponse$json = {
  '1': 'GetOrderFeesResponse',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {'1': 'fee_structure', '3': 2, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.FeeStructure', '10': 'feeStructure'},
    {'1': 'fee_notes', '3': 3, '4': 3, '5': 9, '10': 'feeNotes'},
    {'1': 'fee_valid_until_dt', '3': 4, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.DateTime', '10': 'feeValidUntilDt'},
    {'1': 'msg', '3': 5, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'fee_breakdown', '3': 6, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.GetOrderFeesResponse.FeeBreakdownEntry', '10': 'feeBreakdown'},
    {'1': 'alternative_fee_options', '3': 7, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.FeeStructure', '10': 'alternativeFeeOptions'},
    {'1': 'metadata', '3': 8, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.GetOrderFeesResponse.MetadataEntry', '10': 'metadata'},
  ],
  '3': [GetOrderFeesResponse_FeeBreakdownEntry$json, GetOrderFeesResponse_MetadataEntry$json],
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

@$core.Deprecated('Use getOrderFeesResponseDescriptor instead')
const GetOrderFeesResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetOrderFeesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrderFeesResponseDescriptor = $convert.base64Decode(
    'ChRHZXRPcmRlckZlZXNSZXNwb25zZRIoChByZWZfZXhlY3V0aW9uX2lkGAEgASgJUg5yZWZFeG'
    'VjdXRpb25JZBJSCg1mZWVfc3RydWN0dXJlGAIgASgLMi0ucW9tZXQuYWdvcmEuZGFlbW9ucy5w'
    'cnRhZ2VudC52MS5GZWVTdHJ1Y3R1cmVSDGZlZVN0cnVjdHVyZRIbCglmZWVfbm90ZXMYAyADKA'
    'lSCGZlZU5vdGVzElYKEmZlZV92YWxpZF91bnRpbF9kdBgEIAEoCzIpLnFvbWV0LmFnb3JhLmRh'
    'ZW1vbnMucHJ0YWdlbnQudjEuRGF0ZVRpbWVSD2ZlZVZhbGlkVW50aWxEdBIQCgNtc2cYBSABKA'
    'lSA21zZxJsCg1mZWVfYnJlYWtkb3duGAYgAygLMkcucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRh'
    'Z2VudC52MS5HZXRPcmRlckZlZXNSZXNwb25zZS5GZWVCcmVha2Rvd25FbnRyeVIMZmVlQnJlYW'
    'tkb3duEmUKF2FsdGVybmF0aXZlX2ZlZV9vcHRpb25zGAcgAygLMi0ucW9tZXQuYWdvcmEuZGFl'
    'bW9ucy5wcnRhZ2VudC52MS5GZWVTdHJ1Y3R1cmVSFWFsdGVybmF0aXZlRmVlT3B0aW9ucxJfCg'
    'htZXRhZGF0YRgIIAMoCzJDLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuR2V0T3Jk'
    'ZXJGZWVzUmVzcG9uc2UuTWV0YWRhdGFFbnRyeVIIbWV0YWRhdGEaPwoRRmVlQnJlYWtkb3duRW'
    '50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4ARo7Cg1NZXRh'
    'ZGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use createOrderAsyncRequestDescriptor instead')
const CreateOrderAsyncRequest$json = {
  '1': 'CreateOrderAsyncRequest',
  '2': [
    {'1': 'proposed_execution_id', '3': 1, '4': 1, '5': 9, '10': 'proposedExecutionId'},
    {'1': 'account_iid', '3': 2, '4': 1, '5': 9, '10': 'accountIid'},
    {'1': 'fee_payer_account_iid', '3': 3, '4': 1, '5': 9, '10': 'feePayerAccountIid'},
    {'1': 'instrument_listing_iid', '3': 4, '4': 1, '5': 9, '10': 'instrumentListingIid'},
    {'1': 'order_type', '3': 5, '4': 1, '5': 9, '10': 'orderType'},
    {'1': 'side', '3': 6, '4': 1, '5': 14, '6': '.qomet.agora.daemons.prtagent.v1.OrderSide', '10': 'side'},
    {'1': 'quantity', '3': 7, '4': 1, '5': 9, '10': 'quantity'},
    {'1': 'price', '3': 8, '4': 1, '5': 9, '10': 'price'},
    {'1': 'time_in_force', '3': 9, '4': 1, '5': 9, '10': 'timeInForce'},
    {'1': 'expire_dt', '3': 10, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.DateTime', '10': 'expireDt'},
    {'1': 'participant_order_iid', '3': 11, '4': 1, '5': 9, '10': 'participantOrderIid'},
    {'1': 'aux_data', '3': 105, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.CreateOrderAsyncRequest.AuxDataEntry', '10': 'auxData'},
  ],
  '3': [CreateOrderAsyncRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use createOrderAsyncRequestDescriptor instead')
const CreateOrderAsyncRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `CreateOrderAsyncRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createOrderAsyncRequestDescriptor = $convert.base64Decode(
    'ChdDcmVhdGVPcmRlckFzeW5jUmVxdWVzdBIyChVwcm9wb3NlZF9leGVjdXRpb25faWQYASABKA'
    'lSE3Byb3Bvc2VkRXhlY3V0aW9uSWQSHwoLYWNjb3VudF9paWQYAiABKAlSCmFjY291bnRJaWQS'
    'MQoVZmVlX3BheWVyX2FjY291bnRfaWlkGAMgASgJUhJmZWVQYXllckFjY291bnRJaWQSNAoWaW'
    '5zdHJ1bWVudF9saXN0aW5nX2lpZBgEIAEoCVIUaW5zdHJ1bWVudExpc3RpbmdJaWQSHQoKb3Jk'
    'ZXJfdHlwZRgFIAEoCVIJb3JkZXJUeXBlEj4KBHNpZGUYBiABKA4yKi5xb21ldC5hZ29yYS5kYW'
    'Vtb25zLnBydGFnZW50LnYxLk9yZGVyU2lkZVIEc2lkZRIaCghxdWFudGl0eRgHIAEoCVIIcXVh'
    'bnRpdHkSFAoFcHJpY2UYCCABKAlSBXByaWNlEiIKDXRpbWVfaW5fZm9yY2UYCSABKAlSC3RpbW'
    'VJbkZvcmNlEkYKCWV4cGlyZV9kdBgKIAEoCzIpLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdl'
    'bnQudjEuRGF0ZVRpbWVSCGV4cGlyZUR0EjIKFXBhcnRpY2lwYW50X29yZGVyX2lpZBgLIAEoCV'
    'ITcGFydGljaXBhbnRPcmRlcklpZBJgCghhdXhfZGF0YRhpIAMoCzJFLnFvbWV0LmFnb3JhLmRh'
    'ZW1vbnMucHJ0YWdlbnQudjEuQ3JlYXRlT3JkZXJBc3luY1JlcXVlc3QuQXV4RGF0YUVudHJ5Ug'
    'dhdXhEYXRhGjoKDEF1eERhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEo'
    'CVIFdmFsdWU6AjgB');

@$core.Deprecated('Use replaceOrderAsyncRequestDescriptor instead')
const ReplaceOrderAsyncRequest$json = {
  '1': 'ReplaceOrderAsyncRequest',
  '2': [
    {'1': 'proposed_execution_id', '3': 1, '4': 1, '5': 9, '10': 'proposedExecutionId'},
    {'1': 'old_participant_order_id', '3': 2, '4': 1, '5': 9, '10': 'oldParticipantOrderId'},
    {'1': 'new_participant_order_id', '3': 3, '4': 1, '5': 9, '10': 'newParticipantOrderId'},
    {'1': 'new_quantity', '3': 4, '4': 1, '5': 9, '10': 'newQuantity'},
    {'1': 'new_price', '3': 5, '4': 1, '5': 9, '10': 'newPrice'},
    {'1': 'new_expire_time', '3': 6, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.Time', '10': 'newExpireTime'},
    {'1': 'reason', '3': 7, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'aux_data', '3': 105, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.ReplaceOrderAsyncRequest.AuxDataEntry', '10': 'auxData'},
  ],
  '3': [ReplaceOrderAsyncRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use replaceOrderAsyncRequestDescriptor instead')
const ReplaceOrderAsyncRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ReplaceOrderAsyncRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List replaceOrderAsyncRequestDescriptor = $convert.base64Decode(
    'ChhSZXBsYWNlT3JkZXJBc3luY1JlcXVlc3QSMgoVcHJvcG9zZWRfZXhlY3V0aW9uX2lkGAEgAS'
    'gJUhNwcm9wb3NlZEV4ZWN1dGlvbklkEjcKGG9sZF9wYXJ0aWNpcGFudF9vcmRlcl9pZBgCIAEo'
    'CVIVb2xkUGFydGljaXBhbnRPcmRlcklkEjcKGG5ld19wYXJ0aWNpcGFudF9vcmRlcl9pZBgDIA'
    'EoCVIVbmV3UGFydGljaXBhbnRPcmRlcklkEiEKDG5ld19xdWFudGl0eRgEIAEoCVILbmV3UXVh'
    'bnRpdHkSGwoJbmV3X3ByaWNlGAUgASgJUghuZXdQcmljZRJNCg9uZXdfZXhwaXJlX3RpbWUYBi'
    'ABKAsyJS5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLlRpbWVSDW5ld0V4cGlyZVRp'
    'bWUSFgoGcmVhc29uGAcgASgJUgZyZWFzb24SYQoIYXV4X2RhdGEYaSADKAsyRi5xb21ldC5hZ2'
    '9yYS5kYWVtb25zLnBydGFnZW50LnYxLlJlcGxhY2VPcmRlckFzeW5jUmVxdWVzdC5BdXhEYXRh'
    'RW50cnlSB2F1eERhdGEaOgoMQXV4RGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbH'
    'VlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use cancelOrderAsyncRequestDescriptor instead')
const CancelOrderAsyncRequest$json = {
  '1': 'CancelOrderAsyncRequest',
  '2': [
    {'1': 'proposed_execution_id', '3': 1, '4': 1, '5': 9, '10': 'proposedExecutionId'},
    {'1': 'participant_order_id', '3': 2, '4': 1, '5': 9, '10': 'participantOrderId'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'aux_data', '3': 105, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.CancelOrderAsyncRequest.AuxDataEntry', '10': 'auxData'},
  ],
  '3': [CancelOrderAsyncRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use cancelOrderAsyncRequestDescriptor instead')
const CancelOrderAsyncRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `CancelOrderAsyncRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelOrderAsyncRequestDescriptor = $convert.base64Decode(
    'ChdDYW5jZWxPcmRlckFzeW5jUmVxdWVzdBIyChVwcm9wb3NlZF9leGVjdXRpb25faWQYASABKA'
    'lSE3Byb3Bvc2VkRXhlY3V0aW9uSWQSMAoUcGFydGljaXBhbnRfb3JkZXJfaWQYAiABKAlSEnBh'
    'cnRpY2lwYW50T3JkZXJJZBIWCgZyZWFzb24YAyABKAlSBnJlYXNvbhJgCghhdXhfZGF0YRhpIA'
    'MoCzJFLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuQ2FuY2VsT3JkZXJBc3luY1Jl'
    'cXVlc3QuQXV4RGF0YUVudHJ5UgdhdXhEYXRhGjoKDEF1eERhdGFFbnRyeRIQCgNrZXkYASABKA'
    'lSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use getOrderbookRequestDescriptor instead')
const GetOrderbookRequest$json = {
  '1': 'GetOrderbookRequest',
  '2': [
    {'1': 'proposed_execution_id', '3': 1, '4': 1, '5': 9, '10': 'proposedExecutionId'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.PaginationParams', '10': 'pagination'},
    {'1': 'instrument_iid', '3': 3, '4': 1, '5': 9, '10': 'instrumentIid'},
    {'1': 'orderbook_query_filter', '3': 4, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.OrderbookQueryFilter', '10': 'orderbookQueryFilter'},
    {'1': 'aux_data', '3': 105, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.GetOrderbookRequest.AuxDataEntry', '10': 'auxData'},
  ],
  '3': [GetOrderbookRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use getOrderbookRequestDescriptor instead')
const GetOrderbookRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetOrderbookRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrderbookRequestDescriptor = $convert.base64Decode(
    'ChNHZXRPcmRlcmJvb2tSZXF1ZXN0EjIKFXByb3Bvc2VkX2V4ZWN1dGlvbl9pZBgBIAEoCVITcH'
    'JvcG9zZWRFeGVjdXRpb25JZBJRCgpwYWdpbmF0aW9uGAIgASgLMjEucW9tZXQuYWdvcmEuZGFl'
    'bW9ucy5wcnRhZ2VudC52MS5QYWdpbmF0aW9uUGFyYW1zUgpwYWdpbmF0aW9uEiUKDmluc3RydW'
    '1lbnRfaWlkGAMgASgJUg1pbnN0cnVtZW50SWlkEmsKFm9yZGVyYm9va19xdWVyeV9maWx0ZXIY'
    'BCABKAsyNS5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLk9yZGVyYm9va1F1ZXJ5Rm'
    'lsdGVyUhRvcmRlcmJvb2tRdWVyeUZpbHRlchJcCghhdXhfZGF0YRhpIAMoCzJBLnFvbWV0LmFn'
    'b3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuR2V0T3JkZXJib29rUmVxdWVzdC5BdXhEYXRhRW50cn'
    'lSB2F1eERhdGEaOgoMQXV4RGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIg'
    'ASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use getOrderbookResponseDescriptor instead')
const GetOrderbookResponse$json = {
  '1': 'GetOrderbookResponse',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {'1': 'generated_at_dt', '3': 2, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.DateTime', '10': 'generatedAtDt'},
    {'1': 'instrument', '3': 3, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.Instrument', '10': 'instrument'},
    {'1': 'buy_list', '3': 4, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.OrderList', '10': 'buyList'},
    {'1': 'sell_list', '3': 5, '4': 1, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.OrderList', '10': 'sellList'},
    {'1': 'metadata', '3': 105, '4': 3, '5': 11, '6': '.qomet.agora.daemons.prtagent.v1.GetOrderbookResponse.MetadataEntry', '10': 'metadata'},
  ],
  '3': [GetOrderbookResponse_MetadataEntry$json],
};

@$core.Deprecated('Use getOrderbookResponseDescriptor instead')
const GetOrderbookResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetOrderbookResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrderbookResponseDescriptor = $convert.base64Decode(
    'ChRHZXRPcmRlcmJvb2tSZXNwb25zZRIoChByZWZfZXhlY3V0aW9uX2lkGAEgASgJUg5yZWZFeG'
    'VjdXRpb25JZBJRCg9nZW5lcmF0ZWRfYXRfZHQYAiABKAsyKS5xb21ldC5hZ29yYS5kYWVtb25z'
    'LnBydGFnZW50LnYxLkRhdGVUaW1lUg1nZW5lcmF0ZWRBdER0EksKCmluc3RydW1lbnQYAyABKA'
    'syKy5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkluc3RydW1lbnRSCmluc3RydW1l'
    'bnQSRQoIYnV5X2xpc3QYBCABKAsyKi5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLk'
    '9yZGVyTGlzdFIHYnV5TGlzdBJHCglzZWxsX2xpc3QYBSABKAsyKi5xb21ldC5hZ29yYS5kYWVt'
    'b25zLnBydGFnZW50LnYxLk9yZGVyTGlzdFIIc2VsbExpc3QSXwoIbWV0YWRhdGEYaSADKAsyQy'
    '5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkdldE9yZGVyYm9va1Jlc3BvbnNlLk1l'
    'dGFkYXRhRW50cnlSCG1ldGFkYXRhGjsKDU1ldGFkYXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZX'
    'kSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

