// This is a generated file - do not edit.
//
// Generated from event.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use eventTypeEnumDescriptor instead')
const EventTypeEnum$json = {
  '1': 'EventTypeEnum',
  '2': [
    {'1': 'EVENT_TYPE_ENUM__UNKNOWN', '2': 0},
    {'1': 'EVENT_TYPE_ENUM__NEWS', '2': 1},
    {'1': 'EVENT_TYPE_ENUM__ANNOUNCEMENT', '2': 2},
    {'1': 'EVENT_TYPE_ENUM__MARKET_UPDATE', '2': 3},
    {'1': 'EVENT_TYPE_ENUM__TRADE_EXECUTION', '2': 4},
    {'1': 'EVENT_TYPE_ENUM__ORDER_PLACED', '2': 5},
    {'1': 'EVENT_TYPE_ENUM__ORDER_CANCELLED', '2': 6},
    {'1': 'EVENT_TYPE_ENUM__ORDER_FILLED', '2': 7},
    {'1': 'EVENT_TYPE_ENUM__ORDER_EXPIRED', '2': 8},
    {'1': 'EVENT_TYPE_ENUM__PRICE_UPDATE', '2': 9},
    {'1': 'EVENT_TYPE_ENUM__REGULATORY', '2': 10},
    {'1': 'EVENT_TYPE_ENUM__SYSTEM', '2': 11},
    {'1': 'EVENT_TYPE_ENUM__EXECUTION_UPDATE', '2': 12},
    {'1': 'EVENT_TYPE_ENUM__EXECUTION_RESPONSE', '2': 13},
    {'1': 'EVENT_TYPE_ENUM__OTHER', '2': 1000},
  ],
};

/// Descriptor for `EventTypeEnum`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List eventTypeEnumDescriptor = $convert.base64Decode(
    'Cg1FdmVudFR5cGVFbnVtEhwKGEVWRU5UX1RZUEVfRU5VTV9fVU5LTk9XThAAEhkKFUVWRU5UX1'
    'RZUEVfRU5VTV9fTkVXUxABEiEKHUVWRU5UX1RZUEVfRU5VTV9fQU5OT1VOQ0VNRU5UEAISIgoe'
    'RVZFTlRfVFlQRV9FTlVNX19NQVJLRVRfVVBEQVRFEAMSJAogRVZFTlRfVFlQRV9FTlVNX19UUk'
    'FERV9FWEVDVVRJT04QBBIhCh1FVkVOVF9UWVBFX0VOVU1fX09SREVSX1BMQUNFRBAFEiQKIEVW'
    'RU5UX1RZUEVfRU5VTV9fT1JERVJfQ0FOQ0VMTEVEEAYSIQodRVZFTlRfVFlQRV9FTlVNX19PUk'
    'RFUl9GSUxMRUQQBxIiCh5FVkVOVF9UWVBFX0VOVU1fX09SREVSX0VYUElSRUQQCBIhCh1FVkVO'
    'VF9UWVBFX0VOVU1fX1BSSUNFX1VQREFURRAJEh8KG0VWRU5UX1RZUEVfRU5VTV9fUkVHVUxBVE'
    '9SWRAKEhsKF0VWRU5UX1RZUEVfRU5VTV9fU1lTVEVNEAsSJQohRVZFTlRfVFlQRV9FTlVNX19F'
    'WEVDVVRJT05fVVBEQVRFEAwSJwojRVZFTlRfVFlQRV9FTlVNX19FWEVDVVRJT05fUkVTUE9OU0'
    'UQDRIbChZFVkVOVF9UWVBFX0VOVU1fX09USEVSEOgH');

@$core.Deprecated('Use executionUpdateEventTypeEnumDescriptor instead')
const ExecutionUpdateEventTypeEnum$json = {
  '1': 'ExecutionUpdateEventTypeEnum',
  '2': [
    {'1': 'EXECUTION_UPDATE_EVENT_TYPE_ENUM__UNKNOWN', '2': 0},
    {'1': 'EXECUTION_UPDATE_EVENT_TYPE_ENUM__NEW_EXECUTION_FLOW', '2': 1},
    {'1': 'EXECUTION_UPDATE_EVENT_TYPE_ENUM__FLOW_PROGRESS_REPORT', '2': 2},
    {'1': 'EXECUTION_UPDATE_EVENT_TYPE_ENUM__EXECUTION_COMPLETED', '2': 3},
    {'1': 'EXECUTION_UPDATE_EVENT_TYPE_ENUM__OTHER', '2': 1000},
  ],
};

