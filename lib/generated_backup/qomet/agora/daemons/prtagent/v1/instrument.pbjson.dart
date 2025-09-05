// This is a generated file - do not edit.
//
// Generated from qomet/agora/daemons/prtagent/v1/instrument.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use instrumentQuoteDescriptor instead')
const InstrumentQuote$json = {
  '1': 'InstrumentQuote',
  '2': [
    {
      '1': 'instrument',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Instrument',
      '10': 'instrument'
    },
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
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'metadata', '3': 2, '4': 1, '5': 9, '10': 'metadata'},
    {
      '1': 'quote',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.InstrumentQuote',
      '10': 'quote'
    },
  ],
};

/// Descriptor for `InstrumentQuoteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List instrumentQuoteResponseDescriptor = $convert.base64Decode(
    'ChdJbnN0cnVtZW50UXVvdGVSZXNwb25zZRIkCg5yZWZfcmVxdWVzdF9pZBgBIAEoCVIMcmVmUm'
    'VxdWVzdElkEhoKCG1ldGFkYXRhGAIgASgJUghtZXRhZGF0YRJGCgVxdW90ZRgDIAEoCzIwLnFv'
    'bWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuSW5zdHJ1bWVudFF1b3RlUgVxdW90ZQ==');

@$core.Deprecated('Use ohlcDataDescriptor instead')
const OhlcData$json = {
  '1': 'OhlcData',
  '2': [
    {
      '1': 'instrument',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Instrument',
      '10': 'instrument'
    },
    {
      '1': 'duration',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Duration',
      '10': 'duration'
    },
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
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'metadata', '3': 2, '4': 1, '5': 9, '10': 'metadata'},
    {
      '1': 'ohlc_data',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.OhlcData',
      '10': 'ohlcData'
    },
  ],
};

/// Descriptor for `OhlcDataResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ohlcDataResponseDescriptor = $convert.base64Decode(
    'ChBPaGxjRGF0YVJlc3BvbnNlEiQKDnJlZl9yZXF1ZXN0X2lkGAEgASgJUgxyZWZSZXF1ZXN0SW'
    'QSGgoIbWV0YWRhdGEYAiABKAlSCG1ldGFkYXRhEkYKCW9obGNfZGF0YRgDIAEoCzIpLnFvbWV0'
    'LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuT2hsY0RhdGFSCG9obGNEYXRh');

