import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/theme_service.dart';
import '../services/real_grpc_client.dart';
import '../services/database_helper.dart';
import '../utils/connectivity_checker.dart';
import '../config/ui_constants.dart';
import 'instruments_page.dart';
import 'trading_page.dart';
import 'Cash_management_page.dart';
import 'activity_page.dart';
import 'profile_page.dart';
import 'users_admin_page.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  Map<String, dynamic>? _accountListData;
  Map<String, dynamic>? _portfolioData;
  bool _isLoadingPortfolio = false;
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  
  @override
  void initState() {
    super.initState();

    // Defer initialization to avoid blocking the UI
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializePortfolioData();
    });
  }

  Future<void> _initializePortfolioData() async {
    if (!mounted) return;

    // Check connectivity in parallel with data fetch (non-blocking)
    ConnectivityChecker.checkAndShowErrorIfNeeded(context, 'Portfolio');

    // Start fetching data immediately
    await _fetchPortfolioData();
  }

  Future<void> _fetchAccountList() async {
    try {
      // Fetch account list with comprehensive crash protection
      final accountListResponse = await realGrpcClient.getAccountList(
        pageNumber: 0,
        pageSize: 0,
        accountIdRegex: null, // Can be modified to filter accounts
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

        if (accountListResponse['success'] == true) {
          // Auto-sync server accounts with local users
          final accounts = accountListResponse['output']['accounts'] as List<dynamic>;
          await _syncServerAccountsWithLocalUsers(accounts);
        }
      }
    } catch (e) {
      print('❌ Error in _fetchAccountList: $e');
    }
  }

  Future<void> _fetchPortfolioData() async {
    if (!mounted) return;

    setState(() {
      _isLoadingPortfolio = true;
    });

    try {
      // Get the current logged-in username from AuthService
      final authService = Provider.of<AuthService>(context, listen: false);
      final currentUsername = authService.username;

      print('🔍 Looking for account belonging to logged-in user: $currentUsername');

      // Fetch account list if not already loaded
      if (_accountListData == null) {
        await _fetchAccountList();
      }

      // Find account ID for the logged-in user
      String? accountId;
      if (_accountListData != null && _accountListData!['success'] == true) {
        final accounts = _accountListData!['output']['accounts'] as List<dynamic>;
        accountId = _findUserAccount(accounts, currentUsername);
      }

      if (accountId == null || accountId.isEmpty) {
        print('❌ Portfolio: No account found for user: $currentUsername');
        if (mounted) {
          setState(() {
            _isLoadingPortfolio = false;
            _portfolioData = {
              'success': false,
              'output': {
                'error': 'No account found',
                'message': 'No account found for user $currentUsername',
              },
            };
          });
        }
        return;
      }

      print('✅ Found account ID: "$accountId" for user: $currentUsername');

      // Fetch portfolio data
      final portfolioResponse = await realGrpcClient.getAccountMarketPortfolio(
        accountId: accountId,
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => {
          'input': {'proposed_execution_id': 'timeout'},
          'output': {'error': 'Request timed out', 'message': 'Portfolio request timed out'},
          'requestTime': (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString(),
          'serverType': 'timeout',
          'success': false,
        },
      );

      if (mounted) {
        setState(() {
          _portfolioData = portfolioResponse;
          _isLoadingPortfolio = false;
        });
      }
    } catch (e) {
      print('❌ Error fetching portfolio: $e');
      if (mounted) {
        setState(() {
          _isLoadingPortfolio = false;
          _portfolioData = {
            'success': false,
            'output': {
              'error': 'Failed to load portfolio',
              'message': e.toString(),
            },
          };
        });
      }
    }
  }

  /// Find the account that belongs to the logged-in user
  String? _findUserAccount(List<dynamic> accounts, String username) {
    for (final account in accounts) {
      final accountMap = account as Map<String, dynamic>;
      final externalId = accountMap['external_id'] ?? accountMap['externalId'] ?? accountMap['externalAccountId'] ?? '';
      final accountId = accountMap['id'] ?? accountMap['iid'] ?? '';
      
      // Try to match the account with the logged-in user
      // The external_id might match the username, or contain the username
      if (externalId.toLowerCase().contains(username.toLowerCase()) || 
          externalId == username ||
          accountId.toLowerCase().contains(username.toLowerCase())) {
        print('✅ Found matching account for user $username: ID=$accountId, ExternalID=$externalId');
        return accountId;
      }
    }
    
    // If no exact match found for the logged-in user, return empty string
    // Don't use fallback accounts for users that don't exist on the server
    print('❌ No account found for user $username on the server');
    return '';
  }

  /// Automatically create local users for server accounts that don't exist locally
  Future<void> _syncServerAccountsWithLocalUsers(List<dynamic> accounts) async {
    try {
      print('🔄 Syncing server accounts with local users...');
      int createdCount = 0;
      
      for (final account in accounts) {
        final accountMap = account as Map<String, dynamic>;
        final externalId = accountMap['external_id'] ?? accountMap['externalId'] ?? '';
        
        if (externalId.isNotEmpty) {
          // Check if user already exists locally
          final userExists = await _databaseHelper.isUsernameExists(externalId);
          
          if (!userExists) {
            // Create user with external_id as username and password "111111"
            print('👤 Creating local user for server account: $externalId');
            final success = await _databaseHelper.createUser(externalId, '111111');
            
            if (success) {
              createdCount++;
              print('✅ Successfully created local user: $externalId');
            } else {
              print('❌ Failed to create local user: $externalId');
            }
          } else {
            print('ℹ️ Local user already exists: $externalId');
          }
        }
      }
      
      if (createdCount > 0) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('✅ Created $createdCount new local users from server accounts'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
            ),
          );
        }
        print('✅ Auto-sync completed: $createdCount users created');
      } else {
        print('ℹ️ Auto-sync completed: No new users needed');
      }
    } catch (e) {
      print('❌ Error syncing server accounts with local users: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Failed to sync server accounts: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final themeService = Provider.of<ThemeService>(context);
    final _isDarkTheme = themeService.isDarkTheme; // Use theme from service
    
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
                padding: UIConstants.paddingComfortable,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Portfolio Holdings
                    Expanded(
                      child: Container(
                        padding: UIConstants.paddingComfortable,
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
                              'Instruments Holdings',
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeLg,
                                fontWeight: UIConstants.fontWeightMedium,
                                color: _isDarkTheme ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: UIConstants.spacingMd),
                            Expanded(
                              child: _buildPortfolioContent(themeService, _isDarkTheme),
                            ),
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
                              fontWeight: UIConstants.fontWeightNormal,
                              height: 0.8,
                            ),
                          ),
                          TextSpan(
                            text: 'Broker',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: UIConstants.fontWeightMedium,
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
              // Instruments Button
              _NavigationButton(
                label: 'Instruments',
                destination: const InstrumentsPage(),
              ),

              // Portfolio Button (current page)
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  height: 36,
                  padding: UIConstants.paddingCompact,
                  decoration: BoxDecoration(
                    color: isDarkTheme ? Colors.black : Colors.grey[100],
                    border: Border(
                      top: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
                      left: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
                      right: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(UIConstants.borderRadiusMd),
                      topRight: Radius.circular(UIConstants.borderRadiusMd),
                    ),
                  ),
                  child: Text(
                    'Portfolio',
                    style: TextStyle(
                      fontSize: UIConstants.fontSizeBody,
                      fontWeight: UIConstants.fontWeightMedium,
                      color: isDarkTheme ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),

              // Trading Button
              _NavigationButton(
                label: 'Trading',
                destination: const TradingPage(),
              ),

              // Activity Button
              _NavigationButton(
                label: 'Activity',
                destination: const ActivityPage(),
              ),

              // Cash Management Button
              _NavigationButton(
                label: 'Cash Management',
                destination: const CashManagementPage(),
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
                const PopupMenuItem<String>(
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
                  const PopupMenuItem<String>(
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
                    fontSize: UIConstants.fontSizeBody,
                    fontWeight: UIConstants.fontWeightNormal,
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
              padding: UIConstants.paddingStandard,
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
                print('🚪 Portfolio page logout initiated...');
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
            padding: UIConstants.paddingStandard,
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioContent(ThemeService themeService, bool isDarkTheme) {
    if (_isLoadingPortfolio) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            SizedBox(height: UIConstants.spacingMd),
            Text(
              'Loading portfolio data...',
              style: TextStyle(
                fontSize: UIConstants.fontSizeMd,
                color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    if (_portfolioData == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.pie_chart,
              size: 48,
              color: isDarkTheme ? Colors.grey[600] : Colors.grey[400],
            ),
            SizedBox(height: UIConstants.spacingMd),
            Text(
              'No portfolio data available',
              style: TextStyle(
                fontSize: UIConstants.fontSizeLg,
                fontWeight: UIConstants.fontWeightMedium,
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      );
    }

    if (_portfolioData!['success'] != true) {
      final error = _portfolioData!['output']['error'] ?? 'Unknown error';
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: UIConstants.spacingMd),
            Text(
              'Failed to load portfolio',
              style: TextStyle(
                fontSize: UIConstants.fontSizeMd,
                fontWeight: UIConstants.fontWeightMedium,
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: UIConstants.spacingSm),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: UIConstants.fontSizeBody,
                color: Colors.red,
              ),
            ),
          ],
        ),
      );
    }

    // Display real portfolio data
    final portfolioOutput = _portfolioData!['output'] as Map<String, dynamic>;
    
    // Extract portfolio holdings from the proto response structure
    final portfolio = portfolioOutput['portfolio'] as Map<String, dynamic>? ?? {};
    final holdings = portfolio['holdings'] as Map<String, dynamic>? ?? {};

    if (holdings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox,
              size: 64,
              color: isDarkTheme ? Colors.grey[600] : Colors.grey[400],
            ),
            const SizedBox(height: UIConstants.spacingMd),
            Text(
              'No holdings found',
              style: TextStyle(
                fontSize: UIConstants.fontSizeMd,
                fontWeight: UIConstants.fontWeightMedium,
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: UIConstants.spacingSm),
            Text(
              'Your portfolio appears to be empty',
              style: TextStyle(
                fontSize: UIConstants.fontSizeBody,
                color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    final assetList = holdings.entries.toList();

    return ListView.builder(
      itemCount: assetList.length,
      itemBuilder: (context, index) {
        final entry = assetList[index];
        final assetId = entry.key;
        final holdingData = entry.value as Map<String, dynamic>? ?? {};
        final balance = holdingData['totalUnits']?.toString() ?? '0';
        
        return Padding(
          padding: EdgeInsets.only(bottom: index < assetList.length - 1 ? 16 : 0),
          child: _buildHoldingItem(
            themeService,
            assetId,
            assetId, // Use asset ID as name for now
            balance,
            balance, // Available balance same as total for now
            '0', // Locked balance - not available in current data
            'N/A', // Price - not available in current data
            'N/A', // Price high - not available in current data
            '0%', // Change percentage - not available in current data
            'N/A', // Market value - not available in current data
            _getColorForAsset(assetId),
          ),
        );
      },
    );
  }

  Color _getColorForAsset(String assetId) {
    // Return different colors for different assets
    switch (assetId.toUpperCase()) {
      case 'ETH':
        return const Color(0xFF627EEA);
      case 'OXC':
        return const Color(0xFF85BB65);
      case 'XRP':
        return const Color(0xFF23292F);
      default:
        return const Color(0xFF6B73FF);
    }
  }

  Widget _buildHoldingItem(
    ThemeService themeService,
    String symbol,
    String name,
    String total,
    String available,
    String inOrder,
    String high,
    String low,
    String change,
    String marketValue,
    Color iconColor,
  ) {
    final _isDarkTheme = themeService.isDarkTheme;
    return Container(
      padding: UIConstants.paddingStandard,
      decoration: BoxDecoration(
        color: _isDarkTheme ? const Color(0xFF404040) : Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _isDarkTheme ? Colors.grey[700]! : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                symbol.substring(0, 2).toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: UIConstants.fontSizeBody,
                  fontWeight: UIConstants.fontWeightMedium,
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Symbol and Name
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  symbol,
                  style: TextStyle(
                    fontSize: UIConstants.fontSizeBody,
                    fontWeight: UIConstants.fontWeightMedium,
                    color: _isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: UIConstants.fontSizeSm,
                    color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          
          // Holdings Info
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Total: $total',
                      style: TextStyle(
                        fontSize: UIConstants.fontSizeSm,
                        color: _isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'SYMBOL',
                          style: TextStyle(
                            fontSize: UIConstants.fontSizeXs,
                            color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          symbol,
                          style: TextStyle(
                            fontSize: UIConstants.fontSizeXs,
                            fontWeight: UIConstants.fontWeightMedium,
                            color: _isDarkTheme ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          'VOL.',
                          style: TextStyle(
                            fontSize: UIConstants.fontSizeXs,
                            color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          total,
                          style: TextStyle(
                            fontSize: UIConstants.fontSizeXs,
                            fontWeight: UIConstants.fontWeightMedium,
                            color: _isDarkTheme ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Available: $available',
                      style: TextStyle(
                        fontSize: UIConstants.fontSizeSm,
                        color: _isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'HIGH',
                          style: TextStyle(
                            fontSize: UIConstants.fontSizeXs,
                            color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$high \$',
                          style: TextStyle(
                            fontSize: UIConstants.fontSizeXs,
                            fontWeight: UIConstants.fontWeightMedium,
                            color: _isDarkTheme ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          'LOW',
                          style: TextStyle(
                            fontSize: UIConstants.fontSizeXs,
                            color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$low \$',
                          style: TextStyle(
                            fontSize: UIConstants.fontSizeXs,
                            fontWeight: UIConstants.fontWeightMedium,
                            color: _isDarkTheme ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'In order: $inOrder',
                      style: TextStyle(
                        fontSize: UIConstants.fontSizeSm,
                        color: _isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'CHANGE',
                          style: TextStyle(
                            fontSize: UIConstants.fontSizeXs,
                            color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          change,
                          style: TextStyle(
                            fontSize: UIConstants.fontSizeXs,
                            fontWeight: UIConstants.fontWeightMedium,
                            color: _isDarkTheme ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          'MKT VALUE',
                          style: TextStyle(
                            fontSize: UIConstants.fontSizeXs,
                            color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$marketValue \$',
                          style: TextStyle(
                            fontSize: UIConstants.fontSizeXs,
                            fontWeight: UIConstants.fontWeightMedium,
                            color: _isDarkTheme ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}

/// Reusable navigation button widget for inactive tabs
class _NavigationButton extends StatelessWidget {
  final String label;
  final Widget destination;

  const _NavigationButton({
    required this.label,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => destination,
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(UIConstants.borderRadiusMd),
            topRight: Radius.circular(UIConstants.borderRadiusMd),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(
              height: 32,
              padding: UIConstants.paddingCompact,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                border: Border(
                  top: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
                  left: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
                  right: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
                  bottom: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(UIConstants.borderRadiusMd),
                  topRight: Radius.circular(UIConstants.borderRadiusMd),
                ),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: UIConstants.fontSizeBody,
                  fontWeight: UIConstants.fontWeightNormal,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
