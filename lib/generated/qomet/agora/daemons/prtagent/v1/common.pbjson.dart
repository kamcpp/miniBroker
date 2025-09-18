// This is a generated file - do not edit.
//
// Generated from qomet/agora/daemons/prtagent/v1/common.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use asyncResponseStatusEnumDescriptor instead')
const AsyncResponseStatusEnum$json = {
  '1': 'AsyncResponseStatusEnum',
  '2': [
    {'1': 'ASYNC_RESPONSE_STATUS__UNKNOWN', '2': 0},
    {'1': 'ASYNC_RESPONSE_STATUS__ACCEPTED', '2': 1},
    {'1': 'ASYNC_RESPONSE_STATUS__COMPLETED', '2': 2},
    {'1': 'ASYNC_RESPONSE_STATUS__REJECTED', '2': 3},
    {'1': 'ASYNC_RESPONSE_STATUS__FAILED', '2': 4},
    {'1': 'ASYNC_RESPONSE_STATUS__EXPIRED', '2': 5},
    {'1': 'ASYNC_RESPONSE_STATUS__IN_PROGRESS', '2': 6},
    {'1': 'ASYNC_RESPONSE_STATUS__PENDING', '2': 7},
    {'1': 'ASYNC_RESPONSE_STATUS__UNAUTHORIZED', '2': 8},
    {'1': 'ASYNC_RESPONSE_STATUS__CONFLICT', '2': 9},
    {'1': 'ASYNC_RESPONSE_STATUS__SERVICE_UNAVAILABLE', '2': 10},
    {'1': 'ASYNC_RESPONSE_STATUS__GATEWAY_TIMEOUT', '2': 11},
    {'1': 'ASYNC_RESPONSE_STATUS__NOT_IMPLEMENTED', '2': 12},
    {'1': 'ASYNC_RESPONSE_STATUS__BAD_REQUEST', '2': 13},
    {'1': 'ASYNC_RESPONSE_STATUS__TOO_MANY_REQUESTS', '2': 14},
    {'1': 'ASYNC_RESPONSE_STATUS__INTERNAL_SERVER_ERROR', '2': 15},
    {'1': 'ASYNC_RESPONSE_STATUS__OTHER', '2': 1000},
  ],
};

/// Descriptor for `AsyncResponseStatusEnum`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List asyncResponseStatusEnumDescriptor = $convert.base64Decode(
    'ChdBc3luY1Jlc3BvbnNlU3RhdHVzRW51bRIiCh5BU1lOQ19SRVNQT05TRV9TVEFUVVNfX1VOS0'
    '5PV04QABIjCh9BU1lOQ19SRVNQT05TRV9TVEFUVVNfX0FDQ0VQVEVEEAESJAogQVNZTkNfUkVT'
    'UE9OU0VfU1RBVFVTX19DT01QTEVURUQQAhIjCh9BU1lOQ19SRVNQT05TRV9TVEFUVVNfX1JFSk'
    'VDVEVEEAMSIQodQVNZTkNfUkVTUE9OU0VfU1RBVFVTX19GQUlMRUQQBBIiCh5BU1lOQ19SRVNQ'
    'T05TRV9TVEFUVVNfX0VYUElSRUQQBRImCiJBU1lOQ19SRVNQT05TRV9TVEFUVVNfX0lOX1BST0'
    'dSRVNTEAYSIgoeQVNZTkNfUkVTUE9OU0VfU1RBVFVTX19QRU5ESU5HEAcSJwojQVNZTkNfUkVT'
    'UE9OU0VfU1RBVFVTX19VTkFVVEhPUklaRUQQCBIjCh9BU1lOQ19SRVNQT05TRV9TVEFUVVNfX0'
    'NPTkZMSUNUEAkSLgoqQVNZTkNfUkVTUE9OU0VfU1RBVFVTX19TRVJWSUNFX1VOQVZBSUxBQkxF'
    'EAoSKgomQVNZTkNfUkVTUE9OU0VfU1RBVFVTX19HQVRFV0FZX1RJTUVPVVQQCxIqCiZBU1lOQ1'
    '9SRVNQT05TRV9TVEFUVVNfX05PVF9JTVBMRU1FTlRFRBAMEiYKIkFTWU5DX1JFU1BPTlNFX1NU'
    'QVRVU19fQkFEX1JFUVVFU1QQDRIsCihBU1lOQ19SRVNQT05TRV9TVEFUVVNfX1RPT19NQU5ZX1'
    'JFUVVFU1RTEA4SMAosQVNZTkNfUkVTUE9OU0VfU1RBVFVTX19JTlRFUk5BTF9TRVJWRVJfRVJS'
    'T1IQDxIhChxBU1lOQ19SRVNQT05TRV9TVEFUVVNfX09USEVSEOgH');