/// Descriptor for `ExecutionUpdateEventTypeEnum`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List executionUpdateEventTypeEnumDescriptor = $convert.base64Decode(
    'ChxFeGVjdXRpb25VcGRhdGVFdmVudFR5cGVFbnVtEi0KKUVYRUNVVElPTl9VUERBVEVfRVZFTl'
    'RfVFlQRV9FTlVNX19VTktOT1dOEAASOAo0RVhFQ1VUSU9OX1VQREFURV9FVkVOVF9UWVBFX0VO'
    'VU1fX05FV19FWEVDVVRJT05fRkxPVxABEjoKNkVYRUNVVElPTl9VUERBVEVfRVZFTlRfVFlQRV'
    '9FTlVNX19GTE9XX1BST0dSRVNTX1JFUE9SVBACEjkKNUVYRUNVVElPTl9VUERBVEVfRVZFTlRf'
    'VFlQRV9FTlVNX19FWEVDVVRJT05fQ09NUExFVEVEEAMSLAonRVhFQ1VUSU9OX1VQREFURV9FVk'
    'VOVF9UWVBFX0VOVU1fX09USEVSEOgH');

@$core.Deprecated('Use eventSubscriptionParamsDescriptor instead')
const EventSubscriptionParams$json = {
  '1': 'EventSubscriptionParams',
  '2': [
    {
      '1': 'proposed_subscription_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'proposedSubscriptionId'
    },
    {'1': 'topics', '3': 2, '4': 3, '5': 9, '10': 'topics'},
    {
      '1': 'subscribed_event_types',
      '3': 3,
      '4': 3,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.EventTypeEnum',
      '10': 'subscribedEventTypes'
    },
    {
      '1': 'aux_data',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.EventSubscriptionParams.AuxDataEntry',
      '10': 'auxData'
    },
  ],
  '3': [EventSubscriptionParams_AuxDataEntry$json],
};

@$core.Deprecated('Use eventSubscriptionParamsDescriptor instead')
const EventSubscriptionParams_AuxDataEntry$json = {
  '1': 'AuxDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `EventSubscriptionParams`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventSubscriptionParamsDescriptor = $convert.base64Decode(
    'ChdFdmVudFN1YnNjcmlwdGlvblBhcmFtcxI4Chhwcm9wb3NlZF9zdWJzY3JpcHRpb25faWQYAS'
    'ABKAlSFnByb3Bvc2VkU3Vic2NyaXB0aW9uSWQSFgoGdG9waWNzGAIgAygJUgZ0b3BpY3MSZAoW'
    'c3Vic2NyaWJlZF9ldmVudF90eXBlcxgDIAMoDjIuLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YW'
    'dlbnQudjEuRXZlbnRUeXBlRW51bVIUc3Vic2NyaWJlZEV2ZW50VHlwZXMSYAoIYXV4X2RhdGEY'
    'aSADKAsyRS5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkV2ZW50U3Vic2NyaXB0aW'
    '9uUGFyYW1zLkF1eERhdGFFbnRyeVIHYXV4RGF0YRo6CgxBdXhEYXRhRW50cnkSEAoDa2V5GAEg'
    'ASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use blobEventDescriptor instead')
const BlobEvent$json = {
  '1': 'BlobEvent',
  '2': [
    {
      '1': 'data',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Blob',
      '10': 'data'
    },
  ],
};

/// Descriptor for `BlobEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blobEventDescriptor = $convert.base64Decode(
    'CglCbG9iRXZlbnQSOQoEZGF0YRgBIAEoCzIlLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbn'
    'QudjEuQmxvYlIEZGF0YQ==');

