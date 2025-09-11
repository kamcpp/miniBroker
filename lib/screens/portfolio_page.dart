import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/theme_service.dart';
import '../services/real_grpc_client.dart';
import '../services/database_helper.dart';
import 'trading_page.dart';
import 'activity_page.dart';
import 'profile_page.dart';
import 'users_admin_page.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  String _connectionStatus = 'Checking...';
  Color _connectionStatusColor = Colors.orange;
  String _participantInfo = 'Loading...';
  Map<String, dynamic>? _accountListData;
  bool _isLoadingAccounts = false;
  bool _isPingInProgress = false;
  Map<String, dynamic>? _portfolioData;
  bool _isLoadingPortfolio = false;
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  
  @override
  void initState() {
    super.initState();
    _checkGrpcConnection();
    // Automatically fetch portfolio data when page loads
    _initializePortfolioData();
  }

  Future<void> _initializePortfolioData() async {
    // Small delay to ensure connection check completes first
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      _fetchPortfolioData();
    }
  }

  Future<void> _checkGrpcConnection() async {
    try {
      if (realGrpcClient.isConnected) {
        setState(() {
          _connectionStatus = 'Connected to real simprtagent server ${realGrpcClient.currentHost}:${realGrpcClient.currentPort}';
          _connectionStatusColor = Colors.green;
        });
        
        // Try to get participant info from real server
        try {
          final participantInfo = await realGrpcClient.getParticipantInfo();
          final output = participantInfo['output'] as Map<String, dynamic>;
          setState(() {
            _participantInfo = 'Real Participant: ${output['identifier']} (${output['status']})';
          });
        } catch (e) {
          setState(() {
            _participantInfo = 'Connected to real server but unable to get participant info';
          });
        }
      } else {
        setState(() {
          _connectionStatus = 'Not connected to real simprtagent server';
          _connectionStatusColor = Colors.red;
          _participantInfo = 'N/A - Check if simprtagent is running';
        });
      }
    } catch (e) {
      setState(() {
        _connectionStatus = 'Real server connection error: $e';
        _connectionStatusColor = Colors.red;
        _participantInfo = 'N/A';
      });
    }
  }

  Future<void> _testPingConnection() async {
    // Prevent concurrent ping operations
    if (_isPingInProgress) {
      print('⚠️ Ping already in progress, ignoring button press');
      return;
    }

    _isPingInProgress = true;
    try {
      setState(() {
        _connectionStatus = 'Testing real server connection...';
        _connectionStatusColor = Colors.orange;
      });

      // Test ping with real server - comprehensive crash protection
      final pingResponse = await realGrpcClient.ping(
        stringToBePonged: 'Test from Flutter Portfolio Page',
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => {
          'input': {'ref_request_id': 'timeout', 'string_to_be_ponged': 'Test from Flutter Portfolio Page'},
          'output': {'error': 'Request timed out', 'message': 'Ping request timed out after 10 seconds'},
          'requestTime': DateTime.now().toIso8601String(),
          'serverType': 'timeout',
          'success': false,
        },
      );

      if (mounted) {
        final output = pingResponse['output'] as Map<String, dynamic>;
        if (pingResponse['success'] == true) {
          setState(() {
            _connectionStatus = 'Real server ping successful! Response: "${output['pong_string']}"';
            _connectionStatusColor = Colors.green;
          });

        } else {
          setState(() {
            _connectionStatus = 'Real server ping failed: ${output['error'] ?? 'Unknown error'}';
            _connectionStatusColor = Colors.red;
          });
        }
      }
    } catch (e) {
      // Ultimate crash protection - never let this method throw
      try {
        if (mounted) {
          setState(() {
            _connectionStatus = 'Ping failed with error: ${e.toString()}';
            _connectionStatusColor = Colors.red;
          });
        }
      } catch (innerE) {
        // Even UI updates can fail - print to console as last resort
        print('❌ Critical error in _testPingConnection: $e, UI update failed: $innerE');
      }
    } finally {
      _isPingInProgress = false;
    }
  }

  Future<void> _fetchAccountList() async {
    try {
      setState(() {
        _isLoadingAccounts = true;
      });

      // Fetch account list with comprehensive crash protection
      final accountListResponse = await realGrpcClient.getAccountList(
        pageNumber: 1,
        pageSize: 10,
        accountIdRegex: null, // Can be modified to filter accounts
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => {
          'input': {'ref_request_id': 'timeout'},
          'output': {'error': 'Request timed out', 'message': 'Account list request timed out after 10 seconds'},
          'requestTime': DateTime.now().toIso8601String(),
          'serverType': 'timeout',
          'success': false,
        },
      );

      if (mounted) {
        setState(() {
          _accountListData = accountListResponse;
          _isLoadingAccounts = false;
        });

        if (accountListResponse['success'] == true) {
          // Auto-sync server accounts with local users
          final accounts = accountListResponse['output']['accounts'] as List<dynamic>;
          await _syncServerAccountsWithLocalUsers(accounts);
          
        } else {
          final output = accountListResponse['output'] as Map<String, dynamic>;
          setState(() {
            _connectionStatus = 'Account list fetch failed: ${output['error'] ?? 'Unknown error'}';
            _connectionStatusColor = Colors.red;
          });

        }
      }
    } catch (e) {
      // Ultimate crash protection - never let this method throw
      try {
        if (mounted) {
          setState(() {
            _isLoadingAccounts = false;
            _connectionStatus = 'Account list fetch failed with error: ${e.toString()}';
            _connectionStatusColor = Colors.red;
          });
        }
      } catch (innerE) {
        // Even UI updates can fail - print to console as last resort
        print('❌ Critical error in _fetchAccountList: $e, UI update failed: $innerE');
      }
    }
  }

  Future<void> _fetchPortfolioData() async {
    try {
      setState(() {
        _isLoadingPortfolio = true;
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
          // The sync is already called in _fetchAccountList, so we just find the user
          accountId = _findUserAccount(accounts, currentUsername);
        }
      }

      print('🔍 Final account ID selected: "$accountId" for user: $currentUsername');

      if (accountId == null || accountId.isEmpty) {
        if (mounted) {
          setState(() {
            _isLoadingPortfolio = false;
          });
        }
        return;
      }

      // Fetch portfolio data with comprehensive crash protection
      final portfolioResponse = await realGrpcClient.getAccountMarketPortfolio(
        accountId: accountId,
        marketId: '',
        assetIds: ['ETH', 'OXC','XRP'],
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () => {
          'input': {'ref_request_id': 'timeout'},
          'output': {'error': 'Request timed out', 'message': 'Portfolio request timed out after 15 seconds'},
          'requestTime': DateTime.now().toIso8601String(),
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
      // Ultimate crash protection
      try {
        if (mounted) {
          setState(() {
            _isLoadingPortfolio = false;
          });
        }
      } catch (innerE) {
        print('❌ Critical error in _fetchPortfolioData: $e, UI update failed: $innerE');
      }
    }
  }

  /// Find the account that belongs to the logged-in user
  String? _findUserAccount(List<dynamic> accounts, String username) {
    for (final account in accounts) {
      final accountMap = account as Map<String, dynamic>;
      final externalId = accountMap['external_id'] ?? accountMap['externalId'] ?? '';
      final accountId = accountMap['id'] ?? '';
      
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
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    // gRPC Connection Status Card
                    Container(
                      padding: const EdgeInsets.all(16),
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
                          Row(
                            children: [
                              Icon(
                                Icons.cloud_outlined,
                                color: _connectionStatusColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Trading Server Status',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: _isDarkTheme ? Colors.white : Colors.black,
                                ),
                              ),
                              const Spacer(),
                              // Test Connection Button
                              TextButton.icon(
                                onPressed: () {
                                  // Extra safety wrapper to prevent any possible crashes
                                  try {
                                    _testPingConnection();
                                  } catch (e) {
                                    print('❌ Critical: Ping button press failed: $e');
                                    try {
                                      if (mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Ping failed: ${e.toString()}'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    } catch (uiError) {
                                      print('❌ Even UI error handling failed: $uiError');
                                    }
                                  }
                                },
                                icon: const Icon(Icons.refresh, size: 16),
                                label: const Text('Ping'),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.transparent,
                                  side: const BorderSide(color: Colors.white),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Get Account List Button
                              TextButton.icon(
                                onPressed: _isLoadingAccounts ? null : () {
                                  // Extra safety wrapper to prevent any possible crashes
                                  try {
                                    _fetchAccountList();
                                  } catch (e) {
                                    print('❌ Critical: Account button press failed: $e');
                                    try {
                                      if (mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Account list failed: ${e.toString()}'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    } catch (uiError) {
                                      print('❌ Even UI error handling failed: $uiError');
                                    }
                                  }
                                },
                                icon: _isLoadingAccounts 
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        ),
                                      )
                                    : const Icon(Icons.list, size: 16),
                                label: const Text('Accounts'),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.transparent,
                                  side: const BorderSide(color: Colors.white),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Get Portfolio Button
                              TextButton.icon(
                                onPressed: _isLoadingPortfolio ? null : () {
                                  // Extra safety wrapper to prevent any possible crashes
                                  try {
                                    _fetchPortfolioData();
                                  } catch (e) {
                                    print('❌ Critical: Portfolio button press failed: $e');
                                    try {
                                      if (mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Portfolio fetch failed: ${e.toString()}'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    } catch (uiError) {
                                      print('❌ Even UI error handling failed: $uiError');
                                    }
                                  }
                                },
                                icon: _isLoadingPortfolio 
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        ),
                                      )
                                    : const Icon(Icons.pie_chart, size: 16),
                                label: const Text('Portfolio'),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.transparent,
                                  side: const BorderSide(color: Colors.white),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _connectionStatusColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _connectionStatus,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: _isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                'Participant: ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                ),
                              ),
                              Text(
                                _participantInfo,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: _isDarkTheme ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // GetAccountList Results Section
                    if (_accountListData != null) ...[
                      Container(
                        constraints: const BoxConstraints(maxHeight: 150), // Reduced to 1/4 of original height (600/4 = 150)
                        padding: const EdgeInsets.all(16),
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
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            // Header
                            Row(
                              children: [
                                Icon(
                                  Icons.account_balance_wallet,
                                  color: Colors.blue,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Real Server GetAccountList - gRPC Response',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: _isDarkTheme ? Colors.white : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            
                            // Input Section
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: _isDarkTheme ? const Color(0xFF404040) : Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '📨 Request Input:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _formatJson(_accountListData!['input']),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'monospace',
                                      color: _isDarkTheme ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            
                            // Output Section
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: _isDarkTheme ? const Color(0xFF404040) : Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '📬 Response Output:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _formatJson(_accountListData!['output']),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'monospace',
                                      color: _isDarkTheme ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            
                            // Account Summary
                            if (_accountListData!['output']['accounts'] != null) ...[
                              Text(
                                '👥 Account Summary:',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: _isDarkTheme ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ..._buildAccountList(_accountListData!['output']['accounts'], _isDarkTheme),
                            ],
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                    
                    // Portfolio Holdings
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
                              'Holdings',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: _isDarkTheme ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 20),
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
              // Portfolio Button (current page)
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  height: 55,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isDarkTheme ? const Color(0xFF1A1A1A) : Colors.grey[100],
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
                    'Portfolio',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isDarkTheme ? Colors.white : Colors.black,
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
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
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
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
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
            padding: const EdgeInsets.all(8),
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
            const SizedBox(height: 16),
            Text(
              'Loading portfolio data...',
              style: TextStyle(
                fontSize: 16,
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
              size: 64,
              color: isDarkTheme ? Colors.grey[600] : Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No portfolio data available',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Click the "Portfolio" button above to fetch your portfolio data from the server',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
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
            const SizedBox(height: 16),
            Text(
              'Failed to load portfolio',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.red,
              ),
            ),
          ],
        ),
      );
    }

    // Display real portfolio data
    final portfolioOutput = _portfolioData!['output'] as Map<String, dynamic>;
    
    // Extract portfolio balances from the proto response structure
    final portfolio = portfolioOutput['portfolio'] as Map<String, dynamic>? ?? {};
    final balances = portfolio['balances'] as Map<String, dynamic>? ?? {};
    
    if (balances.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox,
              size: 64,
              color: isDarkTheme ? Colors.grey[600] : Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No holdings found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your portfolio appears to be empty',
              style: TextStyle(
                fontSize: 14,
                color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    final assetList = balances.entries.toList();
    
    return ListView.builder(
      itemCount: assetList.length,
      itemBuilder: (context, index) {
        final entry = assetList[index];
        final assetId = entry.key;
        final balance = entry.value?.toString() ?? '0';
        
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
      padding: const EdgeInsets.all(16),
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
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 12,
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
                        fontSize: 12,
                        color: _isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'SYMBOL',
                          style: TextStyle(
                            fontSize: 10,
                            color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          symbol,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
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
                            fontSize: 10,
                            color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          total,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
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
                        fontSize: 12,
                        color: _isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'HIGH',
                          style: TextStyle(
                            fontSize: 10,
                            color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$high \$',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
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
                            fontSize: 10,
                            color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$low \$',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
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
                        fontSize: 12,
                        color: _isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'CHANGE',
                          style: TextStyle(
                            fontSize: 10,
                            color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          change,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
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
                            fontSize: 10,
                            color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$marketValue \$',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
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

  // Helper method to format JSON for display
  String _formatJson(dynamic json) {
    if (json == null) return 'null';
    
    String jsonString = json.toString();
    // Simple formatting - add line breaks after commas and braces
    jsonString = jsonString.replaceAll('{', '{\n  ');
    jsonString = jsonString.replaceAll('}', '\n}');
    jsonString = jsonString.replaceAll(', ', ',\n  ');
    return jsonString;
  }

  // Helper method to build account list widgets
  List<Widget> _buildAccountList(List<dynamic> accounts, bool isDarkTheme) {
    return accounts.map<Widget>((account) {
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDarkTheme ? const Color(0xFF505050) : Colors.grey[50],
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isDarkTheme ? Colors.grey[600]! : Colors.grey[300]!,
          ),
        ),
        child: Row(
          children: [
            // Account Icon
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            
            // Account Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        account['external_id'] ?? account['externalId'] ?? 'N/A',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isDarkTheme ? Colors.white : Colors.black,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: account['status'] == 'ACTIVE' ? Colors.green : Colors.orange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          account['status'] ?? 'UNKNOWN',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'ID: ${account['id']}',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDarkTheme ? Colors.grey[300] : Colors.grey[600],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Balance: \$${account['balance']} ${account['currency'] ?? ''}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isDarkTheme ? Colors.green[300] : Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