@$core.Deprecated('Use getInstrumentsInfoRequestDescriptor instead')
const GetInstrumentsInfoRequest$json = {
  '1': 'GetInstrumentsInfoRequest',
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
      '1': 'instrument_id_and_symbol_regexes',
      '3': 3,
      '4': 3,
      '5': 9,
      '10': 'instrumentIdAndSymbolRegexes'
    },
    {
      '1': 'listing_types',
      '3': 4,
      '4': 3,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.InstrumentListingStatusType',
      '10': 'listingTypes'
    },
    {'1': 'metadata', '3': 5, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `GetInstrumentsInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInstrumentsInfoRequestDescriptor = $convert.base64Decode(
    'ChlHZXRJbnN0cnVtZW50c0luZm9SZXF1ZXN0EiQKDnJlZl9yZXF1ZXN0X2lkGAEgASgJUgxyZW'
    'ZSZXF1ZXN0SWQSUQoKcGFnaW5hdGlvbhgCIAEoCzIxLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0'
    'YWdlbnQudjEuUGFnaW5hdGlvblBhcmFtc1IKcGFnaW5hdGlvbhJGCiBpbnN0cnVtZW50X2lkX2'
    'FuZF9zeW1ib2xfcmVnZXhlcxgDIAMoCVIcaW5zdHJ1bWVudElkQW5kU3ltYm9sUmVnZXhlcxJh'
    'Cg1saXN0aW5nX3R5cGVzGAQgAygOMjwucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS'
    '5JbnN0cnVtZW50TGlzdGluZ1N0YXR1c1R5cGVSDGxpc3RpbmdUeXBlcxIaCghtZXRhZGF0YRgF'
    'IAEoCVIIbWV0YWRhdGE=');

@$core.Deprecated('Use getInstrumentsInfoResponseDescriptor instead')
const GetInstrumentsInfoResponse$json = {
  '1': 'GetInstrumentsInfoResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'metadata', '3': 2, '4': 1, '5': 9, '10': 'metadata'},
    {
      '1': 'pagination_info',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.PaginationInfo',
      '10': 'paginationInfo'
    },
    {
      '1': 'instruments',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Instrument',
      '10': 'instruments'
    },
  ],
};

/// Descriptor for `GetInstrumentsInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInstrumentsInfoResponseDescriptor = $convert.base64Decode(
    'ChpHZXRJbnN0cnVtZW50c0luZm9SZXNwb25zZRIkCg5yZWZfcmVxdWVzdF9pZBgBIAEoCVIMcm'
    'VmUmVxdWVzdElkEhoKCG1ldGFkYXRhGAIgASgJUghtZXRhZGF0YRJYCg9wYWdpbmF0aW9uX2lu'
    'Zm8YAyABKAsyLy5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLlBhZ2luYXRpb25Jbm'
    'ZvUg5wYWdpbmF0aW9uSW5mbxJNCgtpbnN0cnVtZW50cxgEIAMoCzIrLnFvbWV0LmFnb3JhLmRh'
    'ZW1vbnMucHJ0YWdlbnQudjEuSW5zdHJ1bWVudFILaW5zdHJ1bWVudHM=');

@$core.Deprecated('Use getLatestQuoteRequestDescriptor instead')
const GetLatestQuoteRequest$json = {
  '1': 'GetLatestQuoteRequest',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {
      '1': 'instrument_id_and_symbol_regexes',
      '3': 2,
      '4': 3,
      '5': 9,
      '10': 'instrumentIdAndSymbolRegexes'
    },
    {'1': 'metadata', '3': 3, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `GetLatestQuoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLatestQuoteRequestDescriptor = $convert.base64Decode(
    'ChVHZXRMYXRlc3RRdW90ZVJlcXVlc3QSJAoOcmVmX3JlcXVlc3RfaWQYASABKAlSDHJlZlJlcX'
    'Vlc3RJZBJGCiBpbnN0cnVtZW50X2lkX2FuZF9zeW1ib2xfcmVnZXhlcxgCIAMoCVIcaW5zdHJ1'
    'bWVudElkQW5kU3ltYm9sUmVnZXhlcxIaCghtZXRhZGF0YRgDIAEoCVIIbWV0YWRhdGE=');

@$core.Deprecated('Use liveQuoteFetchParamsDescriptor instead')
const LiveQuoteFetchParams$json = {
  '1': 'LiveQuoteFetchParams',
  '2': [
    {
      '1': 'update_interval_ms',
      '3': 1,
      '4': 1,
      '5': 13,
      '10': 'updateIntervalMs'
    },
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
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {
      '1': 'instrument_id_and_symbol_regexes',
      '3': 2,
      '4': 3,
      '5': 9,
      '10': 'instrumentIdAndSymbolRegexes'
    },
    {
      '1': 'fetch_params',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.LiveQuoteFetchParams',
      '10': 'fetchParams'
    },
    {'1': 'metadata', '3': 4, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `FetchLiveQuoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchLiveQuoteRequestDescriptor = $convert.base64Decode(
    'ChVGZXRjaExpdmVRdW90ZVJlcXVlc3QSJAoOcmVmX3JlcXVlc3RfaWQYASABKAlSDHJlZlJlcX'
    'Vlc3RJZBJGCiBpbnN0cnVtZW50X2lkX2FuZF9zeW1ib2xfcmVnZXhlcxgCIAMoCVIcaW5zdHJ1'
    'bWVudElkQW5kU3ltYm9sUmVnZXhlcxJYCgxmZXRjaF9wYXJhbXMYAyABKAsyNS5xb21ldC5hZ2'
    '9yYS5kYWVtb25zLnBydGFnZW50LnYxLkxpdmVRdW90ZUZldGNoUGFyYW1zUgtmZXRjaFBhcmFt'
    'cxIaCghtZXRhZGF0YRgEIAEoCVIIbWV0YWRhdGE=');

@$core.Deprecated('Use getHistoricalQuoteRequestDescriptor instead')
const GetHistoricalQuoteRequest$json = {
  '1': 'GetHistoricalQuoteRequest',
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
      '1': 'instrument_id_and_symbol_regexes',
      '3': 3,
      '4': 3,
      '5': 9,
      '10': 'instrumentIdAndSymbolRegexes'
    },
    {
      '1': 'duration',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Duration',
      '9': 0,
      '10': 'duration',
      '17': true
    },
    {'1': 'metadata', '3': 5, '4': 1, '5': 9, '10': 'metadata'},
  ],
  '8': [
    {'1': '_duration'},
  ],
};

/// Descriptor for `GetHistoricalQuoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getHistoricalQuoteRequestDescriptor = $convert.base64Decode(
    'ChlHZXRIaXN0b3JpY2FsUXVvdGVSZXF1ZXN0EiQKDnJlZl9yZXF1ZXN0X2lkGAEgASgJUgxyZW'
    'ZSZXF1ZXN0SWQSUQoKcGFnaW5hdGlvbhgCIAEoCzIxLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0'
    'YWdlbnQudjEuUGFnaW5hdGlvblBhcmFtc1IKcGFnaW5hdGlvbhJGCiBpbnN0cnVtZW50X2lkX2'
    'FuZF9zeW1ib2xfcmVnZXhlcxgDIAMoCVIcaW5zdHJ1bWVudElkQW5kU3ltYm9sUmVnZXhlcxJK'
    'CghkdXJhdGlvbhgEIAEoCzIpLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuRHVyYX'
    'Rpb25IAFIIZHVyYXRpb26IAQESGgoIbWV0YWRhdGEYBSABKAlSCG1ldGFkYXRhQgsKCV9kdXJh'
    'dGlvbg==');