@$core.Deprecated('Use executionUpdateEventDescriptor instead')
const ExecutionUpdateEvent$json = {
  '1': 'ExecutionUpdateEvent',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {
      '1': 'event_type',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.ExecutionUpdateEventTypeEnum',
      '10': 'eventType'
    },
    {'1': 'flow_instance_id', '3': 3, '4': 1, '5': 9, '10': 'flowInstanceId'},
    {'1': 'flow_execution_id', '3': 4, '4': 1, '5': 9, '10': 'flowExecutionId'},
    {'1': 'total_nr_of_steps', '3': 5, '4': 1, '5': 9, '10': 'totalNrOfSteps'},
    {'1': 'current_step_nr', '3': 6, '4': 1, '5': 9, '10': 'currentStepNr'},
    {'1': 'step_description', '3': 7, '4': 1, '5': 9, '10': 'stepDescription'},
    {
      '1': 'progress_percentage',
      '3': 8,
      '4': 1,
      '5': 9,
      '10': 'progressPercentage'
    },
    {'1': 'msg', '3': 9, '4': 1, '5': 9, '10': 'msg'},
    {
      '1': 'labels',
      '3': 103,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.ExecutionUpdateEvent.LabelsEntry',
      '10': 'labels'
    },
    {'1': 'tags', '3': 104, '4': 3, '5': 9, '10': 'tags'},
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.ExecutionUpdateEvent.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [
    ExecutionUpdateEvent_LabelsEntry$json,
    ExecutionUpdateEvent_MetadataEntry$json
  ],
};

@$core.Deprecated('Use executionUpdateEventDescriptor instead')
const ExecutionUpdateEvent_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use executionUpdateEventDescriptor instead')
const ExecutionUpdateEvent_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ExecutionUpdateEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List executionUpdateEventDescriptor = $convert.base64Decode(
    'ChRFeGVjdXRpb25VcGRhdGVFdmVudBIoChByZWZfZXhlY3V0aW9uX2lkGAEgASgJUg5yZWZFeG'
    'VjdXRpb25JZBJcCgpldmVudF90eXBlGAIgASgOMj0ucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRh'
    'Z2VudC52MS5FeGVjdXRpb25VcGRhdGVFdmVudFR5cGVFbnVtUglldmVudFR5cGUSKAoQZmxvd1'
    '9pbnN0YW5jZV9pZBgDIAEoCVIOZmxvd0luc3RhbmNlSWQSKgoRZmxvd19leGVjdXRpb25faWQY'
    'BCABKAlSD2Zsb3dFeGVjdXRpb25JZBIpChF0b3RhbF9ucl9vZl9zdGVwcxgFIAEoCVIOdG90YW'
    'xOck9mU3RlcHMSJgoPY3VycmVudF9zdGVwX25yGAYgASgJUg1jdXJyZW50U3RlcE5yEikKEHN0'
    'ZXBfZGVzY3JpcHRpb24YByABKAlSD3N0ZXBEZXNjcmlwdGlvbhIvChNwcm9ncmVzc19wZXJjZW'
    '50YWdlGAggASgJUhJwcm9ncmVzc1BlcmNlbnRhZ2USEAoDbXNnGAkgASgJUgNtc2cSWQoGbGFi'
    'ZWxzGGcgAygLMkEucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5FeGVjdXRpb25VcG'
    'RhdGVFdmVudC5MYWJlbHNFbnRyeVIGbGFiZWxzEhIKBHRhZ3MYaCADKAlSBHRhZ3MSXwoIbWV0'
    'YWRhdGEYaSADKAsyQy5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkV4ZWN1dGlvbl'
    'VwZGF0ZUV2ZW50Lk1ldGFkYXRhRW50cnlSCG1ldGFkYXRhGjkKC0xhYmVsc0VudHJ5EhAKA2tl'
    'eRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAEaOwoNTWV0YWRhdGFFbnRyeR'
    'IQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use executionResponseEventDescriptor instead')
