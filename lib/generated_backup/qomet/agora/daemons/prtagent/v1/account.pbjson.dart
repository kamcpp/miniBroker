// This is a generated file - do not edit.
//
// Generated from account.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use getAccountListRequestDescriptor instead')
const GetAccountListRequest$json = {
  '1': 'GetAccountListRequest',
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
      '1': 'account_iid_or_external_id_regex',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'accountIidOrExternalIdRegex'
    },
    {
      '1': 'aux_data',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetAccountListRequest.AuxDataEntry',
      '10': 'auxData'
    },
  ],
  '3': [GetAccountListRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use getAccountListRequestDescriptor instead')
const GetAccountListRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetAccountListRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountListRequestDescriptor = $convert.base64Decode(
    'ChVHZXRBY2NvdW50TGlzdFJlcXVlc3QSMgoVcHJvcG9zZWRfZXhlY3V0aW9uX2lkGAEgASgJUh'
    'Nwcm9wb3NlZEV4ZWN1dGlvbklkElEKCnBhZ2luYXRpb24YAiABKAsyMS5xb21ldC5hZ29yYS5k'
    'YWVtb25zLnBydGFnZW50LnYxLlBhZ2luYXRpb25QYXJhbXNSCnBhZ2luYXRpb24SRQogYWNjb3'
    'VudF9paWRfb3JfZXh0ZXJuYWxfaWRfcmVnZXgYAyABKAlSG2FjY291bnRJaWRPckV4dGVybmFs'
    'SWRSZWdleBJeCghhdXhfZGF0YRhpIAMoCzJDLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbn'
    'QudjEuR2V0QWNjb3VudExpc3RSZXF1ZXN0LkF1eERhdGFFbnRyeVIHYXV4RGF0YRo6CgxBdXhE'
    'YXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use getAccountListResponseDescriptor instead')
const GetAccountListResponse$json = {
  '1': 'GetAccountListResponse',
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
      '1': 'accounts',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Account',
      '10': 'accounts'
    },
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetAccountListResponse.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [GetAccountListResponse_MetadataEntry$json],
};

@$core.Deprecated('Use getAccountListResponseDescriptor instead')
const GetAccountListResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetAccountListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountListResponseDescriptor = $convert.base64Decode(
    'ChZHZXRBY2NvdW50TGlzdFJlc3BvbnNlEigKEHJlZl9leGVjdXRpb25faWQYASABKAlSDnJlZk'
    'V4ZWN1dGlvbklkElgKD3BhZ2luYXRpb25faW5mbxgCIAEoCzIvLnFvbWV0LmFnb3JhLmRhZW1v'
    'bnMucHJ0YWdlbnQudjEuUGFnaW5hdGlvbkluZm9SDnBhZ2luYXRpb25JbmZvEkQKCGFjY291bn'
    'RzGAMgAygLMigucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5BY2NvdW50UghhY2Nv'
    'dW50cxJhCghtZXRhZGF0YRhpIAMoCzJFLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudj'
    'EuR2V0QWNjb3VudExpc3RSZXNwb25zZS5NZXRhZGF0YUVudHJ5UghtZXRhZGF0YRo7Cg1NZXRh'
    'ZGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use getAccountInfoBatchRequestDescriptor instead')
