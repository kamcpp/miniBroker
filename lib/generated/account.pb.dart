//
//  Generated code. Do not modify.
//  source: account.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $1;
import 'filter.pb.dart' as $10;
import 'fin_common.pb.dart' as $9;
import 'fin_common.pbenum.dart' as $9;

class GetAccountListRequest extends $pb.GeneratedMessage {
  factory GetAccountListRequest({
    $core.String? proposedExecutionId,
    $1.PaginationParams? pagination,
    $core.String? accountIidOrExternalIdRegex,
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    if (accountIidOrExternalIdRegex != null) {
      $result.accountIidOrExternalIdRegex = accountIidOrExternalIdRegex;
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  GetAccountListRequest._() : super();
  factory GetAccountListRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountListRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountListRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination', subBuilder: $1.PaginationParams.create)
    ..aOS(3, _omitFieldNames ? '' : 'accountIidOrExternalIdRegex')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'GetAccountListRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountListRequest clone() => GetAccountListRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountListRequest copyWith(void Function(GetAccountListRequest) updates) => super.copyWith((message) => updates(message as GetAccountListRequest)) as GetAccountListRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountListRequest create() => GetAccountListRequest._();
  GetAccountListRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountListRequest> createRepeated() => $pb.PbList<GetAccountListRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountListRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountListRequest>(create);
  static GetAccountListRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $1.PaginationParams get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination($1.PaginationParams v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  $1.PaginationParams ensurePagination() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get accountIidOrExternalIdRegex => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountIidOrExternalIdRegex($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccountIidOrExternalIdRegex() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountIidOrExternalIdRegex() => clearField(3);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(3);
}

class GetAccountListResponse extends $pb.GeneratedMessage {
  factory GetAccountListResponse({
    $core.String? refExecutionId,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<$9.Account>? accounts,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (refExecutionId != null) {
      $result.refExecutionId = refExecutionId;
    }
    if (paginationInfo != null) {
      $result.paginationInfo = paginationInfo;
    }
    if (accounts != null) {
      $result.accounts.addAll(accounts);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  GetAccountListResponse._() : super();
  factory GetAccountListResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountListResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountListResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo', subBuilder: $1.PaginationInfo.create)
    ..pc<$9.Account>(3, _omitFieldNames ? '' : 'accounts', $pb.PbFieldType.PM, subBuilder: $9.Account.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'GetAccountListResponse.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountListResponse clone() => GetAccountListResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountListResponse copyWith(void Function(GetAccountListResponse) updates) => super.copyWith((message) => updates(message as GetAccountListResponse)) as GetAccountListResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountListResponse create() => GetAccountListResponse._();
  GetAccountListResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountListResponse> createRepeated() => $pb.PbList<GetAccountListResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountListResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountListResponse>(create);
  static GetAccountListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $1.PaginationInfo get paginationInfo => $_getN(1);
  @$pb.TagNumber(2)
  set paginationInfo($1.PaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaginationInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaginationInfo() => clearField(2);
  @$pb.TagNumber(2)
  $1.PaginationInfo ensurePaginationInfo() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.List<$9.Account> get accounts => $_getList(2);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(3);
}

class GetAccountInfoBatchRequest extends $pb.GeneratedMessage {
  factory GetAccountInfoBatchRequest({
    $core.String? proposedExecutionId,
    $core.Iterable<$core.String>? accountIids,
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (accountIids != null) {
      $result.accountIids.addAll(accountIids);
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  GetAccountInfoBatchRequest._() : super();
  factory GetAccountInfoBatchRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountInfoBatchRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountInfoBatchRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..pPS(2, _omitFieldNames ? '' : 'accountIids')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'GetAccountInfoBatchRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountInfoBatchRequest clone() => GetAccountInfoBatchRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountInfoBatchRequest copyWith(void Function(GetAccountInfoBatchRequest) updates) => super.copyWith((message) => updates(message as GetAccountInfoBatchRequest)) as GetAccountInfoBatchRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountInfoBatchRequest create() => GetAccountInfoBatchRequest._();
  GetAccountInfoBatchRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountInfoBatchRequest> createRepeated() => $pb.PbList<GetAccountInfoBatchRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountInfoBatchRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountInfoBatchRequest>(create);
  static GetAccountInfoBatchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get accountIids => $_getList(1);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(2);
}

class GetAccountInfoBatchResponse extends $pb.GeneratedMessage {
  factory GetAccountInfoBatchResponse({
    $core.String? refExecutionId,
    $core.Iterable<$9.Account>? accounts,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (refExecutionId != null) {
      $result.refExecutionId = refExecutionId;
    }
    if (accounts != null) {
      $result.accounts.addAll(accounts);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  GetAccountInfoBatchResponse._() : super();
  factory GetAccountInfoBatchResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountInfoBatchResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountInfoBatchResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..pc<$9.Account>(2, _omitFieldNames ? '' : 'accounts', $pb.PbFieldType.PM, subBuilder: $9.Account.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'GetAccountInfoBatchResponse.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountInfoBatchResponse clone() => GetAccountInfoBatchResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountInfoBatchResponse copyWith(void Function(GetAccountInfoBatchResponse) updates) => super.copyWith((message) => updates(message as GetAccountInfoBatchResponse)) as GetAccountInfoBatchResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountInfoBatchResponse create() => GetAccountInfoBatchResponse._();
  GetAccountInfoBatchResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountInfoBatchResponse> createRepeated() => $pb.PbList<GetAccountInfoBatchResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountInfoBatchResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountInfoBatchResponse>(create);
  static GetAccountInfoBatchResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$9.Account> get accounts => $_getList(1);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(2);
}

class NewAccountRequest extends $pb.GeneratedMessage {
  factory NewAccountRequest({
    $core.String? proposedExecutionId,
    $core.String? externalAccountId,
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (externalAccountId != null) {
      $result.externalAccountId = externalAccountId;
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  NewAccountRequest._() : super();
  factory NewAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NewAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NewAccountRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'externalAccountId')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'NewAccountRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NewAccountRequest clone() => NewAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NewAccountRequest copyWith(void Function(NewAccountRequest) updates) => super.copyWith((message) => updates(message as NewAccountRequest)) as NewAccountRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NewAccountRequest create() => NewAccountRequest._();
  NewAccountRequest createEmptyInstance() => create();
  static $pb.PbList<NewAccountRequest> createRepeated() => $pb.PbList<NewAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static NewAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NewAccountRequest>(create);
  static NewAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get externalAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set externalAccountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasExternalAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearExternalAccountId() => clearField(2);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(2);
}

class NewAccountResponse extends $pb.GeneratedMessage {
  factory NewAccountResponse({
    $core.String? refExecutionId,
    $core.String? agentAccountId,
    $1.DateTime? activationDt,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (refExecutionId != null) {
      $result.refExecutionId = refExecutionId;
    }
    if (agentAccountId != null) {
      $result.agentAccountId = agentAccountId;
    }
    if (activationDt != null) {
      $result.activationDt = activationDt;
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  NewAccountResponse._() : super();
  factory NewAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NewAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NewAccountResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'agentAccountId')
    ..aOM<$1.DateTime>(3, _omitFieldNames ? '' : 'activationDt', subBuilder: $1.DateTime.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'NewAccountResponse.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NewAccountResponse clone() => NewAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NewAccountResponse copyWith(void Function(NewAccountResponse) updates) => super.copyWith((message) => updates(message as NewAccountResponse)) as NewAccountResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NewAccountResponse create() => NewAccountResponse._();
  NewAccountResponse createEmptyInstance() => create();
  static $pb.PbList<NewAccountResponse> createRepeated() => $pb.PbList<NewAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static NewAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NewAccountResponse>(create);
  static NewAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get agentAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set agentAccountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAgentAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAgentAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $1.DateTime get activationDt => $_getN(2);
  @$pb.TagNumber(3)
  set activationDt($1.DateTime v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasActivationDt() => $_has(2);
  @$pb.TagNumber(3)
  void clearActivationDt() => clearField(3);
  @$pb.TagNumber(3)
  $1.DateTime ensureActivationDt() => $_ensure(2);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(3);
}

class ActivateVenueForAccountRequest extends $pb.GeneratedMessage {
  factory ActivateVenueForAccountRequest({
    $core.String? proposedExecutionId,
    $core.String? accountIid,
    $core.String? venueIid,
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (accountIid != null) {
      $result.accountIid = accountIid;
    }
    if (venueIid != null) {
      $result.venueIid = venueIid;
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  ActivateVenueForAccountRequest._() : super();
  factory ActivateVenueForAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ActivateVenueForAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ActivateVenueForAccountRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'accountIid')
    ..aOS(3, _omitFieldNames ? '' : 'venueIid')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'ActivateVenueForAccountRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ActivateVenueForAccountRequest clone() => ActivateVenueForAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ActivateVenueForAccountRequest copyWith(void Function(ActivateVenueForAccountRequest) updates) => super.copyWith((message) => updates(message as ActivateVenueForAccountRequest)) as ActivateVenueForAccountRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ActivateVenueForAccountRequest create() => ActivateVenueForAccountRequest._();
  ActivateVenueForAccountRequest createEmptyInstance() => create();
  static $pb.PbList<ActivateVenueForAccountRequest> createRepeated() => $pb.PbList<ActivateVenueForAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static ActivateVenueForAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ActivateVenueForAccountRequest>(create);
  static ActivateVenueForAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountIid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountIid() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get venueIid => $_getSZ(2);
  @$pb.TagNumber(3)
  set venueIid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVenueIid() => $_has(2);
  @$pb.TagNumber(3)
  void clearVenueIid() => clearField(3);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(3);
}

class ActivateVenueForAccountResponse extends $pb.GeneratedMessage {
  factory ActivateVenueForAccountResponse({
    $core.String? refExecutionId,
    $1.DateTime? activationDt,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (refExecutionId != null) {
      $result.refExecutionId = refExecutionId;
    }
    if (activationDt != null) {
      $result.activationDt = activationDt;
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  ActivateVenueForAccountResponse._() : super();
  factory ActivateVenueForAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ActivateVenueForAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ActivateVenueForAccountResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.DateTime>(2, _omitFieldNames ? '' : 'activationDt', subBuilder: $1.DateTime.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'ActivateVenueForAccountResponse.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ActivateVenueForAccountResponse clone() => ActivateVenueForAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ActivateVenueForAccountResponse copyWith(void Function(ActivateVenueForAccountResponse) updates) => super.copyWith((message) => updates(message as ActivateVenueForAccountResponse)) as ActivateVenueForAccountResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ActivateVenueForAccountResponse create() => ActivateVenueForAccountResponse._();
  ActivateVenueForAccountResponse createEmptyInstance() => create();
  static $pb.PbList<ActivateVenueForAccountResponse> createRepeated() => $pb.PbList<ActivateVenueForAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static ActivateVenueForAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ActivateVenueForAccountResponse>(create);
  static ActivateVenueForAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $1.DateTime get activationDt => $_getN(1);
  @$pb.TagNumber(2)
  set activationDt($1.DateTime v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasActivationDt() => $_has(1);
  @$pb.TagNumber(2)
  void clearActivationDt() => clearField(2);
  @$pb.TagNumber(2)
  $1.DateTime ensureActivationDt() => $_ensure(1);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(2);
}

class GetAccountInstrumentHoldingsRequest extends $pb.GeneratedMessage {
  factory GetAccountInstrumentHoldingsRequest({
    $core.String? proposedExecutionId,
    $core.String? accountIid,
    $core.String? venueIid,
    $core.Iterable<$core.String>? instrumentIids,
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (accountIid != null) {
      $result.accountIid = accountIid;
    }
    if (venueIid != null) {
      $result.venueIid = venueIid;
    }
    if (instrumentIids != null) {
      $result.instrumentIids.addAll(instrumentIids);
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  GetAccountInstrumentHoldingsRequest._() : super();
  factory GetAccountInstrumentHoldingsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountInstrumentHoldingsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountInstrumentHoldingsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'accountIid')
    ..aOS(3, _omitFieldNames ? '' : 'venueIid')
    ..pPS(4, _omitFieldNames ? '' : 'instrumentIids')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'GetAccountInstrumentHoldingsRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountInstrumentHoldingsRequest clone() => GetAccountInstrumentHoldingsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountInstrumentHoldingsRequest copyWith(void Function(GetAccountInstrumentHoldingsRequest) updates) => super.copyWith((message) => updates(message as GetAccountInstrumentHoldingsRequest)) as GetAccountInstrumentHoldingsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountInstrumentHoldingsRequest create() => GetAccountInstrumentHoldingsRequest._();
  GetAccountInstrumentHoldingsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountInstrumentHoldingsRequest> createRepeated() => $pb.PbList<GetAccountInstrumentHoldingsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountInstrumentHoldingsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountInstrumentHoldingsRequest>(create);
  static GetAccountInstrumentHoldingsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountIid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountIid() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get venueIid => $_getSZ(2);
  @$pb.TagNumber(3)
  set venueIid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVenueIid() => $_has(2);
  @$pb.TagNumber(3)
  void clearVenueIid() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.String> get instrumentIids => $_getList(3);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(4);
}

class GetAccountInstrumentHoldingsResponse extends $pb.GeneratedMessage {
  factory GetAccountInstrumentHoldingsResponse({
    $core.String? refExecutionId,
    $9.Portfolio? portfolio,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (refExecutionId != null) {
      $result.refExecutionId = refExecutionId;
    }
    if (portfolio != null) {
      $result.portfolio = portfolio;
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  GetAccountInstrumentHoldingsResponse._() : super();
  factory GetAccountInstrumentHoldingsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountInstrumentHoldingsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountInstrumentHoldingsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$9.Portfolio>(2, _omitFieldNames ? '' : 'portfolio', subBuilder: $9.Portfolio.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'GetAccountInstrumentHoldingsResponse.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountInstrumentHoldingsResponse clone() => GetAccountInstrumentHoldingsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountInstrumentHoldingsResponse copyWith(void Function(GetAccountInstrumentHoldingsResponse) updates) => super.copyWith((message) => updates(message as GetAccountInstrumentHoldingsResponse)) as GetAccountInstrumentHoldingsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountInstrumentHoldingsResponse create() => GetAccountInstrumentHoldingsResponse._();
  GetAccountInstrumentHoldingsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountInstrumentHoldingsResponse> createRepeated() => $pb.PbList<GetAccountInstrumentHoldingsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountInstrumentHoldingsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountInstrumentHoldingsResponse>(create);
  static GetAccountInstrumentHoldingsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $9.Portfolio get portfolio => $_getN(1);
  @$pb.TagNumber(2)
  set portfolio($9.Portfolio v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPortfolio() => $_has(1);
  @$pb.TagNumber(2)
  void clearPortfolio() => clearField(2);
  @$pb.TagNumber(2)
  $9.Portfolio ensurePortfolio() => $_ensure(1);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(2);
}

class GetAccountCashHoldingsRequest extends $pb.GeneratedMessage {
  factory GetAccountCashHoldingsRequest({
    $core.String? proposedExecutionId,
    $core.String? accountIid,
    $core.Iterable<$core.String>? currencyCodes,
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (accountIid != null) {
      $result.accountIid = accountIid;
    }
    if (currencyCodes != null) {
      $result.currencyCodes.addAll(currencyCodes);
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  GetAccountCashHoldingsRequest._() : super();
  factory GetAccountCashHoldingsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountCashHoldingsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountCashHoldingsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'accountIid')
    ..pPS(3, _omitFieldNames ? '' : 'currencyCodes')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'GetAccountCashHoldingsRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountCashHoldingsRequest clone() => GetAccountCashHoldingsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountCashHoldingsRequest copyWith(void Function(GetAccountCashHoldingsRequest) updates) => super.copyWith((message) => updates(message as GetAccountCashHoldingsRequest)) as GetAccountCashHoldingsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountCashHoldingsRequest create() => GetAccountCashHoldingsRequest._();
  GetAccountCashHoldingsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountCashHoldingsRequest> createRepeated() => $pb.PbList<GetAccountCashHoldingsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountCashHoldingsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountCashHoldingsRequest>(create);
  static GetAccountCashHoldingsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountIid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountIid() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get currencyCodes => $_getList(2);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(3);
}

class GetAccountCashHoldingsResponse extends $pb.GeneratedMessage {
  factory GetAccountCashHoldingsResponse({
    $core.String? refExecutionId,
    $9.Portfolio? cashPortfolio,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (refExecutionId != null) {
      $result.refExecutionId = refExecutionId;
    }
    if (cashPortfolio != null) {
      $result.cashPortfolio = cashPortfolio;
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  GetAccountCashHoldingsResponse._() : super();
  factory GetAccountCashHoldingsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountCashHoldingsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountCashHoldingsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$9.Portfolio>(2, _omitFieldNames ? '' : 'cashPortfolio', subBuilder: $9.Portfolio.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'GetAccountCashHoldingsResponse.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountCashHoldingsResponse clone() => GetAccountCashHoldingsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountCashHoldingsResponse copyWith(void Function(GetAccountCashHoldingsResponse) updates) => super.copyWith((message) => updates(message as GetAccountCashHoldingsResponse)) as GetAccountCashHoldingsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountCashHoldingsResponse create() => GetAccountCashHoldingsResponse._();
  GetAccountCashHoldingsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountCashHoldingsResponse> createRepeated() => $pb.PbList<GetAccountCashHoldingsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountCashHoldingsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountCashHoldingsResponse>(create);
  static GetAccountCashHoldingsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $9.Portfolio get cashPortfolio => $_getN(1);
  @$pb.TagNumber(2)
  set cashPortfolio($9.Portfolio v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCashPortfolio() => $_has(1);
  @$pb.TagNumber(2)
  void clearCashPortfolio() => clearField(2);
  @$pb.TagNumber(2)
  $9.Portfolio ensureCashPortfolio() => $_ensure(1);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(2);
}

class DepositCashRequest extends $pb.GeneratedMessage {
  factory DepositCashRequest({
    $core.String? proposedExecutionId,
    $core.String? accountIid,
    $core.String? currencyCode,
    $core.String? amount,
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (accountIid != null) {
      $result.accountIid = accountIid;
    }
    if (currencyCode != null) {
      $result.currencyCode = currencyCode;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  DepositCashRequest._() : super();
  factory DepositCashRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DepositCashRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DepositCashRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'accountIid')
    ..aOS(3, _omitFieldNames ? '' : 'currencyCode')
    ..aOS(4, _omitFieldNames ? '' : 'amount')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'DepositCashRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DepositCashRequest clone() => DepositCashRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DepositCashRequest copyWith(void Function(DepositCashRequest) updates) => super.copyWith((message) => updates(message as DepositCashRequest)) as DepositCashRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DepositCashRequest create() => DepositCashRequest._();
  DepositCashRequest createEmptyInstance() => create();
  static $pb.PbList<DepositCashRequest> createRepeated() => $pb.PbList<DepositCashRequest>();
  @$core.pragma('dart2js:noInline')
  static DepositCashRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DepositCashRequest>(create);
  static DepositCashRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountIid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountIid() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get currencyCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set currencyCode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrencyCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrencyCode() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get amount => $_getSZ(3);
  @$pb.TagNumber(4)
  set amount($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(4);
}

class DepositCashResponse extends $pb.GeneratedMessage {
  factory DepositCashResponse({
    $core.String? refExecutionId,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (refExecutionId != null) {
      $result.refExecutionId = refExecutionId;
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  DepositCashResponse._() : super();
  factory DepositCashResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DepositCashResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DepositCashResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'DepositCashResponse.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DepositCashResponse clone() => DepositCashResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DepositCashResponse copyWith(void Function(DepositCashResponse) updates) => super.copyWith((message) => updates(message as DepositCashResponse)) as DepositCashResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DepositCashResponse create() => DepositCashResponse._();
  DepositCashResponse createEmptyInstance() => create();
  static $pb.PbList<DepositCashResponse> createRepeated() => $pb.PbList<DepositCashResponse>();
  @$core.pragma('dart2js:noInline')
  static DepositCashResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DepositCashResponse>(create);
  static DepositCashResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => clearField(1);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(1);
}

class DepositInstrumentRequest extends $pb.GeneratedMessage {
  factory DepositInstrumentRequest({
    $core.String? proposedExecutionId,
    $core.String? accountIid,
    $core.String? instrumentIid,
    $core.String? units,
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (accountIid != null) {
      $result.accountIid = accountIid;
    }
    if (instrumentIid != null) {
      $result.instrumentIid = instrumentIid;
    }
    if (units != null) {
      $result.units = units;
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  DepositInstrumentRequest._() : super();
  factory DepositInstrumentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DepositInstrumentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DepositInstrumentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'accountIid')
    ..aOS(3, _omitFieldNames ? '' : 'instrumentIid')
    ..aOS(4, _omitFieldNames ? '' : 'units')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'DepositInstrumentRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DepositInstrumentRequest clone() => DepositInstrumentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DepositInstrumentRequest copyWith(void Function(DepositInstrumentRequest) updates) => super.copyWith((message) => updates(message as DepositInstrumentRequest)) as DepositInstrumentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DepositInstrumentRequest create() => DepositInstrumentRequest._();
  DepositInstrumentRequest createEmptyInstance() => create();
  static $pb.PbList<DepositInstrumentRequest> createRepeated() => $pb.PbList<DepositInstrumentRequest>();
  @$core.pragma('dart2js:noInline')
  static DepositInstrumentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DepositInstrumentRequest>(create);
  static DepositInstrumentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountIid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountIid() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get instrumentIid => $_getSZ(2);
  @$pb.TagNumber(3)
  set instrumentIid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasInstrumentIid() => $_has(2);
  @$pb.TagNumber(3)
  void clearInstrumentIid() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get units => $_getSZ(3);
  @$pb.TagNumber(4)
  set units($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUnits() => $_has(3);
  @$pb.TagNumber(4)
  void clearUnits() => clearField(4);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(4);
}

class DepositInstrumentResponse extends $pb.GeneratedMessage {
  factory DepositInstrumentResponse({
    $core.String? refExecutionId,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (refExecutionId != null) {
      $result.refExecutionId = refExecutionId;
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  DepositInstrumentResponse._() : super();
  factory DepositInstrumentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DepositInstrumentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DepositInstrumentResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'DepositInstrumentResponse.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DepositInstrumentResponse clone() => DepositInstrumentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DepositInstrumentResponse copyWith(void Function(DepositInstrumentResponse) updates) => super.copyWith((message) => updates(message as DepositInstrumentResponse)) as DepositInstrumentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DepositInstrumentResponse create() => DepositInstrumentResponse._();
  DepositInstrumentResponse createEmptyInstance() => create();
  static $pb.PbList<DepositInstrumentResponse> createRepeated() => $pb.PbList<DepositInstrumentResponse>();
  @$core.pragma('dart2js:noInline')
  static DepositInstrumentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DepositInstrumentResponse>(create);
  static DepositInstrumentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => clearField(1);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(1);
}

class WithdrawCashRequest extends $pb.GeneratedMessage {
  factory WithdrawCashRequest({
    $core.String? proposedExecutionId,
    $core.String? accountIid,
    $core.String? currencyCode,
    $core.String? amount,
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (accountIid != null) {
      $result.accountIid = accountIid;
    }
    if (currencyCode != null) {
      $result.currencyCode = currencyCode;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  WithdrawCashRequest._() : super();
  factory WithdrawCashRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WithdrawCashRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WithdrawCashRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'accountIid')
    ..aOS(3, _omitFieldNames ? '' : 'currencyCode')
    ..aOS(4, _omitFieldNames ? '' : 'amount')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'WithdrawCashRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WithdrawCashRequest clone() => WithdrawCashRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WithdrawCashRequest copyWith(void Function(WithdrawCashRequest) updates) => super.copyWith((message) => updates(message as WithdrawCashRequest)) as WithdrawCashRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawCashRequest create() => WithdrawCashRequest._();
  WithdrawCashRequest createEmptyInstance() => create();
  static $pb.PbList<WithdrawCashRequest> createRepeated() => $pb.PbList<WithdrawCashRequest>();
  @$core.pragma('dart2js:noInline')
  static WithdrawCashRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WithdrawCashRequest>(create);
  static WithdrawCashRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountIid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountIid() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get currencyCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set currencyCode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrencyCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrencyCode() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get amount => $_getSZ(3);
  @$pb.TagNumber(4)
  set amount($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(4);
}

class WithdrawCashResponse extends $pb.GeneratedMessage {
  factory WithdrawCashResponse({
    $core.String? refExecutionId,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (refExecutionId != null) {
      $result.refExecutionId = refExecutionId;
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  WithdrawCashResponse._() : super();
  factory WithdrawCashResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WithdrawCashResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WithdrawCashResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'WithdrawCashResponse.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WithdrawCashResponse clone() => WithdrawCashResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WithdrawCashResponse copyWith(void Function(WithdrawCashResponse) updates) => super.copyWith((message) => updates(message as WithdrawCashResponse)) as WithdrawCashResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawCashResponse create() => WithdrawCashResponse._();
  WithdrawCashResponse createEmptyInstance() => create();
  static $pb.PbList<WithdrawCashResponse> createRepeated() => $pb.PbList<WithdrawCashResponse>();
  @$core.pragma('dart2js:noInline')
  static WithdrawCashResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WithdrawCashResponse>(create);
  static WithdrawCashResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => clearField(1);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(1);
}

class WithdrawInstrumentRequest extends $pb.GeneratedMessage {
  factory WithdrawInstrumentRequest({
    $core.String? proposedExecutionId,
    $core.String? accountIid,
    $core.String? instrumentIid,
    $core.String? units,
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (accountIid != null) {
      $result.accountIid = accountIid;
    }
    if (instrumentIid != null) {
      $result.instrumentIid = instrumentIid;
    }
    if (units != null) {
      $result.units = units;
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  WithdrawInstrumentRequest._() : super();
  factory WithdrawInstrumentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WithdrawInstrumentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WithdrawInstrumentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'accountIid')
    ..aOS(3, _omitFieldNames ? '' : 'instrumentIid')
    ..aOS(4, _omitFieldNames ? '' : 'units')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'WithdrawInstrumentRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WithdrawInstrumentRequest clone() => WithdrawInstrumentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WithdrawInstrumentRequest copyWith(void Function(WithdrawInstrumentRequest) updates) => super.copyWith((message) => updates(message as WithdrawInstrumentRequest)) as WithdrawInstrumentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawInstrumentRequest create() => WithdrawInstrumentRequest._();
  WithdrawInstrumentRequest createEmptyInstance() => create();
  static $pb.PbList<WithdrawInstrumentRequest> createRepeated() => $pb.PbList<WithdrawInstrumentRequest>();
  @$core.pragma('dart2js:noInline')
  static WithdrawInstrumentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WithdrawInstrumentRequest>(create);
  static WithdrawInstrumentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountIid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountIid() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get instrumentIid => $_getSZ(2);
  @$pb.TagNumber(3)
  set instrumentIid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasInstrumentIid() => $_has(2);
  @$pb.TagNumber(3)
  void clearInstrumentIid() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get units => $_getSZ(3);
  @$pb.TagNumber(4)
  set units($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUnits() => $_has(3);
  @$pb.TagNumber(4)
  void clearUnits() => clearField(4);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(4);
}

class WithdrawInstrumentResponse extends $pb.GeneratedMessage {
  factory WithdrawInstrumentResponse({
    $core.String? refExecutionId,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (refExecutionId != null) {
      $result.refExecutionId = refExecutionId;
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  WithdrawInstrumentResponse._() : super();
  factory WithdrawInstrumentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WithdrawInstrumentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WithdrawInstrumentResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'WithdrawInstrumentResponse.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WithdrawInstrumentResponse clone() => WithdrawInstrumentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WithdrawInstrumentResponse copyWith(void Function(WithdrawInstrumentResponse) updates) => super.copyWith((message) => updates(message as WithdrawInstrumentResponse)) as WithdrawInstrumentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawInstrumentResponse create() => WithdrawInstrumentResponse._();
  WithdrawInstrumentResponse createEmptyInstance() => create();
  static $pb.PbList<WithdrawInstrumentResponse> createRepeated() => $pb.PbList<WithdrawInstrumentResponse>();
  @$core.pragma('dart2js:noInline')
  static WithdrawInstrumentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WithdrawInstrumentResponse>(create);
  static WithdrawInstrumentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => clearField(1);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(1);
}

class GetAccountOrdersRequest extends $pb.GeneratedMessage {
  factory GetAccountOrdersRequest({
    $core.String? proposedExecutionId,
    $core.String? accountIid,
    $core.Iterable<$core.String>? venueIdOrSymbolRegexes,
    $1.PaginationParams? pagination,
    $10.OrderQueryFilter? orderQueryFilter,
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (accountIid != null) {
      $result.accountIid = accountIid;
    }
    if (venueIdOrSymbolRegexes != null) {
      $result.venueIdOrSymbolRegexes.addAll(venueIdOrSymbolRegexes);
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    if (orderQueryFilter != null) {
      $result.orderQueryFilter = orderQueryFilter;
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  GetAccountOrdersRequest._() : super();
  factory GetAccountOrdersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountOrdersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountOrdersRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'accountIid')
    ..pPS(3, _omitFieldNames ? '' : 'venueIdOrSymbolRegexes')
    ..aOM<$1.PaginationParams>(4, _omitFieldNames ? '' : 'pagination', subBuilder: $1.PaginationParams.create)
    ..aOM<$10.OrderQueryFilter>(5, _omitFieldNames ? '' : 'orderQueryFilter', subBuilder: $10.OrderQueryFilter.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'GetAccountOrdersRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountOrdersRequest clone() => GetAccountOrdersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountOrdersRequest copyWith(void Function(GetAccountOrdersRequest) updates) => super.copyWith((message) => updates(message as GetAccountOrdersRequest)) as GetAccountOrdersRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountOrdersRequest create() => GetAccountOrdersRequest._();
  GetAccountOrdersRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountOrdersRequest> createRepeated() => $pb.PbList<GetAccountOrdersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountOrdersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountOrdersRequest>(create);
  static GetAccountOrdersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountIid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountIid() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get venueIdOrSymbolRegexes => $_getList(2);

  @$pb.TagNumber(4)
  $1.PaginationParams get pagination => $_getN(3);
  @$pb.TagNumber(4)
  set pagination($1.PaginationParams v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasPagination() => $_has(3);
  @$pb.TagNumber(4)
  void clearPagination() => clearField(4);
  @$pb.TagNumber(4)
  $1.PaginationParams ensurePagination() => $_ensure(3);

  @$pb.TagNumber(5)
  $10.OrderQueryFilter get orderQueryFilter => $_getN(4);
  @$pb.TagNumber(5)
  set orderQueryFilter($10.OrderQueryFilter v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasOrderQueryFilter() => $_has(4);
  @$pb.TagNumber(5)
  void clearOrderQueryFilter() => clearField(5);
  @$pb.TagNumber(5)
  $10.OrderQueryFilter ensureOrderQueryFilter() => $_ensure(4);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(5);
}

class GetAccountOrdersResponse extends $pb.GeneratedMessage {
  factory GetAccountOrdersResponse({
    $core.String? refExecutionId,
    $1.PaginationInfo? paginationInfo,
    $1.DateTime? generatedAtDt,
    $core.Iterable<$9.Order>? orders,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (refExecutionId != null) {
      $result.refExecutionId = refExecutionId;
    }
    if (paginationInfo != null) {
      $result.paginationInfo = paginationInfo;
    }
    if (generatedAtDt != null) {
      $result.generatedAtDt = generatedAtDt;
    }
    if (orders != null) {
      $result.orders.addAll(orders);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  GetAccountOrdersResponse._() : super();
  factory GetAccountOrdersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountOrdersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountOrdersResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo', subBuilder: $1.PaginationInfo.create)
    ..aOM<$1.DateTime>(3, _omitFieldNames ? '' : 'generatedAtDt', subBuilder: $1.DateTime.create)
    ..pc<$9.Order>(4, _omitFieldNames ? '' : 'orders', $pb.PbFieldType.PM, subBuilder: $9.Order.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'GetAccountOrdersResponse.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountOrdersResponse clone() => GetAccountOrdersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountOrdersResponse copyWith(void Function(GetAccountOrdersResponse) updates) => super.copyWith((message) => updates(message as GetAccountOrdersResponse)) as GetAccountOrdersResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountOrdersResponse create() => GetAccountOrdersResponse._();
  GetAccountOrdersResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountOrdersResponse> createRepeated() => $pb.PbList<GetAccountOrdersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountOrdersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountOrdersResponse>(create);
  static GetAccountOrdersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $1.PaginationInfo get paginationInfo => $_getN(1);
  @$pb.TagNumber(2)
  set paginationInfo($1.PaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaginationInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaginationInfo() => clearField(2);
  @$pb.TagNumber(2)
  $1.PaginationInfo ensurePaginationInfo() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.DateTime get generatedAtDt => $_getN(2);
  @$pb.TagNumber(3)
  set generatedAtDt($1.DateTime v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasGeneratedAtDt() => $_has(2);
  @$pb.TagNumber(3)
  void clearGeneratedAtDt() => clearField(3);
  @$pb.TagNumber(3)
  $1.DateTime ensureGeneratedAtDt() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.List<$9.Order> get orders => $_getList(3);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(4);
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
    $9.OrderSide? side,
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (accountIid != null) {
      $result.accountIid = accountIid;
    }
    if (marketIdOrNameRegexes != null) {
      $result.marketIdOrNameRegexes.addAll(marketIdOrNameRegexes);
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    if (fromDt != null) {
      $result.fromDt = fromDt;
    }
    if (toDt != null) {
      $result.toDt = toDt;
    }
    if (instrumentIdOrSymbolRegexes != null) {
      $result.instrumentIdOrSymbolRegexes.addAll(instrumentIdOrSymbolRegexes);
    }
    if (side != null) {
      $result.side = side;
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  GetAccountTradesRequest._() : super();
  factory GetAccountTradesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountTradesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountTradesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'accountIid')
    ..pPS(3, _omitFieldNames ? '' : 'marketIdOrNameRegexes')
    ..aOM<$1.PaginationParams>(4, _omitFieldNames ? '' : 'pagination', subBuilder: $1.PaginationParams.create)
    ..aOM<$1.DateTime>(5, _omitFieldNames ? '' : 'fromDt', subBuilder: $1.DateTime.create)
    ..aOM<$1.DateTime>(6, _omitFieldNames ? '' : 'toDt', subBuilder: $1.DateTime.create)
    ..pPS(7, _omitFieldNames ? '' : 'instrumentIdOrSymbolRegexes')
    ..e<$9.OrderSide>(8, _omitFieldNames ? '' : 'side', $pb.PbFieldType.OE, defaultOrMaker: $9.OrderSide.ORDER_SIDE__UNKNOWN, valueOf: $9.OrderSide.valueOf, enumValues: $9.OrderSide.values)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'GetAccountTradesRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountTradesRequest clone() => GetAccountTradesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountTradesRequest copyWith(void Function(GetAccountTradesRequest) updates) => super.copyWith((message) => updates(message as GetAccountTradesRequest)) as GetAccountTradesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountTradesRequest create() => GetAccountTradesRequest._();
  GetAccountTradesRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountTradesRequest> createRepeated() => $pb.PbList<GetAccountTradesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountTradesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountTradesRequest>(create);
  static GetAccountTradesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountIid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountIid() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get marketIdOrNameRegexes => $_getList(2);

  @$pb.TagNumber(4)
  $1.PaginationParams get pagination => $_getN(3);
  @$pb.TagNumber(4)
  set pagination($1.PaginationParams v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasPagination() => $_has(3);
  @$pb.TagNumber(4)
  void clearPagination() => clearField(4);
  @$pb.TagNumber(4)
  $1.PaginationParams ensurePagination() => $_ensure(3);

  @$pb.TagNumber(5)
  $1.DateTime get fromDt => $_getN(4);
  @$pb.TagNumber(5)
  set fromDt($1.DateTime v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasFromDt() => $_has(4);
  @$pb.TagNumber(5)
  void clearFromDt() => clearField(5);
  @$pb.TagNumber(5)
  $1.DateTime ensureFromDt() => $_ensure(4);

  @$pb.TagNumber(6)
  $1.DateTime get toDt => $_getN(5);
  @$pb.TagNumber(6)
  set toDt($1.DateTime v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasToDt() => $_has(5);
  @$pb.TagNumber(6)
  void clearToDt() => clearField(6);
  @$pb.TagNumber(6)
  $1.DateTime ensureToDt() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.List<$core.String> get instrumentIdOrSymbolRegexes => $_getList(6);

  @$pb.TagNumber(8)
  $9.OrderSide get side => $_getN(7);
  @$pb.TagNumber(8)
  set side($9.OrderSide v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasSide() => $_has(7);
  @$pb.TagNumber(8)
  void clearSide() => clearField(8);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(8);
}

class GetAccountTradesResponse extends $pb.GeneratedMessage {
  factory GetAccountTradesResponse({
    $core.String? refExecutionId,
    $1.PaginationInfo? paginationInfo,
    $1.DateTime? generatedAtDt,
    $core.Iterable<$9.Trade>? trades,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (refExecutionId != null) {
      $result.refExecutionId = refExecutionId;
    }
    if (paginationInfo != null) {
      $result.paginationInfo = paginationInfo;
    }
    if (generatedAtDt != null) {
      $result.generatedAtDt = generatedAtDt;
    }
    if (trades != null) {
      $result.trades.addAll(trades);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  GetAccountTradesResponse._() : super();
  factory GetAccountTradesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountTradesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountTradesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo', subBuilder: $1.PaginationInfo.create)
    ..aOM<$1.DateTime>(3, _omitFieldNames ? '' : 'generatedAtDt', subBuilder: $1.DateTime.create)
    ..pc<$9.Trade>(4, _omitFieldNames ? '' : 'trades', $pb.PbFieldType.PM, subBuilder: $9.Trade.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'GetAccountTradesResponse.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountTradesResponse clone() => GetAccountTradesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountTradesResponse copyWith(void Function(GetAccountTradesResponse) updates) => super.copyWith((message) => updates(message as GetAccountTradesResponse)) as GetAccountTradesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountTradesResponse create() => GetAccountTradesResponse._();
  GetAccountTradesResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountTradesResponse> createRepeated() => $pb.PbList<GetAccountTradesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountTradesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountTradesResponse>(create);
  static GetAccountTradesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $1.PaginationInfo get paginationInfo => $_getN(1);
  @$pb.TagNumber(2)
  set paginationInfo($1.PaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaginationInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaginationInfo() => clearField(2);
  @$pb.TagNumber(2)
  $1.PaginationInfo ensurePaginationInfo() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.DateTime get generatedAtDt => $_getN(2);
  @$pb.TagNumber(3)
  set generatedAtDt($1.DateTime v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasGeneratedAtDt() => $_has(2);
  @$pb.TagNumber(3)
  void clearGeneratedAtDt() => clearField(3);
  @$pb.TagNumber(3)
  $1.DateTime ensureGeneratedAtDt() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.List<$9.Trade> get trades => $_getList(3);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(4);
}

class GetAccountSettlementsRequest extends $pb.GeneratedMessage {
  factory GetAccountSettlementsRequest({
    $core.String? proposedExecutionId,
    $core.String? accountIid,
    $core.Iterable<$core.String>? marketIdOrNameRegexes,
    $1.PaginationParams? pagination,
    $1.DateTime? fromDt,
    $1.DateTime? toDt,
    $9.ConfirmationStatus? status,
    $core.Iterable<$core.String>? assetIdOrNameRegexes,
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (accountIid != null) {
      $result.accountIid = accountIid;
    }
    if (marketIdOrNameRegexes != null) {
      $result.marketIdOrNameRegexes.addAll(marketIdOrNameRegexes);
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    if (fromDt != null) {
      $result.fromDt = fromDt;
    }
    if (toDt != null) {
      $result.toDt = toDt;
    }
    if (status != null) {
      $result.status = status;
    }
    if (assetIdOrNameRegexes != null) {
      $result.assetIdOrNameRegexes.addAll(assetIdOrNameRegexes);
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  GetAccountSettlementsRequest._() : super();
  factory GetAccountSettlementsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountSettlementsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountSettlementsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'accountIid')
    ..pPS(3, _omitFieldNames ? '' : 'marketIdOrNameRegexes')
    ..aOM<$1.PaginationParams>(4, _omitFieldNames ? '' : 'pagination', subBuilder: $1.PaginationParams.create)
    ..aOM<$1.DateTime>(5, _omitFieldNames ? '' : 'fromDt', subBuilder: $1.DateTime.create)
    ..aOM<$1.DateTime>(6, _omitFieldNames ? '' : 'toDt', subBuilder: $1.DateTime.create)
    ..e<$9.ConfirmationStatus>(7, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: $9.ConfirmationStatus.CONFIRMATION_STATUS__UNKNOWN, valueOf: $9.ConfirmationStatus.valueOf, enumValues: $9.ConfirmationStatus.values)
    ..pPS(8, _omitFieldNames ? '' : 'assetIdOrNameRegexes')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'GetAccountSettlementsRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountSettlementsRequest clone() => GetAccountSettlementsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountSettlementsRequest copyWith(void Function(GetAccountSettlementsRequest) updates) => super.copyWith((message) => updates(message as GetAccountSettlementsRequest)) as GetAccountSettlementsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountSettlementsRequest create() => GetAccountSettlementsRequest._();
  GetAccountSettlementsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountSettlementsRequest> createRepeated() => $pb.PbList<GetAccountSettlementsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountSettlementsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountSettlementsRequest>(create);
  static GetAccountSettlementsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountIid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountIid() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get marketIdOrNameRegexes => $_getList(2);

  @$pb.TagNumber(4)
  $1.PaginationParams get pagination => $_getN(3);
  @$pb.TagNumber(4)
  set pagination($1.PaginationParams v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasPagination() => $_has(3);
  @$pb.TagNumber(4)
  void clearPagination() => clearField(4);
  @$pb.TagNumber(4)
  $1.PaginationParams ensurePagination() => $_ensure(3);

  @$pb.TagNumber(5)
  $1.DateTime get fromDt => $_getN(4);
  @$pb.TagNumber(5)
  set fromDt($1.DateTime v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasFromDt() => $_has(4);
  @$pb.TagNumber(5)
  void clearFromDt() => clearField(5);
  @$pb.TagNumber(5)
  $1.DateTime ensureFromDt() => $_ensure(4);

  @$pb.TagNumber(6)
  $1.DateTime get toDt => $_getN(5);
  @$pb.TagNumber(6)
  set toDt($1.DateTime v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasToDt() => $_has(5);
  @$pb.TagNumber(6)
  void clearToDt() => clearField(6);
  @$pb.TagNumber(6)
  $1.DateTime ensureToDt() => $_ensure(5);

  @$pb.TagNumber(7)
  $9.ConfirmationStatus get status => $_getN(6);
  @$pb.TagNumber(7)
  set status($9.ConfirmationStatus v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<$core.String> get assetIdOrNameRegexes => $_getList(7);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(8);
}

class GetAccountSettlementsResponse extends $pb.GeneratedMessage {
  factory GetAccountSettlementsResponse({
    $core.String? refExecutionId,
    $1.PaginationInfo? paginationInfo,
    $1.DateTime? generatedAtDt,
    $core.Iterable<$9.Settlement>? settlements,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (refExecutionId != null) {
      $result.refExecutionId = refExecutionId;
    }
    if (paginationInfo != null) {
      $result.paginationInfo = paginationInfo;
    }
    if (generatedAtDt != null) {
      $result.generatedAtDt = generatedAtDt;
    }
    if (settlements != null) {
      $result.settlements.addAll(settlements);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  GetAccountSettlementsResponse._() : super();
  factory GetAccountSettlementsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountSettlementsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountSettlementsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo', subBuilder: $1.PaginationInfo.create)
    ..aOM<$1.DateTime>(3, _omitFieldNames ? '' : 'generatedAtDt', subBuilder: $1.DateTime.create)
    ..pc<$9.Settlement>(4, _omitFieldNames ? '' : 'settlements', $pb.PbFieldType.PM, subBuilder: $9.Settlement.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'GetAccountSettlementsResponse.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountSettlementsResponse clone() => GetAccountSettlementsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountSettlementsResponse copyWith(void Function(GetAccountSettlementsResponse) updates) => super.copyWith((message) => updates(message as GetAccountSettlementsResponse)) as GetAccountSettlementsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountSettlementsResponse create() => GetAccountSettlementsResponse._();
  GetAccountSettlementsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountSettlementsResponse> createRepeated() => $pb.PbList<GetAccountSettlementsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountSettlementsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountSettlementsResponse>(create);
  static GetAccountSettlementsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $1.PaginationInfo get paginationInfo => $_getN(1);
  @$pb.TagNumber(2)
  set paginationInfo($1.PaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaginationInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaginationInfo() => clearField(2);
  @$pb.TagNumber(2)
  $1.PaginationInfo ensurePaginationInfo() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.DateTime get generatedAtDt => $_getN(2);
  @$pb.TagNumber(3)
  set generatedAtDt($1.DateTime v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasGeneratedAtDt() => $_has(2);
  @$pb.TagNumber(3)
  void clearGeneratedAtDt() => clearField(3);
  @$pb.TagNumber(3)
  $1.DateTime ensureGeneratedAtDt() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.List<$9.Settlement> get settlements => $_getList(3);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(4);
}

class GetAccountTransactionsRequest extends $pb.GeneratedMessage {
  factory GetAccountTransactionsRequest({
    $core.String? proposedExecutionId,
    $core.String? accountIid,
    $1.PaginationParams? pagination,
    $1.DateTime? fromDt,
    $1.DateTime? toDt,
    $core.Iterable<$9.TransactionTypeEnum>? transactionTypes,
    $core.Iterable<$core.String>? assetIdOrNameRegexes,
    $core.Map<$core.String, $core.String>? auxData,
  }) {
    final $result = create();
    if (proposedExecutionId != null) {
      $result.proposedExecutionId = proposedExecutionId;
    }
    if (accountIid != null) {
      $result.accountIid = accountIid;
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    if (fromDt != null) {
      $result.fromDt = fromDt;
    }
    if (toDt != null) {
      $result.toDt = toDt;
    }
    if (transactionTypes != null) {
      $result.transactionTypes.addAll(transactionTypes);
    }
    if (assetIdOrNameRegexes != null) {
      $result.assetIdOrNameRegexes.addAll(assetIdOrNameRegexes);
    }
    if (auxData != null) {
      $result.auxData.addAll(auxData);
    }
    return $result;
  }
  GetAccountTransactionsRequest._() : super();
  factory GetAccountTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountTransactionsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proposedExecutionId')
    ..aOS(2, _omitFieldNames ? '' : 'accountIid')
    ..aOM<$1.PaginationParams>(3, _omitFieldNames ? '' : 'pagination', subBuilder: $1.PaginationParams.create)
    ..aOM<$1.DateTime>(4, _omitFieldNames ? '' : 'fromDt', subBuilder: $1.DateTime.create)
    ..aOM<$1.DateTime>(5, _omitFieldNames ? '' : 'toDt', subBuilder: $1.DateTime.create)
    ..pc<$9.TransactionTypeEnum>(6, _omitFieldNames ? '' : 'transactionTypes', $pb.PbFieldType.KE, valueOf: $9.TransactionTypeEnum.valueOf, enumValues: $9.TransactionTypeEnum.values, defaultEnumValue: $9.TransactionTypeEnum.TRANSACTION_TYPE_ENUM__UNKNOWN)
    ..pPS(7, _omitFieldNames ? '' : 'assetIdOrNameRegexes')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'auxData', entryClassName: 'GetAccountTransactionsRequest.AuxDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountTransactionsRequest clone() => GetAccountTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountTransactionsRequest copyWith(void Function(GetAccountTransactionsRequest) updates) => super.copyWith((message) => updates(message as GetAccountTransactionsRequest)) as GetAccountTransactionsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountTransactionsRequest create() => GetAccountTransactionsRequest._();
  GetAccountTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountTransactionsRequest> createRepeated() => $pb.PbList<GetAccountTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountTransactionsRequest>(create);
  static GetAccountTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get proposedExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set proposedExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProposedExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountIid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountIid() => clearField(2);

  @$pb.TagNumber(3)
  $1.PaginationParams get pagination => $_getN(2);
  @$pb.TagNumber(3)
  set pagination($1.PaginationParams v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPagination() => $_has(2);
  @$pb.TagNumber(3)
  void clearPagination() => clearField(3);
  @$pb.TagNumber(3)
  $1.PaginationParams ensurePagination() => $_ensure(2);

  @$pb.TagNumber(4)
  $1.DateTime get fromDt => $_getN(3);
  @$pb.TagNumber(4)
  set fromDt($1.DateTime v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasFromDt() => $_has(3);
  @$pb.TagNumber(4)
  void clearFromDt() => clearField(4);
  @$pb.TagNumber(4)
  $1.DateTime ensureFromDt() => $_ensure(3);

  @$pb.TagNumber(5)
  $1.DateTime get toDt => $_getN(4);
  @$pb.TagNumber(5)
  set toDt($1.DateTime v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasToDt() => $_has(4);
  @$pb.TagNumber(5)
  void clearToDt() => clearField(5);
  @$pb.TagNumber(5)
  $1.DateTime ensureToDt() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.List<$9.TransactionTypeEnum> get transactionTypes => $_getList(5);

  @$pb.TagNumber(7)
  $core.List<$core.String> get assetIdOrNameRegexes => $_getList(6);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get auxData => $_getMap(7);
}

class GetAccountTransactionsResponse extends $pb.GeneratedMessage {
  factory GetAccountTransactionsResponse({
    $core.String? refExecutionId,
    $1.PaginationInfo? paginationInfo,
    $1.DateTime? generatedAtDt,
    $core.Iterable<$9.Transaction>? transactions,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (refExecutionId != null) {
      $result.refExecutionId = refExecutionId;
    }
    if (paginationInfo != null) {
      $result.paginationInfo = paginationInfo;
    }
    if (generatedAtDt != null) {
      $result.generatedAtDt = generatedAtDt;
    }
    if (transactions != null) {
      $result.transactions.addAll(transactions);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  GetAccountTransactionsResponse._() : super();
  factory GetAccountTransactionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountTransactionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountTransactionsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refExecutionId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo', subBuilder: $1.PaginationInfo.create)
    ..aOM<$1.DateTime>(3, _omitFieldNames ? '' : 'generatedAtDt', subBuilder: $1.DateTime.create)
    ..pc<$9.Transaction>(4, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: $9.Transaction.create)
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'GetAccountTransactionsResponse.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountTransactionsResponse clone() => GetAccountTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountTransactionsResponse copyWith(void Function(GetAccountTransactionsResponse) updates) => super.copyWith((message) => updates(message as GetAccountTransactionsResponse)) as GetAccountTransactionsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountTransactionsResponse create() => GetAccountTransactionsResponse._();
  GetAccountTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountTransactionsResponse> createRepeated() => $pb.PbList<GetAccountTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountTransactionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountTransactionsResponse>(create);
  static GetAccountTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refExecutionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refExecutionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefExecutionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefExecutionId() => clearField(1);

  @$pb.TagNumber(2)
  $1.PaginationInfo get paginationInfo => $_getN(1);
  @$pb.TagNumber(2)
  set paginationInfo($1.PaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaginationInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaginationInfo() => clearField(2);
  @$pb.TagNumber(2)
  $1.PaginationInfo ensurePaginationInfo() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.DateTime get generatedAtDt => $_getN(2);
  @$pb.TagNumber(3)
  set generatedAtDt($1.DateTime v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasGeneratedAtDt() => $_has(2);
  @$pb.TagNumber(3)
  void clearGeneratedAtDt() => clearField(3);
  @$pb.TagNumber(3)
  $1.DateTime ensureGeneratedAtDt() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.List<$9.Transaction> get transactions => $_getList(3);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(4);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