const ExecutionResponseEvent$json = {
  '1': 'ExecutionResponseEvent',
  '2': [
    {'1': 'ref_execution_id', '3': 1, '4': 1, '5': 9, '10': 'refExecutionId'},
    {
      '1': 'get_account_list',
      '3': 201,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.GetAccountListResponse',
      '9': 0,
      '10': 'getAccountList'
    },
    {
      '1': 'get_account_info_batch',
      '3': 202,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.GetAccountInfoBatchResponse',
      '9': 0,
      '10': 'getAccountInfoBatch'
    },
    {
      '1': 'get_account_instrument_holdings',
      '3': 203,
      '4': 1,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.GetAccountInstrumentHoldingsResponse',
      '9': 0,
      '10': 'getAccountInstrumentHoldings'
    },
    {
      '1': 'get_account_cash_holdings',
      '3': 204,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.GetAccountCashHoldingsResponse',
      '9': 0,
      '10': 'getAccountCashHoldings'
    },
    {
      '1': 'get_account_orders',
      '3': 205,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.GetAccountOrdersResponse',
      '9': 0,
      '10': 'getAccountOrders'
    },
    {
      '1': 'get_account_trades',
      '3': 206,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.GetAccountTradesResponse',
      '9': 0,
      '10': 'getAccountTrades'
    },
    {
      '1': 'get_account_settlements',
      '3': 207,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.GetAccountSettlementsResponse',
      '9': 0,
      '10': 'getAccountSettlements'
    },
    {
      '1': 'get_account_transactions',
      '3': 208,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.GetAccountTransactionsResponse',
      '9': 0,
      '10': 'getAccountTransactions'
    },
    {
      '1': 'get_instrument_list',
      '3': 301,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.GetInstrumentListResponse',
      '9': 0,
      '10': 'getInstrumentList'
    },
    {
      '1': 'get_instrument_info_batch',
      '3': 302,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.GetInstrumentInfoBatchResponse',
      '9': 0,
      '10': 'getInstrumentInfoBatch'
    },
    {
      '1': 'get_instrument_orders',
      '3': 303,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.GetInstrumentOrdersResponse',
      '9': 0,
      '10': 'getInstrumentOrders'
    },
    {
      '1': 'get_instrument_trades',
      '3': 304,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.GetInstrumentTradesResponse',
      '9': 0,
      '10': 'getInstrumentTrades'
    },
    {
      '1': 'get_instrument_settlements',
      '3': 305,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.GetInstrumentSettlementsResponse',
      '9': 0,
      '10': 'getInstrumentSettlements'
    },
    {
      '1': 'get_market_list',
      '3': 401,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.GetMarketListResponse',
      '9': 0,
      '10': 'getMarketList'
    },
    {
      '1': 'get_market_calendar',
      '3': 402,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.GetMarketCalendarResponse',
      '9': 0,
      '10': 'getMarketCalendar'
    },
    {
      '1': 'get_venue_list',
      '3': 501,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.GetVenueListResponse',
      '9': 0,
      '10': 'getVenueList'
    },
    {
      '1': 'get_venue_calendar',
      '3': 503,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.GetVenueCalendarResponse',
      '9': 0,
      '10': 'getVenueCalendar'
    },
    {
      '1': 'get_order_fees',
      '3': 601,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.GetOrderFeesResponse',
      '9': 0,
      '10': 'getOrderFees'
    },
    {
      '1': 'get_participant_info',
      '3': 701,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.GetParticipantInfoResponse',
      '9': 0,
      '10': 'getParticipantInfo'
    },
    {
      '1': 'get_participant_orders',
      '3': 702,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.GetParticipantOrdersResponse',
      '9': 0,
      '10': 'getParticipantOrders'
    },
    {
      '1': 'get_participant_trades',
      '3': 703,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.GetParticipantTradesResponse',
      '9': 0,
      '10': 'getParticipantTrades'
    },
    {
      '1': 'get_participant_settlements',
      '3': 704,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.GetParticipantSettlementsResponse',
      '9': 0,
      '10': 'getParticipantSettlements'
    },
    {
      '1': 'labels',
      '3': 103,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.ExecutionResponseEvent.LabelsEntry',
      '10': 'labels'
    },
    {'1': 'tags', '3': 104, '4': 3, '5': 9, '10': 'tags'},
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6':
          '.qomet.agora.daemons.prtagent.v1.ExecutionResponseEvent.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [
    ExecutionResponseEvent_LabelsEntry$json,
    ExecutionResponseEvent_MetadataEntry$json
  ],
  '8': [
    {'1': 'response'},
  ],
};

