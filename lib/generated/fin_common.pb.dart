//
//  Generated code. Do not modify.
//  source: fin_common.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $1;
import 'fin_common.pbenum.dart';

export 'fin_common.pbenum.dart';

class Account extends $pb.GeneratedMessage {
  factory Account({
    $core.String? iid,
    $core.Iterable<FinIdentifier>? identifiers,
    $core.String? externalAccountId,
    AccountTypeEnum? accountType,
    AccountStatusEnum? accountStatus,
    $core.Map<$core.String, $core.String>? displayNames,
    $core.Map<$core.String, $core.String>? descriptions,
    $core.Map<$core.String, $core.String>? labels,
    $core.Iterable<$core.String>? tags,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (iid != null) {
      $result.iid = iid;
    }
    if (identifiers != null) {
      $result.identifiers.addAll(identifiers);
    }
    if (externalAccountId != null) {
      $result.externalAccountId = externalAccountId;
    }
    if (accountType != null) {
      $result.accountType = accountType;
    }
    if (accountStatus != null) {
      $result.accountStatus = accountStatus;
    }
    if (displayNames != null) {
      $result.displayNames.addAll(displayNames);
    }
    if (descriptions != null) {
      $result.descriptions.addAll(descriptions);
    }
    if (labels != null) {
      $result.labels.addAll(labels);
    }
    if (tags != null) {
      $result.tags.addAll(tags);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  Account._() : super();
  factory Account.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Account.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Account', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'iid')
    ..pc<FinIdentifier>(2, _omitFieldNames ? '' : 'identifiers', $pb.PbFieldType.PM, subBuilder: FinIdentifier.create)
    ..aOS(3, _omitFieldNames ? '' : 'externalAccountId')
    ..e<AccountTypeEnum>(4, _omitFieldNames ? '' : 'accountType', $pb.PbFieldType.OE, defaultOrMaker: AccountTypeEnum.ACCOUNT_TYPE_ENUM__UNKNOWN, valueOf: AccountTypeEnum.valueOf, enumValues: AccountTypeEnum.values)
    ..e<AccountStatusEnum>(8, _omitFieldNames ? '' : 'accountStatus', $pb.PbFieldType.OE, defaultOrMaker: AccountStatusEnum.ACCOUNT_STATUS_ENUM__UNKNOWN, valueOf: AccountStatusEnum.valueOf, enumValues: AccountStatusEnum.values)
    ..m<$core.String, $core.String>(101, _omitFieldNames ? '' : 'displayNames', entryClassName: 'Account.DisplayNamesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(102, _omitFieldNames ? '' : 'descriptions', entryClassName: 'Account.DescriptionsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(103, _omitFieldNames ? '' : 'labels', entryClassName: 'Account.LabelsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..pPS(104, _omitFieldNames ? '' : 'tags')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'Account.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Account clone() => Account()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Account copyWith(void Function(Account) updates) => super.copyWith((message) => updates(message as Account)) as Account;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Account create() => Account._();
  Account createEmptyInstance() => create();
  static $pb.PbList<Account> createRepeated() => $pb.PbList<Account>();
  @$core.pragma('dart2js:noInline')
  static Account getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Account>(create);
  static Account? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get iid => $_getSZ(0);
  @$pb.TagNumber(1)
  set iid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIid() => $_has(0);
  @$pb.TagNumber(1)
  void clearIid() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<FinIdentifier> get identifiers => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get externalAccountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set externalAccountId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasExternalAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearExternalAccountId() => clearField(3);

  @$pb.TagNumber(4)
  AccountTypeEnum get accountType => $_getN(3);
  @$pb.TagNumber(4)
  set accountType(AccountTypeEnum v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasAccountType() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountType() => clearField(4);

  @$pb.TagNumber(8)
  AccountStatusEnum get accountStatus => $_getN(4);
  @$pb.TagNumber(8)
  set accountStatus(AccountStatusEnum v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasAccountStatus() => $_has(4);
  @$pb.TagNumber(8)
  void clearAccountStatus() => clearField(8);

  @$pb.TagNumber(101)
  $core.Map<$core.String, $core.String> get displayNames => $_getMap(5);

  @$pb.TagNumber(102)
  $core.Map<$core.String, $core.String> get descriptions => $_getMap(6);

  @$pb.TagNumber(103)
  $core.Map<$core.String, $core.String> get labels => $_getMap(7);

  @$pb.TagNumber(104)
  $core.List<$core.String> get tags => $_getList(8);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(9);
}

class AccountToAccountRelation extends $pb.GeneratedMessage {
  factory AccountToAccountRelation({
    $core.String? iid,
    $core.String? fromAccountIid,
    $core.String? toAccountIid,
    AccountToAccountRelationTypeEnum? relationType,
    $1.DateTime? effectiveFromDt,
    $1.DateTime? effectiveToDt,
    $core.Map<$core.String, $core.String>? displayNames,
    $core.Map<$core.String, $core.String>? descriptions,
    $core.Map<$core.String, $core.String>? labels,
    $core.Iterable<$core.String>? tags,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (iid != null) {
      $result.iid = iid;
    }
    if (fromAccountIid != null) {
      $result.fromAccountIid = fromAccountIid;
    }
    if (toAccountIid != null) {
      $result.toAccountIid = toAccountIid;
    }
    if (relationType != null) {
      $result.relationType = relationType;
    }
    if (effectiveFromDt != null) {
      $result.effectiveFromDt = effectiveFromDt;
    }
    if (effectiveToDt != null) {
      $result.effectiveToDt = effectiveToDt;
    }
    if (displayNames != null) {
      $result.displayNames.addAll(displayNames);
    }
    if (descriptions != null) {
      $result.descriptions.addAll(descriptions);
    }
    if (labels != null) {
      $result.labels.addAll(labels);
    }
    if (tags != null) {
      $result.tags.addAll(tags);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  AccountToAccountRelation._() : super();
  factory AccountToAccountRelation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AccountToAccountRelation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AccountToAccountRelation', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'iid')
    ..aOS(2, _omitFieldNames ? '' : 'fromAccountIid')
    ..aOS(3, _omitFieldNames ? '' : 'toAccountIid')
    ..e<AccountToAccountRelationTypeEnum>(4, _omitFieldNames ? '' : 'relationType', $pb.PbFieldType.OE, defaultOrMaker: AccountToAccountRelationTypeEnum.ACCOUNT_TO_ACCOUNT_RELATION_TYPE_ENUM__UNKNOWN, valueOf: AccountToAccountRelationTypeEnum.valueOf, enumValues: AccountToAccountRelationTypeEnum.values)
    ..aOM<$1.DateTime>(5, _omitFieldNames ? '' : 'effectiveFromDt', subBuilder: $1.DateTime.create)
    ..aOM<$1.DateTime>(6, _omitFieldNames ? '' : 'effectiveToDt', subBuilder: $1.DateTime.create)
    ..m<$core.String, $core.String>(101, _omitFieldNames ? '' : 'displayNames', entryClassName: 'AccountToAccountRelation.DisplayNamesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(102, _omitFieldNames ? '' : 'descriptions', entryClassName: 'AccountToAccountRelation.DescriptionsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(103, _omitFieldNames ? '' : 'labels', entryClassName: 'AccountToAccountRelation.LabelsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..pPS(104, _omitFieldNames ? '' : 'tags')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'AccountToAccountRelation.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AccountToAccountRelation clone() => AccountToAccountRelation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AccountToAccountRelation copyWith(void Function(AccountToAccountRelation) updates) => super.copyWith((message) => updates(message as AccountToAccountRelation)) as AccountToAccountRelation;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AccountToAccountRelation create() => AccountToAccountRelation._();
  AccountToAccountRelation createEmptyInstance() => create();
  static $pb.PbList<AccountToAccountRelation> createRepeated() => $pb.PbList<AccountToAccountRelation>();
  @$core.pragma('dart2js:noInline')
  static AccountToAccountRelation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AccountToAccountRelation>(create);
  static AccountToAccountRelation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get iid => $_getSZ(0);
  @$pb.TagNumber(1)
  set iid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIid() => $_has(0);
  @$pb.TagNumber(1)
  void clearIid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get fromAccountIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set fromAccountIid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFromAccountIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearFromAccountIid() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get toAccountIid => $_getSZ(2);
  @$pb.TagNumber(3)
  set toAccountIid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasToAccountIid() => $_has(2);
  @$pb.TagNumber(3)
  void clearToAccountIid() => clearField(3);

  @$pb.TagNumber(4)
  AccountToAccountRelationTypeEnum get relationType => $_getN(3);
  @$pb.TagNumber(4)
  set relationType(AccountToAccountRelationTypeEnum v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasRelationType() => $_has(3);
  @$pb.TagNumber(4)
  void clearRelationType() => clearField(4);

  @$pb.TagNumber(5)
  $1.DateTime get effectiveFromDt => $_getN(4);
  @$pb.TagNumber(5)
  set effectiveFromDt($1.DateTime v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasEffectiveFromDt() => $_has(4);
  @$pb.TagNumber(5)
  void clearEffectiveFromDt() => clearField(5);
  @$pb.TagNumber(5)
  $1.DateTime ensureEffectiveFromDt() => $_ensure(4);

  @$pb.TagNumber(6)
  $1.DateTime get effectiveToDt => $_getN(5);
  @$pb.TagNumber(6)
  set effectiveToDt($1.DateTime v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasEffectiveToDt() => $_has(5);
  @$pb.TagNumber(6)
  void clearEffectiveToDt() => clearField(6);
  @$pb.TagNumber(6)
  $1.DateTime ensureEffectiveToDt() => $_ensure(5);

  @$pb.TagNumber(101)
  $core.Map<$core.String, $core.String> get displayNames => $_getMap(6);

  @$pb.TagNumber(102)
  $core.Map<$core.String, $core.String> get descriptions => $_getMap(7);

  @$pb.TagNumber(103)
  $core.Map<$core.String, $core.String> get labels => $_getMap(8);

  @$pb.TagNumber(104)
  $core.List<$core.String> get tags => $_getList(9);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(10);
}

class FinIdentifier extends $pb.GeneratedMessage {
  factory FinIdentifier({
    FinEntityTypeEnum? finEntityType,
    $core.String? scheme,
    $core.String? standardOrFormat,
    $core.Iterable<$1.StringValue>? ids,
    $core.bool? isPrimary,
    $core.Map<$core.String, $core.String>? displayNames,
    $core.Map<$core.String, $core.String>? descriptions,
    $core.Map<$core.String, $core.String>? labels,
    $core.Iterable<$core.String>? tags,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (finEntityType != null) {
      $result.finEntityType = finEntityType;
    }
    if (scheme != null) {
      $result.scheme = scheme;
    }
    if (standardOrFormat != null) {
      $result.standardOrFormat = standardOrFormat;
    }
    if (ids != null) {
      $result.ids.addAll(ids);
    }
    if (isPrimary != null) {
      $result.isPrimary = isPrimary;
    }
    if (displayNames != null) {
      $result.displayNames.addAll(displayNames);
    }
    if (descriptions != null) {
      $result.descriptions.addAll(descriptions);
    }
    if (labels != null) {
      $result.labels.addAll(labels);
    }
    if (tags != null) {
      $result.tags.addAll(tags);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  FinIdentifier._() : super();
  factory FinIdentifier.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FinIdentifier.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FinIdentifier', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..e<FinEntityTypeEnum>(1, _omitFieldNames ? '' : 'finEntityType', $pb.PbFieldType.OE, defaultOrMaker: FinEntityTypeEnum.FIN_ENTITY_TYPE_ENUM__UNKNOWN, valueOf: FinEntityTypeEnum.valueOf, enumValues: FinEntityTypeEnum.values)
    ..aOS(2, _omitFieldNames ? '' : 'scheme')
    ..aOS(3, _omitFieldNames ? '' : 'standardOrFormat')
    ..pc<$1.StringValue>(4, _omitFieldNames ? '' : 'ids', $pb.PbFieldType.PM, subBuilder: $1.StringValue.create)
    ..aOB(5, _omitFieldNames ? '' : 'isPrimary')
    ..m<$core.String, $core.String>(101, _omitFieldNames ? '' : 'displayNames', entryClassName: 'FinIdentifier.DisplayNamesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(102, _omitFieldNames ? '' : 'descriptions', entryClassName: 'FinIdentifier.DescriptionsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(103, _omitFieldNames ? '' : 'labels', entryClassName: 'FinIdentifier.LabelsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..pPS(104, _omitFieldNames ? '' : 'tags')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'FinIdentifier.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FinIdentifier clone() => FinIdentifier()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FinIdentifier copyWith(void Function(FinIdentifier) updates) => super.copyWith((message) => updates(message as FinIdentifier)) as FinIdentifier;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FinIdentifier create() => FinIdentifier._();
  FinIdentifier createEmptyInstance() => create();
  static $pb.PbList<FinIdentifier> createRepeated() => $pb.PbList<FinIdentifier>();
  @$core.pragma('dart2js:noInline')
  static FinIdentifier getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FinIdentifier>(create);
  static FinIdentifier? _defaultInstance;

  @$pb.TagNumber(1)
  FinEntityTypeEnum get finEntityType => $_getN(0);
  @$pb.TagNumber(1)
  set finEntityType(FinEntityTypeEnum v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFinEntityType() => $_has(0);
  @$pb.TagNumber(1)
  void clearFinEntityType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get scheme => $_getSZ(1);
  @$pb.TagNumber(2)
  set scheme($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasScheme() => $_has(1);
  @$pb.TagNumber(2)
  void clearScheme() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get standardOrFormat => $_getSZ(2);
  @$pb.TagNumber(3)
  set standardOrFormat($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStandardOrFormat() => $_has(2);
  @$pb.TagNumber(3)
  void clearStandardOrFormat() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$1.StringValue> get ids => $_getList(3);

  @$pb.TagNumber(5)
  $core.bool get isPrimary => $_getBF(4);
  @$pb.TagNumber(5)
  set isPrimary($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsPrimary() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsPrimary() => clearField(5);

  @$pb.TagNumber(101)
  $core.Map<$core.String, $core.String> get displayNames => $_getMap(5);

  @$pb.TagNumber(102)
  $core.Map<$core.String, $core.String> get descriptions => $_getMap(6);

  @$pb.TagNumber(103)
  $core.Map<$core.String, $core.String> get labels => $_getMap(7);

  @$pb.TagNumber(104)
  $core.List<$core.String> get tags => $_getList(8);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(9);
}

class FinAssetClass extends $pb.GeneratedMessage {
  factory FinAssetClass({
    $core.String? schema,
    $core.Iterable<AssetClassEnum>? classes,
    $core.Map<$core.String, $core.String>? displayNames,
    $core.Map<$core.String, $core.String>? descriptions,
    $core.Map<$core.String, $core.String>? labels,
    $core.Iterable<$core.String>? tags,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (schema != null) {
      $result.schema = schema;
    }
    if (classes != null) {
      $result.classes.addAll(classes);
    }
    if (displayNames != null) {
      $result.displayNames.addAll(displayNames);
    }
    if (descriptions != null) {
      $result.descriptions.addAll(descriptions);
    }
    if (labels != null) {
      $result.labels.addAll(labels);
    }
    if (tags != null) {
      $result.tags.addAll(tags);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  FinAssetClass._() : super();
  factory FinAssetClass.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FinAssetClass.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FinAssetClass', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'schema')
    ..pc<AssetClassEnum>(2, _omitFieldNames ? '' : 'classes', $pb.PbFieldType.KE, valueOf: AssetClassEnum.valueOf, enumValues: AssetClassEnum.values, defaultEnumValue: AssetClassEnum.ASSET_CLASS_ENUM__UNKNOWN)
    ..m<$core.String, $core.String>(101, _omitFieldNames ? '' : 'displayNames', entryClassName: 'FinAssetClass.DisplayNamesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(102, _omitFieldNames ? '' : 'descriptions', entryClassName: 'FinAssetClass.DescriptionsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(103, _omitFieldNames ? '' : 'labels', entryClassName: 'FinAssetClass.LabelsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..pPS(104, _omitFieldNames ? '' : 'tags')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'FinAssetClass.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FinAssetClass clone() => FinAssetClass()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FinAssetClass copyWith(void Function(FinAssetClass) updates) => super.copyWith((message) => updates(message as FinAssetClass)) as FinAssetClass;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FinAssetClass create() => FinAssetClass._();
  FinAssetClass createEmptyInstance() => create();
  static $pb.PbList<FinAssetClass> createRepeated() => $pb.PbList<FinAssetClass>();
  @$core.pragma('dart2js:noInline')
  static FinAssetClass getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FinAssetClass>(create);
  static FinAssetClass? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get schema => $_getSZ(0);
  @$pb.TagNumber(1)
  set schema($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSchema() => $_has(0);
  @$pb.TagNumber(1)
  void clearSchema() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<AssetClassEnum> get classes => $_getList(1);

  @$pb.TagNumber(101)
  $core.Map<$core.String, $core.String> get displayNames => $_getMap(2);

  @$pb.TagNumber(102)
  $core.Map<$core.String, $core.String> get descriptions => $_getMap(3);

  @$pb.TagNumber(103)
  $core.Map<$core.String, $core.String> get labels => $_getMap(4);

  @$pb.TagNumber(104)
  $core.List<$core.String> get tags => $_getList(5);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(6);
}

class Asset extends $pb.GeneratedMessage {
  factory Asset({
    $core.String? iid,
    $core.Iterable<FinIdentifier>? identifiers,
    $core.Iterable<FinAssetClass>? classes,
    $core.Map<$core.String, $core.String>? displayNames,
    $core.Map<$core.String, $core.String>? descriptions,
    $core.Map<$core.String, $core.String>? labels,
    $core.Iterable<$core.String>? tags,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (iid != null) {
      $result.iid = iid;
    }
    if (identifiers != null) {
      $result.identifiers.addAll(identifiers);
    }
    if (classes != null) {
      $result.classes.addAll(classes);
    }
    if (displayNames != null) {
      $result.displayNames.addAll(displayNames);
    }
    if (descriptions != null) {
      $result.descriptions.addAll(descriptions);
    }
    if (labels != null) {
      $result.labels.addAll(labels);
    }
    if (tags != null) {
      $result.tags.addAll(tags);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  Asset._() : super();
  factory Asset.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Asset.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Asset', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'iid')
    ..pc<FinIdentifier>(2, _omitFieldNames ? '' : 'identifiers', $pb.PbFieldType.PM, subBuilder: FinIdentifier.create)
    ..pc<FinAssetClass>(3, _omitFieldNames ? '' : 'classes', $pb.PbFieldType.PM, subBuilder: FinAssetClass.create)
    ..m<$core.String, $core.String>(101, _omitFieldNames ? '' : 'displayNames', entryClassName: 'Asset.DisplayNamesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(102, _omitFieldNames ? '' : 'descriptions', entryClassName: 'Asset.DescriptionsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(103, _omitFieldNames ? '' : 'labels', entryClassName: 'Asset.LabelsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..pPS(104, _omitFieldNames ? '' : 'tags')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'Asset.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Asset clone() => Asset()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Asset copyWith(void Function(Asset) updates) => super.copyWith((message) => updates(message as Asset)) as Asset;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Asset create() => Asset._();
  Asset createEmptyInstance() => create();
  static $pb.PbList<Asset> createRepeated() => $pb.PbList<Asset>();
  @$core.pragma('dart2js:noInline')
  static Asset getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Asset>(create);
  static Asset? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get iid => $_getSZ(0);
  @$pb.TagNumber(1)
  set iid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIid() => $_has(0);
  @$pb.TagNumber(1)
  void clearIid() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<FinIdentifier> get identifiers => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<FinAssetClass> get classes => $_getList(2);

  @$pb.TagNumber(101)
  $core.Map<$core.String, $core.String> get displayNames => $_getMap(3);

  @$pb.TagNumber(102)
  $core.Map<$core.String, $core.String> get descriptions => $_getMap(4);

  @$pb.TagNumber(103)
  $core.Map<$core.String, $core.String> get labels => $_getMap(5);

  @$pb.TagNumber(104)
  $core.List<$core.String> get tags => $_getList(6);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(7);
}

class Participant extends $pb.GeneratedMessage {
  factory Participant({
    $core.String? iid,
    $core.Iterable<FinIdentifier>? identifiers,
    $core.Iterable<ParticipantTypeEnum>? types,
    $core.Map<$core.String, $core.String>? displayNames,
    $core.Map<$core.String, $core.String>? descriptions,
    $core.Map<$core.String, $core.String>? labels,
    $core.Iterable<$core.String>? tags,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (iid != null) {
      $result.iid = iid;
    }
    if (identifiers != null) {
      $result.identifiers.addAll(identifiers);
    }
    if (types != null) {
      $result.types.addAll(types);
    }
    if (displayNames != null) {
      $result.displayNames.addAll(displayNames);
    }
    if (descriptions != null) {
      $result.descriptions.addAll(descriptions);
    }
    if (labels != null) {
      $result.labels.addAll(labels);
    }
    if (tags != null) {
      $result.tags.addAll(tags);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  Participant._() : super();
  factory Participant.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Participant.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Participant', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'iid')
    ..pc<FinIdentifier>(2, _omitFieldNames ? '' : 'identifiers', $pb.PbFieldType.PM, subBuilder: FinIdentifier.create)
    ..pc<ParticipantTypeEnum>(3, _omitFieldNames ? '' : 'types', $pb.PbFieldType.KE, valueOf: ParticipantTypeEnum.valueOf, enumValues: ParticipantTypeEnum.values, defaultEnumValue: ParticipantTypeEnum.PARTICIPANT_TYPE_ENUM__UNKNOWN)
    ..m<$core.String, $core.String>(101, _omitFieldNames ? '' : 'displayNames', entryClassName: 'Participant.DisplayNamesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(102, _omitFieldNames ? '' : 'descriptions', entryClassName: 'Participant.DescriptionsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(103, _omitFieldNames ? '' : 'labels', entryClassName: 'Participant.LabelsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..pPS(104, _omitFieldNames ? '' : 'tags')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'Participant.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Participant clone() => Participant()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Participant copyWith(void Function(Participant) updates) => super.copyWith((message) => updates(message as Participant)) as Participant;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Participant create() => Participant._();
  Participant createEmptyInstance() => create();
  static $pb.PbList<Participant> createRepeated() => $pb.PbList<Participant>();
  @$core.pragma('dart2js:noInline')
  static Participant getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Participant>(create);
  static Participant? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get iid => $_getSZ(0);
  @$pb.TagNumber(1)
  set iid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIid() => $_has(0);
  @$pb.TagNumber(1)
  void clearIid() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<FinIdentifier> get identifiers => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<ParticipantTypeEnum> get types => $_getList(2);

  @$pb.TagNumber(101)
  $core.Map<$core.String, $core.String> get displayNames => $_getMap(3);

  @$pb.TagNumber(102)
  $core.Map<$core.String, $core.String> get descriptions => $_getMap(4);

  @$pb.TagNumber(103)
  $core.Map<$core.String, $core.String> get labels => $_getMap(5);

  @$pb.TagNumber(104)
  $core.List<$core.String> get tags => $_getList(6);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(7);
}

class ParticipantToAssetRelation extends $pb.GeneratedMessage {
  factory ParticipantToAssetRelation({
    $core.String? iid,
    $core.String? participantIid,
    $core.String? assetIid,
    $core.Iterable<ParticipantToAssetRelationEnum>? relations,
    $1.DateTime? effectiveFromDt,
    $1.DateTime? effectiveToDt,
    $core.String? weight,
    $core.Map<$core.String, $core.String>? displayNames,
    $core.Map<$core.String, $core.String>? descriptions,
    $core.Map<$core.String, $core.String>? labels,
    $core.Iterable<$core.String>? tags,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (iid != null) {
      $result.iid = iid;
    }
    if (participantIid != null) {
      $result.participantIid = participantIid;
    }
    if (assetIid != null) {
      $result.assetIid = assetIid;
    }
    if (relations != null) {
      $result.relations.addAll(relations);
    }
    if (effectiveFromDt != null) {
      $result.effectiveFromDt = effectiveFromDt;
    }
    if (effectiveToDt != null) {
      $result.effectiveToDt = effectiveToDt;
    }
    if (weight != null) {
      $result.weight = weight;
    }
    if (displayNames != null) {
      $result.displayNames.addAll(displayNames);
    }
    if (descriptions != null) {
      $result.descriptions.addAll(descriptions);
    }
    if (labels != null) {
      $result.labels.addAll(labels);
    }
    if (tags != null) {
      $result.tags.addAll(tags);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  ParticipantToAssetRelation._() : super();
  factory ParticipantToAssetRelation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ParticipantToAssetRelation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ParticipantToAssetRelation', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'iid')
    ..aOS(2, _omitFieldNames ? '' : 'participantIid')
    ..aOS(3, _omitFieldNames ? '' : 'assetIid')
    ..pc<ParticipantToAssetRelationEnum>(4, _omitFieldNames ? '' : 'relations', $pb.PbFieldType.KE, valueOf: ParticipantToAssetRelationEnum.valueOf, enumValues: ParticipantToAssetRelationEnum.values, defaultEnumValue: ParticipantToAssetRelationEnum.PARTICIPANT_TO_ASSET_RELATION_ENUM__UNKNOWN)
    ..aOM<$1.DateTime>(5, _omitFieldNames ? '' : 'effectiveFromDt', subBuilder: $1.DateTime.create)
    ..aOM<$1.DateTime>(6, _omitFieldNames ? '' : 'effectiveToDt', subBuilder: $1.DateTime.create)
    ..aOS(7, _omitFieldNames ? '' : 'weight')
    ..m<$core.String, $core.String>(101, _omitFieldNames ? '' : 'displayNames', entryClassName: 'ParticipantToAssetRelation.DisplayNamesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(102, _omitFieldNames ? '' : 'descriptions', entryClassName: 'ParticipantToAssetRelation.DescriptionsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(103, _omitFieldNames ? '' : 'labels', entryClassName: 'ParticipantToAssetRelation.LabelsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..pPS(104, _omitFieldNames ? '' : 'tags')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'ParticipantToAssetRelation.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ParticipantToAssetRelation clone() => ParticipantToAssetRelation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ParticipantToAssetRelation copyWith(void Function(ParticipantToAssetRelation) updates) => super.copyWith((message) => updates(message as ParticipantToAssetRelation)) as ParticipantToAssetRelation;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ParticipantToAssetRelation create() => ParticipantToAssetRelation._();
  ParticipantToAssetRelation createEmptyInstance() => create();
  static $pb.PbList<ParticipantToAssetRelation> createRepeated() => $pb.PbList<ParticipantToAssetRelation>();
  @$core.pragma('dart2js:noInline')
  static ParticipantToAssetRelation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ParticipantToAssetRelation>(create);
  static ParticipantToAssetRelation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get iid => $_getSZ(0);
  @$pb.TagNumber(1)
  set iid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIid() => $_has(0);
  @$pb.TagNumber(1)
  void clearIid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get participantIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set participantIid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasParticipantIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearParticipantIid() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get assetIid => $_getSZ(2);
  @$pb.TagNumber(3)
  set assetIid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAssetIid() => $_has(2);
  @$pb.TagNumber(3)
  void clearAssetIid() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<ParticipantToAssetRelationEnum> get relations => $_getList(3);

  @$pb.TagNumber(5)
  $1.DateTime get effectiveFromDt => $_getN(4);
  @$pb.TagNumber(5)
  set effectiveFromDt($1.DateTime v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasEffectiveFromDt() => $_has(4);
  @$pb.TagNumber(5)
  void clearEffectiveFromDt() => clearField(5);
  @$pb.TagNumber(5)
  $1.DateTime ensureEffectiveFromDt() => $_ensure(4);

  @$pb.TagNumber(6)
  $1.DateTime get effectiveToDt => $_getN(5);
  @$pb.TagNumber(6)
  set effectiveToDt($1.DateTime v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasEffectiveToDt() => $_has(5);
  @$pb.TagNumber(6)
  void clearEffectiveToDt() => clearField(6);
  @$pb.TagNumber(6)
  $1.DateTime ensureEffectiveToDt() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get weight => $_getSZ(6);
  @$pb.TagNumber(7)
  set weight($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasWeight() => $_has(6);
  @$pb.TagNumber(7)
  void clearWeight() => clearField(7);

  @$pb.TagNumber(101)
  $core.Map<$core.String, $core.String> get displayNames => $_getMap(7);

  @$pb.TagNumber(102)
  $core.Map<$core.String, $core.String> get descriptions => $_getMap(8);

  @$pb.TagNumber(103)
  $core.Map<$core.String, $core.String> get labels => $_getMap(9);

  @$pb.TagNumber(104)
  $core.List<$core.String> get tags => $_getList(10);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(11);
}

class FinInstrumentClass extends $pb.GeneratedMessage {
  factory FinInstrumentClass({
    $core.String? schema,
    $core.Iterable<InstrumentClassEnum>? classes,
    $core.Map<$core.String, $core.String>? displayNames,
    $core.Map<$core.String, $core.String>? descriptions,
    $core.Map<$core.String, $core.String>? labels,
    $core.Iterable<$core.String>? tags,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (schema != null) {
      $result.schema = schema;
    }
    if (classes != null) {
      $result.classes.addAll(classes);
    }
    if (displayNames != null) {
      $result.displayNames.addAll(displayNames);
    }
    if (descriptions != null) {
      $result.descriptions.addAll(descriptions);
    }
    if (labels != null) {
      $result.labels.addAll(labels);
    }
    if (tags != null) {
      $result.tags.addAll(tags);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  FinInstrumentClass._() : super();
  factory FinInstrumentClass.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FinInstrumentClass.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FinInstrumentClass', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'schema')
    ..pc<InstrumentClassEnum>(2, _omitFieldNames ? '' : 'classes', $pb.PbFieldType.KE, valueOf: InstrumentClassEnum.valueOf, enumValues: InstrumentClassEnum.values, defaultEnumValue: InstrumentClassEnum.INSTRUMENT_CLASS_ENUM__UNKNOWN)
    ..m<$core.String, $core.String>(101, _omitFieldNames ? '' : 'displayNames', entryClassName: 'FinInstrumentClass.DisplayNamesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(102, _omitFieldNames ? '' : 'descriptions', entryClassName: 'FinInstrumentClass.DescriptionsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(103, _omitFieldNames ? '' : 'labels', entryClassName: 'FinInstrumentClass.LabelsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..pPS(104, _omitFieldNames ? '' : 'tags')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'FinInstrumentClass.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FinInstrumentClass clone() => FinInstrumentClass()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FinInstrumentClass copyWith(void Function(FinInstrumentClass) updates) => super.copyWith((message) => updates(message as FinInstrumentClass)) as FinInstrumentClass;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FinInstrumentClass create() => FinInstrumentClass._();
  FinInstrumentClass createEmptyInstance() => create();
  static $pb.PbList<FinInstrumentClass> createRepeated() => $pb.PbList<FinInstrumentClass>();
  @$core.pragma('dart2js:noInline')
  static FinInstrumentClass getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FinInstrumentClass>(create);
  static FinInstrumentClass? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get schema => $_getSZ(0);
  @$pb.TagNumber(1)
  set schema($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSchema() => $_has(0);
  @$pb.TagNumber(1)
  void clearSchema() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<InstrumentClassEnum> get classes => $_getList(1);

  @$pb.TagNumber(101)
  $core.Map<$core.String, $core.String> get displayNames => $_getMap(2);

  @$pb.TagNumber(102)
  $core.Map<$core.String, $core.String> get descriptions => $_getMap(3);

  @$pb.TagNumber(103)
  $core.Map<$core.String, $core.String> get labels => $_getMap(4);

  @$pb.TagNumber(104)
  $core.List<$core.String> get tags => $_getList(5);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(6);
}

enum OneOfIdOrParticipant_Participant {
  iid, 
  obj, 
  notSet
}

class OneOfIdOrParticipant extends $pb.GeneratedMessage {
  factory OneOfIdOrParticipant({
    $core.String? iid,
    Participant? obj,
  }) {
    final $result = create();
    if (iid != null) {
      $result.iid = iid;
    }
    if (obj != null) {
      $result.obj = obj;
    }
    return $result;
  }
  OneOfIdOrParticipant._() : super();
  factory OneOfIdOrParticipant.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OneOfIdOrParticipant.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, OneOfIdOrParticipant_Participant> _OneOfIdOrParticipant_ParticipantByTag = {
    1 : OneOfIdOrParticipant_Participant.iid,
    2 : OneOfIdOrParticipant_Participant.obj,
    0 : OneOfIdOrParticipant_Participant.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OneOfIdOrParticipant', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOS(1, _omitFieldNames ? '' : 'iid')
    ..aOM<Participant>(2, _omitFieldNames ? '' : 'obj', subBuilder: Participant.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OneOfIdOrParticipant clone() => OneOfIdOrParticipant()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OneOfIdOrParticipant copyWith(void Function(OneOfIdOrParticipant) updates) => super.copyWith((message) => updates(message as OneOfIdOrParticipant)) as OneOfIdOrParticipant;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OneOfIdOrParticipant create() => OneOfIdOrParticipant._();
  OneOfIdOrParticipant createEmptyInstance() => create();
  static $pb.PbList<OneOfIdOrParticipant> createRepeated() => $pb.PbList<OneOfIdOrParticipant>();
  @$core.pragma('dart2js:noInline')
  static OneOfIdOrParticipant getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OneOfIdOrParticipant>(create);
  static OneOfIdOrParticipant? _defaultInstance;

  OneOfIdOrParticipant_Participant whichParticipant() => _OneOfIdOrParticipant_ParticipantByTag[$_whichOneof(0)]!;
  void clearParticipant() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get iid => $_getSZ(0);
  @$pb.TagNumber(1)
  set iid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIid() => $_has(0);
  @$pb.TagNumber(1)
  void clearIid() => clearField(1);

  @$pb.TagNumber(2)
  Participant get obj => $_getN(1);
  @$pb.TagNumber(2)
  set obj(Participant v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasObj() => $_has(1);
  @$pb.TagNumber(2)
  void clearObj() => clearField(2);
  @$pb.TagNumber(2)
  Participant ensureObj() => $_ensure(1);
}

enum Instrument_Asset {
  assetIid, 
  assetObj, 
  notSet
}

class Instrument extends $pb.GeneratedMessage {
  factory Instrument({
    $core.String? iid,
    $core.Iterable<FinIdentifier>? identifiers,
    $core.String? cfiCode,
    $core.Iterable<FinInstrumentClass>? classes,
    $1.DateTime? maturityDt,
    $core.String? assetIid,
    Asset? assetObj,
    $1.DateTime? issueDt,
    $core.Iterable<OneOfIdOrParticipant>? issuers,
    $core.String? issueCountryCode,
    $core.String? issueCurrency,
    $core.String? issueInitialUnits,
    $core.String? issueDivisibility,
    $core.String? issueInitialAuthorizedUnits,
    $core.Map<$core.String, $core.String>? displayNames,
    $core.Map<$core.String, $core.String>? descriptions,
    $core.Map<$core.String, $core.String>? labels,
    $core.Iterable<$core.String>? tags,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (iid != null) {
      $result.iid = iid;
    }
    if (identifiers != null) {
      $result.identifiers.addAll(identifiers);
    }
    if (cfiCode != null) {
      $result.cfiCode = cfiCode;
    }
    if (classes != null) {
      $result.classes.addAll(classes);
    }
    if (maturityDt != null) {
      $result.maturityDt = maturityDt;
    }
    if (assetIid != null) {
      $result.assetIid = assetIid;
    }
    if (assetObj != null) {
      $result.assetObj = assetObj;
    }
    if (issueDt != null) {
      $result.issueDt = issueDt;
    }
    if (issuers != null) {
      $result.issuers.addAll(issuers);
    }
    if (issueCountryCode != null) {
      $result.issueCountryCode = issueCountryCode;
    }
    if (issueCurrency != null) {
      $result.issueCurrency = issueCurrency;
    }
    if (issueInitialUnits != null) {
      $result.issueInitialUnits = issueInitialUnits;
    }
    if (issueDivisibility != null) {
      $result.issueDivisibility = issueDivisibility;
    }
    if (issueInitialAuthorizedUnits != null) {
      $result.issueInitialAuthorizedUnits = issueInitialAuthorizedUnits;
    }
    if (displayNames != null) {
      $result.displayNames.addAll(displayNames);
    }
    if (descriptions != null) {
      $result.descriptions.addAll(descriptions);
    }
    if (labels != null) {
      $result.labels.addAll(labels);
    }
    if (tags != null) {
      $result.tags.addAll(tags);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  Instrument._() : super();
  factory Instrument.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Instrument.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, Instrument_Asset> _Instrument_AssetByTag = {
    6 : Instrument_Asset.assetIid,
    7 : Instrument_Asset.assetObj,
    0 : Instrument_Asset.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Instrument', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..oo(0, [6, 7])
    ..aOS(1, _omitFieldNames ? '' : 'iid')
    ..pc<FinIdentifier>(2, _omitFieldNames ? '' : 'identifiers', $pb.PbFieldType.PM, subBuilder: FinIdentifier.create)
    ..aOS(3, _omitFieldNames ? '' : 'cfiCode')
    ..pc<FinInstrumentClass>(4, _omitFieldNames ? '' : 'classes', $pb.PbFieldType.PM, subBuilder: FinInstrumentClass.create)
    ..aOM<$1.DateTime>(5, _omitFieldNames ? '' : 'maturityDt', subBuilder: $1.DateTime.create)
    ..aOS(6, _omitFieldNames ? '' : 'assetIid')
    ..aOM<Asset>(7, _omitFieldNames ? '' : 'assetObj', subBuilder: Asset.create)
    ..aOM<$1.DateTime>(8, _omitFieldNames ? '' : 'issueDt', subBuilder: $1.DateTime.create)
    ..pc<OneOfIdOrParticipant>(9, _omitFieldNames ? '' : 'issuers', $pb.PbFieldType.PM, subBuilder: OneOfIdOrParticipant.create)
    ..aOS(10, _omitFieldNames ? '' : 'issueCountryCode')
    ..aOS(11, _omitFieldNames ? '' : 'issueCurrency')
    ..aOS(12, _omitFieldNames ? '' : 'issueInitialUnits')
    ..aOS(13, _omitFieldNames ? '' : 'issueDivisibility')
    ..aOS(14, _omitFieldNames ? '' : 'issueInitialAuthorizedUnits')
    ..m<$core.String, $core.String>(101, _omitFieldNames ? '' : 'displayNames', entryClassName: 'Instrument.DisplayNamesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(102, _omitFieldNames ? '' : 'descriptions', entryClassName: 'Instrument.DescriptionsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(103, _omitFieldNames ? '' : 'labels', entryClassName: 'Instrument.LabelsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..pPS(104, _omitFieldNames ? '' : 'tags')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'Instrument.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Instrument clone() => Instrument()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Instrument copyWith(void Function(Instrument) updates) => super.copyWith((message) => updates(message as Instrument)) as Instrument;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Instrument create() => Instrument._();
  Instrument createEmptyInstance() => create();
  static $pb.PbList<Instrument> createRepeated() => $pb.PbList<Instrument>();
  @$core.pragma('dart2js:noInline')
  static Instrument getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Instrument>(create);
  static Instrument? _defaultInstance;

  Instrument_Asset whichAsset() => _Instrument_AssetByTag[$_whichOneof(0)]!;
  void clearAsset() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get iid => $_getSZ(0);
  @$pb.TagNumber(1)
  set iid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIid() => $_has(0);
  @$pb.TagNumber(1)
  void clearIid() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<FinIdentifier> get identifiers => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get cfiCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set cfiCode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCfiCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCfiCode() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<FinInstrumentClass> get classes => $_getList(3);

  @$pb.TagNumber(5)
  $1.DateTime get maturityDt => $_getN(4);
  @$pb.TagNumber(5)
  set maturityDt($1.DateTime v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasMaturityDt() => $_has(4);
  @$pb.TagNumber(5)
  void clearMaturityDt() => clearField(5);
  @$pb.TagNumber(5)
  $1.DateTime ensureMaturityDt() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get assetIid => $_getSZ(5);
  @$pb.TagNumber(6)
  set assetIid($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAssetIid() => $_has(5);
  @$pb.TagNumber(6)
  void clearAssetIid() => clearField(6);

  @$pb.TagNumber(7)
  Asset get assetObj => $_getN(6);
  @$pb.TagNumber(7)
  set assetObj(Asset v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasAssetObj() => $_has(6);
  @$pb.TagNumber(7)
  void clearAssetObj() => clearField(7);
  @$pb.TagNumber(7)
  Asset ensureAssetObj() => $_ensure(6);

  @$pb.TagNumber(8)
  $1.DateTime get issueDt => $_getN(7);
  @$pb.TagNumber(8)
  set issueDt($1.DateTime v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasIssueDt() => $_has(7);
  @$pb.TagNumber(8)
  void clearIssueDt() => clearField(8);
  @$pb.TagNumber(8)
  $1.DateTime ensureIssueDt() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.List<OneOfIdOrParticipant> get issuers => $_getList(8);

  @$pb.TagNumber(10)
  $core.String get issueCountryCode => $_getSZ(9);
  @$pb.TagNumber(10)
  set issueCountryCode($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasIssueCountryCode() => $_has(9);
  @$pb.TagNumber(10)
  void clearIssueCountryCode() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get issueCurrency => $_getSZ(10);
  @$pb.TagNumber(11)
  set issueCurrency($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasIssueCurrency() => $_has(10);
  @$pb.TagNumber(11)
  void clearIssueCurrency() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get issueInitialUnits => $_getSZ(11);
  @$pb.TagNumber(12)
  set issueInitialUnits($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasIssueInitialUnits() => $_has(11);
  @$pb.TagNumber(12)
  void clearIssueInitialUnits() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get issueDivisibility => $_getSZ(12);
  @$pb.TagNumber(13)
  set issueDivisibility($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasIssueDivisibility() => $_has(12);
  @$pb.TagNumber(13)
  void clearIssueDivisibility() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get issueInitialAuthorizedUnits => $_getSZ(13);
  @$pb.TagNumber(14)
  set issueInitialAuthorizedUnits($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasIssueInitialAuthorizedUnits() => $_has(13);
  @$pb.TagNumber(14)
  void clearIssueInitialAuthorizedUnits() => clearField(14);

  @$pb.TagNumber(101)
  $core.Map<$core.String, $core.String> get displayNames => $_getMap(14);

  @$pb.TagNumber(102)
  $core.Map<$core.String, $core.String> get descriptions => $_getMap(15);

  @$pb.TagNumber(103)
  $core.Map<$core.String, $core.String> get labels => $_getMap(16);

  @$pb.TagNumber(104)
  $core.List<$core.String> get tags => $_getList(17);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(18);
}

class ParticipantToInstrumentRelation extends $pb.GeneratedMessage {
  factory ParticipantToInstrumentRelation({
    $core.String? iid,
    $core.String? participantIid,
    $core.String? instrumentIid,
    $core.Iterable<ParticipantToInstrumentRelationEnum>? relations,
    $1.DateTime? effectiveFromDt,
    $1.DateTime? effectiveToDt,
    $core.String? weight,
    $core.Map<$core.String, $core.String>? displayNames,
    $core.Map<$core.String, $core.String>? descriptions,
    $core.Map<$core.String, $core.String>? labels,
    $core.Iterable<$core.String>? tags,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (iid != null) {
      $result.iid = iid;
    }
    if (participantIid != null) {
      $result.participantIid = participantIid;
    }
    if (instrumentIid != null) {
      $result.instrumentIid = instrumentIid;
    }
    if (relations != null) {
      $result.relations.addAll(relations);
    }
    if (effectiveFromDt != null) {
      $result.effectiveFromDt = effectiveFromDt;
    }
    if (effectiveToDt != null) {
      $result.effectiveToDt = effectiveToDt;
    }
    if (weight != null) {
      $result.weight = weight;
    }
    if (displayNames != null) {
      $result.displayNames.addAll(displayNames);
    }
    if (descriptions != null) {
      $result.descriptions.addAll(descriptions);
    }
    if (labels != null) {
      $result.labels.addAll(labels);
    }
    if (tags != null) {
      $result.tags.addAll(tags);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  ParticipantToInstrumentRelation._() : super();
  factory ParticipantToInstrumentRelation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ParticipantToInstrumentRelation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ParticipantToInstrumentRelation', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'iid')
    ..aOS(2, _omitFieldNames ? '' : 'participantIid')
    ..aOS(3, _omitFieldNames ? '' : 'instrumentIid')
    ..pc<ParticipantToInstrumentRelationEnum>(4, _omitFieldNames ? '' : 'relations', $pb.PbFieldType.KE, valueOf: ParticipantToInstrumentRelationEnum.valueOf, enumValues: ParticipantToInstrumentRelationEnum.values, defaultEnumValue: ParticipantToInstrumentRelationEnum.PARTICIPANT_TO_INSTRUMENT_RELATION_ENUM__UNKNOWN)
    ..aOM<$1.DateTime>(5, _omitFieldNames ? '' : 'effectiveFromDt', subBuilder: $1.DateTime.create)
    ..aOM<$1.DateTime>(6, _omitFieldNames ? '' : 'effectiveToDt', subBuilder: $1.DateTime.create)
    ..aOS(7, _omitFieldNames ? '' : 'weight')
    ..m<$core.String, $core.String>(101, _omitFieldNames ? '' : 'displayNames', entryClassName: 'ParticipantToInstrumentRelation.DisplayNamesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(102, _omitFieldNames ? '' : 'descriptions', entryClassName: 'ParticipantToInstrumentRelation.DescriptionsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(103, _omitFieldNames ? '' : 'labels', entryClassName: 'ParticipantToInstrumentRelation.LabelsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..pPS(104, _omitFieldNames ? '' : 'tags')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'ParticipantToInstrumentRelation.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ParticipantToInstrumentRelation clone() => ParticipantToInstrumentRelation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ParticipantToInstrumentRelation copyWith(void Function(ParticipantToInstrumentRelation) updates) => super.copyWith((message) => updates(message as ParticipantToInstrumentRelation)) as ParticipantToInstrumentRelation;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ParticipantToInstrumentRelation create() => ParticipantToInstrumentRelation._();
  ParticipantToInstrumentRelation createEmptyInstance() => create();
  static $pb.PbList<ParticipantToInstrumentRelation> createRepeated() => $pb.PbList<ParticipantToInstrumentRelation>();
  @$core.pragma('dart2js:noInline')
  static ParticipantToInstrumentRelation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ParticipantToInstrumentRelation>(create);
  static ParticipantToInstrumentRelation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get iid => $_getSZ(0);
  @$pb.TagNumber(1)
  set iid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIid() => $_has(0);
  @$pb.TagNumber(1)
  void clearIid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get participantIid => $_getSZ(1);
  @$pb.TagNumber(2)
  set participantIid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasParticipantIid() => $_has(1);
  @$pb.TagNumber(2)
  void clearParticipantIid() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get instrumentIid => $_getSZ(2);
  @$pb.TagNumber(3)
  set instrumentIid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasInstrumentIid() => $_has(2);
  @$pb.TagNumber(3)
  void clearInstrumentIid() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<ParticipantToInstrumentRelationEnum> get relations => $_getList(3);

  @$pb.TagNumber(5)
  $1.DateTime get effectiveFromDt => $_getN(4);
  @$pb.TagNumber(5)
  set effectiveFromDt($1.DateTime v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasEffectiveFromDt() => $_has(4);
  @$pb.TagNumber(5)
  void clearEffectiveFromDt() => clearField(5);
  @$pb.TagNumber(5)
  $1.DateTime ensureEffectiveFromDt() => $_ensure(4);

  @$pb.TagNumber(6)
  $1.DateTime get effectiveToDt => $_getN(5);
  @$pb.TagNumber(6)
  set effectiveToDt($1.DateTime v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasEffectiveToDt() => $_has(5);
  @$pb.TagNumber(6)
  void clearEffectiveToDt() => clearField(6);
  @$pb.TagNumber(6)
  $1.DateTime ensureEffectiveToDt() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get weight => $_getSZ(6);
  @$pb.TagNumber(7)
  set weight($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasWeight() => $_has(6);
  @$pb.TagNumber(7)
  void clearWeight() => clearField(7);

  @$pb.TagNumber(101)
  $core.Map<$core.String, $core.String> get displayNames => $_getMap(7);

  @$pb.TagNumber(102)
  $core.Map<$core.String, $core.String> get descriptions => $_getMap(8);

  @$pb.TagNumber(103)
  $core.Map<$core.String, $core.String> get labels => $_getMap(9);

  @$pb.TagNumber(104)
  $core.List<$core.String> get tags => $_getList(10);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(11);
}

enum Holdings_AssetId {
  instrumentIid, 
  currencyCode, 
  notSet
}

class Holdings extends $pb.GeneratedMessage {
  factory Holdings({
    $core.String? instrumentIid,
    $core.String? currencyCode,
    $core.String? totalUnits,
    $core.Map<$core.String, $core.String>? stashUnits,
  }) {
    final $result = create();
    if (instrumentIid != null) {
      $result.instrumentIid = instrumentIid;
    }
    if (currencyCode != null) {
      $result.currencyCode = currencyCode;
    }
    if (totalUnits != null) {
      $result.totalUnits = totalUnits;
    }
    if (stashUnits != null) {
      $result.stashUnits.addAll(stashUnits);
    }
    return $result;
  }
  Holdings._() : super();
  factory Holdings.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Holdings.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, Holdings_AssetId> _Holdings_AssetIdByTag = {
    1 : Holdings_AssetId.instrumentIid,
    2 : Holdings_AssetId.currencyCode,
    0 : Holdings_AssetId.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Holdings', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOS(1, _omitFieldNames ? '' : 'instrumentIid')
    ..aOS(2, _omitFieldNames ? '' : 'currencyCode')
    ..aOS(3, _omitFieldNames ? '' : 'totalUnits')
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'stashUnits', entryClassName: 'Holdings.StashUnitsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Holdings clone() => Holdings()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Holdings copyWith(void Function(Holdings) updates) => super.copyWith((message) => updates(message as Holdings)) as Holdings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Holdings create() => Holdings._();
  Holdings createEmptyInstance() => create();
  static $pb.PbList<Holdings> createRepeated() => $pb.PbList<Holdings>();
  @$core.pragma('dart2js:noInline')
  static Holdings getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Holdings>(create);
  static Holdings? _defaultInstance;

  Holdings_AssetId whichAssetId() => _Holdings_AssetIdByTag[$_whichOneof(0)]!;
  void clearAssetId() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get instrumentIid => $_getSZ(0);
  @$pb.TagNumber(1)
  set instrumentIid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInstrumentIid() => $_has(0);
  @$pb.TagNumber(1)
  void clearInstrumentIid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get currencyCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set currencyCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrencyCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrencyCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get totalUnits => $_getSZ(2);
  @$pb.TagNumber(3)
  set totalUnits($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalUnits() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalUnits() => clearField(3);

  @$pb.TagNumber(4)
  $core.Map<$core.String, $core.String> get stashUnits => $_getMap(3);
}

class Portfolio extends $pb.GeneratedMessage {
  factory Portfolio({
    $core.String? accountIid,
    $1.DateTime? generatedAtDt,
    $core.Map<$core.String, Holdings>? holdings,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (accountIid != null) {
      $result.accountIid = accountIid;
    }
    if (generatedAtDt != null) {
      $result.generatedAtDt = generatedAtDt;
    }
    if (holdings != null) {
      $result.holdings.addAll(holdings);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  Portfolio._() : super();
  factory Portfolio.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Portfolio.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Portfolio', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountIid')
    ..aOM<$1.DateTime>(2, _omitFieldNames ? '' : 'generatedAtDt', subBuilder: $1.DateTime.create)
    ..m<$core.String, Holdings>(3, _omitFieldNames ? '' : 'holdings', entryClassName: 'Portfolio.HoldingsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: Holdings.create, valueDefaultOrMaker: Holdings.getDefault, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'Portfolio.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Portfolio clone() => Portfolio()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Portfolio copyWith(void Function(Portfolio) updates) => super.copyWith((message) => updates(message as Portfolio)) as Portfolio;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Portfolio create() => Portfolio._();
  Portfolio createEmptyInstance() => create();
  static $pb.PbList<Portfolio> createRepeated() => $pb.PbList<Portfolio>();
  @$core.pragma('dart2js:noInline')
  static Portfolio getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Portfolio>(create);
  static Portfolio? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountIid => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountIid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountIid() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountIid() => clearField(1);

  @$pb.TagNumber(2)
  $1.DateTime get generatedAtDt => $_getN(1);
  @$pb.TagNumber(2)
  set generatedAtDt($1.DateTime v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasGeneratedAtDt() => $_has(1);
  @$pb.TagNumber(2)
  void clearGeneratedAtDt() => clearField(2);
  @$pb.TagNumber(2)
  $1.DateTime ensureGeneratedAtDt() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.Map<$core.String, Holdings> get holdings => $_getMap(2);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(3);
}

class Market extends $pb.GeneratedMessage {
  factory Market({
    $core.String? iid,
    $core.Iterable<FinIdentifier>? identifiers,
    $core.String? dominantCurrency,
    $core.String? countryCode,
    $core.String? cityCode,
    $core.String? websiteUrl,
    $core.String? timezone,
    $1.Duration? tradingHours,
    $core.Iterable<$core.String>? tradingDays,
    MarketStatus? status,
    $core.Map<$core.String, $core.String>? displayNames,
    $core.Map<$core.String, $core.String>? descriptions,
    $core.Map<$core.String, $core.String>? labels,
    $core.Iterable<$core.String>? tags,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (iid != null) {
      $result.iid = iid;
    }
    if (identifiers != null) {
      $result.identifiers.addAll(identifiers);
    }
    if (dominantCurrency != null) {
      $result.dominantCurrency = dominantCurrency;
    }
    if (countryCode != null) {
      $result.countryCode = countryCode;
    }
    if (cityCode != null) {
      $result.cityCode = cityCode;
    }
    if (websiteUrl != null) {
      $result.websiteUrl = websiteUrl;
    }
    if (timezone != null) {
      $result.timezone = timezone;
    }
    if (tradingHours != null) {
      $result.tradingHours = tradingHours;
    }
    if (tradingDays != null) {
      $result.tradingDays.addAll(tradingDays);
    }
    if (status != null) {
      $result.status = status;
    }
    if (displayNames != null) {
      $result.displayNames.addAll(displayNames);
    }
    if (descriptions != null) {
      $result.descriptions.addAll(descriptions);
    }
    if (labels != null) {
      $result.labels.addAll(labels);
    }
    if (tags != null) {
      $result.tags.addAll(tags);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  Market._() : super();
  factory Market.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Market.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Market', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'iid')
    ..pc<FinIdentifier>(2, _omitFieldNames ? '' : 'identifiers', $pb.PbFieldType.PM, subBuilder: FinIdentifier.create)
    ..aOS(3, _omitFieldNames ? '' : 'dominantCurrency')
    ..aOS(4, _omitFieldNames ? '' : 'countryCode')
    ..aOS(5, _omitFieldNames ? '' : 'cityCode')
    ..aOS(6, _omitFieldNames ? '' : 'websiteUrl')
    ..aOS(7, _omitFieldNames ? '' : 'timezone')
    ..aOM<$1.Duration>(8, _omitFieldNames ? '' : 'tradingHours', subBuilder: $1.Duration.create)
    ..pPS(9, _omitFieldNames ? '' : 'tradingDays')
    ..e<MarketStatus>(10, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: MarketStatus.MARKET_STATUS__UNKNOWN, valueOf: MarketStatus.valueOf, enumValues: MarketStatus.values)
    ..m<$core.String, $core.String>(101, _omitFieldNames ? '' : 'displayNames', entryClassName: 'Market.DisplayNamesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(102, _omitFieldNames ? '' : 'descriptions', entryClassName: 'Market.DescriptionsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(103, _omitFieldNames ? '' : 'labels', entryClassName: 'Market.LabelsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..pPS(104, _omitFieldNames ? '' : 'tags')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'Market.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Market clone() => Market()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Market copyWith(void Function(Market) updates) => super.copyWith((message) => updates(message as Market)) as Market;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Market create() => Market._();
  Market createEmptyInstance() => create();
  static $pb.PbList<Market> createRepeated() => $pb.PbList<Market>();
  @$core.pragma('dart2js:noInline')
  static Market getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Market>(create);
  static Market? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get iid => $_getSZ(0);
  @$pb.TagNumber(1)
  set iid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIid() => $_has(0);
  @$pb.TagNumber(1)
  void clearIid() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<FinIdentifier> get identifiers => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get dominantCurrency => $_getSZ(2);
  @$pb.TagNumber(3)
  set dominantCurrency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDominantCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearDominantCurrency() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get countryCode => $_getSZ(3);
  @$pb.TagNumber(4)
  set countryCode($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCountryCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearCountryCode() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get cityCode => $_getSZ(4);
  @$pb.TagNumber(5)
  set cityCode($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCityCode() => $_has(4);
  @$pb.TagNumber(5)
  void clearCityCode() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get websiteUrl => $_getSZ(5);
  @$pb.TagNumber(6)
  set websiteUrl($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasWebsiteUrl() => $_has(5);
  @$pb.TagNumber(6)
  void clearWebsiteUrl() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get timezone => $_getSZ(6);
  @$pb.TagNumber(7)
  set timezone($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTimezone() => $_has(6);
  @$pb.TagNumber(7)
  void clearTimezone() => clearField(7);

  @$pb.TagNumber(8)
  $1.Duration get tradingHours => $_getN(7);
  @$pb.TagNumber(8)
  set tradingHours($1.Duration v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasTradingHours() => $_has(7);
  @$pb.TagNumber(8)
  void clearTradingHours() => clearField(8);
  @$pb.TagNumber(8)
  $1.Duration ensureTradingHours() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.List<$core.String> get tradingDays => $_getList(8);

  @$pb.TagNumber(10)
  MarketStatus get status => $_getN(9);
  @$pb.TagNumber(10)
  set status(MarketStatus v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => clearField(10);

  @$pb.TagNumber(101)
  $core.Map<$core.String, $core.String> get displayNames => $_getMap(10);

  @$pb.TagNumber(102)
  $core.Map<$core.String, $core.String> get descriptions => $_getMap(11);

  @$pb.TagNumber(103)
  $core.Map<$core.String, $core.String> get labels => $_getMap(12);

  @$pb.TagNumber(104)
  $core.List<$core.String> get tags => $_getList(13);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(14);
}

class MarketDuration extends $pb.GeneratedMessage {
  factory MarketDuration({
    $1.Duration? duration,
    MarketStatus? status,
    $core.Iterable<$core.String>? comments,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (duration != null) {
      $result.duration = duration;
    }
    if (status != null) {
      $result.status = status;
    }
    if (comments != null) {
      $result.comments.addAll(comments);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  MarketDuration._() : super();
  factory MarketDuration.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MarketDuration.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MarketDuration', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOM<$1.Duration>(1, _omitFieldNames ? '' : 'duration', subBuilder: $1.Duration.create)
    ..e<MarketStatus>(2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: MarketStatus.MARKET_STATUS__UNKNOWN, valueOf: MarketStatus.valueOf, enumValues: MarketStatus.values)
    ..pPS(3, _omitFieldNames ? '' : 'comments')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'MarketDuration.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MarketDuration clone() => MarketDuration()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MarketDuration copyWith(void Function(MarketDuration) updates) => super.copyWith((message) => updates(message as MarketDuration)) as MarketDuration;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarketDuration create() => MarketDuration._();
  MarketDuration createEmptyInstance() => create();
  static $pb.PbList<MarketDuration> createRepeated() => $pb.PbList<MarketDuration>();
  @$core.pragma('dart2js:noInline')
  static MarketDuration getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MarketDuration>(create);
  static MarketDuration? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Duration get duration => $_getN(0);
  @$pb.TagNumber(1)
  set duration($1.Duration v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasDuration() => $_has(0);
  @$pb.TagNumber(1)
  void clearDuration() => clearField(1);
  @$pb.TagNumber(1)
  $1.Duration ensureDuration() => $_ensure(0);

  @$pb.TagNumber(2)
  MarketStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(MarketStatus v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get comments => $_getList(2);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(3);
}

class MarketCalendar extends $pb.GeneratedMessage {
  factory MarketCalendar({
    $core.String? marketIid,
    $1.Time? dailyOpen,
    $1.Time? dailyClose,
    $core.Iterable<$1.Duration>? calendar,
  }) {
    final $result = create();
    if (marketIid != null) {
      $result.marketIid = marketIid;
    }
    if (dailyOpen != null) {
      $result.dailyOpen = dailyOpen;
    }
    if (dailyClose != null) {
      $result.dailyClose = dailyClose;
    }
    if (calendar != null) {
      $result.calendar.addAll(calendar);
    }
    return $result;
  }
  MarketCalendar._() : super();
  factory MarketCalendar.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MarketCalendar.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MarketCalendar', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'marketIid')
    ..aOM<$1.Time>(2, _omitFieldNames ? '' : 'dailyOpen', subBuilder: $1.Time.create)
    ..aOM<$1.Time>(3, _omitFieldNames ? '' : 'dailyClose', subBuilder: $1.Time.create)
    ..pc<$1.Duration>(4, _omitFieldNames ? '' : 'calendar', $pb.PbFieldType.PM, subBuilder: $1.Duration.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MarketCalendar clone() => MarketCalendar()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MarketCalendar copyWith(void Function(MarketCalendar) updates) => super.copyWith((message) => updates(message as MarketCalendar)) as MarketCalendar;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarketCalendar create() => MarketCalendar._();
  MarketCalendar createEmptyInstance() => create();
  static $pb.PbList<MarketCalendar> createRepeated() => $pb.PbList<MarketCalendar>();
  @$core.pragma('dart2js:noInline')
  static MarketCalendar getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MarketCalendar>(create);
  static MarketCalendar? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get marketIid => $_getSZ(0);
  @$pb.TagNumber(1)
  set marketIid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMarketIid() => $_has(0);
  @$pb.TagNumber(1)
  void clearMarketIid() => clearField(1);

  @$pb.TagNumber(2)
  $1.Time get dailyOpen => $_getN(1);
  @$pb.TagNumber(2)
  set dailyOpen($1.Time v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDailyOpen() => $_has(1);
  @$pb.TagNumber(2)
  void clearDailyOpen() => clearField(2);
  @$pb.TagNumber(2)
  $1.Time ensureDailyOpen() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.Time get dailyClose => $_getN(2);
  @$pb.TagNumber(3)
  set dailyClose($1.Time v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasDailyClose() => $_has(2);
  @$pb.TagNumber(3)
  void clearDailyClose() => clearField(3);
  @$pb.TagNumber(3)
  $1.Time ensureDailyClose() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.List<$1.Duration> get calendar => $_getList(3);
}

enum Venue_Market {
  marketIid, 
  marketObj, 
  notSet
}

class Venue extends $pb.GeneratedMessage {
  factory Venue({
    $core.String? iid,
    $core.Iterable<FinIdentifier>? identifiers,
    $core.String? marketIid,
    Market? marketObj,
    $core.String? dominantCurrency,
    VenueTypeEnum? venueType,
    $1.DateTime? establishedDt,
    $core.String? countryCode,
    $core.String? cityCode,
    $core.String? websiteUrl,
    $core.String? timezone,
    $1.Duration? tradingHours,
    $core.Iterable<$core.String>? tradingDays,
    VenueStatus? status,
    $core.Iterable<OneOfIdOrParticipant>? settlementDepositories,
    $core.Iterable<OneOfIdOrParticipant>? clearingHouses,
    $core.Iterable<OneOfIdOrParticipant>? regulators,
    $core.Map<$core.String, $core.String>? displayNames,
    $core.Map<$core.String, $core.String>? descriptions,
    $core.Map<$core.String, $core.String>? labels,
    $core.Iterable<$core.String>? tags,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (iid != null) {
      $result.iid = iid;
    }
    if (identifiers != null) {
      $result.identifiers.addAll(identifiers);
    }
    if (marketIid != null) {
      $result.marketIid = marketIid;
    }
    if (marketObj != null) {
      $result.marketObj = marketObj;
    }
    if (dominantCurrency != null) {
      $result.dominantCurrency = dominantCurrency;
    }
    if (venueType != null) {
      $result.venueType = venueType;
    }
    if (establishedDt != null) {
      $result.establishedDt = establishedDt;
    }
    if (countryCode != null) {
      $result.countryCode = countryCode;
    }
    if (cityCode != null) {
      $result.cityCode = cityCode;
    }
    if (websiteUrl != null) {
      $result.websiteUrl = websiteUrl;
    }
    if (timezone != null) {
      $result.timezone = timezone;
    }
    if (tradingHours != null) {
      $result.tradingHours = tradingHours;
    }
    if (tradingDays != null) {
      $result.tradingDays.addAll(tradingDays);
    }
    if (status != null) {
      $result.status = status;
    }
    if (settlementDepositories != null) {
      $result.settlementDepositories.addAll(settlementDepositories);
    }
    if (clearingHouses != null) {
      $result.clearingHouses.addAll(clearingHouses);
    }
    if (regulators != null) {
      $result.regulators.addAll(regulators);
    }
    if (displayNames != null) {
      $result.displayNames.addAll(displayNames);
    }
    if (descriptions != null) {
      $result.descriptions.addAll(descriptions);
    }
    if (labels != null) {
      $result.labels.addAll(labels);
    }
    if (tags != null) {
      $result.tags.addAll(tags);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  Venue._() : super();
  factory Venue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Venue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, Venue_Market> _Venue_MarketByTag = {
    3 : Venue_Market.marketIid,
    4 : Venue_Market.marketObj,
    0 : Venue_Market.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Venue', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..oo(0, [3, 4])
    ..aOS(1, _omitFieldNames ? '' : 'iid')
    ..pc<FinIdentifier>(2, _omitFieldNames ? '' : 'identifiers', $pb.PbFieldType.PM, subBuilder: FinIdentifier.create)
    ..aOS(3, _omitFieldNames ? '' : 'marketIid')
    ..aOM<Market>(4, _omitFieldNames ? '' : 'marketObj', subBuilder: Market.create)
    ..aOS(5, _omitFieldNames ? '' : 'dominantCurrency')
    ..e<VenueTypeEnum>(6, _omitFieldNames ? '' : 'venueType', $pb.PbFieldType.OE, defaultOrMaker: VenueTypeEnum.VENUE_TYPE_ENUM__UNKNOWN, valueOf: VenueTypeEnum.valueOf, enumValues: VenueTypeEnum.values)
    ..aOM<$1.DateTime>(7, _omitFieldNames ? '' : 'establishedDt', subBuilder: $1.DateTime.create)
    ..aOS(8, _omitFieldNames ? '' : 'countryCode')
    ..aOS(9, _omitFieldNames ? '' : 'cityCode')
    ..aOS(10, _omitFieldNames ? '' : 'websiteUrl')
    ..aOS(11, _omitFieldNames ? '' : 'timezone')
    ..aOM<$1.Duration>(12, _omitFieldNames ? '' : 'tradingHours', subBuilder: $1.Duration.create)
    ..pPS(13, _omitFieldNames ? '' : 'tradingDays')
    ..e<VenueStatus>(14, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: VenueStatus.VENUE_STATUS__UNKNOWN, valueOf: VenueStatus.valueOf, enumValues: VenueStatus.values)
    ..pc<OneOfIdOrParticipant>(15, _omitFieldNames ? '' : 'settlementDepositories', $pb.PbFieldType.PM, subBuilder: OneOfIdOrParticipant.create)
    ..pc<OneOfIdOrParticipant>(16, _omitFieldNames ? '' : 'clearingHouses', $pb.PbFieldType.PM, subBuilder: OneOfIdOrParticipant.create)
    ..pc<OneOfIdOrParticipant>(17, _omitFieldNames ? '' : 'regulators', $pb.PbFieldType.PM, subBuilder: OneOfIdOrParticipant.create)
    ..m<$core.String, $core.String>(101, _omitFieldNames ? '' : 'displayNames', entryClassName: 'Venue.DisplayNamesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(102, _omitFieldNames ? '' : 'descriptions', entryClassName: 'Venue.DescriptionsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(103, _omitFieldNames ? '' : 'labels', entryClassName: 'Venue.LabelsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..pPS(104, _omitFieldNames ? '' : 'tags')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'Venue.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Venue clone() => Venue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Venue copyWith(void Function(Venue) updates) => super.copyWith((message) => updates(message as Venue)) as Venue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Venue create() => Venue._();
  Venue createEmptyInstance() => create();
  static $pb.PbList<Venue> createRepeated() => $pb.PbList<Venue>();
  @$core.pragma('dart2js:noInline')
  static Venue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Venue>(create);
  static Venue? _defaultInstance;

  Venue_Market whichMarket() => _Venue_MarketByTag[$_whichOneof(0)]!;
  void clearMarket() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get iid => $_getSZ(0);
  @$pb.TagNumber(1)
  set iid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIid() => $_has(0);
  @$pb.TagNumber(1)
  void clearIid() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<FinIdentifier> get identifiers => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get marketIid => $_getSZ(2);
  @$pb.TagNumber(3)
  set marketIid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMarketIid() => $_has(2);
  @$pb.TagNumber(3)
  void clearMarketIid() => clearField(3);

  @$pb.TagNumber(4)
  Market get marketObj => $_getN(3);
  @$pb.TagNumber(4)
  set marketObj(Market v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasMarketObj() => $_has(3);
  @$pb.TagNumber(4)
  void clearMarketObj() => clearField(4);
  @$pb.TagNumber(4)
  Market ensureMarketObj() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get dominantCurrency => $_getSZ(4);
  @$pb.TagNumber(5)
  set dominantCurrency($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDominantCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearDominantCurrency() => clearField(5);

  @$pb.TagNumber(6)
  VenueTypeEnum get venueType => $_getN(5);
  @$pb.TagNumber(6)
  set venueType(VenueTypeEnum v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasVenueType() => $_has(5);
  @$pb.TagNumber(6)
  void clearVenueType() => clearField(6);

  @$pb.TagNumber(7)
  $1.DateTime get establishedDt => $_getN(6);
  @$pb.TagNumber(7)
  set establishedDt($1.DateTime v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasEstablishedDt() => $_has(6);
  @$pb.TagNumber(7)
  void clearEstablishedDt() => clearField(7);
  @$pb.TagNumber(7)
  $1.DateTime ensureEstablishedDt() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.String get countryCode => $_getSZ(7);
  @$pb.TagNumber(8)
  set countryCode($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCountryCode() => $_has(7);
  @$pb.TagNumber(8)
  void clearCountryCode() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get cityCode => $_getSZ(8);
  @$pb.TagNumber(9)
  set cityCode($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCityCode() => $_has(8);
  @$pb.TagNumber(9)
  void clearCityCode() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get websiteUrl => $_getSZ(9);
  @$pb.TagNumber(10)
  set websiteUrl($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasWebsiteUrl() => $_has(9);
  @$pb.TagNumber(10)
  void clearWebsiteUrl() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get timezone => $_getSZ(10);
  @$pb.TagNumber(11)
  set timezone($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasTimezone() => $_has(10);
  @$pb.TagNumber(11)
  void clearTimezone() => clearField(11);

  @$pb.TagNumber(12)
  $1.Duration get tradingHours => $_getN(11);
  @$pb.TagNumber(12)
  set tradingHours($1.Duration v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasTradingHours() => $_has(11);
  @$pb.TagNumber(12)
  void clearTradingHours() => clearField(12);
  @$pb.TagNumber(12)
  $1.Duration ensureTradingHours() => $_ensure(11);

  @$pb.TagNumber(13)
  $core.List<$core.String> get tradingDays => $_getList(12);

  @$pb.TagNumber(14)
  VenueStatus get status => $_getN(13);
  @$pb.TagNumber(14)
  set status(VenueStatus v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasStatus() => $_has(13);
  @$pb.TagNumber(14)
  void clearStatus() => clearField(14);

  @$pb.TagNumber(15)
  $core.List<OneOfIdOrParticipant> get settlementDepositories => $_getList(14);

  @$pb.TagNumber(16)
  $core.List<OneOfIdOrParticipant> get clearingHouses => $_getList(15);

  @$pb.TagNumber(17)
  $core.List<OneOfIdOrParticipant> get regulators => $_getList(16);

  @$pb.TagNumber(101)
  $core.Map<$core.String, $core.String> get displayNames => $_getMap(17);

  @$pb.TagNumber(102)
  $core.Map<$core.String, $core.String> get descriptions => $_getMap(18);

  @$pb.TagNumber(103)
  $core.Map<$core.String, $core.String> get labels => $_getMap(19);

  @$pb.TagNumber(104)
  $core.List<$core.String> get tags => $_getList(20);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(21);
}

enum InstrumentListing_Instrument {
  instrumentIid, 
  instrumentObj, 
  notSet
}

enum InstrumentListing_Venue {
  venueIid, 
  venueObj, 
  notSet
}

class InstrumentListing extends $pb.GeneratedMessage {
  factory InstrumentListing({
    $core.String? iid,
    $core.Iterable<FinIdentifier>? localIdentifiers,
    $core.String? instrumentIid,
    Instrument? instrumentObj,
    $core.String? venueIid,
    Venue? venueObj,
    $1.DateTime? listingDt,
    $1.DateTime? effectiveFromDt,
    $1.DateTime? effectiveToDt,
    InstrumentListingStatusEnum? status,
    $core.String? lotSize,
    $core.String? tickSize,
    $core.String? currency,
    $core.Map<$core.String, $core.String>? displayNames,
    $core.Map<$core.String, $core.String>? descriptions,
    $core.Map<$core.String, $core.String>? labels,
    $core.Iterable<$core.String>? tags,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (iid != null) {
      $result.iid = iid;
    }
    if (localIdentifiers != null) {
      $result.localIdentifiers.addAll(localIdentifiers);
    }
    if (instrumentIid != null) {
      $result.instrumentIid = instrumentIid;
    }
    if (instrumentObj != null) {
      $result.instrumentObj = instrumentObj;
    }
    if (venueIid != null) {
      $result.venueIid = venueIid;
    }
    if (venueObj != null) {
      $result.venueObj = venueObj;
    }
    if (listingDt != null) {
      $result.listingDt = listingDt;
    }
    if (effectiveFromDt != null) {
      $result.effectiveFromDt = effectiveFromDt;
    }
    if (effectiveToDt != null) {
      $result.effectiveToDt = effectiveToDt;
    }
    if (status != null) {
      $result.status = status;
    }
    if (lotSize != null) {
      $result.lotSize = lotSize;
    }
    if (tickSize != null) {
      $result.tickSize = tickSize;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (displayNames != null) {
      $result.displayNames.addAll(displayNames);
    }
    if (descriptions != null) {
      $result.descriptions.addAll(descriptions);
    }
    if (labels != null) {
      $result.labels.addAll(labels);
    }
    if (tags != null) {
      $result.tags.addAll(tags);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  InstrumentListing._() : super();
  factory InstrumentListing.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InstrumentListing.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, InstrumentListing_Instrument> _InstrumentListing_InstrumentByTag = {
    4 : InstrumentListing_Instrument.instrumentIid,
    5 : InstrumentListing_Instrument.instrumentObj,
    0 : InstrumentListing_Instrument.notSet
  };
  static const $core.Map<$core.int, InstrumentListing_Venue> _InstrumentListing_VenueByTag = {
    6 : InstrumentListing_Venue.venueIid,
    7 : InstrumentListing_Venue.venueObj,
    0 : InstrumentListing_Venue.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InstrumentListing', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..oo(0, [4, 5])
    ..oo(1, [6, 7])
    ..aOS(1, _omitFieldNames ? '' : 'iid')
    ..pc<FinIdentifier>(2, _omitFieldNames ? '' : 'localIdentifiers', $pb.PbFieldType.PM, subBuilder: FinIdentifier.create)
    ..aOS(4, _omitFieldNames ? '' : 'instrumentIid')
    ..aOM<Instrument>(5, _omitFieldNames ? '' : 'instrumentObj', subBuilder: Instrument.create)
    ..aOS(6, _omitFieldNames ? '' : 'venueIid')
    ..aOM<Venue>(7, _omitFieldNames ? '' : 'venueObj', subBuilder: Venue.create)
    ..aOM<$1.DateTime>(8, _omitFieldNames ? '' : 'listingDt', subBuilder: $1.DateTime.create)
    ..aOM<$1.DateTime>(9, _omitFieldNames ? '' : 'effectiveFromDt', subBuilder: $1.DateTime.create)
    ..aOM<$1.DateTime>(10, _omitFieldNames ? '' : 'effectiveToDt', subBuilder: $1.DateTime.create)
    ..e<InstrumentListingStatusEnum>(11, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: InstrumentListingStatusEnum.INSTRUMENT_LISTING_STATUS_ENUM__UNKNOWN, valueOf: InstrumentListingStatusEnum.valueOf, enumValues: InstrumentListingStatusEnum.values)
    ..aOS(12, _omitFieldNames ? '' : 'lotSize')
    ..aOS(13, _omitFieldNames ? '' : 'tickSize')
    ..aOS(14, _omitFieldNames ? '' : 'currency')
    ..m<$core.String, $core.String>(101, _omitFieldNames ? '' : 'displayNames', entryClassName: 'InstrumentListing.DisplayNamesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(102, _omitFieldNames ? '' : 'descriptions', entryClassName: 'InstrumentListing.DescriptionsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(103, _omitFieldNames ? '' : 'labels', entryClassName: 'InstrumentListing.LabelsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..pPS(104, _omitFieldNames ? '' : 'tags')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'InstrumentListing.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InstrumentListing clone() => InstrumentListing()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InstrumentListing copyWith(void Function(InstrumentListing) updates) => super.copyWith((message) => updates(message as InstrumentListing)) as InstrumentListing;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstrumentListing create() => InstrumentListing._();
  InstrumentListing createEmptyInstance() => create();
  static $pb.PbList<InstrumentListing> createRepeated() => $pb.PbList<InstrumentListing>();
  @$core.pragma('dart2js:noInline')
  static InstrumentListing getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InstrumentListing>(create);
  static InstrumentListing? _defaultInstance;

  InstrumentListing_Instrument whichInstrument() => _InstrumentListing_InstrumentByTag[$_whichOneof(0)]!;
  void clearInstrument() => clearField($_whichOneof(0));

  InstrumentListing_Venue whichVenue() => _InstrumentListing_VenueByTag[$_whichOneof(1)]!;
  void clearVenue() => clearField($_whichOneof(1));

  @$pb.TagNumber(1)
  $core.String get iid => $_getSZ(0);
  @$pb.TagNumber(1)
  set iid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIid() => $_has(0);
  @$pb.TagNumber(1)
  void clearIid() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<FinIdentifier> get localIdentifiers => $_getList(1);

  @$pb.TagNumber(4)
  $core.String get instrumentIid => $_getSZ(2);
  @$pb.TagNumber(4)
  set instrumentIid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasInstrumentIid() => $_has(2);
  @$pb.TagNumber(4)
  void clearInstrumentIid() => clearField(4);

  @$pb.TagNumber(5)
  Instrument get instrumentObj => $_getN(3);
  @$pb.TagNumber(5)
  set instrumentObj(Instrument v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasInstrumentObj() => $_has(3);
  @$pb.TagNumber(5)
  void clearInstrumentObj() => clearField(5);
  @$pb.TagNumber(5)
  Instrument ensureInstrumentObj() => $_ensure(3);

  @$pb.TagNumber(6)
  $core.String get venueIid => $_getSZ(4);
  @$pb.TagNumber(6)
  set venueIid($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(6)
  $core.bool hasVenueIid() => $_has(4);
  @$pb.TagNumber(6)
  void clearVenueIid() => clearField(6);

  @$pb.TagNumber(7)
  Venue get venueObj => $_getN(5);
  @$pb.TagNumber(7)
  set venueObj(Venue v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasVenueObj() => $_has(5);
  @$pb.TagNumber(7)
  void clearVenueObj() => clearField(7);
  @$pb.TagNumber(7)
  Venue ensureVenueObj() => $_ensure(5);

  @$pb.TagNumber(8)
  $1.DateTime get listingDt => $_getN(6);
  @$pb.TagNumber(8)
  set listingDt($1.DateTime v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasListingDt() => $_has(6);
  @$pb.TagNumber(8)
  void clearListingDt() => clearField(8);
  @$pb.TagNumber(8)
  $1.DateTime ensureListingDt() => $_ensure(6);

  @$pb.TagNumber(9)
  $1.DateTime get effectiveFromDt => $_getN(7);
  @$pb.TagNumber(9)
  set effectiveFromDt($1.DateTime v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasEffectiveFromDt() => $_has(7);
  @$pb.TagNumber(9)
  void clearEffectiveFromDt() => clearField(9);
  @$pb.TagNumber(9)
  $1.DateTime ensureEffectiveFromDt() => $_ensure(7);

  @$pb.TagNumber(10)
  $1.DateTime get effectiveToDt => $_getN(8);
  @$pb.TagNumber(10)
  set effectiveToDt($1.DateTime v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasEffectiveToDt() => $_has(8);
  @$pb.TagNumber(10)
  void clearEffectiveToDt() => clearField(10);
  @$pb.TagNumber(10)
  $1.DateTime ensureEffectiveToDt() => $_ensure(8);

  @$pb.TagNumber(11)
  InstrumentListingStatusEnum get status => $_getN(9);
  @$pb.TagNumber(11)
  set status(InstrumentListingStatusEnum v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(11)
  void clearStatus() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get lotSize => $_getSZ(10);
  @$pb.TagNumber(12)
  set lotSize($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(12)
  $core.bool hasLotSize() => $_has(10);
  @$pb.TagNumber(12)
  void clearLotSize() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get tickSize => $_getSZ(11);
  @$pb.TagNumber(13)
  set tickSize($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(13)
  $core.bool hasTickSize() => $_has(11);
  @$pb.TagNumber(13)
  void clearTickSize() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get currency => $_getSZ(12);
  @$pb.TagNumber(14)
  set currency($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(14)
  $core.bool hasCurrency() => $_has(12);
  @$pb.TagNumber(14)
  void clearCurrency() => clearField(14);

  @$pb.TagNumber(101)
  $core.Map<$core.String, $core.String> get displayNames => $_getMap(13);

  @$pb.TagNumber(102)
  $core.Map<$core.String, $core.String> get descriptions => $_getMap(14);

  @$pb.TagNumber(103)
  $core.Map<$core.String, $core.String> get labels => $_getMap(15);

  @$pb.TagNumber(104)
  $core.List<$core.String> get tags => $_getList(16);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(17);
}

class VenueDuration extends $pb.GeneratedMessage {
  factory VenueDuration({
    $1.Duration? duration,
    VenueStatus? status,
    $core.String? metadata,
    $core.Iterable<$core.String>? comments,
  }) {
    final $result = create();
    if (duration != null) {
      $result.duration = duration;
    }
    if (status != null) {
      $result.status = status;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    if (comments != null) {
      $result.comments.addAll(comments);
    }
    return $result;
  }
  VenueDuration._() : super();
  factory VenueDuration.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VenueDuration.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VenueDuration', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOM<$1.Duration>(1, _omitFieldNames ? '' : 'duration', subBuilder: $1.Duration.create)
    ..e<VenueStatus>(2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: VenueStatus.VENUE_STATUS__UNKNOWN, valueOf: VenueStatus.valueOf, enumValues: VenueStatus.values)
    ..aOS(3, _omitFieldNames ? '' : 'metadata')
    ..pPS(4, _omitFieldNames ? '' : 'comments')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VenueDuration clone() => VenueDuration()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VenueDuration copyWith(void Function(VenueDuration) updates) => super.copyWith((message) => updates(message as VenueDuration)) as VenueDuration;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VenueDuration create() => VenueDuration._();
  VenueDuration createEmptyInstance() => create();
  static $pb.PbList<VenueDuration> createRepeated() => $pb.PbList<VenueDuration>();
  @$core.pragma('dart2js:noInline')
  static VenueDuration getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VenueDuration>(create);
  static VenueDuration? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Duration get duration => $_getN(0);
  @$pb.TagNumber(1)
  set duration($1.Duration v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasDuration() => $_has(0);
  @$pb.TagNumber(1)
  void clearDuration() => clearField(1);
  @$pb.TagNumber(1)
  $1.Duration ensureDuration() => $_ensure(0);

  @$pb.TagNumber(2)
  VenueStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(VenueStatus v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get metadata => $_getSZ(2);
  @$pb.TagNumber(3)
  set metadata($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMetadata() => $_has(2);
  @$pb.TagNumber(3)
  void clearMetadata() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.String> get comments => $_getList(3);
}

class VenueCalendar extends $pb.GeneratedMessage {
  factory VenueCalendar({
    $core.String? venueIid,
    $1.Time? dailyOpen,
    $1.Time? dailyClose,
    $core.Iterable<VenueDuration>? calendar,
  }) {
    final $result = create();
    if (venueIid != null) {
      $result.venueIid = venueIid;
    }
    if (dailyOpen != null) {
      $result.dailyOpen = dailyOpen;
    }
    if (dailyClose != null) {
      $result.dailyClose = dailyClose;
    }
    if (calendar != null) {
      $result.calendar.addAll(calendar);
    }
    return $result;
  }
  VenueCalendar._() : super();
  factory VenueCalendar.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VenueCalendar.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VenueCalendar', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'venueIid')
    ..aOM<$1.Time>(2, _omitFieldNames ? '' : 'dailyOpen', subBuilder: $1.Time.create)
    ..aOM<$1.Time>(3, _omitFieldNames ? '' : 'dailyClose', subBuilder: $1.Time.create)
    ..pc<VenueDuration>(4, _omitFieldNames ? '' : 'calendar', $pb.PbFieldType.PM, subBuilder: VenueDuration.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VenueCalendar clone() => VenueCalendar()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VenueCalendar copyWith(void Function(VenueCalendar) updates) => super.copyWith((message) => updates(message as VenueCalendar)) as VenueCalendar;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VenueCalendar create() => VenueCalendar._();
  VenueCalendar createEmptyInstance() => create();
  static $pb.PbList<VenueCalendar> createRepeated() => $pb.PbList<VenueCalendar>();
  @$core.pragma('dart2js:noInline')
  static VenueCalendar getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VenueCalendar>(create);
  static VenueCalendar? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get venueIid => $_getSZ(0);
  @$pb.TagNumber(1)
  set venueIid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasVenueIid() => $_has(0);
  @$pb.TagNumber(1)
  void clearVenueIid() => clearField(1);

  @$pb.TagNumber(2)
  $1.Time get dailyOpen => $_getN(1);
  @$pb.TagNumber(2)
  set dailyOpen($1.Time v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDailyOpen() => $_has(1);
  @$pb.TagNumber(2)
  void clearDailyOpen() => clearField(2);
  @$pb.TagNumber(2)
  $1.Time ensureDailyOpen() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.Time get dailyClose => $_getN(2);
  @$pb.TagNumber(3)
  set dailyClose($1.Time v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasDailyClose() => $_has(2);
  @$pb.TagNumber(3)
  void clearDailyClose() => clearField(3);
  @$pb.TagNumber(3)
  $1.Time ensureDailyClose() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.List<VenueDuration> get calendar => $_getList(3);
}

class Order extends $pb.GeneratedMessage {
  factory Order({
    $core.String? orderId,
    $core.String? orderHash,
    $core.String? participantIid,
    $core.String? participantOrderId,
    $core.String? participantAccountIid,
    $core.String? investorAccountIid,
    $core.String? executorAccountIid,
    $core.String? orderType,
    OrderSide? side,
    $core.String? symbol,
    $core.String? currency,
    $core.String? quantity,
    $core.String? remainingQuantity,
    $core.String? price,
    $core.String? volume,
    $core.String? remainingVolume,
    $core.String? slippage,
    $core.String? timeInForce,
    $core.String? createTimestamp,
    $core.String? effectiveTimestamp,
    $core.String? expireTimestamp,
    $core.bool? isOffer,
    $core.bool? isDirectlyFillable,
    $core.bool? isBid,
    $core.bool? isFilled,
    $core.bool? isCancelled,
    $core.bool? isExpired,
    $core.String? creatorAddress,
    $core.String? trezorStashId,
    $core.String? offerIds,
    $core.String? parentDirectOrderId,
    $core.String? alarmAbi,
    $core.String? alarmData,
    $core.String? data,
    $core.String? dataEncoding,
    $core.String? participantData,
  }) {
    final $result = create();
    if (orderId != null) {
      $result.orderId = orderId;
    }
    if (orderHash != null) {
      $result.orderHash = orderHash;
    }
    if (participantIid != null) {
      $result.participantIid = participantIid;
    }
    if (participantOrderId != null) {
      $result.participantOrderId = participantOrderId;
    }
    if (participantAccountIid != null) {
      $result.participantAccountIid = participantAccountIid;
    }
    if (investorAccountIid != null) {
      $result.investorAccountIid = investorAccountIid;
    }
    if (executorAccountIid != null) {
      $result.executorAccountIid = executorAccountIid;
    }
    if (orderType != null) {
      $result.orderType = orderType;
    }
    if (side != null) {
      $result.side = side;
    }
    if (symbol != null) {
      $result.symbol = symbol;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (quantity != null) {
      $result.quantity = quantity;
    }
    if (remainingQuantity != null) {
      $result.remainingQuantity = remainingQuantity;
    }
    if (price != null) {
      $result.price = price;
    }
    if (volume != null) {
      $result.volume = volume;
    }
    if (remainingVolume != null) {
      $result.remainingVolume = remainingVolume;
    }
    if (slippage != null) {
      $result.slippage = slippage;
    }
    if (timeInForce != null) {
      $result.timeInForce = timeInForce;
    }
    if (createTimestamp != null) {
      $result.createTimestamp = createTimestamp;
    }
    if (effectiveTimestamp != null) {
      $result.effectiveTimestamp = effectiveTimestamp;
    }
    if (expireTimestamp != null) {
      $result.expireTimestamp = expireTimestamp;
    }
    if (isOffer != null) {
      $result.isOffer = isOffer;
    }
    if (isDirectlyFillable != null) {
      $result.isDirectlyFillable = isDirectlyFillable;
    }
    if (isBid != null) {
      $result.isBid = isBid;
    }
    if (isFilled != null) {
      $result.isFilled = isFilled;
    }
    if (isCancelled != null) {
      $result.isCancelled = isCancelled;
    }
    if (isExpired != null) {
      $result.isExpired = isExpired;
    }
    if (creatorAddress != null) {
      $result.creatorAddress = creatorAddress;
    }
    if (trezorStashId != null) {
      $result.trezorStashId = trezorStashId;
    }
    if (offerIds != null) {
      $result.offerIds = offerIds;
    }
    if (parentDirectOrderId != null) {
      $result.parentDirectOrderId = parentDirectOrderId;
    }
    if (alarmAbi != null) {
      $result.alarmAbi = alarmAbi;
    }
    if (alarmData != null) {
      $result.alarmData = alarmData;
    }
    if (data != null) {
      $result.data = data;
    }
    if (dataEncoding != null) {
      $result.dataEncoding = dataEncoding;
    }
    if (participantData != null) {
      $result.participantData = participantData;
    }
    return $result;
  }
  Order._() : super();
  factory Order.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Order.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Order', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'orderId')
    ..aOS(2, _omitFieldNames ? '' : 'orderHash')
    ..aOS(3, _omitFieldNames ? '' : 'participantIid')
    ..aOS(4, _omitFieldNames ? '' : 'participantOrderId')
    ..aOS(5, _omitFieldNames ? '' : 'participantAccountIid')
    ..aOS(6, _omitFieldNames ? '' : 'investorAccountIid')
    ..aOS(7, _omitFieldNames ? '' : 'executorAccountIid')
    ..aOS(8, _omitFieldNames ? '' : 'orderType')
    ..e<OrderSide>(9, _omitFieldNames ? '' : 'side', $pb.PbFieldType.OE, defaultOrMaker: OrderSide.ORDER_SIDE__UNKNOWN, valueOf: OrderSide.valueOf, enumValues: OrderSide.values)
    ..aOS(10, _omitFieldNames ? '' : 'symbol')
    ..aOS(11, _omitFieldNames ? '' : 'currency')
    ..aOS(12, _omitFieldNames ? '' : 'quantity')
    ..aOS(13, _omitFieldNames ? '' : 'remainingQuantity')
    ..aOS(14, _omitFieldNames ? '' : 'price')
    ..aOS(15, _omitFieldNames ? '' : 'volume')
    ..aOS(16, _omitFieldNames ? '' : 'remainingVolume')
    ..aOS(17, _omitFieldNames ? '' : 'slippage')
    ..aOS(18, _omitFieldNames ? '' : 'timeInForce')
    ..aOS(19, _omitFieldNames ? '' : 'createTimestamp')
    ..aOS(20, _omitFieldNames ? '' : 'effectiveTimestamp')
    ..aOS(21, _omitFieldNames ? '' : 'expireTimestamp')
    ..aOB(22, _omitFieldNames ? '' : 'isOffer')
    ..aOB(23, _omitFieldNames ? '' : 'isDirectlyFillable')
    ..aOB(24, _omitFieldNames ? '' : 'isBid')
    ..aOB(25, _omitFieldNames ? '' : 'isFilled')
    ..aOB(26, _omitFieldNames ? '' : 'isCancelled')
    ..aOB(27, _omitFieldNames ? '' : 'isExpired')
    ..aOS(28, _omitFieldNames ? '' : 'creatorAddress')
    ..aOS(29, _omitFieldNames ? '' : 'trezorStashId')
    ..aOS(30, _omitFieldNames ? '' : 'offerIds')
    ..aOS(31, _omitFieldNames ? '' : 'parentDirectOrderId')
    ..aOS(32, _omitFieldNames ? '' : 'alarmAbi')
    ..aOS(33, _omitFieldNames ? '' : 'alarmData')
    ..aOS(34, _omitFieldNames ? '' : 'data')
    ..aOS(35, _omitFieldNames ? '' : 'dataEncoding')
    ..aOS(36, _omitFieldNames ? '' : 'participantData')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Order clone() => Order()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Order copyWith(void Function(Order) updates) => super.copyWith((message) => updates(message as Order)) as Order;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Order create() => Order._();
  Order createEmptyInstance() => create();
  static $pb.PbList<Order> createRepeated() => $pb.PbList<Order>();
  @$core.pragma('dart2js:noInline')
  static Order getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Order>(create);
  static Order? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get orderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set orderId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOrderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrderId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get orderHash => $_getSZ(1);
  @$pb.TagNumber(2)
  set orderHash($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOrderHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrderHash() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get participantIid => $_getSZ(2);
  @$pb.TagNumber(3)
  set participantIid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasParticipantIid() => $_has(2);
  @$pb.TagNumber(3)
  void clearParticipantIid() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get participantOrderId => $_getSZ(3);
  @$pb.TagNumber(4)
  set participantOrderId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasParticipantOrderId() => $_has(3);
  @$pb.TagNumber(4)
  void clearParticipantOrderId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get participantAccountIid => $_getSZ(4);
  @$pb.TagNumber(5)
  set participantAccountIid($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasParticipantAccountIid() => $_has(4);
  @$pb.TagNumber(5)
  void clearParticipantAccountIid() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get investorAccountIid => $_getSZ(5);
  @$pb.TagNumber(6)
  set investorAccountIid($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasInvestorAccountIid() => $_has(5);
  @$pb.TagNumber(6)
  void clearInvestorAccountIid() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get executorAccountIid => $_getSZ(6);
  @$pb.TagNumber(7)
  set executorAccountIid($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasExecutorAccountIid() => $_has(6);
  @$pb.TagNumber(7)
  void clearExecutorAccountIid() => clearField(7);

  /// Order details
  @$pb.TagNumber(8)
  $core.String get orderType => $_getSZ(7);
  @$pb.TagNumber(8)
  set orderType($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasOrderType() => $_has(7);
  @$pb.TagNumber(8)
  void clearOrderType() => clearField(8);

  @$pb.TagNumber(9)
  OrderSide get side => $_getN(8);
  @$pb.TagNumber(9)
  set side(OrderSide v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasSide() => $_has(8);
  @$pb.TagNumber(9)
  void clearSide() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get symbol => $_getSZ(9);
  @$pb.TagNumber(10)
  set symbol($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasSymbol() => $_has(9);
  @$pb.TagNumber(10)
  void clearSymbol() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get currency => $_getSZ(10);
  @$pb.TagNumber(11)
  set currency($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCurrency() => $_has(10);
  @$pb.TagNumber(11)
  void clearCurrency() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get quantity => $_getSZ(11);
  @$pb.TagNumber(12)
  set quantity($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasQuantity() => $_has(11);
  @$pb.TagNumber(12)
  void clearQuantity() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get remainingQuantity => $_getSZ(12);
  @$pb.TagNumber(13)
  set remainingQuantity($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasRemainingQuantity() => $_has(12);
  @$pb.TagNumber(13)
  void clearRemainingQuantity() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get price => $_getSZ(13);
  @$pb.TagNumber(14)
  set price($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasPrice() => $_has(13);
  @$pb.TagNumber(14)
  void clearPrice() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get volume => $_getSZ(14);
  @$pb.TagNumber(15)
  set volume($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasVolume() => $_has(14);
  @$pb.TagNumber(15)
  void clearVolume() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get remainingVolume => $_getSZ(15);
  @$pb.TagNumber(16)
  set remainingVolume($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasRemainingVolume() => $_has(15);
  @$pb.TagNumber(16)
  void clearRemainingVolume() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get slippage => $_getSZ(16);
  @$pb.TagNumber(17)
  set slippage($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasSlippage() => $_has(16);
  @$pb.TagNumber(17)
  void clearSlippage() => clearField(17);

  /// Time fields
  @$pb.TagNumber(18)
  $core.String get timeInForce => $_getSZ(17);
  @$pb.TagNumber(18)
  set timeInForce($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasTimeInForce() => $_has(17);
  @$pb.TagNumber(18)
  void clearTimeInForce() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get createTimestamp => $_getSZ(18);
  @$pb.TagNumber(19)
  set createTimestamp($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasCreateTimestamp() => $_has(18);
  @$pb.TagNumber(19)
  void clearCreateTimestamp() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get effectiveTimestamp => $_getSZ(19);
  @$pb.TagNumber(20)
  set effectiveTimestamp($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasEffectiveTimestamp() => $_has(19);
  @$pb.TagNumber(20)
  void clearEffectiveTimestamp() => clearField(20);

  @$pb.TagNumber(21)
  $core.String get expireTimestamp => $_getSZ(20);
  @$pb.TagNumber(21)
  set expireTimestamp($core.String v) { $_setString(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasExpireTimestamp() => $_has(20);
  @$pb.TagNumber(21)
  void clearExpireTimestamp() => clearField(21);

  /// Status flags
  @$pb.TagNumber(22)
  $core.bool get isOffer => $_getBF(21);
  @$pb.TagNumber(22)
  set isOffer($core.bool v) { $_setBool(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasIsOffer() => $_has(21);
  @$pb.TagNumber(22)
  void clearIsOffer() => clearField(22);

  @$pb.TagNumber(23)
  $core.bool get isDirectlyFillable => $_getBF(22);
  @$pb.TagNumber(23)
  set isDirectlyFillable($core.bool v) { $_setBool(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasIsDirectlyFillable() => $_has(22);
  @$pb.TagNumber(23)
  void clearIsDirectlyFillable() => clearField(23);

  @$pb.TagNumber(24)
  $core.bool get isBid => $_getBF(23);
  @$pb.TagNumber(24)
  set isBid($core.bool v) { $_setBool(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasIsBid() => $_has(23);
  @$pb.TagNumber(24)
  void clearIsBid() => clearField(24);

  @$pb.TagNumber(25)
  $core.bool get isFilled => $_getBF(24);
  @$pb.TagNumber(25)
  set isFilled($core.bool v) { $_setBool(24, v); }
  @$pb.TagNumber(25)
  $core.bool hasIsFilled() => $_has(24);
  @$pb.TagNumber(25)
  void clearIsFilled() => clearField(25);

  @$pb.TagNumber(26)
  $core.bool get isCancelled => $_getBF(25);
  @$pb.TagNumber(26)
  set isCancelled($core.bool v) { $_setBool(25, v); }
  @$pb.TagNumber(26)
  $core.bool hasIsCancelled() => $_has(25);
  @$pb.TagNumber(26)
  void clearIsCancelled() => clearField(26);

  @$pb.TagNumber(27)
  $core.bool get isExpired => $_getBF(26);
  @$pb.TagNumber(27)
  set isExpired($core.bool v) { $_setBool(26, v); }
  @$pb.TagNumber(27)
  $core.bool hasIsExpired() => $_has(26);
  @$pb.TagNumber(27)
  void clearIsExpired() => clearField(27);

  /// Additional data
  @$pb.TagNumber(28)
  $core.String get creatorAddress => $_getSZ(27);
  @$pb.TagNumber(28)
  set creatorAddress($core.String v) { $_setString(27, v); }
  @$pb.TagNumber(28)
  $core.bool hasCreatorAddress() => $_has(27);
  @$pb.TagNumber(28)
  void clearCreatorAddress() => clearField(28);

  @$pb.TagNumber(29)
  $core.String get trezorStashId => $_getSZ(28);
  @$pb.TagNumber(29)
  set trezorStashId($core.String v) { $_setString(28, v); }
  @$pb.TagNumber(29)
  $core.bool hasTrezorStashId() => $_has(28);
  @$pb.TagNumber(29)
  void clearTrezorStashId() => clearField(29);

  @$pb.TagNumber(30)
  $core.String get offerIds => $_getSZ(29);
  @$pb.TagNumber(30)
  set offerIds($core.String v) { $_setString(29, v); }
  @$pb.TagNumber(30)
  $core.bool hasOfferIds() => $_has(29);
  @$pb.TagNumber(30)
  void clearOfferIds() => clearField(30);

  @$pb.TagNumber(31)
  $core.String get parentDirectOrderId => $_getSZ(30);
  @$pb.TagNumber(31)
  set parentDirectOrderId($core.String v) { $_setString(30, v); }
  @$pb.TagNumber(31)
  $core.bool hasParentDirectOrderId() => $_has(30);
  @$pb.TagNumber(31)
  void clearParentDirectOrderId() => clearField(31);

  @$pb.TagNumber(32)
  $core.String get alarmAbi => $_getSZ(31);
  @$pb.TagNumber(32)
  set alarmAbi($core.String v) { $_setString(31, v); }
  @$pb.TagNumber(32)
  $core.bool hasAlarmAbi() => $_has(31);
  @$pb.TagNumber(32)
  void clearAlarmAbi() => clearField(32);

  @$pb.TagNumber(33)
  $core.String get alarmData => $_getSZ(32);
  @$pb.TagNumber(33)
  set alarmData($core.String v) { $_setString(32, v); }
  @$pb.TagNumber(33)
  $core.bool hasAlarmData() => $_has(32);
  @$pb.TagNumber(33)
  void clearAlarmData() => clearField(33);

  @$pb.TagNumber(34)
  $core.String get data => $_getSZ(33);
  @$pb.TagNumber(34)
  set data($core.String v) { $_setString(33, v); }
  @$pb.TagNumber(34)
  $core.bool hasData() => $_has(33);
  @$pb.TagNumber(34)
  void clearData() => clearField(34);

  @$pb.TagNumber(35)
  $core.String get dataEncoding => $_getSZ(34);
  @$pb.TagNumber(35)
  set dataEncoding($core.String v) { $_setString(34, v); }
  @$pb.TagNumber(35)
  $core.bool hasDataEncoding() => $_has(34);
  @$pb.TagNumber(35)
  void clearDataEncoding() => clearField(35);

  @$pb.TagNumber(36)
  $core.String get participantData => $_getSZ(35);
  @$pb.TagNumber(36)
  set participantData($core.String v) { $_setString(35, v); }
  @$pb.TagNumber(36)
  $core.bool hasParticipantData() => $_has(35);
  @$pb.TagNumber(36)
  void clearParticipantData() => clearField(36);
}

class Trade extends $pb.GeneratedMessage {
  factory Trade({
    $core.String? tradeId,
    $core.String? tradeHash,
    $core.String? timestamp,
    $core.String? creatorAddress,
    $core.String? tradeType,
    $core.bool? isBuy,
    $core.String? bidOrderId,
    $core.String? askOrderId,
    $core.String? quantity,
    $core.String? price,
    $core.String? volume,
    $core.String? bidFee,
    $core.String? askFee,
    $core.String? dataAbi,
    $core.String? data,
  }) {
    final $result = create();
    if (tradeId != null) {
      $result.tradeId = tradeId;
    }
    if (tradeHash != null) {
      $result.tradeHash = tradeHash;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    if (creatorAddress != null) {
      $result.creatorAddress = creatorAddress;
    }
    if (tradeType != null) {
      $result.tradeType = tradeType;
    }
    if (isBuy != null) {
      $result.isBuy = isBuy;
    }
    if (bidOrderId != null) {
      $result.bidOrderId = bidOrderId;
    }
    if (askOrderId != null) {
      $result.askOrderId = askOrderId;
    }
    if (quantity != null) {
      $result.quantity = quantity;
    }
    if (price != null) {
      $result.price = price;
    }
    if (volume != null) {
      $result.volume = volume;
    }
    if (bidFee != null) {
      $result.bidFee = bidFee;
    }
    if (askFee != null) {
      $result.askFee = askFee;
    }
    if (dataAbi != null) {
      $result.dataAbi = dataAbi;
    }
    if (data != null) {
      $result.data = data;
    }
    return $result;
  }
  Trade._() : super();
  factory Trade.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Trade.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Trade', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'tradeId')
    ..aOS(2, _omitFieldNames ? '' : 'tradeHash')
    ..aOS(3, _omitFieldNames ? '' : 'timestamp')
    ..aOS(4, _omitFieldNames ? '' : 'creatorAddress')
    ..aOS(5, _omitFieldNames ? '' : 'tradeType')
    ..aOB(6, _omitFieldNames ? '' : 'isBuy')
    ..aOS(7, _omitFieldNames ? '' : 'bidOrderId')
    ..aOS(8, _omitFieldNames ? '' : 'askOrderId')
    ..aOS(9, _omitFieldNames ? '' : 'quantity')
    ..aOS(10, _omitFieldNames ? '' : 'price')
    ..aOS(11, _omitFieldNames ? '' : 'volume')
    ..aOS(12, _omitFieldNames ? '' : 'bidFee')
    ..aOS(13, _omitFieldNames ? '' : 'askFee')
    ..aOS(14, _omitFieldNames ? '' : 'dataAbi')
    ..aOS(15, _omitFieldNames ? '' : 'data')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Trade clone() => Trade()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Trade copyWith(void Function(Trade) updates) => super.copyWith((message) => updates(message as Trade)) as Trade;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Trade create() => Trade._();
  Trade createEmptyInstance() => create();
  static $pb.PbList<Trade> createRepeated() => $pb.PbList<Trade>();
  @$core.pragma('dart2js:noInline')
  static Trade getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Trade>(create);
  static Trade? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get tradeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set tradeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTradeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTradeId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get tradeHash => $_getSZ(1);
  @$pb.TagNumber(2)
  set tradeHash($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTradeHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearTradeHash() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get timestamp => $_getSZ(2);
  @$pb.TagNumber(3)
  set timestamp($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get creatorAddress => $_getSZ(3);
  @$pb.TagNumber(4)
  set creatorAddress($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCreatorAddress() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatorAddress() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get tradeType => $_getSZ(4);
  @$pb.TagNumber(5)
  set tradeType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTradeType() => $_has(4);
  @$pb.TagNumber(5)
  void clearTradeType() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isBuy => $_getBF(5);
  @$pb.TagNumber(6)
  set isBuy($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIsBuy() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsBuy() => clearField(6);

  /// Order references
  @$pb.TagNumber(7)
  $core.String get bidOrderId => $_getSZ(6);
  @$pb.TagNumber(7)
  set bidOrderId($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasBidOrderId() => $_has(6);
  @$pb.TagNumber(7)
  void clearBidOrderId() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get askOrderId => $_getSZ(7);
  @$pb.TagNumber(8)
  set askOrderId($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasAskOrderId() => $_has(7);
  @$pb.TagNumber(8)
  void clearAskOrderId() => clearField(8);

  /// Trade details
  @$pb.TagNumber(9)
  $core.String get quantity => $_getSZ(8);
  @$pb.TagNumber(9)
  set quantity($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasQuantity() => $_has(8);
  @$pb.TagNumber(9)
  void clearQuantity() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get price => $_getSZ(9);
  @$pb.TagNumber(10)
  set price($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasPrice() => $_has(9);
  @$pb.TagNumber(10)
  void clearPrice() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get volume => $_getSZ(10);
  @$pb.TagNumber(11)
  set volume($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasVolume() => $_has(10);
  @$pb.TagNumber(11)
  void clearVolume() => clearField(11);

  /// Fees
  @$pb.TagNumber(12)
  $core.String get bidFee => $_getSZ(11);
  @$pb.TagNumber(12)
  set bidFee($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasBidFee() => $_has(11);
  @$pb.TagNumber(12)
  void clearBidFee() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get askFee => $_getSZ(12);
  @$pb.TagNumber(13)
  set askFee($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasAskFee() => $_has(12);
  @$pb.TagNumber(13)
  void clearAskFee() => clearField(13);

  /// Additional data
  @$pb.TagNumber(14)
  $core.String get dataAbi => $_getSZ(13);
  @$pb.TagNumber(14)
  set dataAbi($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasDataAbi() => $_has(13);
  @$pb.TagNumber(14)
  void clearDataAbi() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get data => $_getSZ(14);
  @$pb.TagNumber(15)
  set data($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasData() => $_has(14);
  @$pb.TagNumber(15)
  void clearData() => clearField(15);
}

class Settlement extends $pb.GeneratedMessage {
  factory Settlement({
    $core.String? settlementId,
    $core.String? settlementHash,
    $core.String? timestamp,
    $core.String? tradeId,
    $core.String? tradeHash,
    ConfirmationStatus? confirmationStatus,
    $core.String? settlementType,
    $core.String? buyerAccount,
    $core.String? sellerAccount,
    $core.String? assetTransferred,
    $core.String? amountTransferred,
    $core.String? currencyTransferred,
    $core.String? currencyAmount,
    $core.String? ledgerId,
    $core.String? vaultAddress,
    $core.String? reserveId,
    $core.String? failureReason,
    $core.String? data,
  }) {
    final $result = create();
    if (settlementId != null) {
      $result.settlementId = settlementId;
    }
    if (settlementHash != null) {
      $result.settlementHash = settlementHash;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    if (tradeId != null) {
      $result.tradeId = tradeId;
    }
    if (tradeHash != null) {
      $result.tradeHash = tradeHash;
    }
    if (confirmationStatus != null) {
      $result.confirmationStatus = confirmationStatus;
    }
    if (settlementType != null) {
      $result.settlementType = settlementType;
    }
    if (buyerAccount != null) {
      $result.buyerAccount = buyerAccount;
    }
    if (sellerAccount != null) {
      $result.sellerAccount = sellerAccount;
    }
    if (assetTransferred != null) {
      $result.assetTransferred = assetTransferred;
    }
    if (amountTransferred != null) {
      $result.amountTransferred = amountTransferred;
    }
    if (currencyTransferred != null) {
      $result.currencyTransferred = currencyTransferred;
    }
    if (currencyAmount != null) {
      $result.currencyAmount = currencyAmount;
    }
    if (ledgerId != null) {
      $result.ledgerId = ledgerId;
    }
    if (vaultAddress != null) {
      $result.vaultAddress = vaultAddress;
    }
    if (reserveId != null) {
      $result.reserveId = reserveId;
    }
    if (failureReason != null) {
      $result.failureReason = failureReason;
    }
    if (data != null) {
      $result.data = data;
    }
    return $result;
  }
  Settlement._() : super();
  factory Settlement.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Settlement.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Settlement', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'settlementId')
    ..aOS(2, _omitFieldNames ? '' : 'settlementHash')
    ..aOS(3, _omitFieldNames ? '' : 'timestamp')
    ..aOS(4, _omitFieldNames ? '' : 'tradeId')
    ..aOS(5, _omitFieldNames ? '' : 'tradeHash')
    ..e<ConfirmationStatus>(6, _omitFieldNames ? '' : 'confirmationStatus', $pb.PbFieldType.OE, defaultOrMaker: ConfirmationStatus.CONFIRMATION_STATUS__UNKNOWN, valueOf: ConfirmationStatus.valueOf, enumValues: ConfirmationStatus.values)
    ..aOS(7, _omitFieldNames ? '' : 'settlementType')
    ..aOS(8, _omitFieldNames ? '' : 'buyerAccount')
    ..aOS(9, _omitFieldNames ? '' : 'sellerAccount')
    ..aOS(10, _omitFieldNames ? '' : 'assetTransferred')
    ..aOS(11, _omitFieldNames ? '' : 'amountTransferred')
    ..aOS(12, _omitFieldNames ? '' : 'currencyTransferred')
    ..aOS(13, _omitFieldNames ? '' : 'currencyAmount')
    ..aOS(14, _omitFieldNames ? '' : 'ledgerId')
    ..aOS(15, _omitFieldNames ? '' : 'vaultAddress')
    ..aOS(16, _omitFieldNames ? '' : 'reserveId')
    ..aOS(17, _omitFieldNames ? '' : 'failureReason')
    ..aOS(18, _omitFieldNames ? '' : 'data')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Settlement clone() => Settlement()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Settlement copyWith(void Function(Settlement) updates) => super.copyWith((message) => updates(message as Settlement)) as Settlement;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Settlement create() => Settlement._();
  Settlement createEmptyInstance() => create();
  static $pb.PbList<Settlement> createRepeated() => $pb.PbList<Settlement>();
  @$core.pragma('dart2js:noInline')
  static Settlement getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Settlement>(create);
  static Settlement? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get settlementId => $_getSZ(0);
  @$pb.TagNumber(1)
  set settlementId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSettlementId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSettlementId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get settlementHash => $_getSZ(1);
  @$pb.TagNumber(2)
  set settlementHash($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSettlementHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearSettlementHash() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get timestamp => $_getSZ(2);
  @$pb.TagNumber(3)
  set timestamp($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => clearField(3);

  /// Trade reference
  @$pb.TagNumber(4)
  $core.String get tradeId => $_getSZ(3);
  @$pb.TagNumber(4)
  set tradeId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTradeId() => $_has(3);
  @$pb.TagNumber(4)
  void clearTradeId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get tradeHash => $_getSZ(4);
  @$pb.TagNumber(5)
  set tradeHash($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTradeHash() => $_has(4);
  @$pb.TagNumber(5)
  void clearTradeHash() => clearField(5);

  /// Settlement status
  @$pb.TagNumber(6)
  ConfirmationStatus get confirmationStatus => $_getN(5);
  @$pb.TagNumber(6)
  set confirmationStatus(ConfirmationStatus v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasConfirmationStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearConfirmationStatus() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get settlementType => $_getSZ(6);
  @$pb.TagNumber(7)
  set settlementType($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSettlementType() => $_has(6);
  @$pb.TagNumber(7)
  void clearSettlementType() => clearField(7);

  /// Parties involved
  @$pb.TagNumber(8)
  $core.String get buyerAccount => $_getSZ(7);
  @$pb.TagNumber(8)
  set buyerAccount($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasBuyerAccount() => $_has(7);
  @$pb.TagNumber(8)
  void clearBuyerAccount() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get sellerAccount => $_getSZ(8);
  @$pb.TagNumber(9)
  set sellerAccount($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasSellerAccount() => $_has(8);
  @$pb.TagNumber(9)
  void clearSellerAccount() => clearField(9);

  /// Settlement details
  @$pb.TagNumber(10)
  $core.String get assetTransferred => $_getSZ(9);
  @$pb.TagNumber(10)
  set assetTransferred($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasAssetTransferred() => $_has(9);
  @$pb.TagNumber(10)
  void clearAssetTransferred() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get amountTransferred => $_getSZ(10);
  @$pb.TagNumber(11)
  set amountTransferred($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasAmountTransferred() => $_has(10);
  @$pb.TagNumber(11)
  void clearAmountTransferred() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get currencyTransferred => $_getSZ(11);
  @$pb.TagNumber(12)
  set currencyTransferred($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasCurrencyTransferred() => $_has(11);
  @$pb.TagNumber(12)
  void clearCurrencyTransferred() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get currencyAmount => $_getSZ(12);
  @$pb.TagNumber(13)
  set currencyAmount($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasCurrencyAmount() => $_has(12);
  @$pb.TagNumber(13)
  void clearCurrencyAmount() => clearField(13);

  /// Settlement location
  @$pb.TagNumber(14)
  $core.String get ledgerId => $_getSZ(13);
  @$pb.TagNumber(14)
  set ledgerId($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasLedgerId() => $_has(13);
  @$pb.TagNumber(14)
  void clearLedgerId() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get vaultAddress => $_getSZ(14);
  @$pb.TagNumber(15)
  set vaultAddress($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasVaultAddress() => $_has(14);
  @$pb.TagNumber(15)
  void clearVaultAddress() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get reserveId => $_getSZ(15);
  @$pb.TagNumber(16)
  set reserveId($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasReserveId() => $_has(15);
  @$pb.TagNumber(16)
  void clearReserveId() => clearField(16);

  /// Additional data
  @$pb.TagNumber(17)
  $core.String get failureReason => $_getSZ(16);
  @$pb.TagNumber(17)
  set failureReason($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasFailureReason() => $_has(16);
  @$pb.TagNumber(17)
  void clearFailureReason() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get data => $_getSZ(17);
  @$pb.TagNumber(18)
  set data($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasData() => $_has(17);
  @$pb.TagNumber(18)
  void clearData() => clearField(18);
}

class OrderEvent extends $pb.GeneratedMessage {
  factory OrderEvent({
    $core.String? orderEventId,
    $core.String? orderEventHash,
    $core.String? orderEventTimestamp,
    $core.String? orderEventType,
    $core.String? orderEventVersion,
    Order? order,
    Order? otherOrder,
    Trade? trade,
    $core.String? chainId,
    $core.String? chainName,
    $core.String? engineAddress,
    $core.String? indexTimestamp,
    $core.String? indexBlockTimestamp,
    $core.String? indexBlockNumber,
    $core.String? indexTxHash,
    $fixnum.Int64? indexTxLogIdx,
    $core.String? pairId,
    $core.String? pairBaseTokenSymbol,
    $core.String? pairQuoteTokenSymbol,
    $core.String? commandId,
    $core.String? commandRequestId,
    $core.String? commandTimestamp,
    $core.String? commandOrigin,
    $core.String? commandParticipantId,
    $core.String? commandOperation,
    $core.String? orderEventData,
  }) {
    final $result = create();
    if (orderEventId != null) {
      $result.orderEventId = orderEventId;
    }
    if (orderEventHash != null) {
      $result.orderEventHash = orderEventHash;
    }
    if (orderEventTimestamp != null) {
      $result.orderEventTimestamp = orderEventTimestamp;
    }
    if (orderEventType != null) {
      $result.orderEventType = orderEventType;
    }
    if (orderEventVersion != null) {
      $result.orderEventVersion = orderEventVersion;
    }
    if (order != null) {
      $result.order = order;
    }
    if (otherOrder != null) {
      $result.otherOrder = otherOrder;
    }
    if (trade != null) {
      $result.trade = trade;
    }
    if (chainId != null) {
      $result.chainId = chainId;
    }
    if (chainName != null) {
      $result.chainName = chainName;
    }
    if (engineAddress != null) {
      $result.engineAddress = engineAddress;
    }
    if (indexTimestamp != null) {
      $result.indexTimestamp = indexTimestamp;
    }
    if (indexBlockTimestamp != null) {
      $result.indexBlockTimestamp = indexBlockTimestamp;
    }
    if (indexBlockNumber != null) {
      $result.indexBlockNumber = indexBlockNumber;
    }
    if (indexTxHash != null) {
      $result.indexTxHash = indexTxHash;
    }
    if (indexTxLogIdx != null) {
      $result.indexTxLogIdx = indexTxLogIdx;
    }
    if (pairId != null) {
      $result.pairId = pairId;
    }
    if (pairBaseTokenSymbol != null) {
      $result.pairBaseTokenSymbol = pairBaseTokenSymbol;
    }
    if (pairQuoteTokenSymbol != null) {
      $result.pairQuoteTokenSymbol = pairQuoteTokenSymbol;
    }
    if (commandId != null) {
      $result.commandId = commandId;
    }
    if (commandRequestId != null) {
      $result.commandRequestId = commandRequestId;
    }
    if (commandTimestamp != null) {
      $result.commandTimestamp = commandTimestamp;
    }
    if (commandOrigin != null) {
      $result.commandOrigin = commandOrigin;
    }
    if (commandParticipantId != null) {
      $result.commandParticipantId = commandParticipantId;
    }
    if (commandOperation != null) {
      $result.commandOperation = commandOperation;
    }
    if (orderEventData != null) {
      $result.orderEventData = orderEventData;
    }
    return $result;
  }
  OrderEvent._() : super();
  factory OrderEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OrderEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OrderEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'orderEventId')
    ..aOS(2, _omitFieldNames ? '' : 'orderEventHash')
    ..aOS(3, _omitFieldNames ? '' : 'orderEventTimestamp')
    ..aOS(4, _omitFieldNames ? '' : 'orderEventType')
    ..aOS(5, _omitFieldNames ? '' : 'orderEventVersion')
    ..aOM<Order>(6, _omitFieldNames ? '' : 'order', subBuilder: Order.create)
    ..aOM<Order>(7, _omitFieldNames ? '' : 'otherOrder', subBuilder: Order.create)
    ..aOM<Trade>(8, _omitFieldNames ? '' : 'trade', subBuilder: Trade.create)
    ..aOS(9, _omitFieldNames ? '' : 'chainId')
    ..aOS(10, _omitFieldNames ? '' : 'chainName')
    ..aOS(11, _omitFieldNames ? '' : 'engineAddress')
    ..aOS(12, _omitFieldNames ? '' : 'indexTimestamp')
    ..aOS(13, _omitFieldNames ? '' : 'indexBlockTimestamp')
    ..aOS(14, _omitFieldNames ? '' : 'indexBlockNumber')
    ..aOS(15, _omitFieldNames ? '' : 'indexTxHash')
    ..aInt64(16, _omitFieldNames ? '' : 'indexTxLogIdx')
    ..aOS(17, _omitFieldNames ? '' : 'pairId')
    ..aOS(18, _omitFieldNames ? '' : 'pairBaseTokenSymbol')
    ..aOS(19, _omitFieldNames ? '' : 'pairQuoteTokenSymbol')
    ..aOS(20, _omitFieldNames ? '' : 'commandId')
    ..aOS(21, _omitFieldNames ? '' : 'commandRequestId')
    ..aOS(22, _omitFieldNames ? '' : 'commandTimestamp')
    ..aOS(23, _omitFieldNames ? '' : 'commandOrigin')
    ..aOS(24, _omitFieldNames ? '' : 'commandParticipantId')
    ..aOS(25, _omitFieldNames ? '' : 'commandOperation')
    ..aOS(26, _omitFieldNames ? '' : 'orderEventData')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OrderEvent clone() => OrderEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OrderEvent copyWith(void Function(OrderEvent) updates) => super.copyWith((message) => updates(message as OrderEvent)) as OrderEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OrderEvent create() => OrderEvent._();
  OrderEvent createEmptyInstance() => create();
  static $pb.PbList<OrderEvent> createRepeated() => $pb.PbList<OrderEvent>();
  @$core.pragma('dart2js:noInline')
  static OrderEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OrderEvent>(create);
  static OrderEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get orderEventId => $_getSZ(0);
  @$pb.TagNumber(1)
  set orderEventId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOrderEventId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrderEventId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get orderEventHash => $_getSZ(1);
  @$pb.TagNumber(2)
  set orderEventHash($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOrderEventHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrderEventHash() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get orderEventTimestamp => $_getSZ(2);
  @$pb.TagNumber(3)
  set orderEventTimestamp($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOrderEventTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearOrderEventTimestamp() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get orderEventType => $_getSZ(3);
  @$pb.TagNumber(4)
  set orderEventType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOrderEventType() => $_has(3);
  @$pb.TagNumber(4)
  void clearOrderEventType() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get orderEventVersion => $_getSZ(4);
  @$pb.TagNumber(5)
  set orderEventVersion($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasOrderEventVersion() => $_has(4);
  @$pb.TagNumber(5)
  void clearOrderEventVersion() => clearField(5);

  /// Order reference
  @$pb.TagNumber(6)
  Order get order => $_getN(5);
  @$pb.TagNumber(6)
  set order(Order v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasOrder() => $_has(5);
  @$pb.TagNumber(6)
  void clearOrder() => clearField(6);
  @$pb.TagNumber(6)
  Order ensureOrder() => $_ensure(5);

  @$pb.TagNumber(7)
  Order get otherOrder => $_getN(6);
  @$pb.TagNumber(7)
  set otherOrder(Order v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasOtherOrder() => $_has(6);
  @$pb.TagNumber(7)
  void clearOtherOrder() => clearField(7);
  @$pb.TagNumber(7)
  Order ensureOtherOrder() => $_ensure(6);

  /// Trade reference (if applicable)
  @$pb.TagNumber(8)
  Trade get trade => $_getN(7);
  @$pb.TagNumber(8)
  set trade(Trade v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasTrade() => $_has(7);
  @$pb.TagNumber(8)
  void clearTrade() => clearField(8);
  @$pb.TagNumber(8)
  Trade ensureTrade() => $_ensure(7);

  /// Chain and indexing information
  @$pb.TagNumber(9)
  $core.String get chainId => $_getSZ(8);
  @$pb.TagNumber(9)
  set chainId($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasChainId() => $_has(8);
  @$pb.TagNumber(9)
  void clearChainId() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get chainName => $_getSZ(9);
  @$pb.TagNumber(10)
  set chainName($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasChainName() => $_has(9);
  @$pb.TagNumber(10)
  void clearChainName() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get engineAddress => $_getSZ(10);
  @$pb.TagNumber(11)
  set engineAddress($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasEngineAddress() => $_has(10);
  @$pb.TagNumber(11)
  void clearEngineAddress() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get indexTimestamp => $_getSZ(11);
  @$pb.TagNumber(12)
  set indexTimestamp($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasIndexTimestamp() => $_has(11);
  @$pb.TagNumber(12)
  void clearIndexTimestamp() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get indexBlockTimestamp => $_getSZ(12);
  @$pb.TagNumber(13)
  set indexBlockTimestamp($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasIndexBlockTimestamp() => $_has(12);
  @$pb.TagNumber(13)
  void clearIndexBlockTimestamp() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get indexBlockNumber => $_getSZ(13);
  @$pb.TagNumber(14)
  set indexBlockNumber($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasIndexBlockNumber() => $_has(13);
  @$pb.TagNumber(14)
  void clearIndexBlockNumber() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get indexTxHash => $_getSZ(14);
  @$pb.TagNumber(15)
  set indexTxHash($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasIndexTxHash() => $_has(14);
  @$pb.TagNumber(15)
  void clearIndexTxHash() => clearField(15);

  @$pb.TagNumber(16)
  $fixnum.Int64 get indexTxLogIdx => $_getI64(15);
  @$pb.TagNumber(16)
  set indexTxLogIdx($fixnum.Int64 v) { $_setInt64(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasIndexTxLogIdx() => $_has(15);
  @$pb.TagNumber(16)
  void clearIndexTxLogIdx() => clearField(16);

  /// Pair information
  @$pb.TagNumber(17)
  $core.String get pairId => $_getSZ(16);
  @$pb.TagNumber(17)
  set pairId($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasPairId() => $_has(16);
  @$pb.TagNumber(17)
  void clearPairId() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get pairBaseTokenSymbol => $_getSZ(17);
  @$pb.TagNumber(18)
  set pairBaseTokenSymbol($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasPairBaseTokenSymbol() => $_has(17);
  @$pb.TagNumber(18)
  void clearPairBaseTokenSymbol() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get pairQuoteTokenSymbol => $_getSZ(18);
  @$pb.TagNumber(19)
  set pairQuoteTokenSymbol($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasPairQuoteTokenSymbol() => $_has(18);
  @$pb.TagNumber(19)
  void clearPairQuoteTokenSymbol() => clearField(19);

  /// Command information (for audit)
  @$pb.TagNumber(20)
  $core.String get commandId => $_getSZ(19);
  @$pb.TagNumber(20)
  set commandId($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasCommandId() => $_has(19);
  @$pb.TagNumber(20)
  void clearCommandId() => clearField(20);

  @$pb.TagNumber(21)
  $core.String get commandRequestId => $_getSZ(20);
  @$pb.TagNumber(21)
  set commandRequestId($core.String v) { $_setString(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasCommandRequestId() => $_has(20);
  @$pb.TagNumber(21)
  void clearCommandRequestId() => clearField(21);

  @$pb.TagNumber(22)
  $core.String get commandTimestamp => $_getSZ(21);
  @$pb.TagNumber(22)
  set commandTimestamp($core.String v) { $_setString(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasCommandTimestamp() => $_has(21);
  @$pb.TagNumber(22)
  void clearCommandTimestamp() => clearField(22);

  @$pb.TagNumber(23)
  $core.String get commandOrigin => $_getSZ(22);
  @$pb.TagNumber(23)
  set commandOrigin($core.String v) { $_setString(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasCommandOrigin() => $_has(22);
  @$pb.TagNumber(23)
  void clearCommandOrigin() => clearField(23);

  @$pb.TagNumber(24)
  $core.String get commandParticipantId => $_getSZ(23);
  @$pb.TagNumber(24)
  set commandParticipantId($core.String v) { $_setString(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasCommandParticipantId() => $_has(23);
  @$pb.TagNumber(24)
  void clearCommandParticipantId() => clearField(24);

  @$pb.TagNumber(25)
  $core.String get commandOperation => $_getSZ(24);
  @$pb.TagNumber(25)
  set commandOperation($core.String v) { $_setString(24, v); }
  @$pb.TagNumber(25)
  $core.bool hasCommandOperation() => $_has(24);
  @$pb.TagNumber(25)
  void clearCommandOperation() => clearField(25);

  /// Additional event data
  @$pb.TagNumber(26)
  $core.String get orderEventData => $_getSZ(25);
  @$pb.TagNumber(26)
  set orderEventData($core.String v) { $_setString(25, v); }
  @$pb.TagNumber(26)
  $core.bool hasOrderEventData() => $_has(25);
  @$pb.TagNumber(26)
  void clearOrderEventData() => clearField(26);
}

/// Transaction message reflects Activity structure with from/to accounts and stashes
/// This structure mirrors the Activity model from pkg/chain/trezor/activity.go
class Transaction extends $pb.GeneratedMessage {
  factory Transaction({
    $core.String? transactionId,
    $core.String? transactionHash,
    $1.Time? timestamp,
    TransactionTypeEnum? type,
    $core.String? operation,
    $core.String? accountIid,
    $core.String? fromAccountIid,
    $core.String? toAccountIid,
    $core.String? fromReserveId,
    $core.String? toReserveId,
    $core.String? fromStash,
    $core.String? toStash,
    $core.String? assetIid,
    $core.String? amount,
    $core.String? referenceId,
    $core.String? referenceType,
    $core.Map<$core.String, $core.String>? displayNames,
    $core.Map<$core.String, $core.String>? descriptions,
    $core.Map<$core.String, $core.String>? labels,
    $core.Iterable<$core.String>? tags,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (transactionHash != null) {
      $result.transactionHash = transactionHash;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    if (type != null) {
      $result.type = type;
    }
    if (operation != null) {
      $result.operation = operation;
    }
    if (accountIid != null) {
      $result.accountIid = accountIid;
    }
    if (fromAccountIid != null) {
      $result.fromAccountIid = fromAccountIid;
    }
    if (toAccountIid != null) {
      $result.toAccountIid = toAccountIid;
    }
    if (fromReserveId != null) {
      $result.fromReserveId = fromReserveId;
    }
    if (toReserveId != null) {
      $result.toReserveId = toReserveId;
    }
    if (fromStash != null) {
      $result.fromStash = fromStash;
    }
    if (toStash != null) {
      $result.toStash = toStash;
    }
    if (assetIid != null) {
      $result.assetIid = assetIid;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (referenceId != null) {
      $result.referenceId = referenceId;
    }
    if (referenceType != null) {
      $result.referenceType = referenceType;
    }
    if (displayNames != null) {
      $result.displayNames.addAll(displayNames);
    }
    if (descriptions != null) {
      $result.descriptions.addAll(descriptions);
    }
    if (labels != null) {
      $result.labels.addAll(labels);
    }
    if (tags != null) {
      $result.tags.addAll(tags);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  Transaction._() : super();
  factory Transaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Transaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Transaction', package: const $pb.PackageName(_omitMessageNames ? '' : 'qomet.agora.daemons.prtagent.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..aOS(2, _omitFieldNames ? '' : 'transactionHash')
    ..aOM<$1.Time>(3, _omitFieldNames ? '' : 'timestamp', subBuilder: $1.Time.create)
    ..e<TransactionTypeEnum>(4, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: TransactionTypeEnum.TRANSACTION_TYPE_ENUM__UNKNOWN, valueOf: TransactionTypeEnum.valueOf, enumValues: TransactionTypeEnum.values)
    ..aOS(5, _omitFieldNames ? '' : 'operation')
    ..aOS(6, _omitFieldNames ? '' : 'accountIid')
    ..aOS(7, _omitFieldNames ? '' : 'fromAccountIid')
    ..aOS(8, _omitFieldNames ? '' : 'toAccountIid')
    ..aOS(9, _omitFieldNames ? '' : 'fromReserveId')
    ..aOS(10, _omitFieldNames ? '' : 'toReserveId')
    ..aOS(11, _omitFieldNames ? '' : 'fromStash')
    ..aOS(12, _omitFieldNames ? '' : 'toStash')
    ..aOS(13, _omitFieldNames ? '' : 'assetIid')
    ..aOS(14, _omitFieldNames ? '' : 'amount')
    ..aOS(15, _omitFieldNames ? '' : 'referenceId')
    ..aOS(16, _omitFieldNames ? '' : 'referenceType')
    ..m<$core.String, $core.String>(101, _omitFieldNames ? '' : 'displayNames', entryClassName: 'Transaction.DisplayNamesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(102, _omitFieldNames ? '' : 'descriptions', entryClassName: 'Transaction.DescriptionsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..m<$core.String, $core.String>(103, _omitFieldNames ? '' : 'labels', entryClassName: 'Transaction.LabelsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..pPS(104, _omitFieldNames ? '' : 'tags')
    ..m<$core.String, $core.String>(105, _omitFieldNames ? '' : 'metadata', entryClassName: 'Transaction.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('qomet.agora.daemons.prtagent.v1'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Transaction clone() => Transaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Transaction copyWith(void Function(Transaction) updates) => super.copyWith((message) => updates(message as Transaction)) as Transaction;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Transaction create() => Transaction._();
  Transaction createEmptyInstance() => create();
  static $pb.PbList<Transaction> createRepeated() => $pb.PbList<Transaction>();
  @$core.pragma('dart2js:noInline')
  static Transaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Transaction>(create);
  static Transaction? _defaultInstance;

  /// Core identifiers
  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get transactionHash => $_getSZ(1);
  @$pb.TagNumber(2)
  set transactionHash($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTransactionHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionHash() => clearField(2);

  @$pb.TagNumber(3)
  $1.Time get timestamp => $_getN(2);
  @$pb.TagNumber(3)
  set timestamp($1.Time v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => clearField(3);
  @$pb.TagNumber(3)
  $1.Time ensureTimestamp() => $_ensure(2);

  /// Transaction type and operation
  @$pb.TagNumber(4)
  TransactionTypeEnum get type => $_getN(3);
  @$pb.TagNumber(4)
  set type(TransactionTypeEnum v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasType() => $_has(3);
  @$pb.TagNumber(4)
  void clearType() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get operation => $_getSZ(4);
  @$pb.TagNumber(5)
  set operation($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasOperation() => $_has(4);
  @$pb.TagNumber(5)
  void clearOperation() => clearField(5);

  /// Account information (reflecting Activity structure)
  @$pb.TagNumber(6)
  $core.String get accountIid => $_getSZ(5);
  @$pb.TagNumber(6)
  set accountIid($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAccountIid() => $_has(5);
  @$pb.TagNumber(6)
  void clearAccountIid() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get fromAccountIid => $_getSZ(6);
  @$pb.TagNumber(7)
  set fromAccountIid($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFromAccountIid() => $_has(6);
  @$pb.TagNumber(7)
  void clearFromAccountIid() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get toAccountIid => $_getSZ(7);
  @$pb.TagNumber(8)
  set toAccountIid($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasToAccountIid() => $_has(7);
  @$pb.TagNumber(8)
  void clearToAccountIid() => clearField(8);

  /// Reserve IDs (from Activity model)
  @$pb.TagNumber(9)
  $core.String get fromReserveId => $_getSZ(8);
  @$pb.TagNumber(9)
  set fromReserveId($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasFromReserveId() => $_has(8);
  @$pb.TagNumber(9)
  void clearFromReserveId() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get toReserveId => $_getSZ(9);
  @$pb.TagNumber(10)
  set toReserveId($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasToReserveId() => $_has(9);
  @$pb.TagNumber(10)
  void clearToReserveId() => clearField(10);

  /// Stash information (critical for the Activity model)
  @$pb.TagNumber(11)
  $core.String get fromStash => $_getSZ(10);
  @$pb.TagNumber(11)
  set fromStash($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasFromStash() => $_has(10);
  @$pb.TagNumber(11)
  void clearFromStash() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get toStash => $_getSZ(11);
  @$pb.TagNumber(12)
  set toStash($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasToStash() => $_has(11);
  @$pb.TagNumber(12)
  void clearToStash() => clearField(12);

  /// Asset and amount
  @$pb.TagNumber(13)
  $core.String get assetIid => $_getSZ(12);
  @$pb.TagNumber(13)
  set assetIid($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasAssetIid() => $_has(12);
  @$pb.TagNumber(13)
  void clearAssetIid() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get amount => $_getSZ(13);
  @$pb.TagNumber(14)
  set amount($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasAmount() => $_has(13);
  @$pb.TagNumber(14)
  void clearAmount() => clearField(14);

  /// Reference information
  @$pb.TagNumber(15)
  $core.String get referenceId => $_getSZ(14);
  @$pb.TagNumber(15)
  set referenceId($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasReferenceId() => $_has(14);
  @$pb.TagNumber(15)
  void clearReferenceId() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get referenceType => $_getSZ(15);
  @$pb.TagNumber(16)
  set referenceType($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasReferenceType() => $_has(15);
  @$pb.TagNumber(16)
  void clearReferenceType() => clearField(16);

  /// Additional fields
  @$pb.TagNumber(101)
  $core.Map<$core.String, $core.String> get displayNames => $_getMap(16);

  @$pb.TagNumber(102)
  $core.Map<$core.String, $core.String> get descriptions => $_getMap(17);

  @$pb.TagNumber(103)
  $core.Map<$core.String, $core.String> get labels => $_getMap(18);

  @$pb.TagNumber(104)
  $core.List<$core.String> get tags => $_getList(19);

  @$pb.TagNumber(105)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(20);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
