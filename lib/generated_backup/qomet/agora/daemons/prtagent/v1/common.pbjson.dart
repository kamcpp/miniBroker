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

@$core.Deprecated('Use eventTypeDescriptor instead')
const EventType$json = {
  '1': 'EventType',
  '2': [
    {'1': 'EVENT_TYPE__UNKNOWN', '2': 0},
    {'1': 'EVENT_TYPE__NEWS', '2': 1},
    {'1': 'EVENT_TYPE__ANNOUNCEMENT', '2': 2},
    {'1': 'EVENT_TYPE__MARKET_UPDATE', '2': 3},
    {'1': 'EVENT_TYPE__TRADE_EXECUTION', '2': 4},
    {'1': 'EVENT_TYPE__ORDER_PLACED', '2': 5},
    {'1': 'EVENT_TYPE__ORDER_CANCELLED', '2': 6},
    {'1': 'EVENT_TYPE__ORDER_FILLED', '2': 7},
    {'1': 'EVENT_TYPE__ORDER_EXPIRED', '2': 8},
    {'1': 'EVENT_TYPE__PRICE_UPDATE', '2': 9},
    {'1': 'EVENT_TYPE__REGULATORY', '2': 10},
    {'1': 'EVENT_TYPE__SYSTEM', '2': 11},
  ],
};

/// Descriptor for `EventType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List eventTypeDescriptor = $convert.base64Decode(
    'CglFdmVudFR5cGUSFwoTRVZFTlRfVFlQRV9fVU5LTk9XThAAEhQKEEVWRU5UX1RZUEVfX05FV1'
    'MQARIcChhFVkVOVF9UWVBFX19BTk5PVU5DRU1FTlQQAhIdChlFVkVOVF9UWVBFX19NQVJLRVRf'
    'VVBEQVRFEAMSHwobRVZFTlRfVFlQRV9fVFJBREVfRVhFQ1VUSU9OEAQSHAoYRVZFTlRfVFlQRV'
    '9fT1JERVJfUExBQ0VEEAUSHwobRVZFTlRfVFlQRV9fT1JERVJfQ0FOQ0VMTEVEEAYSHAoYRVZF'
    'TlRfVFlQRV9fT1JERVJfRklMTEVEEAcSHQoZRVZFTlRfVFlQRV9fT1JERVJfRVhQSVJFRBAIEh'
    'wKGEVWRU5UX1RZUEVfX1BSSUNFX1VQREFURRAJEhoKFkVWRU5UX1RZUEVfX1JFR1VMQVRPUlkQ'
    'ChIWChJFVkVOVF9UWVBFX19TWVNURU0QCw==');

@$core.Deprecated('Use assetTypeDescriptor instead')
const AssetType$json = {
  '1': 'AssetType',
  '2': [
    {'1': 'ASSET_TYPE__UNKNOWN', '2': 0},
    {'1': 'ASSET_TYPE__CASH', '2': 1},
    {'1': 'ASSET_TYPE__ON_CHAIN', '2': 2},
    {'1': 'ASSET_TYPE__RWA', '2': 3},
    {'1': 'ASSET_TYPE__COMMODITY', '2': 4},
    {'1': 'ASSET_TYPE__EQUITY', '2': 5},
    {'1': 'ASSET_TYPE__FIXED_INCOME', '2': 6},
    {'1': 'ASSET_TYPE__DERIVATIVE', '2': 7},
    {'1': 'ASSET_TYPE__CRYPTO', '2': 8},
    {'1': 'ASSET_TYPE__STABLECOIN', '2': 9},
    {'1': 'ASSET_TYPE__NFT', '2': 10},
  ],
};

/// Descriptor for `AssetType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List assetTypeDescriptor = $convert.base64Decode(
    'CglBc3NldFR5cGUSFwoTQVNTRVRfVFlQRV9fVU5LTk9XThAAEhQKEEFTU0VUX1RZUEVfX0NBU0'
    'gQARIYChRBU1NFVF9UWVBFX19PTl9DSEFJThACEhMKD0FTU0VUX1RZUEVfX1JXQRADEhkKFUFT'
    'U0VUX1RZUEVfX0NPTU1PRElUWRAEEhYKEkFTU0VUX1RZUEVfX0VRVUlUWRAFEhwKGEFTU0VUX1'
    'RZUEVfX0ZJWEVEX0lOQ09NRRAGEhoKFkFTU0VUX1RZUEVfX0RFUklWQVRJVkUQBxIWChJBU1NF'
    'VF9UWVBFX19DUllQVE8QCBIaChZBU1NFVF9UWVBFX19TVEFCTEVDT0lOEAkSEwoPQVNTRVRfVF'
    'lQRV9fTkZUEAo=');

@$core.Deprecated('Use instrumentTypeDescriptor instead')
const InstrumentType$json = {
  '1': 'InstrumentType',
  '2': [
    {'1': 'INSTRUMENT_TYPE__UNKNOWN', '2': 0},
    {'1': 'INSTRUMENT_TYPE__SPOT', '2': 1},
    {'1': 'INSTRUMENT_TYPE__FUTURE', '2': 2},
    {'1': 'INSTRUMENT_TYPE__OPTION', '2': 3},
    {'1': 'INSTRUMENT_TYPE__SWAP', '2': 4},
    {'1': 'INSTRUMENT_TYPE__FORWARD', '2': 5},
    {'1': 'INSTRUMENT_TYPE__BOND', '2': 6},
    {'1': 'INSTRUMENT_TYPE__INDEX', '2': 7},
    {'1': 'INSTRUMENT_TYPE__ETF', '2': 8},
    {'1': 'INSTRUMENT_TYPE__PERPETUAL', '2': 9},
    {'1': 'INSTRUMENT_TYPE__CFD', '2': 10},
  ],
};

/// Descriptor for `InstrumentType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List instrumentTypeDescriptor = $convert.base64Decode(
    'Cg5JbnN0cnVtZW50VHlwZRIcChhJTlNUUlVNRU5UX1RZUEVfX1VOS05PV04QABIZChVJTlNUUl'
    'VNRU5UX1RZUEVfX1NQT1QQARIbChdJTlNUUlVNRU5UX1RZUEVfX0ZVVFVSRRACEhsKF0lOU1RS'
    'VU1FTlRfVFlQRV9fT1BUSU9OEAMSGQoVSU5TVFJVTUVOVF9UWVBFX19TV0FQEAQSHAoYSU5TVF'
    'JVTUVOVF9UWVBFX19GT1JXQVJEEAUSGQoVSU5TVFJVTUVOVF9UWVBFX19CT05EEAYSGgoWSU5T'
    'VFJVTUVOVF9UWVBFX19JTkRFWBAHEhgKFElOU1RSVU1FTlRfVFlQRV9fRVRGEAgSHgoaSU5TVF'
    'JVTUVOVF9UWVBFX19QRVJQRVRVQUwQCRIYChRJTlNUUlVNRU5UX1RZUEVfX0NGRBAK');

