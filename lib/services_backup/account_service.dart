import 'package:mini_broker/generated/qomet/agora/daemons/prtagent/v1/account.pb.dart';
import 'package:mini_broker/generated/qomet/agora/daemons/prtagent/v1/common.pb.dart';
import 'package:mini_broker/generated/google/protobuf/timestamp.pb.dart';
import 'package:fixnum/fixnum.dart';
import 'package:mini_broker/services/grpc_client.dart';

class AccountService {
  static final TradingGrpcClient _client = grpcClient;

  /// Create a new account
  static Future<NewAccountResponse> createAccount({
    required String externalAccountId,
    String? auxData,
  }) async {
    final request = NewAccountRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'new_account')
      ..externalAccountId = externalAccountId;
    
    if (auxData != null) {
      request.auxData = auxData;
    }

    return await _client.accountService.newAccount(request);
  }

  /// Get account information
  static Future<GetAccountInfoResponse> getAccountInfo({
    required String accountId,
  }) async {
    final request = GetAccountInfoRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'get_account_info')
      ..accountId = accountId;

    return await _client.accountService.getAccountInfo(request);
  }

  /// Get list of accounts with pagination
  static Future<GetAccountListResponse> getAccountList({
    int pageNumber = 1,
    int pageSize = 20,
    String? pageToken,
  }) async {
    final pagination = PaginationParams()
      ..pageNr = pageNumber
      ..pageSize = pageSize;
    
    if (pageToken != null) {
      pagination.pageToken = pageToken;
    }

    final request = GetAccountListRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'get_account_list')
      ..pagination = pagination;

    return await _client.accountService.getAccountList(request);
  }

  /// Enable market for an account
  static Future<EnableMarketForAccountResponse> enableMarketForAccount({
    required String accountId,
    required String marketId,
    String? auxData,
  }) async {
    final request = EnableMarketForAccountRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'enable_market')
      ..accountId = accountId
      ..marketId = marketId;
    
    if (auxData != null) {
      request.auxData = auxData;
    }

    return await _client.accountService.enableMarketForAccount(request);
  }

  /// Get account portfolio for a specific market
  static Future<GetAccountMarketPortfolioResponse> getAccountMarketPortfolio({
    required String accountId,
    required String marketId,
    List<String>? assetIds,
  }) async {
    final request = GetAccountMarketPortfolioRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'get_portfolio')
      ..accountId = accountId
      ..marketId = marketId;
    
    if (assetIds != null) {
      request.assetIds.addAll(assetIds);
    }

    return await _client.accountService.getAccountMarketPortfolio(request);
  }

  /// Get account cash holdings
  static Future<GetAccountCashHoldingsResponse> getAccountCashHoldings({
    required String accountId,
    List<String>? cashAssetIds,
  }) async {
    final request = GetAccountCashHoldingsRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'get_cash_holdings')
      ..accountId = accountId;
    
    if (cashAssetIds != null) {
      request.cashAssetIds.addAll(cashAssetIds);
    }

    return await _client.accountService.getAccountCashHoldings(request);
  }

  /// Deposit cash to account
  static Future<DepositCashResponse> depositCash({
    required String accountId,
    required String currencyAssetId,
    required String amount,
    String? auxData,
  }) async {
    final request = DepositCashRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'deposit_cash')
      ..accountId = accountId
      ..currencyAssetId = currencyAssetId
      ..amount = amount;
    
    if (auxData != null) {
      request.auxData = auxData;
    }

    return await _client.accountService.depositCash(request);
  }

  /// Deposit asset to account
  static Future<DepositAssetResponse> depositAsset({
    required String accountId,
    required String assetId,
    required int amount,
    String? auxData,
  }) async {
    final request = DepositAssetRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'deposit_asset')
      ..accountId = accountId
      ..assetId = assetId
      ..amount = Int64(amount);
    
    if (auxData != null) {
      request.auxData = auxData;
    }

    return await _client.accountService.depositAsset(request);
  }

  /// Withdraw cash from account
  static Future<WithdrawCashResponse> withdrawCash({
    required String accountId,
    required String currencyAssetId,
    required int amount,
    String? auxData,
  }) async {
    final request = WithdrawCashRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'withdraw_cash')
      ..accountId = accountId
      ..currencyAssetId = currencyAssetId
      ..amount = Int64(amount);
    
    if (auxData != null) {
      request.auxData = auxData;
    }

    return await _client.accountService.withdrawCash(request);
  }

  /// Get account orders with filtering
  static Future<GetAccountOrdersResponse> getAccountOrders({
    required String accountId,
    List<String>? marketRegexes,
    int pageNumber = 1,
    int pageSize = 20,
    String? pageToken,
    DateTime? fromTime,
    DateTime? toTime,
    OrderSide? side,
    List<bool>? statusFilters,
    List<String>? instrumentRegexes,
  }) async {
    final pagination = PaginationParams()
      ..pageNr = pageNumber
      ..pageSize = pageSize;
    
    if (pageToken != null) {
      pagination.pageToken = pageToken;
    }

    final request = GetAccountOrdersRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'get_account_orders')
      ..accountId = accountId
      ..pagination = pagination;

    if (marketRegexes != null) {
      request.marketIdOrNameRegexes.addAll(marketRegexes);
    }
    
    if (fromTime != null) {
      request.fromTime = Time()..ts = Timestamp.fromDateTime(fromTime);
    }
    
    if (toTime != null) {
      request.toTime = Time()..ts = Timestamp.fromDateTime(toTime);
    }
    
    if (side != null) {
      request.side = side;
    }
    
    if (statusFilters != null) {
      request.statusFilters.addAll(statusFilters);
    }
    
    if (instrumentRegexes != null) {
      request.instrumentIdOrSymbolRegexes.addAll(instrumentRegexes);
    }

    return await _client.accountService.getAccountOrders(request);
  }

  /// Get account trades with filtering
  static Future<GetAccountTradesResponse> getAccountTrades({
    required String accountId,
    List<String>? marketRegexes,
    int pageNumber = 1,
    int pageSize = 20,
    String? pageToken,
    DateTime? fromTime,
    DateTime? toTime,
    List<String>? instrumentRegexes,
    OrderSide? side,
  }) async {
    final pagination = PaginationParams()
      ..pageNr = pageNumber
      ..pageSize = pageSize;
    
    if (pageToken != null) {
      pagination.pageToken = pageToken;
    }

    final request = GetAccountTradesRequest()
      ..refRequestId = _client.generateRequestId(prefix: 'get_account_trades')
      ..accountId = accountId
      ..pagination = pagination;

    if (marketRegexes != null) {
      request.marketIdOrNameRegexes.addAll(marketRegexes);
    }
    
    if (fromTime != null) {
      request.fromTime = Time()..ts = Timestamp.fromDateTime(fromTime);
    }
    
    if (toTime != null) {
      request.toTime = Time()..ts = Timestamp.fromDateTime(toTime);
    }
    
    if (instrumentRegexes != null) {
      request.instrumentIdOrSymbolRegexes.addAll(instrumentRegexes);
    }
    
    if (side != null) {
      request.side = side;
    }

    return await _client.accountService.getAccountTrades(request);
  }
}