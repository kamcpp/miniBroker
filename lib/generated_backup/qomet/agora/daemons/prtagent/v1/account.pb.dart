// This is a generated file - do not edit.
//
// Generated from account.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $1;
import 'filter.pb.dart' as $3;
import 'fin_common.pb.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class GetAccountListRequest extends $pb.GeneratedMessage {
  factory GetAccountListRequest({
    $core.String? proposedExecutionId,
    $1.PaginationParams? pagination,
    $core.String? accountIidOrExternalIdRegex,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (pagination != null) result.pagination = pagination;
    if (accountIidOrExternalIdRegex != null)
      result.accountIidOrExternalIdRegex = accountIidOrExternalIdRegex;
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  GetAccountListRequest._();

  factory GetAccountListRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountListRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountListRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..aOS(3, _omitFieldNames ? '' : 'accountIidOrExternalIdRegex')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'GetAccountListRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountListRequest clone() =>
      GetAccountListRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountListRequest copyWith(
          void Function(GetAccountListRequest) updates) =>
      super.copyWith((message) => updates(message as GetAccountListRequest))
          as GetAccountListRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountListRequest create() => GetAccountListRequest._();
  @$core.override
  GetAccountListRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountListRequest> createRepeated() =>
      $pb.PbList<GetAccountListRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountListRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAccountListRequest>(create);
  static GetAccountListRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.PaginationParams get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination($1.PaginationParams value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.PaginationParams ensurePagination() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get accountIidOrExternalIdRegex => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountIidOrExternalIdRegex($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccountIidOrExternalIdRegex() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountIidOrExternalIdRegex() => $_clearField(3);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(3);
}

class GetAccountListResponse extends $pb.GeneratedMessage {
  factory GetAccountListResponse({
    $core.String? refExecutionId,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<$2.Account>? accounts,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (accounts != null) result.accounts.addAll(accounts);
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  GetAccountListResponse._();

  factory GetAccountListResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountListResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountListResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<$2.Account>(3, _omitFieldNames ? '' : 'accounts', $pb.PbFieldType.PM,
        subBuilder: $2.Account.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'GetAccountListResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountListResponse clone() =>
      GetAccountListResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountListResponse copyWith(
          void Function(GetAccountListResponse) updates) =>
      super.copyWith((message) => updates(message as GetAccountListResponse))
          as GetAccountListResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountListResponse create() => GetAccountListResponse._();
  @$core.override
  GetAccountListResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountListResponse> createRepeated() =>
      $pb.PbList<GetAccountListResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountListResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAccountListResponse>(create);
  static GetAccountListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.PaginationInfo get paginationInfo => $_getN(1);
  @$pb.TagNumber(2)
  set paginationInfo($1.PaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPaginationInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaginationInfo() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.PaginationInfo ensurePaginationInfo() => $_ensure(1);

  @$pb.TagNumber(3)
  $pb.PbList<$2.Account> get accounts => $_getList(2);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(3);
}

class GetAccountInfoBatchRequest extends $pb.GeneratedMessage {
  factory GetAccountInfoBatchRequest({
    $core.String? proposedExecutionId,
    $core.Iterable<$core.String>? accountIids,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (accountIids != null) result.accountIids.addAll(accountIids);
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  GetAccountInfoBatchRequest._();

  factory GetAccountInfoBatchRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountInfoBatchRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountInfoBatchRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..pPS(2, _omitFieldNames ? '' : 'accountIids')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'GetAccountInfoBatchRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountInfoBatchRequest clone() =>
      GetAccountInfoBatchRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountInfoBatchRequest copyWith(
          void Function(GetAccountInfoBatchRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetAccountInfoBatchRequest))
          as GetAccountInfoBatchRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountInfoBatchRequest create() => GetAccountInfoBatchRequest._();
  @$core.override
  GetAccountInfoBatchRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountInfoBatchRequest> createRepeated() =>
      $pb.PbList<GetAccountInfoBatchRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountInfoBatchRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAccountInfoBatchRequest>(create);
  static GetAccountInfoBatchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get accountIids => $_getList(1);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(2);
}

class GetAccountInfoBatchResponse extends $pb.GeneratedMessage {
  factory GetAccountInfoBatchResponse({
    $core.String? refExecutionId,
    $core.Iterable<$2.Account>? accounts,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (accounts != null) result.accounts.addAll(accounts);
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  GetAccountInfoBatchResponse._();

  factory GetAccountInfoBatchResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountInfoBatchResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountInfoBatchResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..pc<$2.Account>(2, _omitFieldNames ? '' : 'accounts', $pb.PbFieldType.PM,
        subBuilder: $2.Account.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'GetAccountInfoBatchResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountInfoBatchResponse clone() =>
      GetAccountInfoBatchResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountInfoBatchResponse copyWith(
          void Function(GetAccountInfoBatchResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetAccountInfoBatchResponse))
          as GetAccountInfoBatchResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountInfoBatchResponse create() =>
      GetAccountInfoBatchResponse._();
  @$core.override
  GetAccountInfoBatchResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountInfoBatchResponse> createRepeated() =>
      $pb.PbList<GetAccountInfoBatchResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountInfoBatchResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAccountInfoBatchResponse>(create);
  static GetAccountInfoBatchResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$2.Account> get accounts => $_getList(1);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(2);
}

class NewAccountRequest extends $pb.GeneratedMessage {
  factory NewAccountRequest({
    $core.String? proposedExecutionId,
    $core.String? externalAccountId,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (externalAccountId != null) result.externalAccountId = externalAccountId;
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  NewAccountRequest._();

  factory NewAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NewAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NewAccountRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'externalAccountId')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'NewAccountRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NewAccountRequest clone() => NewAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NewAccountRequest copyWith(void Function(NewAccountRequest) updates) =>
      super.copyWith((message) => updates(message as NewAccountRequest))
          as NewAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NewAccountRequest create() => NewAccountRequest._();
  @$core.override
  NewAccountRequest createEmptyInstance() => create();
  static $pb.PbList<NewAccountRequest> createRepeated() =>
      $pb.PbList<NewAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static NewAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NewAccountRequest>(create);
  static NewAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get externalAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set externalAccountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasExternalAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearExternalAccountId() => $_clearField(2);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(2);
}

class NewAccountResponse extends $pb.GeneratedMessage {
  factory NewAccountResponse({
    $core.String? refExecutionId,
    $core.String? agentAccountId,
    $1.DateTime? activationDt,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (agentAccountId != null) result.agentAccountId = agentAccountId;
    if (activationDt != null) result.activationDt = activationDt;
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  NewAccountResponse._();

  factory NewAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NewAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NewAccountResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'agentAccountId')
    ..aOM<$1.DateTime>(3, _omitFieldNames ? '' : 'activationDt',
        subBuilder: $1.DateTime.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'NewAccountResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NewAccountResponse clone() => NewAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NewAccountResponse copyWith(void Function(NewAccountResponse) updates) =>
      super.copyWith((message) => updates(message as NewAccountResponse))
          as NewAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NewAccountResponse create() => NewAccountResponse._();
  @$core.override
  NewAccountResponse createEmptyInstance() => create();
  static $pb.PbList<NewAccountResponse> createRepeated() =>
      $pb.PbList<NewAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static NewAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NewAccountResponse>(create);
  static NewAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get agentAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set agentAccountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAgentAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAgentAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.DateTime get activationDt => $_getN(2);
  @$pb.TagNumber(3)
  set activationDt($1.DateTime value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasActivationDt() => $_has(2);
  @$pb.TagNumber(3)
  void clearActivationDt() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.DateTime ensureActivationDt() => $_ensure(2);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(3);
}

class ActivateVenueForAccountRequest extends $pb.GeneratedMessage {
  factory ActivateVenueForAccountRequest({
    $core.String? proposedExecutionId,
    $core.String? accountIid,
    $core.String? venueIid,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (accountIid != null) result.accountIid = accountIid;
    if (venueIid != null) result.venueIid = venueIid;
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  ActivateVenueForAccountRequest._();

  factory ActivateVenueForAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ActivateVenueForAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ActivateVenueForAccountRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'accountIid')
    ..aOS(3, _omitFieldNames ? '' : 'venueIid')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'ActivateVenueForAccountRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ActivateVenueForAccountRequest clone() =>
      ActivateVenueForAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ActivateVenueForAccountRequest copyWith(
          void Function(ActivateVenueForAccountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ActivateVenueForAccountRequest))
          as ActivateVenueForAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ActivateVenueForAccountRequest create() =>
      ActivateVenueForAccountRequest._();
  @$core.override
  ActivateVenueForAccountRequest createEmptyInstance() => create();
  static $pb.PbList<ActivateVenueForAccountRequest> createRepeated() =>
      $pb.PbList<ActivateVenueForAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static ActivateVenueForAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ActivateVenueForAccountRequest>(create);
  static ActivateVenueForAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountIid($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountIid() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get venueIid => $_getSZ(2);
  @$pb.TagNumber(3)
  set venueIid($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVenueIid() => $_has(2);
  @$pb.TagNumber(3)
  void clearVenueIid() => $_clearField(3);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(3);
}

class ActivateVenueForAccountResponse extends $pb.GeneratedMessage {
  factory ActivateVenueForAccountResponse({
    $core.String? refExecutionId,
    $1.DateTime? activationDt,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (activationDt != null) result.activationDt = activationDt;
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  ActivateVenueForAccountResponse._();

  factory ActivateVenueForAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ActivateVenueForAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ActivateVenueForAccountResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.DateTime>(2, _omitFieldNames ? '' : 'activationDt',
        subBuilder: $1.DateTime.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'ActivateVenueForAccountResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ActivateVenueForAccountResponse clone() =>
      ActivateVenueForAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ActivateVenueForAccountResponse copyWith(
          void Function(ActivateVenueForAccountResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ActivateVenueForAccountResponse))
          as ActivateVenueForAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ActivateVenueForAccountResponse create() =>
      ActivateVenueForAccountResponse._();
  @$core.override
  ActivateVenueForAccountResponse createEmptyInstance() => create();
  static $pb.PbList<ActivateVenueForAccountResponse> createRepeated() =>
      $pb.PbList<ActivateVenueForAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static ActivateVenueForAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ActivateVenueForAccountResponse>(
          create);
  static ActivateVenueForAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.DateTime get activationDt => $_getN(1);
  @$pb.TagNumber(2)
  set activationDt($1.DateTime value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasActivationDt() => $_has(1);
  @$pb.TagNumber(2)
  void clearActivationDt() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.DateTime ensureActivationDt() => $_ensure(1);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(2);
}

class GetAccountInstrumentHoldingsRequest extends $pb.GeneratedMessage {
  factory GetAccountInstrumentHoldingsRequest({
    $core.String? proposedExecutionId,
    $core.String? accountIid,
    $core.String? venueIid,
    $core.Iterable<$core.String>? instrumentIids,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (accountIid != null) result.accountIid = accountIid;
    if (venueIid != null) result.venueIid = venueIid;
    if (instrumentIids != null) result.instrumentIids.addAll(instrumentIids);
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  GetAccountInstrumentHoldingsRequest._();

  factory GetAccountInstrumentHoldingsRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountInstrumentHoldingsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountInstrumentHoldingsRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'accountIid')
    ..aOS(3, _omitFieldNames ? '' : 'venueIid')
    ..pPS(4, _omitFieldNames ? '' : 'instrumentIids')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'GetAccountInstrumentHoldingsRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountInstrumentHoldingsRequest clone() =>
      GetAccountInstrumentHoldingsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountInstrumentHoldingsRequest copyWith(
          void Function(GetAccountInstrumentHoldingsRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetAccountInstrumentHoldingsRequest))
          as GetAccountInstrumentHoldingsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountInstrumentHoldingsRequest create() =>
      GetAccountInstrumentHoldingsRequest._();
  @$core.override
  GetAccountInstrumentHoldingsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountInstrumentHoldingsRequest> createRepeated() =>
      $pb.PbList<GetAccountInstrumentHoldingsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountInstrumentHoldingsRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetAccountInstrumentHoldingsRequest>(create);
  static GetAccountInstrumentHoldingsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountIid($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountIid() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get venueIid => $_getSZ(2);
  @$pb.TagNumber(3)
  set venueIid($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVenueIid() => $_has(2);
  @$pb.TagNumber(3)
  void clearVenueIid() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get instrumentIids => $_getList(3);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(4);
}

class GetAccountInstrumentHoldingsResponse extends $pb.GeneratedMessage {
  factory GetAccountInstrumentHoldingsResponse({
    $core.String? refExecutionId,
    $2.Portfolio? portfolio,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (portfolio != null) result.portfolio = portfolio;
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  GetAccountInstrumentHoldingsResponse._();

  factory GetAccountInstrumentHoldingsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountInstrumentHoldingsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountInstrumentHoldingsResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$2.Portfolio>(2, _omitFieldNames ? '' : 'portfolio',
        subBuilder: $2.Portfolio.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'GetAccountInstrumentHoldingsResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountInstrumentHoldingsResponse clone() =>
      GetAccountInstrumentHoldingsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountInstrumentHoldingsResponse copyWith(
          void Function(GetAccountInstrumentHoldingsResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetAccountInstrumentHoldingsResponse))
          as GetAccountInstrumentHoldingsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountInstrumentHoldingsResponse create() =>
      GetAccountInstrumentHoldingsResponse._();
  @$core.override
  GetAccountInstrumentHoldingsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountInstrumentHoldingsResponse> createRepeated() =>
      $pb.PbList<GetAccountInstrumentHoldingsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountInstrumentHoldingsResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetAccountInstrumentHoldingsResponse>(create);
  static GetAccountInstrumentHoldingsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $2.Portfolio get portfolio => $_getN(1);
  @$pb.TagNumber(2)
  set portfolio($2.Portfolio value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPortfolio() => $_has(1);
  @$pb.TagNumber(2)
  void clearPortfolio() => $_clearField(2);
  @$pb.TagNumber(2)
  $2.Portfolio ensurePortfolio() => $_ensure(1);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(2);
}

class GetAccountCashHoldingsRequest extends $pb.GeneratedMessage {
  factory GetAccountCashHoldingsRequest({
    $core.String? proposedExecutionId,
    $core.String? accountIid,
    $core.Iterable<$core.String>? currencyCodes,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (accountIid != null) result.accountIid = accountIid;
    if (currencyCodes != null) result.currencyCodes.addAll(currencyCodes);
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  GetAccountCashHoldingsRequest._();

  factory GetAccountCashHoldingsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountCashHoldingsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountCashHoldingsRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'accountIid')
    ..pPS(3, _omitFieldNames ? '' : 'currencyCodes')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'GetAccountCashHoldingsRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountCashHoldingsRequest clone() =>
      GetAccountCashHoldingsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountCashHoldingsRequest copyWith(
          void Function(GetAccountCashHoldingsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetAccountCashHoldingsRequest))
          as GetAccountCashHoldingsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountCashHoldingsRequest create() =>
      GetAccountCashHoldingsRequest._();
  @$core.override
  GetAccountCashHoldingsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountCashHoldingsRequest> createRepeated() =>
      $pb.PbList<GetAccountCashHoldingsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountCashHoldingsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAccountCashHoldingsRequest>(create);
  static GetAccountCashHoldingsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountIid($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountIid() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get currencyCodes => $_getList(2);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(3);
}

class GetAccountCashHoldingsResponse extends $pb.GeneratedMessage {
  factory GetAccountCashHoldingsResponse({
    $core.String? refExecutionId,
    $2.Portfolio? cashPortfolio,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (cashPortfolio != null) result.cashPortfolio = cashPortfolio;
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  GetAccountCashHoldingsResponse._();

  factory GetAccountCashHoldingsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountCashHoldingsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountCashHoldingsResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$2.Portfolio>(2, _omitFieldNames ? '' : 'cashPortfolio',
        subBuilder: $2.Portfolio.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'GetAccountCashHoldingsResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountCashHoldingsResponse clone() =>
      GetAccountCashHoldingsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountCashHoldingsResponse copyWith(
          void Function(GetAccountCashHoldingsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetAccountCashHoldingsResponse))
          as GetAccountCashHoldingsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountCashHoldingsResponse create() =>
      GetAccountCashHoldingsResponse._();
  @$core.override
  GetAccountCashHoldingsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountCashHoldingsResponse> createRepeated() =>
      $pb.PbList<GetAccountCashHoldingsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountCashHoldingsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAccountCashHoldingsResponse>(create);
  static GetAccountCashHoldingsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $2.Portfolio get cashPortfolio => $_getN(1);
  @$pb.TagNumber(2)
  set cashPortfolio($2.Portfolio value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCashPortfolio() => $_has(1);
  @$pb.TagNumber(2)
  void clearCashPortfolio() => $_clearField(2);
  @$pb.TagNumber(2)
  $2.Portfolio ensureCashPortfolio() => $_ensure(1);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(2);
}

class DepositCashRequest extends $pb.GeneratedMessage {
  factory DepositCashRequest({
    $core.String? proposedExecutionId,
    $core.String? accountIid,
    $core.String? currencyCode,
    $core.String? amount,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (accountIid != null) result.accountIid = accountIid;
    if (currencyCode != null) result.currencyCode = currencyCode;
    if (amount != null) result.amount = amount;
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  DepositCashRequest._();

  factory DepositCashRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DepositCashRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DepositCashRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'accountIid')
    ..aOS(3, _omitFieldNames ? '' : 'currencyCode')
    ..aOS(4, _omitFieldNames ? '' : 'amount')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'DepositCashRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DepositCashRequest clone() => DepositCashRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DepositCashRequest copyWith(void Function(DepositCashRequest) updates) =>
      super.copyWith((message) => updates(message as DepositCashRequest))
          as DepositCashRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DepositCashRequest create() => DepositCashRequest._();
  @$core.override
  DepositCashRequest createEmptyInstance() => create();
  static $pb.PbList<DepositCashRequest> createRepeated() =>
      $pb.PbList<DepositCashRequest>();
  @$core.pragma('dart2js:noInline')
  static DepositCashRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DepositCashRequest>(create);
  static DepositCashRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountIid($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountIid() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currencyCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set currencyCode($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrencyCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrencyCode() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get amount => $_getSZ(3);
  @$pb.TagNumber(4)
  set amount($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(4);
}

class DepositCashResponse extends $pb.GeneratedMessage {
  factory DepositCashResponse({
    $core.String? refExecutionId,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  DepositCashResponse._();

  factory DepositCashResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DepositCashResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DepositCashResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'DepositCashResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DepositCashResponse clone() => DepositCashResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DepositCashResponse copyWith(void Function(DepositCashResponse) updates) =>
      super.copyWith((message) => updates(message as DepositCashResponse))
          as DepositCashResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DepositCashResponse create() => DepositCashResponse._();
  @$core.override
  DepositCashResponse createEmptyInstance() => create();
  static $pb.PbList<DepositCashResponse> createRepeated() =>
      $pb.PbList<DepositCashResponse>();
  @$core.pragma('dart2js:noInline')
  static DepositCashResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DepositCashResponse>(create);
  static DepositCashResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => $_clearField(1);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(1);
}

class DepositInstrumentRequest extends $pb.GeneratedMessage {
  factory DepositInstrumentRequest({
    $core.String? proposedExecutionId,
    $core.String? accountIid,
    $core.String? instrumentIid,
    $core.String? units,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (accountIid != null) result.accountIid = accountIid;
    if (instrumentIid != null) result.instrumentIid = instrumentIid;
    if (units != null) result.units = units;
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  DepositInstrumentRequest._();

  factory DepositInstrumentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DepositInstrumentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DepositInstrumentRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'accountIid')
    ..aOS(3, _omitFieldNames ? '' : 'instrumentIid')
    ..aOS(4, _omitFieldNames ? '' : 'units')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'DepositInstrumentRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DepositInstrumentRequest clone() =>
      DepositInstrumentRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DepositInstrumentRequest copyWith(
          void Function(DepositInstrumentRequest) updates) =>
      super.copyWith((message) => updates(message as DepositInstrumentRequest))
          as DepositInstrumentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DepositInstrumentRequest create() => DepositInstrumentRequest._();
  @$core.override
  DepositInstrumentRequest createEmptyInstance() => create();
  static $pb.PbList<DepositInstrumentRequest> createRepeated() =>
      $pb.PbList<DepositInstrumentRequest>();
  @$core.pragma('dart2js:noInline')
  static DepositInstrumentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DepositInstrumentRequest>(create);
  static DepositInstrumentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountIid($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountIid() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get instrumentIid => $_getSZ(2);
  @$pb.TagNumber(3)
  set instrumentIid($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInstrumentIid() => $_has(2);
  @$pb.TagNumber(3)
  void clearInstrumentIid() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get units => $_getSZ(3);
  @$pb.TagNumber(4)
  set units($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUnits() => $_has(3);
  @$pb.TagNumber(4)
  void clearUnits() => $_clearField(4);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(4);
}

class DepositInstrumentResponse extends $pb.GeneratedMessage {
  factory DepositInstrumentResponse({
    $core.String? refExecutionId,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  DepositInstrumentResponse._();

  factory DepositInstrumentResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DepositInstrumentResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DepositInstrumentResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'DepositInstrumentResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DepositInstrumentResponse clone() =>
      DepositInstrumentResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DepositInstrumentResponse copyWith(
          void Function(DepositInstrumentResponse) updates) =>
      super.copyWith((message) => updates(message as DepositInstrumentResponse))
          as DepositInstrumentResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DepositInstrumentResponse create() => DepositInstrumentResponse._();
  @$core.override
  DepositInstrumentResponse createEmptyInstance() => create();
  static $pb.PbList<DepositInstrumentResponse> createRepeated() =>
      $pb.PbList<DepositInstrumentResponse>();
  @$core.pragma('dart2js:noInline')
  static DepositInstrumentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DepositInstrumentResponse>(create);
  static DepositInstrumentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => $_clearField(1);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(1);
}

class WithdrawCashRequest extends $pb.GeneratedMessage {
  factory WithdrawCashRequest({
    $core.String? proposedExecutionId,
    $core.String? accountIid,
    $core.String? currencyCode,
    $core.String? amount,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (accountIid != null) result.accountIid = accountIid;
    if (currencyCode != null) result.currencyCode = currencyCode;
    if (amount != null) result.amount = amount;
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  WithdrawCashRequest._();

  factory WithdrawCashRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WithdrawCashRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WithdrawCashRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'accountIid')
    ..aOS(3, _omitFieldNames ? '' : 'currencyCode')
    ..aOS(4, _omitFieldNames ? '' : 'amount')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'WithdrawCashRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawCashRequest clone() => WithdrawCashRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawCashRequest copyWith(void Function(WithdrawCashRequest) updates) =>
      super.copyWith((message) => updates(message as WithdrawCashRequest))
          as WithdrawCashRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawCashRequest create() => WithdrawCashRequest._();
  @$core.override
  WithdrawCashRequest createEmptyInstance() => create();
  static $pb.PbList<WithdrawCashRequest> createRepeated() =>
      $pb.PbList<WithdrawCashRequest>();
  @$core.pragma('dart2js:noInline')
  static WithdrawCashRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WithdrawCashRequest>(create);
  static WithdrawCashRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountIid($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountIid() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currencyCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set currencyCode($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrencyCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrencyCode() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get amount => $_getSZ(3);
  @$pb.TagNumber(4)
  set amount($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(4);
}

class WithdrawCashResponse extends $pb.GeneratedMessage {
  factory WithdrawCashResponse({
    $core.String? refExecutionId,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  WithdrawCashResponse._();

  factory WithdrawCashResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WithdrawCashResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WithdrawCashResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'WithdrawCashResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawCashResponse clone() =>
      WithdrawCashResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawCashResponse copyWith(void Function(WithdrawCashResponse) updates) =>
      super.copyWith((message) => updates(message as WithdrawCashResponse))
          as WithdrawCashResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawCashResponse create() => WithdrawCashResponse._();
  @$core.override
  WithdrawCashResponse createEmptyInstance() => create();
  static $pb.PbList<WithdrawCashResponse> createRepeated() =>
      $pb.PbList<WithdrawCashResponse>();
  @$core.pragma('dart2js:noInline')
  static WithdrawCashResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WithdrawCashResponse>(create);
  static WithdrawCashResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => $_clearField(1);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(1);
}

class WithdrawInstrumentRequest extends $pb.GeneratedMessage {
  factory WithdrawInstrumentRequest({
    $core.String? proposedExecutionId,
    $core.String? accountIid,
    $core.String? instrumentIid,
    $core.String? units,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (accountIid != null) result.accountIid = accountIid;
    if (instrumentIid != null) result.instrumentIid = instrumentIid;
    if (units != null) result.units = units;
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  WithdrawInstrumentRequest._();

  factory WithdrawInstrumentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WithdrawInstrumentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WithdrawInstrumentRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'accountIid')
    ..aOS(3, _omitFieldNames ? '' : 'instrumentIid')
    ..aOS(4, _omitFieldNames ? '' : 'units')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'WithdrawInstrumentRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawInstrumentRequest clone() =>
      WithdrawInstrumentRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawInstrumentRequest copyWith(
          void Function(WithdrawInstrumentRequest) updates) =>
      super.copyWith((message) => updates(message as WithdrawInstrumentRequest))
          as WithdrawInstrumentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawInstrumentRequest create() => WithdrawInstrumentRequest._();
  @$core.override
  WithdrawInstrumentRequest createEmptyInstance() => create();
  static $pb.PbList<WithdrawInstrumentRequest> createRepeated() =>
      $pb.PbList<WithdrawInstrumentRequest>();
  @$core.pragma('dart2js:noInline')
  static WithdrawInstrumentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WithdrawInstrumentRequest>(create);
  static WithdrawInstrumentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountIid($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountIid() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get instrumentIid => $_getSZ(2);
  @$pb.TagNumber(3)
  set instrumentIid($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInstrumentIid() => $_has(2);
  @$pb.TagNumber(3)
  void clearInstrumentIid() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get units => $_getSZ(3);
  @$pb.TagNumber(4)
  set units($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUnits() => $_has(3);
  @$pb.TagNumber(4)
  void clearUnits() => $_clearField(4);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(4);
}

class WithdrawInstrumentResponse extends $pb.GeneratedMessage {
  factory WithdrawInstrumentResponse({
    $core.String? refExecutionId,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  WithdrawInstrumentResponse._();

  factory WithdrawInstrumentResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WithdrawInstrumentResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WithdrawInstrumentResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'WithdrawInstrumentResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawInstrumentResponse clone() =>
      WithdrawInstrumentResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawInstrumentResponse copyWith(
          void Function(WithdrawInstrumentResponse) updates) =>
      super.copyWith(
              (message) => updates(message as WithdrawInstrumentResponse))
          as WithdrawInstrumentResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawInstrumentResponse create() => WithdrawInstrumentResponse._();
  @$core.override
  WithdrawInstrumentResponse createEmptyInstance() => create();
  static $pb.PbList<WithdrawInstrumentResponse> createRepeated() =>
      $pb.PbList<WithdrawInstrumentResponse>();
  @$core.pragma('dart2js:noInline')
  static WithdrawInstrumentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WithdrawInstrumentResponse>(create);
  static WithdrawInstrumentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => $_clearField(1);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(1);
}

class GetAccountOrdersRequest extends $pb.GeneratedMessage {
  factory GetAccountOrdersRequest({
    $core.String? proposedExecutionId,
    $core.String? accountIid,
    $core.Iterable<$core.String>? venueIdOrSymbolRegexes,
    $1.PaginationParams? pagination,
    $3.OrderQueryFilter? orderQueryFilter,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (accountIid != null) result.accountIid = accountIid;
    if (venueIdOrSymbolRegexes != null)
      result.venueIdOrSymbolRegexes.addAll(venueIdOrSymbolRegexes);
    if (pagination != null) result.pagination = pagination;
    if (orderQueryFilter != null) result.orderQueryFilter = orderQueryFilter;
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  GetAccountOrdersRequest._();

  factory GetAccountOrdersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountOrdersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountOrdersRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'accountIid')
    ..pPS(3, _omitFieldNames ? '' : 'venueIdOrSymbolRegexes')
    ..aOM<$1.PaginationParams>(4, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..aOM<$3.OrderQueryFilter>(5, _omitFieldNames ? '' : 'orderQueryFilter',
        subBuilder: $3.OrderQueryFilter.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'GetAccountOrdersRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountOrdersRequest clone() =>
      GetAccountOrdersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountOrdersRequest copyWith(
          void Function(GetAccountOrdersRequest) updates) =>
      super.copyWith((message) => updates(message as GetAccountOrdersRequest))
          as GetAccountOrdersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountOrdersRequest create() => GetAccountOrdersRequest._();
  @$core.override
  GetAccountOrdersRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountOrdersRequest> createRepeated() =>
      $pb.PbList<GetAccountOrdersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountOrdersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAccountOrdersRequest>(create);
  static GetAccountOrdersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountIid($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountIid() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get venueIdOrSymbolRegexes => $_getList(2);

  @$pb.TagNumber(4)
  $1.PaginationParams get pagination => $_getN(3);
  @$pb.TagNumber(4)
  set pagination($1.PaginationParams value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPagination() => $_has(3);
  @$pb.TagNumber(4)
  void clearPagination() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.PaginationParams ensurePagination() => $_ensure(3);

  @$pb.TagNumber(5)
  $3.OrderQueryFilter get orderQueryFilter => $_getN(4);
  @$pb.TagNumber(5)
  set orderQueryFilter($3.OrderQueryFilter value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasOrderQueryFilter() => $_has(4);
  @$pb.TagNumber(5)
  void clearOrderQueryFilter() => $_clearField(5);
  @$pb.TagNumber(5)
  $3.OrderQueryFilter ensureOrderQueryFilter() => $_ensure(4);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(5);
}

class GetAccountOrdersResponse extends $pb.GeneratedMessage {
  factory GetAccountOrdersResponse({
    $core.String? refExecutionId,
    $1.PaginationInfo? paginationInfo,
    $1.DateTime? generatedAtDt,
    $core.Iterable<$2.Order>? orders,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (generatedAtDt != null) result.generatedAtDt = generatedAtDt;
    if (orders != null) result.orders.addAll(orders);
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  GetAccountOrdersResponse._();

  factory GetAccountOrdersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountOrdersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountOrdersResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..aOM<$1.DateTime>(3, _omitFieldNames ? '' : 'generatedAtDt',
        subBuilder: $1.DateTime.create)
    ..pc<$2.Order>(4, _omitFieldNames ? '' : 'orders', $pb.PbFieldType.PM,
        subBuilder: $2.Order.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'GetAccountOrdersResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountOrdersResponse clone() =>
      GetAccountOrdersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountOrdersResponse copyWith(
          void Function(GetAccountOrdersResponse) updates) =>
      super.copyWith((message) => updates(message as GetAccountOrdersResponse))
          as GetAccountOrdersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountOrdersResponse create() => GetAccountOrdersResponse._();
  @$core.override
  GetAccountOrdersResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountOrdersResponse> createRepeated() =>
      $pb.PbList<GetAccountOrdersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountOrdersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAccountOrdersResponse>(create);
  static GetAccountOrdersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.PaginationInfo get paginationInfo => $_getN(1);
  @$pb.TagNumber(2)
  set paginationInfo($1.PaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPaginationInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaginationInfo() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.PaginationInfo ensurePaginationInfo() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.DateTime get generatedAtDt => $_getN(2);
  @$pb.TagNumber(3)
  set generatedAtDt($1.DateTime value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasGeneratedAtDt() => $_has(2);
  @$pb.TagNumber(3)
  void clearGeneratedAtDt() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.DateTime ensureGeneratedAtDt() => $_ensure(2);

  @$pb.TagNumber(4)
  $pb.PbList<$2.Order> get orders => $_getList(3);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(4);
}

class GetAccountTradesRequest extends $pb.GeneratedMessage {
  factory GetAccountTradesRequest({
    $core.String? proposedExecutionId,
    $core.String? accountIid,
    $core.Iterable<$core.String>? marketIdOrNameRegexes,
    $1.PaginationParams? pagination,
    $1.DateTime? fromDt,
    $1.DateTime? toDt,
    $core.Iterable<$core.String>? instrumentIdOrSymbolRegexes,
    $2.OrderSide? side,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (accountIid != null) result.accountIid = accountIid;
    if (marketIdOrNameRegexes != null)
      result.marketIdOrNameRegexes.addAll(marketIdOrNameRegexes);
    if (pagination != null) result.pagination = pagination;
    if (fromDt != null) result.fromDt = fromDt;
    if (toDt != null) result.toDt = toDt;
    if (instrumentIdOrSymbolRegexes != null)
      result.instrumentIdOrSymbolRegexes.addAll(instrumentIdOrSymbolRegexes);
    if (side != null) result.side = side;
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  GetAccountTradesRequest._();

  factory GetAccountTradesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountTradesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountTradesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'accountIid')
    ..pPS(3, _omitFieldNames ? '' : 'marketIdOrNameRegexes')
    ..aOM<$1.PaginationParams>(4, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..aOM<$1.DateTime>(5, _omitFieldNames ? '' : 'fromDt',
        subBuilder: $1.DateTime.create)
    ..aOM<$1.DateTime>(6, _omitFieldNames ? '' : 'toDt',
        subBuilder: $1.DateTime.create)
    ..pPS(7, _omitFieldNames ? '' : 'instrumentIdOrSymbolRegexes')
    ..e<$2.OrderSide>(8, _omitFieldNames ? '' : 'side', $pb.PbFieldType.OE,
        defaultOrMaker: $2.OrderSide.ORDER_SIDE__UNKNOWN,
        valueOf: $2.OrderSide.valueOf,
        enumValues: $2.OrderSide.values)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'GetAccountTradesRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountTradesRequest clone() =>
      GetAccountTradesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountTradesRequest copyWith(
          void Function(GetAccountTradesRequest) updates) =>
      super.copyWith((message) => updates(message as GetAccountTradesRequest))
          as GetAccountTradesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountTradesRequest create() => GetAccountTradesRequest._();
  @$core.override
  GetAccountTradesRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountTradesRequest> createRepeated() =>
      $pb.PbList<GetAccountTradesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountTradesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAccountTradesRequest>(create);
  static GetAccountTradesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountIid($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountIid() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get marketIdOrNameRegexes => $_getList(2);

  @$pb.TagNumber(4)
  $1.PaginationParams get pagination => $_getN(3);
  @$pb.TagNumber(4)
  set pagination($1.PaginationParams value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPagination() => $_has(3);
  @$pb.TagNumber(4)
  void clearPagination() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.PaginationParams ensurePagination() => $_ensure(3);

  @$pb.TagNumber(5)
  $1.DateTime get fromDt => $_getN(4);
  @$pb.TagNumber(5)
  set fromDt($1.DateTime value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasFromDt() => $_has(4);
  @$pb.TagNumber(5)
  void clearFromDt() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.DateTime ensureFromDt() => $_ensure(4);

  @$pb.TagNumber(6)
  $1.DateTime get toDt => $_getN(5);
  @$pb.TagNumber(6)
  set toDt($1.DateTime value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasToDt() => $_has(5);
  @$pb.TagNumber(6)
  void clearToDt() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.DateTime ensureToDt() => $_ensure(5);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get instrumentIdOrSymbolRegexes => $_getList(6);

  @$pb.TagNumber(8)
  $2.OrderSide get side => $_getN(7);
  @$pb.TagNumber(8)
  set side($2.OrderSide value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasSide() => $_has(7);
  @$pb.TagNumber(8)
  void clearSide() => $_clearField(8);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(8);
}

class GetAccountTradesResponse extends $pb.GeneratedMessage {
  factory GetAccountTradesResponse({
    $core.String? refExecutionId,
    $1.PaginationInfo? paginationInfo,
    $1.DateTime? generatedAtDt,
    $core.Iterable<$2.Trade>? trades,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (generatedAtDt != null) result.generatedAtDt = generatedAtDt;
    if (trades != null) result.trades.addAll(trades);
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  GetAccountTradesResponse._();

  factory GetAccountTradesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountTradesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountTradesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..aOM<$1.DateTime>(3, _omitFieldNames ? '' : 'generatedAtDt',
        subBuilder: $1.DateTime.create)
    ..pc<$2.Trade>(4, _omitFieldNames ? '' : 'trades', $pb.PbFieldType.PM,
        subBuilder: $2.Trade.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'GetAccountTradesResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountTradesResponse clone() =>
      GetAccountTradesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountTradesResponse copyWith(
          void Function(GetAccountTradesResponse) updates) =>
      super.copyWith((message) => updates(message as GetAccountTradesResponse))
          as GetAccountTradesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountTradesResponse create() => GetAccountTradesResponse._();
  @$core.override
  GetAccountTradesResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountTradesResponse> createRepeated() =>
      $pb.PbList<GetAccountTradesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountTradesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAccountTradesResponse>(create);
  static GetAccountTradesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.PaginationInfo get paginationInfo => $_getN(1);
  @$pb.TagNumber(2)
  set paginationInfo($1.PaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPaginationInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaginationInfo() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.PaginationInfo ensurePaginationInfo() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.DateTime get generatedAtDt => $_getN(2);
  @$pb.TagNumber(3)
  set generatedAtDt($1.DateTime value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasGeneratedAtDt() => $_has(2);
  @$pb.TagNumber(3)
  void clearGeneratedAtDt() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.DateTime ensureGeneratedAtDt() => $_ensure(2);

  @$pb.TagNumber(4)
  $pb.PbList<$2.Trade> get trades => $_getList(3);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(4);
}

class GetAccountSettlementsRequest extends $pb.GeneratedMessage {
  factory GetAccountSettlementsRequest({
    $core.String? proposedExecutionId,
    $core.String? accountIid,
    $core.Iterable<$core.String>? marketIdOrNameRegexes,
    $1.PaginationParams? pagination,
    $1.DateTime? fromDt,
    $1.DateTime? toDt,
    $2.ConfirmationStatus? status,
    $core.Iterable<$core.String>? assetIdOrNameRegexes,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (accountIid != null) result.accountIid = accountIid;
    if (marketIdOrNameRegexes != null)
      result.marketIdOrNameRegexes.addAll(marketIdOrNameRegexes);
    if (pagination != null) result.pagination = pagination;
    if (fromDt != null) result.fromDt = fromDt;
    if (toDt != null) result.toDt = toDt;
    if (status != null) result.status = status;
    if (assetIdOrNameRegexes != null)
      result.assetIdOrNameRegexes.addAll(assetIdOrNameRegexes);
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  GetAccountSettlementsRequest._();

  factory GetAccountSettlementsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountSettlementsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountSettlementsRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'accountIid')
    ..pPS(3, _omitFieldNames ? '' : 'marketIdOrNameRegexes')
    ..aOM<$1.PaginationParams>(4, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..aOM<$1.DateTime>(5, _omitFieldNames ? '' : 'fromDt',
        subBuilder: $1.DateTime.create)
    ..aOM<$1.DateTime>(6, _omitFieldNames ? '' : 'toDt',
        subBuilder: $1.DateTime.create)
    ..e<$2.ConfirmationStatus>(
        7, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: $2.ConfirmationStatus.CONFIRMATION_STATUS__UNKNOWN,
        valueOf: $2.ConfirmationStatus.valueOf,
        enumValues: $2.ConfirmationStatus.values)
    ..pPS(8, _omitFieldNames ? '' : 'assetIdOrNameRegexes')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'GetAccountSettlementsRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountSettlementsRequest clone() =>
      GetAccountSettlementsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountSettlementsRequest copyWith(
          void Function(GetAccountSettlementsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetAccountSettlementsRequest))
          as GetAccountSettlementsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountSettlementsRequest create() =>
      GetAccountSettlementsRequest._();
  @$core.override
  GetAccountSettlementsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountSettlementsRequest> createRepeated() =>
      $pb.PbList<GetAccountSettlementsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountSettlementsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAccountSettlementsRequest>(create);
  static GetAccountSettlementsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountIid($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountIid() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get marketIdOrNameRegexes => $_getList(2);

  @$pb.TagNumber(4)
  $1.PaginationParams get pagination => $_getN(3);
  @$pb.TagNumber(4)
  set pagination($1.PaginationParams value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPagination() => $_has(3);
  @$pb.TagNumber(4)
  void clearPagination() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.PaginationParams ensurePagination() => $_ensure(3);

  @$pb.TagNumber(5)
  $1.DateTime get fromDt => $_getN(4);
  @$pb.TagNumber(5)
  set fromDt($1.DateTime value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasFromDt() => $_has(4);
  @$pb.TagNumber(5)
  void clearFromDt() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.DateTime ensureFromDt() => $_ensure(4);

  @$pb.TagNumber(6)
  $1.DateTime get toDt => $_getN(5);
  @$pb.TagNumber(6)
  set toDt($1.DateTime value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasToDt() => $_has(5);
  @$pb.TagNumber(6)
  void clearToDt() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.DateTime ensureToDt() => $_ensure(5);

  @$pb.TagNumber(7)
  $2.ConfirmationStatus get status => $_getN(6);
  @$pb.TagNumber(7)
  set status($2.ConfirmationStatus value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get assetIdOrNameRegexes => $_getList(7);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(8);
}

class GetAccountSettlementsResponse extends $pb.GeneratedMessage {
  factory GetAccountSettlementsResponse({
    $core.String? refExecutionId,
    $1.PaginationInfo? paginationInfo,
    $1.DateTime? generatedAtDt,
    $core.Iterable<$2.Settlement>? settlements,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (generatedAtDt != null) result.generatedAtDt = generatedAtDt;
    if (settlements != null) result.settlements.addAll(settlements);
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  GetAccountSettlementsResponse._();

  factory GetAccountSettlementsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountSettlementsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountSettlementsResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..aOM<$1.DateTime>(3, _omitFieldNames ? '' : 'generatedAtDt',
        subBuilder: $1.DateTime.create)
    ..pc<$2.Settlement>(
        4, _omitFieldNames ? '' : 'settlements', $pb.PbFieldType.PM,
        subBuilder: $2.Settlement.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'GetAccountSettlementsResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountSettlementsResponse clone() =>
      GetAccountSettlementsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountSettlementsResponse copyWith(
          void Function(GetAccountSettlementsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetAccountSettlementsResponse))
          as GetAccountSettlementsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountSettlementsResponse create() =>
      GetAccountSettlementsResponse._();
  @$core.override
  GetAccountSettlementsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountSettlementsResponse> createRepeated() =>
      $pb.PbList<GetAccountSettlementsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountSettlementsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAccountSettlementsResponse>(create);
  static GetAccountSettlementsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.PaginationInfo get paginationInfo => $_getN(1);
  @$pb.TagNumber(2)
  set paginationInfo($1.PaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPaginationInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaginationInfo() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.PaginationInfo ensurePaginationInfo() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.DateTime get generatedAtDt => $_getN(2);
  @$pb.TagNumber(3)
  set generatedAtDt($1.DateTime value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasGeneratedAtDt() => $_has(2);
  @$pb.TagNumber(3)
  void clearGeneratedAtDt() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.DateTime ensureGeneratedAtDt() => $_ensure(2);

  @$pb.TagNumber(4)
  $pb.PbList<$2.Settlement> get settlements => $_getList(3);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(4);
}

class GetAccountTransactionsRequest extends $pb.GeneratedMessage {
  factory GetAccountTransactionsRequest({
    $core.String? proposedExecutionId,
    $core.String? accountIid,
    $1.PaginationParams? pagination,
    $1.DateTime? fromDt,
    $1.DateTime? toDt,
    $core.Iterable<$2.TransactionTypeEnum>? transactionTypes,
    $core.Iterable<$core.String>? assetIdOrNameRegexes,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? auxData,
  }) {
    final result = create();
    if (proposedExecutionId != null)
      result.proposedExecutionId = proposedExecutionId;
    if (accountIid != null) result.accountIid = accountIid;
    if (pagination != null) result.pagination = pagination;
    if (fromDt != null) result.fromDt = fromDt;
    if (toDt != null) result.toDt = toDt;
    if (transactionTypes != null)
      result.transactionTypes.addAll(transactionTypes);
    if (assetIdOrNameRegexes != null)
      result.assetIdOrNameRegexes.addAll(assetIdOrNameRegexes);
    if (auxData != null) result.auxData.addEntries(auxData);
    return result;
  }

  GetAccountTransactionsRequest._();

  factory GetAccountTransactionsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountTransactionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountTransactionsRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'accountIid')
    ..aOM<$1.PaginationParams>(3, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..aOM<$1.DateTime>(4, _omitFieldNames ? '' : 'fromDt',
        subBuilder: $1.DateTime.create)
    ..aOM<$1.DateTime>(5, _omitFieldNames ? '' : 'toDt',
        subBuilder: $1.DateTime.create)
    ..pc<$2.TransactionTypeEnum>(
        6, _omitFieldNames ? '' : 'transactionTypes', $pb.PbFieldType.KE,
        valueOf: $2.TransactionTypeEnum.valueOf,
        enumValues: $2.TransactionTypeEnum.values,
        defaultEnumValue: $2.TransactionTypeEnum.TRANSACTION_TYPE_ENUM__UNKNOWN)
    ..pPS(7, _omitFieldNames ? '' : 'assetIdOrNameRegexes')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData',
        entryClassName: 'GetAccountTransactionsRequest.AuxDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountTransactionsRequest clone() =>
      GetAccountTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountTransactionsRequest copyWith(
          void Function(GetAccountTransactionsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetAccountTransactionsRequest))
          as GetAccountTransactionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountTransactionsRequest create() =>
      GetAccountTransactionsRequest._();
  @$core.override
  GetAccountTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountTransactionsRequest> createRepeated() =>
      $pb.PbList<GetAccountTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountTransactionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAccountTransactionsRequest>(create);
  static GetAccountTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountIid($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountIid() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.PaginationParams get pagination => $_getN(2);
  @$pb.TagNumber(3)
  set pagination($1.PaginationParams value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPagination() => $_has(2);
  @$pb.TagNumber(3)
  void clearPagination() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.PaginationParams ensurePagination() => $_ensure(2);

  @$pb.TagNumber(4)
  $1.DateTime get fromDt => $_getN(3);
  @$pb.TagNumber(4)
  set fromDt($1.DateTime value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasFromDt() => $_has(3);
  @$pb.TagNumber(4)
  void clearFromDt() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.DateTime ensureFromDt() => $_ensure(3);

  @$pb.TagNumber(5)
  $1.DateTime get toDt => $_getN(4);
  @$pb.TagNumber(5)
  set toDt($1.DateTime value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasToDt() => $_has(4);
  @$pb.TagNumber(5)
  void clearToDt() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.DateTime ensureToDt() => $_ensure(4);

  @$pb.TagNumber(6)
  $pb.PbList<$2.TransactionTypeEnum> get transactionTypes => $_getList(5);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get assetIdOrNameRegexes => $_getList(6);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get auxData => $_getMap(7);
}

class GetAccountTransactionsResponse extends $pb.GeneratedMessage {
  factory GetAccountTransactionsResponse({
    $core.String? refExecutionId,
    $1.PaginationInfo? paginationInfo,
    $1.DateTime? generatedAtDt,
    $core.Iterable<$2.Transaction>? transactions,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (refExecutionId != null) result.refExecutionId = refExecutionId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (generatedAtDt != null) result.generatedAtDt = generatedAtDt;
    if (transactions != null) result.transactions.addAll(transactions);
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  GetAccountTransactionsResponse._();

  factory GetAccountTransactionsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountTransactionsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountTransactionsResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..aOM<$1.DateTime>(3, _omitFieldNames ? '' : 'generatedAtDt',
        subBuilder: $1.DateTime.create)
    ..pc<$2.Transaction>(
        4, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM,
        subBuilder: $2.Transaction.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'GetAccountTransactionsResponse.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountTransactionsResponse clone() =>
      GetAccountTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountTransactionsResponse copyWith(
          void Function(GetAccountTransactionsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetAccountTransactionsResponse))
          as GetAccountTransactionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountTransactionsResponse create() =>
      GetAccountTransactionsResponse._();
  @$core.override
  GetAccountTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountTransactionsResponse> createRepeated() =>
      $pb.PbList<GetAccountTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountTransactionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAccountTransactionsResponse>(create);
  static GetAccountTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.PaginationInfo get paginationInfo => $_getN(1);
  @$pb.TagNumber(2)
  set paginationInfo($1.PaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPaginationInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaginationInfo() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.PaginationInfo ensurePaginationInfo() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.DateTime get generatedAtDt => $_getN(2);
  @$pb.TagNumber(3)
  set generatedAtDt($1.DateTime value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasGeneratedAtDt() => $_has(2);
  @$pb.TagNumber(3)
  void clearGeneratedAtDt() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.DateTime ensureGeneratedAtDt() => $_ensure(2);

  @$pb.TagNumber(4)
  $pb.PbList<$2.Transaction> get transactions => $_getList(3);

  @$pb.TagNumber(105)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