@$core.Deprecated('Use executionResponseEventDescriptor instead')
const ExecutionResponseEvent_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use executionResponseEventDescriptor instead')
const ExecutionResponseEvent_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ExecutionResponseEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List executionResponseEventDescriptor = $convert.base64Decode(
    'ChZFeGVjdXRpb25SZXNwb25zZUV2ZW50EigKEHJlZl9leGVjdXRpb25faWQYASABKAlSDnJlZk'
    'V4ZWN1dGlvbklkEmQKEGdldF9hY2NvdW50X2xpc3QYyQEgASgLMjcucW9tZXQuYWdvcmEuZGFl'
    'bW9ucy5wcnRhZ2VudC52MS5HZXRBY2NvdW50TGlzdFJlc3BvbnNlSABSDmdldEFjY291bnRMaX'
    'N0EnQKFmdldF9hY2NvdW50X2luZm9fYmF0Y2gYygEgASgLMjwucW9tZXQuYWdvcmEuZGFlbW9u'
    'cy5wcnRhZ2VudC52MS5HZXRBY2NvdW50SW5mb0JhdGNoUmVzcG9uc2VIAFITZ2V0QWNjb3VudE'
    'luZm9CYXRjaBKPAQofZ2V0X2FjY291bnRfaW5zdHJ1bWVudF9ob2xkaW5ncxjLASABKAsyRS5x'
    'b21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkdldEFjY291bnRJbnN0cnVtZW50SG9sZG'
    'luZ3NSZXNwb25zZUgAUhxnZXRBY2NvdW50SW5zdHJ1bWVudEhvbGRpbmdzEn0KGWdldF9hY2Nv'
    'dW50X2Nhc2hfaG9sZGluZ3MYzAEgASgLMj8ucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC'
    '52MS5HZXRBY2NvdW50Q2FzaEhvbGRpbmdzUmVzcG9uc2VIAFIWZ2V0QWNjb3VudENhc2hIb2xk'
    'aW5ncxJqChJnZXRfYWNjb3VudF9vcmRlcnMYzQEgASgLMjkucW9tZXQuYWdvcmEuZGFlbW9ucy'
    '5wcnRhZ2VudC52MS5HZXRBY2NvdW50T3JkZXJzUmVzcG9uc2VIAFIQZ2V0QWNjb3VudE9yZGVy'
    'cxJqChJnZXRfYWNjb3VudF90cmFkZXMYzgEgASgLMjkucW9tZXQuYWdvcmEuZGFlbW9ucy5wcn'
    'RhZ2VudC52MS5HZXRBY2NvdW50VHJhZGVzUmVzcG9uc2VIAFIQZ2V0QWNjb3VudFRyYWRlcxJ5'
    'ChdnZXRfYWNjb3VudF9zZXR0bGVtZW50cxjPASABKAsyPi5xb21ldC5hZ29yYS5kYWVtb25zLn'
    'BydGFnZW50LnYxLkdldEFjY291bnRTZXR0bGVtZW50c1Jlc3BvbnNlSABSFWdldEFjY291bnRT'
    'ZXR0bGVtZW50cxJ8ChhnZXRfYWNjb3VudF90cmFuc2FjdGlvbnMY0AEgASgLMj8ucW9tZXQuYW'
    'dvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5HZXRBY2NvdW50VHJhbnNhY3Rpb25zUmVzcG9uc2VI'
    'AFIWZ2V0QWNjb3VudFRyYW5zYWN0aW9ucxJtChNnZXRfaW5zdHJ1bWVudF9saXN0GK0CIAEoCz'
    'I6LnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuR2V0SW5zdHJ1bWVudExpc3RSZXNw'
    'b25zZUgAUhFnZXRJbnN0cnVtZW50TGlzdBJ9ChlnZXRfaW5zdHJ1bWVudF9pbmZvX2JhdGNoGK'
    '4CIAEoCzI/LnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuR2V0SW5zdHJ1bWVudElu'
    'Zm9CYXRjaFJlc3BvbnNlSABSFmdldEluc3RydW1lbnRJbmZvQmF0Y2gScwoVZ2V0X2luc3RydW'
    '1lbnRfb3JkZXJzGK8CIAEoCzI8LnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuR2V0'
    'SW5zdHJ1bWVudE9yZGVyc1Jlc3BvbnNlSABSE2dldEluc3RydW1lbnRPcmRlcnMScwoVZ2V0X2'
    'luc3RydW1lbnRfdHJhZGVzGLACIAEoCzI8LnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQu'
    'djEuR2V0SW5zdHJ1bWVudFRyYWRlc1Jlc3BvbnNlSABSE2dldEluc3RydW1lbnRUcmFkZXMSgg'
    'EKGmdldF9pbnN0cnVtZW50X3NldHRsZW1lbnRzGLECIAEoCzJBLnFvbWV0LmFnb3JhLmRhZW1v'
    'bnMucHJ0YWdlbnQudjEuR2V0SW5zdHJ1bWVudFNldHRsZW1lbnRzUmVzcG9uc2VIAFIYZ2V0SW'
    '5zdHJ1bWVudFNldHRsZW1lbnRzEmEKD2dldF9tYXJrZXRfbGlzdBiRAyABKAsyNi5xb21ldC5h'
    'Z29yYS5kYWVtb25zLnBydGFnZW50LnYxLkdldE1hcmtldExpc3RSZXNwb25zZUgAUg1nZXRNYX'
    'JrZXRMaXN0Em0KE2dldF9tYXJrZXRfY2FsZW5kYXIYkgMgASgLMjoucW9tZXQuYWdvcmEuZGFl'
    'bW9ucy5wcnRhZ2VudC52MS5HZXRNYXJrZXRDYWxlbmRhclJlc3BvbnNlSABSEWdldE1hcmtldE'
    'NhbGVuZGFyEl4KDmdldF92ZW51ZV9saXN0GPUDIAEoCzI1LnFvbWV0LmFnb3JhLmRhZW1vbnMu'
    'cHJ0YWdlbnQudjEuR2V0VmVudWVMaXN0UmVzcG9uc2VIAFIMZ2V0VmVudWVMaXN0EmoKEmdldF'
    '92ZW51ZV9jYWxlbmRhchj3AyABKAsyOS5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYx'
    'LkdldFZlbnVlQ2FsZW5kYXJSZXNwb25zZUgAUhBnZXRWZW51ZUNhbGVuZGFyEl4KDmdldF9vcm'
    'Rlcl9mZWVzGNkEIAEoCzI1LnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuR2V0T3Jk'
    'ZXJGZWVzUmVzcG9uc2VIAFIMZ2V0T3JkZXJGZWVzEnAKFGdldF9wYXJ0aWNpcGFudF9pbmZvGL'
    '0FIAEoCzI7LnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuR2V0UGFydGljaXBhbnRJ'
    'bmZvUmVzcG9uc2VIAFISZ2V0UGFydGljaXBhbnRJbmZvEnYKFmdldF9wYXJ0aWNpcGFudF9vcm'
    'RlcnMYvgUgASgLMj0ucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5HZXRQYXJ0aWNp'
    'cGFudE9yZGVyc1Jlc3BvbnNlSABSFGdldFBhcnRpY2lwYW50T3JkZXJzEnYKFmdldF9wYXJ0aW'
    'NpcGFudF90cmFkZXMYvwUgASgLMj0ucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5H'
    'ZXRQYXJ0aWNpcGFudFRyYWRlc1Jlc3BvbnNlSABSFGdldFBhcnRpY2lwYW50VHJhZGVzEoUBCh'
    'tnZXRfcGFydGljaXBhbnRfc2V0dGxlbWVudHMYwAUgASgLMkIucW9tZXQuYWdvcmEuZGFlbW9u'
    'cy5wcnRhZ2VudC52MS5HZXRQYXJ0aWNpcGFudFNldHRsZW1lbnRzUmVzcG9uc2VIAFIZZ2V0UG'
    'FydGljaXBhbnRTZXR0bGVtZW50cxJbCgZsYWJlbHMYZyADKAsyQy5xb21ldC5hZ29yYS5kYWVt'
    'b25zLnBydGFnZW50LnYxLkV4ZWN1dGlvblJlc3BvbnNlRXZlbnQuTGFiZWxzRW50cnlSBmxhYm'
    'VscxISCgR0YWdzGGggAygJUgR0YWdzEmEKCG1ldGFkYXRhGGkgAygLMkUucW9tZXQuYWdvcmEu'
    'ZGFlbW9ucy5wcnRhZ2VudC52MS5FeGVjdXRpb25SZXNwb25zZUV2ZW50Lk1ldGFkYXRhRW50cn'
    'lSCG1ldGFkYXRhGjkKC0xhYmVsc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIg'
    'ASgJUgV2YWx1ZToCOAEaOwoNTWV0YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YW'
    'x1ZRgCIAEoCVIFdmFsdWU6AjgBQgoKCHJlc3BvbnNl');