@$core.Deprecated('Use getHistoricalQuoteResponseDescriptor instead')
const GetHistoricalQuoteResponse$json = {
  '1': 'GetHistoricalQuoteResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'metadata', '3': 2, '4': 1, '5': 9, '10': 'metadata'},
    {
      '1': 'pagination_info',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.PaginationInfo',
      '10': 'paginationInfo'
    },
    {
      '1': 'quotes',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.InstrumentQuote',
      '10': 'quotes'
    },
  ],
};

/// Descriptor for `GetHistoricalQuoteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getHistoricalQuoteResponseDescriptor = $convert.base64Decode(
    'ChpHZXRIaXN0b3JpY2FsUXVvdGVSZXNwb25zZRIkCg5yZWZfcmVxdWVzdF9pZBgBIAEoCVIMcm'
    'VmUmVxdWVzdElkEhoKCG1ldGFkYXRhGAIgASgJUghtZXRhZGF0YRJYCg9wYWdpbmF0aW9uX2lu'
    'Zm8YAyABKAsyLy5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLlBhZ2luYXRpb25Jbm'
    'ZvUg5wYWdpbmF0aW9uSW5mbxJICgZxdW90ZXMYBCADKAsyMC5xb21ldC5hZ29yYS5kYWVtb25z'
    'LnBydGFnZW50LnYxLkluc3RydW1lbnRRdW90ZVIGcXVvdGVz');