@$core.Deprecated('Use blobDescriptor instead')
const Blob$json = {
  '1': 'Blob',
  '2': [
    {'1': 'encoding', '3': 1, '4': 1, '5': 9, '10': 'encoding'},
    {'1': 'struct_type', '3': 2, '4': 1, '5': 9, '10': 'structType'},
    {'1': 'data', '3': 3, '4': 1, '5': 9, '10': 'data'},
  ],
};

/// Descriptor for `Blob`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blobDescriptor = $convert.base64Decode(
    'CgRCbG9iEhoKCGVuY29kaW5nGAEgASgJUghlbmNvZGluZxIfCgtzdHJ1Y3RfdHlwZRgCIAEoCV'
    'IKc3RydWN0VHlwZRISCgRkYXRhGAMgASgJUgRkYXRh');

@$core.Deprecated('Use timeHMSDescriptor instead')
const TimeHMS$json = {
  '1': 'TimeHMS',
  '2': [
    {'1': 'hour', '3': 1, '4': 1, '5': 5, '10': 'hour'},
    {'1': 'minute', '3': 2, '4': 1, '5': 5, '10': 'minute'},
    {'1': 'second', '3': 3, '4': 1, '5': 5, '10': 'second'},
    {'1': 'sub_second', '3': 4, '4': 1, '5': 5, '10': 'subSecond'},
  ],
};

/// Descriptor for `TimeHMS`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timeHMSDescriptor = $convert.base64Decode(
    'CgdUaW1lSE1TEhIKBGhvdXIYASABKAVSBGhvdXISFgoGbWludXRlGAIgASgFUgZtaW51dGUSFg'
    'oGc2Vjb25kGAMgASgFUgZzZWNvbmQSHQoKc3ViX3NlY29uZBgEIAEoBVIJc3ViU2Vjb25k');

@$core.Deprecated('Use timeDescriptor instead')
const Time$json = {
  '1': 'Time',
  '2': [
    {
      '1': 'hms',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.TimeHMS',
      '9': 0,
      '10': 'hms'
    },
    {'1': 'ts', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'ts'},
  ],
  '8': [
    {'1': 'value'},
  ],
};

/// Descriptor for `Time`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timeDescriptor = $convert.base64Decode(
    'CgRUaW1lEjwKA2htcxgBIAEoCzIoLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuVG'
    'ltZUhNU0gAUgNobXMSEAoCdHMYAiABKAlIAFICdHNCBwoFdmFsdWU=');

@$core.Deprecated('Use dateDescriptor instead')
const Date$json = {
  '1': 'Date',
  '2': [
    {'1': 'year', '3': 1, '4': 1, '5': 5, '10': 'year'},
    {'1': 'month', '3': 2, '4': 1, '5': 5, '10': 'month'},
    {'1': 'day', '3': 3, '4': 1, '5': 5, '10': 'day'},
  ],
};

/// Descriptor for `Date`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dateDescriptor = $convert.base64Decode(
    'CgREYXRlEhIKBHllYXIYASABKAVSBHllYXISFAoFbW9udGgYAiABKAVSBW1vbnRoEhAKA2RheR'
    'gDIAEoBVIDZGF5');

@$core.Deprecated('Use dateTimeDescriptor instead')
const DateTime$json = {
  '1': 'DateTime',
  '2': [
    {
      '1': 'date',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Date',
      '10': 'date'
    },
    {
      '1': 'time',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '10': 'time'
    },
  ],
};

/// Descriptor for `DateTime`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dateTimeDescriptor = $convert.base64Decode(
    'CghEYXRlVGltZRI5CgRkYXRlGAEgASgLMiUucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC'
    '52MS5EYXRlUgRkYXRlEjkKBHRpbWUYAiABKAsyJS5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFn'
    'ZW50LnYxLlRpbWVSBHRpbWU=');