@$core.Deprecated('Use eventDescriptor instead')
const Event$json = {
  '1': 'Event',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'hash', '3': 2, '4': 1, '5': 9, '10': 'hash'},
    {
      '1': 'ref_subscription_id',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'refSubscriptionId'
    },
    {'1': 'topic', '3': 4, '4': 1, '5': 9, '10': 'topic'},
    {
      '1': 'generated_at_dt',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.DateTime',
      '10': 'generatedAtDt'
    },
    {
      '1': 'type',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.EventTypeEnum',
      '10': 'type'
    },
    {
      '1': 'blob',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.BlobEvent',
      '9': 0,
      '10': 'blob'
    },
    {
      '1': 'execution_update',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.ExecutionUpdateEvent',
      '9': 0,
      '10': 'executionUpdate'
    },
    {
      '1': 'execution_response',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.ExecutionResponseEvent',
      '9': 0,
      '10': 'executionResponse'
    },
    {
      '1': 'display_names',
      '3': 101,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Event.DisplayNamesEntry',
      '10': 'displayNames'
    },
    {
      '1': 'descriptions',
      '3': 102,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Event.DescriptionsEntry',
      '10': 'descriptions'
    },
    {
      '1': 'labels',
      '3': 103,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Event.LabelsEntry',
      '10': 'labels'
    },
    {'1': 'tags', '3': 104, '4': 3, '5': 9, '10': 'tags'},
    {
      '1': 'metadata',
      '3': 105,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Event.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [
    Event_DisplayNamesEntry$json,
    Event_DescriptionsEntry$json,
    Event_LabelsEntry$json,
    Event_MetadataEntry$json
  ],
  '8': [
    {'1': 'carrying_object'},
  ],
};