@$core.Deprecated('Use instrumentListingStatusTypeDescriptor instead')
const InstrumentListingStatusType$json = {
  '1': 'InstrumentListingStatusType',
  '2': [
    {'1': 'INSTRUMENT_LISTING_STATUS_TYPE__UNKNOWN', '2': 0},
    {'1': 'INSTRUMENT_LISTING_STATUS_TYPE__LISTED', '2': 1},
    {'1': 'INSTRUMENT_LISTING_STATUS_TYPE__SUSPENDED', '2': 2},
    {'1': 'INSTRUMENT_LISTING_STATUS_TYPE__DELISTED', '2': 3},
    {'1': 'INSTRUMENT_LISTING_STATUS_TYPE__PENDING', '2': 4},
    {'1': 'INSTRUMENT_LISTING_STATUS_TYPE__HALTED', '2': 5},
    {'1': 'INSTRUMENT_LISTING_STATUS_TYPE__CLOSED', '2': 6},
    {'1': 'INSTRUMENT_LISTING_STATUS_TYPE__PRE_LISTING', '2': 7},
  ],
};

/// Descriptor for `InstrumentListingStatusType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List instrumentListingStatusTypeDescriptor = $convert.base64Decode(
    'ChtJbnN0cnVtZW50TGlzdGluZ1N0YXR1c1R5cGUSKwonSU5TVFJVTUVOVF9MSVNUSU5HX1NUQV'
    'RVU19UWVBFX19VTktOT1dOEAASKgomSU5TVFJVTUVOVF9MSVNUSU5HX1NUQVRVU19UWVBFX19M'
    'SVNURUQQARItCilJTlNUUlVNRU5UX0xJU1RJTkdfU1RBVFVTX1RZUEVfX1NVU1BFTkRFRBACEi'
    'wKKElOU1RSVU1FTlRfTElTVElOR19TVEFUVVNfVFlQRV9fREVMSVNURUQQAxIrCidJTlNUUlVN'
    'RU5UX0xJU1RJTkdfU1RBVFVTX1RZUEVfX1BFTkRJTkcQBBIqCiZJTlNUUlVNRU5UX0xJU1RJTk'
    'dfU1RBVFVTX1RZUEVfX0hBTFRFRBAFEioKJklOU1RSVU1FTlRfTElTVElOR19TVEFUVVNfVFlQ'
    'RV9fQ0xPU0VEEAYSLworSU5TVFJVTUVOVF9MSVNUSU5HX1NUQVRVU19UWVBFX19QUkVfTElTVE'
    'lORxAH');

@$core.Deprecated('Use confirmationStatusDescriptor instead')
const ConfirmationStatus$json = {
  '1': 'ConfirmationStatus',
  '2': [
    {'1': 'CONFIRMATION_STATUS__UNKNOWN', '2': 0},
    {'1': 'CONFIRMATION_STATUS__CONFIRMED', '2': 1},
    {'1': 'CONFIRMATION_STATUS__PENDING', '2': 2},
    {'1': 'CONFIRMATION_STATUS__DECLINED', '2': 3},
  ],
};

/// Descriptor for `ConfirmationStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List confirmationStatusDescriptor = $convert.base64Decode(
    'ChJDb25maXJtYXRpb25TdGF0dXMSIAocQ09ORklSTUFUSU9OX1NUQVRVU19fVU5LTk9XThAAEi'
    'IKHkNPTkZJUk1BVElPTl9TVEFUVVNfX0NPTkZJUk1FRBABEiAKHENPTkZJUk1BVElPTl9TVEFU'
    'VVNfX1BFTkRJTkcQAhIhCh1DT05GSVJNQVRJT05fU1RBVFVTX19ERUNMSU5FRBAD');

@$core.Deprecated('Use orderSideDescriptor instead')
const OrderSide$json = {
  '1': 'OrderSide',
  '2': [
    {'1': 'ORDER_SIDE__UNKNOWN', '2': 0},
    {'1': 'ORDER_SIDE__BUY', '2': 1},
    {'1': 'ORDER_SIDE__BID', '2': 1},
    {'1': 'ORDER_SIDE__CALL', '2': 1},
    {'1': 'ORDER_SIDE__SELL', '2': 2},
    {'1': 'ORDER_SIDE__ASK', '2': 2},
    {'1': 'ORDER_SIDE__PUT', '2': 2},
    {'1': 'ORDER_SIDE__BOTH', '2': 3},
    {'1': 'ORDER_SIDE__NO_SIDE', '2': 4},
  ],
  '3': {'2': true},
};

/// Descriptor for `OrderSide`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List orderSideDescriptor = $convert.base64Decode(
    'CglPcmRlclNpZGUSFwoTT1JERVJfU0lERV9fVU5LTk9XThAAEhMKD09SREVSX1NJREVfX0JVWR'
    'ABEhMKD09SREVSX1NJREVfX0JJRBABEhQKEE9SREVSX1NJREVfX0NBTEwQARIUChBPUkRFUl9T'
    'SURFX19TRUxMEAISEwoPT1JERVJfU0lERV9fQVNLEAISEwoPT1JERVJfU0lERV9fUFVUEAISFA'
    'oQT1JERVJfU0lERV9fQk9USBADEhcKE09SREVSX1NJREVfX05PX1NJREUQBBoCEAE=');

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
    {
      '1': 'ts',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '9': 0,
      '10': 'ts'
    },
  ],
  '8': [
    {'1': 'value'},
  ],
};

/// Descriptor for `Time`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timeDescriptor = $convert.base64Decode(
    'CgRUaW1lEjwKA2htcxgBIAEoCzIoLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuVG'
    'ltZUhNU0gAUgNobXMSLAoCdHMYAiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wSABS'
    'AnRzQgcKBXZhbHVl');

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
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'metadata', '3': 4, '4': 1, '5': 9, '10': 'metadata'},
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
  ],
  '8': [
    {'1': 'start'},
    {'1': 'end'},
  ],
};

