// This is a generated file - do not edit.
//
// Generated from qomet/agora/daemons/prtagent/v1/account.proto.

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

  $grpc.ResponseFuture<$0.GetAccountInfoResponse> getAccountInfo(
    $0.GetAccountInfoRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountInfo, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAccountListResponse> getAccountList(
    $0.GetAccountListRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountList, request, options: options);
  }

  $grpc.ResponseFuture<$0.NewAccountResponse> newAccount(
    $0.NewAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$newAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.EnableMarketForAccountResponse>
      enableMarketForAccount(
    $0.EnableMarketForAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$enableMarketForAccount, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetAccountMarketPortfolioResponse>
      getAccountMarketPortfolio(
    $0.GetAccountMarketPortfolioRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountMarketPortfolio, request,
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

  $grpc.ResponseFuture<$0.DepositCashResponse> depositCash(
    $0.DepositCashRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$depositCash, request, options: options);
  }

  $grpc.ResponseFuture<$0.DepositAssetResponse> depositAsset(
    $0.DepositAssetRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$depositAsset, request, options: options);
  }

  $grpc.ResponseFuture<$0.WithdrawCashResponse> withdrawCash(
    $0.WithdrawCashRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$withdrawCash, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAccountOrdersResponse> getAccountOrders(
    $0.GetAccountOrdersRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountOrders, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAccountTradesResponse> getAccountTrades(
    $0.GetAccountTradesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountTrades, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAccountSettlementsResponse> getAccountSettlements(
    $0.GetAccountSettlementsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountSettlements, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAccountTransactionsResponse>
      getAccountTransactions(
    $0.GetAccountTransactionsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountTransactions, request,
        options: options);
  }

  // method descriptors

  static final _$getAccountInfo =
      $grpc.ClientMethod<$0.GetAccountInfoRequest, $0.GetAccountInfoResponse>(
          '/qomet.agora.daemons.prtagent.v1.AccountService/GetAccountInfo',
          ($0.GetAccountInfoRequest value) => value.writeToBuffer(),
          $0.GetAccountInfoResponse.fromBuffer);
  static final _$getAccountList =
      $grpc.ClientMethod<$0.GetAccountListRequest, $0.GetAccountListResponse>(
          '/qomet.agora.daemons.prtagent.v1.AccountService/GetAccountList',
          ($0.GetAccountListRequest value) => value.writeToBuffer(),
          $0.GetAccountListResponse.fromBuffer);
  static final _$newAccount =
      $grpc.ClientMethod<$0.NewAccountRequest, $0.NewAccountResponse>(
          '/qomet.agora.daemons.prtagent.v1.AccountService/NewAccount',
          ($0.NewAccountRequest value) => value.writeToBuffer(),
          $0.NewAccountResponse.fromBuffer);
  static final _$enableMarketForAccount = $grpc.ClientMethod<
          $0.EnableMarketForAccountRequest, $0.EnableMarketForAccountResponse>(
      '/qomet.agora.daemons.prtagent.v1.AccountService/EnableMarketForAccount',
      ($0.EnableMarketForAccountRequest value) => value.writeToBuffer(),
      $0.EnableMarketForAccountResponse.fromBuffer);
  static final _$getAccountMarketPortfolio = $grpc.ClientMethod<
          $0.GetAccountMarketPortfolioRequest,
          $0.GetAccountMarketPortfolioResponse>(
      '/qomet.agora.daemons.prtagent.v1.AccountService/GetAccountMarketPortfolio',
      ($0.GetAccountMarketPortfolioRequest value) => value.writeToBuffer(),
      $0.GetAccountMarketPortfolioResponse.fromBuffer);
  static final _$getAccountCashHoldings = $grpc.ClientMethod<
          $0.GetAccountCashHoldingsRequest, $0.GetAccountCashHoldingsResponse>(
      '/qomet.agora.daemons.prtagent.v1.AccountService/GetAccountCashHoldings',
      ($0.GetAccountCashHoldingsRequest value) => value.writeToBuffer(),
      $0.GetAccountCashHoldingsResponse.fromBuffer);
  static final _$depositCash =
      $grpc.ClientMethod<$0.DepositCashRequest, $0.DepositCashResponse>(
          '/qomet.agora.daemons.prtagent.v1.AccountService/DepositCash',
          ($0.DepositCashRequest value) => value.writeToBuffer(),
          $0.DepositCashResponse.fromBuffer);
  static final _$depositAsset =
      $grpc.ClientMethod<$0.DepositAssetRequest, $0.DepositAssetResponse>(
          '/qomet.agora.daemons.prtagent.v1.AccountService/DepositAsset',
          ($0.DepositAssetRequest value) => value.writeToBuffer(),
          $0.DepositAssetResponse.fromBuffer);
  static final _$withdrawCash =
      $grpc.ClientMethod<$0.WithdrawCashRequest, $0.WithdrawCashResponse>(
          '/qomet.agora.daemons.prtagent.v1.AccountService/WithdrawCash',
          ($0.WithdrawCashRequest value) => value.writeToBuffer(),
          $0.WithdrawCashResponse.fromBuffer);
  static final _$getAccountOrders = $grpc.ClientMethod<
          $0.GetAccountOrdersRequest, $0.GetAccountOrdersResponse>(
      '/qomet.agora.daemons.prtagent.v1.AccountService/GetAccountOrders',
      ($0.GetAccountOrdersRequest value) => value.writeToBuffer(),
      $0.GetAccountOrdersResponse.fromBuffer);
  static final _$getAccountTrades = $grpc.ClientMethod<
          $0.GetAccountTradesRequest, $0.GetAccountTradesResponse>(
      '/qomet.agora.daemons.prtagent.v1.AccountService/GetAccountTrades',
      ($0.GetAccountTradesRequest value) => value.writeToBuffer(),
      $0.GetAccountTradesResponse.fromBuffer);
  static final _$getAccountSettlements = $grpc.ClientMethod<
          $0.GetAccountSettlementsRequest, $0.GetAccountSettlementsResponse>(
      '/qomet.agora.daemons.prtagent.v1.AccountService/GetAccountSettlements',
      ($0.GetAccountSettlementsRequest value) => value.writeToBuffer(),
      $0.GetAccountSettlementsResponse.fromBuffer);
  static final _$getAccountTransactions = $grpc.ClientMethod<
          $0.GetAccountTransactionsRequest, $0.GetAccountTransactionsResponse>(
      '/qomet.agora.daemons.prtagent.v1.AccountService/GetAccountTransactions',
      ($0.GetAccountTransactionsRequest value) => value.writeToBuffer(),
      $0.GetAccountTransactionsResponse.fromBuffer);
}

@$pb.GrpcServiceName('qomet.agora.daemons.prtagent.v1.AccountService')
abstract class AccountServiceBase extends $grpc.Service {
  $core.String get $name => 'qomet.agora.daemons.prtagent.v1.AccountService';

  AccountServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetAccountInfoRequest,
            $0.GetAccountInfoResponse>(
        'GetAccountInfo',
        getAccountInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountInfoRequest.fromBuffer(value),
        ($0.GetAccountInfoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountListRequest,
            $0.GetAccountListResponse>(
        'GetAccountList',
        getAccountList_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountListRequest.fromBuffer(value),
        ($0.GetAccountListResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.NewAccountRequest, $0.NewAccountResponse>(
        'NewAccount',
        newAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.NewAccountRequest.fromBuffer(value),
        ($0.NewAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.EnableMarketForAccountRequest,
            $0.EnableMarketForAccountResponse>(
        'EnableMarketForAccount',
        enableMarketForAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.EnableMarketForAccountRequest.fromBuffer(value),
        ($0.EnableMarketForAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountMarketPortfolioRequest,
            $0.GetAccountMarketPortfolioResponse>(
        'GetAccountMarketPortfolio',
        getAccountMarketPortfolio_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountMarketPortfolioRequest.fromBuffer(value),
        ($0.GetAccountMarketPortfolioResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountCashHoldingsRequest,
            $0.GetAccountCashHoldingsResponse>(
        'GetAccountCashHoldings',
        getAccountCashHoldings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountCashHoldingsRequest.fromBuffer(value),
        ($0.GetAccountCashHoldingsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.DepositCashRequest, $0.DepositCashResponse>(
            'DepositCash',
            depositCash_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.DepositCashRequest.fromBuffer(value),
            ($0.DepositCashResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.DepositAssetRequest, $0.DepositAssetResponse>(
            'DepositAsset',
            depositAsset_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.DepositAssetRequest.fromBuffer(value),
            ($0.DepositAssetResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.WithdrawCashRequest, $0.WithdrawCashResponse>(
            'WithdrawCash',
            withdrawCash_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.WithdrawCashRequest.fromBuffer(value),
            ($0.WithdrawCashResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountOrdersRequest,
            $0.GetAccountOrdersResponse>(
        'GetAccountOrders',
        getAccountOrders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountOrdersRequest.fromBuffer(value),
        ($0.GetAccountOrdersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountTradesRequest,
            $0.GetAccountTradesResponse>(
        'GetAccountTrades',
        getAccountTrades_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountTradesRequest.fromBuffer(value),
        ($0.GetAccountTradesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountSettlementsRequest,
            $0.GetAccountSettlementsResponse>(
        'GetAccountSettlements',
        getAccountSettlements_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountSettlementsRequest.fromBuffer(value),
        ($0.GetAccountSettlementsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountTransactionsRequest,
            $0.GetAccountTransactionsResponse>(
        'GetAccountTransactions',
        getAccountTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountTransactionsRequest.fromBuffer(value),
        ($0.GetAccountTransactionsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetAccountInfoResponse> getAccountInfo_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAccountInfoRequest> $request) async {
    return getAccountInfo($call, await $request);
  }

  $async.Future<$0.GetAccountInfoResponse> getAccountInfo(
      $grpc.ServiceCall call, $0.GetAccountInfoRequest request);

  $async.Future<$0.GetAccountListResponse> getAccountList_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAccountListRequest> $request) async {
    return getAccountList($call, await $request);
  }

  $async.Future<$0.GetAccountListResponse> getAccountList(
      $grpc.ServiceCall call, $0.GetAccountListRequest request);

  $async.Future<$0.NewAccountResponse> newAccount_Pre($grpc.ServiceCall $call,
      $async.Future<$0.NewAccountRequest> $request) async {
    return newAccount($call, await $request);
  }

  $async.Future<$0.NewAccountResponse> newAccount(
      $grpc.ServiceCall call, $0.NewAccountRequest request);

  $async.Future<$0.EnableMarketForAccountResponse> enableMarketForAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.EnableMarketForAccountRequest> $request) async {
    return enableMarketForAccount($call, await $request);
  }

  $async.Future<$0.EnableMarketForAccountResponse> enableMarketForAccount(
      $grpc.ServiceCall call, $0.EnableMarketForAccountRequest request);

  $async.Future<$0.GetAccountMarketPortfolioResponse>
      getAccountMarketPortfolio_Pre($grpc.ServiceCall $call,
          $async.Future<$0.GetAccountMarketPortfolioRequest> $request) async {
    return getAccountMarketPortfolio($call, await $request);
  }

  $async.Future<$0.GetAccountMarketPortfolioResponse> getAccountMarketPortfolio(
      $grpc.ServiceCall call, $0.GetAccountMarketPortfolioRequest request);

  $async.Future<$0.GetAccountCashHoldingsResponse> getAccountCashHoldings_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAccountCashHoldingsRequest> $request) async {
    return getAccountCashHoldings($call, await $request);
  }

  $async.Future<$0.GetAccountCashHoldingsResponse> getAccountCashHoldings(
      $grpc.ServiceCall call, $0.GetAccountCashHoldingsRequest request);

  $async.Future<$0.DepositCashResponse> depositCash_Pre($grpc.ServiceCall $call,
      $async.Future<$0.DepositCashRequest> $request) async {
    return depositCash($call, await $request);
  }

  $async.Future<$0.DepositCashResponse> depositCash(
      $grpc.ServiceCall call, $0.DepositCashRequest request);

  $async.Future<$0.DepositAssetResponse> depositAsset_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.DepositAssetRequest> $request) async {
    return depositAsset($call, await $request);
  }

  $async.Future<$0.DepositAssetResponse> depositAsset(
      $grpc.ServiceCall call, $0.DepositAssetRequest request);

  $async.Future<$0.WithdrawCashResponse> withdrawCash_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.WithdrawCashRequest> $request) async {
    return withdrawCash($call, await $request);
  }

  $async.Future<$0.WithdrawCashResponse> withdrawCash(
      $grpc.ServiceCall call, $0.WithdrawCashRequest request);

  $async.Future<$0.GetAccountOrdersResponse> getAccountOrders_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAccountOrdersRequest> $request) async {
    return getAccountOrders($call, await $request);
  }

  $async.Future<$0.GetAccountOrdersResponse> getAccountOrders(
      $grpc.ServiceCall call, $0.GetAccountOrdersRequest request);

  $async.Future<$0.GetAccountTradesResponse> getAccountTrades_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAccountTradesRequest> $request) async {
    return getAccountTrades($call, await $request);
  }

  $async.Future<$0.GetAccountTradesResponse> getAccountTrades(
      $grpc.ServiceCall call, $0.GetAccountTradesRequest request);

  $async.Future<$0.GetAccountSettlementsResponse> getAccountSettlements_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAccountSettlementsRequest> $request) async {
    return getAccountSettlements($call, await $request);
  }

  $async.Future<$0.GetAccountSettlementsResponse> getAccountSettlements(
      $grpc.ServiceCall call, $0.GetAccountSettlementsRequest request);

  $async.Future<$0.GetAccountTransactionsResponse> getAccountTransactions_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAccountTransactionsRequest> $request) async {
    return getAccountTransactions($call, await $request);
  }

  $async.Future<$0.GetAccountTransactionsResponse> getAccountTransactions(
      $grpc.ServiceCall call, $0.GetAccountTransactionsRequest request);
}
