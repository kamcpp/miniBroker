import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/theme_service.dart';
import '../services/real_grpc_client.dart';
import '../utils/connectivity_checker.dart';
import 'trading_page.dart';
import 'portfolio_page.dart';
import 'activity_page.dart';
import 'profile_page.dart';
import 'users_admin_page.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  Map<String, dynamic>? _accountListData;
  bool _isLoadingCashHoldings = false;
  String _buyingPower = '0';
  String? _cachedAccountId;

  // Supported currencies data - now includes asset_id for cash holdings
  List<Map<String, String>> _supportedCurrencies = [];
  Map<String, String> _selectedCurrency = {};
  bool _isLoadingSupportedCurrencies = false;

  @override
  void initState() {
    super.initState();

    // Check server connectivity when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ConnectivityChecker.checkAndShowErrorIfNeeded(context, 'Balance');
    });

    // Initialize data
    _initializeBalanceData();
  }

  Future<void> _initializeBalanceData() async {
    if (mounted) {
      _fetchSupportedCurrencies();
    }
  }

  // Fetch market supported currencies using GetMarketSupportedCurrencies
  Future<void> _fetchSupportedCurrencies() async {
    try {
      if (!realGrpcClient.isConnected) {
        print('❌ Not connected to real gRPC server for market supported currencies');
        return;
      }

      setState(() {
        _isLoadingSupportedCurrencies = true;
      });

      // Use default market_id - this should ideally come from configuration or user selection
      final result = await realGrpcClient.getMarketSupportedCurrencies(
        marketId: '', // Empty string for default/all markets
      );

      if (result['success'] == true) {
        final output = result['output'] as Map<String, dynamic>;
        final currencies = output['currencies'] as List<dynamic>? ?? [];

        final currencyData = currencies.map((currency) {
          final currencyMap = currency as Map<String, dynamic>;

          // Extract currency value from currencies > identifiers > ids[0] > value
          String currencyValue = '';
          final identifiers = currencyMap['identifiers'] as List<dynamic>? ?? [];
          if (identifiers.isNotEmpty) {
            final firstIdentifier = identifiers.first as Map<String, dynamic>? ?? {};
            final ids = firstIdentifier['ids'] as List<dynamic>? ?? [];
            if (ids.isNotEmpty) {
              final firstId = ids.first as Map<String, dynamic>? ?? {};
              currencyValue = firstId['value']?.toString() ?? '';
            }
          }

          // Use currency value as both asset_id and symbol for now
          return {
            'asset_id': currencyValue, // Using currency value as asset_id
            'code': currencyValue,
            'symbol': currencyValue,
            'display': currencyValue, // Show currencies > identifiers > ids[0] > value
          };
        }).where((currency) => currency['code']!.isNotEmpty).toList();

        setState(() {
          _supportedCurrencies = currencyData;
          if (_selectedCurrency.isEmpty && _supportedCurrencies.isNotEmpty) {
            _selectedCurrency = _supportedCurrencies.first;
            // Fetch cash holdings for the initially selected currency using asset_id
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _fetchCashHoldingsForCurrency(_selectedCurrency['asset_id']!);
            });
          }
          _isLoadingSupportedCurrencies = false;
        });

        print('✅ Loaded ${_supportedCurrencies.length} market supported currencies');
      } else {
        print('❌ Failed to fetch market supported currencies: ${result['output']}');
        setState(() {
          _isLoadingSupportedCurrencies = false;
        });
      }
    } catch (e) {
      print('❌ Error fetching market supported currencies: $e');
      setState(() {
        _isLoadingSupportedCurrencies = false;
      });
    }
  }

  // Fetch cash holdings - copied and adapted from trading page
  Future<void> _fetchCashHoldings() async {
    try {
      if (!realGrpcClient.isConnected) {
        print('❌ Not connected to real gRPC server for cash holdings');
        return;
      }

      // Check if we already have cached account ID
      if (_cachedAccountId != null &&
          _cachedAccountId!.isNotEmpty &&
          _selectedCurrency.isNotEmpty) {
        await _fetchCashHoldingsForAccount(_cachedAccountId!);
        return;
      }

      setState(() {
        _isLoadingCashHoldings = true;
      });

      // Get the current logged-in username from AuthService
      final authService = Provider.of<AuthService>(context, listen: false);
      final currentUsername = authService.username;

      print('🔍 Looking for account belonging to logged-in user: $currentUsername');

      // First, get the account ID that belongs to the logged-in user
      String? accountId;
      if (_accountListData != null && _accountListData!['success'] == true) {
        final accounts = _accountListData!['output']['accounts'] as List<dynamic>;
        accountId = _findUserAccount(accounts, currentUsername);
      } else {
        // Fetch account list first to get account ID
        await _fetchAccountList();
        if (_accountListData != null && _accountListData!['success'] == true) {
          final accounts = _accountListData!['output']['accounts'] as List<dynamic>;
          accountId = _findUserAccount(accounts, currentUsername);
        }
      }

      print('🔍 Final account ID selected: "$accountId" for user: $currentUsername');
      if (accountId == null || accountId.isEmpty) {
        setState(() {
          _isLoadingCashHoldings = false;
          _buyingPower = '0';
        });
        print('❌ No account ID found for user: $currentUsername');
        return;
      }

      // Cache the account ID for the entire session
      _cachedAccountId = accountId;
      print('💾 Cached account ID: $_cachedAccountId for session');

      await _fetchCashHoldingsForAccount(accountId);

    } catch (e) {
      // Ultimate crash protection
      try {
        if (mounted) {
          setState(() {
            _isLoadingCashHoldings = false;
            if (_buyingPower == '0' || _buyingPower.isEmpty) {
              _buyingPower = '0';
            }
          });
        }
        print('❌ Failed to fetch cash holdings: ${e.toString()}');
      } catch (innerE) {
        print('❌ Critical error in _fetchCashHoldings: $e, UI update failed: $innerE');
      }
    }
  }

  Future<void> _fetchAccountList() async {
    try {
      final accountListResponse = await realGrpcClient.getAccountList(
        pageNumber: 0,
        pageSize: 0,
        accountIdRegex: null,
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => {
          'input': {'ref_request_id': 'timeout'},
          'output': {'error': 'Request timed out', 'message': 'Account list request timed out after 10 seconds'},
          'requestTime': (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString(),
          'serverType': 'timeout',
          'success': false,
        },
      );

      if (mounted) {
        setState(() {
          _accountListData = accountListResponse;
        });
      }
    } catch (e) {
      print('❌ Error in _fetchAccountList: $e');
    }
  }

  String? _findUserAccount(List<dynamic> accounts, String username) {
    for (final account in accounts) {
      final accountMap = account as Map<String, dynamic>;
      final externalId = accountMap['external_id'] ?? accountMap['externalId'] ?? accountMap['externalAccountId'] ?? '';
      final accountId = accountMap['id'] ?? accountMap['iid'] ?? '';

      if (externalId.toLowerCase().contains(username.toLowerCase()) ||
          externalId == username ||
          accountId.toLowerCase().contains(username.toLowerCase())) {
        print('✅ Found matching account for user $username: ID=$accountId, ExternalID=$externalId');
        return accountId;
      }
    }

    print('❌ No account found for user $username on the server');
    return '';
  }

  Future<void> _fetchCashHoldingsForAccount(String accountId) async {
    try {
      setState(() {
        _isLoadingCashHoldings = true;
      });

      // Get the current selected currency's asset_id
      final selectedAssetId = _selectedCurrency['asset_id'];
      final cashHoldingsResponse = await realGrpcClient.getAccountCashHoldings(
        accountId: accountId,
        cashAssetIds: selectedAssetId != null ? [selectedAssetId] : [], // Use specific asset_id
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () => {
          'input': {'ref_request_id': 'timeout'},
          'output': {'error': 'Request timed out', 'message': 'Cash holdings request timed out after 15 seconds'},
          'requestTime': (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString(),
          'serverType': 'timeout',
          'success': false,
        },
      );

      if (mounted) {
        setState(() {
          _isLoadingCashHoldings = false;
        });

        if (cashHoldingsResponse['success'] == true) {
          final output = cashHoldingsResponse['output'] as Map<String, dynamic>;
          final cashPortfolio = output['cashPortfolio'] as Map<String, dynamic>? ?? {};
          final holdings = cashPortfolio['holdings'] as Map<String, dynamic>? ?? {};
          final currencyCode = _selectedCurrency['code'] ?? '';
          final assetHolding = holdings[currencyCode] as Map<String, dynamic>? ?? {};
          final assetBalance = assetHolding['totalUnits']?.toString() ?? '0';

          setState(() {
            _buyingPower = assetBalance;
          });

          print('✅ Cash holdings loaded successfully! Currency $currencyCode balance: $assetBalance');
        } else {
          final output = cashHoldingsResponse['output'] as Map<String, dynamic>;
          setState(() {
            _buyingPower = '0';
          });
          print('❌ Failed to fetch cash holdings: ${output['error'] ?? 'Unknown error'}');
        }
      }
    } catch (e) {
      try {
        if (mounted) {
          setState(() {
            _isLoadingCashHoldings = false;
            _buyingPower = '0';
          });
        }
        print('❌ Failed to fetch cash holdings: ${e.toString()}');
      } catch (innerE) {
        print('❌ Critical error in _fetchCashHoldings: $e, UI update failed: $innerE');
      }
    }
  }

  Future<void> _fetchCashHoldingsForCurrency(String assetId) async {
    print('🔍 _fetchCashHoldingsForCurrency called with assetId: $assetId');
    if (_cachedAccountId == null || _cachedAccountId!.isEmpty) {
      print('❌ No cached account ID available for currency fetch');
      return;
    }

    try {
      setState(() {
        _isLoadingCashHoldings = true;
      });

      final cashHoldingsResponse = await realGrpcClient.getAccountCashHoldings(
        accountId: _cachedAccountId!,
        cashAssetIds: [assetId], // Use the specific asset_id
      ).timeout(const Duration(seconds: 15));

      print('🔍 Currency fetch response: ${cashHoldingsResponse['output']}');

      if (mounted) {
        setState(() {
          _isLoadingCashHoldings = false;
        });

        if (cashHoldingsResponse['success'] == true) {
          final output = cashHoldingsResponse['output'] as Map<String, dynamic>;
          final cashPortfolio = output['cashPortfolio'] as Map<String, dynamic>? ?? {};
          final holdings = cashPortfolio['holdings'] as Map<String, dynamic>? ?? {};

          // Extract currency code from asset ID or use it directly
          String currencyCode = assetId;
          if (currencyCode.startsWith('cash_')) {
            currencyCode = currencyCode.replaceFirst('cash_', '');
          }

          print('🔍 Looking for currency code: $currencyCode in holdings: ${holdings.keys}');
          print('🔍 Holdings content: $holdings');

          // Try to find the holding by currency code
          Map<String, dynamic>? assetHolding;
          String assetBalance = '0';

          // First try direct lookup
          if (holdings.containsKey(currencyCode)) {
            assetHolding = holdings[currencyCode] as Map<String, dynamic>?;
            print('🔍 Direct lookup found: $assetHolding');
          } else {
            // If not found, try to find any holding that matches
            for (String key in holdings.keys) {
              if (key.toUpperCase() == currencyCode.toUpperCase()) {
                assetHolding = holdings[key] as Map<String, dynamic>?;
                print('🔍 Case-insensitive lookup found: $assetHolding');
                break;
              }
            }
          }

          if (assetHolding != null) {
            final totalUnits = assetHolding['totalUnits'];
            print('🔍 totalUnits raw value: $totalUnits (type: ${totalUnits.runtimeType})');
            assetBalance = totalUnits?.toString() ?? '0';
            print('🔍 Converted to string: $assetBalance');
          }

          print('🔍 Found holding: $assetHolding, extracted balance: $assetBalance');

          setState(() {
            _buyingPower = assetBalance;
          });

          print('✅ Updated buying power for $currencyCode: $assetBalance');
        } else {
          print('❌ Failed to fetch cash holdings for asset $assetId: ${cashHoldingsResponse['output']}');
          setState(() {
            _buyingPower = '0';
          });
        }
      }
    } catch (e) {
      print('❌ Error fetching cash holdings for asset $assetId: $e');
      setState(() {
        _buyingPower = '0';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final themeService = Provider.of<ThemeService>(context);
    final _isDarkTheme = themeService.isDarkTheme;

    return Theme(
      data: _isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        backgroundColor: _isDarkTheme ? const Color(0x000000) : Colors.grey[100],
        body: Column(
          children: [
            // Header Section
            _buildHeader(authService, themeService),

            // Main Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Balance Section
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: _isDarkTheme ? const Color(0xFF2A2A2A) : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Balance',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: _isDarkTheme ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildBalanceContent(themeService, _isDarkTheme),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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

                // Activity Button
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const ActivityPage(),
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
                            'Activity',
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

              // Balance Button (current page)
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  height: 55,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isDarkTheme ? Colors.black : Colors.grey[100],
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
                    'Balance',
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
                print('🚪 Balance page logout initiated...');
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

  Widget _buildBalanceContent(ThemeService themeService, bool isDarkTheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      height:220,
      decoration: BoxDecoration(
        color: isDarkTheme ? const Color(0xFF404040) : Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDarkTheme ? Colors.grey[700]! : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        // Currency Dropdown
        Row(
          children: [
            Text(
              'Currency: ',
              style: TextStyle(
                fontSize: 14,
                color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
            const SizedBox(width: 30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              width: 180,
              height: 40,
              decoration: BoxDecoration(
                color: isDarkTheme ? const Color(0xFF505050) : Colors.white, // Enhanced background color
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDarkTheme ? Colors.grey[700]! : Colors.grey[200]!,
                  width: 1,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Map<String, String>>(
                  value: _supportedCurrencies.isEmpty
                      ? null
                      : (_supportedCurrencies.any((currency) => currency['code'] == _selectedCurrency['code'])
                          ? _selectedCurrency
                          : _supportedCurrencies.isNotEmpty ? _supportedCurrencies.first : null),
                  isExpanded: true, // Expand to fill the fixed width container
                  onChanged: _supportedCurrencies.isEmpty ? null : (Map<String, String>? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedCurrency = newValue;
                      });
                      _fetchCashHoldingsForCurrency(newValue['asset_id']!);
                    }
                  },
                  dropdownColor: isDarkTheme ? const Color(0xFF1e1e1e) : Colors.white,
                  style: TextStyle(
                    color: isDarkTheme ? Colors.white : Colors.black,
                    fontSize: 12, // Smaller font for more compact appearance
                  ),
                  items: _supportedCurrencies.isEmpty
                      ? [DropdownMenuItem<Map<String, String>>(
                          value: {'code': '', 'symbol': '', 'display': ''},
                          child: Text(_isLoadingSupportedCurrencies ? 'Loading currencies...' : 'No currencies available'),
                        )]
                      : _supportedCurrencies.map<DropdownMenuItem<Map<String, String>>>((currency) {
                          return DropdownMenuItem<Map<String, String>>(
                            value: currency,
                            child: Text(currency['display'] ?? currency['code']!),
                          );
                        }).toList(),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 30),

        // Total Balance
        Row(
          children: [
            Text(
              'Total Balance: ',
              style: TextStyle(
                fontSize: 14, // Same as Currency title
                color: isDarkTheme ? Colors.grey[400] : Colors.grey[600], // Same as Currency title
              ),
            ),
            const SizedBox(width: 10),
            _isLoadingCashHoldings
                ? SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isDarkTheme ? Colors.white : Colors.black,
                      ),
                    ),
                  )
                : Text(
                    '$_buyingPower ${_selectedCurrency['symbol'] ?? ''}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isDarkTheme ? Colors.white : Colors.black,
                    ),
                  ),
          ],
        ),

        const SizedBox(height: 40),

        // Action Buttons
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Add Cash functionality
                  _showAddCashDialog();
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  'Add Cash',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Withdraw Cash functionality
                  _showWithdrawCashDialog();
                },
                icon: const Icon(Icons.remove, color: Colors.white),
                label: const Text(
                  'Withdraw Cash',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF4081),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
        ],
      ),
    );
  }

  void _showAddCashDialog() {
    final themeService = Provider.of<ThemeService>(context, listen: false);
    final isDarkTheme = themeService.isDarkTheme;
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDarkTheme ? const Color(0xFF2A2A2A) : Colors.white,
          title: Text(
            'Add Cash',
            style: TextStyle(
              color: isDarkTheme ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter amount to add:',
                style: TextStyle(
                  color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '0.00',
                  suffixText: _selectedCurrency['symbol'] ?? '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: isDarkTheme ? Colors.grey[400] : Colors.grey[200],
                ),
                style: TextStyle(
                  color: isDarkTheme ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Here you would implement the actual add cash functionality
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Add Cash functionality not yet implemented'),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
              ),
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showWithdrawCashDialog() {
    final themeService = Provider.of<ThemeService>(context, listen: false);
    final isDarkTheme = themeService.isDarkTheme;
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDarkTheme ? const Color(0xFF2A2A2A) : Colors.white,
          title: Text(
            'Withdraw Cash',
            style: TextStyle(
              color: isDarkTheme ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter amount to withdraw:',
                style: TextStyle(
                  color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '0.00',
                  suffixText: _selectedCurrency['symbol'] ?? '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: isDarkTheme ? Colors.grey[400] : Colors.grey[200],
                ),
                style: TextStyle(
                  color: isDarkTheme ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Available: $_buyingPower ${_selectedCurrency['symbol'] ?? ''}',
                style: TextStyle(
                  color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Here you would implement the actual withdraw cash functionality
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Withdraw Cash functionality not yet implemented'),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF4081),
              ),
              child: const Text(
                'Withdraw',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}