@$core.Deprecated('Use durationDescriptor instead')
const Duration$json = {
  '1': 'Duration',
  '2': [
    {'1': 'identifiers', '3': 1, '4': 3, '5': 9, '10': 'identifiers'},
    {'1': 'names', '3': 2, '4': 3, '5': 9, '10': 'names'},
    {
      '1': 'start_time',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '9': 0,
      '10': 'startTime'
    },
    {
      '1': 'start_date',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Date',
      '9': 0,
      '10': 'startDate'
    },
    {
      '1': 'start_dt',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '9': 0,
      '10': 'startDt'
    },
    {
      '1': 'end_time',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Time',
      '9': 1,
      '10': 'endTime'
    },
    {
      '1': 'end_date',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Date',
      '9': 1,
      '10': 'endDate'
    },
    {
      '1': 'end_dt',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '9': 1,
      '10': 'endDt'
    },
    {'1': 'display_name', '3': 101, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'description', '3': 102, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'labels',
      '3': 103,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Duration.LabelsEntry',
      '10': 'labels'
    },
    {'1': 'tags', '3': 104, '4': 3, '5': 9, '10': 'tags'},
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Duration.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [Duration_LabelsEntry$json, Duration_MetadataEntry$json],
  '8': [
    {'1': 'start'},
    {'1': 'end'},
  ],
};

@$core.Deprecated('Use durationDescriptor instead')
const Duration_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use durationDescriptor instead')
const Duration_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Duration`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List durationDescriptor = $convert.base64Decode(
    'CghEdXJhdGlvbhIgCgtpZGVudGlmaWVycxgBIAMoCVILaWRlbnRpZmllcnMSFAoFbmFtZXMYAi'
    'ADKAlSBW5hbWVzEkYKCnN0YXJ0X3RpbWUYBSABKAsyJS5xb21ldC5hZ29yYS5kYWVtb25zLnBy'
    'dGFnZW50LnYxLlRpbWVIAFIJc3RhcnRUaW1lEkYKCnN0YXJ0X2RhdGUYBiABKAsyJS5xb21ldC'
    '5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkRhdGVIAFIJc3RhcnREYXRlEkYKCHN0YXJ0X2R0'
    'GAcgASgLMikucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5EYXRlVGltZUgAUgdzdG'
    'FydER0EkIKCGVuZF90aW1lGAggASgLMiUucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52'
    'MS5UaW1lSAFSB2VuZFRpbWUSQgoIZW5kX2RhdGUYCSABKAsyJS5xb21ldC5hZ29yYS5kYWVtb2'
    '5zLnBydGFnZW50LnYxLkRhdGVIAVIHZW5kRGF0ZRJCCgZlbmRfZHQYCiABKAsyKS5xb21ldC5h'
    'Z29yYS5kYWVtb25zLnBydGFnZW50LnYxLkRhdGVUaW1lSAFSBWVuZER0EiEKDGRpc3BsYXlfbm'
    'FtZRhlIAEoCVILZGlzcGxheU5hbWUSIAoLZGVzY3JpcHRpb24YZiABKAlSC2Rlc2NyaXB0aW9u'
    'Ek0KBmxhYmVscxhnIAMoCzI1LnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuRHVyYX'
    'Rpb24uTGFiZWxzRW50cnlSBmxhYmVscxISCgR0YWdzGGggAygJUgR0YWdzElMKCG1ldGFkYXRh'
    'GGkgAygLMjcucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5EdXJhdGlvbi5NZXRhZG'
    'F0YUVudHJ5UghtZXRhZGF0YRo5CgtMYWJlbHNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2'
    'YWx1ZRgCIAEoCVIFdmFsdWU6AjgBGjsKDU1ldGFkYXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZX'
    'kSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AUIHCgVzdGFydEIFCgNlbmQ=');

@$core.Deprecated('Use paginationParamsDescriptor instead')
const PaginationParams$json = {
  '1': 'PaginationParams',
  '2': [
    {'1': 'page_nr', '3': 1, '4': 1, '5': 5, '10': 'pageNr'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `PaginationParams`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paginationParamsDescriptor = $convert.base64Decode(
    'ChBQYWdpbmF0aW9uUGFyYW1zEhcKB3BhZ2VfbnIYASABKAVSBnBhZ2VOchIbCglwYWdlX3Npem'
    'UYAiABKAVSCHBhZ2VTaXplEh0KCnBhZ2VfdG9rZW4YAyABKAlSCXBhZ2VUb2tlbg==');

@$core.Deprecated('Use paginationInfoDescriptor instead')
const PaginationInfo$json = {
  '1': 'PaginationInfo',
  '2': [
    {'1': 'total_count', '3': 1, '4': 1, '5': 3, '10': 'totalCount'},
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `PaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paginationInfoDescriptor = $convert.base64Decode(
    'Cg5QYWdpbmF0aW9uSW5mbxIfCgt0b3RhbF9jb3VudBgBIAEoA1IKdG90YWxDb3VudBImCg9uZX'
    'h0X3BhZ2VfdG9rZW4YAiABKAlSDW5leHRQYWdlVG9rZW4=');

@$core.Deprecated('Use stringValueDescriptor instead')
const StringValue$json = {
  '1': 'StringValue',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 9, '10': 'value'},
    {'1': 'case_insensitive', '3': 2, '4': 1, '5': 8, '10': 'caseInsensitive'},
    {'1': 'encoding', '3': 3, '4': 1, '5': 9, '10': 'encoding'},
  ],
};