@$core.Deprecated('Use liveOhlcDataFetchParamsDescriptor instead')
const LiveOhlcDataFetchParams$json = {
  '1': 'LiveOhlcDataFetchParams',
  '2': [
    {
      '1': 'update_interval_ms',
      '3': 1,
      '4': 1,
      '5': 13,
      '10': 'updateIntervalMs'
    },
    {'1': 'max_duration_ms', '3': 2, '4': 1, '5': 13, '10': 'maxDurationMs'},
    {'1': 'period', '3': 3, '4': 1, '5': 9, '10': 'period'},
    {'1': 'include_volume', '3': 4, '4': 1, '5': 8, '10': 'includeVolume'},
    {
      '1': 'include_indicators',
      '3': 5,
      '4': 1,
      '5': 8,
      '10': 'includeIndicators'
    },
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
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {
      '1': 'instrument_id_and_symbol_regexes',
      '3': 2,
      '4': 3,
      '5': 9,
      '10': 'instrumentIdAndSymbolRegexes'
    },
    {
      '1': 'fetch_params',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.LiveOhlcDataFetchParams',
      '10': 'fetchParams'
    },
    {'1': 'metadata', '3': 4, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `FetchLiveOhlcDataRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchLiveOhlcDataRequestDescriptor = $convert.base64Decode(
    'ChhGZXRjaExpdmVPaGxjRGF0YVJlcXVlc3QSJAoOcmVmX3JlcXVlc3RfaWQYASABKAlSDHJlZl'
    'JlcXVlc3RJZBJGCiBpbnN0cnVtZW50X2lkX2FuZF9zeW1ib2xfcmVnZXhlcxgCIAMoCVIcaW5z'
    'dHJ1bWVudElkQW5kU3ltYm9sUmVnZXhlcxJbCgxmZXRjaF9wYXJhbXMYAyABKAsyOC5xb21ldC'
    '5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkxpdmVPaGxjRGF0YUZldGNoUGFyYW1zUgtmZXRj'
    'aFBhcmFtcxIaCghtZXRhZGF0YRgEIAEoCVIIbWV0YWRhdGE=');

@$core.Deprecated('Use getHistoricalOhlcDataRequestDescriptor instead')
const GetHistoricalOhlcDataRequest$json = {
  '1': 'GetHistoricalOhlcDataRequest',
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
      '1': 'instrument_id_and_symbol_regexes',
      '3': 3,
      '4': 3,
      '5': 9,
      '10': 'instrumentIdAndSymbolRegexes'
    },
    {
      '1': 'duration',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Duration',
      '9': 0,
      '10': 'duration',
      '17': true
    },
    {'1': 'metadata', '3': 5, '4': 1, '5': 9, '10': 'metadata'},
  ],
  '8': [
    {'1': '_duration'},
  ],
};

/// Descriptor for `GetHistoricalOhlcDataRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getHistoricalOhlcDataRequestDescriptor = $convert.base64Decode(
    'ChxHZXRIaXN0b3JpY2FsT2hsY0RhdGFSZXF1ZXN0EiQKDnJlZl9yZXF1ZXN0X2lkGAEgASgJUg'
    'xyZWZSZXF1ZXN0SWQSUQoKcGFnaW5hdGlvbhgCIAEoCzIxLnFvbWV0LmFnb3JhLmRhZW1vbnMu'
    'cHJ0YWdlbnQudjEuUGFnaW5hdGlvblBhcmFtc1IKcGFnaW5hdGlvbhJGCiBpbnN0cnVtZW50X2'
    'lkX2FuZF9zeW1ib2xfcmVnZXhlcxgDIAMoCVIcaW5zdHJ1bWVudElkQW5kU3ltYm9sUmVnZXhl'
    'cxJKCghkdXJhdGlvbhgEIAEoCzIpLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuRH'
    'VyYXRpb25IAFIIZHVyYXRpb26IAQESGgoIbWV0YWRhdGEYBSABKAlSCG1ldGFkYXRhQgsKCV9k'
    'dXJhdGlvbg==');

@$core.Deprecated('Use getHistoricalOhlcDataResponseDescriptor instead')
const GetHistoricalOhlcDataResponse$json = {
  '1': 'GetHistoricalOhlcDataResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'metadata', '3': 2, '4': 1, '5': 9, '10': 'metadata'},
    {
      '1': 'pagination_info',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.PaginationInfo',
      '10': 'paginationInfo'
    },
    {
      '1': 'ohlc_datas',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.OhlcData',
      '10': 'ohlcDatas'
    },
  ],
};

/// Descriptor for `GetHistoricalOhlcDataResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getHistoricalOhlcDataResponseDescriptor = $convert.base64Decode(
    'Ch1HZXRIaXN0b3JpY2FsT2hsY0RhdGFSZXNwb25zZRIkCg5yZWZfcmVxdWVzdF9pZBgBIAEoCV'
    'IMcmVmUmVxdWVzdElkEhoKCG1ldGFkYXRhGAIgASgJUghtZXRhZGF0YRJYCg9wYWdpbmF0aW9u'
    'X2luZm8YAyABKAsyLy5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLlBhZ2luYXRpb2'
    '5JbmZvUg5wYWdpbmF0aW9uSW5mbxJICgpvaGxjX2RhdGFzGAQgAygLMikucW9tZXQuYWdvcmEu'
    'ZGFlbW9ucy5wcnRhZ2VudC52MS5PaGxjRGF0YVIJb2hsY0RhdGFz');

@$core.Deprecated('Use orderQueryFilterDescriptor instead')
const OrderQueryFilter$json = {
  '1': 'OrderQueryFilter',
  '2': [
    {
      '1': 'from_time',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'fromTime'
    },
    {
      '1': 'to_time',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'toTime'
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
    'ChBPcmRlclF1ZXJ5RmlsdGVyEkIKCWZyb21fdGltZRgBIAEoCzIlLnFvbWV0LmFnb3JhLmRhZW'
    '1vbnMucHJ0YWdlbnQudjEuVGltZVIIZnJvbVRpbWUSPgoHdG9fdGltZRgCIAEoCzIlLnFvbWV0'
    'LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuVGltZVIGdG9UaW1lEj4KBHNpZGUYAyABKA4yKi'
    '5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLk9yZGVyU2lkZVIEc2lkZRIfCgtvcmRl'
    'cl90eXBlcxgEIAMoCVIKb3JkZXJUeXBlcxIbCglwcmljZV9taW4YBSABKAlSCHByaWNlTWluEh'
    'sKCXByaWNlX21heBgGIAEoCVIIcHJpY2VNYXgSIQoMcXVhbnRpdHlfbWluGAcgASgJUgtxdWFu'
    'dGl0eU1pbhIhCgxxdWFudGl0eV9tYXgYCCABKAlSC3F1YW50aXR5TWF4EiUKDnN0YXR1c19maW'
    'x0ZXJzGAkgAygIUg1zdGF0dXNGaWx0ZXJzEicKD2NyZWF0b3JfYWRkcmVzcxgKIAEoCVIOY3Jl'
    'YXRvckFkZHJlc3M=');

@$core.Deprecated('Use getInstrumentOrdersRequestDescriptor instead')
const GetInstrumentOrdersRequest$json = {
  '1': 'GetInstrumentOrdersRequest',
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
      '1': 'instrument_id_and_symbol_regexes',
      '3': 3,
      '4': 3,
      '5': 9,
      '10': 'instrumentIdAndSymbolRegexes'
    },
    {
      '1': 'order_query_filter',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.OrderQueryFilter',
      '10': 'orderQueryFilter'
    },
    {'1': 'metadata', '3': 5, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `GetInstrumentOrdersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInstrumentOrdersRequestDescriptor = $convert.base64Decode(
    'ChpHZXRJbnN0cnVtZW50T3JkZXJzUmVxdWVzdBIkCg5yZWZfcmVxdWVzdF9pZBgBIAEoCVIMcm'
    'VmUmVxdWVzdElkElEKCnBhZ2luYXRpb24YAiABKAsyMS5xb21ldC5hZ29yYS5kYWVtb25zLnBy'
    'dGFnZW50LnYxLlBhZ2luYXRpb25QYXJhbXNSCnBhZ2luYXRpb24SRgogaW5zdHJ1bWVudF9pZF'
    '9hbmRfc3ltYm9sX3JlZ2V4ZXMYAyADKAlSHGluc3RydW1lbnRJZEFuZFN5bWJvbFJlZ2V4ZXMS'
    'XwoSb3JkZXJfcXVlcnlfZmlsdGVyGAQgASgLMjEucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2'
    'VudC52MS5PcmRlclF1ZXJ5RmlsdGVyUhBvcmRlclF1ZXJ5RmlsdGVyEhoKCG1ldGFkYXRhGAUg'
    'ASgJUghtZXRhZGF0YQ==');

@$core.Deprecated('Use getInstrumentOrdersResponseDescriptor instead')
const GetInstrumentOrdersResponse$json = {
  '1': 'GetInstrumentOrdersResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'metadata', '3': 2, '4': 1, '5': 9, '10': 'metadata'},
    {
      '1': 'pagination_info',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.PaginationInfo',
      '10': 'paginationInfo'
    },
    {
      '1': 'orders',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Order',
      '10': 'orders'
    },
  ],
};

/// Descriptor for `GetInstrumentOrdersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInstrumentOrdersResponseDescriptor = $convert.base64Decode(
    'ChtHZXRJbnN0cnVtZW50T3JkZXJzUmVzcG9uc2USJAoOcmVmX3JlcXVlc3RfaWQYASABKAlSDH'
    'JlZlJlcXVlc3RJZBIaCghtZXRhZGF0YRgCIAEoCVIIbWV0YWRhdGESWAoPcGFnaW5hdGlvbl9p'
    'bmZvGAMgASgLMi8ucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5QYWdpbmF0aW9uSW'
    '5mb1IOcGFnaW5hdGlvbkluZm8SPgoGb3JkZXJzGAQgAygLMiYucW9tZXQuYWdvcmEuZGFlbW9u'
    'cy5wcnRhZ2VudC52MS5PcmRlclIGb3JkZXJz');

@$core.Deprecated('Use tradeQueryFilterDescriptor instead')
const TradeQueryFilter$json = {
  '1': 'TradeQueryFilter',
  '2': [
    {
      '1': 'from_time',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'fromTime'
    },
    {
      '1': 'to_time',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'toTime'
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
    'ChBUcmFkZVF1ZXJ5RmlsdGVyEkIKCWZyb21fdGltZRgBIAEoCzIlLnFvbWV0LmFnb3JhLmRhZW'
    '1vbnMucHJ0YWdlbnQudjEuVGltZVIIZnJvbVRpbWUSPgoHdG9fdGltZRgCIAEoCzIlLnFvbWV0'
    'LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuVGltZVIGdG9UaW1lEhsKCXByaWNlX21pbhgDIA'
    'EoCVIIcHJpY2VNaW4SGwoJcHJpY2VfbWF4GAQgASgJUghwcmljZU1heBIdCgp2b2x1bWVfbWlu'
    'GAUgASgJUgl2b2x1bWVNaW4SHQoKdm9sdW1lX21heBgGIAEoCVIJdm9sdW1lTWF4Eh8KC3RyYW'
    'RlX3R5cGVzGAcgAygJUgp0cmFkZVR5cGVzEj4KBHNpZGUYCCABKA4yKi5xb21ldC5hZ29yYS5k'
    'YWVtb25zLnBydGFnZW50LnYxLk9yZGVyU2lkZVIEc2lkZQ==');

@$core.Deprecated('Use getInstrumentTradesRequestDescriptor instead')
const GetInstrumentTradesRequest$json = {
  '1': 'GetInstrumentTradesRequest',
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
      '1': 'instrument_id_and_symbol_regexes',
      '3': 3,
      '4': 3,
      '5': 9,
      '10': 'instrumentIdAndSymbolRegexes'
    },
    {
      '1': 'trade_query_filter',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.TradeQueryFilter',
      '10': 'tradeQueryFilter'
    },
    {'1': 'metadata', '3': 5, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `GetInstrumentTradesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInstrumentTradesRequestDescriptor = $convert.base64Decode(
    'ChpHZXRJbnN0cnVtZW50VHJhZGVzUmVxdWVzdBIkCg5yZWZfcmVxdWVzdF9pZBgBIAEoCVIMcm'
    'VmUmVxdWVzdElkElEKCnBhZ2luYXRpb24YAiABKAsyMS5xb21ldC5hZ29yYS5kYWVtb25zLnBy'
    'dGFnZW50LnYxLlBhZ2luYXRpb25QYXJhbXNSCnBhZ2luYXRpb24SRgogaW5zdHJ1bWVudF9pZF'
    '9hbmRfc3ltYm9sX3JlZ2V4ZXMYAyADKAlSHGluc3RydW1lbnRJZEFuZFN5bWJvbFJlZ2V4ZXMS'
    'XwoSdHJhZGVfcXVlcnlfZmlsdGVyGAQgASgLMjEucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2'
    'VudC52MS5UcmFkZVF1ZXJ5RmlsdGVyUhB0cmFkZVF1ZXJ5RmlsdGVyEhoKCG1ldGFkYXRhGAUg'
    'ASgJUghtZXRhZGF0YQ==');

@$core.Deprecated('Use getInstrumentTradesResponseDescriptor instead')
const GetInstrumentTradesResponse$json = {
  '1': 'GetInstrumentTradesResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'metadata', '3': 2, '4': 1, '5': 9, '10': 'metadata'},
    {
      '1': 'pagination_info',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.PaginationInfo',
      '10': 'paginationInfo'
    },
    {
      '1': 'trades',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Trade',
      '10': 'trades'
    },
  ],
};

/// Descriptor for `GetInstrumentTradesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInstrumentTradesResponseDescriptor = $convert.base64Decode(
    'ChtHZXRJbnN0cnVtZW50VHJhZGVzUmVzcG9uc2USJAoOcmVmX3JlcXVlc3RfaWQYASABKAlSDH'
    'JlZlJlcXVlc3RJZBIaCghtZXRhZGF0YRgCIAEoCVIIbWV0YWRhdGESWAoPcGFnaW5hdGlvbl9p'
    'bmZvGAMgASgLMi8ucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5QYWdpbmF0aW9uSW'
    '5mb1IOcGFnaW5hdGlvbkluZm8SPgoGdHJhZGVzGAQgAygLMiYucW9tZXQuYWdvcmEuZGFlbW9u'
    'cy5wcnRhZ2VudC52MS5UcmFkZVIGdHJhZGVz');

@$core.Deprecated('Use settlementQueryFilterDescriptor instead')
const SettlementQueryFilter$json = {
  '1': 'SettlementQueryFilter',
  '2': [
    {
      '1': 'from_time',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'fromTime'
    },
    {
      '1': 'to_time',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'toTime'
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
    'ChVTZXR0bGVtZW50UXVlcnlGaWx0ZXISQgoJZnJvbV90aW1lGAEgASgLMiUucW9tZXQuYWdvcm'
    'EuZGFlbW9ucy5wcnRhZ2VudC52MS5UaW1lUghmcm9tVGltZRI+Cgd0b190aW1lGAIgASgLMiUu'
    'cW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5UaW1lUgZ0b1RpbWUSSwoGc3RhdHVzGA'
    'MgASgOMjMucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5Db25maXJtYXRpb25TdGF0'
    'dXNSBnN0YXR1cxIpChBzZXR0bGVtZW50X3R5cGVzGAQgAygJUg9zZXR0bGVtZW50VHlwZXMSNg'
    'oYYXNzZXRfaWRfb3JfbmFtZV9yZWdleGVzGAUgAygJUhRhc3NldElkT3JOYW1lUmVnZXhlcxId'
    'CgphbW91bnRfbWluGAYgASgJUglhbW91bnRNaW4SHQoKYW1vdW50X21heBgHIAEoCVIJYW1vdW'
    '50TWF4');

@$core.Deprecated('Use getInstrumentSettlementsRequestDescriptor instead')
const GetInstrumentSettlementsRequest$json = {
  '1': 'GetInstrumentSettlementsRequest',
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
      '1': 'instrument_id_and_symbol_regexes',
      '3': 3,
      '4': 3,
      '5': 9,
      '10': 'instrumentIdAndSymbolRegexes'
    },
    {
      '1': 'settlement_query_filter',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.SettlementQueryFilter',
      '10': 'settlementQueryFilter'
    },
    {'1': 'metadata', '3': 5, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `GetInstrumentSettlementsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInstrumentSettlementsRequestDescriptor = $convert.base64Decode(
    'Ch9HZXRJbnN0cnVtZW50U2V0dGxlbWVudHNSZXF1ZXN0EiQKDnJlZl9yZXF1ZXN0X2lkGAEgAS'
    'gJUgxyZWZSZXF1ZXN0SWQSUQoKcGFnaW5hdGlvbhgCIAEoCzIxLnFvbWV0LmFnb3JhLmRhZW1v'
    'bnMucHJ0YWdlbnQudjEuUGFnaW5hdGlvblBhcmFtc1IKcGFnaW5hdGlvbhJGCiBpbnN0cnVtZW'
    '50X2lkX2FuZF9zeW1ib2xfcmVnZXhlcxgDIAMoCVIcaW5zdHJ1bWVudElkQW5kU3ltYm9sUmVn'
    'ZXhlcxJuChdzZXR0bGVtZW50X3F1ZXJ5X2ZpbHRlchgEIAEoCzI2LnFvbWV0LmFnb3JhLmRhZW'
    '1vbnMucHJ0YWdlbnQudjEuU2V0dGxlbWVudFF1ZXJ5RmlsdGVyUhVzZXR0bGVtZW50UXVlcnlG'
    'aWx0ZXISGgoIbWV0YWRhdGEYBSABKAlSCG1ldGFkYXRh');

@$core.Deprecated('Use getInstrumentSettlementsResponseDescriptor instead')
const GetInstrumentSettlementsResponse$json = {
  '1': 'GetInstrumentSettlementsResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'metadata', '3': 2, '4': 1, '5': 9, '10': 'metadata'},
    {
      '1': 'pagination_info',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.PaginationInfo',
      '10': 'paginationInfo'
    },
    {
      '1': 'settlements',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Settlement',
      '10': 'settlements'
    },
  ],
};

/// Descriptor for `GetInstrumentSettlementsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInstrumentSettlementsResponseDescriptor = $convert.base64Decode(
    'CiBHZXRJbnN0cnVtZW50U2V0dGxlbWVudHNSZXNwb25zZRIkCg5yZWZfcmVxdWVzdF9pZBgBIA'
    'EoCVIMcmVmUmVxdWVzdElkEhoKCG1ldGFkYXRhGAIgASgJUghtZXRhZGF0YRJYCg9wYWdpbmF0'
    'aW9uX2luZm8YAyABKAsyLy5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLlBhZ2luYX'
    'Rpb25JbmZvUg5wYWdpbmF0aW9uSW5mbxJNCgtzZXR0bGVtZW50cxgEIAMoCzIrLnFvbWV0LmFn'
    'b3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuU2V0dGxlbWVudFILc2V0dGxlbWVudHM=');

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

@$core.Deprecated('Use getOrderbookRequestDescriptor instead')
const GetOrderbookRequest$json = {
  '1': 'GetOrderbookRequest',
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
    {'1': 'instrument_id', '3': 3, '4': 1, '5': 9, '10': 'instrumentId'},
    {
      '1': 'orderbook_query_filter',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.OrderbookQueryFilter',
      '10': 'orderbookQueryFilter'
    },
    {'1': 'metadata', '3': 5, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `GetOrderbookRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrderbookRequestDescriptor = $convert.base64Decode(
    'ChNHZXRPcmRlcmJvb2tSZXF1ZXN0EiQKDnJlZl9yZXF1ZXN0X2lkGAEgASgJUgxyZWZSZXF1ZX'
    'N0SWQSUQoKcGFnaW5hdGlvbhgCIAEoCzIxLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQu'
    'djEuUGFnaW5hdGlvblBhcmFtc1IKcGFnaW5hdGlvbhIjCg1pbnN0cnVtZW50X2lkGAMgASgJUg'
    'xpbnN0cnVtZW50SWQSawoWb3JkZXJib29rX3F1ZXJ5X2ZpbHRlchgEIAEoCzI1LnFvbWV0LmFn'
    'b3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuT3JkZXJib29rUXVlcnlGaWx0ZXJSFG9yZGVyYm9va1'
    'F1ZXJ5RmlsdGVyEhoKCG1ldGFkYXRhGAUgASgJUghtZXRhZGF0YQ==');

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

@$core.Deprecated('Use getOrderbookResponseDescriptor instead')
const GetOrderbookResponse$json = {
  '1': 'GetOrderbookResponse',
  '2': [
    {'1': 'ref_request_id', '3': 1, '4': 1, '5': 9, '10': 'refRequestId'},
    {'1': 'metadata', '3': 2, '4': 1, '5': 9, '10': 'metadata'},
    {
      '1': 'instrument',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Instrument',
      '10': 'instrument'
    },
    {
      '1': 'buy_list',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.OrderList',
      '10': 'buyList'
    },
    {
      '1': 'sell_list',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.OrderList',
      '10': 'sellList'
    },
  ],
};

/// Descriptor for `GetOrderbookResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrderbookResponseDescriptor = $convert.base64Decode(
    'ChRHZXRPcmRlcmJvb2tSZXNwb25zZRIkCg5yZWZfcmVxdWVzdF9pZBgBIAEoCVIMcmVmUmVxdW'
    'VzdElkEhoKCG1ldGFkYXRhGAIgASgJUghtZXRhZGF0YRJLCgppbnN0cnVtZW50GAMgASgLMisu'
    'cW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5JbnN0cnVtZW50UgppbnN0cnVtZW50Ek'
    'UKCGJ1eV9saXN0GAQgASgLMioucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5PcmRl'
    'ckxpc3RSB2J1eUxpc3QSRwoJc2VsbF9saXN0GAUgASgLMioucW9tZXQuYWdvcmEuZGFlbW9ucy'
    '5wcnRhZ2VudC52MS5PcmRlckxpc3RSCHNlbGxMaXN0');