/// Descriptor for `Duration`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List durationDescriptor = $convert.base64Decode(
    'CghEdXJhdGlvbhIgCgtpZGVudGlmaWVycxgBIAMoCVILaWRlbnRpZmllcnMSFAoFbmFtZXMYAi'
    'ADKAlSBW5hbWVzEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIaCghtZXRhZGF0'
    'YRgEIAEoCVIIbWV0YWRhdGESRgoKc3RhcnRfdGltZRgFIAEoCzIlLnFvbWV0LmFnb3JhLmRhZW'
    '1vbnMucHJ0YWdlbnQudjEuVGltZUgAUglzdGFydFRpbWUSRgoKc3RhcnRfZGF0ZRgGIAEoCzIl'
    'LnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuRGF0ZUgAUglzdGFydERhdGUSRgoIc3'
    'RhcnRfZHQYByABKAsyKS5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkRhdGVUaW1l'
    'SABSB3N0YXJ0RHQSQgoIZW5kX3RpbWUYCCABKAsyJS5xb21ldC5hZ29yYS5kYWVtb25zLnBydG'
    'FnZW50LnYxLlRpbWVIAVIHZW5kVGltZRJCCghlbmRfZGF0ZRgJIAEoCzIlLnFvbWV0LmFnb3Jh'
    'LmRhZW1vbnMucHJ0YWdlbnQudjEuRGF0ZUgBUgdlbmREYXRlEkIKBmVuZF9kdBgKIAEoCzIpLn'
    'FvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuRGF0ZVRpbWVIAVIFZW5kRHRCBwoFc3Rh'
    'cnRCBQoDZW5k');

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

@$core.Deprecated('Use zonedIdentifierDescriptor instead')
const ZonedIdentifier$json = {
  '1': 'ZonedIdentifier',
  '2': [
    {'1': 'zone', '3': 1, '4': 1, '5': 9, '10': 'zone'},
    {
      '1': 'standard_or_format',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'standardOrFormat'
    },
    {'1': 'identifiers', '3': 3, '4': 3, '5': 9, '10': 'identifiers'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'metadata', '3': 5, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `ZonedIdentifier`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List zonedIdentifierDescriptor = $convert.base64Decode(
    'Cg9ab25lZElkZW50aWZpZXISEgoEem9uZRgBIAEoCVIEem9uZRIsChJzdGFuZGFyZF9vcl9mb3'
    'JtYXQYAiABKAlSEHN0YW5kYXJkT3JGb3JtYXQSIAoLaWRlbnRpZmllcnMYAyADKAlSC2lkZW50'
    'aWZpZXJzEiAKC2Rlc2NyaXB0aW9uGAQgASgJUgtkZXNjcmlwdGlvbhIaCghtZXRhZGF0YRgFIA'
    'EoCVIIbWV0YWRhdGE=');

@$core.Deprecated('Use stringValueDescriptor instead')
const StringValue$json = {
  '1': 'StringValue',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 9, '10': 'value'},
    {'1': 'case_insensitive', '3': 2, '4': 1, '5': 8, '10': 'caseInsensitive'},
  ],
};

/// Descriptor for `StringValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stringValueDescriptor = $convert.base64Decode(
    'CgtTdHJpbmdWYWx1ZRIUCgV2YWx1ZRgBIAEoCVIFdmFsdWUSKQoQY2FzZV9pbnNlbnNpdGl2ZR'
    'gCIAEoCFIPY2FzZUluc2Vuc2l0aXZl');

@$core.Deprecated('Use eventSubscriptionParamsDescriptor instead')
const EventSubscriptionParams$json = {
  '1': 'EventSubscriptionParams',
  '2': [
    {
      '1': 'ref_subscription_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'refSubscriptionId'
    },
    {'1': 'topics', '3': 2, '4': 3, '5': 9, '10': 'topics'},
    {'1': 'type_regex', '3': 3, '4': 1, '5': 9, '10': 'typeRegex'},
  ],
};

/// Descriptor for `EventSubscriptionParams`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventSubscriptionParamsDescriptor = $convert.base64Decode(
    'ChdFdmVudFN1YnNjcmlwdGlvblBhcmFtcxIuChNyZWZfc3Vic2NyaXB0aW9uX2lkGAEgASgJUh'
    'FyZWZTdWJzY3JpcHRpb25JZBIWCgZ0b3BpY3MYAiADKAlSBnRvcGljcxIdCgp0eXBlX3JlZ2V4'
    'GAMgASgJUgl0eXBlUmVnZXg=');

@$core.Deprecated('Use eventDescriptor instead')
const Event$json = {
  '1': 'Event',
  '2': [
    {
      '1': 'ref_subscription_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'refSubscriptionId'
    },
    {'1': 'topic', '3': 2, '4': 1, '5': 9, '10': 'topic'},
    {'1': 'type', '3': 3, '4': 1, '5': 9, '10': 'type'},
    {'1': 'data', '3': 4, '4': 1, '5': 9, '10': 'data'},
  ],
};

/// Descriptor for `Event`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventDescriptor = $convert.base64Decode(
    'CgVFdmVudBIuChNyZWZfc3Vic2NyaXB0aW9uX2lkGAEgASgJUhFyZWZTdWJzY3JpcHRpb25JZB'
    'IUCgV0b3BpYxgCIAEoCVIFdG9waWMSEgoEdHlwZRgDIAEoCVIEdHlwZRISCgRkYXRhGAQgASgJ'
    'UgRkYXRh');

