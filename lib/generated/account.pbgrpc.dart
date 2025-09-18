// This is a generated file - do not edit.
//
// Generated from account.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'account.pb.dart' as $0;
import 'common.pb.dart' as $1;

export 'account.pb.dart';

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.AccountService')
class AccountServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  AccountServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.GetAccountListResponse> getAccountList(
    $0.GetAccountListRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountList, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getAccountListAsync(
    $0.GetAccountListRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountListAsync, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAccountInfoBatchResponse> getAccountInfoBatch(
    $0.GetAccountInfoBatchRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountInfoBatch, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getAccountInfoBatchAsync(
    $0.GetAccountInfoBatchRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountInfoBatchAsync, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> newAccount(
    $0.NewAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$newAccount, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> activateVenueForAccount(
    $0.ActivateVenueForAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$activateVenueForAccount, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> depositCash(
    $0.DepositCashRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$depositCash, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> depositInstrument(
    $0.DepositInstrumentRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$depositInstrument, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> withdrawCash(
    $0.WithdrawCashRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$withdrawCash, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> withdrawInstrument(
    $0.WithdrawInstrumentRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$withdrawInstrument, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAccountInstrumentHoldingsResponse>
      getAccountInstrumentHoldings(
    $0.GetAccountInstrumentHoldingsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountInstrumentHoldings, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse>
      getAccountInstrumentHoldingsAsync(
    $0.GetAccountInstrumentHoldingsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountInstrumentHoldingsAsync, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetAccountCashHoldingsResponse>
      getAccountCashHoldings(
    $0.GetAccountCashHoldingsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountCashHoldings, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getAccountCashHoldingsAsync(
    $0.GetAccountCashHoldingsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountCashHoldingsAsync, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetAccountOrdersResponse> getAccountOrders(
    $0.GetAccountOrdersRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountOrders, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getAccountOrdersAsync(
    $0.GetAccountOrdersRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountOrdersAsync, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAccountTradesResponse> getAccountTrades(
    $0.GetAccountTradesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountTrades, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getAccountTradesAsync(
    $0.GetAccountTradesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountTradesAsync, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAccountSettlementsResponse> getAccountSettlements(
    $0.GetAccountSettlementsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountSettlements, request, options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getAccountSettlementsAsync(
    $0.GetAccountSettlementsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountSettlementsAsync, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetAccountTransactionsResponse>
      getAccountTransactions(
    $0.GetAccountTransactionsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.ExecutionAsyncResponse> getAccountTransactionsAsync(
    $0.GetAccountTransactionsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountTransactionsAsync, request,
        options: options);
  }

  // method descriptors

  static final _$getAccountList =
      $grpc.ClientMethod<$0.GetAccountListRequest, $0.GetAccountListResponse>(
          '/qomet.agora.daemons.prtagent.v1.AccountService/GetAccountList',
          ($0.GetAccountListRequest value) => value.writeToBuffer(),
          $0.GetAccountListResponse.fromBuffer);
  static final _$getAccountListAsync =
      $grpc.ClientMethod<$0.GetAccountListRequest, $1.ExecutionAsyncResponse>(
          '/qomet.agora.daemons.prtagent.v1.AccountService/GetAccountListAsync',
          ($0.GetAccountListRequest value) => value.writeToBuffer(),
          $1.ExecutionAsyncResponse.fromBuffer);
  static final _$getAccountInfoBatch = $grpc.ClientMethod<
          $0.GetAccountInfoBatchRequest, $0.GetAccountInfoBatchResponse>(
      '/qomet.agora.daemons.prtagent.v1.AccountService/GetAccountInfoBatch',
      ($0.GetAccountInfoBatchRequest value) => value.writeToBuffer(),
      $0.GetAccountInfoBatchResponse.fromBuffer);
  static final _$getAccountInfoBatchAsync = $grpc.ClientMethod<
          $0.GetAccountInfoBatchRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.AccountService/GetAccountInfoBatchAsync',
      ($0.GetAccountInfoBatchRequest value) => value.writeToBuffer(),
      $1.ExecutionAsyncResponse.fromBuffer);
  static final _$newAccount =
      $grpc.ClientMethod<$0.NewAccountRequest, $1.ExecutionAsyncResponse>(
          '/qomet.agora.daemons.prtagent.v1.AccountService/NewAccount',
          ($0.NewAccountRequest value) => value.writeToBuffer(),
          $1.ExecutionAsyncResponse.fromBuffer);
  static final _$activateVenueForAccount = $grpc.ClientMethod<
          $0.ActivateVenueForAccountRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.AccountService/ActivateVenueForAccount',
      ($0.ActivateVenueForAccountRequest value) => value.writeToBuffer(),
      $1.ExecutionAsyncResponse.fromBuffer);
  static final _$depositCash =
      $grpc.ClientMethod<$0.DepositCashRequest, $1.ExecutionAsyncResponse>(
          '/qomet.agora.daemons.prtagent.v1.AccountService/DepositCash',
          ($0.DepositCashRequest value) => value.writeToBuffer(),
          $1.ExecutionAsyncResponse.fromBuffer);
  static final _$depositInstrument = $grpc.ClientMethod<
          $0.DepositInstrumentRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.AccountService/DepositInstrument',
      ($0.DepositInstrumentRequest value) => value.writeToBuffer(),
      $1.ExecutionAsyncResponse.fromBuffer);
  static final _$withdrawCash =
      $grpc.ClientMethod<$0.WithdrawCashRequest, $1.ExecutionAsyncResponse>(
          '/qomet.agora.daemons.prtagent.v1.AccountService/WithdrawCash',
          ($0.WithdrawCashRequest value) => value.writeToBuffer(),
          $1.ExecutionAsyncResponse.fromBuffer);
  static final _$withdrawInstrument = $grpc.ClientMethod<
          $0.WithdrawInstrumentRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.AccountService/WithdrawInstrument',
      ($0.WithdrawInstrumentRequest value) => value.writeToBuffer(),
      $1.ExecutionAsyncResponse.fromBuffer);
  static final _$getAccountInstrumentHoldings = $grpc.ClientMethod<
          $0.GetAccountInstrumentHoldingsRequest,
          $0.GetAccountInstrumentHoldingsResponse>(
      '/qomet.agora.daemons.prtagent.v1.AccountService/GetAccountInstrumentHoldings',
      ($0.GetAccountInstrumentHoldingsRequest value) => value.writeToBuffer(),
      $0.GetAccountInstrumentHoldingsResponse.fromBuffer);
  static final _$getAccountInstrumentHoldingsAsync = $grpc.ClientMethod<
          $0.GetAccountInstrumentHoldingsRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.AccountService/GetAccountInstrumentHoldingsAsync',
      ($0.GetAccountInstrumentHoldingsRequest value) => value.writeToBuffer(),
      $1.ExecutionAsyncResponse.fromBuffer);
  static final _$getAccountCashHoldings = $grpc.ClientMethod<
          $0.GetAccountCashHoldingsRequest, $0.GetAccountCashHoldingsResponse>(
      '/qomet.agora.daemons.prtagent.v1.AccountService/GetAccountCashHoldings',
      ($0.GetAccountCashHoldingsRequest value) => value.writeToBuffer(),
      $0.GetAccountCashHoldingsResponse.fromBuffer);
  static final _$getAccountCashHoldingsAsync = $grpc.ClientMethod<
          $0.GetAccountCashHoldingsRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.AccountService/GetAccountCashHoldingsAsync',
      ($0.GetAccountCashHoldingsRequest value) => value.writeToBuffer(),
      $1.ExecutionAsyncResponse.fromBuffer);
  static final _$getAccountOrders = $grpc.ClientMethod<
          $0.GetAccountOrdersRequest, $0.GetAccountOrdersResponse>(
      '/qomet.agora.daemons.prtagent.v1.AccountService/GetAccountOrders',
      ($0.GetAccountOrdersRequest value) => value.writeToBuffer(),
      $0.GetAccountOrdersResponse.fromBuffer);
  static final _$getAccountOrdersAsync = $grpc.ClientMethod<
          $0.GetAccountOrdersRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.AccountService/GetAccountOrdersAsync',
      ($0.GetAccountOrdersRequest value) => value.writeToBuffer(),
      $1.ExecutionAsyncResponse.fromBuffer);
  static final _$getAccountTrades = $grpc.ClientMethod<
          $0.GetAccountTradesRequest, $0.GetAccountTradesResponse>(
      '/qomet.agora.daemons.prtagent.v1.AccountService/GetAccountTrades',
      ($0.GetAccountTradesRequest value) => value.writeToBuffer(),
      $0.GetAccountTradesResponse.fromBuffer);
  static final _$getAccountTradesAsync = $grpc.ClientMethod<
          $0.GetAccountTradesRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.AccountService/GetAccountTradesAsync',
      ($0.GetAccountTradesRequest value) => value.writeToBuffer(),
      $1.ExecutionAsyncResponse.fromBuffer);
  static final _$getAccountSettlements = $grpc.ClientMethod<
          $0.GetAccountSettlementsRequest, $0.GetAccountSettlementsResponse>(
      '/qomet.agora.daemons.prtagent.v1.AccountService/GetAccountSettlements',
      ($0.GetAccountSettlementsRequest value) => value.writeToBuffer(),
      $0.GetAccountSettlementsResponse.fromBuffer);
  static final _$getAccountSettlementsAsync = $grpc.ClientMethod<
          $0.GetAccountSettlementsRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.AccountService/GetAccountSettlementsAsync',
      ($0.GetAccountSettlementsRequest value) => value.writeToBuffer(),
      $1.ExecutionAsyncResponse.fromBuffer);
  static final _$getAccountTransactions = $grpc.ClientMethod<
          $0.GetAccountTransactionsRequest, $0.GetAccountTransactionsResponse>(
      '/qomet.agora.daemons.prtagent.v1.AccountService/GetAccountTransactions',
      ($0.GetAccountTransactionsRequest value) => value.writeToBuffer(),
      $0.GetAccountTransactionsResponse.fromBuffer);
  static final _$getAccountTransactionsAsync = $grpc.ClientMethod<
          $0.GetAccountTransactionsRequest, $1.ExecutionAsyncResponse>(
      '/qomet.agora.daemons.prtagent.v1.AccountService/GetAccountTransactionsAsync',
      ($0.GetAccountTransactionsRequest value) => value.writeToBuffer(),
      $1.ExecutionAsyncResponse.fromBuffer);
}

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.AccountService')
abstract class AccountServiceBase extends $grpc.Service {
  $core.String get $name => 'qomet.agora.daemons.prtagent.v1.AccountService';

  AccountServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetAccountListRequest,
            $0.GetAccountListResponse>(
        'GetAccountList',
        getAccountList_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountListRequest.fromBuffer(value),
        ($0.GetAccountListResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountListRequest,
            $1.ExecutionAsyncResponse>(
        'GetAccountListAsync',
        getAccountListAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountListRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountInfoBatchRequest,
            $0.GetAccountInfoBatchResponse>(
        'GetAccountInfoBatch',
        getAccountInfoBatch_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountInfoBatchRequest.fromBuffer(value),
        ($0.GetAccountInfoBatchResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountInfoBatchRequest,
            $1.ExecutionAsyncResponse>(
        'GetAccountInfoBatchAsync',
        getAccountInfoBatchAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountInfoBatchRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.NewAccountRequest, $1.ExecutionAsyncResponse>(
            'NewAccount',
            newAccount_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.NewAccountRequest.fromBuffer(value),
            ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ActivateVenueForAccountRequest,
            $1.ExecutionAsyncResponse>(
        'ActivateVenueForAccount',
        activateVenueForAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ActivateVenueForAccountRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.DepositCashRequest, $1.ExecutionAsyncResponse>(
            'DepositCash',
            depositCash_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.DepositCashRequest.fromBuffer(value),
            ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DepositInstrumentRequest,
            $1.ExecutionAsyncResponse>(
        'DepositInstrument',
        depositInstrument_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DepositInstrumentRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.WithdrawCashRequest, $1.ExecutionAsyncResponse>(
            'WithdrawCash',
            withdrawCash_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.WithdrawCashRequest.fromBuffer(value),
            ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WithdrawInstrumentRequest,
            $1.ExecutionAsyncResponse>(
        'WithdrawInstrument',
        withdrawInstrument_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.WithdrawInstrumentRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountInstrumentHoldingsRequest,
            $0.GetAccountInstrumentHoldingsResponse>(
        'GetAccountInstrumentHoldings',
        getAccountInstrumentHoldings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountInstrumentHoldingsRequest.fromBuffer(value),
        ($0.GetAccountInstrumentHoldingsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountInstrumentHoldingsRequest,
            $1.ExecutionAsyncResponse>(
        'GetAccountInstrumentHoldingsAsync',
        getAccountInstrumentHoldingsAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountInstrumentHoldingsRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountCashHoldingsRequest,
            $0.GetAccountCashHoldingsResponse>(
        'GetAccountCashHoldings',
        getAccountCashHoldings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountCashHoldingsRequest.fromBuffer(value),
        ($0.GetAccountCashHoldingsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountCashHoldingsRequest,
            $1.ExecutionAsyncResponse>(
        'GetAccountCashHoldingsAsync',
        getAccountCashHoldingsAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountCashHoldingsRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountOrdersRequest,
            $0.GetAccountOrdersResponse>(
        'GetAccountOrders',
        getAccountOrders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountOrdersRequest.fromBuffer(value),
        ($0.GetAccountOrdersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountOrdersRequest,
            $1.ExecutionAsyncResponse>(
        'GetAccountOrdersAsync',
        getAccountOrdersAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountOrdersRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountTradesRequest,
            $0.GetAccountTradesResponse>(
        'GetAccountTrades',
        getAccountTrades_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountTradesRequest.fromBuffer(value),
        ($0.GetAccountTradesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountTradesRequest,
            $1.ExecutionAsyncResponse>(
        'GetAccountTradesAsync',
        getAccountTradesAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountTradesRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountSettlementsRequest,
            $0.GetAccountSettlementsResponse>(
        'GetAccountSettlements',
        getAccountSettlements_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountSettlementsRequest.fromBuffer(value),
        ($0.GetAccountSettlementsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountSettlementsRequest,
            $1.ExecutionAsyncResponse>(
        'GetAccountSettlementsAsync',
        getAccountSettlementsAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountSettlementsRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountTransactionsRequest,
            $0.GetAccountTransactionsResponse>(
        'GetAccountTransactions',
        getAccountTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountTransactionsRequest.fromBuffer(value),
        ($0.GetAccountTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountTransactionsRequest,
            $1.ExecutionAsyncResponse>(
        'GetAccountTransactionsAsync',
        getAccountTransactionsAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountTransactionsRequest.fromBuffer(value),
        ($1.ExecutionAsyncResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetAccountListResponse> getAccountList_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAccountListRequest> $request) async {
    return getAccountList($call, await $request);
  }

  $async.Future<$0.GetAccountListResponse> getAccountList(
      $grpc.ServiceCall call, $0.GetAccountListRequest request);

  $async.Future<$1.ExecutionAsyncResponse> getAccountListAsync_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAccountListRequest> $request) async {
    return getAccountListAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getAccountListAsync(
      $grpc.ServiceCall call, $0.GetAccountListRequest request);

  $async.Future<$0.GetAccountInfoBatchResponse> getAccountInfoBatch_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAccountInfoBatchRequest> $request) async {
    return getAccountInfoBatch($call, await $request);
  }

  $async.Future<$0.GetAccountInfoBatchResponse> getAccountInfoBatch(
      $grpc.ServiceCall call, $0.GetAccountInfoBatchRequest request);

  $async.Future<$1.ExecutionAsyncResponse> getAccountInfoBatchAsync_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAccountInfoBatchRequest> $request) async {
    return getAccountInfoBatchAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getAccountInfoBatchAsync(
      $grpc.ServiceCall call, $0.GetAccountInfoBatchRequest request);

  $async.Future<$1.ExecutionAsyncResponse> newAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.NewAccountRequest> $request) async {
    return newAccount($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> newAccount(
      $grpc.ServiceCall call, $0.NewAccountRequest request);

  $async.Future<$1.ExecutionAsyncResponse> activateVenueForAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ActivateVenueForAccountRequest> $request) async {
    return activateVenueForAccount($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> activateVenueForAccount(
      $grpc.ServiceCall call, $0.ActivateVenueForAccountRequest request);

  $async.Future<$1.ExecutionAsyncResponse> depositCash_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.DepositCashRequest> $request) async {
    return depositCash($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> depositCash(
      $grpc.ServiceCall call, $0.DepositCashRequest request);

  $async.Future<$1.ExecutionAsyncResponse> depositInstrument_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.DepositInstrumentRequest> $request) async {
    return depositInstrument($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> depositInstrument(
      $grpc.ServiceCall call, $0.DepositInstrumentRequest request);

  $async.Future<$1.ExecutionAsyncResponse> withdrawCash_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.WithdrawCashRequest> $request) async {
    return withdrawCash($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> withdrawCash(
      $grpc.ServiceCall call, $0.WithdrawCashRequest request);

  $async.Future<$1.ExecutionAsyncResponse> withdrawInstrument_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.WithdrawInstrumentRequest> $request) async {
    return withdrawInstrument($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> withdrawInstrument(
      $grpc.ServiceCall call, $0.WithdrawInstrumentRequest request);

  $async.Future<$0.GetAccountInstrumentHoldingsResponse>
      getAccountInstrumentHoldings_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$0.GetAccountInstrumentHoldingsRequest>
              $request) async {
    return getAccountInstrumentHoldings($call, await $request);
  }

  $async.Future<$0.GetAccountInstrumentHoldingsResponse>
      getAccountInstrumentHoldings($grpc.ServiceCall call,
          $0.GetAccountInstrumentHoldingsRequest request);

  $async.Future<$1.ExecutionAsyncResponse>
      getAccountInstrumentHoldingsAsync_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$0.GetAccountInstrumentHoldingsRequest>
              $request) async {
    return getAccountInstrumentHoldingsAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getAccountInstrumentHoldingsAsync(
      $grpc.ServiceCall call, $0.GetAccountInstrumentHoldingsRequest request);

  $async.Future<$0.GetAccountCashHoldingsResponse> getAccountCashHoldings_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAccountCashHoldingsRequest> $request) async {
    return getAccountCashHoldings($call, await $request);
  }

  $async.Future<$0.GetAccountCashHoldingsResponse> getAccountCashHoldings(
      $grpc.ServiceCall call, $0.GetAccountCashHoldingsRequest request);

  $async.Future<$1.ExecutionAsyncResponse> getAccountCashHoldingsAsync_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAccountCashHoldingsRequest> $request) async {
    return getAccountCashHoldingsAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getAccountCashHoldingsAsync(
      $grpc.ServiceCall call, $0.GetAccountCashHoldingsRequest request);

  $async.Future<$0.GetAccountOrdersResponse> getAccountOrders_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAccountOrdersRequest> $request) async {
    return getAccountOrders($call, await $request);
  }

  $async.Future<$0.GetAccountOrdersResponse> getAccountOrders(
      $grpc.ServiceCall call, $0.GetAccountOrdersRequest request);

  $async.Future<$1.ExecutionAsyncResponse> getAccountOrdersAsync_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAccountOrdersRequest> $request) async {
    return getAccountOrdersAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getAccountOrdersAsync(
      $grpc.ServiceCall call, $0.GetAccountOrdersRequest request);

  $async.Future<$0.GetAccountTradesResponse> getAccountTrades_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAccountTradesRequest> $request) async {
    return getAccountTrades($call, await $request);
  }

  $async.Future<$0.GetAccountTradesResponse> getAccountTrades(
      $grpc.ServiceCall call, $0.GetAccountTradesRequest request);

  $async.Future<$1.ExecutionAsyncResponse> getAccountTradesAsync_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAccountTradesRequest> $request) async {
    return getAccountTradesAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getAccountTradesAsync(
      $grpc.ServiceCall call, $0.GetAccountTradesRequest request);

  $async.Future<$0.GetAccountSettlementsResponse> getAccountSettlements_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAccountSettlementsRequest> $request) async {
    return getAccountSettlements($call, await $request);
  }

  $async.Future<$0.GetAccountSettlementsResponse> getAccountSettlements(
      $grpc.ServiceCall call, $0.GetAccountSettlementsRequest request);

  $async.Future<$1.ExecutionAsyncResponse> getAccountSettlementsAsync_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAccountSettlementsRequest> $request) async {
    return getAccountSettlementsAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getAccountSettlementsAsync(
      $grpc.ServiceCall call, $0.GetAccountSettlementsRequest request);

  $async.Future<$0.GetAccountTransactionsResponse> getAccountTransactions_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAccountTransactionsRequest> $request) async {
    return getAccountTransactions($call, await $request);
  }

  $async.Future<$0.GetAccountTransactionsResponse> getAccountTransactions(
      $grpc.ServiceCall call, $0.GetAccountTransactionsRequest request);

  $async.Future<$1.ExecutionAsyncResponse> getAccountTransactionsAsync_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAccountTransactionsRequest> $request) async {
    return getAccountTransactionsAsync($call, await $request);
  }

  $async.Future<$1.ExecutionAsyncResponse> getAccountTransactionsAsync(
      $grpc.ServiceCall call, $0.GetAccountTransactionsRequest request);
}