const GetAccountInfoBatchRequest$json = {
  '1': 'GetAccountInfoBatchRequest',
  '2': [
    {
      '1': 'proposed_execution_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'proposedExecutionId'
    },
    {'1': 'account_iids', '3': 2, '4': 3, '5': 9, '10': 'accountIids'},
    {
      '1': 'aux_data',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetAccountInfoBatchRequest.AuxDataEntry',
      '10': 'auxData'
    },
  ],
  '3': [GetAccountInfoBatchRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use getAccountInfoBatchRequestDescriptor instead')
const GetAccountInfoBatchRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetAccountInfoBatchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountInfoBatchRequestDescriptor = $convert.base64Decode(
    'ChpHZXRBY2NvdW50SW5mb0JhdGNoUmVxdWVzdBIyChVwcm9wb3NlZF9leGVjdXRpb25faWQYAS'
    'ABKAlSE3Byb3Bvc2VkRXhlY3V0aW9uSWQSIQoMYWNjb3VudF9paWRzGAIgAygJUgthY2NvdW50'
    'SWlkcxJjCghhdXhfZGF0YRhpIAMoCzJILnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudj'
    'EuR2V0QWNjb3VudEluZm9CYXRjaFJlcXVlc3QuQXV4RGF0YUVudHJ5UgdhdXhEYXRhGjoKDEF1'
    'eERhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use getAccountInfoBatchResponseDescriptor instead')
const GetAccountInfoBatchResponse$json = {
  '1': 'GetAccountInfoBatchResponse',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {
      '1': 'accounts',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Account',
      '10': 'accounts'
    },
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetAccountInfoBatchResponse.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [GetAccountInfoBatchResponse_MetadataEntry$json],
};

@$core.Deprecated('Use getAccountInfoBatchResponseDescriptor instead')
const GetAccountInfoBatchResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetAccountInfoBatchResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountInfoBatchResponseDescriptor = $convert.base64Decode(
    'ChtHZXRBY2NvdW50SW5mb0JhdGNoUmVzcG9uc2USKAoQcmVmX2V4ZWN1dGlvbl9pZBgBIAEoCV'
    'IOcmVmRXhlY3V0aW9uSWQSRAoIYWNjb3VudHMYAiADKAsyKC5xb21ldC5hZ29yYS5kYWVtb25z'
    'LnBydGFnZW50LnYxLkFjY291bnRSCGFjY291bnRzEmYKCG1ldGFkYXRhGGkgAygLMkoucW9tZX'
    'QuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5HZXRBY2NvdW50SW5mb0JhdGNoUmVzcG9uc2Uu'
    'TWV0YWRhdGFFbnRyeVIIbWV0YWRhdGEaOwoNTWV0YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2'
    'tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use newAccountRequestDescriptor instead')
const NewAccountRequest$json = {
  '1': 'NewAccountRequest',
  '2': [
    {
      '1': 'proposed_execution_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'proposedExecutionId'
    },
    {
      '1': 'external_account_id',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'externalAccountId'
    },
    {
      '1': 'aux_data',
      '3': 105,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.NewAccountRequest.AuxDataEntry',
      '10': 'auxData'
    },
  ],
  '3': [NewAccountRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use newAccountRequestDescriptor instead')
const NewAccountRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `NewAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List newAccountRequestDescriptor = $convert.base64Decode(
    'ChFOZXdBY2NvdW50UmVxdWVzdBIyChVwcm9wb3NlZF9leGVjdXRpb25faWQYASABKAlSE3Byb3'
    'Bvc2VkRXhlY3V0aW9uSWQSLgoTZXh0ZXJuYWxfYWNjb3VudF9pZBgCIAEoCVIRZXh0ZXJuYWxB'
    'Y2NvdW50SWQSWgoIYXV4X2RhdGEYaSADKAsyPy5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW'
    '50LnYxLk5ld0FjY291bnRSZXF1ZXN0LkF1eERhdGFFbnRyeVIHYXV4RGF0YRo6CgxBdXhEYXRh'
    'RW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use newAccountResponseDescriptor instead')
const NewAccountResponse$json = {
  '1': 'NewAccountResponse',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {'1': 'agent_account_id', '3': 2, '4': 1, '5': 9, '10': 'agentAccountId'},
    {
      '1': 'activation_dt',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'activationDt'
    },
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.NewAccountResponse.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [NewAccountResponse_MetadataEntry$json],
};

@$core.Deprecated('Use newAccountResponseDescriptor instead')
const NewAccountResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `NewAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List newAccountResponseDescriptor = $convert.base64Decode(
    'ChJOZXdBY2NvdW50UmVzcG9uc2USKAoQcmVmX2V4ZWN1dGlvbl9pZBgBIAEoCVIOcmVmRXhlY3'
    'V0aW9uSWQSKAoQYWdlbnRfYWNjb3VudF9pZBgCIAEoCVIOYWdlbnRBY2NvdW50SWQSTgoNYWN0'
    'aXZhdGlvbl9kdBgDIAEoCzIpLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuRGF0ZV'
    'RpbWVSDGFjdGl2YXRpb25EdBJdCghtZXRhZGF0YRhpIAMoCzJBLnFvbWV0LmFnb3JhLmRhZW1v'
    'bnMucHJ0YWdlbnQudjEuTmV3QWNjb3VudFJlc3BvbnNlLk1ldGFkYXRhRW50cnlSCG1ldGFkYX'
    'RhGjsKDU1ldGFkYXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZh'
    'bHVlOgI4AQ==');

@$core.Deprecated('Use activateVenueForAccountRequestDescriptor instead')
const ActivateVenueForAccountRequest$json = {
  '1': 'ActivateVenueForAccountRequest',
  '2': [
    {
      '1': 'proposed_execution_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'proposedExecutionId'
    },
    {'1': 'account_iid', '3': 2, '4': 1, '5': 9, '10': 'accountIid'},
    {'1': 'venue_iid', '3': 3, '4': 1, '5': 9, '10': 'venueIid'},
    {
      '1': 'aux_data',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.ActivateVenueForAccountRequest.AuxDataEntry',
      '10': 'auxData'
    },
  ],
  '3': [ActivateVenueForAccountRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use activateVenueForAccountRequestDescriptor instead')
const ActivateVenueForAccountRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ActivateVenueForAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List activateVenueForAccountRequestDescriptor = $convert.base64Decode(
    'Ch5BY3RpdmF0ZVZlbnVlRm9yQWNjb3VudFJlcXVlc3QSMgoVcHJvcG9zZWRfZXhlY3V0aW9uX2'
    'lkGAEgASgJUhNwcm9wb3NlZEV4ZWN1dGlvbklkEh8KC2FjY291bnRfaWlkGAIgASgJUgphY2Nv'
    'dW50SWlkEhsKCXZlbnVlX2lpZBgDIAEoCVIIdmVudWVJaWQSZwoIYXV4X2RhdGEYaSADKAsyTC'
    '5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkFjdGl2YXRlVmVudWVGb3JBY2NvdW50'
    'UmVxdWVzdC5BdXhEYXRhRW50cnlSB2F1eERhdGEaOgoMQXV4RGF0YUVudHJ5EhAKA2tleRgBIA'
    'EoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use activateVenueForAccountResponseDescriptor instead')
const ActivateVenueForAccountResponse$json = {
  '1': 'ActivateVenueForAccountResponse',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {
      '1': 'activation_dt',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'activationDt'
    },
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.ActivateVenueForAccountResponse.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [ActivateVenueForAccountResponse_MetadataEntry$json],
};

@$core.Deprecated('Use activateVenueForAccountResponseDescriptor instead')
const ActivateVenueForAccountResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ActivateVenueForAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List activateVenueForAccountResponseDescriptor = $convert.base64Decode(
    'Ch9BY3RpdmF0ZVZlbnVlRm9yQWNjb3VudFJlc3BvbnNlEigKEHJlZl9leGVjdXRpb25faWQYAS'
    'ABKAlSDnJlZkV4ZWN1dGlvbklkEk4KDWFjdGl2YXRpb25fZHQYAiABKAsyKS5xb21ldC5hZ29y'
    'YS5kYWVtb25zLnBydGFnZW50LnYxLkRhdGVUaW1lUgxhY3RpdmF0aW9uRHQSagoIbWV0YWRhdG'
    'EYaSADKAsyTi5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkFjdGl2YXRlVmVudWVG'
    'b3JBY2NvdW50UmVzcG9uc2UuTWV0YWRhdGFFbnRyeVIIbWV0YWRhdGEaOwoNTWV0YWRhdGFFbn'
    'RyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use getAccountInstrumentHoldingsRequestDescriptor instead')
const GetAccountInstrumentHoldingsRequest$json = {
  '1': 'GetAccountInstrumentHoldingsRequest',
  '2': [
    {
      '1': 'proposed_execution_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'proposedExecutionId'
    },
    {'1': 'account_iid', '3': 2, '4': 1, '5': 9, '10': 'accountIid'},
    {'1': 'venue_iid', '3': 3, '4': 1, '5': 9, '10': 'venueIid'},
    {'1': 'instrument_iids', '3': 4, '4': 3, '5': 9, '10': 'instrumentIids'},
    {
      '1': 'aux_data',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetAccountInstrumentHoldingsRequest.AuxDataEntry',
      '10': 'auxData'
    },
  ],
  '3': [GetAccountInstrumentHoldingsRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use getAccountInstrumentHoldingsRequestDescriptor instead')
const GetAccountInstrumentHoldingsRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetAccountInstrumentHoldingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountInstrumentHoldingsRequestDescriptor = $convert.base64Decode(
    'CiNHZXRBY2NvdW50SW5zdHJ1bWVudEhvbGRpbmdzUmVxdWVzdBIyChVwcm9wb3NlZF9leGVjdX'
    'Rpb25faWQYASABKAlSE3Byb3Bvc2VkRXhlY3V0aW9uSWQSHwoLYWNjb3VudF9paWQYAiABKAlS'
    'CmFjY291bnRJaWQSGwoJdmVudWVfaWlkGAMgASgJUgh2ZW51ZUlpZBInCg9pbnN0cnVtZW50X2'
    'lpZHMYBCADKAlSDmluc3RydW1lbnRJaWRzEmwKCGF1eF9kYXRhGGkgAygLMlEucW9tZXQuYWdv'
    'cmEuZGFlbW9ucy5wcnRhZ2VudC52MS5HZXRBY2NvdW50SW5zdHJ1bWVudEhvbGRpbmdzUmVxdW'
    'VzdC5BdXhEYXRhRW50cnlSB2F1eERhdGEaOgoMQXV4RGF0YUVudHJ5EhAKA2tleRgBIAEoCVID'
    'a2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use getAccountInstrumentHoldingsResponseDescriptor instead')
const GetAccountInstrumentHoldingsResponse$json = {
  '1': 'GetAccountInstrumentHoldingsResponse',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {
      '1': 'portfolio',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Portfolio',
      '10': 'portfolio'
    },
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetAccountInstrumentHoldingsResponse.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [GetAccountInstrumentHoldingsResponse_MetadataEntry$json],
};

@$core.Deprecated('Use getAccountInstrumentHoldingsResponseDescriptor instead')
const GetAccountInstrumentHoldingsResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetAccountInstrumentHoldingsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountInstrumentHoldingsResponseDescriptor = $convert.base64Decode(
    'CiRHZXRBY2NvdW50SW5zdHJ1bWVudEhvbGRpbmdzUmVzcG9uc2USKAoQcmVmX2V4ZWN1dGlvbl'
    '9pZBgBIAEoCVIOcmVmRXhlY3V0aW9uSWQSSAoJcG9ydGZvbGlvGAIgASgLMioucW9tZXQuYWdv'
    'cmEuZGFlbW9ucy5wcnRhZ2VudC52MS5Qb3J0Zm9saW9SCXBvcnRmb2xpbxJvCghtZXRhZGF0YR'
    'hpIAMoCzJTLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuR2V0QWNjb3VudEluc3Ry'
    'dW1lbnRIb2xkaW5nc1Jlc3BvbnNlLk1ldGFkYXRhRW50cnlSCG1ldGFkYXRhGjsKDU1ldGFkYX'
    'RhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use getAccountCashHoldingsRequestDescriptor instead')
const GetAccountCashHoldingsRequest$json = {
  '1': 'GetAccountCashHoldingsRequest',
  '2': [
    {
      '1': 'proposed_execution_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'proposedExecutionId'
    },
    {'1': 'account_iid', '3': 2, '4': 1, '5': 9, '10': 'accountIid'},
    {'1': 'currency_codes', '3': 3, '4': 3, '5': 9, '10': 'currencyCodes'},
    {
      '1': 'aux_data',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetAccountCashHoldingsRequest.AuxDataEntry',
      '10': 'auxData'
    },
  ],
  '3': [GetAccountCashHoldingsRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use getAccountCashHoldingsRequestDescriptor instead')
const GetAccountCashHoldingsRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetAccountCashHoldingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountCashHoldingsRequestDescriptor = $convert.base64Decode(
    'Ch1HZXRBY2NvdW50Q2FzaEhvbGRpbmdzUmVxdWVzdBIyChVwcm9wb3NlZF9leGVjdXRpb25faW'
    'QYASABKAlSE3Byb3Bvc2VkRXhlY3V0aW9uSWQSHwoLYWNjb3VudF9paWQYAiABKAlSCmFjY291'
    'bnRJaWQSJQoOY3VycmVuY3lfY29kZXMYAyADKAlSDWN1cnJlbmN5Q29kZXMSZgoIYXV4X2RhdG'
    'EYaSADKAsySy5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkdldEFjY291bnRDYXNo'
    'SG9sZGluZ3NSZXF1ZXN0LkF1eERhdGFFbnRyeVIHYXV4RGF0YRo6CgxBdXhEYXRhRW50cnkSEA'
    'oDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use getAccountCashHoldingsResponseDescriptor instead')
const GetAccountCashHoldingsResponse$json = {
  '1': 'GetAccountCashHoldingsResponse',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {
      '1': 'cash_portfolio',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Portfolio',
      '10': 'cashPortfolio'
    },
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetAccountCashHoldingsResponse.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [GetAccountCashHoldingsResponse_MetadataEntry$json],
};

@$core.Deprecated('Use getAccountCashHoldingsResponseDescriptor instead')
const GetAccountCashHoldingsResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetAccountCashHoldingsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountCashHoldingsResponseDescriptor = $convert.base64Decode(
    'Ch5HZXRBY2NvdW50Q2FzaEhvbGRpbmdzUmVzcG9uc2USKAoQcmVmX2V4ZWN1dGlvbl9pZBgBIA'
    'EoCVIOcmVmRXhlY3V0aW9uSWQSUQoOY2FzaF9wb3J0Zm9saW8YAiABKAsyKi5xb21ldC5hZ29y'
    'YS5kYWVtb25zLnBydGFnZW50LnYxLlBvcnRmb2xpb1INY2FzaFBvcnRmb2xpbxJpCghtZXRhZG'
    'F0YRhpIAMoCzJNLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuR2V0QWNjb3VudENh'
    'c2hIb2xkaW5nc1Jlc3BvbnNlLk1ldGFkYXRhRW50cnlSCG1ldGFkYXRhGjsKDU1ldGFkYXRhRW'
    '50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use depositCashRequestDescriptor instead')
const DepositCashRequest$json = {
  '1': 'DepositCashRequest',
  '2': [
    {
      '1': 'proposed_execution_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'proposedExecutionId'
    },
    {'1': 'account_iid', '3': 2, '4': 1, '5': 9, '10': 'accountIid'},
    {'1': 'currency_code', '3': 3, '4': 1, '5': 9, '10': 'currencyCode'},
    {'1': 'amount', '3': 4, '4': 1, '5': 9, '10': 'amount'},
    {
      '1': 'aux_data',
      '3': 105,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DepositCashRequest.AuxDataEntry',
      '10': 'auxData'
    },
  ],
  '3': [DepositCashRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use depositCashRequestDescriptor instead')
const DepositCashRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `DepositCashRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List depositCashRequestDescriptor = $convert.base64Decode(
    'ChJEZXBvc2l0Q2FzaFJlcXVlc3QSMgoVcHJvcG9zZWRfZXhlY3V0aW9uX2lkGAEgASgJUhNwcm'
    '9wb3NlZEV4ZWN1dGlvbklkEh8KC2FjY291bnRfaWlkGAIgASgJUgphY2NvdW50SWlkEiMKDWN1'
    'cnJlbmN5X2NvZGUYAyABKAlSDGN1cnJlbmN5Q29kZRIWCgZhbW91bnQYBCABKAlSBmFtb3VudB'
    'JbCghhdXhfZGF0YRhpIAMoCzJALnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuRGVw'
    'b3NpdENhc2hSZXF1ZXN0LkF1eERhdGFFbnRyeVIHYXV4RGF0YRo6CgxBdXhEYXRhRW50cnkSEA'
    'oDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use depositCashResponseDescriptor instead')
const DepositCashResponse$json = {
  '1': 'DepositCashResponse',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DepositCashResponse.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [DepositCashResponse_MetadataEntry$json],
};

@$core.Deprecated('Use depositCashResponseDescriptor instead')
const DepositCashResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `DepositCashResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List depositCashResponseDescriptor = $convert.base64Decode(
    'ChNEZXBvc2l0Q2FzaFJlc3BvbnNlEigKEHJlZl9leGVjdXRpb25faWQYASABKAlSDnJlZkV4ZW'
    'N1dGlvbklkEl4KCG1ldGFkYXRhGGkgAygLMkIucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2Vu'
    'dC52MS5EZXBvc2l0Q2FzaFJlc3BvbnNlLk1ldGFkYXRhRW50cnlSCG1ldGFkYXRhGjsKDU1ldG'
    'FkYXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use depositInstrumentRequestDescriptor instead')
const DepositInstrumentRequest$json = {
  '1': 'DepositInstrumentRequest',
  '2': [
    {
      '1': 'proposed_execution_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'proposedExecutionId'
    },
    {'1': 'account_iid', '3': 2, '4': 1, '5': 9, '10': 'accountIid'},
    {'1': 'instrument_iid', '3': 3, '4': 1, '5': 9, '10': 'instrumentIid'},
    {'1': 'units', '3': 4, '4': 1, '5': 9, '10': 'units'},
    {
      '1': 'aux_data',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.DepositInstrumentRequest.AuxDataEntry',
      '10': 'auxData'
    },
  ],
  '3': [DepositInstrumentRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use depositInstrumentRequestDescriptor instead')
const DepositInstrumentRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `DepositInstrumentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List depositInstrumentRequestDescriptor = $convert.base64Decode(
    'ChhEZXBvc2l0SW5zdHJ1bWVudFJlcXVlc3QSMgoVcHJvcG9zZWRfZXhlY3V0aW9uX2lkGAEgAS'
    'gJUhNwcm9wb3NlZEV4ZWN1dGlvbklkEh8KC2FjY291bnRfaWlkGAIgASgJUgphY2NvdW50SWlk'
    'EiUKDmluc3RydW1lbnRfaWlkGAMgASgJUg1pbnN0cnVtZW50SWlkEhQKBXVuaXRzGAQgASgJUg'
    'V1bml0cxJhCghhdXhfZGF0YRhpIAMoCzJGLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQu'
    'djEuRGVwb3NpdEluc3RydW1lbnRSZXF1ZXN0LkF1eERhdGFFbnRyeVIHYXV4RGF0YRo6CgxBdX'
    'hEYXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use depositInstrumentResponseDescriptor instead')
const DepositInstrumentResponse$json = {
  '1': 'DepositInstrumentResponse',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.DepositInstrumentResponse.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [DepositInstrumentResponse_MetadataEntry$json],
};

@$core.Deprecated('Use depositInstrumentResponseDescriptor instead')
const DepositInstrumentResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `DepositInstrumentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List depositInstrumentResponseDescriptor = $convert.base64Decode(
    'ChlEZXBvc2l0SW5zdHJ1bWVudFJlc3BvbnNlEigKEHJlZl9leGVjdXRpb25faWQYASABKAlSDn'
    'JlZkV4ZWN1dGlvbklkEmQKCG1ldGFkYXRhGGkgAygLMkgucW9tZXQuYWdvcmEuZGFlbW9ucy5w'
    'cnRhZ2VudC52MS5EZXBvc2l0SW5zdHJ1bWVudFJlc3BvbnNlLk1ldGFkYXRhRW50cnlSCG1ldG'
    'FkYXRhGjsKDU1ldGFkYXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlS'
    'BXZhbHVlOgI4AQ==');

@$core.Deprecated('Use withdrawCashRequestDescriptor instead')
const WithdrawCashRequest$json = {
  '1': 'WithdrawCashRequest',
  '2': [
    {
      '1': 'proposed_execution_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'proposedExecutionId'
    },
    {'1': 'account_iid', '3': 2, '4': 1, '5': 9, '10': 'accountIid'},
    {'1': 'currency_code', '3': 3, '4': 1, '5': 9, '10': 'currencyCode'},
    {'1': 'amount', '3': 4, '4': 1, '5': 9, '10': 'amount'},
    {
      '1': 'aux_data',
      '3': 105,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.WithdrawCashRequest.AuxDataEntry',
      '10': 'auxData'
    },
  ],
  '3': [WithdrawCashRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use withdrawCashRequestDescriptor instead')
const WithdrawCashRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `WithdrawCashRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawCashRequestDescriptor = $convert.base64Decode(
    'ChNXaXRoZHJhd0Nhc2hSZXF1ZXN0EjIKFXByb3Bvc2VkX2V4ZWN1dGlvbl9pZBgBIAEoCVITcH'
    'JvcG9zZWRFeGVjdXRpb25JZBIfCgthY2NvdW50X2lpZBgCIAEoCVIKYWNjb3VudElpZBIjCg1j'
    'dXJyZW5jeV9jb2RlGAMgASgJUgxjdXJyZW5jeUNvZGUSFgoGYW1vdW50GAQgASgJUgZhbW91bn'
    'QSXAoIYXV4X2RhdGEYaSADKAsyQS5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLldp'
    'dGhkcmF3Q2FzaFJlcXVlc3QuQXV4RGF0YUVudHJ5UgdhdXhEYXRhGjoKDEF1eERhdGFFbnRyeR'
    'IQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use withdrawCashResponseDescriptor instead')
const WithdrawCashResponse$json = {
  '1': 'WithdrawCashResponse',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.WithdrawCashResponse.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [WithdrawCashResponse_MetadataEntry$json],
};

@$core.Deprecated('Use withdrawCashResponseDescriptor instead')
const WithdrawCashResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `WithdrawCashResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawCashResponseDescriptor = $convert.base64Decode(
    'ChRXaXRoZHJhd0Nhc2hSZXNwb25zZRIoChByZWZfZXhlY3V0aW9uX2lkGAEgASgJUg5yZWZFeG'
    'VjdXRpb25JZBJfCghtZXRhZGF0YRhpIAMoCzJDLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdl'
    'bnQudjEuV2l0aGRyYXdDYXNoUmVzcG9uc2UuTWV0YWRhdGFFbnRyeVIIbWV0YWRhdGEaOwoNTW'
    'V0YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use withdrawInstrumentRequestDescriptor instead')
const WithdrawInstrumentRequest$json = {
  '1': 'WithdrawInstrumentRequest',
  '2': [
    {
      '1': 'proposed_execution_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'proposedExecutionId'
    },
    {'1': 'account_iid', '3': 2, '4': 1, '5': 9, '10': 'accountIid'},
    {'1': 'instrument_iid', '3': 3, '4': 1, '5': 9, '10': 'instrumentIid'},
    {'1': 'units', '3': 4, '4': 1, '5': 9, '10': 'units'},
    {
      '1': 'aux_data',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.WithdrawInstrumentRequest.AuxDataEntry',
      '10': 'auxData'
    },
  ],
  '3': [WithdrawInstrumentRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use withdrawInstrumentRequestDescriptor instead')
const WithdrawInstrumentRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `WithdrawInstrumentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawInstrumentRequestDescriptor = $convert.base64Decode(
    'ChlXaXRoZHJhd0luc3RydW1lbnRSZXF1ZXN0EjIKFXByb3Bvc2VkX2V4ZWN1dGlvbl9pZBgBIA'
    'EoCVITcHJvcG9zZWRFeGVjdXRpb25JZBIfCgthY2NvdW50X2lpZBgCIAEoCVIKYWNjb3VudElp'
    'ZBIlCg5pbnN0cnVtZW50X2lpZBgDIAEoCVINaW5zdHJ1bWVudElpZBIUCgV1bml0cxgEIAEoCV'
    'IFdW5pdHMSYgoIYXV4X2RhdGEYaSADKAsyRy5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50'
    'LnYxLldpdGhkcmF3SW5zdHJ1bWVudFJlcXVlc3QuQXV4RGF0YUVudHJ5UgdhdXhEYXRhGjoKDE'
    'F1eERhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use withdrawInstrumentResponseDescriptor instead')
const WithdrawInstrumentResponse$json = {
  '1': 'WithdrawInstrumentResponse',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.WithdrawInstrumentResponse.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [WithdrawInstrumentResponse_MetadataEntry$json],
};

@$core.Deprecated('Use withdrawInstrumentResponseDescriptor instead')
const WithdrawInstrumentResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `WithdrawInstrumentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawInstrumentResponseDescriptor = $convert.base64Decode(
    'ChpXaXRoZHJhd0luc3RydW1lbnRSZXNwb25zZRIoChByZWZfZXhlY3V0aW9uX2lkGAEgASgJUg'
    '5yZWZFeGVjdXRpb25JZBJlCghtZXRhZGF0YRhpIAMoCzJJLnFvbWV0LmFnb3JhLmRhZW1vbnMu'
    'cHJ0YWdlbnQudjEuV2l0aGRyYXdJbnN0cnVtZW50UmVzcG9uc2UuTWV0YWRhdGFFbnRyeVIIbW'
    'V0YWRhdGEaOwoNTWV0YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEo'
    'CVIFdmFsdWU6AjgB');

@$core.Deprecated('Use getAccountOrdersRequestDescriptor instead')
const GetAccountOrdersRequest$json = {
  '1': 'GetAccountOrdersRequest',
  '2': [
    {
      '1': 'proposed_execution_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'proposedExecutionId'
    },
    {'1': 'account_iid', '3': 2, '4': 1, '5': 9, '10': 'accountIid'},
    {
      '1': 'venue_id_or_symbol_regexes',
      '3': 3,
      '4': 3,
      '5': 9,
      '10': 'venueIdOrSymbolRegexes'
    },
    {
      '1': 'pagination',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.PaginationParams',
      '10': 'pagination'
    },
    {
      '1': 'order_query_filter',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.OrderQueryFilter',
      '10': 'orderQueryFilter'
    },
    {
      '1': 'aux_data',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetAccountOrdersRequest.AuxDataEntry',
      '10': 'auxData'
    },
  ],
  '3': [GetAccountOrdersRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use getAccountOrdersRequestDescriptor instead')
const GetAccountOrdersRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetAccountOrdersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountOrdersRequestDescriptor = $convert.base64Decode(
    'ChdHZXRBY2NvdW50T3JkZXJzUmVxdWVzdBIyChVwcm9wb3NlZF9leGVjdXRpb25faWQYASABKA'
    'lSE3Byb3Bvc2VkRXhlY3V0aW9uSWQSHwoLYWNjb3VudF9paWQYAiABKAlSCmFjY291bnRJaWQS'
    'OgoadmVudWVfaWRfb3Jfc3ltYm9sX3JlZ2V4ZXMYAyADKAlSFnZlbnVlSWRPclN5bWJvbFJlZ2'
    'V4ZXMSUQoKcGFnaW5hdGlvbhgEIAEoCzIxLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQu'
    'djEuUGFnaW5hdGlvblBhcmFtc1IKcGFnaW5hdGlvbhJfChJvcmRlcl9xdWVyeV9maWx0ZXIYBS'
    'ABKAsyMS5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLk9yZGVyUXVlcnlGaWx0ZXJS'
    'EG9yZGVyUXVlcnlGaWx0ZXISYAoIYXV4X2RhdGEYaSADKAsyRS5xb21ldC5hZ29yYS5kYWVtb2'
    '5zLnBydGFnZW50LnYxLkdldEFjY291bnRPcmRlcnNSZXF1ZXN0LkF1eERhdGFFbnRyeVIHYXV4'
    'RGF0YRo6CgxBdXhEYXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBX'
    'ZhbHVlOgI4AQ==');

@$core.Deprecated('Use getAccountOrdersResponseDescriptor instead')
const GetAccountOrdersResponse$json = {
  '1': 'GetAccountOrdersResponse',
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
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetAccountOrdersResponse.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [GetAccountOrdersResponse_MetadataEntry$json],
};

@$core.Deprecated('Use getAccountOrdersResponseDescriptor instead')
const GetAccountOrdersResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetAccountOrdersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountOrdersResponseDescriptor = $convert.base64Decode(
    'ChhHZXRBY2NvdW50T3JkZXJzUmVzcG9uc2USKAoQcmVmX2V4ZWN1dGlvbl9pZBgBIAEoCVIOcm'
    'VmRXhlY3V0aW9uSWQSWAoPcGFnaW5hdGlvbl9pbmZvGAIgASgLMi8ucW9tZXQuYWdvcmEuZGFl'
    'bW9ucy5wcnRhZ2VudC52MS5QYWdpbmF0aW9uSW5mb1IOcGFnaW5hdGlvbkluZm8SUQoPZ2VuZX'
    'JhdGVkX2F0X2R0GAMgASgLMikucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5EYXRl'
    'VGltZVINZ2VuZXJhdGVkQXREdBI+CgZvcmRlcnMYBCADKAsyJi5xb21ldC5hZ29yYS5kYWVtb2'
    '5zLnBydGFnZW50LnYxLk9yZGVyUgZvcmRlcnMSYwoIbWV0YWRhdGEYaSADKAsyRy5xb21ldC5h'
    'Z29yYS5kYWVtb25zLnBydGFnZW50LnYxLkdldEFjY291bnRPcmRlcnNSZXNwb25zZS5NZXRhZG'
    'F0YUVudHJ5UghtZXRhZGF0YRo7Cg1NZXRhZGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQK'
    'BXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use getAccountTradesRequestDescriptor instead')
const GetAccountTradesRequest$json = {
  '1': 'GetAccountTradesRequest',
  '2': [
    {
      '1': 'proposed_execution_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'proposedExecutionId'
    },
    {'1': 'account_iid', '3': 2, '4': 1, '5': 9, '10': 'accountIid'},
    {
      '1': 'market_id_or_name_regexes',
      '3': 3,
      '4': 3,
      '5': 9,
      '10': 'marketIdOrNameRegexes'
    },
    {
      '1': 'pagination',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.PaginationParams',
      '10': 'pagination'
    },
    {
      '1': 'from_dt',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'fromDt'
    },
    {
      '1': 'to_dt',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'toDt'
    },
    {
      '1': 'instrument_id_or_symbol_regexes',
      '3': 7,
      '4': 3,
      '5': 9,
      '10': 'instrumentIdOrSymbolRegexes'
    },
    {
      '1': 'side',
      '3': 8,
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
          '.qomet.agora.daemons.prtagent.v1.GetAccountTradesRequest.AuxDataEntry',
      '10': 'auxData'
    },
  ],
  '3': [GetAccountTradesRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use getAccountTradesRequestDescriptor instead')
const GetAccountTradesRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetAccountTradesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountTradesRequestDescriptor = $convert.base64Decode(
    'ChdHZXRBY2NvdW50VHJhZGVzUmVxdWVzdBIyChVwcm9wb3NlZF9leGVjdXRpb25faWQYASABKA'
    'lSE3Byb3Bvc2VkRXhlY3V0aW9uSWQSHwoLYWNjb3VudF9paWQYAiABKAlSCmFjY291bnRJaWQS'
    'OAoZbWFya2V0X2lkX29yX25hbWVfcmVnZXhlcxgDIAMoCVIVbWFya2V0SWRPck5hbWVSZWdleG'
    'VzElEKCnBhZ2luYXRpb24YBCABKAsyMS5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYx'
    'LlBhZ2luYXRpb25QYXJhbXNSCnBhZ2luYXRpb24SQgoHZnJvbV9kdBgFIAEoCzIpLnFvbWV0Lm'
    'Fnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuRGF0ZVRpbWVSBmZyb21EdBI+CgV0b19kdBgGIAEo'
    'CzIpLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuRGF0ZVRpbWVSBHRvRHQSRAofaW'
    '5zdHJ1bWVudF9pZF9vcl9zeW1ib2xfcmVnZXhlcxgHIAMoCVIbaW5zdHJ1bWVudElkT3JTeW1i'
    'b2xSZWdleGVzEj4KBHNpZGUYCCABKA4yKi5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50Ln'
    'YxLk9yZGVyU2lkZVIEc2lkZRJgCghhdXhfZGF0YRhpIAMoCzJFLnFvbWV0LmFnb3JhLmRhZW1v'
    'bnMucHJ0YWdlbnQudjEuR2V0QWNjb3VudFRyYWRlc1JlcXVlc3QuQXV4RGF0YUVudHJ5UgdhdX'
    'hEYXRhGjoKDEF1eERhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIF'
    'dmFsdWU6AjgB');

@$core.Deprecated('Use getAccountTradesResponseDescriptor instead')
const GetAccountTradesResponse$json = {
  '1': 'GetAccountTradesResponse',
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
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetAccountTradesResponse.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [GetAccountTradesResponse_MetadataEntry$json],
};

@$core.Deprecated('Use getAccountTradesResponseDescriptor instead')
const GetAccountTradesResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetAccountTradesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountTradesResponseDescriptor = $convert.base64Decode(
    'ChhHZXRBY2NvdW50VHJhZGVzUmVzcG9uc2USKAoQcmVmX2V4ZWN1dGlvbl9pZBgBIAEoCVIOcm'
    'VmRXhlY3V0aW9uSWQSWAoPcGFnaW5hdGlvbl9pbmZvGAIgASgLMi8ucW9tZXQuYWdvcmEuZGFl'
    'bW9ucy5wcnRhZ2VudC52MS5QYWdpbmF0aW9uSW5mb1IOcGFnaW5hdGlvbkluZm8SUQoPZ2VuZX'
    'JhdGVkX2F0X2R0GAMgASgLMikucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5EYXRl'
    'VGltZVINZ2VuZXJhdGVkQXREdBI+CgZ0cmFkZXMYBCADKAsyJi5xb21ldC5hZ29yYS5kYWVtb2'
    '5zLnBydGFnZW50LnYxLlRyYWRlUgZ0cmFkZXMSYwoIbWV0YWRhdGEYaSADKAsyRy5xb21ldC5h'
    'Z29yYS5kYWVtb25zLnBydGFnZW50LnYxLkdldEFjY291bnRUcmFkZXNSZXNwb25zZS5NZXRhZG'
    'F0YUVudHJ5UghtZXRhZGF0YRo7Cg1NZXRhZGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQK'
    'BXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use getAccountSettlementsRequestDescriptor instead')
const GetAccountSettlementsRequest$json = {
  '1': 'GetAccountSettlementsRequest',
  '2': [
    {
      '1': 'proposed_execution_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'proposedExecutionId'
    },
    {'1': 'account_iid', '3': 2, '4': 1, '5': 9, '10': 'accountIid'},
    {
      '1': 'market_id_or_name_regexes',
      '3': 3,
      '4': 3,
      '5': 9,
      '10': 'marketIdOrNameRegexes'
    },
    {
      '1': 'pagination',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.PaginationParams',
      '10': 'pagination'
    },
    {
      '1': 'from_dt',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'fromDt'
    },
    {
      '1': 'to_dt',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'toDt'
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
    {
      '1': 'aux_data',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetAccountSettlementsRequest.AuxDataEntry',
      '10': 'auxData'
    },
  ],
  '3': [GetAccountSettlementsRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use getAccountSettlementsRequestDescriptor instead')
const GetAccountSettlementsRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetAccountSettlementsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountSettlementsRequestDescriptor = $convert.base64Decode(
    'ChxHZXRBY2NvdW50U2V0dGxlbWVudHNSZXF1ZXN0EjIKFXByb3Bvc2VkX2V4ZWN1dGlvbl9pZB'
    'gBIAEoCVITcHJvcG9zZWRFeGVjdXRpb25JZBIfCgthY2NvdW50X2lpZBgCIAEoCVIKYWNjb3Vu'
    'dElpZBI4ChltYXJrZXRfaWRfb3JfbmFtZV9yZWdleGVzGAMgAygJUhVtYXJrZXRJZE9yTmFtZV'
    'JlZ2V4ZXMSUQoKcGFnaW5hdGlvbhgEIAEoCzIxLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdl'
    'bnQudjEuUGFnaW5hdGlvblBhcmFtc1IKcGFnaW5hdGlvbhJCCgdmcm9tX2R0GAUgASgLMikucW'
    '9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5EYXRlVGltZVIGZnJvbUR0Ej4KBXRvX2R0'
    'GAYgASgLMikucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5EYXRlVGltZVIEdG9EdB'
    'JLCgZzdGF0dXMYByABKA4yMy5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkNvbmZp'
    'cm1hdGlvblN0YXR1c1IGc3RhdHVzEjYKGGFzc2V0X2lkX29yX25hbWVfcmVnZXhlcxgIIAMoCV'
    'IUYXNzZXRJZE9yTmFtZVJlZ2V4ZXMSZQoIYXV4X2RhdGEYaSADKAsySi5xb21ldC5hZ29yYS5k'
    'YWVtb25zLnBydGFnZW50LnYxLkdldEFjY291bnRTZXR0bGVtZW50c1JlcXVlc3QuQXV4RGF0YU'
    'VudHJ5UgdhdXhEYXRhGjoKDEF1eERhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1'
    'ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use getAccountSettlementsResponseDescriptor instead')
const GetAccountSettlementsResponse$json = {
  '1': 'GetAccountSettlementsResponse',
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
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetAccountSettlementsResponse.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [GetAccountSettlementsResponse_MetadataEntry$json],
};

@$core.Deprecated('Use getAccountSettlementsResponseDescriptor instead')
const GetAccountSettlementsResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetAccountSettlementsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountSettlementsResponseDescriptor = $convert.base64Decode(
    'Ch1HZXRBY2NvdW50U2V0dGxlbWVudHNSZXNwb25zZRIoChByZWZfZXhlY3V0aW9uX2lkGAEgAS'
    'gJUg5yZWZFeGVjdXRpb25JZBJYCg9wYWdpbmF0aW9uX2luZm8YAiABKAsyLy5xb21ldC5hZ29y'
    'YS5kYWVtb25zLnBydGFnZW50LnYxLlBhZ2luYXRpb25JbmZvUg5wYWdpbmF0aW9uSW5mbxJRCg'
    '9nZW5lcmF0ZWRfYXRfZHQYAyABKAsyKS5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYx'
    'LkRhdGVUaW1lUg1nZW5lcmF0ZWRBdER0Ek0KC3NldHRsZW1lbnRzGAQgAygLMisucW9tZXQuYW'
    'dvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5TZXR0bGVtZW50UgtzZXR0bGVtZW50cxJoCghtZXRh'
    'ZGF0YRhpIAMoCzJMLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuR2V0QWNjb3VudF'
    'NldHRsZW1lbnRzUmVzcG9uc2UuTWV0YWRhdGFFbnRyeVIIbWV0YWRhdGEaOwoNTWV0YWRhdGFF'
    'bnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use getAccountTransactionsRequestDescriptor instead')
const GetAccountTransactionsRequest$json = {
  '1': 'GetAccountTransactionsRequest',
  '2': [
    {
      '1': 'proposed_execution_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'proposedExecutionId'
    },
    {'1': 'account_iid', '3': 2, '4': 1, '5': 9, '10': 'accountIid'},
    {
      '1': 'pagination',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.PaginationParams',
      '10': 'pagination'
    },
    {
      '1': 'from_dt',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'fromDt'
    },
    {
      '1': 'to_dt',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'toDt'
    },
    {
      '1': 'transaction_types',
      '3': 6,
      '4': 3,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.TransactionTypeEnum',
      '10': 'transactionTypes'
    },
    {
      '1': 'asset_id_or_name_regexes',
      '3': 7,
      '4': 3,
      '5': 9,
      '10': 'assetIdOrNameRegexes'
    },
    {
      '1': 'aux_data',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetAccountTransactionsRequest.AuxDataEntry',
      '10': 'auxData'
    },
  ],
  '3': [GetAccountTransactionsRequest_AuxDataEntry$json],
};

@$core.Deprecated('Use getAccountTransactionsRequestDescriptor instead')
const GetAccountTransactionsRequest_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetAccountTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountTransactionsRequestDescriptor = $convert.base64Decode(
    'Ch1HZXRBY2NvdW50VHJhbnNhY3Rpb25zUmVxdWVzdBIyChVwcm9wb3NlZF9leGVjdXRpb25faW'
    'QYASABKAlSE3Byb3Bvc2VkRXhlY3V0aW9uSWQSHwoLYWNjb3VudF9paWQYAiABKAlSCmFjY291'
    'bnRJaWQSUQoKcGFnaW5hdGlvbhgDIAEoCzIxLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbn'
    'QudjEuUGFnaW5hdGlvblBhcmFtc1IKcGFnaW5hdGlvbhJCCgdmcm9tX2R0GAQgASgLMikucW9t'
    'ZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5EYXRlVGltZVIGZnJvbUR0Ej4KBXRvX2R0GA'
    'UgASgLMikucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5EYXRlVGltZVIEdG9EdBJh'
    'ChF0cmFuc2FjdGlvbl90eXBlcxgGIAMoDjI0LnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbn'
    'QudjEuVHJhbnNhY3Rpb25UeXBlRW51bVIQdHJhbnNhY3Rpb25UeXBlcxI2Chhhc3NldF9pZF9v'
    'cl9uYW1lX3JlZ2V4ZXMYByADKAlSFGFzc2V0SWRPck5hbWVSZWdleGVzEmYKCGF1eF9kYXRhGG'
    'kgAygLMksucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5HZXRBY2NvdW50VHJhbnNh'
    'Y3Rpb25zUmVxdWVzdC5BdXhEYXRhRW50cnlSB2F1eERhdGEaOgoMQXV4RGF0YUVudHJ5EhAKA2'
    'tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use getAccountTransactionsResponseDescriptor instead')
const GetAccountTransactionsResponse$json = {
  '1': 'GetAccountTransactionsResponse',
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
      '1': 'transactions',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Transaction',
      '10': 'transactions'
    },
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetAccountTransactionsResponse.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [GetAccountTransactionsResponse_MetadataEntry$json],
};

@$core.Deprecated('Use getAccountTransactionsResponseDescriptor instead')
const GetAccountTransactionsResponse_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetAccountTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountTransactionsResponseDescriptor = $convert.base64Decode(
    'Ch5HZXRBY2NvdW50VHJhbnNhY3Rpb25zUmVzcG9uc2USKAoQcmVmX2V4ZWN1dGlvbl9pZBgBIA'
    'EoCVIOcmVmRXhlY3V0aW9uSWQSWAoPcGFnaW5hdGlvbl9pbmZvGAIgASgLMi8ucW9tZXQuYWdv'
    'cmEuZGFlbW9ucy5wcnRhZ2VudC52MS5QYWdpbmF0aW9uSW5mb1IOcGFnaW5hdGlvbkluZm8SUQ'
    'oPZ2VuZXJhdGVkX2F0X2R0GAMgASgLMikucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52'
    'MS5EYXRlVGltZVINZ2VuZXJhdGVkQXREdBJQCgx0cmFuc2FjdGlvbnMYBCADKAsyLC5xb21ldC'
    '5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLlRyYW5zYWN0aW9uUgx0cmFuc2FjdGlvbnMSaQoI'
    'bWV0YWRhdGEYaSADKAsyTS5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkdldEFjY2'
    '91bnRUcmFuc2FjdGlvbnNSZXNwb25zZS5NZXRhZGF0YUVudHJ5UghtZXRhZGF0YRo7Cg1NZXRh'
    'ZGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');