@$core.Deprecated('Use zonedSymbolDescriptor instead')
const ZonedSymbol$json = {
  '1': 'ZonedSymbol',
  '2': [
    {'1': 'zone', '3': 1, '4': 1, '5': 9, '10': 'zone'},
    {
      '1': 'standard_or_format',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'standardOrFormat'
    },
    {
      '1': 'symbols',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.StringValue',
      '10': 'symbols'
    },
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'metadata', '3': 5, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `ZonedSymbol`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List zonedSymbolDescriptor = $convert.base64Decode(
    'Cgtab25lZFN5bWJvbBISCgR6b25lGAEgASgJUgR6b25lEiwKEnN0YW5kYXJkX29yX2Zvcm1hdB'
    'gCIAEoCVIQc3RhbmRhcmRPckZvcm1hdBJGCgdzeW1ib2xzGAMgAygLMiwucW9tZXQuYWdvcmEu'
    'ZGFlbW9ucy5wcnRhZ2VudC52MS5TdHJpbmdWYWx1ZVIHc3ltYm9scxIgCgtkZXNjcmlwdGlvbh'
    'gEIAEoCVILZGVzY3JpcHRpb24SGgoIbWV0YWRhdGEYBSABKAlSCG1ldGFkYXRh');

@$core.Deprecated('Use zonedAssetTypeDescriptor instead')
const ZonedAssetType$json = {
  '1': 'ZonedAssetType',
  '2': [
    {'1': 'zone', '3': 1, '4': 1, '5': 9, '10': 'zone'},
    {
      '1': 'types',
      '3': 2,
      '4': 3,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.AssetType',
      '10': 'types'
    },
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'metadata', '3': 4, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `ZonedAssetType`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List zonedAssetTypeDescriptor = $convert.base64Decode(
    'Cg5ab25lZEFzc2V0VHlwZRISCgR6b25lGAEgASgJUgR6b25lEkAKBXR5cGVzGAIgAygOMioucW'
    '9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5Bc3NldFR5cGVSBXR5cGVzEiAKC2Rlc2Ny'
    'aXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIaCghtZXRhZGF0YRgEIAEoCVIIbWV0YWRhdGE=');

@$core.Deprecated('Use assetDescriptor instead')
const Asset$json = {
  '1': 'Asset',
  '2': [
    {
      '1': 'zoned_identifiers',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.ZonedIdentifier',
      '10': 'zonedIdentifiers'
    },
    {
      '1': 'zoned_symbols',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.ZonedSymbol',
      '10': 'zonedSymbols'
    },
    {
      '1': 'zoned_asset_types',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.ZonedAssetType',
      '10': 'zonedAssetTypes'
    },
    {'1': 'decimals', '3': 4, '4': 1, '5': 5, '10': 'decimals'},
    {'1': 'disabled', '3': 5, '4': 1, '5': 8, '10': 'disabled'},
    {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    {'1': 'metadata', '3': 7, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `Asset`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List assetDescriptor = $convert.base64Decode(
    'CgVBc3NldBJdChF6b25lZF9pZGVudGlmaWVycxgBIAMoCzIwLnFvbWV0LmFnb3JhLmRhZW1vbn'
    'MucHJ0YWdlbnQudjEuWm9uZWRJZGVudGlmaWVyUhB6b25lZElkZW50aWZpZXJzElEKDXpvbmVk'
    'X3N5bWJvbHMYAiADKAsyLC5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLlpvbmVkU3'
    'ltYm9sUgx6b25lZFN5bWJvbHMSWwoRem9uZWRfYXNzZXRfdHlwZXMYAyADKAsyLy5xb21ldC5h'
    'Z29yYS5kYWVtb25zLnBydGFnZW50LnYxLlpvbmVkQXNzZXRUeXBlUg96b25lZEFzc2V0VHlwZX'
    'MSGgoIZGVjaW1hbHMYBCABKAVSCGRlY2ltYWxzEhoKCGRpc2FibGVkGAUgASgIUghkaXNhYmxl'
    'ZBIgCgtkZXNjcmlwdGlvbhgGIAEoCVILZGVzY3JpcHRpb24SGgoIbWV0YWRhdGEYByABKAlSCG'
    '1ldGFkYXRh');

@$core.Deprecated('Use marketDescriptor instead')
const Market$json = {
  '1': 'Market',
  '2': [
    {'1': 'identifiers', '3': 1, '4': 3, '5': 9, '10': 'identifiers'},
    {'1': 'names', '3': 2, '4': 3, '5': 9, '10': 'names'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'metadata', '3': 4, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `Market`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List marketDescriptor = $convert.base64Decode(
    'CgZNYXJrZXQSIAoLaWRlbnRpZmllcnMYASADKAlSC2lkZW50aWZpZXJzEhQKBW5hbWVzGAIgAy'
    'gJUgVuYW1lcxIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SGgoIbWV0YWRhdGEY'
    'BCABKAlSCG1ldGFkYXRh');

@$core.Deprecated('Use zonedInstrumentTypeDescriptor instead')
const ZonedInstrumentType$json = {
  '1': 'ZonedInstrumentType',
  '2': [
    {'1': 'zone', '3': 1, '4': 1, '5': 9, '10': 'zone'},
    {
      '1': 'types',
      '3': 2,
      '4': 3,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.InstrumentType',
      '10': 'types'
    },
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'metadata', '3': 4, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `ZonedInstrumentType`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List zonedInstrumentTypeDescriptor = $convert.base64Decode(
    'ChNab25lZEluc3RydW1lbnRUeXBlEhIKBHpvbmUYASABKAlSBHpvbmUSRQoFdHlwZXMYAiADKA'
    '4yLy5xb21ldC5hZ29yYS5kYWVtb25zLnBydGFnZW50LnYxLkluc3RydW1lbnRUeXBlUgV0eXBl'
    'cxIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SGgoIbWV0YWRhdGEYBCABKAlSCG'
    '1ldGFkYXRh');

@$core.Deprecated('Use instrumentDescriptor instead')
const Instrument$json = {
  '1': 'Instrument',
  '2': [
    {
      '1': 'zoned_identifiers',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.ZonedIdentifier',
      '10': 'zonedIdentifiers'
    },
    {
      '1': 'zoned_symbols',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.ZonedSymbol',
      '10': 'zonedSymbols'
    },
    {
      '1': 'zoned_instrument_types',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.ZonedInstrumentType',
      '10': 'zonedInstrumentTypes'
    },
    {
      '1': 'market',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Market',
      '10': 'market'
    },
    {
      '1': 'the_asset',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Asset',
      '10': 'theAsset'
    },
    {
      '1': 'currency',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Asset',
      '10': 'currency'
    },
    {
      '1': 'listing_status_type',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.InstrumentListingStatusType',
      '10': 'listingStatusType'
    },
    {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    {'1': 'metadata', '3': 9, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `Instrument`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List instrumentDescriptor = $convert.base64Decode(
    'CgpJbnN0cnVtZW50El0KEXpvbmVkX2lkZW50aWZpZXJzGAEgAygLMjAucW9tZXQuYWdvcmEuZG'
    'FlbW9ucy5wcnRhZ2VudC52MS5ab25lZElkZW50aWZpZXJSEHpvbmVkSWRlbnRpZmllcnMSUQoN'
    'em9uZWRfc3ltYm9scxgCIAMoCzIsLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuWm'
    '9uZWRTeW1ib2xSDHpvbmVkU3ltYm9scxJqChZ6b25lZF9pbnN0cnVtZW50X3R5cGVzGAMgAygL'
    'MjQucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5ab25lZEluc3RydW1lbnRUeXBlUh'
    'R6b25lZEluc3RydW1lbnRUeXBlcxI/CgZtYXJrZXQYBCABKAsyJy5xb21ldC5hZ29yYS5kYWVt'
    'b25zLnBydGFnZW50LnYxLk1hcmtldFIGbWFya2V0EkMKCXRoZV9hc3NldBgFIAEoCzImLnFvbW'
    'V0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuQXNzZXRSCHRoZUFzc2V0EkIKCGN1cnJlbmN5'
    'GAYgASgLMiYucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5Bc3NldFIIY3VycmVuY3'
    'kSbAoTbGlzdGluZ19zdGF0dXNfdHlwZRgHIAEoDjI8LnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0'
    'YWdlbnQudjEuSW5zdHJ1bWVudExpc3RpbmdTdGF0dXNUeXBlUhFsaXN0aW5nU3RhdHVzVHlwZR'
    'IgCgtkZXNjcmlwdGlvbhgIIAEoCVILZGVzY3JpcHRpb24SGgoIbWV0YWRhdGEYCSABKAlSCG1l'
    'dGFkYXRh');

@$core.Deprecated('Use orderDescriptor instead')
const Order$json = {
  '1': 'Order',
  '2': [
    {'1': 'order_id', '3': 1, '4': 1, '5': 9, '10': 'orderId'},
    {'1': 'order_hash', '3': 2, '4': 1, '5': 9, '10': 'orderHash'},
    {'1': 'participant_id', '3': 3, '4': 1, '5': 9, '10': 'participantId'},
    {
      '1': 'participant_order_id',
      '3': 4,
      '4': 1,
      '5': 9,
      '10': 'participantOrderId'
    },
    {
      '1': 'participant_account_id',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'participantAccountId'
    },
    {
      '1': 'investor_account_id',
      '3': 6,
      '4': 1,
      '5': 9,
      '10': 'investorAccountId'
    },
    {
      '1': 'executor_account_id',
      '3': 7,
      '4': 1,
      '5': 9,
      '10': 'executorAccountId'
    },
    {'1': 'order_type', '3': 8, '4': 1, '5': 9, '10': 'orderType'},
    {
      '1': 'side',
      '3': 9,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.OrderSide',
      '10': 'side'
    },
    {'1': 'symbol', '3': 10, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'currency', '3': 11, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'quantity', '3': 12, '4': 1, '5': 9, '10': 'quantity'},
    {
      '1': 'remaining_quantity',
      '3': 13,
      '4': 1,
      '5': 9,
      '10': 'remainingQuantity'
    },
    {'1': 'price', '3': 14, '4': 1, '5': 9, '10': 'price'},
    {'1': 'volume', '3': 15, '4': 1, '5': 9, '10': 'volume'},
    {'1': 'remaining_volume', '3': 16, '4': 1, '5': 9, '10': 'remainingVolume'},
    {'1': 'slippage', '3': 17, '4': 1, '5': 9, '10': 'slippage'},
    {'1': 'time_in_force', '3': 18, '4': 1, '5': 9, '10': 'timeInForce'},
    {'1': 'create_timestamp', '3': 19, '4': 1, '5': 9, '10': 'createTimestamp'},
    {
      '1': 'effective_timestamp',
      '3': 20,
      '4': 1,
      '5': 9,
      '10': 'effectiveTimestamp'
    },
    {'1': 'expire_timestamp', '3': 21, '4': 1, '5': 9, '10': 'expireTimestamp'},
    {'1': 'is_offer', '3': 22, '4': 1, '5': 8, '10': 'isOffer'},
    {
      '1': 'is_directly_fillable',
      '3': 23,
      '4': 1,
      '5': 8,
      '10': 'isDirectlyFillable'
    },
    {'1': 'is_bid', '3': 24, '4': 1, '5': 8, '10': 'isBid'},
    {'1': 'is_filled', '3': 25, '4': 1, '5': 8, '10': 'isFilled'},
    {'1': 'is_cancelled', '3': 26, '4': 1, '5': 8, '10': 'isCancelled'},
    {'1': 'is_expired', '3': 27, '4': 1, '5': 8, '10': 'isExpired'},
    {'1': 'creator_address', '3': 28, '4': 1, '5': 9, '10': 'creatorAddress'},
    {'1': 'trezor_stash_id', '3': 29, '4': 1, '5': 9, '10': 'trezorStashId'},
    {'1': 'offer_ids', '3': 30, '4': 1, '5': 9, '10': 'offerIds'},
    {
      '1': 'parent_direct_order_id',
      '3': 31,
      '4': 1,
      '5': 9,
      '10': 'parentDirectOrderId'
    },
    {'1': 'alarm_abi', '3': 32, '4': 1, '5': 9, '10': 'alarmAbi'},
    {'1': 'alarm_data', '3': 33, '4': 1, '5': 9, '10': 'alarmData'},
    {'1': 'data', '3': 34, '4': 1, '5': 9, '10': 'data'},
    {'1': 'data_encoding', '3': 35, '4': 1, '5': 9, '10': 'dataEncoding'},
    {'1': 'participant_data', '3': 36, '4': 1, '5': 9, '10': 'participantData'},
  ],
};

/// Descriptor for `Order`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List orderDescriptor = $convert.base64Decode(
    'CgVPcmRlchIZCghvcmRlcl9pZBgBIAEoCVIHb3JkZXJJZBIdCgpvcmRlcl9oYXNoGAIgASgJUg'
    'lvcmRlckhhc2gSJQoOcGFydGljaXBhbnRfaWQYAyABKAlSDXBhcnRpY2lwYW50SWQSMAoUcGFy'
    'dGljaXBhbnRfb3JkZXJfaWQYBCABKAlSEnBhcnRpY2lwYW50T3JkZXJJZBI0ChZwYXJ0aWNpcG'
    'FudF9hY2NvdW50X2lkGAUgASgJUhRwYXJ0aWNpcGFudEFjY291bnRJZBIuChNpbnZlc3Rvcl9h'
    'Y2NvdW50X2lkGAYgASgJUhFpbnZlc3RvckFjY291bnRJZBIuChNleGVjdXRvcl9hY2NvdW50X2'
    'lkGAcgASgJUhFleGVjdXRvckFjY291bnRJZBIdCgpvcmRlcl90eXBlGAggASgJUglvcmRlclR5'
    'cGUSPgoEc2lkZRgJIAEoDjIqLnFvbWV0LmFnb3JhLmRhZW1vbnMucHJ0YWdlbnQudjEuT3JkZX'
    'JTaWRlUgRzaWRlEhYKBnN5bWJvbBgKIAEoCVIGc3ltYm9sEhoKCGN1cnJlbmN5GAsgASgJUghj'
    'dXJyZW5jeRIaCghxdWFudGl0eRgMIAEoCVIIcXVhbnRpdHkSLQoScmVtYWluaW5nX3F1YW50aX'
    'R5GA0gASgJUhFyZW1haW5pbmdRdWFudGl0eRIUCgVwcmljZRgOIAEoCVIFcHJpY2USFgoGdm9s'
    'dW1lGA8gASgJUgZ2b2x1bWUSKQoQcmVtYWluaW5nX3ZvbHVtZRgQIAEoCVIPcmVtYWluaW5nVm'
    '9sdW1lEhoKCHNsaXBwYWdlGBEgASgJUghzbGlwcGFnZRIiCg10aW1lX2luX2ZvcmNlGBIgASgJ'
    'Ugt0aW1lSW5Gb3JjZRIpChBjcmVhdGVfdGltZXN0YW1wGBMgASgJUg9jcmVhdGVUaW1lc3RhbX'
    'ASLwoTZWZmZWN0aXZlX3RpbWVzdGFtcBgUIAEoCVISZWZmZWN0aXZlVGltZXN0YW1wEikKEGV4'
    'cGlyZV90aW1lc3RhbXAYFSABKAlSD2V4cGlyZVRpbWVzdGFtcBIZCghpc19vZmZlchgWIAEoCF'
    'IHaXNPZmZlchIwChRpc19kaXJlY3RseV9maWxsYWJsZRgXIAEoCFISaXNEaXJlY3RseUZpbGxh'
    'YmxlEhUKBmlzX2JpZBgYIAEoCFIFaXNCaWQSGwoJaXNfZmlsbGVkGBkgASgIUghpc0ZpbGxlZB'
    'IhCgxpc19jYW5jZWxsZWQYGiABKAhSC2lzQ2FuY2VsbGVkEh0KCmlzX2V4cGlyZWQYGyABKAhS'
    'CWlzRXhwaXJlZBInCg9jcmVhdG9yX2FkZHJlc3MYHCABKAlSDmNyZWF0b3JBZGRyZXNzEiYKD3'
    'RyZXpvcl9zdGFzaF9pZBgdIAEoCVINdHJlem9yU3Rhc2hJZBIbCglvZmZlcl9pZHMYHiABKAlS'
    'CG9mZmVySWRzEjMKFnBhcmVudF9kaXJlY3Rfb3JkZXJfaWQYHyABKAlSE3BhcmVudERpcmVjdE'
    '9yZGVySWQSGwoJYWxhcm1fYWJpGCAgASgJUghhbGFybUFiaRIdCgphbGFybV9kYXRhGCEgASgJ'
    'UglhbGFybURhdGESEgoEZGF0YRgiIAEoCVIEZGF0YRIjCg1kYXRhX2VuY29kaW5nGCMgASgJUg'
    'xkYXRhRW5jb2RpbmcSKQoQcGFydGljaXBhbnRfZGF0YRgkIAEoCVIPcGFydGljaXBhbnREYXRh');

@$core.Deprecated('Use tradeDescriptor instead')
const Trade$json = {
  '1': 'Trade',
  '2': [
    {'1': 'trade_id', '3': 1, '4': 1, '5': 9, '10': 'tradeId'},
    {'1': 'trade_hash', '3': 2, '4': 1, '5': 9, '10': 'tradeHash'},
    {'1': 'timestamp', '3': 3, '4': 1, '5': 9, '10': 'timestamp'},
    {'1': 'creator_address', '3': 4, '4': 1, '5': 9, '10': 'creatorAddress'},
    {'1': 'trade_type', '3': 5, '4': 1, '5': 9, '10': 'tradeType'},
    {'1': 'is_buy', '3': 6, '4': 1, '5': 8, '10': 'isBuy'},
    {'1': 'bid_order_id', '3': 7, '4': 1, '5': 9, '10': 'bidOrderId'},
    {'1': 'ask_order_id', '3': 8, '4': 1, '5': 9, '10': 'askOrderId'},
    {'1': 'quantity', '3': 9, '4': 1, '5': 9, '10': 'quantity'},
    {'1': 'price', '3': 10, '4': 1, '5': 9, '10': 'price'},
    {'1': 'volume', '3': 11, '4': 1, '5': 9, '10': 'volume'},
    {'1': 'bid_fee', '3': 12, '4': 1, '5': 9, '10': 'bidFee'},
    {'1': 'ask_fee', '3': 13, '4': 1, '5': 9, '10': 'askFee'},
    {'1': 'data_abi', '3': 14, '4': 1, '5': 9, '10': 'dataAbi'},
    {'1': 'data', '3': 15, '4': 1, '5': 9, '10': 'data'},
  ],
};

/// Descriptor for `Trade`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tradeDescriptor = $convert.base64Decode(
    'CgVUcmFkZRIZCgh0cmFkZV9pZBgBIAEoCVIHdHJhZGVJZBIdCgp0cmFkZV9oYXNoGAIgASgJUg'
    'l0cmFkZUhhc2gSHAoJdGltZXN0YW1wGAMgASgJUgl0aW1lc3RhbXASJwoPY3JlYXRvcl9hZGRy'
    'ZXNzGAQgASgJUg5jcmVhdG9yQWRkcmVzcxIdCgp0cmFkZV90eXBlGAUgASgJUgl0cmFkZVR5cG'
    'USFQoGaXNfYnV5GAYgASgIUgVpc0J1eRIgCgxiaWRfb3JkZXJfaWQYByABKAlSCmJpZE9yZGVy'
    'SWQSIAoMYXNrX29yZGVyX2lkGAggASgJUgphc2tPcmRlcklkEhoKCHF1YW50aXR5GAkgASgJUg'
    'hxdWFudGl0eRIUCgVwcmljZRgKIAEoCVIFcHJpY2USFgoGdm9sdW1lGAsgASgJUgZ2b2x1bWUS'
    'FwoHYmlkX2ZlZRgMIAEoCVIGYmlkRmVlEhcKB2Fza19mZWUYDSABKAlSBmFza0ZlZRIZCghkYX'
    'RhX2FiaRgOIAEoCVIHZGF0YUFiaRISCgRkYXRhGA8gASgJUgRkYXRh');

@$core.Deprecated('Use settlementDescriptor instead')
const Settlement$json = {
  '1': 'Settlement',
  '2': [
    {'1': 'settlement_id', '3': 1, '4': 1, '5': 9, '10': 'settlementId'},
    {'1': 'settlement_hash', '3': 2, '4': 1, '5': 9, '10': 'settlementHash'},
    {'1': 'timestamp', '3': 3, '4': 1, '5': 9, '10': 'timestamp'},
    {'1': 'trade_id', '3': 4, '4': 1, '5': 9, '10': 'tradeId'},
    {'1': 'trade_hash', '3': 5, '4': 1, '5': 9, '10': 'tradeHash'},
    {
      '1': 'confirmation_status',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.qomet.agora.daemons.prtagent.v1.ConfirmationStatus',
      '10': 'confirmationStatus'
    },
    {'1': 'settlement_type', '3': 7, '4': 1, '5': 9, '10': 'settlementType'},
    {'1': 'buyer_account', '3': 8, '4': 1, '5': 9, '10': 'buyerAccount'},
    {'1': 'seller_account', '3': 9, '4': 1, '5': 9, '10': 'sellerAccount'},
    {
      '1': 'asset_transferred',
      '3': 10,
      '4': 1,
      '5': 9,
      '10': 'assetTransferred'
    },
    {
      '1': 'amount_transferred',
      '3': 11,
      '4': 1,
      '5': 9,
      '10': 'amountTransferred'
    },
    {
      '1': 'currency_transferred',
      '3': 12,
      '4': 1,
      '5': 9,
      '10': 'currencyTransferred'
    },
    {'1': 'currency_amount', '3': 13, '4': 1, '5': 9, '10': 'currencyAmount'},
    {'1': 'ledger_id', '3': 14, '4': 1, '5': 9, '10': 'ledgerId'},
    {'1': 'vault_address', '3': 15, '4': 1, '5': 9, '10': 'vaultAddress'},
    {'1': 'reserve_id', '3': 16, '4': 1, '5': 9, '10': 'reserveId'},
    {'1': 'failure_reason', '3': 17, '4': 1, '5': 9, '10': 'failureReason'},
    {'1': 'data', '3': 18, '4': 1, '5': 9, '10': 'data'},
  ],
};

/// Descriptor for `Settlement`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List settlementDescriptor = $convert.base64Decode(
    'CgpTZXR0bGVtZW50EiMKDXNldHRsZW1lbnRfaWQYASABKAlSDHNldHRsZW1lbnRJZBInCg9zZX'
    'R0bGVtZW50X2hhc2gYAiABKAlSDnNldHRsZW1lbnRIYXNoEhwKCXRpbWVzdGFtcBgDIAEoCVIJ'
    'dGltZXN0YW1wEhkKCHRyYWRlX2lkGAQgASgJUgd0cmFkZUlkEh0KCnRyYWRlX2hhc2gYBSABKA'
    'lSCXRyYWRlSGFzaBJkChNjb25maXJtYXRpb25fc3RhdHVzGAYgASgOMjMucW9tZXQuYWdvcmEu'
    'ZGFlbW9ucy5wcnRhZ2VudC52MS5Db25maXJtYXRpb25TdGF0dXNSEmNvbmZpcm1hdGlvblN0YX'
    'R1cxInCg9zZXR0bGVtZW50X3R5cGUYByABKAlSDnNldHRsZW1lbnRUeXBlEiMKDWJ1eWVyX2Fj'
    'Y291bnQYCCABKAlSDGJ1eWVyQWNjb3VudBIlCg5zZWxsZXJfYWNjb3VudBgJIAEoCVINc2VsbG'
    'VyQWNjb3VudBIrChFhc3NldF90cmFuc2ZlcnJlZBgKIAEoCVIQYXNzZXRUcmFuc2ZlcnJlZBIt'
    'ChJhbW91bnRfdHJhbnNmZXJyZWQYCyABKAlSEWFtb3VudFRyYW5zZmVycmVkEjEKFGN1cnJlbm'
    'N5X3RyYW5zZmVycmVkGAwgASgJUhNjdXJyZW5jeVRyYW5zZmVycmVkEicKD2N1cnJlbmN5X2Ft'
    'b3VudBgNIAEoCVIOY3VycmVuY3lBbW91bnQSGwoJbGVkZ2VyX2lkGA4gASgJUghsZWRnZXJJZB'
    'IjCg12YXVsdF9hZGRyZXNzGA8gASgJUgx2YXVsdEFkZHJlc3MSHQoKcmVzZXJ2ZV9pZBgQIAEo'
    'CVIJcmVzZXJ2ZUlkEiUKDmZhaWx1cmVfcmVhc29uGBEgASgJUg1mYWlsdXJlUmVhc29uEhIKBG'
    'RhdGEYEiABKAlSBGRhdGE=');

@$core.Deprecated('Use orderEventDescriptor instead')
const OrderEvent$json = {
  '1': 'OrderEvent',
  '2': [
    {'1': 'order_event_id', '3': 1, '4': 1, '5': 9, '10': 'orderEventId'},
    {'1': 'order_event_hash', '3': 2, '4': 1, '5': 9, '10': 'orderEventHash'},
    {
      '1': 'order_event_timestamp',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'orderEventTimestamp'
    },
    {'1': 'order_event_type', '3': 4, '4': 1, '5': 9, '10': 'orderEventType'},
    {
      '1': 'order_event_version',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'orderEventVersion'
    },
    {
      '1': 'order',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Order',
      '10': 'order'
    },
    {
      '1': 'other_order',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Order',
      '10': 'otherOrder'
    },
    {
      '1': 'trade',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.qomet.agora.daemons.prtagent.v1.Trade',
      '10': 'trade'
    },
    {'1': 'chain_id', '3': 9, '4': 1, '5': 9, '10': 'chainId'},
    {'1': 'chain_name', '3': 10, '4': 1, '5': 9, '10': 'chainName'},
    {'1': 'engine_address', '3': 11, '4': 1, '5': 9, '10': 'engineAddress'},
    {'1': 'index_timestamp', '3': 12, '4': 1, '5': 9, '10': 'indexTimestamp'},
    {
      '1': 'index_block_timestamp',
      '3': 13,
      '4': 1,
      '5': 9,
      '10': 'indexBlockTimestamp'
    },
    {
      '1': 'index_block_number',
      '3': 14,
      '4': 1,
      '5': 9,
      '10': 'indexBlockNumber'
    },
    {'1': 'index_tx_hash', '3': 15, '4': 1, '5': 9, '10': 'indexTxHash'},
    {'1': 'index_tx_log_idx', '3': 16, '4': 1, '5': 3, '10': 'indexTxLogIdx'},
    {'1': 'pair_id', '3': 17, '4': 1, '5': 9, '10': 'pairId'},
    {
      '1': 'pair_base_token_symbol',
      '3': 18,
      '4': 1,
      '5': 9,
      '10': 'pairBaseTokenSymbol'
    },
    {
      '1': 'pair_quote_token_symbol',
      '3': 19,
      '4': 1,
      '5': 9,
      '10': 'pairQuoteTokenSymbol'
    },
    {'1': 'command_id', '3': 20, '4': 1, '5': 9, '10': 'commandId'},
    {
      '1': 'command_request_id',
      '3': 21,
      '4': 1,
      '5': 9,
      '10': 'commandRequestId'
    },
    {
      '1': 'command_timestamp',
      '3': 22,
      '4': 1,
      '5': 9,
      '10': 'commandTimestamp'
    },
    {'1': 'command_origin', '3': 23, '4': 1, '5': 9, '10': 'commandOrigin'},
    {
      '1': 'command_participant_id',
      '3': 24,
      '4': 1,
      '5': 9,
      '10': 'commandParticipantId'
    },
    {
      '1': 'command_operation',
      '3': 25,
      '4': 1,
      '5': 9,
      '10': 'commandOperation'
    },
    {'1': 'order_event_data', '3': 26, '4': 1, '5': 9, '10': 'orderEventData'},
  ],
};

/// Descriptor for `OrderEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List orderEventDescriptor = $convert.base64Decode(
    'CgpPcmRlckV2ZW50EiQKDm9yZGVyX2V2ZW50X2lkGAEgASgJUgxvcmRlckV2ZW50SWQSKAoQb3'
    'JkZXJfZXZlbnRfaGFzaBgCIAEoCVIOb3JkZXJFdmVudEhhc2gSMgoVb3JkZXJfZXZlbnRfdGlt'
    'ZXN0YW1wGAMgASgJUhNvcmRlckV2ZW50VGltZXN0YW1wEigKEG9yZGVyX2V2ZW50X3R5cGUYBC'
    'ABKAlSDm9yZGVyRXZlbnRUeXBlEi4KE29yZGVyX2V2ZW50X3ZlcnNpb24YBSABKAlSEW9yZGVy'
    'RXZlbnRWZXJzaW9uEjwKBW9yZGVyGAYgASgLMiYucW9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2'
    'VudC52MS5PcmRlclIFb3JkZXISRwoLb3RoZXJfb3JkZXIYByABKAsyJi5xb21ldC5hZ29yYS5k'
    'YWVtb25zLnBydGFnZW50LnYxLk9yZGVyUgpvdGhlck9yZGVyEjwKBXRyYWRlGAggASgLMiYucW'
    '9tZXQuYWdvcmEuZGFlbW9ucy5wcnRhZ2VudC52MS5UcmFkZVIFdHJhZGUSGQoIY2hhaW5faWQY'
    'CSABKAlSB2NoYWluSWQSHQoKY2hhaW5fbmFtZRgKIAEoCVIJY2hhaW5OYW1lEiUKDmVuZ2luZV'
    '9hZGRyZXNzGAsgASgJUg1lbmdpbmVBZGRyZXNzEicKD2luZGV4X3RpbWVzdGFtcBgMIAEoCVIO'
    'aW5kZXhUaW1lc3RhbXASMgoVaW5kZXhfYmxvY2tfdGltZXN0YW1wGA0gASgJUhNpbmRleEJsb2'
    'NrVGltZXN0YW1wEiwKEmluZGV4X2Jsb2NrX251bWJlchgOIAEoCVIQaW5kZXhCbG9ja051bWJl'
    'chIiCg1pbmRleF90eF9oYXNoGA8gASgJUgtpbmRleFR4SGFzaBInChBpbmRleF90eF9sb2dfaW'
    'R4GBAgASgDUg1pbmRleFR4TG9nSWR4EhcKB3BhaXJfaWQYESABKAlSBnBhaXJJZBIzChZwYWly'
    'X2Jhc2VfdG9rZW5fc3ltYm9sGBIgASgJUhNwYWlyQmFzZVRva2VuU3ltYm9sEjUKF3BhaXJfcX'
    'VvdGVfdG9rZW5fc3ltYm9sGBMgASgJUhRwYWlyUXVvdGVUb2tlblN5bWJvbBIdCgpjb21tYW5k'
    'X2lkGBQgASgJUgljb21tYW5kSWQSLAoSY29tbWFuZF9yZXF1ZXN0X2lkGBUgASgJUhBjb21tYW'
    '5kUmVxdWVzdElkEisKEWNvbW1hbmRfdGltZXN0YW1wGBYgASgJUhBjb21tYW5kVGltZXN0YW1w'
    'EiUKDmNvbW1hbmRfb3JpZ2luGBcgASgJUg1jb21tYW5kT3JpZ2luEjQKFmNvbW1hbmRfcGFydG'
    'ljaXBhbnRfaWQYGCABKAlSFGNvbW1hbmRQYXJ0aWNpcGFudElkEisKEWNvbW1hbmRfb3BlcmF0'
    'aW9uGBkgASgJUhBjb21tYW5kT3BlcmF0aW9uEigKEG9yZGVyX2V2ZW50X2RhdGEYGiABKAlSDm'
    '9yZGVyRXZlbnREYXRh');
