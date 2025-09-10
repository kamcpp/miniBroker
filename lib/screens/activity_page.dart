import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/theme_service.dart';
import '../services/real_grpc_client.dart';
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
  int _pageSize = 50;
  bool _showFilters = false;

  // Filter state for trades (similar to orders but without status filters)
  String? _selectedTradeSide;
  List<String> _tradeMarketFilters = [];
  List<String> _tradeInstrumentFilters = [];
  DateTime? _tradeFromDate;
  DateTime? _tradeToDate;
  int _tradePageSize = 50;
  bool _showTradeFilters = false;
  
  @override
  void initState() {
    super.initState();
    // Fetch both orders and trades when page loads
    _fetchActivityData();
  }

  /// Fetch both orders and trades data
  Future<void> _fetchActivityData() async {
    await Future.wait([
      _fetchOrders(),
      _fetchTrades(),
    ]);
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

  /// Fetch orders using GetAccountOrders function
  Future<void> _fetchOrders() async {
    setState(() {
      _isLoadingOrders = true;
      _ordersError = '';
    });

    try {
      print('📋 Fetching orders...');
      
      // Get account ID
      final accountId = await _getAccountId();
      if (accountId == null || accountId.isEmpty) {
        setState(() {
          _isLoadingOrders = false;
          _ordersError = 'No account ID found for logged-in user';
          _orders = [];
        });
        print('❌ No account ID found for orders');
        return;
      }

      // Prepare filter parameters
      final pagination = {'page_size': _pageSize, 'page_nr': 1};
      final statusFilters = [_showOnlyFilled, _showOnlyCancelled, _showOnlyExpired];
      
      final inputParams = {
        'ref_request_id': 'flutter-get-orders-${DateTime.now().millisecondsSinceEpoch}',
        'account_id': accountId,
        'market_id_or_name_regexes': _marketFilters,
        'instrument_id_or_symbol_regexes': _instrumentFilters,
        'from_time': _fromDate?.toIso8601String(),
        'to_time': _toDate?.toIso8601String(),
        'side': _selectedSide,
        'status_filters': statusFilters,
        'pagination': {
          'page_size': _pageSize,
          'page_nr': 1,
        },
      };

      print('🔍 GetAccountOrders INPUT: ${jsonEncode(inputParams)}');

      // Call GetAccountOrders with all parameters
      final ordersResponse = await realGrpcClient.getAccountOrders(
        accountId: accountId,
        marketIdOrNameRegexes: _marketFilters.isNotEmpty ? _marketFilters : null,
        pagination: pagination,
        fromTime: _fromDate?.toIso8601String(),
        toTime: _toDate?.toIso8601String(),
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

  /// Fetch trades using GetAccountTrades function
  Future<void> _fetchTrades() async {
    setState(() {
      _isLoadingTrades = true;
      _tradesError = '';
    });

    try {
      print('📋 Fetching trades...');
      
      // Get account ID
      final accountId = await _getAccountId();
      if (accountId == null || accountId.isEmpty) {
        setState(() {
          _isLoadingTrades = false;
          _tradesError = 'No account ID found for logged-in user';
          _trades = [];
        });
        print('❌ No account ID found for trades');
        return;
      }

      // Prepare filter parameters for trades
      final tradePagination = {'page_size': _tradePageSize, 'page_nr': 1};
      
      final tradeInputParams = {
        'ref_request_id': 'flutter-get-trades-${DateTime.now().millisecondsSinceEpoch}',
        'account_id': accountId,
        'market_id_or_name_regexes': _tradeMarketFilters,
        'instrument_id_or_symbol_regexes': _tradeInstrumentFilters,
        'from_time': _tradeFromDate?.toIso8601String(),
        'to_time': _tradeToDate?.toIso8601String(),
        'side': _selectedTradeSide,
        'pagination': {
          'page_size': _tradePageSize,
          'page_nr': 1,
        },
      };

      print('🔍 GetAccountTrades INPUT: ${jsonEncode(tradeInputParams)}');

      // Call GetAccountTrades with all parameters
      final tradesResponse = await realGrpcClient.getAccountTrades(
        accountId: accountId,
        marketIdOrNameRegexes: _tradeMarketFilters.isNotEmpty ? _tradeMarketFilters : null,
        pagination: tradePagination,
        fromTime: _tradeFromDate?.toIso8601String(),
        toTime: _tradeToDate?.toIso8601String(),
        side: _selectedTradeSide,
        instrumentIdOrSymbolRegexes: _tradeInstrumentFilters.isNotEmpty ? _tradeInstrumentFilters : null,
      );

      print('📤 GetAccountTrades OUTPUT: ${jsonEncode(tradesResponse)}');

      if (mounted) {
        setState(() {
          _isLoadingTrades = false;
          
          if (tradesResponse['success'] == true) {
            final output = tradesResponse['output'] as Map<String, dynamic>;
            // Extract trades from the response - adjust field name based on actual server response
            final tradesList = output['trades'] as List<dynamic>? ?? [];
            _trades = tradesList.map((trade) => trade as Map<String, dynamic>).toList();
            _tradesError = '';
            print('✅ Trades loaded successfully: ${_trades.length} trades found');
          } else {
            final output = tradesResponse['output'] as Map<String, dynamic>;
            _tradesError = output['error']?.toString() ?? 'Unknown error fetching trades';
            _trades = [];
            print('❌ Failed to fetch trades: $_tradesError');
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingTrades = false;
          _tradesError = 'Failed to fetch trades: ${e.toString()}';
          _trades = [];
        });
      }
      print('❌ Exception fetching trades: $e');
    }
  }

  /// Build orders table widget
  Widget _buildOrdersTable(bool isDarkTheme) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkTheme ? const Color(0xFF1e1e1e) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDarkTheme ? Colors.grey[700]! : Colors.grey[300]!,
          width: 1,
        ),
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
                border: Border(
                  bottom: BorderSide(
                    color: isDarkTheme ? Colors.grey[700]! : Colors.grey[300]!,
                    width: 1,
                  ),
                ),
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
                                color: isDarkTheme ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            DropdownButton<String?>(
                              value: _selectedSide,
                              isExpanded: true,
                              dropdownColor: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.white,
                              items: [
                                DropdownMenuItem(value: null, child: Text('All', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))),
                                DropdownMenuItem(value: 'BUY', child: Text('BUY', style: TextStyle(color: Colors.green))),
                                DropdownMenuItem(value: 'SELL', child: Text('SELL', style: TextStyle(color: Colors.red))),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedSide = value;
                                });
                              },
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
                                color: isDarkTheme ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            DropdownButton<int>(
                              value: _pageSize,
                              isExpanded: true,
                              dropdownColor: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.white,
                              items: [10, 25, 50, 100].map((size) => 
                                DropdownMenuItem(
                                  value: size, 
                                  child: Text('$size', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))
                                )
                              ).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _pageSize = value;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Status filters
                  Text(
                    'Status Filters',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDarkTheme ? Colors.white : Colors.black,
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
                  // Apply filters button
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _fetchOrders(); // Refresh orders with current filters
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
          Container(
            height: _showFilters ? 300 : 400, // Fixed height instead of Expanded
            child: _isLoadingOrders
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isDarkTheme ? Colors.white : Colors.black,
                      ),
                    ),
                  )
                : _ordersError.isNotEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 48,
                                color: Colors.red,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Error loading orders',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkTheme ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _ordersError,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton.icon(
                                onPressed: _fetchOrders,
                                icon: const Icon(Icons.refresh),
                                label: const Text('Retry'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                              // Show empty table structure even on error
                              const SizedBox(height: 20),
                              _buildOrdersTableStructure(isDarkTheme),
                            ],
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          // Table header
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              color: isDarkTheme ? const Color(0xFF2d2d2d) : Colors.grey[200],
                              border: Border.all(
                                color: isDarkTheme ? Colors.grey[600]! : Colors.grey[400]!,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Order ID',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isDarkTheme ? Colors.white : Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Participant Account',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isDarkTheme ? Colors.white : Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Symbol',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isDarkTheme ? Colors.white : Colors.black,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Quantity',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isDarkTheme ? Colors.white : Colors.black,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Price',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isDarkTheme ? Colors.white : Colors.black,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Table rows
                          Flexible(
                            child: _orders.isEmpty
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.receipt_long,
                                          size: 48,
                                          color: isDarkTheme ? Colors.grey[600] : Colors.grey[400],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'No orders found',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: _orders.length,
                                    itemBuilder: (context, index) {
                                      final order = _orders[index];
                                      return Container(
                                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                        decoration: BoxDecoration(
                                          color: index.isEven 
                                              ? (isDarkTheme ? const Color(0xFF1e1e1e) : Colors.white)
                                              : (isDarkTheme ? const Color(0xFF2a2a2a) : Colors.grey[50]),
                                          border: Border(
                                            left: BorderSide(color: isDarkTheme ? Colors.grey[600]! : Colors.grey[400]!),
                                            right: BorderSide(color: isDarkTheme ? Colors.grey[600]! : Colors.grey[400]!),
                                            bottom: BorderSide(color: isDarkTheme ? Colors.grey[700]! : Colors.grey[300]!),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            // Order ID
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                order['id']?.toString() ?? 
                                                order['order_id']?.toString() ?? 
                                                'N/A',
                                                style: TextStyle(
                                                  color: isDarkTheme ? Colors.white : Colors.black,
                                                  fontSize: 13,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            // Participant Account
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                order['account_id']?.toString() ?? 
                                                order['participant_account']?.toString() ?? 
                                                'N/A',
                                                style: TextStyle(
                                                  color: isDarkTheme ? Colors.white : Colors.black,
                                                  fontSize: 13,
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
                                                  fontWeight: FontWeight.w600,
                                                  color: isDarkTheme ? Colors.white : Colors.black,
                                                  fontSize: 13,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            // Quantity
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                order['quantity']?.toString() ?? 'N/A',
                                                style: TextStyle(
                                                  color: isDarkTheme ? Colors.white : Colors.black,
                                                  fontSize: 13,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            // Price
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                order['price']?.toString() ?? 'N/A',
                                                style: TextStyle(
                                                  color: isDarkTheme ? Colors.white : Colors.black,
                                                  fontSize: 13,
                                                ),
                                                textAlign: TextAlign.right,
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
        border: Border.all(
          color: isDarkTheme ? Colors.grey[700]! : Colors.grey[300]!,
          width: 1,
        ),
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
                border: Border(
                  bottom: BorderSide(
                    color: isDarkTheme ? Colors.grey[700]! : Colors.grey[300]!,
                    width: 1,
                  ),
                ),
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
                                color: isDarkTheme ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            DropdownButton<String?>(
                              value: _selectedTradeSide,
                              isExpanded: true,
                              dropdownColor: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.white,
                              items: [
                                DropdownMenuItem(value: null, child: Text('All', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))),
                                DropdownMenuItem(value: 'BUY', child: Text('BUY', style: TextStyle(color: Colors.green))),
                                DropdownMenuItem(value: 'SELL', child: Text('SELL', style: TextStyle(color: Colors.red))),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedTradeSide = value;
                                });
                              },
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
                                color: isDarkTheme ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            DropdownButton<int>(
                              value: _tradePageSize,
                              isExpanded: true,
                              dropdownColor: isDarkTheme ? const Color(0xFF2a2a2a) : Colors.white,
                              items: [10, 25, 50, 100].map((size) => 
                                DropdownMenuItem(
                                  value: size, 
                                  child: Text('$size', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black))
                                )
                              ).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _tradePageSize = value;
                                  });
                                }
                              },
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
                        _fetchTrades(); // Refresh trades with current filters
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
          Container(
            height: _showTradeFilters ? 200 : 300, // Adjust height when filters are shown
            child: _isLoadingTrades
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isDarkTheme ? Colors.white : Colors.black,
                      ),
                    ),
                  )
                : _tradesError.isNotEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 48,
                                color: Colors.red,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Error loading trades',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkTheme ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _tradesError,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton.icon(
                                onPressed: _fetchTrades,
                                icon: const Icon(Icons.refresh),
                                label: const Text('Retry'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : _trades.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.swap_horiz,
                                  size: 48,
                                  color: isDarkTheme ? Colors.grey[600] : Colors.grey[400],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'No trades found',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: _trades.length,
                            itemBuilder: (context, index) {
                              final trade = _trades[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isDarkTheme ? const Color(0xFF2d2d2d) : Colors.grey[50],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            trade['symbol']?.toString() ?? trade['asset_id']?.toString() ?? 'N/A',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: isDarkTheme ? Colors.white : Colors.black,
                                            ),
                                          ),
                                          Text(
                                            trade['side']?.toString()?.toUpperCase() ?? 'N/A',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: trade['side']?.toString()?.toLowerCase() == 'buy'
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            trade['quantity']?.toString() ?? 'N/A',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: isDarkTheme ? Colors.white : Colors.black,
                                            ),
                                          ),
                                          Text(
                                            '\$${trade['price']?.toString() ?? 'N/A'}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '\$${((double.tryParse(trade['quantity']?.toString() ?? '0') ?? 0.0) * (double.tryParse(trade['price']?.toString() ?? '0') ?? 0.0)).toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: isDarkTheme ? Colors.white : Colors.black,
                                            ),
                                          ),
                                          Text(
                                            trade['timestamp']?.toString() ?? trade['executed_at']?.toString() ?? 'N/A',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                            ),
                                          ),
                                        ],
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

  /// Build empty orders table structure (shown on error)
  Widget _buildOrdersTableStructure(bool isDarkTheme) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDarkTheme ? const Color(0xFF1e1e1e) : Colors.white,
        border: Border.all(
          color: isDarkTheme ? Colors.grey[600]! : Colors.grey[400]!,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Table header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: isDarkTheme ? const Color(0xFF2d2d2d) : Colors.grey[200],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Order ID',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDarkTheme ? Colors.white : Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Participant Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDarkTheme ? Colors.white : Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Symbol',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDarkTheme ? Colors.white : Colors.black,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Quantity',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDarkTheme ? Colors.white : Colors.black,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Price',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDarkTheme ? Colors.white : Colors.black,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
          // Empty state
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Orders will be displayed here once loaded',
              style: TextStyle(
                color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                fontSize: 14,
              ),
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
            child: RefreshIndicator(
              onRefresh: _fetchActivityData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Orders table (top)
                    _buildOrdersTable(isDarkTheme),
                    
                    const SizedBox(height: 24),
                    
                    // Trades table (bottom)
                    _buildTradesTable(isDarkTheme),
                  ],
                ),
              ),
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