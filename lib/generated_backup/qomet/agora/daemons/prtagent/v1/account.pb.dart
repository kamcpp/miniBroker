// This is a generated file - do not edit.
//
// Generated from qomet/agora/daemons/prtagent/v1/account.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'account.pbenum.dart';
import 'common.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'account.pbenum.dart';

class Account extends $pb.GeneratedMessage {
  factory Account({
    $core.String? id,
    $core.String? externalId,
    $core.String? metadata,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (externalId != null) result.externalId = externalId;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  Account._();

  factory Account.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Account.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Account',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'externalId')
    ..aOS(3, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Account clone() => Account()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Account copyWith(void Function(Account) updates) =>
      super.copyWith((message) => updates(message as Account)) as Account;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Account create() => Account._();
  @$core.override
  Account createEmptyInstance() => create();
  static $pb.PbList<Account> createRepeated() => $pb.PbList<Account>();
  @$core.pragma('dart2js:noInline')
  static Account getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Account>(create);
  static Account? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get externalId => $_getSZ(1);
  @$pb.TagNumber(2)
  set externalId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasExternalId() => $_has(1);
  @$pb.TagNumber(2)
  void clearExternalId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get metadata => $_getSZ(2);
  @$pb.TagNumber(3)
  set metadata($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMetadata() => $_has(2);
  @$pb.TagNumber(3)
  void clearMetadata() => $_clearField(3);
}

class NewAccountRequest extends $pb.GeneratedMessage {
  factory NewAccountRequest({
    $core.String? refRequestId,
    $core.String? externalAccountId,
    $core.String? auxData,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (externalAccountId != null) result.externalAccountId = externalAccountId;
    if (auxData != null) result.auxData = auxData;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'externalAccountId')
    ..aOS(3, _omitFieldNames ? '' : 'auxData')
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get externalAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set externalAccountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasExternalAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearExternalAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get auxData => $_getSZ(2);
  @$pb.TagNumber(3)
  set auxData($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAuxData() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuxData() => $_clearField(3);
}

class NewAccountResponse extends $pb.GeneratedMessage {
  factory NewAccountResponse({
    $core.String? refRequestId,
    $core.String? newAccountId,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (newAccountId != null) result.newAccountId = newAccountId;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'newAccountId')
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get newAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set newAccountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewAccountId() => $_clearField(2);
}

class GetAccountInfoRequest extends $pb.GeneratedMessage {
  factory GetAccountInfoRequest({
    $core.String? refRequestId,
    $core.String? accountId,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (accountId != null) result.accountId = accountId;
    return result;
  }

  GetAccountInfoRequest._();

  factory GetAccountInfoRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountInfoRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountInfoRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountInfoRequest clone() =>
      GetAccountInfoRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountInfoRequest copyWith(
          void Function(GetAccountInfoRequest) updates) =>
      super.copyWith((message) => updates(message as GetAccountInfoRequest))
          as GetAccountInfoRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountInfoRequest create() => GetAccountInfoRequest._();
  @$core.override
  GetAccountInfoRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountInfoRequest> createRepeated() =>
      $pb.PbList<GetAccountInfoRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountInfoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAccountInfoRequest>(create);
  static GetAccountInfoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => $_clearField(2);
}

class GetAccountInfoResponse extends $pb.GeneratedMessage {
  factory GetAccountInfoResponse({
    $core.String? refRequestId,
    Account? account,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (account != null) result.account = account;
    return result;
  }

  GetAccountInfoResponse._();

  factory GetAccountInfoResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountInfoResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountInfoResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<Account>(2, _omitFieldNames ? '' : 'account',
        subBuilder: Account.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountInfoResponse clone() =>
      GetAccountInfoResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountInfoResponse copyWith(
          void Function(GetAccountInfoResponse) updates) =>
      super.copyWith((message) => updates(message as GetAccountInfoResponse))
          as GetAccountInfoResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountInfoResponse create() => GetAccountInfoResponse._();
  @$core.override
  GetAccountInfoResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountInfoResponse> createRepeated() =>
      $pb.PbList<GetAccountInfoResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountInfoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAccountInfoResponse>(create);
  static GetAccountInfoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  Account get account => $_getN(1);
  @$pb.TagNumber(2)
  set account(Account value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasAccount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccount() => $_clearField(2);
  @$pb.TagNumber(2)
  Account ensureAccount() => $_ensure(1);
}

class GetAccountListRequest extends $pb.GeneratedMessage {
  factory GetAccountListRequest({
    $core.String? refRequestId,
    $1.PaginationParams? pagination,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (pagination != null) result.pagination = pagination;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.PaginationParams>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

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
}

class GetAccountListResponse extends $pb.GeneratedMessage {
  factory GetAccountListResponse({
    $core.String? refRequestId,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<Account>? accounts,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (accounts != null) result.accounts.addAll(accounts);
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<Account>(3, _omitFieldNames ? '' : 'accounts', $pb.PbFieldType.PM,
        subBuilder: Account.create)
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

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
  $pb.PbList<Account> get accounts => $_getList(2);
}

class EnableMarketForAccountRequest extends $pb.GeneratedMessage {
  factory EnableMarketForAccountRequest({
    $core.String? refRequestId,
    $core.String? accountId,
    $core.String? marketId,
    $core.String? auxData,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (accountId != null) result.accountId = accountId;
    if (marketId != null) result.marketId = marketId;
    if (auxData != null) result.auxData = auxData;
    return result;
  }

  EnableMarketForAccountRequest._();

  factory EnableMarketForAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EnableMarketForAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EnableMarketForAccountRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..aOS(3, _omitFieldNames ? '' : 'marketId')
    ..aOS(4, _omitFieldNames ? '' : 'auxData')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EnableMarketForAccountRequest clone() =>
      EnableMarketForAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EnableMarketForAccountRequest copyWith(
          void Function(EnableMarketForAccountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as EnableMarketForAccountRequest))
          as EnableMarketForAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EnableMarketForAccountRequest create() =>
      EnableMarketForAccountRequest._();
  @$core.override
  EnableMarketForAccountRequest createEmptyInstance() => create();
  static $pb.PbList<EnableMarketForAccountRequest> createRepeated() =>
      $pb.PbList<EnableMarketForAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static EnableMarketForAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EnableMarketForAccountRequest>(create);
  static EnableMarketForAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get marketId => $_getSZ(2);
  @$pb.TagNumber(3)
  set marketId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMarketId() => $_has(2);
  @$pb.TagNumber(3)
  void clearMarketId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get auxData => $_getSZ(3);
  @$pb.TagNumber(4)
  set auxData($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAuxData() => $_has(3);
  @$pb.TagNumber(4)
  void clearAuxData() => $_clearField(4);
}

class EnableMarketForAccountResponse extends $pb.GeneratedMessage {
  factory EnableMarketForAccountResponse({
    $core.String? refRequestId,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    return result;
  }

  EnableMarketForAccountResponse._();

  factory EnableMarketForAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EnableMarketForAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EnableMarketForAccountResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EnableMarketForAccountResponse clone() =>
      EnableMarketForAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EnableMarketForAccountResponse copyWith(
          void Function(EnableMarketForAccountResponse) updates) =>
      super.copyWith(
              (message) => updates(message as EnableMarketForAccountResponse))
          as EnableMarketForAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EnableMarketForAccountResponse create() =>
      EnableMarketForAccountResponse._();
  @$core.override
  EnableMarketForAccountResponse createEmptyInstance() => create();
  static $pb.PbList<EnableMarketForAccountResponse> createRepeated() =>
      $pb.PbList<EnableMarketForAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static EnableMarketForAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EnableMarketForAccountResponse>(create);
  static EnableMarketForAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);
}

class AssetHoldings extends $pb.GeneratedMessage {
  factory AssetHoldings({
    $core.Iterable<$core.MapEntry<$core.String, $fixnum.Int64>>? balances,
  }) {
    final result = create();
    if (balances != null) result.balances.addEntries(balances);
    return result;
  }

  AssetHoldings._();

  factory AssetHoldings.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AssetHoldings.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AssetHoldings',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..m<$core.String, $fixnum.Int64>(1, _omitFieldNames ? '' : 'balances',
        entryClassName: 'AssetHoldings.BalancesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.O6,
        packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AssetHoldings clone() => AssetHoldings()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AssetHoldings copyWith(void Function(AssetHoldings) updates) =>
      super.copyWith((message) => updates(message as AssetHoldings))
          as AssetHoldings;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AssetHoldings create() => AssetHoldings._();
  @$core.override
  AssetHoldings createEmptyInstance() => create();
  static $pb.PbList<AssetHoldings> createRepeated() =>
      $pb.PbList<AssetHoldings>();
  @$core.pragma('dart2js:noInline')
  static AssetHoldings getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AssetHoldings>(create);
  static AssetHoldings? _defaultInstance;

  /// asset-id > balance
  @$pb.TagNumber(1)
  $pb.PbMap<$core.String, $fixnum.Int64> get balances => $_getMap(0);
}

class GetAccountMarketPortfolioRequest extends $pb.GeneratedMessage {
  factory GetAccountMarketPortfolioRequest({
    $core.String? refRequestId,
    $core.String? accountId,
    $core.String? marketId,
    $core.Iterable<$core.String>? assetIds,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (accountId != null) result.accountId = accountId;
    if (marketId != null) result.marketId = marketId;
    if (assetIds != null) result.assetIds.addAll(assetIds);
    return result;
  }

  GetAccountMarketPortfolioRequest._();

  factory GetAccountMarketPortfolioRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountMarketPortfolioRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountMarketPortfolioRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..aOS(3, _omitFieldNames ? '' : 'marketId')
    ..pPS(4, _omitFieldNames ? '' : 'assetIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountMarketPortfolioRequest clone() =>
      GetAccountMarketPortfolioRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountMarketPortfolioRequest copyWith(
          void Function(GetAccountMarketPortfolioRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetAccountMarketPortfolioRequest))
          as GetAccountMarketPortfolioRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountMarketPortfolioRequest create() =>
      GetAccountMarketPortfolioRequest._();
  @$core.override
  GetAccountMarketPortfolioRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountMarketPortfolioRequest> createRepeated() =>
      $pb.PbList<GetAccountMarketPortfolioRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountMarketPortfolioRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAccountMarketPortfolioRequest>(
          create);
  static GetAccountMarketPortfolioRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get marketId => $_getSZ(2);
  @$pb.TagNumber(3)
  set marketId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMarketId() => $_has(2);
  @$pb.TagNumber(3)
  void clearMarketId() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get assetIds => $_getList(3);
}

class GetAccountMarketPortfolioResponse extends $pb.GeneratedMessage {
  factory GetAccountMarketPortfolioResponse({
    $core.String? refRequestId,
    $1.Time? createdAt,
    AssetHoldings? portfolio,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (createdAt != null) result.createdAt = createdAt;
    if (portfolio != null) result.portfolio = portfolio;
    return result;
  }

  GetAccountMarketPortfolioResponse._();

  factory GetAccountMarketPortfolioResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAccountMarketPortfolioResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAccountMarketPortfolioResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.Time>(2, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Time.create)
    ..aOM<AssetHoldings>(3, _omitFieldNames ? '' : 'portfolio',
        subBuilder: AssetHoldings.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountMarketPortfolioResponse clone() =>
      GetAccountMarketPortfolioResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAccountMarketPortfolioResponse copyWith(
          void Function(GetAccountMarketPortfolioResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetAccountMarketPortfolioResponse))
          as GetAccountMarketPortfolioResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountMarketPortfolioResponse create() =>
      GetAccountMarketPortfolioResponse._();
  @$core.override
  GetAccountMarketPortfolioResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountMarketPortfolioResponse> createRepeated() =>
      $pb.PbList<GetAccountMarketPortfolioResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountMarketPortfolioResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAccountMarketPortfolioResponse>(
          create);
  static GetAccountMarketPortfolioResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.Time get createdAt => $_getN(1);
  @$pb.TagNumber(2)
  set createdAt($1.Time value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCreatedAt() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreatedAt() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Time ensureCreatedAt() => $_ensure(1);

  @$pb.TagNumber(3)
  AssetHoldings get portfolio => $_getN(2);
  @$pb.TagNumber(3)
  set portfolio(AssetHoldings value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPortfolio() => $_has(2);
  @$pb.TagNumber(3)
  void clearPortfolio() => $_clearField(3);
  @$pb.TagNumber(3)
  AssetHoldings ensurePortfolio() => $_ensure(2);
}

class GetAccountCashHoldingsRequest extends $pb.GeneratedMessage {
  factory GetAccountCashHoldingsRequest({
    $core.String? refRequestId,
    $core.String? accountId,
    $core.Iterable<$core.String>? cashAssetIds,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (accountId != null) result.accountId = accountId;
    if (cashAssetIds != null) result.cashAssetIds.addAll(cashAssetIds);
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..pPS(3, _omitFieldNames ? '' : 'cashAssetIds')
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get cashAssetIds => $_getList(2);
}

class GetAccountCashHoldingsResponse extends $pb.GeneratedMessage {
  factory GetAccountCashHoldingsResponse({
    $core.String? refRequestId,
    $1.Time? createdAt,
    AssetHoldings? cashHoldings,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (createdAt != null) result.createdAt = createdAt;
    if (cashHoldings != null) result.cashHoldings = cashHoldings;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.Time>(2, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Time.create)
    ..aOM<AssetHoldings>(3, _omitFieldNames ? '' : 'cashHoldings',
        subBuilder: AssetHoldings.create)
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.Time get createdAt => $_getN(1);
  @$pb.TagNumber(2)
  set createdAt($1.Time value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCreatedAt() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreatedAt() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Time ensureCreatedAt() => $_ensure(1);

  @$pb.TagNumber(3)
  AssetHoldings get cashHoldings => $_getN(2);
  @$pb.TagNumber(3)
  set cashHoldings(AssetHoldings value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCashHoldings() => $_has(2);
  @$pb.TagNumber(3)
  void clearCashHoldings() => $_clearField(3);
  @$pb.TagNumber(3)
  AssetHoldings ensureCashHoldings() => $_ensure(2);
}

class DepositCashRequest extends $pb.GeneratedMessage {
  factory DepositCashRequest({
    $core.String? refRequestId,
    $core.String? accountId,
    $core.String? currencyAssetId,
    $core.String? amount,
    $core.String? auxData,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (accountId != null) result.accountId = accountId;
    if (currencyAssetId != null) result.currencyAssetId = currencyAssetId;
    if (amount != null) result.amount = amount;
    if (auxData != null) result.auxData = auxData;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..aOS(3, _omitFieldNames ? '' : 'currencyAssetId')
    ..aOS(4, _omitFieldNames ? '' : 'amount')
    ..aOS(5, _omitFieldNames ? '' : 'auxData')
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currencyAssetId => $_getSZ(2);
  @$pb.TagNumber(3)
  set currencyAssetId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrencyAssetId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrencyAssetId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get amount => $_getSZ(3);
  @$pb.TagNumber(4)
  set amount($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get auxData => $_getSZ(4);
  @$pb.TagNumber(5)
  set auxData($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAuxData() => $_has(4);
  @$pb.TagNumber(5)
  void clearAuxData() => $_clearField(5);
}

class DepositCashResponse extends $pb.GeneratedMessage {
  factory DepositCashResponse({
    $core.String? refRequestId,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);
}

class DepositAssetRequest extends $pb.GeneratedMessage {
  factory DepositAssetRequest({
    $core.String? refRequestId,
    $core.String? accountId,
    $core.String? assetId,
    $fixnum.Int64? amount,
    $core.String? auxData,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (accountId != null) result.accountId = accountId;
    if (assetId != null) result.assetId = assetId;
    if (amount != null) result.amount = amount;
    if (auxData != null) result.auxData = auxData;
    return result;
  }

  DepositAssetRequest._();

  factory DepositAssetRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DepositAssetRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DepositAssetRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..aOS(3, _omitFieldNames ? '' : 'assetId')
    ..aInt64(4, _omitFieldNames ? '' : 'amount')
    ..aOS(5, _omitFieldNames ? '' : 'auxData')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DepositAssetRequest clone() => DepositAssetRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DepositAssetRequest copyWith(void Function(DepositAssetRequest) updates) =>
      super.copyWith((message) => updates(message as DepositAssetRequest))
          as DepositAssetRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DepositAssetRequest create() => DepositAssetRequest._();
  @$core.override
  DepositAssetRequest createEmptyInstance() => create();
  static $pb.PbList<DepositAssetRequest> createRepeated() =>
      $pb.PbList<DepositAssetRequest>();
  @$core.pragma('dart2js:noInline')
  static DepositAssetRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DepositAssetRequest>(create);
  static DepositAssetRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get assetId => $_getSZ(2);
  @$pb.TagNumber(3)
  set assetId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAssetId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAssetId() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get amount => $_getI64(3);
  @$pb.TagNumber(4)
  set amount($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get auxData => $_getSZ(4);
  @$pb.TagNumber(5)
  set auxData($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAuxData() => $_has(4);
  @$pb.TagNumber(5)
  void clearAuxData() => $_clearField(5);
}

class DepositAssetResponse extends $pb.GeneratedMessage {
  factory DepositAssetResponse({
    $core.String? refRequestId,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    return result;
  }

  DepositAssetResponse._();

  factory DepositAssetResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DepositAssetResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DepositAssetResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DepositAssetResponse clone() =>
      DepositAssetResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DepositAssetResponse copyWith(void Function(DepositAssetResponse) updates) =>
      super.copyWith((message) => updates(message as DepositAssetResponse))
          as DepositAssetResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DepositAssetResponse create() => DepositAssetResponse._();
  @$core.override
  DepositAssetResponse createEmptyInstance() => create();
  static $pb.PbList<DepositAssetResponse> createRepeated() =>
      $pb.PbList<DepositAssetResponse>();
  @$core.pragma('dart2js:noInline')
  static DepositAssetResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DepositAssetResponse>(create);
  static DepositAssetResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);
}

class WithdrawCashRequest extends $pb.GeneratedMessage {
  factory WithdrawCashRequest({
    $core.String? refRequestId,
    $core.String? accountId,
    $core.String? currencyAssetId,
    $fixnum.Int64? amount,
    $core.String? auxData,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (accountId != null) result.accountId = accountId;
    if (currencyAssetId != null) result.currencyAssetId = currencyAssetId;
    if (amount != null) result.amount = amount;
    if (auxData != null) result.auxData = auxData;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..aOS(3, _omitFieldNames ? '' : 'currencyAssetId')
    ..aInt64(4, _omitFieldNames ? '' : 'amount')
    ..aOS(5, _omitFieldNames ? '' : 'auxData')
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currencyAssetId => $_getSZ(2);
  @$pb.TagNumber(3)
  set currencyAssetId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrencyAssetId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrencyAssetId() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get amount => $_getI64(3);
  @$pb.TagNumber(4)
  set amount($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get auxData => $_getSZ(4);
  @$pb.TagNumber(5)
  set auxData($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAuxData() => $_has(4);
  @$pb.TagNumber(5)
  void clearAuxData() => $_clearField(5);
}

class WithdrawCashResponse extends $pb.GeneratedMessage {
  factory WithdrawCashResponse({
    $core.String? refRequestId,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);
}

/// Transaction message reflects Activity structure with from/to accounts and stashes
/// This structure mirrors the Activity model from pkg/chain/trezor/activity.go
class Transaction extends $pb.GeneratedMessage {
  factory Transaction({
    $core.String? transactionId,
    $core.String? transactionHash,
    $1.Time? timestamp,
    TransactionType? type,
    $core.String? operation,
    $core.String? accountId,
    $core.String? fromAccount,
    $core.String? toAccount,
    $core.String? fromReserveId,
    $core.String? toReserveId,
    $core.String? fromStash,
    $core.String? toStash,
    $core.String? assetId,
    $core.String? amount,
    $core.String? referenceId,
    $core.String? referenceType,
    $core.String? description,
    $core.String? metadata,
  }) {
    final result = create();
    if (transactionId != null) result.transactionId = transactionId;
    if (transactionHash != null) result.transactionHash = transactionHash;
    if (timestamp != null) result.timestamp = timestamp;
    if (type != null) result.type = type;
    if (operation != null) result.operation = operation;
    if (accountId != null) result.accountId = accountId;
    if (fromAccount != null) result.fromAccount = fromAccount;
    if (toAccount != null) result.toAccount = toAccount;
    if (fromReserveId != null) result.fromReserveId = fromReserveId;
    if (toReserveId != null) result.toReserveId = toReserveId;
    if (fromStash != null) result.fromStash = fromStash;
    if (toStash != null) result.toStash = toStash;
    if (assetId != null) result.assetId = assetId;
    if (amount != null) result.amount = amount;
    if (referenceId != null) result.referenceId = referenceId;
    if (referenceType != null) result.referenceType = referenceType;
    if (description != null) result.description = description;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  Transaction._();

  factory Transaction.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Transaction.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Transaction',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..aOS(2, _omitFieldNames ? '' : 'transactionHash')
    ..aOM<$1.Time>(3, _omitFieldNames ? '' : 'timestamp',
        subBuilder: $1.Time.create)
    ..e<TransactionType>(4, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: TransactionType.TRANSACTION_TYPE__UNKNOWN,
        valueOf: TransactionType.valueOf,
        enumValues: TransactionType.values)
    ..aOS(5, _omitFieldNames ? '' : 'operation')
    ..aOS(6, _omitFieldNames ? '' : 'accountId')
    ..aOS(7, _omitFieldNames ? '' : 'fromAccount')
    ..aOS(8, _omitFieldNames ? '' : 'toAccount')
    ..aOS(9, _omitFieldNames ? '' : 'fromReserveId')
    ..aOS(10, _omitFieldNames ? '' : 'toReserveId')
    ..aOS(11, _omitFieldNames ? '' : 'fromStash')
    ..aOS(12, _omitFieldNames ? '' : 'toStash')
    ..aOS(13, _omitFieldNames ? '' : 'assetId')
    ..aOS(14, _omitFieldNames ? '' : 'amount')
    ..aOS(15, _omitFieldNames ? '' : 'referenceId')
    ..aOS(16, _omitFieldNames ? '' : 'referenceType')
    ..aOS(17, _omitFieldNames ? '' : 'description')
    ..aOS(18, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Transaction clone() => Transaction()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Transaction copyWith(void Function(Transaction) updates) =>
      super.copyWith((message) => updates(message as Transaction))
          as Transaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Transaction create() => Transaction._();
  @$core.override
  Transaction createEmptyInstance() => create();
  static $pb.PbList<Transaction> createRepeated() => $pb.PbList<Transaction>();
  @$core.pragma('dart2js:noInline')
  static Transaction getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Transaction>(create);
  static Transaction? _defaultInstance;

  /// Core identifiers
  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get transactionHash => $_getSZ(1);
  @$pb.TagNumber(2)
  set transactionHash($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTransactionHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionHash() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.Time get timestamp => $_getN(2);
  @$pb.TagNumber(3)
  set timestamp($1.Time value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Time ensureTimestamp() => $_ensure(2);

  /// Transaction type and operation
  @$pb.TagNumber(4)
  TransactionType get type => $_getN(3);
  @$pb.TagNumber(4)
  set type(TransactionType value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasType() => $_has(3);
  @$pb.TagNumber(4)
  void clearType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get operation => $_getSZ(4);
  @$pb.TagNumber(5)
  set operation($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasOperation() => $_has(4);
  @$pb.TagNumber(5)
  void clearOperation() => $_clearField(5);

  /// Account information (reflecting Activity structure)
  @$pb.TagNumber(6)
  $core.String get accountId => $_getSZ(5);
  @$pb.TagNumber(6)
  set accountId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAccountId() => $_has(5);
  @$pb.TagNumber(6)
  void clearAccountId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get fromAccount => $_getSZ(6);
  @$pb.TagNumber(7)
  set fromAccount($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasFromAccount() => $_has(6);
  @$pb.TagNumber(7)
  void clearFromAccount() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get toAccount => $_getSZ(7);
  @$pb.TagNumber(8)
  set toAccount($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasToAccount() => $_has(7);
  @$pb.TagNumber(8)
  void clearToAccount() => $_clearField(8);

  /// Reserve IDs (from Activity model)
  @$pb.TagNumber(9)
  $core.String get fromReserveId => $_getSZ(8);
  @$pb.TagNumber(9)
  set fromReserveId($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasFromReserveId() => $_has(8);
  @$pb.TagNumber(9)
  void clearFromReserveId() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get toReserveId => $_getSZ(9);
  @$pb.TagNumber(10)
  set toReserveId($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasToReserveId() => $_has(9);
  @$pb.TagNumber(10)
  void clearToReserveId() => $_clearField(10);

  /// Stash information (critical for the Activity model)
  @$pb.TagNumber(11)
  $core.String get fromStash => $_getSZ(10);
  @$pb.TagNumber(11)
  set fromStash($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasFromStash() => $_has(10);
  @$pb.TagNumber(11)
  void clearFromStash() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get toStash => $_getSZ(11);
  @$pb.TagNumber(12)
  set toStash($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasToStash() => $_has(11);
  @$pb.TagNumber(12)
  void clearToStash() => $_clearField(12);

  /// Asset and amount
  @$pb.TagNumber(13)
  $core.String get assetId => $_getSZ(12);
  @$pb.TagNumber(13)
  set assetId($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasAssetId() => $_has(12);
  @$pb.TagNumber(13)
  void clearAssetId() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get amount => $_getSZ(13);
  @$pb.TagNumber(14)
  set amount($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasAmount() => $_has(13);
  @$pb.TagNumber(14)
  void clearAmount() => $_clearField(14);

  /// Reference information
  @$pb.TagNumber(15)
  $core.String get referenceId => $_getSZ(14);
  @$pb.TagNumber(15)
  set referenceId($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasReferenceId() => $_has(14);
  @$pb.TagNumber(15)
  void clearReferenceId() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get referenceType => $_getSZ(15);
  @$pb.TagNumber(16)
  set referenceType($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasReferenceType() => $_has(15);
  @$pb.TagNumber(16)
  void clearReferenceType() => $_clearField(16);

  /// Additional fields
  @$pb.TagNumber(17)
  $core.String get description => $_getSZ(16);
  @$pb.TagNumber(17)
  set description($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasDescription() => $_has(16);
  @$pb.TagNumber(17)
  void clearDescription() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get metadata => $_getSZ(17);
  @$pb.TagNumber(18)
  set metadata($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasMetadata() => $_has(17);
  @$pb.TagNumber(18)
  void clearMetadata() => $_clearField(18);
}

class GetAccountOrdersRequest extends $pb.GeneratedMessage {
  factory GetAccountOrdersRequest({
    $core.String? refRequestId,
    $core.String? accountId,
    $core.Iterable<$core.String>? marketIdOrNameRegexes,
    $1.PaginationParams? pagination,
    $1.Time? fromTime,
    $1.Time? toTime,
    $1.OrderSide? side,
    $core.Iterable<$core.bool>? statusFilters,
    $core.Iterable<$core.String>? instrumentIdOrSymbolRegexes,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (accountId != null) result.accountId = accountId;
    if (marketIdOrNameRegexes != null)
      result.marketIdOrNameRegexes.addAll(marketIdOrNameRegexes);
    if (pagination != null) result.pagination = pagination;
    if (fromTime != null) result.fromTime = fromTime;
    if (toTime != null) result.toTime = toTime;
    if (side != null) result.side = side;
    if (statusFilters != null) result.statusFilters.addAll(statusFilters);
    if (instrumentIdOrSymbolRegexes != null)
      result.instrumentIdOrSymbolRegexes.addAll(instrumentIdOrSymbolRegexes);
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..pPS(3, _omitFieldNames ? '' : 'marketIdOrNameRegexes')
    ..aOM<$1.PaginationParams>(4, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..aOM<$1.Time>(5, _omitFieldNames ? '' : 'fromTime',
        subBuilder: $1.Time.create)
    ..aOM<$1.Time>(6, _omitFieldNames ? '' : 'toTime',
        subBuilder: $1.Time.create)
    ..e<$1.OrderSide>(7, _omitFieldNames ? '' : 'side', $pb.PbFieldType.OE,
        defaultOrMaker: $1.OrderSide.ORDER_SIDE__UNKNOWN,
        valueOf: $1.OrderSide.valueOf,
        enumValues: $1.OrderSide.values)
    ..p<$core.bool>(
        8, _omitFieldNames ? '' : 'statusFilters', $pb.PbFieldType.KB)
    ..pPS(9, _omitFieldNames ? '' : 'instrumentIdOrSymbolRegexes')
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => $_clearField(2);

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

  /// Optional filters
  @$pb.TagNumber(5)
  $1.Time get fromTime => $_getN(4);
  @$pb.TagNumber(5)
  set fromTime($1.Time value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasFromTime() => $_has(4);
  @$pb.TagNumber(5)
  void clearFromTime() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Time ensureFromTime() => $_ensure(4);

  @$pb.TagNumber(6)
  $1.Time get toTime => $_getN(5);
  @$pb.TagNumber(6)
  set toTime($1.Time value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasToTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearToTime() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Time ensureToTime() => $_ensure(5);

  @$pb.TagNumber(7)
  $1.OrderSide get side => $_getN(6);
  @$pb.TagNumber(7)
  set side($1.OrderSide value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasSide() => $_has(6);
  @$pb.TagNumber(7)
  void clearSide() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<$core.bool> get statusFilters => $_getList(7);

  @$pb.TagNumber(9)
  $pb.PbList<$core.String> get instrumentIdOrSymbolRegexes => $_getList(8);
}

class GetAccountOrdersResponse extends $pb.GeneratedMessage {
  factory GetAccountOrdersResponse({
    $core.String? refRequestId,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<$1.Order>? orders,
    $1.Time? createdAt,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (orders != null) result.orders.addAll(orders);
    if (createdAt != null) result.createdAt = createdAt;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<$1.Order>(3, _omitFieldNames ? '' : 'orders', $pb.PbFieldType.PM,
        subBuilder: $1.Order.create)
    ..aOM<$1.Time>(4, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Time.create)
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

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
  $pb.PbList<$1.Order> get orders => $_getList(2);

  @$pb.TagNumber(4)
  $1.Time get createdAt => $_getN(3);
  @$pb.TagNumber(4)
  set createdAt($1.Time value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCreatedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatedAt() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Time ensureCreatedAt() => $_ensure(3);
}

class GetAccountTradesRequest extends $pb.GeneratedMessage {
  factory GetAccountTradesRequest({
    $core.String? refRequestId,
    $core.String? accountId,
    $core.Iterable<$core.String>? marketIdOrNameRegexes,
    $1.PaginationParams? pagination,
    $1.Time? fromTime,
    $1.Time? toTime,
    $core.Iterable<$core.String>? instrumentIdOrSymbolRegexes,
    $1.OrderSide? side,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (accountId != null) result.accountId = accountId;
    if (marketIdOrNameRegexes != null)
      result.marketIdOrNameRegexes.addAll(marketIdOrNameRegexes);
    if (pagination != null) result.pagination = pagination;
    if (fromTime != null) result.fromTime = fromTime;
    if (toTime != null) result.toTime = toTime;
    if (instrumentIdOrSymbolRegexes != null)
      result.instrumentIdOrSymbolRegexes.addAll(instrumentIdOrSymbolRegexes);
    if (side != null) result.side = side;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..pPS(3, _omitFieldNames ? '' : 'marketIdOrNameRegexes')
    ..aOM<$1.PaginationParams>(4, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..aOM<$1.Time>(5, _omitFieldNames ? '' : 'fromTime',
        subBuilder: $1.Time.create)
    ..aOM<$1.Time>(6, _omitFieldNames ? '' : 'toTime',
        subBuilder: $1.Time.create)
    ..pPS(7, _omitFieldNames ? '' : 'instrumentIdOrSymbolRegexes')
    ..e<$1.OrderSide>(8, _omitFieldNames ? '' : 'side', $pb.PbFieldType.OE,
        defaultOrMaker: $1.OrderSide.ORDER_SIDE__UNKNOWN,
        valueOf: $1.OrderSide.valueOf,
        enumValues: $1.OrderSide.values)
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => $_clearField(2);

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

  /// Optional filters
  @$pb.TagNumber(5)
  $1.Time get fromTime => $_getN(4);
  @$pb.TagNumber(5)
  set fromTime($1.Time value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasFromTime() => $_has(4);
  @$pb.TagNumber(5)
  void clearFromTime() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Time ensureFromTime() => $_ensure(4);

  @$pb.TagNumber(6)
  $1.Time get toTime => $_getN(5);
  @$pb.TagNumber(6)
  set toTime($1.Time value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasToTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearToTime() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Time ensureToTime() => $_ensure(5);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get instrumentIdOrSymbolRegexes => $_getList(6);

  @$pb.TagNumber(8)
  $1.OrderSide get side => $_getN(7);
  @$pb.TagNumber(8)
  set side($1.OrderSide value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasSide() => $_has(7);
  @$pb.TagNumber(8)
  void clearSide() => $_clearField(8);
}

class GetAccountTradesResponse extends $pb.GeneratedMessage {
  factory GetAccountTradesResponse({
    $core.String? refRequestId,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<$1.Trade>? trades,
    $1.Time? createdAt,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (trades != null) result.trades.addAll(trades);
    if (createdAt != null) result.createdAt = createdAt;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<$1.Trade>(3, _omitFieldNames ? '' : 'trades', $pb.PbFieldType.PM,
        subBuilder: $1.Trade.create)
    ..aOM<$1.Time>(4, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Time.create)
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

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
  $pb.PbList<$1.Trade> get trades => $_getList(2);

  @$pb.TagNumber(4)
  $1.Time get createdAt => $_getN(3);
  @$pb.TagNumber(4)
  set createdAt($1.Time value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCreatedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatedAt() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Time ensureCreatedAt() => $_ensure(3);
}

class GetAccountSettlementsRequest extends $pb.GeneratedMessage {
  factory GetAccountSettlementsRequest({
    $core.String? refRequestId,
    $core.String? accountId,
    $core.Iterable<$core.String>? marketIdOrNameRegexes,
    $1.PaginationParams? pagination,
    $1.Time? fromTime,
    $1.Time? toTime,
    $1.ConfirmationStatus? status,
    $core.Iterable<$core.String>? assetIdOrNameRegexes,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (accountId != null) result.accountId = accountId;
    if (marketIdOrNameRegexes != null)
      result.marketIdOrNameRegexes.addAll(marketIdOrNameRegexes);
    if (pagination != null) result.pagination = pagination;
    if (fromTime != null) result.fromTime = fromTime;
    if (toTime != null) result.toTime = toTime;
    if (status != null) result.status = status;
    if (assetIdOrNameRegexes != null)
      result.assetIdOrNameRegexes.addAll(assetIdOrNameRegexes);
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..pPS(3, _omitFieldNames ? '' : 'marketIdOrNameRegexes')
    ..aOM<$1.PaginationParams>(4, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..aOM<$1.Time>(5, _omitFieldNames ? '' : 'fromTime',
        subBuilder: $1.Time.create)
    ..aOM<$1.Time>(6, _omitFieldNames ? '' : 'toTime',
        subBuilder: $1.Time.create)
    ..e<$1.ConfirmationStatus>(
        7, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: $1.ConfirmationStatus.CONFIRMATION_STATUS__UNKNOWN,
        valueOf: $1.ConfirmationStatus.valueOf,
        enumValues: $1.ConfirmationStatus.values)
    ..pPS(8, _omitFieldNames ? '' : 'assetIdOrNameRegexes')
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => $_clearField(2);

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

  /// Optional filters
  @$pb.TagNumber(5)
  $1.Time get fromTime => $_getN(4);
  @$pb.TagNumber(5)
  set fromTime($1.Time value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasFromTime() => $_has(4);
  @$pb.TagNumber(5)
  void clearFromTime() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Time ensureFromTime() => $_ensure(4);

  @$pb.TagNumber(6)
  $1.Time get toTime => $_getN(5);
  @$pb.TagNumber(6)
  set toTime($1.Time value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasToTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearToTime() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Time ensureToTime() => $_ensure(5);

  @$pb.TagNumber(7)
  $1.ConfirmationStatus get status => $_getN(6);
  @$pb.TagNumber(7)
  set status($1.ConfirmationStatus value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get assetIdOrNameRegexes => $_getList(7);
}

class GetAccountSettlementsResponse extends $pb.GeneratedMessage {
  factory GetAccountSettlementsResponse({
    $core.String? refRequestId,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<$1.Settlement>? settlements,
    $1.Time? createdAt,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (settlements != null) result.settlements.addAll(settlements);
    if (createdAt != null) result.createdAt = createdAt;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<$1.Settlement>(
        3, _omitFieldNames ? '' : 'settlements', $pb.PbFieldType.PM,
        subBuilder: $1.Settlement.create)
    ..aOM<$1.Time>(4, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Time.create)
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

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
  $pb.PbList<$1.Settlement> get settlements => $_getList(2);

  @$pb.TagNumber(4)
  $1.Time get createdAt => $_getN(3);
  @$pb.TagNumber(4)
  set createdAt($1.Time value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCreatedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatedAt() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Time ensureCreatedAt() => $_ensure(3);
}

class GetAccountTransactionsRequest extends $pb.GeneratedMessage {
  factory GetAccountTransactionsRequest({
    $core.String? refRequestId,
    $core.String? accountId,
    $1.PaginationParams? pagination,
    $1.Time? fromTime,
    $1.Time? toTime,
    $core.Iterable<TransactionType>? transactionTypes,
    $core.Iterable<$core.String>? assetIdOrNameRegexes,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (accountId != null) result.accountId = accountId;
    if (pagination != null) result.pagination = pagination;
    if (fromTime != null) result.fromTime = fromTime;
    if (toTime != null) result.toTime = toTime;
    if (transactionTypes != null)
      result.transactionTypes.addAll(transactionTypes);
    if (assetIdOrNameRegexes != null)
      result.assetIdOrNameRegexes.addAll(assetIdOrNameRegexes);
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..aOM<$1.PaginationParams>(3, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginationParams.create)
    ..aOM<$1.Time>(4, _omitFieldNames ? '' : 'fromTime',
        subBuilder: $1.Time.create)
    ..aOM<$1.Time>(5, _omitFieldNames ? '' : 'toTime',
        subBuilder: $1.Time.create)
    ..pc<TransactionType>(
        6, _omitFieldNames ? '' : 'transactionTypes', $pb.PbFieldType.KE,
        valueOf: TransactionType.valueOf,
        enumValues: TransactionType.values,
        defaultEnumValue: TransactionType.TRANSACTION_TYPE__UNKNOWN)
    ..pPS(7, _omitFieldNames ? '' : 'assetIdOrNameRegexes')
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => $_clearField(2);

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

  /// Optional filters
  @$pb.TagNumber(4)
  $1.Time get fromTime => $_getN(3);
  @$pb.TagNumber(4)
  set fromTime($1.Time value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasFromTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearFromTime() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Time ensureFromTime() => $_ensure(3);

  @$pb.TagNumber(5)
  $1.Time get toTime => $_getN(4);
  @$pb.TagNumber(5)
  set toTime($1.Time value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasToTime() => $_has(4);
  @$pb.TagNumber(5)
  void clearToTime() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Time ensureToTime() => $_ensure(4);

  @$pb.TagNumber(6)
  $pb.PbList<TransactionType> get transactionTypes => $_getList(5);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get assetIdOrNameRegexes => $_getList(6);
}

class GetAccountTransactionsResponse extends $pb.GeneratedMessage {
  factory GetAccountTransactionsResponse({
    $core.String? refRequestId,
    $1.PaginationInfo? paginationInfo,
    $core.Iterable<Transaction>? transactions,
    $1.Time? createdAt,
  }) {
    final result = create();
    if (refRequestId != null) result.refRequestId = refRequestId;
    if (paginationInfo != null) result.paginationInfo = paginationInfo;
    if (transactions != null) result.transactions.addAll(transactions);
    if (createdAt != null) result.createdAt = createdAt;
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
    ..aOS(1, _omitFieldNames ? '' : 'refRequestId')
    ..aOM<$1.PaginationInfo>(2, _omitFieldNames ? '' : 'paginationInfo',
        subBuilder: $1.PaginationInfo.create)
    ..pc<Transaction>(
        3, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM,
        subBuilder: Transaction.create)
    ..aOM<$1.Time>(4, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Time.create)
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
  $core.String get refRequestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refRequestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefRequestId() => $_clearField(1);

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
  $pb.PbList<Transaction> get transactions => $_getList(2);

  @$pb.TagNumber(4)
  $1.Time get createdAt => $_getN(3);
  @$pb.TagNumber(4)
  set createdAt($1.Time value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCreatedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatedAt() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Time ensureCreatedAt() => $_ensure(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