/// Descriptor for `StringValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stringValueDescriptor = $convert.base64Decode(
    'CgtTdHJpbmdWYWx1ZRIUCgV2YWx1ZRgBIAEoCVIFdmFsdWUSKQoQY2FzZV9pbnNlbnNpdGl2ZR'
    'gCIAEoCFIPY2FzZUluc2Vuc2l0aXZlEhoKCGVuY29kaW5nGAMgASgJUghlbmNvZGluZw==');

@$core.Deprecated('Use executionAsyncResponseDescriptor instead')
const ExecutionAsyncResponse$json = {
  '1': 'ExecutionAsyncResponse',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'ref_execution_id', '3': 2, '4': 1, '5': 9, '10': 'refExecutionId'},
    {
      '1': 'generated_at_dt',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'generatedAtDt'
    },
    {
      '1': 'async_status',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.AsyncResponseStatusEnum',
      '10': 'asyncStatus'
    },
    {'1': 'msg', '3': 5, '4': 1, '5': 9, '10': 'msg'},
    {
      '1': 'async_response_data',
      '3': 100,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.ExecutionAsyncResponse.AsyncResponseDataEntry',
      '10': 'asyncResponseData'
    },
    {
      '1': 'metadata',
      '3': 1001,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.ExecutionAsyncResponse.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [
    ExecutionAsyncResponse_AsyncResponseDataEntry$json,
    ExecutionAsyncResponse_MetadataEntry$json
  ],
};

@$core.Deprecated('Use executionAsyncResponseDescriptor instead')
const ExecutionAsyncResponse_AsyncResponseDataEntry$json = {
  '1': 'AsyncResponseDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use executionAsyncResponseDescriptor instead')
const ExecutionAsyncResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ExecutionAsyncResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List executionAsyncResponseDescriptor = $convert.base64Decode(
    'ChZFeGVjdXRpb25Bc3luY1Jlc3BvbnNlEg4KAmlkGAEgASgJUgJpZBIoChByZWZfZXhlY3V0aW'
    '9uX2lkGAIgASgJUg5yZWZFeGVjdXRpb25JZBJRCg9nZW5lcmF0ZWRfYXRfZHQYAyABKAsyKS5x'
    'b21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkRhdGVUaW1lUg1nZW5lcmF0ZWRBdER0El'
    'sKDGFzeW5jX3N0YXR1cxgEIAEoDjI4LnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEu'
    'QXN5bmNSZXNwb25zZVN0YXR1c0VudW1SC2FzeW5jU3RhdHVzEhAKA21zZxgFIAEoCVIDbXNnEn'
    '4KE2FzeW5jX3Jlc3BvbnNlX2RhdGEYZCADKAsyTi5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFn'
    'ZW50LnYxLkV4ZWN1dGlvbkFzeW5jUmVzcG9uc2UuQXN5bmNSZXNwb25zZURhdGFFbnRyeVIRYX'
    'N5bmNSZXNwb25zZURhdGESYgoIbWV0YWRhdGEY6QcgAygLMkUucW9tZXQuYWdvcmEuZGFlbW9u'
    'cy5wcnRhZ2VudC52MS5FeGVjdXRpb25Bc3luY1Jlc3BvbnNlLk1ldGFkYXRhRW50cnlSCG1ldG'
    'FkYXRhGkQKFkFzeW5jUmVzcG9uc2VEYXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFs'
    'dWUYAiABKAlSBXZhbHVlOgI4ARo7Cg1NZXRhZGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5Eh'
    'QKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');
