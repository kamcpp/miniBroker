import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../config/ui_constants.dart';
import '../utils/menu_items_helper.dart';
import '../widgets/base_page.dart';import '../services/theme_service.dart';
import '../services/real_grpc_client.dart';
import '../utils/connectivity_checker.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  // Orders data variables
  List<Map<String, dynamic>> _orders = [];
  bool _isLoadingOrders = false;
  String _ordersError = '';

  // Trades data variables
  List<Map<String, dynamic>> _trades = [];
  bool _isLoadingTrades = false;
  String _tradesError = '';

  // Settlements data variables
  List<Map<String, dynamic>> _settlements = [];
  bool _isLoadingSettlements = false;
  String _settlementsError = '';

  // Transactions data variables
  List<Map<String, dynamic>> _transactions = [];
  bool _isLoadingTransactions = false;
  String _transactionsError = '';

  // Account management
  String? _cachedAccountId;

  // Filter state for orders
  String? _selectedSide; // BUY, SELL, or null for all
  List<String> _marketFilters = [];
  List<String> _instrumentFilters = [];
  DateTime? _fromDate;
  DateTime? _toDate;
  String _selectedOrderStatus = 'All';
  int? _pageSize = 15;
  int _pageNumber = 1;
  bool _showFilters = false;

  // Filter state for trades (similar to orders but without status filters)
  String? _selectedTradeSide;
  List<String> _tradeMarketFilters = [];
  List<String> _tradeInstrumentFilters = [];
  DateTime? _tradeFromDate;
  DateTime? _tradeToDate;
  int? _tradePageSize = 15;
  int _tradePageNumber = 1;
  bool _showTradeFilters = false;

  // Filter state for settlements
  String? _selectedSettlementStatus; // CONFIRMED, PENDING, DECLINED, or null for all
  String? _selectedSettlementTransactionType; // Transaction type for settlements
  DateTime? _settlementFromDate;
  DateTime? _settlementToDate;
  int? _settlementPageSize = 15;
  int _settlementPageNumber = 1;
  bool _showSettlementFilters = false;

  // Filter state for transactions
  List<String> _selectedTransactionTypes = []; // TRADE_BUY, TRADE_SELL, DEPOSIT_CASH, etc.
  List<String> _transactionAssetFilters = [];
  DateTime? _transactionFromDate;
  DateTime? _transactionToDate;
  int? _transactionPageSize = 15;
  int _transactionPageNumber = 1;
  bool _showTransactionFilters = false;

  // Market and Asset dropdown data
  List<Map<String, dynamic>> _availableMarkets = [];
  List<Map<String, dynamic>> _availableAssets = [];
  String? _selectedOrdersMarket;
  String? _selectedOrdersAsset;
  String? _selectedTradesMarket;
  String? _selectedTradesAsset;
  String? _selectedSettlementsMarket;
  String? _selectedSettlementsAsset;
  String? _selectedTransactionsAsset;
  bool _isLoadingMarkets = false;
  bool _isLoadingAssets = false;

  // Temporary filter state (used before applying filters)
  String? _tempSelectedOrdersMarket;
  String? _tempSelectedOrdersAsset;
  String? _tempSelectedTradesMarket;
  String? _tempSelectedTradesAsset;
  String? _tempSelectedSettlementsMarket;
  String? _tempSelectedSettlementsAsset;
  String? _tempSelectedTransactionsAsset;
  
  // Text controllers for page number fields
  late TextEditingController _pageNumberController;
  late TextEditingController _tradePageNumberController;
  late TextEditingController _settlementPageNumberController;
  late TextEditingController _transactionPageNumberController;

  // Tab management
  int _selectedTabIndex = 0;
  final List<String> _tabNames = ['Orders', 'Trades', 'Settlements', 'Transactions'];
  
  @override
  void initState() {
    super.initState();
    print('🏁 ActivityPage initState() called - initializing activity data fetch');
    
    // Initialize text controllers
    _pageNumberController = TextEditingController(text: _pageNumber.toString());
    _tradePageNumberController = TextEditingController(text: _tradePageNumber.toString());
    _settlementPageNumberController = TextEditingController(text: _settlementPageNumber.toString());
    _transactionPageNumberController = TextEditingController(text: _transactionPageNumber.toString());
    
    // Check server connectivity when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ConnectivityChecker.checkAndShowErrorIfNeeded(context, 'Activity');
    });

    // Only fetch orders on page load (default tab is Orders)
    _fetchOrders();

    // Load dropdown data
    _fetchMarketList();
    // Asset list will be fetched when market is selected
  }

  @override
  void dispose() {
    _pageNumberController.dispose();
    _tradePageNumberController.dispose();
    _settlementPageNumberController.dispose();
    _transactionPageNumberController.dispose();
    super.dispose();
  }

  /// Show date and time picker combined
  Future<DateTime?> _showDateTimePicker(BuildContext context, {
    DateTime? initialDateTime,
    DateTime? firstDate,
    DateTime? lastDate,
    String title = 'Select Date & Time',
  }) async {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    
    // First show date picker
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDateTime ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2020),
      lastDate: lastDate ?? DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
          child: child!,
        );
      },
    );
    
    if (pickedDate == null) return null;
    
    // Then show time picker
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDateTime ?? DateTime.now()),
      builder: (context, child) {
        return Theme(
          data: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
          child: child!,
        );
      },
    );
    
    if (pickedTime == null) return pickedDate;
    
    // Combine date and time
    return DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
  }

  /// Format DateTime for display with date and time
  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'Select Date and Time';
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
           '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  /// Fetch both orders and trades data
  Future<void> _fetchActivityData() async {
    print('🚀 _fetchActivityData() called - starting parallel fetch of orders and trades');
    
    // Get account ID once and use it for both orders and trades
    print('🔍 Getting account ID for both orders and trades...');
    final accountId = await _getAccountId();
    print('📋 Account ID for both orders and trades: "$accountId"');
    
    if (accountId == null || accountId.isEmpty) {
      print('❌ No account ID found - skipping both orders and trades fetch');
      setState(() {
        _isLoadingOrders = false;
        _isLoadingTrades = false;
        _ordersError = 'No account ID found for logged-in user';
        _tradesError = 'No account ID found for logged-in user';
        _orders = [];
        _trades = [];
      });
      return;
    }
    
    await Future.wait([
      _fetchOrdersWithAccountId(accountId),
      _fetchTradesWithAccountId(accountId),
      _fetchSettlementsWithAccountId(accountId),
      _fetchTransactionsWithAccountId(accountId),
    ]);
    print('🏁 _fetchActivityData() completed - both orders and trades fetch finished');
  }

  /// Find the account that belongs to the logged-in user
  String? _findUserAccount(List<dynamic> accounts, String username) {
    print('🔍 Searching for account matching user: "$username"');
    print('📋 Available accounts:');
    
    for (int i = 0; i < accounts.length; i++) {
      final accountMap = accounts[i] as Map<String, dynamic>;
      final externalId = accountMap['external_id'] ?? accountMap['externalId'] ?? accountMap['externalAccountId'] ?? '';
      final accountId = accountMap['id'] ?? accountMap['iid'] ?? '';
      print('   [$i] ID: "$accountId", ExternalID: "$externalId"');
      
      // Try exact match first (case-sensitive)
      if (externalId == username) {
        print('✅ Found EXACT match for user "$username": ID="$accountId", ExternalID="$externalId"');
        return accountId;
      }
    }
    
    // If no exact match, try case-insensitive
    for (final account in accounts) {
      final accountMap = account as Map<String, dynamic>;
      final externalId = accountMap['external_id'] ?? accountMap['externalId'] ?? accountMap['externalAccountId'] ?? '';
      final accountId = accountMap['id'] ?? accountMap['iid'] ?? '';
      
      if (externalId.toLowerCase() == username.toLowerCase()) {
        print('✅ Found case-insensitive match for user "$username": ID="$accountId", ExternalID="$externalId"');
        return accountId;
      }
    }
    
    // If still no match, try contains
    for (final account in accounts) {
      final accountMap = account as Map<String, dynamic>;
      final externalId = accountMap['external_id'] ?? accountMap['externalId'] ?? accountMap['externalAccountId'] ?? '';
      final accountId = accountMap['id'] ?? accountMap['iid'] ?? '';
      
      if (externalId.toLowerCase().contains(username.toLowerCase()) || 
          accountId.toLowerCase().contains(username.toLowerCase())) {
        print('⚠️ Found partial match for user "$username": ID="$accountId", ExternalID="$externalId"');
        return accountId;
      }
    }
    
    // If no match found for the logged-in user, return empty string
    print('❌ No account found for user "$username" on the server');
    print('🔍 Searched in ${accounts.length} accounts');
    return '';
  }

  /// Get the account ID for the current logged-in user
  Future<String?> _getAccountId() async {
    // Use cached account ID if available
    if (_cachedAccountId != null && _cachedAccountId!.isNotEmpty) {
      print('✅ Using cached account ID: $_cachedAccountId');
      return _cachedAccountId;
    }

    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final currentUsername = authService.username;
      print('🔍 Getting account ID for user: $currentUsername');

      // Get account list to find the user's account ID
      final accountListResponse = await realGrpcClient.getAccountList();
      
      String? accountId;
      if (accountListResponse['success'] == true) {
        final accounts = accountListResponse['output']['accounts'] as List<dynamic>;
        accountId = _findUserAccount(accounts, currentUsername);
      }

      print('🔍 Account ID found: "$accountId" for user: $currentUsername');

      if (accountId != null && accountId.isNotEmpty) {
        // Cache the account ID for future use
        _cachedAccountId = accountId;
        print('💾 Cached account ID: $_cachedAccountId for session');
        return accountId;
      }

      return null;
    } catch (e) {
      print('❌ Error getting account ID: $e');
      return null;
    }
  }

  /// Fetch orders using GetAccountOrders function (with account ID lookup)
  Future<void> _fetchOrders() async {
    // Get account ID
    final accountId = await _getAccountId();
    if (accountId == null || accountId.isEmpty) {
      setState(() {
        _isLoadingOrders = false;
        _ordersError = 'No account ID found for logged-in user';
        _orders = [];
      });
      return;
    }
    await _fetchOrdersWithAccountId(accountId);
  }

  /// Fetch orders using GetAccountOrders function (with provided account ID)
  Future<void> _fetchOrdersWithAccountId(String accountId) async {
    setState(() {
      _isLoadingOrders = true;
      _ordersError = '';
    });

    try {
      print('📋 Fetching orders with account ID: $accountId');

      // Prepare filter parameters
      final pagination = <String, dynamic>{
        'page_nr': _pageNumber,
      };
      if (_pageSize != null) {
        pagination['page_size'] = _pageSize!;
      }
      // Build status filter array based on dropdown selection
      List<bool>? statusFilters;
      if (_selectedOrderStatus != 'All') {
        statusFilters = [
          _selectedOrderStatus == 'Filled',
          _selectedOrderStatus == 'Cancelled',
          _selectedOrderStatus == 'Expired'
        ];
      }
      
      // Format date filters in the required timestamp format
      Map<String, dynamic>? fromTimeFormatted;
      Map<String, dynamic>? toTimeFormatted;
      
      if (_fromDate != null) {
        // Use DateTime with utc_unix_epoch_ts_millis format
        final timestamp = _fromDate!.toUtc().millisecondsSinceEpoch.toString();
        fromTimeFormatted = {
          "utc_unix_epoch_ts_millis": timestamp
        };
      }
      
      if (_toDate != null) {
        // Use DateTime with utc_unix_epoch_ts_millis format
        final timestamp = _toDate!.toUtc().millisecondsSinceEpoch.toString();
        toTimeFormatted = {
          "utc_unix_epoch_ts_millis": timestamp
        };
      }
      
      // Build market filters array from selected dropdown value
      final marketFilters = _selectedOrdersMarket != null ? [_selectedOrdersMarket!] : <String>[];
      
      // Build instrument filters array from selected dropdown value  
      final instrumentFilters = _selectedOrdersAsset != null ? [_selectedOrdersAsset!] : <String>[];

      final inputParams = {
        'ref_request_id': 'flutter-get-orders-${DateTime.now().millisecondsSinceEpoch}',
        'account_id': accountId,
        'market_id_or_name_regexes': marketFilters,
        'instrument_id_or_symbol_regexes': instrumentFilters,
        'from_time': fromTimeFormatted,
        'to_time': toTimeFormatted,
        'side': _selectedSide,
        'status_filters': statusFilters,
        'pagination': pagination,
      };

      print('🔍 GetAccountOrders INPUT: ${jsonEncode(inputParams)}');

      // Call GetAccountOrders with all parameters
      final ordersResponse = await realGrpcClient.getAccountOrders(
        accountId: accountId,
        marketIdOrNameRegexes: _marketFilters.isNotEmpty ? _marketFilters : null,
        pagination: pagination,
        fromTime: fromTimeFormatted != null ? jsonEncode(fromTimeFormatted) : null,
        toTime: toTimeFormatted != null ? jsonEncode(toTimeFormatted) : null,
        side: _selectedSide,
        statusFilters: statusFilters,
      );

      if (mounted) {
        setState(() {
          _isLoadingOrders = false;
          
          if (ordersResponse['success'] == true) {
            final output = ordersResponse['output'] as Map<String, dynamic>;
            // Extract orders from the response - adjust field name based on actual server response
            final ordersList = output['orders'] as List<dynamic>? ?? [];
            _orders = ordersList.map((order) => order as Map<String, dynamic>).toList();
            _ordersError = '';
            print('✅ Orders loaded successfully: ${_orders.length} orders found');
          } else {
            final output = ordersResponse['output'] as Map<String, dynamic>;
            _ordersError = output['error']?.toString() ?? 'Unknown error fetching orders';
            _orders = [];
            print('❌ Failed to fetch orders: $_ordersError');
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingOrders = false;
          _ordersError = 'Failed to fetch orders: ${e.toString()}';
          _orders = [];
        });
      }
      print('❌ Exception fetching orders: $e');
    }
  }

  /// Fetch trades using GetAccountTrades function (with account ID lookup)
  Future<void> _fetchTrades() async {
    // Get account ID
    final accountId = await _getAccountId();
    if (accountId == null || accountId.isEmpty) {
      setState(() {
        _isLoadingTrades = false;
        _tradesError = 'No account ID found for logged-in user';
        _trades = [];
      });
      return;
    }
    await _fetchTradesWithAccountId(accountId);
  }

  /// Fetch trades using GetAccountTrades function (with provided account ID)
  Future<void> _fetchTradesWithAccountId(String accountId) async {
    print('🚀 _fetchTradesWithAccountId() called - Starting trade fetch process with account ID: $accountId');
    
    setState(() {
      _isLoadingTrades = true;
      _tradesError = '';
    });

    try {
      print('📋 Fetching trades with account ID: $accountId');

      // Prepare filter parameters for trades
      final tradePagination = <String, dynamic>{
        'page_nr': _tradePageNumber,
      };
      if (_tradePageSize != null) {
        tradePagination['page_size'] = _tradePageSize!;
      }
      
      // Format date filters in the required timestamp format
      Map<String, dynamic>? fromTimeFormatted;
      Map<String, dynamic>? toTimeFormatted;
      
      if (_tradeFromDate != null) {
        // Use DateTime with utc_unix_epoch_ts_millis format
        final timestamp = _tradeFromDate!.toUtc().millisecondsSinceEpoch.toString();
        fromTimeFormatted = {
          "utc_unix_epoch_ts_millis": timestamp
        };
      }
      
      if (_tradeToDate != null) {
        // Use DateTime with utc_unix_epoch_ts_millis format
        final timestamp = _tradeToDate!.toUtc().millisecondsSinceEpoch.toString();
        toTimeFormatted = {
          "utc_unix_epoch_ts_millis": timestamp
        };
      }
      
      // Build market filters array from selected dropdown value
      final tradeMarketFilters = _selectedTradesMarket != null ? [_selectedTradesMarket!] : <String>[];
      
      // Build instrument filters array from selected dropdown value
      final tradeInstrumentFilters = _selectedTradesAsset != null ? [_selectedTradesAsset!] : <String>[];
      
      final tradeInputParams = {
        'ref_request_id': 'flutter-get-trades-${DateTime.now().millisecondsSinceEpoch}',
        'account_id': accountId,
        'market_id_or_name_regexes': tradeMarketFilters,
        'instrument_id_or_symbol_regexes': tradeInstrumentFilters,
        'from_time': fromTimeFormatted,
        'to_time': toTimeFormatted,
        'side': _selectedTradeSide,
        'pagination': tradePagination,
      };

      print('🔍 GetAccountTrades REQUEST PARAMETERS:');
      print('   Account ID: $accountId');
      print('   Market Filters: $tradeMarketFilters');
      print('   Instrument Filters: $tradeInstrumentFilters');
      print('   From Date: $fromTimeFormatted');
      print('   To Date: $toTimeFormatted');
      print('   Side: $_selectedTradeSide');
      print('   Page Size: $_tradePageSize');
      print('🔍 GetAccountTrades FULL INPUT: ${jsonEncode(tradeInputParams)}');

      print('📞 Making GetAccountTrades API call...');
      
      // Call GetAccountTrades with all parameters
      final tradesResponse = await realGrpcClient.getAccountTrades(
        accountId: accountId,
        marketIdOrNameRegexes: _tradeMarketFilters.isNotEmpty ? _tradeMarketFilters : null,
        pagination: tradePagination,
        fromTime: fromTimeFormatted != null ? jsonEncode(fromTimeFormatted) : null,
        toTime: toTimeFormatted != null ? jsonEncode(toTimeFormatted) : null,
        side: _selectedTradeSide,
        instrumentIdOrSymbolRegexes: _tradeInstrumentFilters.isNotEmpty ? _tradeInstrumentFilters : null,
      );

      print('📤 GetAccountTrades API RESPONSE:');
      print('   Response Type: ${tradesResponse.runtimeType}');
      print('   Full Response: ${jsonEncode(tradesResponse)}');

      print('🔄 Processing GetAccountTrades response...');
      
      if (mounted) {
        setState(() {
          _isLoadingTrades = false;
          
          print('🔍 Response success check: ${tradesResponse['success']}');
          
          if (tradesResponse['success'] == true) {
            print('✅ Response marked as successful');
            final output = tradesResponse['output'] as Map<String, dynamic>;
            print('📋 Response output keys: ${output.keys.toList()}');
            
            // Extract trades from the response - adjust field name based on actual server response
            final tradesList = output['trades'] as List<dynamic>? ?? [];
            print('📋 Trades list length: ${tradesList.length}');
            print('📋 First few trades: ${tradesList.take(3).toList()}');
            
            _trades = tradesList.map((trade) => trade as Map<String, dynamic>).toList();
            _tradesError = '';
            print('✅ Trades loaded successfully: ${_trades.length} trades found');
            print('📋 Processed trades: $_trades');
          } else {
            print('❌ Response marked as failed');
            final output = tradesResponse['output'] as Map<String, dynamic>? ?? {};
            _tradesError = output['error']?.toString() ?? 'Unknown error fetching trades';
            _trades = [];
            print('❌ Failed to fetch trades: $_tradesError');
            print('❌ Full error output: $output');
          }
        });
      }
    } catch (e) {
      print('💥 Exception caught in _fetchTrades: $e');
      print('💥 Exception stack trace: ${StackTrace.current}');
      
      if (mounted) {
        setState(() {
          _isLoadingTrades = false;
          _tradesError = 'Failed to fetch trades: ${e.toString()}';
          _trades = [];
        });
      }
      print('❌ Exception fetching trades: $e');
    }
    
    print('🏁 _fetchTrades() completed');
  }

  /// Fetch settlements (wrapper method to get account ID first)
  Future<void> _fetchSettlements() async {
    // Get account ID
    final accountId = await _getAccountId();
    if (accountId == null || accountId.isEmpty) {
      setState(() {
        _isLoadingSettlements = false;
        _settlementsError = 'No account ID found for logged-in user';
        _settlements = [];
      });
      return;
    }
    await _fetchSettlementsWithAccountId(accountId);
  }

  /// Fetch settlements using GetAccountSettlements function (with provided account ID)
  Future<void> _fetchSettlementsWithAccountId(String accountId) async {
    setState(() {
      _isLoadingSettlements = true;
      _settlementsError = '';
    });

    try {
      final settlementPagination = <String, dynamic>{
        'page_nr': _settlementPageNumber,
      };
      if (_settlementPageSize != null) {
        settlementPagination['page_size'] = _settlementPageSize!;
      }

      Map<String, dynamic>? fromTimeFormatted;
      Map<String, dynamic>? toTimeFormatted;

      if (_settlementFromDate != null) {
        final timestamp = _settlementFromDate!.toUtc().millisecondsSinceEpoch.toString();
        fromTimeFormatted = {"utc_unix_epoch_ts_millis": timestamp};
      }

      if (_settlementToDate != null) {
        final timestamp = _settlementToDate!.toUtc().millisecondsSinceEpoch.toString();
        toTimeFormatted = {"utc_unix_epoch_ts_millis": timestamp};
      }

      // Only include filters if they have values
      final settlementMarketFilters = _selectedSettlementsMarket != null && _selectedSettlementsMarket!.isNotEmpty
        ? [_selectedSettlementsMarket!]
        : null;
      final settlementAssetFilters = _selectedSettlementsAsset != null && _selectedSettlementsAsset!.isNotEmpty
        ? [_selectedSettlementsAsset!]
        : null;
      final settlementStatusFilter = _selectedSettlementStatus != null && _selectedSettlementStatus!.isNotEmpty
        ? _selectedSettlementStatus
        : null;

      // Call real API to get settlements
      final settlementsResponse = await realGrpcClient.getAccountSettlements(
        accountId: accountId,
        marketIdOrNameRegexes: settlementMarketFilters,
        assetIdOrNameRegexes: settlementAssetFilters,
        fromTime: fromTimeFormatted != null ? json.encode(fromTimeFormatted) : null,
        toTime: toTimeFormatted != null ? json.encode(toTimeFormatted) : null,
        status: settlementStatusFilter,
        pagination: settlementPagination,
      );

      if (mounted) {
        setState(() {
          _isLoadingSettlements = false;

          if (settlementsResponse['success'] == true) {
            final output = settlementsResponse['output'] as Map<String, dynamic>;
            final settlementsList = output['settlements'] as List<dynamic>? ?? [];
            _settlements = settlementsList.map((settlement) => settlement as Map<String, dynamic>).toList();
            _settlementsError = '';
          } else {
            final output = settlementsResponse['output'] as Map<String, dynamic>;
            _settlementsError = output['error']?.toString() ?? 'Unknown error fetching settlements';
            _settlements = [];
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingSettlements = false;
          _settlementsError = 'Failed to fetch settlements: ${e.toString()}';
          _settlements = [];
        });
      }
    }
  }

  /// Fetch transactions (wrapper method to get account ID first)
  Future<void> _fetchTransactions() async {
    // Get account ID
    final accountId = await _getAccountId();
    if (accountId == null || accountId.isEmpty) {
      setState(() {
        _isLoadingTransactions = false;
        _transactionsError = 'No account ID found for logged-in user';
        _transactions = [];
      });
      return;
    }
    await _fetchTransactionsWithAccountId(accountId);
  }

  /// Fetch transactions using GetAccountTransactions function (with provided account ID)
  Future<void> _fetchTransactionsWithAccountId(String accountId) async {
    setState(() {
      _isLoadingTransactions = true;
      _transactionsError = '';
    });

    try {
      final transactionPagination = <String, dynamic>{
        'page_nr': _transactionPageNumber,
      };
      if (_transactionPageSize != null) {
        transactionPagination['page_size'] = _transactionPageSize!;
      }

      Map<String, dynamic>? fromTimeFormatted;
      Map<String, dynamic>? toTimeFormatted;

      if (_transactionFromDate != null) {
        final timestamp = _transactionFromDate!.toUtc().millisecondsSinceEpoch.toString();
        fromTimeFormatted = {"utc_unix_epoch_ts_millis": timestamp};
      }

      if (_transactionToDate != null) {
        final timestamp = _transactionToDate!.toUtc().millisecondsSinceEpoch.toString();
        toTimeFormatted = {"utc_unix_epoch_ts_millis": timestamp};
      }

      final transactionAssetFilters = _selectedTransactionsAsset != null ? [_selectedTransactionsAsset!] : <String>[];

      final transactionInputParams = {
        'ref_request_id': 'flutter-get-transactions-${DateTime.now().millisecondsSinceEpoch}',
        'account_id': accountId,
        'pagination': transactionPagination,
        'from_time': fromTimeFormatted,
        'to_time': toTimeFormatted,
        'transaction_types': _selectedTransactionTypes.isNotEmpty ? _selectedTransactionTypes : null,
        'asset_id_or_name_regexes': transactionAssetFilters.isNotEmpty ? transactionAssetFilters : null,
      };

      transactionInputParams.removeWhere((key, value) => value == null);

      // TODO: Replace with real API call when GetAccountTransactions is implemented
      // final transactionsResponse = await realGrpcClient.getAccountTransactions(
      //   accountId: accountId,
      //   pagination: transactionPagination,
      //   fromTime: fromTimeFormatted != null ? json.encode(fromTimeFormatted) : null,
      //   toTime: toTimeFormatted != null ? json.encode(toTimeFormatted) : null,
      //   transactionTypes: _selectedTransactionTypes.isNotEmpty ? _selectedTransactionTypes : null,
      //   assetIdOrNameRegexes: transactionAssetFilters.isNotEmpty ? transactionAssetFilters : null,
      // );

      // Mock transactions response for UI demonstration
      final transactionsResponse = {
        'success': true,
        'output': {
          'transactions': [
            {
              'transaction_id': 'txn_deposit_12345',
              'transaction_hash': '0xabcdef1234567890abcdef1234567890abcdef12',
              'timestamp': {'ts': DateTime.now().subtract(Duration(hours: 2)).toIso8601String()},
              'type': 'TRANSACTION_TYPE__DEPOSIT_CASH',
              'operation': 'CASH_DEPOSIT',
              'account_id': accountId,
              'from_account': 'external_bank_001',
              'to_account': accountId,
              'asset_id': 'USDC',
              'amount': '10000000000',
              'reference_id': 'bank_transfer_ref_789',
              'reference_type': 'bank_transfer',
              'description': 'Cash deposit from external bank account',
              'metadata': '{"bank_ref": "TXN789456123", "wire_id": "WIRE001"}',
            },
            {
              'transaction_id': 'txn_trade_buy_67890',
              'transaction_hash': '0x1234567890abcdef1234567890abcdef12345678',
              'timestamp': {'ts': DateTime.now().subtract(Duration(hours: 4)).toIso8601String()},
              'type': 'TRANSACTION_TYPE__TRADE_BUY',
              'operation': 'SPOT_BUY',
              'account_id': accountId,
              'from_account': accountId,
              'to_account': 'acc_marketmaker_001',
              'asset_id': 'ETH',
              'amount': '2500000000000000000',
              'reference_id': 'order_eth_buy_5678',
              'reference_type': 'order',
              'description': 'ETH purchase via spot order',
              'metadata': '{"order_id": "order_eth_buy_5678", "trade_id": "trade_eth_12345", "price": "1700.00"}',
            },
            {
              'transaction_id': 'txn_settlement_11111',
              'transaction_hash': '0xfedcba0987654321fedcba0987654321fedcba09',
              'timestamp': {'ts': DateTime.now().subtract(Duration(hours: 6)).toIso8601String()},
              'type': 'TRANSACTION_TYPE__SETTLEMENT',
              'operation': 'ASSET_SETTLEMENT',
              'account_id': accountId,
              'from_account': 'acc_marketmaker_001',
              'to_account': accountId,
              'asset_id': 'ETH',
              'amount': '2500000000000000000',
              'reference_id': 'settle_eth_12345',
              'reference_type': 'settlement',
              'description': 'ETH settlement for trade execution',
              'metadata': '{"settlement_id": "settle_eth_12345", "trade_id": "trade_eth_12345"}',
            },
            {
              'transaction_id': 'txn_fee_22222',
              'transaction_hash': '0x55556666777788889999000011112222333344444',
              'timestamp': {'ts': DateTime.now().subtract(Duration(hours: 8)).toIso8601String()},
              'type': 'TRANSACTION_TYPE__FEE',
              'operation': 'TRADING_FEE',
              'account_id': accountId,
              'from_account': accountId,
              'to_account': 'acc_fee_collection',
              'asset_id': 'USDC',
              'amount': '8500000',
              'reference_id': 'trade_eth_12345',
              'reference_type': 'trade',
              'description': 'Trading fee for ETH purchase',
              'metadata': '{"fee_rate": "0.002", "trade_volume": "4250.00"}',
            },
            {
              'transaction_id': 'txn_trade_sell_33333',
              'transaction_hash': '0x99998888777766665555444433332222111100000',
              'timestamp': {'ts': DateTime.now().subtract(Duration(days: 1)).toIso8601String()},
              'type': 'TRANSACTION_TYPE__TRADE_SELL',
              'operation': 'SPOT_SELL',
              'account_id': accountId,
              'from_account': accountId,
              'to_account': 'acc_hedge_fund_xyz',
              'asset_id': 'BTC',
              'amount': '50000000',
              'reference_id': 'order_btc_sell_9012',
              'reference_type': 'order',
              'description': 'BTC sale via spot order',
              'metadata': '{"order_id": "order_btc_sell_9012", "trade_id": "trade_btc_67890", "price": "55000.00"}',
            },
          ]
        }
      };

      if (mounted) {
        setState(() {
          _isLoadingTransactions = false;

          if (transactionsResponse['success'] == true) {
            final output = transactionsResponse['output'] as Map<String, dynamic>;
            final transactionsList = output['transactions'] as List<dynamic>? ?? [];
            _transactions = transactionsList.map((transaction) => transaction as Map<String, dynamic>).toList();
            _transactionsError = '';
          } else {
            final output = transactionsResponse['output'] as Map<String, dynamic>;
            _transactionsError = output['error']?.toString() ?? 'Unknown error fetching transactions';
            _transactions = [];
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingTransactions = false;
          _transactionsError = 'Failed to fetch transactions: ${e.toString()}';
          _transactions = [];
        });
      }
    }
  }

  /// Fetch market list for dropdown filters
  Future<void> _fetchMarketList() async {
    if (_isLoadingMarkets) return;
    
    setState(() {
      _isLoadingMarkets = true;
    });
    
    try {
      print('📋 Fetching market list for dropdown filters...');
      
      final response = await realGrpcClient.getMarketList();
      
      if (mounted) {
        setState(() {
          _isLoadingMarkets = false;
          
          if (response['success'] == true) {
            final output = response['output'] as Map<String, dynamic>;
            final marketsList = output['markets'] as List<dynamic>? ?? [];
            
            _availableMarkets = marketsList.map((market) => market as Map<String, dynamic>).toList();
            print('✅ Markets loaded successfully: ${_availableMarkets.length} markets found');
          } else {
            print('❌ Failed to fetch markets: ${response['output']['error']}');
            _availableMarkets = [];
          }
        });
      }
    } catch (e) {
      print('❌ Exception fetching markets: $e');
      if (mounted) {
        setState(() {
          _isLoadingMarkets = false;
          _availableMarkets = [];
        });
      }
    }
  }

  /// Fetch data for the currently active tab
  void _fetchDataForActiveTab() {
    switch (_selectedTabIndex) {
      case 0: // Orders tab
        _fetchOrders();
        break;
      case 1: // Trades tab
        _fetchTrades();
        break;
      case 2: // Settlements tab
        _fetchSettlements();
        break;
      case 3: // Transactions tab
        _fetchTransactions();
        break;
    }
  }

  /// Apply filter changes and refresh data for active tab only
  void _applyFilters() {
    setState(() {
      // Apply temporary filter state to actual filter state
      _selectedOrdersMarket = _tempSelectedOrdersMarket;
      _selectedOrdersAsset = _tempSelectedOrdersAsset;
      _selectedTradesMarket = _tempSelectedTradesMarket;
      _selectedTradesAsset = _tempSelectedTradesAsset;
      
      // Reset pagination when filters are applied
      _pageSize = 15;
      _pageNumber = 1;
      _tradePageSize = 15;
      _tradePageNumber = 1;
    });

    // Refresh data only for the active tab
    _fetchDataForActiveTab();
  }

  /// Clear all orders filters
  void _clearOrdersFilters() {
    setState(() {
      _selectedSide = null;
      _marketFilters = [];
      _instrumentFilters = [];
      _fromDate = null;
      _toDate = null;
      _selectedOrderStatus = 'All';
      _pageSize = 15;
      _pageNumber = 1;
      _selectedOrdersMarket = null;
      _selectedOrdersAsset = null;
      _tempSelectedOrdersMarket = null;
      _tempSelectedOrdersAsset = null;
    });
    _pageNumberController.text = '1';
  }

  /// Clear all trades filters
  void _clearTradesFilters() {
    setState(() {
      _selectedTradeSide = null;
      _tradeMarketFilters = [];
      _tradeInstrumentFilters = [];
      _tradeFromDate = null;
      _tradeToDate = null;
      _tradePageSize = 15;
      _tradePageNumber = 1;
      _selectedTradesMarket = null;
      _selectedTradesAsset = null;
      _tempSelectedTradesMarket = null;
      _tempSelectedTradesAsset = null;
    });
    _tradePageNumberController.text = '1';
  }

  /// Clear all settlements filters
  void _clearSettlementsFilters() {
    setState(() {
      _selectedSettlementStatus = null;
      _selectedSettlementTransactionType = null;
      _selectedSettlementsMarket = null;
      _selectedSettlementsAsset = null;
      _tempSelectedSettlementsMarket = null;
      _tempSelectedSettlementsAsset = null;
      _settlementFromDate = null;
      _settlementToDate = null;
      _settlementPageSize = 15;
      _settlementPageNumber = 1;
    });
    _settlementPageNumberController.text = '1';
  }

  /// Clear all transactions filters
  void _clearTransactionsFilters() {
    setState(() {
      _selectedTransactionTypes.clear();
      _selectedTransactionsAsset = null;
      _tempSelectedTransactionsAsset = null;
      _transactionFromDate = null;
      _transactionToDate = null;
      _transactionPageSize = 15;
      _transactionPageNumber = 1;
    });
    _transactionPageNumberController.text = '1';
  }

  /// Fetch asset list for dropdown filters using GetOrderbook
  Future<void> _fetchAssetList(String? marketId) async {
    if (_isLoadingAssets) return;
    
    if (marketId == null || marketId.isEmpty) {
      setState(() {
        _availableAssets = [];
      });
      return;
    }

    setState(() {
      _isLoadingAssets = true;
    });
    
    try {
      print('📋 Fetching assets for market: $marketId...');
      
      final result = await realGrpcClient.getMarketInstrumentList(
        marketId: marketId,
      );
      
      if (mounted) {
        setState(() {
          _isLoadingAssets = false;
          if (result['success'] == true) {
            final output = result['output'];
            print('✅ GetMarketInstrumentList response for market $marketId: $output');
            
            if (output is Map<String, dynamic>) {
              // Extract instruments from the response based on actual server structure
              final instruments = output['instruments'] ?? output['instrumentList'] ?? output['instrument_list'] ?? [];
              if (instruments is List && instruments.isNotEmpty) {
                // Process instruments to extract the symbol values from nested structure
                final processedAssets = <Map<String, dynamic>>[];
                for (final instrument in instruments) {
                  if (instrument is Map<String, dynamic>) {
                    // Extract from identifiers structure: identifiers -> ids -> value
                    String assetId = '';
                    String assetName = '';
                    
                    // Get the iid as asset ID
                    assetId = instrument['iid']?.toString() ?? '';
                    
                    // Extract from identifiers -> ids -> value
                    final identifiers = instrument['identifiers'] as List?;
                    if (identifiers != null && identifiers.isNotEmpty) {
                      final firstIdentifier = identifiers.first;
                      if (firstIdentifier is Map) {
                        final idsArray = firstIdentifier['ids'] as List?;
                        if (idsArray != null && idsArray.isNotEmpty) {
                          final firstId = idsArray.first;
                          if (firstId is Map && firstId.containsKey('value')) {
                            final symbolValue = firstId['value'].toString();
                            if (assetId.isEmpty) {
                              assetId = symbolValue;
                            }
                            assetName = symbolValue;
                          }
                        }
                      }
                    }
                    
                    // Extract display name
                    final displayNames = instrument['displayNames'] as Map?;
                    if (displayNames != null && displayNames.isNotEmpty) {
                      assetName = displayNames['en']?.toString() ?? 
                                  displayNames.values.first?.toString() ?? assetName;
                    }
                    
                    if (assetId.isNotEmpty) {
                      processedAssets.add({
                        'id': assetId,
                        'symbol': assetName.isNotEmpty ? assetName : assetId,
                        'instrument_id': assetId,
                        'description': assetName.isNotEmpty ? assetName : assetId,
                      });
                    }
                  }
                }
                
                _availableAssets = processedAssets;
                print('✅ Assets loaded for market $marketId: ${_availableAssets.length} assets found');
                if (_availableAssets.isNotEmpty) {
                  print('📋 Sample assets: ${_availableAssets.take(3).map((a) => a['symbol']).toList()}');
                }
              } else {
                _availableAssets = [];
                print('⚠️ No instruments found in market $marketId response');
              }
            } else {
              _availableAssets = [];
              print('⚠️ Unexpected response format for market $marketId');
            }
          } else {
            print('❌ GetMarketInstrumentList failed for market $marketId: ${result['output']}');
            _availableAssets = [];
          }
        });
      }
    } catch (e) {
      print('❌ Exception fetching assets: $e');
      if (mounted) {
        setState(() {
          _isLoadingAssets = false;
          _availableAssets = [];
        });
      }
    }
  }

  /// Build orders table widget
  Widget _buildOrdersTable(bool isDarkTheme) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkTheme ? const Color(0xFF1e1e1e) : Colors.white,
        borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Table header
          Container(
            padding: UIConstants.paddingStandard,
            decoration: BoxDecoration(
              color: isDarkTheme ? const Color(0xFF2d2d2d) : Colors.grey[50],
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Filters',
                  style: TextStyle(
                    fontSize: UIConstants.fontSizeMd,
                    fontWeight: UIConstants.fontWeightMedium,
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(width: UIConstants.spacingMd),
                // Filter toggle button
                IconButton(
                  onPressed: () {
                    setState(() {
                      _showFilters = !_showFilters;
                    });
                  },
                  icon: Icon(
                    _showFilters ? Icons.filter_alt : Icons.filter_alt_outlined,
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
                  tooltip: 'Toggle Filters',
                ),
                const Spacer(),
                if (_isLoadingOrders)
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isDarkTheme ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Filter section
          if (_showFilters)
            Container(
              padding: UIConstants.paddingStandard,
              decoration: BoxDecoration(
                color: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.grey[100],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: UIConstants.spacingMd),
                  // Market, Asset and Status filters row
                  Row(
                    children: [
                      // Market filter
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Market',
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeSm,
                                fontWeight: UIConstants.fontWeightNormal,
                                color: isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: isDarkTheme ? const Color(0xFF3a3a3a) : Colors.white,
                                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                border: Border.all(
                                  color: isDarkTheme ? Colors.grey[600]! : Colors.grey[300]!,
                                ),
                              ),
                              child: DropdownButton<String?>(
                                value: _tempSelectedOrdersMarket ?? _selectedOrdersMarket,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.white,
                                iconEnabledColor: isDarkTheme ? Colors.grey[300] : Colors.grey[600],
                                iconDisabledColor: isDarkTheme ? Colors.grey[600] : Colors.grey[400],
                                items: [
                                  DropdownMenuItem(value: null, child: Text('All Markets', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))),
                                  ..._availableMarkets.map<DropdownMenuItem<String?>>((market) {
                                    // Extract identifier string from nested structure
                                    // Try iid first as it seems to be the unique identifier in the API
                                    String marketId = market['iid']?.toString() ?? '';
                                    
                                    // If no iid, try extracting from identifiers structure
                                    if (marketId.isEmpty) {
                                      final identifiers = market['identifiers'] as List?;
                                      if (identifiers != null && identifiers.isNotEmpty) {
                                        final firstIdentifier = identifiers.first;
                                        if (firstIdentifier is Map) {
                                          // Check if there's an 'ids' array with nested 'value'
                                          final idsArray = firstIdentifier['ids'] as List?;
                                          if (idsArray != null && idsArray.isNotEmpty) {
                                            final firstId = idsArray.first;
                                            if (firstId is Map) {
                                              marketId = firstId['value']?.toString() ?? '';
                                            } else if (firstId is String) {
                                              marketId = firstId;
                                            }
                                          }
                                          // Fallback to direct value/id fields
                                          if (marketId.isEmpty) {
                                            marketId = firstIdentifier['value']?.toString() ?? firstIdentifier['id']?.toString() ?? '';
                                          }
                                        } else if (firstIdentifier is String) {
                                          marketId = firstIdentifier;
                                        }
                                      }
                                    }
                                    
                                    // Final fallback
                                    if (marketId.isEmpty) {
                                      marketId = market['id']?.toString() ?? '';
                                    }

                                    // Extract name string from nested structure
                                    String marketName = 'Unknown';
                                    final displayNames = market['displayNames'] as Map?;
                                    if (displayNames != null && displayNames.isNotEmpty) {
                                      // displayNames is an object like {"en": "Cryptocurrency Market"}
                                      // Try to get the 'en' key first, then try any key
                                      final enName = displayNames['en']?.toString();
                                      final anyName = displayNames.values.first?.toString();
                                      marketName = enName ?? anyName ?? 'Unknown';
                                    }
                                    if (marketName == 'Unknown') {
                                      marketName = market['name']?.toString() ?? 'Unknown';
                                    }

                                    return DropdownMenuItem<String?>(
                                      value: marketId,
                                      child: Text(
                                        marketName,
                                        style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black)
                                      )
                                    );
                                  }).toList(),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _tempSelectedOrdersMarket = value;
                                    // Reset asset selection when market changes
                                    _tempSelectedOrdersAsset = null;
                                  });
                                  // Fetch assets for the selected market
                                  if (value != null) {
                                    _fetchAssetList(value);
                                  } else {
                                    _availableAssets = [];
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: UIConstants.spacingMd),
                      // Asset filter
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Asset',
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeSm,
                                fontWeight: UIConstants.fontWeightNormal,
                                color: isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: isDarkTheme ? const Color(0xFF3a3a3a) : Colors.white,
                                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                border: Border.all(
                                  color: isDarkTheme ? Colors.grey[600]! : Colors.grey[300]!,
                                ),
                              ),
                              child: DropdownButton<String?>(
                                value: _tempSelectedOrdersAsset ?? _selectedOrdersAsset,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.white,
                                iconEnabledColor: isDarkTheme ? Colors.grey[300] : Colors.grey[600],
                                iconDisabledColor: isDarkTheme ? Colors.grey[600] : Colors.grey[400],
                                items: (_tempSelectedOrdersMarket ?? _selectedOrdersMarket) == null ? [
                                  DropdownMenuItem(value: null, child: Text('Select Market First', style: TextStyle(color: isDarkTheme ? Colors.grey : Colors.grey)))
                                ] : [
                                  DropdownMenuItem(value: null, child: Text('All Assets', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))),
                                  ..._availableAssets.map<DropdownMenuItem<String?>>((asset) => 
                                    DropdownMenuItem<String?>(
                                      value: asset['id'] ?? asset['symbol'] ?? asset['instrument_id'] ?? '',
                                      child: Text(
                                        asset['symbol'] ?? asset['id'] ?? asset['instrument_id'] ?? 'Unknown',
                                        style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black)
                                      )
                                    )
                                  ).toList(),
                                ],
                                onChanged: (_tempSelectedOrdersMarket ?? _selectedOrdersMarket) == null ? null : (value) {
                                  setState(() {
                                    _tempSelectedOrdersAsset = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: UIConstants.spacingMd),
                      // Side filter
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Side',
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeSm,
                                fontWeight: UIConstants.fontWeightNormal,
                                color: isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: isDarkTheme ? const Color(0xFF3a3a3a) : Colors.white,
                                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                border: Border.all(
                                  color: isDarkTheme ? Colors.grey[600]! : Colors.grey[300]!,
                                ),
                              ),
                              child: DropdownButton<String?>(
                                value: _selectedSide,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.white,
                                iconEnabledColor: isDarkTheme ? Colors.grey[300] : Colors.grey[600],
                                iconDisabledColor: isDarkTheme ? Colors.grey[600] : Colors.grey[400],
                                items: [
                                  DropdownMenuItem(value: null, child: Text('All', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))),
                                  DropdownMenuItem(value: '1', child: Text('Buy', style: TextStyle(color: Colors.green))),
                                  DropdownMenuItem(value: '2', child: Text('Sell', style: TextStyle(color: Colors.red))),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedSide = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: UIConstants.spacingMd),
                      // Status filter
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Status',
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeSm,
                                fontWeight: UIConstants.fontWeightNormal,
                                color: isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: isDarkTheme ? const Color(0xFF3a3a3a) : Colors.white,
                                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                border: Border.all(
                                  color: isDarkTheme ? Colors.grey[600]! : Colors.grey[300]!,
                                ),
                              ),
                              child: DropdownButton<String>(
                                value: _selectedOrderStatus,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.white,
                                iconEnabledColor: isDarkTheme ? Colors.grey[300] : Colors.grey[600],
                                iconDisabledColor: isDarkTheme ? Colors.grey[600] : Colors.grey[400],
                                style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
                                items: ['All', 'Filled', 'Cancelled', 'Expired']
                                    .map((status) => DropdownMenuItem(
                                          value: status,
                                          child: Text(status),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOrderStatus = value ?? 'All';
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: UIConstants.spacingMd),
                  // Date filters row
                  Row(
                    children: [
                      // From Date filter
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'From Date',
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeSm,
                                fontWeight: UIConstants.fontWeightNormal,
                                color: isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            InkWell(
                              onTap: () async {
                                final DateTime? picked = await _showDateTimePicker(
                                  context,
                                  initialDateTime: _fromDate ?? DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime.now(),
                                  title: 'Select From Date & Time',
                                );
                                if (picked != null) {
                                  setState(() {
                                    _fromDate = picked;
                                    // Reset toDate if it's before the new fromDate
                                    if (_toDate != null && _toDate!.isBefore(picked)) {
                                      _toDate = null;
                                    }
                                  });
                                }
                              },
                              child: Container(
                                height: 38,
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: isDarkTheme ? const Color(0xFF3a3a3a) : Colors.white,
                                  borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                  border: Border.all(
                                    color: isDarkTheme ? Colors.grey[600]! : Colors.grey[300]!,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _formatDateTime(_fromDate),
                                        style: TextStyle(
                                          color: isDarkTheme ? Colors.white : Colors.black,
                                          fontSize: UIConstants.textFieldFontSize,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.calendar_today,
                                      size: 16,
                                      color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: UIConstants.spacingMd),
                      // To Date filter
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'To Date',
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeSm,
                                fontWeight: UIConstants.fontWeightNormal,
                                color: isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            InkWell(
                              onTap: () async {
                                final DateTime? picked = await _showDateTimePicker(
                                  context,
                                  initialDateTime: _toDate ?? DateTime.now(),
                                  firstDate: _fromDate ?? DateTime(2020), // Cannot be before fromDate
                                  lastDate: DateTime.now(),
                                  title: 'Select To Date & Time',
                                );
                                if (picked != null) {
                                  setState(() {
                                    _toDate = picked;
                                  });
                                }
                              },
                              child: Container(
                                height: 38,
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: isDarkTheme ? const Color(0xFF3a3a3a) : Colors.white,
                                  borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                  border: Border.all(
                                    color: isDarkTheme ? Colors.grey[600]! : Colors.grey[300]!,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _formatDateTime(_toDate),
                                        style: TextStyle(
                                          color: isDarkTheme ? Colors.white : Colors.black,
                                          fontSize: UIConstants.textFieldFontSize,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.calendar_today,
                                      size: 16,
                                      color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: UIConstants.spacingMd),
                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          _applyFilters(); // Apply filter changes and refresh orders
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Apply Filters'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(width: UIConstants.spacingMd),
                      ElevatedButton.icon(
                        onPressed: () {
                          _clearOrdersFilters();
                        },
                        icon: const Icon(Icons.clear),
                        label: const Text('Clear'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          // Orders table content
          Expanded(
            child: Column(
              children: [
                // Table header row - always show
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          'Order ID',
                          style: TextStyle(
                            fontSize: UIConstants.textFieldFontSize,
                            color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Account',
                        style: TextStyle(
                          fontSize: UIConstants.textFieldFontSize,
                          color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Symbol',
                        style: TextStyle(
                          fontSize: UIConstants.textFieldFontSize,
                          color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Quantity',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: UIConstants.textFieldFontSize,
                          color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          'Price',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: UIConstants.textFieldFontSize,
                            color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: UIConstants.spacingSm),
                Container(
                  height: 1,
                  color: isDarkTheme ? Colors.grey[700] : Colors.grey[300],
                ),
                const SizedBox(height: UIConstants.spacingSm),
                // Table rows
                Flexible(
                  child: _isLoadingOrders
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isDarkTheme ? Colors.white : Colors.black,
                            ),
                          ),
                        )
                      : _orders.isEmpty
                          ? Center(
                              child: Text(
                                'No orders found',
                                style: TextStyle(
                                  color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                  fontSize: UIConstants.textFieldFontSize,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: _orders.length,
                              itemBuilder: (context, index) {
                                final order = _orders[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    children: [
                                      // Order ID
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 16),
                                          child: Text(
                                            order['orderId']?.toString() ?? 
                                            order['id']?.toString() ?? 
                                            order['order_id']?.toString() ?? 
                                            'N/A',
                                            style: TextStyle(
                                              fontSize: UIConstants.textFieldFontSize,
                                              color: isDarkTheme ? Colors.white : Colors.black,
                                              fontWeight: UIConstants.fontWeightNormal,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      // Account
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          order['participantAccountId']?.toString() ?? 
                                          order['account_id']?.toString() ?? 
                                          order['participant_account']?.toString() ?? 
                                          'N/A',
                                          style: TextStyle(
                                            fontSize: UIConstants.textFieldFontSize,
                                            color: isDarkTheme ? Colors.white : Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      // Symbol
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          order['symbol']?.toString() ?? 
                                          order['asset_id']?.toString() ?? 
                                          'N/A',
                                          style: TextStyle(
                                            fontSize: UIConstants.textFieldFontSize,
                                            color: isDarkTheme ? Colors.white : Colors.black,
                                          ),
                                        ),
                                      ),
                                      // Quantity
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          order['quantity']?.toString() ?? 'N/A',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: UIConstants.textFieldFontSize,
                                            color: isDarkTheme ? Colors.white : Colors.black,
                                          ),
                                        ),
                                      ),
                                      // Price
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 16),
                                          child: Text(
                                            order['price']?.toString() ?? 'N/A',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: UIConstants.textFieldFontSize,
                                              color: isDarkTheme ? Colors.white : Colors.black,
                                              fontWeight: UIConstants.fontWeightNormal,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                ),
              ],
            ),
          ),
          // Show More button for orders
          if (_orders.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (_cachedAccountId != null && _cachedAccountId!.isNotEmpty) {
                      setState(() {
                        _pageSize = (_pageSize ?? 15) + 15;
                      });
                      await _fetchOrdersWithAccountId(_cachedAccountId!);
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Show More'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkTheme
                        ? const Color(0xFF2d2d2d)
                        : Colors.grey[100],
                    foregroundColor: isDarkTheme
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Build trades table widget
  Widget _buildTradesTable(bool isDarkTheme) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkTheme ? const Color(0xFF1e1e1e) : Colors.white,
        borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Table header
          Container(
            padding: UIConstants.paddingStandard,
            decoration: BoxDecoration(
              color: isDarkTheme ? const Color(0xFF2d2d2d) : Colors.grey[50],
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Filters',
                  style: TextStyle(
                    fontSize: UIConstants.fontSizeMd,
                    fontWeight: UIConstants.fontWeightMedium,
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(width: UIConstants.spacingMd),
                // Filter toggle button for trades
                IconButton(
                  onPressed: () {
                    setState(() {
                      _showTradeFilters = !_showTradeFilters;
                    });
                  },
                  icon: Icon(
                    _showTradeFilters ? Icons.filter_alt : Icons.filter_alt_outlined,
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
                  tooltip: 'Toggle Filters',
                ),
                const Spacer(),
                if (_isLoadingTrades)
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isDarkTheme ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Filter section for trades
          if (_showTradeFilters)
            Container(
              padding: UIConstants.paddingStandard,
              decoration: BoxDecoration(
                color: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.grey[100],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Market and Asset and Side filters row for trades
                  Row(
                    children: [
                      // Market filter for trades
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Market',
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeSm,
                                fontWeight: UIConstants.fontWeightNormal,
                                color: isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: isDarkTheme ? const Color(0xFF3a3a3a) : Colors.white,
                                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                border: Border.all(
                                  color: isDarkTheme ? Colors.grey[600]! : Colors.grey[300]!,
                                ),
                              ),
                              child: DropdownButton<String?>(
                                value: _tempSelectedTradesMarket ?? _selectedTradesMarket,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.white,
                                iconEnabledColor: isDarkTheme ? Colors.grey[300] : Colors.grey[600],
                                iconDisabledColor: isDarkTheme ? Colors.grey[600] : Colors.grey[400],
                                items: [
                                  DropdownMenuItem(value: null, child: Text('All Markets', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))),
                                  ..._availableMarkets.map<DropdownMenuItem<String?>>((market) {
                                    // Extract identifier string from nested structure
                                    // Try iid first as it seems to be the unique identifier in the API
                                    String marketId = market['iid']?.toString() ?? '';
                                    
                                    // If no iid, try extracting from identifiers structure
                                    if (marketId.isEmpty) {
                                      final identifiers = market['identifiers'] as List?;
                                      if (identifiers != null && identifiers.isNotEmpty) {
                                        final firstIdentifier = identifiers.first;
                                        if (firstIdentifier is Map) {
                                          // Check if there's an 'ids' array with nested 'value'
                                          final idsArray = firstIdentifier['ids'] as List?;
                                          if (idsArray != null && idsArray.isNotEmpty) {
                                            final firstId = idsArray.first;
                                            if (firstId is Map) {
                                              marketId = firstId['value']?.toString() ?? '';
                                            } else if (firstId is String) {
                                              marketId = firstId;
                                            }
                                          }
                                          // Fallback to direct value/id fields
                                          if (marketId.isEmpty) {
                                            marketId = firstIdentifier['value']?.toString() ?? firstIdentifier['id']?.toString() ?? '';
                                          }
                                        } else if (firstIdentifier is String) {
                                          marketId = firstIdentifier;
                                        }
                                      }
                                    }
                                    
                                    // Final fallback
                                    if (marketId.isEmpty) {
                                      marketId = market['id']?.toString() ?? '';
                                    }

                                    // Extract name string from nested structure
                                    String marketName = 'Unknown';
                                    final displayNames = market['displayNames'] as Map?;
                                    if (displayNames != null && displayNames.isNotEmpty) {
                                      // displayNames is an object like {"en": "Cryptocurrency Market"}
                                      // Try to get the 'en' key first, then try any key
                                      final enName = displayNames['en']?.toString();
                                      final anyName = displayNames.values.first?.toString();
                                      marketName = enName ?? anyName ?? 'Unknown';
                                    }
                                    if (marketName == 'Unknown') {
                                      marketName = market['name']?.toString() ?? 'Unknown';
                                    }

                                    return DropdownMenuItem<String?>(
                                      value: marketId,
                                      child: Text(
                                        marketName,
                                        style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black)
                                      )
                                    );
                                  }).toList(),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _tempSelectedTradesMarket = value;
                                    // Reset asset selection when market changes
                                    _tempSelectedTradesAsset = null;
                                  });
                                  // Fetch assets for the selected market
                                  if (value != null) {
                                    _fetchAssetList(value);
                                  } else {
                                    _availableAssets = [];
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: UIConstants.spacingMd),
                      // Asset filter for trades
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Asset',
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeSm,
                                fontWeight: UIConstants.fontWeightNormal,
                                color: isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: isDarkTheme ? const Color(0xFF3a3a3a) : Colors.white,
                                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                border: Border.all(
                                  color: isDarkTheme ? Colors.grey[600]! : Colors.grey[300]!,
                                ),
                              ),
                              child: DropdownButton<String?>(
                                value: _tempSelectedTradesAsset ?? _selectedTradesAsset,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.white,
                                iconEnabledColor: isDarkTheme ? Colors.grey[300] : Colors.grey[600],
                                iconDisabledColor: isDarkTheme ? Colors.grey[600] : Colors.grey[400],
                                items: (_tempSelectedTradesMarket ?? _selectedTradesMarket) == null ? [
                                  DropdownMenuItem(value: null, child: Text('Select Market First', style: TextStyle(color: isDarkTheme ? Colors.grey : Colors.grey)))
                                ] : [
                                  DropdownMenuItem(value: null, child: Text('All Assets', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))),
                                  ..._availableAssets.map<DropdownMenuItem<String?>>((asset) => 
                                    DropdownMenuItem<String?>(
                                      value: asset['id'] ?? asset['symbol'] ?? asset['instrument_id'] ?? '',
                                      child: Text(
                                        asset['symbol'] ?? asset['id'] ?? asset['instrument_id'] ?? 'Unknown',
                                        style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black)
                                      )
                                    )
                                  ).toList(),
                                ],
                                onChanged: (_tempSelectedTradesMarket ?? _selectedTradesMarket) == null ? null : (value) {
                                  setState(() {
                                    _tempSelectedTradesAsset = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: UIConstants.spacingMd),
                      // Side filter for trades
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Side',
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeSm,
                                fontWeight: UIConstants.fontWeightNormal,
                                color: isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: isDarkTheme ? const Color(0xFF3a3a3a) : Colors.white,
                                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                border: Border.all(
                                  color: isDarkTheme ? Colors.grey[600]! : Colors.grey[300]!,
                                ),
                              ),
                              child: DropdownButton<String?>(
                                value: _selectedTradeSide,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.white,
                                iconEnabledColor: isDarkTheme ? Colors.grey[300] : Colors.grey[600],
                                iconDisabledColor: isDarkTheme ? Colors.grey[600] : Colors.grey[400],
                                items: [
                                  DropdownMenuItem(value: null, child: Text('All', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))),
                                  DropdownMenuItem(value: '1', child: Text('Buy', style: TextStyle(color: Colors.green))),
                                  DropdownMenuItem(value: '2', child: Text('Sell', style: TextStyle(color: Colors.red))),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedTradeSide = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: UIConstants.spacingMd),
                    ],
                  ),
                  const SizedBox(height: UIConstants.spacingMd),
                  // Date filters row
                  Row(
                    children: [
                      // From Date filter
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'From Date',
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeSm,
                                fontWeight: UIConstants.fontWeightNormal,
                                color: isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            InkWell(
                              onTap: () async {
                                final DateTime? picked = await _showDateTimePicker(
                                  context,
                                  initialDateTime: _tradeFromDate ?? DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime.now(),
                                  title: 'Select From Date & Time',
                                );
                                if (picked != null) {
                                  setState(() {
                                    _tradeFromDate = picked;
                                    // Reset tradeToDate if it's before the new tradeFromDate
                                    if (_tradeToDate != null && _tradeToDate!.isBefore(picked)) {
                                      _tradeToDate = null;
                                    }
                                  });
                                }
                              },
                              child: Container(
                                height: 38,
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: isDarkTheme ? const Color(0xFF3a3a3a) : Colors.white,
                                  borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                  border: Border.all(
                                    color: isDarkTheme ? Colors.grey[600]! : Colors.grey[300]!,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _formatDateTime(_tradeFromDate),
                                        style: TextStyle(
                                          color: isDarkTheme ? Colors.white : Colors.black,
                                          fontSize: UIConstants.textFieldFontSize,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.calendar_today,
                                      size: 16,
                                      color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: UIConstants.spacingMd),
                      // To Date filter
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'To Date',
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeSm,
                                fontWeight: UIConstants.fontWeightNormal,
                                color: isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            InkWell(
                              onTap: () async {
                                final DateTime? picked = await _showDateTimePicker(
                                  context,
                                  initialDateTime: _tradeToDate ?? DateTime.now(),
                                  firstDate: _tradeFromDate ?? DateTime(2020), // Cannot be before tradeFromDate
                                  lastDate: DateTime.now(),
                                  title: 'Select To Date & Time',
                                );
                                if (picked != null) {
                                  setState(() {
                                    _tradeToDate = picked;
                                  });
                                }
                              },
                              child: Container(
                                height: 38,
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: isDarkTheme ? const Color(0xFF3a3a3a) : Colors.white,
                                  borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                  border: Border.all(
                                    color: isDarkTheme ? Colors.grey[600]! : Colors.grey[300]!,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _formatDateTime(_tradeToDate),
                                        style: TextStyle(
                                          color: isDarkTheme ? Colors.white : Colors.black,
                                          fontSize: UIConstants.textFieldFontSize,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.calendar_today,
                                      size: 16,
                                      color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: UIConstants.spacingMd),
                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          _applyFilters(); // Apply filter changes and refresh trades
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Apply Filters'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(width: UIConstants.spacingMd),
                      ElevatedButton.icon(
                        onPressed: () {
                          _clearTradesFilters();
                        },
                        icon: const Icon(Icons.clear),
                        label: const Text('Clear'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          // Table content
          Expanded(
            child: Column(
              children: [
                // Trades table header row - always show
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          'Price',
                          style: TextStyle(
                            fontSize: UIConstants.textFieldFontSize,
                            color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          'Quantity',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: UIConstants.textFieldFontSize,
                            color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: UIConstants.spacingSm),
                Container(
                  height: 1,
                  color: isDarkTheme ? Colors.grey[700] : Colors.grey[300],
                ),
                const SizedBox(height: UIConstants.spacingSm),
                // Trades table rows
                Flexible(
                  child: _isLoadingTrades
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isDarkTheme ? Colors.white : Colors.black,
                            ),
                          ),
                        )
                      : _trades.isEmpty
                          ? Center(
                              child: Text(
                                'No trades found',
                                style: TextStyle(
                                  color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                  fontSize: UIConstants.textFieldFontSize,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: _trades.length,
                              itemBuilder: (context, index) {
                                final trade = _trades[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    children: [
                                      // Price
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 16),
                                          child: Text(
                                            '\$${trade['price']?.toString() ?? 'N/A'}',
                                            style: TextStyle(
                                              fontSize: UIConstants.textFieldFontSize,
                                              color: isDarkTheme ? Colors.white : Colors.black,
                                              fontWeight: UIConstants.fontWeightNormal,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      // Quantity
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 16),
                                          child: Text(
                                            trade['quantity']?.toString() ?? 'N/A',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: UIConstants.textFieldFontSize,
                                              color: isDarkTheme ? Colors.white : Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                ),
              ],
            ),
          ),
          // Show More button for trades
          if (_trades.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (_cachedAccountId != null && _cachedAccountId!.isNotEmpty) {
                      setState(() {
                        _tradePageSize = (_tradePageSize ?? 15) + 15;
                      });
                      await _fetchTradesWithAccountId(_cachedAccountId!);
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Show More'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkTheme 
                        ? const Color(0xFF2d2d2d) 
                        : Colors.grey[100],
                    foregroundColor: isDarkTheme 
                        ? Colors.white 
                        : Colors.black,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Get color for order status
  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'filled':
      case 'executed':
        return Colors.green;
      case 'pending':
      case 'open':
        return Colors.orange;
      case 'cancelled':
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }


  /// Build connected tab interface with headers attached to content
  Widget _buildConnectedTabInterface(bool isDarkTheme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start, // Align column content to the left
      children: [
        // Connected tab headers
        _buildConnectedTabHeaders(isDarkTheme),
        // Connected content area
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: isDarkTheme ? const Color(0xFF2d2d2d) : Colors.white,
              border: Border.all(
                color: isDarkTheme ? const Color(0xFF2d2d2d) : Colors.white, // Same as selected tab background
              ),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: RefreshIndicator(
              onRefresh: _fetchActivityData,
              child: _buildTabContent(isDarkTheme),
            ),
          ),
        ),
      ],
    );
  }

  /// Build connected tab headers that integrate with content
  Widget _buildConnectedTabHeaders(bool isDarkTheme) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start, // Align tabs to the left
        children: _tabNames.asMap().entries.map((entry) {
        final index = entry.key;
        final tabName = entry.value;
        final isActive = _selectedTabIndex == index;

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedTabIndex = index;
              });
              // Fetch data for the newly selected tab
              _fetchDataForActiveTab();
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: isActive ? 13.74 : 12,
              ),
              decoration: BoxDecoration(
                color: isActive
                    ? (isDarkTheme ? const Color(0xFF2d2d2d) : Colors.white)
                    : (isDarkTheme
                        ? Colors.black.withOpacity(0.3)
                        : Colors.grey.withOpacity(0.2)),
                border: isActive
                    ? null // No border for selected tab
                    : Border.all(
                        color: isDarkTheme ? const Color(0xFF2d2d2d) : Colors.white, // Same as selected background
                      ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Text(
                tabName,
                style: TextStyle(
                  color: isActive
                      ? (isDarkTheme ? Colors.white : Colors.black)
                      : Colors.grey[400],
                  fontSize: UIConstants.textFieldFontSize,
                  fontWeight: isActive ? UIConstants.fontWeightMedium : UIConstants.fontWeightNormal,
                ),
              ),
            ),
          ),
        );
      }).toList(),
      ),
    );
  }

  /// Build tab content based on selected tab
  Widget _buildTabContent(bool isDarkTheme) {
    switch (_selectedTabIndex) {
      case 0: // Orders
        return _buildOrdersTable(isDarkTheme);
      case 1: // Trades
        return _buildTradesTable(isDarkTheme);
      case 2: // Settlements
        return _buildSettlementsTable(isDarkTheme);
      case 3: // Transactions
        return _buildTransactionsTable(isDarkTheme);
      default:
        return _buildOrdersTable(isDarkTheme);
    }
  }

  /// Build settlements table
  Widget _buildSettlementsTable(bool isDarkTheme) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkTheme ? const Color(0xFF1e1e1e) : Colors.white,
        borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Table header
          Container(
            padding: UIConstants.paddingStandard,
            decoration: BoxDecoration(
              color: isDarkTheme ? const Color(0xFF2d2d2d) : Colors.grey[50],
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Filters',
                  style: TextStyle(
                    fontSize: UIConstants.fontSizeMd,
                    fontWeight: UIConstants.fontWeightMedium,
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(width: UIConstants.spacingMd),
                // Filter toggle button
                IconButton(
                  onPressed: () {
                    setState(() {
                      _showSettlementFilters = !_showSettlementFilters;
                    });
                  },
                  icon: Icon(
                    _showSettlementFilters ? Icons.filter_alt : Icons.filter_alt_outlined,
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
                  tooltip: 'Toggle Filters',
                ),
                const Spacer(),
                if (_isLoadingSettlements)
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isDarkTheme ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Filters section
          if (_showSettlementFilters)
            Container(
              padding: UIConstants.paddingStandard,
              decoration: BoxDecoration(
                color: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.grey[100],
                border: Border(
                  bottom: BorderSide(
                    color: isDarkTheme ? Colors.grey[700]! : Colors.grey[300]!,
                  ),
                ),
              ),
              child: Column(
                children: [
                  // First row: Status, Market, Asset
                  Row(
                    children: [
                      // Market filter
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Market',
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeSm,
                                fontWeight: UIConstants.fontWeightNormal,
                                color: isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: isDarkTheme ? const Color(0xFF3a3a3a) : Colors.white,
                                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                border: Border.all(
                                  color: isDarkTheme ? Colors.grey[600]! : Colors.grey[300]!,
                                ),
                              ),
                              child: DropdownButton<String>(
                                value: _tempSelectedSettlementsMarket ?? _selectedSettlementsMarket,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.white,
                                iconEnabledColor: isDarkTheme ? Colors.grey[300] : Colors.grey[600],
                                iconDisabledColor: isDarkTheme ? Colors.grey[600] : Colors.grey[400],
                                items: [
                                  DropdownMenuItem(value: null, child: Text('All Markets', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))),
                                  ..._availableMarkets.map((market) {
                                    // Extract identifier - try iid first
                                    String marketId = market['iid']?.toString() ?? '';
                                    if (marketId.isEmpty) {
                                      final identifiers = market['identifiers'] as List?;
                                      if (identifiers != null && identifiers.isNotEmpty) {
                                        final firstIdentifier = identifiers.first;
                                        if (firstIdentifier is Map) {
                                          final idsArray = firstIdentifier['ids'] as List?;
                                          if (idsArray != null && idsArray.isNotEmpty) {
                                            final firstId = idsArray.first;
                                            if (firstId is Map) {
                                              marketId = firstId['value']?.toString() ?? '';
                                            }
                                          }
                                        }
                                      }
                                    }
                                    if (marketId.isEmpty) {
                                      marketId = market['id']?.toString() ?? '';
                                    }
                                    
                                    // Extract name from displayNames
                                    String marketName = 'Unknown';
                                    final displayNames = market['displayNames'] as Map?;
                                    if (displayNames != null && displayNames.isNotEmpty) {
                                      marketName = displayNames['en']?.toString() ?? 
                                                   displayNames.values.first?.toString() ?? 'Unknown';
                                    }
                                    if (marketName == 'Unknown') {
                                      marketName = market['name']?.toString() ?? 'Unknown Market';
                                    }
                                    
                                    return DropdownMenuItem(
                                      value: marketId,
                                      child: Text(
                                        marketName,
                                        style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _tempSelectedSettlementsMarket = value;
                                    _tempSelectedSettlementsAsset = null;
                                  });
                                  if (value != null) {
                                    _fetchAssetList(value);
                                  } else {
                                    setState(() {
                                      _availableAssets = [];
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: UIConstants.spacingSm),
                      // Asset filter
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Asset',
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeSm,
                                fontWeight: UIConstants.fontWeightNormal,
                                color: isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: isDarkTheme ? const Color(0xFF3a3a3a) : Colors.white,
                                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                border: Border.all(
                                  color: isDarkTheme ? Colors.grey[600]! : Colors.grey[300]!,
                                ),
                              ),
                              child: DropdownButton<String>(
                                value: _tempSelectedSettlementsAsset ?? _selectedSettlementsAsset,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.white,
                                iconEnabledColor: isDarkTheme ? Colors.grey[300] : Colors.grey[600],
                                iconDisabledColor: isDarkTheme ? Colors.grey[600] : Colors.grey[400],
                                items: (_tempSelectedSettlementsMarket ?? _selectedSettlementsMarket) == null ? [
                                  DropdownMenuItem(value: null, child: Text('Select Market First', style: TextStyle(color: isDarkTheme ? Colors.grey : Colors.grey)))
                                ] : [
                                  DropdownMenuItem(value: null, child: Text('All Assets', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))),
                                  ..._availableAssets.map((asset) => DropdownMenuItem(
                                    value: asset['id']?.toString() ?? asset['symbol']?.toString() ?? '',
                                    child: Text(
                                      asset['symbol']?.toString() ?? asset['id']?.toString() ?? 'Unknown Asset',
                                      style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
                                    ),
                                  )),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _tempSelectedSettlementsAsset = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: UIConstants.spacingSm),
                      // Status filter
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Status',
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeSm,
                                fontWeight: UIConstants.fontWeightNormal,
                                color: isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: isDarkTheme ? const Color(0xFF3a3a3a) : Colors.white,
                                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                border: Border.all(
                                  color: isDarkTheme ? Colors.grey[600]! : Colors.grey[300]!,
                                ),
                              ),
                              child: DropdownButton<String>(
                                value: _selectedSettlementStatus,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.white,
                                iconEnabledColor: isDarkTheme ? Colors.grey[300] : Colors.grey[600],
                                iconDisabledColor: isDarkTheme ? Colors.grey[600] : Colors.grey[400],
                                items: [
                                  DropdownMenuItem(value: null, child: Text('All Status', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))),
                                  DropdownMenuItem(value: 'CONFIRMATION_STATUS__CONFIRMED', child: Text('Confirmed', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))),
                                  DropdownMenuItem(value: 'CONFIRMATION_STATUS__PENDING', child: Text('Pending', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))),
                                  DropdownMenuItem(value: 'CONFIRMATION_STATUS__DECLINED', child: Text('Declined', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedSettlementStatus = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: UIConstants.spacingSm),
                  // Second row: Date filters and Page size
                  Row(
                    children: [
                      // From Date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'From Date',
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeSm,
                                fontWeight: UIConstants.fontWeightNormal,
                                color: isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            InkWell(
                              onTap: () async {
                                final date = await _showDateTimePicker(context, initialDateTime: _settlementFromDate);
                                if (date != null) {
                                  setState(() {
                                    _settlementFromDate = date;
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                decoration: BoxDecoration(
                                  color: isDarkTheme ? const Color(0xFF3a3a3a) : Colors.white,
                                  borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                  border: Border.all(
                                    color: isDarkTheme ? Colors.grey[600]! : Colors.grey[300]!,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 16,
                                      color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                    ),
                                    const SizedBox(width: UIConstants.spacingSm),
                                    Text(
                                      _settlementFromDate != null ?
                                      '${_settlementFromDate!.day}/${_settlementFromDate!.month}/${_settlementFromDate!.year} ${_settlementFromDate!.hour.toString().padLeft(2, '0')}:${_settlementFromDate!.minute.toString().padLeft(2, '0')}' :
                                      'Select Date and Time',
                                      style: TextStyle(
                                        fontSize: UIConstants.fontSizeSm,
                                        color: isDarkTheme ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: UIConstants.spacingSm),
                      // To Date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'To Date',
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeSm,
                                fontWeight: UIConstants.fontWeightNormal,
                                color: isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            InkWell(
                              onTap: () async {
                                final date = await _showDateTimePicker(context, initialDateTime: _settlementToDate);
                                if (date != null) {
                                  setState(() {
                                    _settlementToDate = date;
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                decoration: BoxDecoration(
                                  color: isDarkTheme ? const Color(0xFF3a3a3a) : Colors.white,
                                  borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                  border: Border.all(
                                    color: isDarkTheme ? Colors.grey[600]! : Colors.grey[300]!,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 16,
                                      color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                    ),
                                    const SizedBox(width: UIConstants.spacingSm),
                                    Text(
                                      _settlementToDate != null ?
                                      '${_settlementToDate!.day}/${_settlementToDate!.month}/${_settlementToDate!.year} ${_settlementToDate!.hour.toString().padLeft(2, '0')}:${_settlementToDate!.minute.toString().padLeft(2, '0')}' :
                                      'Select Date and Time',
                                      style: TextStyle(
                                        fontSize: UIConstants.fontSizeSm,
                                        color: isDarkTheme ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: UIConstants.spacingMd),
                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _selectedSettlementsMarket = _tempSelectedSettlementsMarket;
                            _selectedSettlementsAsset = _tempSelectedSettlementsAsset;
                          });
                          _fetchActivityData();
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Apply Filters'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(width: UIConstants.spacingMd),
                      ElevatedButton.icon(
                        onPressed: () {
                          _clearSettlementsFilters();
                        },
                        icon: const Icon(Icons.clear),
                        label: const Text('Clear'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          // Settlements table content
          Expanded(
            child: Column(
              children: [
                // Table header row - always show
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          'Settlement ID',
                          style: TextStyle(
                            fontSize: UIConstants.textFieldFontSize,
                            color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Status',
                        style: TextStyle(
                          fontSize: UIConstants.textFieldFontSize,
                          color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Asset',
                        style: TextStyle(
                          fontSize: UIConstants.textFieldFontSize,
                          color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Amount',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: UIConstants.textFieldFontSize,
                          color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          'Timestamp',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: UIConstants.textFieldFontSize,
                            color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: UIConstants.spacingSm),
                Container(
                  height: 1,
                  color: isDarkTheme ? Colors.grey[700] : Colors.grey[300],
                ),
                const SizedBox(height: UIConstants.spacingSm),
                // Table rows
                Flexible(
                  child: _isLoadingSettlements
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isDarkTheme ? Colors.white : Colors.black,
                            ),
                          ),
                        )
                      : _settlements.isEmpty
                          ? Center(
                              child: Text(
                                'No settlements found',
                                style: TextStyle(
                                  color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                  fontSize: UIConstants.textFieldFontSize,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: _settlements.length,
                              itemBuilder: (context, index) {
                                final settlement = _settlements[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    children: [
                                      // Settlement ID
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 16),
                                          child: Text(
                                            settlement['settlement_id']?.toString() ?? 'N/A',
                                            style: TextStyle(
                                              fontSize: UIConstants.textFieldFontSize,
                                              color: isDarkTheme ? Colors.white : Colors.black,
                                              fontWeight: UIConstants.fontWeightNormal,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      // Status
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          settlement['confirmation_status']?.toString().replaceAll('CONFIRMATION_STATUS__', '') ?? 'N/A',
                                          style: TextStyle(
                                            fontSize: UIConstants.textFieldFontSize,
                                            color: settlement['confirmation_status'] == 'CONFIRMATION_STATUS__CONFIRMED'
                                                ? Colors.green[600]
                                                : settlement['confirmation_status'] == 'CONFIRMATION_STATUS__PENDING'
                                                ? Colors.orange[600]
                                                : Colors.red[600],
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      // Asset
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          settlement['asset_transferred']?.toString() ?? 'N/A',
                                          style: TextStyle(
                                            fontSize: UIConstants.textFieldFontSize,
                                            color: isDarkTheme ? Colors.white : Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      // Amount
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          settlement['amount_transferred']?.toString() ?? 'N/A',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: UIConstants.textFieldFontSize,
                                            color: isDarkTheme ? Colors.white : Colors.black,
                                            fontWeight: UIConstants.fontWeightNormal,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      // Timestamp
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 16),
                                          child: Text(
                                            settlement['timestamp'] != null
                                                ? DateTime.tryParse(settlement['timestamp'])?.toString().split('.')[0] ?? 'N/A'
                                                : 'N/A',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: UIConstants.textFieldFontSize,
                                              color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                                },
                              ),
                  ),
                ],
              ),
            ),
          // Show More button for settlements
          if (_settlements.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (_cachedAccountId != null && _cachedAccountId!.isNotEmpty) {
                      setState(() {
                        _settlementPageSize = (_settlementPageSize ?? 15) + 15;
                      });
                      await _fetchSettlementsWithAccountId(_cachedAccountId!);
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Show More'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkTheme
                        ? const Color(0xFF2d2d2d)
                        : Colors.grey[100],
                    foregroundColor: isDarkTheme
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Build transactions table
  Widget _buildTransactionsTable(bool isDarkTheme) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkTheme ? const Color(0xFF1e1e1e) : Colors.white,
        borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Table header
          Container(
            padding: UIConstants.paddingStandard,
            decoration: BoxDecoration(
              color: isDarkTheme ? const Color(0xFF2d2d2d) : Colors.grey[50],
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Filters',
                  style: TextStyle(
                    fontSize: UIConstants.fontSizeMd,
                    fontWeight: UIConstants.fontWeightMedium,
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(width: UIConstants.spacingMd),
                // Filter toggle button
                IconButton(
                  onPressed: () {
                    setState(() {
                      _showTransactionFilters = !_showTransactionFilters;
                    });
                  },
                  icon: Icon(
                    _showTransactionFilters ? Icons.filter_alt : Icons.filter_alt_outlined,
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
                  tooltip: 'Toggle Filters',
                ),
                const Spacer(),
                if (_isLoadingTransactions)
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isDarkTheme ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Filters section
          if (_showTransactionFilters)
            Container(
              padding: UIConstants.paddingStandard,
              decoration: BoxDecoration(
                color: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.grey[100],
                border: Border(
                  bottom: BorderSide(
                    color: isDarkTheme ? Colors.grey[700]! : Colors.grey[300]!,
                  ),
                ),
              ),
              child: Column(
                children: [
                  // First row: Transaction Types and Asset
                  Row(
                    children: [
                      // Transaction Types filter (multiple selection)
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Transaction Types',
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeSm,
                                fontWeight: UIConstants.fontWeightNormal,
                                color: isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 38,
                              padding: UIConstants.paddingStandard,
                              decoration: BoxDecoration(
                                color: isDarkTheme ? const Color(0xFF3a3a3a) : Colors.white,
                                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                border: Border.all(
                                  color: isDarkTheme ? Colors.grey[600]! : Colors.grey[300]!,
                                ),
                              ),
                              child: Wrap(
                                spacing: 8,
                                children: [
                                  'TRADE_BUY',
                                  'TRADE_SELL',
                                  'DEPOSIT_CASH',
                                  'SETTLEMENT',
                                  'FEE',
                                  'TRANSFER_IN',
                                ].map((type) => FilterChip(
                                  label: Text(
                                    type.replaceAll('TRANSACTION_TYPE__', '').replaceAll('_', ' '),
                                    style: TextStyle(
                                      fontSize: UIConstants.fontSizeXs,
                                      color: isDarkTheme ? Colors.white : Colors.black,
                                    ),
                                  ),
                                  selected: _selectedTransactionTypes.contains('TRANSACTION_TYPE__$type'),
                                  onSelected: (selected) {
                                    setState(() {
                                      if (selected) {
                                        _selectedTransactionTypes.add('TRANSACTION_TYPE__$type');
                                      } else {
                                        _selectedTransactionTypes.remove('TRANSACTION_TYPE__$type');
                                      }
                                    });
                                  },
                                  backgroundColor: isDarkTheme ? const Color(0xFF4a4a4a) : Colors.grey[200],
                                  selectedColor: isDarkTheme ? Colors.blue[700] : Colors.blue[200],
                                )).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: UIConstants.spacingSm),
                      // Asset filter
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Asset',
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeSm,
                                fontWeight: UIConstants.fontWeightNormal,
                                color: isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: isDarkTheme ? const Color(0xFF3a3a3a) : Colors.white,
                                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                border: Border.all(
                                  color: isDarkTheme ? Colors.grey[600]! : Colors.grey[300]!,
                                ),
                              ),
                              child: DropdownButton<String>(
                                value: _tempSelectedTransactionsAsset ?? _selectedTransactionsAsset,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.white,
                                iconEnabledColor: isDarkTheme ? Colors.grey[300] : Colors.grey[600],
                                iconDisabledColor: isDarkTheme ? Colors.grey[600] : Colors.grey[400],
                                items: [
                                  DropdownMenuItem(value: null, child: Text('All Assets', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))),
                                  DropdownMenuItem(value: 'USDC', child: Text('USDC', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))),
                                  DropdownMenuItem(value: 'ETH', child: Text('ETH', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))),
                                  DropdownMenuItem(value: 'BTC', child: Text('BTC', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))),
                                  DropdownMenuItem(value: 'XRP', child: Text('XRP', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _tempSelectedTransactionsAsset = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: UIConstants.spacingSm),
                  // Second row: Date filters and Page size
                  Row(
                    children: [
                      // From Date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'From Date',
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeSm,
                                fontWeight: UIConstants.fontWeightNormal,
                                color: isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            InkWell(
                              onTap: () async {
                                final date = await _showDateTimePicker(context, initialDateTime: _transactionFromDate);
                                if (date != null) {
                                  setState(() {
                                    _transactionFromDate = date;
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                decoration: BoxDecoration(
                                  color: isDarkTheme ? const Color(0xFF3a3a3a) : Colors.white,
                                  borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                  border: Border.all(
                                    color: isDarkTheme ? Colors.grey[600]! : Colors.grey[300]!,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 16,
                                      color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                    ),
                                    const SizedBox(width: UIConstants.spacingSm),
                                    Text(
                                      _transactionFromDate != null ?
                                      '${_transactionFromDate!.day}/${_transactionFromDate!.month}/${_transactionFromDate!.year} ${_transactionFromDate!.hour.toString().padLeft(2, '0')}:${_transactionFromDate!.minute.toString().padLeft(2, '0')}' :
                                      'Select Date and Time',
                                      style: TextStyle(
                                        fontSize: UIConstants.fontSizeSm,
                                        color: isDarkTheme ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: UIConstants.spacingSm),
                      // To Date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'To Date',
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeSm,
                                fontWeight: UIConstants.fontWeightNormal,
                                color: isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            InkWell(
                              onTap: () async {
                                final date = await _showDateTimePicker(context, initialDateTime: _transactionToDate);
                                if (date != null) {
                                  setState(() {
                                    _transactionToDate = date;
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                decoration: BoxDecoration(
                                  color: isDarkTheme ? const Color(0xFF3a3a3a) : Colors.white,
                                  borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                  border: Border.all(
                                    color: isDarkTheme ? Colors.grey[600]! : Colors.grey[300]!,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 16,
                                      color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                    ),
                                    const SizedBox(width: UIConstants.spacingSm),
                                    Text(
                                      _transactionToDate != null ?
                                      '${_transactionToDate!.day}/${_transactionToDate!.month}/${_transactionToDate!.year} ${_transactionToDate!.hour.toString().padLeft(2, '0')}:${_transactionToDate!.minute.toString().padLeft(2, '0')}' :
                                      'Select Date and Time',
                                      style: TextStyle(
                                        fontSize: UIConstants.fontSizeSm,
                                        color: isDarkTheme ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: UIConstants.spacingMd),
                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _selectedTransactionsAsset = _tempSelectedTransactionsAsset;
                          });
                          _fetchActivityData();
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Apply Filters'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(width: UIConstants.spacingMd),
                      ElevatedButton.icon(
                        onPressed: () {
                          _clearTransactionsFilters();
                        },
                        icon: const Icon(Icons.clear),
                        label: const Text('Clear'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          // Transactions table content
          Expanded(
            child: Column(
              children: [
                // Table header row - always show
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          'Transaction ID',
                          style: TextStyle(
                            fontSize: UIConstants.textFieldFontSize,
                            color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Type',
                        style: TextStyle(
                          fontSize: UIConstants.textFieldFontSize,
                          color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Asset',
                        style: TextStyle(
                          fontSize: UIConstants.textFieldFontSize,
                          color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Amount',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: UIConstants.textFieldFontSize,
                          color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          'Timestamp',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: UIConstants.textFieldFontSize,
                            color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: UIConstants.spacingSm),
                Container(
                  height: 1,
                  color: isDarkTheme ? Colors.grey[700] : Colors.grey[300],
                ),
                const SizedBox(height: UIConstants.spacingSm),
                // Table rows
                Flexible(
                  child: _isLoadingTransactions
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isDarkTheme ? Colors.white : Colors.black,
                            ),
                          ),
                        )
                      : _transactions.isEmpty
                          ? Center(
                              child: Text(
                                'No transactions found',
                                style: TextStyle(
                                  color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                  fontSize: UIConstants.textFieldFontSize,
                                ),
                              ),
                            )
                            : ListView.builder(
                                itemCount: _transactions.length,
                                itemBuilder: (context, index) {
                                  final transaction = _transactions[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      children: [
                                        // Transaction ID
                                        Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 16),
                                            child: Text(
                                              transaction['transaction_id']?.toString() ?? 'N/A',
                                              style: TextStyle(
                                                fontSize: UIConstants.textFieldFontSize,
                                                color: isDarkTheme ? Colors.white : Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        // Type
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            transaction['type']?.toString().replaceAll('TRANSACTION_TYPE__', '').replaceAll('_', ' ') ?? 'N/A',
                                            style: TextStyle(
                                              fontSize: UIConstants.textFieldFontSize,
                                              color: _getTransactionTypeColor(transaction['type']?.toString() ?? ''),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        // Asset
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            transaction['asset_id']?.toString() ?? 'N/A',
                                            style: TextStyle(
                                              fontSize: UIConstants.textFieldFontSize,
                                              color: isDarkTheme ? Colors.white : Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        // Amount
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            _formatTransactionAmount(transaction['amount']?.toString() ?? '0', transaction['asset_id']?.toString() ?? ''),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: UIConstants.textFieldFontSize,
                                              color: isDarkTheme ? Colors.white : Colors.black,
                                              fontWeight: UIConstants.fontWeightNormal,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        // Timestamp
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 16),
                                            child: Text(
                                              _formatTransactionTimestamp(transaction['timestamp']),
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontSize: UIConstants.textFieldFontSize,
                                                color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                )
                ],
              ),
            ),
        ],
      ),
    );
  }

  Color _getTransactionTypeColor(String type) {
    switch (type) {
      case 'TRANSACTION_TYPE__TRADE_BUY':
        return Colors.green[600]!;
      case 'TRANSACTION_TYPE__TRADE_SELL':
        return Colors.red[600]!;
      case 'TRANSACTION_TYPE__DEPOSIT_CASH':
        return Colors.blue[600]!;
      case 'TRANSACTION_TYPE__SETTLEMENT':
        return Colors.orange[600]!;
      case 'TRANSACTION_TYPE__FEE':
        return Colors.purple[600]!;
      case 'TRANSACTION_TYPE__TRANSFER_IN':
        return Colors.teal[600]!;
      default:
        return Colors.grey[600]!;
    }
  }

  String _formatTransactionAmount(String amount, String assetId) {
    try {
      final double value = double.parse(amount);
      if (assetId == 'USDC' || assetId == 'USD') {
        // USDC typically has 6 decimals
        return '${(value / 1000000).toStringAsFixed(2)} $assetId';
      } else if (assetId == 'ETH') {
        // ETH has 18 decimals
        return '${(value / 1000000000000000000).toStringAsFixed(4)} $assetId';
      } else if (assetId == 'BTC') {
        // BTC has 8 decimals
        return '${(value / 100000000).toStringAsFixed(8)} $assetId';
      } else {
        // Default formatting
        return '$value $assetId';
      }
    } catch (e) {
      return '$amount $assetId';
    }
  }

  String _formatTransactionTimestamp(dynamic timestamp) {
    try {
      String? timeString;
      if (timestamp is Map<String, dynamic> && timestamp.containsKey('ts')) {
        timeString = timestamp['ts'];
      } else if (timestamp is String) {
        timeString = timestamp;
      }

      if (timeString != null) {
        final dateTime = DateTime.tryParse(timeString);
        if (dateTime != null) {
          return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
        }
      }
      return 'N/A';
    } catch (e) {
      return 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final isDarkTheme = themeService.isDarkTheme;

    return BasePage(
      menuItems: MenuItemsHelper.buildMenuItems(context, 'activity'),
      content: Padding(
        padding: UIConstants.paddingStandard,
        child: _buildConnectedTabInterface(isDarkTheme),
      ),
    );
  }

}