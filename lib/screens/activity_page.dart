import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  // Transactions data variables
  List<Map<String, dynamic>> _transactions = [];
  bool _isLoadingTransactions = false;
  String _transactionsError = '';

  // Account management
  String? _cachedAccountId;

  // Filter state for orders
  String? _selectedSide; // BUY, SELL, or null for all
  List<String> _marketFilters = [];
  List<String> _securityFilters = [];
  DateTime? _fromDate;
  DateTime? _toDate;
  String _selectedOrderStatus = 'All';
  int? _pageSize = 15;
  int _pageNumber = 1;
  bool _showFilters = false;

  // Filter state for trades (similar to orders but without status filters)
  String? _selectedTradeSide;
  List<String> _tradeMarketFilters = [];
  List<String> _tradeSecurityFilters = [];
  DateTime? _tradeFromDate;
  DateTime? _tradeToDate;
  int? _tradePageSize = 15;
  int _tradePageNumber = 1;
  bool _showTradeFilters = false;

  // Filter state for transactions
  String? _selectedTransactionType; // Single selection from dropdown
  List<String> _transactionSecurityFilters = [];
  DateTime? _transactionFromDate;
  DateTime? _transactionToDate;
  int? _transactionPageSize = 15;
  int _transactionPageNumber = 1;
  bool _showTransactionFilters = false;

  // Market and Security dropdown data
  List<Map<String, dynamic>> _availableMarkets = [];
  List<Map<String, dynamic>> _availableSecurities = [];
  List<Map<String, dynamic>> _allSecurities = []; // All securitys from all markets for transactions
  String? _selectedOrdersMarket;
  String? _selectedOrdersSecurity;
  String? _selectedTradesMarket;
  String? _selectedTradesSecurity;
  String? _selectedTransactionsSecurity;
  bool _isLoadingMarkets = false;
  bool _isLoadingSecurities = false;

  // Temporary filter state (used before applying filters)
  String? _tempSelectedOrdersMarket;
  String? _tempSelectedOrdersSecurity;
  String? _tempSelectedTradesMarket;
  String? _tempSelectedTradesSecurity;
  String? _tempSelectedTransactionsSecurity;
  String? _tempSelectedTransactionType;
  
  // Text controllers for page number fields
  late TextEditingController _pageNumberController;
  late TextEditingController _tradePageNumberController;
  late TextEditingController _transactionPageNumberController;

  // Scroll controllers for transactions table horizontal scroll
  final ScrollController _transactionsHeaderScrollController = ScrollController();
  final ScrollController _transactionsRowsScrollController = ScrollController();

  // Tab management
  int _selectedTabIndex = 0;
  final List<String> _tabNames = ['Orders', 'Trades', 'Transactions'];
  
  @override
  void initState() {
    super.initState();
    print('🏁 ActivityPage initState() called - initializing activity data fetch');
    
    // Initialize text controllers
    _pageNumberController = TextEditingController(text: _pageNumber.toString());
    _tradePageNumberController = TextEditingController(text: _tradePageNumber.toString());
    _transactionPageNumberController = TextEditingController(text: _transactionPageNumber.toString());

    // Sync transactions scroll controllers
    _transactionsHeaderScrollController.addListener(() {
      if (_transactionsRowsScrollController.hasClients &&
          _transactionsRowsScrollController.offset != _transactionsHeaderScrollController.offset) {
        _transactionsRowsScrollController.jumpTo(_transactionsHeaderScrollController.offset);
      }
    });
    _transactionsRowsScrollController.addListener(() {
      if (_transactionsHeaderScrollController.hasClients &&
          _transactionsHeaderScrollController.offset != _transactionsRowsScrollController.offset) {
        _transactionsHeaderScrollController.jumpTo(_transactionsRowsScrollController.offset);
      }
    });

    // Check server connectivity when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ConnectivityChecker.checkAndShowErrorIfNeeded(context, 'Activity');
    });

    // Only fetch orders on page load (default tab is Orders)
    _fetchOrders();

    // Load dropdown data
    _fetchMarketList();
    // Security list will be fetched when market is selected

    // Fetch all securitys for transactions tab (no market filter) - after frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Wait a bit to ensure markets are loaded
      await Future.delayed(const Duration(milliseconds: 500));
      _fetchAllSecuritys();
    });
  }

  @override
  void dispose() {
    _pageNumberController.dispose();
    _tradePageNumberController.dispose();
    _transactionPageNumberController.dispose();
    _transactionsHeaderScrollController.dispose();
    _transactionsRowsScrollController.dispose();
    super.dispose();
  }

  /// Format timestamp from milliseconds string to readable date
  String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null) {
      return 'N/A';
    }

    try {
      // Handle nested timestamp object like {hmss: {hour: 13, minute: 24, second: 56}}
      if (timestamp is Map<String, dynamic>) {
        final hmss = timestamp['hmss'] as Map<String, dynamic>?;
        if (hmss != null) {
          final hour = hmss['hour']?.toString().padLeft(2, '0') ?? '00';
          final minute = hmss['minute']?.toString().padLeft(2, '0') ?? '00';
          final second = hmss['second']?.toString().padLeft(2, '0') ?? '00';
          // Return time only since date is not provided in this format
          return '$hour:$minute:$second';
        }

        // Handle full timestamp with ymdhmss
        final ymdhmss = timestamp['ymdhmss'] as Map<String, dynamic>?;
        if (ymdhmss != null) {
          final date = ymdhmss['date'] as Map<String, dynamic>?;
          final time = ymdhmss['time'] as Map<String, dynamic>?;

          if (date != null && time != null) {
            final year = date['year']?.toString() ?? '0000';
            final month = date['month']?.toString().padLeft(2, '0') ?? '00';
            final day = date['day']?.toString().padLeft(2, '0') ?? '00';
            final hour = time['hour']?.toString().padLeft(2, '0') ?? '00';
            final minute = time['minute']?.toString().padLeft(2, '0') ?? '00';
            final second = time['second']?.toString().padLeft(2, '0') ?? '00';
            return '$year-$month-$day $hour:$minute:$second';
          }
        }
      }

      // Handle string timestamp
      if (timestamp is String && timestamp.isNotEmpty) {
        // Try parsing as seconds timestamp
        final seconds = int.tryParse(timestamp);
        if (seconds != null) {
          final dateTime = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
          return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
        }

        // Try parsing as ISO date string
        final dateTime = DateTime.tryParse(timestamp);
        if (dateTime != null) {
          return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
        }
      }
    } catch (e) {
      return 'N/A';
    }

    return 'N/A';
  }

  /// Build abbreviated hash display with copy button
  Widget _buildHashWidget(String? hash, bool isDarkTheme) {
    if (hash == null || hash.isEmpty) {
      return Text(
        'N/A',
        style: TextStyle(
          fontSize: UIConstants.textFieldFontSize,
          color: UIConstants.textPrimary(isDarkTheme),
        ),
      );
    }

    // Abbreviate hash: first 4 + ... + last 4
    String abbreviatedHash;
    if (hash.length > 8) {
      abbreviatedHash = '${hash.substring(0, 4)}...${hash.substring(hash.length - 4)}';
    } else {
      abbreviatedHash = hash;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          abbreviatedHash,
          style: TextStyle(
            fontSize: UIConstants.textFieldFontSize,
            color: UIConstants.textPrimary(isDarkTheme),
            fontFamily: 'monospace',
          ),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(width: 4),
        InkWell(
          onTap: () {
            Clipboard.setData(ClipboardData(text: hash));
            ScaffoldMessenger.of(context).showSnackBar(
              UIConstants.successSnackBar('$hash copied successfully', duration: const Duration(seconds: 2)),
            );
          },
          child: const Icon(
            Icons.copy,
            size: 14,
            color: Colors.blue,
          ),
        ),
      ],
    );
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
      final accountListResponse = await realGrpcClient.getInvestorList();
      
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

  /// Fetch orders using GetInvestorOrders function (with account ID lookup)
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

  /// Fetch orders using GetInvestorOrders function (with provided account ID)
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
      
      // Build security filters array from selected dropdown value  
      final securityFilters = _selectedOrdersSecurity != null ? [_selectedOrdersSecurity!] : <String>[];

      final inputParams = {
        'ref_request_id': 'flutter-get-orders-${DateTime.now().millisecondsSinceEpoch}',
        'account_id': accountId,
        'market_id_or_name_regexes': marketFilters,
        'security_id_or_symbol_regexes': securityFilters,
        'from_time': fromTimeFormatted,
        'to_time': toTimeFormatted,
        'side': _selectedSide,
        'status_filters': statusFilters,
        'pagination': pagination,
      };

      print('🔍 GetInvestorOrders INPUT: ${jsonEncode(inputParams)}');

      final ordersResponse = await realGrpcClient.getInvestorOrders(
        accountId: accountId,
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

  /// Fetch trades using GetInvestorTrades function (with account ID lookup)
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

  /// Fetch trades using GetInvestorTrades function (with provided account ID)
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
      
      // Build security filters array from selected dropdown value
      final tradeSecurityFilters = _selectedTradesSecurity != null ? [_selectedTradesSecurity!] : <String>[];
      
      final tradeInputParams = {
        'ref_request_id': 'flutter-get-trades-${DateTime.now().millisecondsSinceEpoch}',
        'account_id': accountId,
        'market_id_or_name_regexes': tradeMarketFilters,
        'security_id_or_symbol_regexes': tradeSecurityFilters,
        'from_time': fromTimeFormatted,
        'to_time': toTimeFormatted,
        'side': _selectedTradeSide,
        'pagination': tradePagination,
      };

      print('🔍 GetInvestorTrades REQUEST PARAMETERS:');
      print('   Account ID: $accountId');
      print('   Market Filters: $tradeMarketFilters');
      print('   Security Filters: $tradeSecurityFilters');
      print('   From Date: $fromTimeFormatted');
      print('   To Date: $toTimeFormatted');
      print('   Side: $_selectedTradeSide');
      print('   Page Size: $_tradePageSize');
      print('🔍 GetInvestorTrades FULL INPUT: ${jsonEncode(tradeInputParams)}');

      print('📞 Making GetInvestorTrades API call...');
      
      // Call GetInvestorTrades with all parameters
      final tradesResponse = await realGrpcClient.getInvestorTrades(
        accountId: accountId,
        marketIids: _tradeMarketFilters.isNotEmpty ? _tradeMarketFilters : null,
        pagination: tradePagination,
        fromTime: fromTimeFormatted != null ? jsonEncode(fromTimeFormatted) : null,
        toTime: toTimeFormatted != null ? jsonEncode(toTimeFormatted) : null,
        side: _selectedTradeSide,
        securityListingIids: _tradeSecurityFilters.isNotEmpty ? _tradeSecurityFilters : null,
      );

      print('📤 GetInvestorTrades API RESPONSE:');
      print('   Response Type: ${tradesResponse.runtimeType}');
      print('   Full Response: ${jsonEncode(tradesResponse)}');

      print('🔄 Processing GetInvestorTrades response...');
      
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

  /// Fetch transactions using GetInvestorTransactions function (with provided account ID)
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

      final transactionSecurityFilters = _selectedTransactionsSecurity != null ? [_selectedTransactionsSecurity!] : <String>[];

      final transactionInputParams = {
        'ref_request_id': 'flutter-get-transactions-${DateTime.now().millisecondsSinceEpoch}',
        'account_id': accountId,
        'pagination': transactionPagination,
        'from_time': fromTimeFormatted,
        'to_time': toTimeFormatted,
        'transaction_types': _selectedTransactionType != null ? [_selectedTransactionType!] : null,
        'asset_id_or_name_regexes': transactionSecurityFilters.isNotEmpty ? transactionSecurityFilters : null,
      };

      transactionInputParams.removeWhere((key, value) => value == null);

      // Call GetInvestorTransactions API
      final transactionsResponse = await realGrpcClient.getInvestorTransactions(
        accountId: accountId,
        pagination: transactionPagination,
        fromTime: fromTimeFormatted != null ? json.encode(fromTimeFormatted) : null,
        toTime: toTimeFormatted != null ? json.encode(toTimeFormatted) : null,
        transactionTypes: _selectedTransactionType != null ? [_selectedTransactionType!] : null,
        assetIds: transactionSecurityFilters.isNotEmpty ? transactionSecurityFilters : null,
      );

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
      case 2: // Transactions tab
        _fetchTransactions();
        break;
    }
  }

  /// Apply filter changes and refresh data for active tab only
  void _applyFilters() {
    setState(() {
      // Apply temporary filter state to actual filter state
      _selectedOrdersMarket = _tempSelectedOrdersMarket;
      _selectedOrdersSecurity = _tempSelectedOrdersSecurity;
      _selectedTradesMarket = _tempSelectedTradesMarket;
      _selectedTradesSecurity = _tempSelectedTradesSecurity;
      
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
      _securityFilters = [];
      _fromDate = null;
      _toDate = null;
      _selectedOrderStatus = 'All';
      _pageSize = 15;
      _pageNumber = 1;
      _selectedOrdersMarket = null;
      _selectedOrdersSecurity = null;
      _tempSelectedOrdersMarket = null;
      _tempSelectedOrdersSecurity = null;
    });
    _pageNumberController.text = '1';
  }

  /// Clear all trades filters
  void _clearTradesFilters() {
    setState(() {
      _selectedTradeSide = null;
      _tradeMarketFilters = [];
      _tradeSecurityFilters = [];
      _tradeFromDate = null;
      _tradeToDate = null;
      _tradePageSize = 15;
      _tradePageNumber = 1;
      _selectedTradesMarket = null;
      _selectedTradesSecurity = null;
      _tempSelectedTradesMarket = null;
      _tempSelectedTradesSecurity = null;
    });
    _tradePageNumberController.text = '1';
  }

  /// Clear all transactions filters
  void _clearTransactionsFilters() {
    setState(() {
      _selectedTransactionType = null;
      _tempSelectedTransactionType = null;
      _selectedTransactionsSecurity = null;
      _tempSelectedTransactionsSecurity = null;
      _transactionFromDate = null;
      _transactionToDate = null;
      _transactionPageSize = 15;
      _transactionPageNumber = 1;
    });
    _transactionPageNumberController.text = '1';
  }

  /// Fetch security list for dropdown filters using GetOrderbook
  Future<void> _fetchSecurityList(String? marketId) async {
    if (_isLoadingSecurities) return;
    
    if (marketId == null || marketId.isEmpty) {
      setState(() {
        _availableSecurities = [];
      });
      return;
    }

    setState(() {
      _isLoadingSecurities = true;
    });
    
    try {
      print('📋 Fetching securities for market: $marketId...');
      
      final result = await realGrpcClient.getMarketSecurityList(
        marketId: marketId,
      );
      
      if (mounted) {
        setState(() {
          _isLoadingSecurities = false;
          if (result['success'] == true) {
            final output = result['output'];
            print('✅ GetMarketSecurityList response for market $marketId: $output');
            
            if (output is Map<String, dynamic>) {
              // Extract securitys from the response based on actual server structure
              final securitys = output['securities'] ?? output['securityList'] ?? output['security_list'] ?? [];
              if (securitys is List && securitys.isNotEmpty) {
                // Process securitys to extract the symbol values from nested structure
                final processedSecurities = <Map<String, dynamic>>[];
                for (final security in securitys) {
                  if (security is Map<String, dynamic>) {
                    // Extract from identifiers structure: identifiers -> ids -> value
                    String securityId = '';
                    String securityName = '';
                    
                    // Get the iid as security ID
                    securityId = security['iid']?.toString() ?? '';
                    
                    // Extract from identifiers -> ids -> value
                    final identifiers = security['identifiers'] as List?;
                    if (identifiers != null && identifiers.isNotEmpty) {
                      final firstIdentifier = identifiers.first;
                      if (firstIdentifier is Map) {
                        final idsArray = firstIdentifier['ids'] as List?;
                        if (idsArray != null && idsArray.isNotEmpty) {
                          final firstId = idsArray.first;
                          if (firstId is Map && firstId.containsKey('value')) {
                            final symbolValue = firstId['value'].toString();
                            if (securityId.isEmpty) {
                              securityId = symbolValue;
                            }
                            securityName = symbolValue;
                          }
                        }
                      }
                    }
                    
                    // Extract display name
                    final displayNames = security['displayNames'] as Map?;
                    if (displayNames != null && displayNames.isNotEmpty) {
                      securityName = displayNames['en']?.toString() ?? 
                                  displayNames.values.first?.toString() ?? securityName;
                    }
                    
                    if (securityId.isNotEmpty) {
                      processedSecurities.add({
                        'id': securityId,
                        'symbol': securityName.isNotEmpty ? securityName : securityId,
                        'security_id': securityId,
                        'description': securityName.isNotEmpty ? securityName : securityId,
                      });
                    }
                  }
                }
                
                _availableSecurities = processedSecurities;
                print('✅ Securities loaded for market $marketId: ${_availableSecurities.length} securities found');
                if (_availableSecurities.isNotEmpty) {
                  print('📋 Sample securities: ${_availableSecurities.take(3).map((a) => a['symbol']).toList()}');
                }
              } else {
                _availableSecurities = [];
                print('⚠️ No securities found in market $marketId response');
              }
            } else {
              _availableSecurities = [];
              print('⚠️ Unexpected response format for market $marketId');
            }
          } else {
            print('❌ GetMarketSecurityList failed for market $marketId: ${result['output']}');
            _availableSecurities = [];
          }
        });
      }
    } catch (e) {
      print('❌ Exception fetching securities: $e');
      if (mounted) {
        setState(() {
          _isLoadingSecurities = false;
          _availableSecurities = [];
        });
      }
    }
  }

  /// Fetch all securitys from all markets for transactions filter
  Future<void> _fetchAllSecuritys() async {
    if (_isLoadingSecurities) return;

    setState(() {
      _isLoadingSecurities = true;
    });

    try {
      print('📋 Fetching all securitys from all markets...');

      // Wait for markets to be loaded if not already
      if (_availableMarkets.isEmpty) {
        await _fetchMarketList();
      }

      final allSecuritiesFromMarkets = <Map<String, dynamic>>[];

      // Fetch securitys from each market
      for (final market in _availableMarkets) {
        final marketId = market['iid']?.toString();
        if (marketId != null && marketId.isNotEmpty) {
          try {
            print('📋 Fetching securities for market: $marketId');
            final result = await realGrpcClient.getMarketSecurityList(
              marketId: marketId,
            );

            print('📋 GetMarketSecurityList result for $marketId: success=${result['success']}, output type=${result['output'].runtimeType}');
            if (result['success'] == true) {
              final output = result['output'];
              if (output is Map<String, dynamic>) {
                final securitys = output['securities'] ?? output['securityList'] ?? output['security_list'] ?? [];
                print('📋 Securitys found in $marketId: ${securitys.length}');
                if (securitys is List && securitys.isNotEmpty) {
                  for (final security in securitys) {
                    if (security is Map<String, dynamic>) {
                      String securityId = '';
                      String securityName = '';

                      securityId = security['iid']?.toString() ?? '';

                      final identifiers = security['identifiers'] as List?;
                      if (identifiers != null && identifiers.isNotEmpty) {
                        final firstIdentifier = identifiers.first;
                        if (firstIdentifier is Map) {
                          final idsArray = firstIdentifier['ids'] as List?;
                          if (idsArray != null && idsArray.isNotEmpty) {
                            final firstId = idsArray.first;
                            if (firstId is Map && firstId.containsKey('value')) {
                              final symbolValue = firstId['value'].toString();
                              if (securityId.isEmpty) {
                                securityId = symbolValue;
                              }
                              securityName = symbolValue;
                            }
                          }
                        }
                      }

                      final displayNames = security['displayNames'] as Map?;
                      if (displayNames != null && displayNames.isNotEmpty) {
                        securityName = displayNames['en']?.toString() ??
                                    displayNames.values.first?.toString() ?? securityName;
                      }

                      if (securityId.isNotEmpty) {
                        allSecuritiesFromMarkets.add({
                          'id': securityId,
                          'symbol': securityName.isNotEmpty ? securityName : securityId,
                          'security_id': securityId,
                          'description': securityName.isNotEmpty ? securityName : securityId,
                        });
                      }
                    }
                  }
                }
              } else {
                print('⚠️ Output is not Map for market $marketId: ${output.runtimeType}');
              }
            } else {
              print('⚠️ GetMarketSecurityList failed for market $marketId: ${result['output']}');
            }
          } catch (e) {
            print('⚠️ Failed to fetch securities from market $marketId: $e');
          }
        } else {
          print('⚠️ Invalid market ID: $marketId');
        }
      }

      // Remove duplicates based on security ID
      final uniqueSecurities = <String, Map<String, dynamic>>{};
      for (final security in allSecuritiesFromMarkets) {
        final id = security['id']?.toString() ?? '';
        if (id.isNotEmpty && !uniqueSecurities.containsKey(id)) {
          uniqueSecurities[id] = security;
        }
      }

      if (mounted) {
        setState(() {
          _allSecurities = uniqueSecurities.values.toList();
          _isLoadingSecurities = false;
        });
        print('✅ All securitys loaded: ${_allSecurities.length} unique securitys found (from ${allSecuritiesFromMarkets.length} total)');
        if (_allSecurities.isNotEmpty) {
          print('📋 Sample securitys: ${_allSecurities.take(3).map((a) => a['symbol']).toList()}');
        }
      }
    } catch (e) {
      print('❌ Exception fetching all securitys: $e');
      if (mounted) {
        setState(() {
          _isLoadingSecurities = false;
          _allSecurities = [];
        });
      }
    }
  }

  /// Build orders table widget
  Widget _buildOrdersTable(bool isDarkTheme) {
    return Container(
      decoration: BoxDecoration(
        color: UIConstants.pageBackground(isDarkTheme),
        borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Table header
          Container(
            padding: UIConstants.paddingStandard,
            decoration: BoxDecoration(
              color: UIConstants.tableHeaderBackground(isDarkTheme),
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
                    color: UIConstants.textPrimary(isDarkTheme),
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
                    color: UIConstants.textPrimary(isDarkTheme),
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
                        UIConstants.textPrimary(isDarkTheme),
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
                color: UIConstants.filterBarBackground(isDarkTheme),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: UIConstants.spacingMd),
                  // Market, Security and Status filters row
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
                                color: UIConstants.textSecondary(isDarkTheme),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: UIConstants.filterBarBackground(isDarkTheme),
                                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                border: Border.all(
                                  color: UIConstants.visibleBorderColor(isDarkTheme),
                                ),
                              ),
                              child: DropdownButton<String?>(
                                value: _tempSelectedOrdersMarket ?? _selectedOrdersMarket,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
                                iconEnabledColor: UIConstants.textSecondary(isDarkTheme),
                                iconDisabledColor: UIConstants.textHint(isDarkTheme),
                                items: [
                                  DropdownMenuItem(value: null, child: Text('All Markets', style: TextStyle(color: UIConstants.textPrimary(isDarkTheme)))),
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
                                        style: TextStyle(color: UIConstants.textPrimary(isDarkTheme))
                                      )
                                    );
                                  }).toList(),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _tempSelectedOrdersMarket = value;
                                    // Reset security selection when market changes
                                    _tempSelectedOrdersSecurity = null;
                                  });
                                  // Fetch securities for the selected market
                                  if (value != null) {
                                    _fetchSecurityList(value);
                                  } else {
                                    _availableSecurities = [];
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: UIConstants.spacingMd),
                      // Security filter
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Security',
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeSm,
                                fontWeight: UIConstants.fontWeightNormal,
                                color: UIConstants.textSecondary(isDarkTheme),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: UIConstants.filterBarBackground(isDarkTheme),
                                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                border: Border.all(
                                  color: UIConstants.visibleBorderColor(isDarkTheme),
                                ),
                              ),
                              child: DropdownButton<String?>(
                                value: _tempSelectedOrdersSecurity ?? _selectedOrdersSecurity,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
                                iconEnabledColor: UIConstants.textSecondary(isDarkTheme),
                                iconDisabledColor: UIConstants.textHint(isDarkTheme),
                                items: (_tempSelectedOrdersMarket ?? _selectedOrdersMarket) == null ? [
                                  DropdownMenuItem(value: null, child: Text('Select Market First', style: TextStyle(color: UIConstants.textHint(isDarkTheme))))
                                ] : [
                                  DropdownMenuItem(value: null, child: Text('All Securities', style: TextStyle(color: UIConstants.textPrimary(isDarkTheme)))),
                                  ..._availableSecurities.map<DropdownMenuItem<String?>>((security) =>
                                    DropdownMenuItem<String?>(
                                      value: security['id'] ?? security['symbol'] ?? security['security_id'] ?? '',
                                      child: Text(
                                        security['symbol'] ?? security['id'] ?? security['security_id'] ?? 'Unknown',
                                        style: TextStyle(color: UIConstants.textPrimary(isDarkTheme))
                                      )
                                    )
                                  ).toList(),
                                ],
                                onChanged: (_tempSelectedOrdersMarket ?? _selectedOrdersMarket) == null ? null : (value) {
                                  setState(() {
                                    _tempSelectedOrdersSecurity = value;
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
                                color: UIConstants.textSecondary(isDarkTheme),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: UIConstants.filterBarBackground(isDarkTheme),
                                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                border: Border.all(
                                  color: UIConstants.visibleBorderColor(isDarkTheme),
                                ),
                              ),
                              child: DropdownButton<String?>(
                                value: _selectedSide,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
                                iconEnabledColor: UIConstants.textSecondary(isDarkTheme),
                                iconDisabledColor: UIConstants.textHint(isDarkTheme),
                                items: [
                                  DropdownMenuItem(value: null, child: Text('All', style: TextStyle(color: UIConstants.textPrimary(isDarkTheme)))),
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
                                color: UIConstants.textSecondary(isDarkTheme),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: UIConstants.filterBarBackground(isDarkTheme),
                                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                border: Border.all(
                                  color: UIConstants.visibleBorderColor(isDarkTheme),
                                ),
                              ),
                              child: DropdownButton<String>(
                                value: _selectedOrderStatus,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
                                iconEnabledColor: UIConstants.textSecondary(isDarkTheme),
                                iconDisabledColor: UIConstants.textHint(isDarkTheme),
                                style: TextStyle(color: UIConstants.textPrimary(isDarkTheme)),
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
                                color: UIConstants.textSecondary(isDarkTheme),
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
                                  color: UIConstants.filterBarBackground(isDarkTheme),
                                  borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                  border: Border.all(
                                    color: UIConstants.visibleBorderColor(isDarkTheme),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _formatDateTime(_fromDate),
                                        style: TextStyle(
                                          color: UIConstants.textPrimary(isDarkTheme),
                                          fontSize: UIConstants.textFieldFontSize,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.calendar_today,
                                      size: 16,
                                      color: UIConstants.textSecondary(isDarkTheme),
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
                                color: UIConstants.textSecondary(isDarkTheme),
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
                                  color: UIConstants.filterBarBackground(isDarkTheme),
                                  borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                  border: Border.all(
                                    color: UIConstants.visibleBorderColor(isDarkTheme),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _formatDateTime(_toDate),
                                        style: TextStyle(
                                          color: UIConstants.textPrimary(isDarkTheme),
                                          fontSize: UIConstants.textFieldFontSize,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.calendar_today,
                                      size: 16,
                                      color: UIConstants.textSecondary(isDarkTheme),
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
                        style: UIConstants.buttonStyle(UIConstants.colorCommand),
                      ),
                      const SizedBox(width: UIConstants.spacingMd),
                      ElevatedButton.icon(
                        onPressed: () {
                          _clearOrdersFilters();
                        },
                        icon: const Icon(Icons.clear),
                        label: const Text('Clear'),
                        style: UIConstants.buttonStyle(UIConstants.colorReject),
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
                            color: UIConstants.textSecondary(isDarkTheme),
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
                          color: UIConstants.textSecondary(isDarkTheme),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Symbol',
                        style: TextStyle(
                          fontSize: UIConstants.textFieldFontSize,
                          color: UIConstants.textSecondary(isDarkTheme),
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
                          color: UIConstants.textSecondary(isDarkTheme),
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
                            color: UIConstants.textSecondary(isDarkTheme),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: UIConstants.spacingSm),
                Container(
                  height: 1,
                  color: UIConstants.visibleBorderColor(isDarkTheme),
                ),
                const SizedBox(height: UIConstants.spacingSm),
                // Table rows
                Flexible(
                  child: _isLoadingOrders
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              UIConstants.textPrimary(isDarkTheme),
                            ),
                          ),
                        )
                      : _orders.isEmpty
                          ? Center(
                              child: Text(
                                'No orders found',
                                style: TextStyle(
                                  color: UIConstants.textSecondary(isDarkTheme),
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
                                              color: UIConstants.textPrimary(isDarkTheme),
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
                                            color: UIConstants.textPrimary(isDarkTheme),
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
                                            color: UIConstants.textPrimary(isDarkTheme),
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
                                            color: UIConstants.textPrimary(isDarkTheme),
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
                                              color: UIConstants.textPrimary(isDarkTheme),
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
                  style: UIConstants.buttonStyle(UIConstants.colorCommand),
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
        color: UIConstants.pageBackground(isDarkTheme),
        borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Table header
          Container(
            padding: UIConstants.paddingStandard,
            decoration: BoxDecoration(
              color: UIConstants.tableHeaderBackground(isDarkTheme),
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
                    color: UIConstants.textPrimary(isDarkTheme),
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
                    color: UIConstants.textPrimary(isDarkTheme),
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
                        UIConstants.textPrimary(isDarkTheme),
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
                color: UIConstants.filterBarBackground(isDarkTheme),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Market and Security and Side filters row for trades
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
                                color: UIConstants.textSecondary(isDarkTheme),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: UIConstants.filterBarBackground(isDarkTheme),
                                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                border: Border.all(
                                  color: UIConstants.visibleBorderColor(isDarkTheme),
                                ),
                              ),
                              child: DropdownButton<String?>(
                                value: _tempSelectedTradesMarket ?? _selectedTradesMarket,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
                                iconEnabledColor: UIConstants.textSecondary(isDarkTheme),
                                iconDisabledColor: UIConstants.textHint(isDarkTheme),
                                items: [
                                  DropdownMenuItem(value: null, child: Text('All Markets', style: TextStyle(color: UIConstants.textPrimary(isDarkTheme)))),
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
                                        style: TextStyle(color: UIConstants.textPrimary(isDarkTheme))
                                      )
                                    );
                                  }).toList(),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _tempSelectedTradesMarket = value;
                                    // Reset security selection when market changes
                                    _tempSelectedTradesSecurity = null;
                                  });
                                  // Fetch securities for the selected market
                                  if (value != null) {
                                    _fetchSecurityList(value);
                                  } else {
                                    _availableSecurities = [];
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: UIConstants.spacingMd),
                      // Security filter for trades
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Security',
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeSm,
                                fontWeight: UIConstants.fontWeightNormal,
                                color: UIConstants.textSecondary(isDarkTheme),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: UIConstants.filterBarBackground(isDarkTheme),
                                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                border: Border.all(
                                  color: UIConstants.visibleBorderColor(isDarkTheme),
                                ),
                              ),
                              child: DropdownButton<String?>(
                                value: _tempSelectedTradesSecurity ?? _selectedTradesSecurity,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
                                iconEnabledColor: UIConstants.textSecondary(isDarkTheme),
                                iconDisabledColor: UIConstants.textHint(isDarkTheme),
                                items: (_tempSelectedTradesMarket ?? _selectedTradesMarket) == null ? [
                                  DropdownMenuItem(value: null, child: Text('Select Market First', style: TextStyle(color: UIConstants.textHint(isDarkTheme))))
                                ] : [
                                  DropdownMenuItem(value: null, child: Text('All Securities', style: TextStyle(color: UIConstants.textPrimary(isDarkTheme)))),
                                  ..._availableSecurities.map<DropdownMenuItem<String?>>((security) =>
                                    DropdownMenuItem<String?>(
                                      value: security['id'] ?? security['symbol'] ?? security['security_id'] ?? '',
                                      child: Text(
                                        security['symbol'] ?? security['id'] ?? security['security_id'] ?? 'Unknown',
                                        style: TextStyle(color: UIConstants.textPrimary(isDarkTheme))
                                      )
                                    )
                                  ).toList(),
                                ],
                                onChanged: (_tempSelectedTradesMarket ?? _selectedTradesMarket) == null ? null : (value) {
                                  setState(() {
                                    _tempSelectedTradesSecurity = value;
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
                                color: UIConstants.textSecondary(isDarkTheme),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: UIConstants.filterBarBackground(isDarkTheme),
                                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                border: Border.all(
                                  color: UIConstants.visibleBorderColor(isDarkTheme),
                                ),
                              ),
                              child: DropdownButton<String?>(
                                value: _selectedTradeSide,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
                                iconEnabledColor: UIConstants.textSecondary(isDarkTheme),
                                iconDisabledColor: UIConstants.textHint(isDarkTheme),
                                items: [
                                  DropdownMenuItem(value: null, child: Text('All', style: TextStyle(color: UIConstants.textPrimary(isDarkTheme)))),
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
                                color: UIConstants.textSecondary(isDarkTheme),
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
                                  color: UIConstants.filterBarBackground(isDarkTheme),
                                  borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                  border: Border.all(
                                    color: UIConstants.visibleBorderColor(isDarkTheme),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _formatDateTime(_tradeFromDate),
                                        style: TextStyle(
                                          color: UIConstants.textPrimary(isDarkTheme),
                                          fontSize: UIConstants.textFieldFontSize,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.calendar_today,
                                      size: 16,
                                      color: UIConstants.textSecondary(isDarkTheme),
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
                                color: UIConstants.textSecondary(isDarkTheme),
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
                                  color: UIConstants.filterBarBackground(isDarkTheme),
                                  borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                  border: Border.all(
                                    color: UIConstants.visibleBorderColor(isDarkTheme),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _formatDateTime(_tradeToDate),
                                        style: TextStyle(
                                          color: UIConstants.textPrimary(isDarkTheme),
                                          fontSize: UIConstants.textFieldFontSize,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.calendar_today,
                                      size: 16,
                                      color: UIConstants.textSecondary(isDarkTheme),
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
                        style: UIConstants.buttonStyle(UIConstants.colorCommand),
                      ),
                      const SizedBox(width: UIConstants.spacingMd),
                      ElevatedButton.icon(
                        onPressed: () {
                          _clearTradesFilters();
                        },
                        icon: const Icon(Icons.clear),
                        label: const Text('Clear'),
                        style: UIConstants.buttonStyle(UIConstants.colorReject),
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
                            color: UIConstants.textSecondary(isDarkTheme),
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
                            color: UIConstants.textSecondary(isDarkTheme),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: UIConstants.spacingSm),
                Container(
                  height: 1,
                  color: UIConstants.visibleBorderColor(isDarkTheme),
                ),
                const SizedBox(height: UIConstants.spacingSm),
                // Trades table rows
                Flexible(
                  child: _isLoadingTrades
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              UIConstants.textPrimary(isDarkTheme),
                            ),
                          ),
                        )
                      : _trades.isEmpty
                          ? Center(
                              child: Text(
                                'No trades found',
                                style: TextStyle(
                                  color: UIConstants.textSecondary(isDarkTheme),
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
                                              color: UIConstants.textPrimary(isDarkTheme),
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
                                              color: UIConstants.textPrimary(isDarkTheme),
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
                  style: UIConstants.buttonStyle(UIConstants.colorCommand),
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
              color: UIConstants.cardBackground(isDarkTheme),
              border: Border.all(
                color: UIConstants.cardBackground(isDarkTheme), // Same as selected tab background
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
                    ? (UIConstants.cardBackground(isDarkTheme))
                    : (isDarkTheme
                        ? Colors.black.withOpacity(0.3)
                        : Colors.grey.withOpacity(0.2)),
                border: isActive
                    ? null // No border for selected tab
                    : Border.all(
                        color: UIConstants.cardBackground(isDarkTheme), // Same as selected background
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
                      ? (UIConstants.textPrimary(isDarkTheme))
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
      case 2: // Transactions
        return _buildTransactionsTable(isDarkTheme);
      default:
        return _buildOrdersTable(isDarkTheme);
    }
  }

  /// Build transactions table
  Widget _buildTransactionsTable(bool isDarkTheme) {
    return Container(
      decoration: BoxDecoration(
        color: UIConstants.pageBackground(isDarkTheme),
        borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Table header
          Container(
            padding: UIConstants.paddingStandard,
            decoration: BoxDecoration(
              color: UIConstants.tableHeaderBackground(isDarkTheme),
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
                    color: UIConstants.textPrimary(isDarkTheme),
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
                    color: UIConstants.textPrimary(isDarkTheme),
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
                        UIConstants.textPrimary(isDarkTheme),
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
                color: UIConstants.filterBarBackground(isDarkTheme),
                border: Border(
                  bottom: BorderSide(
                    color: UIConstants.visibleBorderColor(isDarkTheme),
                  ),
                ),
              ),
              child: Column(
                children: [
                  // First row: Transaction Types and Security
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
                                color: UIConstants.textSecondary(isDarkTheme),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: UIConstants.filterBarBackground(isDarkTheme),
                                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                border: Border.all(
                                  color: UIConstants.visibleBorderColor(isDarkTheme),
                                ),
                              ),
                              child: DropdownButton<String>(
                                value: _tempSelectedTransactionsSecurity ?? _selectedTransactionsSecurity,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
                                iconEnabledColor: UIConstants.textSecondary(isDarkTheme),
                                iconDisabledColor: UIConstants.textHint(isDarkTheme),
                                items: [
                                  DropdownMenuItem(value: null, child: Text('All Markets', style: TextStyle(color: UIConstants.textPrimary(isDarkTheme)))),
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
                                        style: TextStyle(color: UIConstants.textPrimary(isDarkTheme)),
                                      ),
                                    );
                                  }).toList(),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _tempSelectedTransactionsSecurity = value;
                                    _tempSelectedTransactionsSecurity = null;
                                  });
                                  if (value != null) {
                                    _fetchSecurityList(value);
                                  } else {
                                    setState(() {
                                      _availableSecurities = [];
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: UIConstants.spacingSm),
                      // Security filter
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Security',
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeSm,
                                fontWeight: UIConstants.fontWeightNormal,
                                color: UIConstants.textSecondary(isDarkTheme),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: UIConstants.filterBarBackground(isDarkTheme),
                                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                border: Border.all(
                                  color: UIConstants.visibleBorderColor(isDarkTheme),
                                ),
                              ),
                              child: DropdownButton<String?>(
                                value: _tempSelectedTransactionsSecurity ?? _selectedTransactionsSecurity,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
                                iconEnabledColor: UIConstants.textSecondary(isDarkTheme),
                                iconDisabledColor: UIConstants.textHint(isDarkTheme),
                                items: [
                                  DropdownMenuItem<String?>(value: null, child: Text('All Securities', style: TextStyle(color: UIConstants.textPrimary(isDarkTheme)))),
                                  ..._allSecurities.map<DropdownMenuItem<String?>>((security) =>
                                    DropdownMenuItem<String?>(
                                      value: security['id'] ?? security['symbol'] ?? security['security_id'] ?? '',
                                      child: Text(
                                        security['symbol'] ?? security['id'] ?? security['security_id'] ?? 'Unknown',
                                        style: TextStyle(color: UIConstants.textPrimary(isDarkTheme))
                                      )
                                    )
                                  ).toList(),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _tempSelectedTransactionsSecurity = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: UIConstants.spacingSm),
                      // Transaction Type filter (dropdown)
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Transaction Type',
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeSm,
                                fontWeight: UIConstants.fontWeightNormal,
                                color: UIConstants.textSecondary(isDarkTheme),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: UIConstants.filterBarBackground(isDarkTheme),
                                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                border: Border.all(
                                  color: UIConstants.visibleBorderColor(isDarkTheme),
                                ),
                              ),
                              child: DropdownButton<String?>(
                                value: _tempSelectedTransactionType ?? _selectedTransactionType,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
                                iconEnabledColor: UIConstants.textSecondary(isDarkTheme),
                                iconDisabledColor: UIConstants.textHint(isDarkTheme),
                                items: [
                                  DropdownMenuItem<String?>(
                                    value: null,
                                    child: Text('All Types', style: TextStyle(color: UIConstants.textPrimary(isDarkTheme)))
                                  ),
                                  DropdownMenuItem<String?>(
                                    value: 'TRANSACTION_TYPE_ENUM_DEPOSIT_CASH',
                                    child: Text('Deposit Cash', style: TextStyle(color: UIConstants.textPrimary(isDarkTheme)))
                                  ),
                                  DropdownMenuItem<String?>(
                                    value: 'TRANSACTION_TYPE_ENUM_DEPOSIT_ASSET',
                                    child: Text('Deposit Asset', style: TextStyle(color: UIConstants.textPrimary(isDarkTheme)))
                                  ),
                                  DropdownMenuItem<String?>(
                                    value: 'TRANSACTION_TYPE_ENUM_WITHDRAW_CASH',
                                    child: Text('Withdraw Cash', style: TextStyle(color: UIConstants.textPrimary(isDarkTheme)))
                                  ),
                                  DropdownMenuItem<String?>(
                                    value: 'TRANSACTION_TYPE_ENUM_WITHDRAW_ASSET',
                                    child: Text('Withdraw Asset', style: TextStyle(color: UIConstants.textPrimary(isDarkTheme)))
                                  ),
                                  DropdownMenuItem<String?>(
                                    value: 'TRANSACTION_TYPE_ENUM_TRADE_BUY',
                                    child: Text('Trade Buy', style: TextStyle(color: UIConstants.textPrimary(isDarkTheme)))
                                  ),
                                  DropdownMenuItem<String?>(
                                    value: 'TRANSACTION_TYPE_ENUM_TRADE_SELL',
                                    child: Text('Trade Sell', style: TextStyle(color: UIConstants.textPrimary(isDarkTheme)))
                                  ),
                                  DropdownMenuItem<String?>(
                                    value: 'TRANSACTION_TYPE_ENUM_FEE',
                                    child: Text('Fee', style: TextStyle(color: UIConstants.textPrimary(isDarkTheme)))
                                  ),
                                  DropdownMenuItem<String?>(
                                    value: 'TRANSACTION_TYPE_ENUM_SETTLEMENT',
                                    child: Text('Settlement', style: TextStyle(color: UIConstants.textPrimary(isDarkTheme)))
                                  ),
                                  DropdownMenuItem<String?>(
                                    value: 'TRANSACTION_TYPE_ENUM_TRANSFER_IN',
                                    child: Text('Transfer In', style: TextStyle(color: UIConstants.textPrimary(isDarkTheme)))
                                  ),
                                  DropdownMenuItem<String?>(
                                    value: 'TRANSACTION_TYPE_ENUM_TRANSFER_OUT',
                                    child: Text('Transfer Out', style: TextStyle(color: UIConstants.textPrimary(isDarkTheme)))
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _tempSelectedTransactionType = value;
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
                                color: UIConstants.textSecondary(isDarkTheme),
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
                                  color: UIConstants.filterBarBackground(isDarkTheme),
                                  borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                  border: Border.all(
                                    color: UIConstants.visibleBorderColor(isDarkTheme),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 16,
                                      color: UIConstants.textSecondary(isDarkTheme),
                                    ),
                                    const SizedBox(width: UIConstants.spacingSm),
                                    Text(
                                      _transactionFromDate != null ?
                                      '${_transactionFromDate!.day}/${_transactionFromDate!.month}/${_transactionFromDate!.year} ${_transactionFromDate!.hour.toString().padLeft(2, '0')}:${_transactionFromDate!.minute.toString().padLeft(2, '0')}' :
                                      'Select Date and Time',
                                      style: TextStyle(
                                        fontSize: UIConstants.fontSizeSm,
                                        color: UIConstants.textPrimary(isDarkTheme),
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
                                color: UIConstants.textSecondary(isDarkTheme),
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
                                  color: UIConstants.filterBarBackground(isDarkTheme),
                                  borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                                  border: Border.all(
                                    color: UIConstants.visibleBorderColor(isDarkTheme),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 16,
                                      color: UIConstants.textSecondary(isDarkTheme),
                                    ),
                                    const SizedBox(width: UIConstants.spacingSm),
                                    Text(
                                      _transactionToDate != null ?
                                      '${_transactionToDate!.day}/${_transactionToDate!.month}/${_transactionToDate!.year} ${_transactionToDate!.hour.toString().padLeft(2, '0')}:${_transactionToDate!.minute.toString().padLeft(2, '0')}' :
                                      'Select Date and Time',
                                      style: TextStyle(
                                        fontSize: UIConstants.fontSizeSm,
                                        color: UIConstants.textPrimary(isDarkTheme),
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
                            _selectedTransactionsSecurity = _tempSelectedTransactionsSecurity;
                            _selectedTransactionType = _tempSelectedTransactionType;
                          });
                          _fetchActivityData();
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Apply Filters'),
                        style: UIConstants.buttonStyle(UIConstants.colorCommand),
                      ),
                      const SizedBox(width: UIConstants.spacingMd),
                      ElevatedButton.icon(
                        onPressed: () {
                          _clearTransactionsFilters();
                        },
                        icon: const Icon(Icons.clear),
                        label: const Text('Clear'),
                        style: UIConstants.buttonStyle(UIConstants.colorReject),
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
                // Table header row with horizontal scroll
                SingleChildScrollView(
                  controller: _transactionsHeaderScrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            'Transaction ID',
                            style: TextStyle(
                              fontSize: UIConstants.textFieldFontSize,
                              color: UIConstants.textSecondary(isDarkTheme),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          'Transaction Hash',
                          style: TextStyle(
                            fontSize: UIConstants.textFieldFontSize,
                            color: UIConstants.textSecondary(isDarkTheme),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: Text(
                          'Timestamp',
                          style: TextStyle(
                            fontSize: UIConstants.textFieldFontSize,
                            color: UIConstants.textSecondary(isDarkTheme),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          'Type',
                          style: TextStyle(
                            fontSize: UIConstants.textFieldFontSize,
                            color: UIConstants.textSecondary(isDarkTheme),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: Text(
                          'Operation',
                          style: TextStyle(
                            fontSize: UIConstants.textFieldFontSize,
                            color: UIConstants.textSecondary(isDarkTheme),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          'Account IID',
                          style: TextStyle(
                            fontSize: UIConstants.textFieldFontSize,
                            color: UIConstants.textSecondary(isDarkTheme),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          'To Account IID',
                          style: TextStyle(
                            fontSize: UIConstants.textFieldFontSize,
                            color: UIConstants.textSecondary(isDarkTheme),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: Text(
                          'To Reserve ID',
                          style: TextStyle(
                            fontSize: UIConstants.textFieldFontSize,
                            color: UIConstants.textSecondary(isDarkTheme),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          'To Stash',
                          style: TextStyle(
                            fontSize: UIConstants.textFieldFontSize,
                            color: UIConstants.textSecondary(isDarkTheme),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          'Security IID',
                          style: TextStyle(
                            fontSize: UIConstants.textFieldFontSize,
                            color: UIConstants.textSecondary(isDarkTheme),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: Text(
                          'Amount',
                          style: TextStyle(
                            fontSize: UIConstants.textFieldFontSize,
                            color: UIConstants.textSecondary(isDarkTheme),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: Text(
                          'Reference ID',
                          style: TextStyle(
                            fontSize: UIConstants.textFieldFontSize,
                            color: UIConstants.textSecondary(isDarkTheme),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text(
                            'Reference Type',
                            style: TextStyle(
                              fontSize: UIConstants.textFieldFontSize,
                              color: UIConstants.textSecondary(isDarkTheme),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: UIConstants.spacingSm),
                Container(
                  height: 1,
                  color: UIConstants.visibleBorderColor(isDarkTheme),
                ),
                const SizedBox(height: UIConstants.spacingSm),
                // Table rows with scrollbar at bottom
                Flexible(
                  child: Column(
                    children: [
                      Expanded(
                        child: _isLoadingTransactions
                            ? Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    UIConstants.textPrimary(isDarkTheme),
                                  ),
                                ),
                              )
                            : _transactions.isEmpty
                                ? Center(
                                    child: Text(
                                      'No transactions found',
                                      style: TextStyle(
                                        color: UIConstants.textSecondary(isDarkTheme),
                                        fontSize: UIConstants.textFieldFontSize,
                                      ),
                                    ),
                                  )
                                : Scrollbar(
                                    controller: _transactionsRowsScrollController,
                                    thumbVisibility: true,
                                    child: SingleChildScrollView(
                                      controller: _transactionsRowsScrollController,
                                      scrollDirection: Axis.horizontal,
                                      child: SizedBox(
                                        width: 150 + 150 + 180 + 150 + 120 + 150 + 150 + 120 + 100 + 100 + 120 + 120 + 120, // Sum of all column widths
                                        child: ListView.builder(
                                          itemCount: _transactions.length,
                                          itemBuilder: (context, index) {
                                            final transaction = _transactions[index];
                                            return Padding(
                                              padding: const EdgeInsets.only(bottom: 8),
                                              child: Row(
                                                children: [
                                                  // Transaction ID
                                                  SizedBox(
                                                    width: 150,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 16),
                                                      child: Text(
                                                        transaction['transactionId']?.toString() ?? 'N/A',
                                                        style: TextStyle(
                                                          fontSize: UIConstants.textFieldFontSize,
                                                          color: UIConstants.textPrimary(isDarkTheme),
                                                          fontWeight: UIConstants.fontWeightNormal,
                                                        ),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                  // Transaction Hash
                                                  SizedBox(
                                                    width: 150,
                                                    child: _buildHashWidget(
                                                      transaction['transactionHash']?.toString(),
                                                      isDarkTheme,
                                                    ),
                                                  ),
                                                  // Timestamp
                                                  SizedBox(
                                                    width: 180,
                                                    child: Text(
                                                      _formatTimestamp(transaction['timestamp']),
                                                      style: TextStyle(
                                                        fontSize: UIConstants.textFieldFontSize,
                                                        color: UIConstants.textSecondary(isDarkTheme),
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  // Type
                                                  SizedBox(
                                                    width: 150,
                                                    child: Text(
                                                      transaction['type']?.toString() ?? 'N/A',
                                                      style: TextStyle(
                                                        fontSize: UIConstants.textFieldFontSize,
                                                        color: UIConstants.textPrimary(isDarkTheme),
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  // Operation
                                                  SizedBox(
                                                    width: 120,
                                                    child: Text(
                                                      transaction['operation']?.toString() ?? 'N/A',
                                                      style: TextStyle(
                                                        fontSize: UIConstants.textFieldFontSize,
                                                        color: UIConstants.textPrimary(isDarkTheme),
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  // Account IID
                                                  SizedBox(
                                                    width: 150,
                                                    child: Text(
                                                      transaction['accountIid']?.toString() ?? 'N/A',
                                                      style: TextStyle(
                                                        fontSize: UIConstants.textFieldFontSize,
                                                        color: UIConstants.textPrimary(isDarkTheme),
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  // To Account IID
                                                  SizedBox(
                                                    width: 150,
                                                    child: Text(
                                                      transaction['toAccountIid']?.toString() ?? 'N/A',
                                                      style: TextStyle(
                                                        fontSize: UIConstants.textFieldFontSize,
                                                        color: UIConstants.textPrimary(isDarkTheme),
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  // To Reserve ID
                                                  SizedBox(
                                                    width: 120,
                                                    child: Text(
                                                      transaction['toReserveId']?.toString() ?? 'N/A',
                                                      style: TextStyle(
                                                        fontSize: UIConstants.textFieldFontSize,
                                                        color: UIConstants.textPrimary(isDarkTheme),
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  // To Stash
                                                  SizedBox(
                                                    width: 100,
                                                    child: Text(
                                                      transaction['toStash']?.toString() ?? 'N/A',
                                                      style: TextStyle(
                                                        fontSize: UIConstants.textFieldFontSize,
                                                        color: UIConstants.textPrimary(isDarkTheme),
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  // Security IID
                                                  SizedBox(
                                                    width: 100,
                                                    child: Text(
                                                      transaction['assetIid']?.toString() ?? 'N/A',
                                                      style: TextStyle(
                                                        fontSize: UIConstants.textFieldFontSize,
                                                        color: UIConstants.textPrimary(isDarkTheme),
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  // Amount
                                                  SizedBox(
                                                    width: 120,
                                                    child: Text(
                                                      transaction['amount']?.toString() ?? 'N/A',
                                                      style: TextStyle(
                                                        fontSize: UIConstants.textFieldFontSize,
                                                        color: UIConstants.textPrimary(isDarkTheme),
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  // Reference ID
                                                  SizedBox(
                                                    width: 120,
                                                    child: Text(
                                                      transaction['referenceId']?.toString() ?? 'N/A',
                                                      style: TextStyle(
                                                        fontSize: UIConstants.textFieldFontSize,
                                                        color: UIConstants.textPrimary(isDarkTheme),
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  // Reference Type
                                                  SizedBox(
                                                    width: 120,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(right: 16),
                                                      child: Text(
                                                        transaction['referenceType']?.toString() ?? 'N/A',
                                                        style: TextStyle(
                                                          fontSize: UIConstants.textFieldFontSize,
                                                          color: UIConstants.textPrimary(isDarkTheme),
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
                                    ),
                        ),
                      ),
                      // Show More button for transactions
                      if (_transactions.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Center(
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                if (_cachedAccountId != null && _cachedAccountId!.isNotEmpty) {
                                  setState(() {
                                    _transactionPageSize = (_transactionPageSize ?? 15) + 15;
                                  });
                                  await _fetchTransactionsWithAccountId(_cachedAccountId!);
                                }
                              },
                              icon: const Icon(Icons.add),
                              label: const Text('Show More'),
                              style: UIConstants.buttonStyle(UIConstants.colorCommand),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
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

  String _formatTransactionAmount(String amount, String securityId) {
    try {
      final double value = double.parse(amount);
      if (securityId == 'USDC' || securityId == 'USD') {
        // USDC typically has 6 decimals
        return '${(value / 1000000).toStringAsFixed(2)} $securityId';
      } else if (securityId == 'ETH') {
        // ETH has 18 decimals
        return '${(value / 1000000000000000000).toStringAsFixed(4)} $securityId';
      } else if (securityId == 'BTC') {
        // BTC has 8 decimals
        return '${(value / 100000000).toStringAsFixed(8)} $securityId';
      } else {
        // Default formatting
        return '$value $securityId';
      }
    } catch (e) {
      return '$amount $securityId';
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