@$core.Deprecated('Use eventDescriptor instead')
const Event_DisplayNamesEntry$json = {
  '1': 'DisplayNamesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use eventDescriptor instead')
const Event_DescriptionsEntry$json = {
  '1': 'DescriptionsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use eventDescriptor instead')
const Event_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use eventDescriptor instead')
const Event_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Event`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventDescriptor = $convert.base64Decode(
    'CgVFdmVudBIOCgJpZBgBIAEoCVICaWQSEgoEaGFzaBgCIAEoCVIEaGFzaBIuChNyZWZfc3Vic2'
    'NyaXB0aW9uX2lkGAMgASgJUhFyZWZTdWJzY3JpcHRpb25JZBIUCgV0b3BpYxgEIAEoCVIFdG9w'
    'aWMSUQoPZ2VuZXJhdGVkX2F0X2R0GAUgASgLMikucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2'
    'VudC52MS5EYXRlVGltZVINZ2VuZXJhdGVkQXREdBJCCgR0eXBlGAYgASgOMi4ucW9tZXQuYWdv'
    'cmEuZGFlbW9ucy5wcnRhZ2VudC52MS5FdmVudFR5cGVFbnVtUgR0eXBlEkAKBGJsb2IYByABKA'
    'syKi5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkJsb2JFdmVudEgAUgRibG9iEmIK'
    'EGV4ZWN1dGlvbl91cGRhdGUYCCABKAsyNS5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50Ln'
    'YxLkV4ZWN1dGlvblVwZGF0ZUV2ZW50SABSD2V4ZWN1dGlvblVwZGF0ZRJoChJleGVjdXRpb25f'
    'cmVzcG9uc2UYCSABKAsyNy5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkV4ZWN1dG'
    'lvblJlc3BvbnNlRXZlbnRIAFIRZXhlY3V0aW9uUmVzcG9uc2USXQoNZGlzcGxheV9uYW1lcxhl'
    'IAMoCzI4LnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuRXZlbnQuRGlzcGxheU5hbW'
    'VzRW50cnlSDGRpc3BsYXlOYW1lcxJcCgxkZXNjcmlwdGlvbnMYZiADKAsyOC5xb21ldC5hZ29y'
    'YS5kYWVtb25zLnBydGFnZW50LnYxLkV2ZW50LkRlc2NyaXB0aW9uc0VudHJ5UgxkZXNjcmlwdG'
    'lvbnMSSgoGbGFiZWxzGGcgAygLMjIucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5F'
    'dmVudC5MYWJlbHNFbnRyeVIGbGFiZWxzEhIKBHRhZ3MYaCADKAlSBHRhZ3MSUAoIbWV0YWRhdG'
    'EYaSADKAsyNC5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkV2ZW50Lk1ldGFkYXRh'
    'RW50cnlSCG1ldGFkYXRhGj8KEURpc3BsYXlOYW1lc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5Eh'
    'QKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAEaPwoRRGVzY3JpcHRpb25zRW50cnkSEAoDa2V5GAEg'
    'ASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4ARo5CgtMYWJlbHNFbnRyeRIQCgNrZX'
    'kYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBGjsKDU1ldGFkYXRhRW50cnkS'
    'EAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AUIRCg9jYXJyeWluZ1'
    '9vYmplY3Q=');
