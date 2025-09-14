import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/theme_service.dart';
import '../services/real_grpc_client.dart';
import '../utils/connectivity_checker.dart';
import 'portfolio_page.dart';
import 'trading_page.dart';
import 'profile_page.dart';
import 'users_admin_page.dart';

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

  // Account management
  String? _cachedAccountId;

  // Filter state for orders
  String? _selectedSide; // BUY, SELL, or null for all
  List<String> _marketFilters = [];
  List<String> _instrumentFilters = [];
  DateTime? _fromDate;
  DateTime? _toDate;
  bool _showOnlyFilled = false;
  bool _showOnlyCancelled = false;
  bool _showOnlyExpired = false;
  int? _pageSize = 50;
  int _pageNumber = 1;
  bool _showFilters = false;

  // Filter state for trades (similar to orders but without status filters)
  String? _selectedTradeSide;
  List<String> _tradeMarketFilters = [];
  List<String> _tradeInstrumentFilters = [];
  DateTime? _tradeFromDate;
  DateTime? _tradeToDate;
  int? _tradePageSize = 50;
  int _tradePageNumber = 1;
  bool _showTradeFilters = false;
  
  // Market and Asset dropdown data
  List<Map<String, dynamic>> _availableMarkets = [];
  List<Map<String, dynamic>> _availableAssets = [];
  String? _selectedOrdersMarket;
  String? _selectedOrdersAsset;
  String? _selectedTradesMarket;
  String? _selectedTradesAsset;
  bool _isLoadingMarkets = false;
  bool _isLoadingAssets = false;
  
  // Temporary filter state (used before applying filters)
  String? _tempSelectedOrdersMarket;
  String? _tempSelectedOrdersAsset;
  String? _tempSelectedTradesMarket;
  String? _tempSelectedTradesAsset;
  
  // Text controllers for page number fields
  late TextEditingController _pageNumberController;
  late TextEditingController _tradePageNumberController;

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
    
    // Check server connectivity when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ConnectivityChecker.checkAndShowErrorIfNeeded(context, 'Activity');
    });
    
    // Fetch both orders and trades when page loads
    _fetchActivityData();
    
    // Load dropdown data
    _fetchMarketList();
    // Asset list will be fetched when market is selected
  }

  @override
  void dispose() {
    _pageNumberController.dispose();
    _tradePageNumberController.dispose();
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
    if (dateTime == null) return 'Select date & time';
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
    ]);
    print('🏁 _fetchActivityData() completed - both orders and trades fetch finished');
  }

  /// Find the account that belongs to the logged-in user
  String? _findUserAccount(List<dynamic> accounts, String username) {
    print('🔍 Searching for account matching user: "$username"');
    print('📋 Available accounts:');
    
    for (int i = 0; i < accounts.length; i++) {
      final accountMap = accounts[i] as Map<String, dynamic>;
      final externalId = accountMap['external_id'] ?? accountMap['externalId'] ?? '';
      final accountId = accountMap['id'] ?? '';
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
      final externalId = accountMap['external_id'] ?? accountMap['externalId'] ?? '';
      final accountId = accountMap['id'] ?? '';
      
      if (externalId.toLowerCase() == username.toLowerCase()) {
        print('✅ Found case-insensitive match for user "$username": ID="$accountId", ExternalID="$externalId"');
        return accountId;
      }
    }
    
    // If still no match, try contains
    for (final account in accounts) {
      final accountMap = account as Map<String, dynamic>;
      final externalId = accountMap['external_id'] ?? accountMap['externalId'] ?? '';
      final accountId = accountMap['id'] ?? '';
      
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
      final statusFilters = [_showOnlyFilled, _showOnlyCancelled, _showOnlyExpired];
      
      // Format date filters in the required timestamp format
      Map<String, dynamic>? fromTimeFormatted;
      Map<String, dynamic>? toTimeFormatted;
      
      if (_fromDate != null) {
        // Use exact time selected by user
        fromTimeFormatted = {
          "ts": _fromDate!.toUtc().toIso8601String()
        };
      }
      
      if (_toDate != null) {
        // Use exact time selected by user
        toTimeFormatted = {
          "ts": _toDate!.toUtc().toIso8601String()
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
        statusFilters: statusFilters.contains(true) ? statusFilters : null,
        instrumentIdOrSymbolRegexes: _instrumentFilters.isNotEmpty ? _instrumentFilters : null,
      );

      print('📤 GetAccountOrders OUTPUT: ${jsonEncode(ordersResponse)}');

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
        // Use exact time selected by user
        fromTimeFormatted = {
          "ts": _tradeFromDate!.toUtc().toIso8601String()
        };
      }
      
      if (_tradeToDate != null) {
        // Use exact time selected by user
        toTimeFormatted = {
          "ts": _tradeToDate!.toUtc().toIso8601String()
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

  /// Apply filter changes and refresh data
  void _applyFilters() {
    setState(() {
      // Apply temporary filter state to actual filter state
      _selectedOrdersMarket = _tempSelectedOrdersMarket;
      _selectedOrdersAsset = _tempSelectedOrdersAsset;
      _selectedTradesMarket = _tempSelectedTradesMarket;
      _selectedTradesAsset = _tempSelectedTradesAsset;
    });
    
    // Refresh data with new filters
    _fetchOrders();
    _fetchTrades();
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
                    // Navigate through the nested structure: instrument -> zonedSymbols -> symbols -> value
                    final zonedSymbols = instrument['zonedSymbols'] ?? [];
                    if (zonedSymbols is List && zonedSymbols.isNotEmpty) {
                      for (final zonedSymbol in zonedSymbols) {
                        if (zonedSymbol is Map<String, dynamic>) {
                          final symbols = zonedSymbol['symbols'] ?? [];
                          if (symbols is List && symbols.isNotEmpty) {
                            for (final symbol in symbols) {
                              if (symbol is Map<String, dynamic> && symbol.containsKey('value')) {
                                final symbolValue = symbol['value'];
                                processedAssets.add({
                                  'id': symbolValue,
                                  'symbol': symbolValue,
                                  'instrument_id': symbolValue,
                                  'description': instrument['description'] ?? symbolValue,
                                });
                              }
                            }
                          }
                        }
                      }
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
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Table header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkTheme ? const Color(0xFF2d2d2d) : Colors.grey[50],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Orders',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(width: 16),
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
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.grey[100],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // First row of filters
                  Row(
                    children: [
                      // Side filter
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Side',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 48,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: isDarkTheme ? Colors.grey[600]! : Colors.grey[400]!),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: DropdownButton<String?>(
                                value: _selectedSide,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.white,
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
                      const SizedBox(width: 16),
                      // Page size filter
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Page Size',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 48,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: isDarkTheme ? Colors.grey[600]! : Colors.grey[400]!),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: DropdownButton<int?>(
                                value: _pageSize,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.white,
                                items: [
                                  DropdownMenuItem(
                                    value: null, 
                                    child: Text('All', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))
                                  ),
                                  ...[10, 25, 50, 100].map((size) => 
                                    DropdownMenuItem(
                                      value: size, 
                                      child: Text('$size', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))
                                    )
                                  ).toList(),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _pageSize = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Page number filter
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Page Number',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: isDarkTheme ? Colors.grey[600]! : Colors.grey[400]!),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: TextFormField(
                                      controller: _pageNumberController,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        color: isDarkTheme ? Colors.white : Colors.black,
                                        fontSize: 14,
                                      ),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                      onChanged: (value) {
                                        final pageNum = int.tryParse(value);
                                        if (pageNum != null && pageNum > 0) {
                                          setState(() {
                                            _pageNumber = pageNum;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  onPressed: _pageNumber > 1 ? () {
                                    setState(() {
                                      _pageNumber = _pageNumber - 1;
                                      _pageNumberController.text = _pageNumber.toString();
                                    });
                                  } : null,
                                  icon: Icon(
                                    Icons.keyboard_arrow_left,
                                    color: _pageNumber > 1 
                                        ? (isDarkTheme ? Colors.white : Colors.black)
                                        : Colors.grey,
                                  ),
                                  iconSize: 20,
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _pageNumber = _pageNumber + 1;
                                      _pageNumberController.text = _pageNumber.toString();
                                    });
                                  },
                                  icon: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: isDarkTheme ? Colors.white : Colors.black,
                                  ),
                                  iconSize: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Second row - Market and Asset filters
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
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 48,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: isDarkTheme ? Colors.grey[600]! : Colors.grey[400]!),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: DropdownButton<String?>(
                                value: _tempSelectedOrdersMarket ?? _selectedOrdersMarket,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.white,
                                items: [
                                  DropdownMenuItem(value: null, child: Text('All Markets', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))),
                                  ..._availableMarkets.map<DropdownMenuItem<String?>>((market) => 
                                    DropdownMenuItem<String?>(
                                      value: (market['identifiers'] as List?)?.first ?? market['id'] ?? '',
                                      child: Text(
                                        (market['names'] as List?)?.first ?? market['name'] ?? 'Unknown',
                                        style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black)
                                      )
                                    )
                                  ).toList(),
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
                      const SizedBox(width: 16),
                      // Asset filter
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Asset',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 48,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: isDarkTheme ? Colors.grey[600]! : Colors.grey[400]!),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: DropdownButton<String?>(
                                value: _tempSelectedOrdersAsset ?? _selectedOrdersAsset,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.white,
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
                      const SizedBox(width: 16),
                      // Empty space to balance the row
                      Expanded(child: Container()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Status filters
                  Text(
                    'Status Filters',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: Text('Filled', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black)),
                          value: _showOnlyFilled,
                          onChanged: (value) {
                            setState(() {
                              _showOnlyFilled = value ?? false;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          dense: true,
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: Text('Cancelled', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black)),
                          value: _showOnlyCancelled,
                          onChanged: (value) {
                            setState(() {
                              _showOnlyCancelled = value ?? false;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          dense: true,
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: Text('Expired', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black)),
                          value: _showOnlyExpired,
                          onChanged: (value) {
                            setState(() {
                              _showOnlyExpired = value ?? false;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          dense: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Date filters row
                  Row(
                    children: [
                      // From Date filter
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'From Time',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
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
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: isDarkTheme ? Colors.grey[600]! : Colors.grey[400]!),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _formatDateTime(_fromDate),
                                        style: TextStyle(
                                          color: isDarkTheme ? Colors.white : Colors.black,
                                          fontSize: 14,
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
                      const SizedBox(width: 16),
                      // To Date filter
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'To Time',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
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
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: isDarkTheme ? Colors.grey[600]! : Colors.grey[400]!),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _formatDateTime(_toDate),
                                        style: TextStyle(
                                          color: isDarkTheme ? Colors.white : Colors.black,
                                          fontSize: 14,
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
                  const SizedBox(height: 16),
                  // Apply filters button
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _applyFilters(); // Apply filter changes and refresh orders
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Apply Filters'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
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
                            fontSize: 14,
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
                          fontSize: 14,
                          color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Symbol',
                        style: TextStyle(
                          fontSize: 14,
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
                          fontSize: 14,
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
                            fontSize: 14,
                            color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 1,
                  color: isDarkTheme ? Colors.grey[700] : Colors.grey[300],
                ),
                const SizedBox(height: 12),
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
                                  fontSize: 14,
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
                                              fontSize: 16,
                                              color: isDarkTheme ? Colors.white : Colors.black,
                                              fontWeight: FontWeight.w500,
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
                                            fontSize: 16,
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
                                            fontSize: 16,
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
                                            fontSize: 16,
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
                                              fontSize: 16,
                                              color: isDarkTheme ? Colors.white : Colors.black,
                                              fontWeight: FontWeight.w500,
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
        ],
      ),
    );
  }

  /// Build trades table widget
  Widget _buildTradesTable(bool isDarkTheme) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkTheme ? const Color(0xFF1e1e1e) : Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Table header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkTheme ? const Color(0xFF2d2d2d) : Colors.grey[50],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Trades',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(width: 16),
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
                  tooltip: 'Toggle Trade Filters',
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
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.grey[100],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // First row of filters
                  Row(
                    children: [
                      // Side filter for trades
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Side',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 48,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: isDarkTheme ? Colors.grey[600]! : Colors.grey[400]!),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: DropdownButton<String?>(
                                value: _selectedTradeSide,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.white,
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
                      const SizedBox(width: 16),
                      // Page size filter for trades
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Page Size',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 48,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: isDarkTheme ? Colors.grey[600]! : Colors.grey[400]!),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: DropdownButton<int?>(
                                value: _tradePageSize,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.white,
                                items: [
                                  DropdownMenuItem(
                                    value: null, 
                                    child: Text('All', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))
                                  ),
                                  ...[10, 25, 50, 100].map((size) => 
                                    DropdownMenuItem(
                                      value: size, 
                                      child: Text('$size', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))
                                    )
                                  ).toList(),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _tradePageSize = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Page number filter
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Page Number',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: isDarkTheme ? Colors.grey[600]! : Colors.grey[400]!),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: TextFormField(
                                      controller: _tradePageNumberController,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        color: isDarkTheme ? Colors.white : Colors.black,
                                        fontSize: 14,
                                      ),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                      onChanged: (value) {
                                        final pageNum = int.tryParse(value);
                                        if (pageNum != null && pageNum > 0) {
                                          setState(() {
                                            _tradePageNumber = pageNum;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  onPressed: _tradePageNumber > 1 ? () {
                                    setState(() {
                                      _tradePageNumber = _tradePageNumber - 1;
                                      _tradePageNumberController.text = _tradePageNumber.toString();
                                    });
                                  } : null,
                                  icon: Icon(
                                    Icons.keyboard_arrow_left,
                                    color: _tradePageNumber > 1 
                                        ? (isDarkTheme ? Colors.white : Colors.black)
                                        : Colors.grey,
                                  ),
                                  iconSize: 20,
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _tradePageNumber = _tradePageNumber + 1;
                                      _tradePageNumberController.text = _tradePageNumber.toString();
                                    });
                                  },
                                  icon: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: isDarkTheme ? Colors.white : Colors.black,
                                  ),
                                  iconSize: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Market and Asset filters row for trades
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
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 48,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: isDarkTheme ? Colors.grey[600]! : Colors.grey[400]!),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: DropdownButton<String?>(
                                value: _tempSelectedTradesMarket ?? _selectedTradesMarket,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.white,
                                items: [
                                  DropdownMenuItem(value: null, child: Text('All Markets', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))),
                                  ..._availableMarkets.map<DropdownMenuItem<String?>>((market) => 
                                    DropdownMenuItem<String?>(
                                      value: (market['identifiers'] as List?)?.first ?? market['id'] ?? '',
                                      child: Text(
                                        (market['names'] as List?)?.first ?? market['name'] ?? 'Unknown',
                                        style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black)
                                      )
                                    )
                                  ).toList(),
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
                      const SizedBox(width: 16),
                      // Asset filter for trades
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Asset',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 48,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: isDarkTheme ? Colors.grey[600]! : Colors.grey[400]!),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: DropdownButton<String?>(
                                value: _tempSelectedTradesAsset ?? _selectedTradesAsset,
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                dropdownColor: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.white,
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
                      const SizedBox(width: 16),
                      // Empty space to balance the row
                      Expanded(child: Container()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Date filters row
                  Row(
                    children: [
                      // From Date filter
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'From Time',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
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
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: isDarkTheme ? Colors.grey[600]! : Colors.grey[400]!),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _formatDateTime(_tradeFromDate),
                                        style: TextStyle(
                                          color: isDarkTheme ? Colors.white : Colors.black,
                                          fontSize: 14,
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
                      const SizedBox(width: 16),
                      // To Date filter
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'To Time',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
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
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: isDarkTheme ? Colors.grey[600]! : Colors.grey[400]!),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _formatDateTime(_tradeToDate),
                                        style: TextStyle(
                                          color: isDarkTheme ? Colors.white : Colors.black,
                                          fontSize: 14,
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
                  const SizedBox(height: 16),
                  // Apply filters button for trades
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _applyFilters(); // Apply filter changes and refresh trades
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Apply Trade Filters'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
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
                            fontSize: 14,
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
                            fontSize: 14,
                            color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 1,
                  color: isDarkTheme ? Colors.grey[700] : Colors.grey[300],
                ),
                const SizedBox(height: 12),
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
                                  fontSize: 14,
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
                                              fontSize: 16,
                                              color: isDarkTheme ? Colors.white : Colors.black,
                                              fontWeight: FontWeight.w500,
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
                                              fontSize: 16,
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
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
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
        return _buildSettlementsContent(isDarkTheme);
      case 3: // Transactions
        return _buildTransactionsContent(isDarkTheme);
      default:
        return _buildOrdersTable(isDarkTheme);
    }
  }

  /// Build settlements content (placeholder)
  Widget _buildSettlementsContent(bool isDarkTheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 48,
            color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
          ),
          const SizedBox(height: 16),
          Text(
            'Settlements',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDarkTheme ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Settlements data will be displayed here',
            style: TextStyle(
              fontSize: 14,
              color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  /// Build transactions content (placeholder)
  Widget _buildTransactionsContent(bool isDarkTheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 48,
            color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
          ),
          const SizedBox(height: 16),
          Text(
            'Transactions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDarkTheme ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Transactions data will be displayed here',
            style: TextStyle(
              fontSize: 14,
              color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final themeService = Provider.of<ThemeService>(context);
    final isDarkTheme = themeService.isDarkTheme;

    return Scaffold(
      backgroundColor: isDarkTheme ? const Color(0xFF121212) : Colors.grey[100],
      body: Column(
        children: [
          // Header with navigation
          _buildHeader(authService, themeService),
          
          // Main content area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _buildConnectedTabInterface(isDarkTheme),
            ),
          ),
        ],
      ),
    );
  }

  /// Build header with navigation similar to Portfolio page
  Widget _buildHeader(AuthService authService, ThemeService themeService) {
    final isDarkTheme = themeService.isDarkTheme;
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1754),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo on the left
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF1E88E5),
            ),
            child: ClipOval(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF1E88E5),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'mini\n',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.w500,
                              height: 0.8,
                            ),
                          ),
                          TextSpan(
                            text: 'Broker',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              height: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Navigation Tabs - Left side beside logo
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
              // Portfolio Button
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => const PortfolioPage(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Container(
                        height: 45,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          border: Border(
                            top: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
                            left: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
                            right: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
                            bottom: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Portfolio',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              // Trading Button
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => const TradingPage(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Container(
                        height: 45,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          border: Border(
                            top: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
                            left: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
                            right: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
                            bottom: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Trading',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              // Activity Button (current page)
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  height: 55,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isDarkTheme ? const Color(0xFF121212) : Colors.grey[100],
                    border: Border(
                      top: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
                      left: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
                      right: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Activity',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isDarkTheme ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              ],
            ),
          ),
          
          // Spacer to push user menu to the right
          const Spacer(),
          
          // User Profile with Dropdown
          PopupMenuButton<String>(
            offset: const Offset(18, 40),
            color: const Color(0xFF1a1754),
            surfaceTintColor: const Color(0xFF1a1754),
            shadowColor: Colors.black.withOpacity(0.3),
            elevation: 8,
            onSelected: (value) {
              if (value == 'profile') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              } else if (value == 'users') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UsersAdminPage(),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              final isAdmin = authService.username.toLowerCase() == 'admin';
              return [
                PopupMenuItem<String>(
                  value: 'profile',
                  child: Row(
                    children: [
                      Icon(Icons.person, size: 18, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Profile', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                if (isAdmin)
                  PopupMenuDivider(
                    height: 1,
                    color: Colors.white.withOpacity(0.3),
                  ),
                if (isAdmin)
                  PopupMenuItem<String>(
                    value: 'users',
                    child: Row(
                      children: [
                        Icon(Icons.people, size: 18, color: Colors.white),
                        SizedBox(width: 8),
                        Text('View Users', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
              ];
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  authService.username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Vertical divider line
          Container(
            height: 30,
            width: 1,
            color: Colors.white.withOpacity(0.3),
          ),
          
          const SizedBox(width: 16),
          
          // Theme toggle button (centered)
          Container(
            width: 36,
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {
                themeService.toggleTheme();
              },
              icon: Icon(
                themeService.isDarkTheme ? Icons.wb_sunny : Icons.nights_stay,
                color: Colors.white,
                size: 20,
              ),
              tooltip: themeService.isDarkTheme ? 'Light Theme' : 'Dark Theme',
              padding: const EdgeInsets.all(8),
            ),
          ),
          
          const SizedBox(width: 8),
          
          // Vertical divider line
          Container(
            height: 30,
            width: 1,
            color: Colors.white.withOpacity(0.3),
          ),
          
          const SizedBox(width: 8),
          
          // Logout icon button
          IconButton(
            onPressed: () async {
              try {
                print('🚪 Activity page logout initiated...');
                await authService.logout();
                print('✅ Logout completed, should redirect to login');
                
                // Navigate back to root to ensure proper app state reset
                if (mounted) {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }
              } catch (e) {
                print('❌ Error during logout: $e');
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Logout failed: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
              size: 20,
            ),
            tooltip: 'Logout',
            padding: const EdgeInsets.all(8),
          ),
        ],
      ),
    );
  }
}