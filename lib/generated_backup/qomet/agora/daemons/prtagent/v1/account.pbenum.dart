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

import 'package:protobuf/protobuf.dart' as $pb;

class TransactionType extends $pb.ProtobufEnum {
  static const TransactionType TRANSACTION_TYPE__UNKNOWN =
      TransactionType._(0, _omitEnumNames ? '' : 'TRANSACTION_TYPE__UNKNOWN');
  static const TransactionType TRANSACTION_TYPE__DEPOSIT_CASH =
      TransactionType._(
          1, _omitEnumNames ? '' : 'TRANSACTION_TYPE__DEPOSIT_CASH');
  static const TransactionType TRANSACTION_TYPE__DEPOSIT_ASSET =
      TransactionType._(
          2, _omitEnumNames ? '' : 'TRANSACTION_TYPE__DEPOSIT_ASSET');
  static const TransactionType TRANSACTION_TYPE__WITHDRAW_CASH =
      TransactionType._(
          3, _omitEnumNames ? '' : 'TRANSACTION_TYPE__WITHDRAW_CASH');
  static const TransactionType TRANSACTION_TYPE__WITHDRAW_ASSET =
      TransactionType._(
          4, _omitEnumNames ? '' : 'TRANSACTION_TYPE__WITHDRAW_ASSET');
  static const TransactionType TRANSACTION_TYPE__TRADE_BUY =
      TransactionType._(5, _omitEnumNames ? '' : 'TRANSACTION_TYPE__TRADE_BUY');
  static const TransactionType TRANSACTION_TYPE__TRADE_SELL = TransactionType._(
      6, _omitEnumNames ? '' : 'TRANSACTION_TYPE__TRADE_SELL');
  static const TransactionType TRANSACTION_TYPE__FEE =
      TransactionType._(7, _omitEnumNames ? '' : 'TRANSACTION_TYPE__FEE');
  static const TransactionType TRANSACTION_TYPE__SETTLEMENT = TransactionType._(
      8, _omitEnumNames ? '' : 'TRANSACTION_TYPE__SETTLEMENT');
  static const TransactionType TRANSACTION_TYPE__TRANSFER_IN =
      TransactionType._(
          9, _omitEnumNames ? '' : 'TRANSACTION_TYPE__TRANSFER_IN');
  static const TransactionType TRANSACTION_TYPE__TRANSFER_OUT =
      TransactionType._(
          10, _omitEnumNames ? '' : 'TRANSACTION_TYPE__TRANSFER_OUT');

  static const $core.List<TransactionType> values = <TransactionType>[
    TRANSACTION_TYPE__UNKNOWN,
    TRANSACTION_TYPE__DEPOSIT_CASH,
    TRANSACTION_TYPE__DEPOSIT_ASSET,
    TRANSACTION_TYPE__WITHDRAW_CASH,
    TRANSACTION_TYPE__WITHDRAW_ASSET,
    TRANSACTION_TYPE__TRADE_BUY,
    TRANSACTION_TYPE__TRADE_SELL,
    TRANSACTION_TYPE__FEE,
    TRANSACTION_TYPE__SETTLEMENT,
    TRANSACTION_TYPE__TRANSFER_IN,
    TRANSACTION_TYPE__TRANSFER_OUT,
  ];

  static final $core.List<TransactionType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 10);
  static TransactionType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TransactionType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
