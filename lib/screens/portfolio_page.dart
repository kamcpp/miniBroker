import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/theme_service.dart';
import '../services/real_grpc_client.dart';
import 'trading_page.dart';
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
  
  @override
  void initState() {
    super.initState();
    _checkGrpcConnection();
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

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ Real server connection test successful!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          setState(() {
            _connectionStatus = 'Real server ping failed: ${output['error'] ?? 'Unknown error'}';
            _connectionStatusColor = Colors.red;
          });
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('❌ Real server connection test failed: ${output['error'] ?? 'Unknown error'}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
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
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('❌ Ping failed: ${e.toString()}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
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
      if (!realGrpcClient.isConnected) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('❌ Not connected to real simprtagent server'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ Real server account list loaded successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          final output = accountListResponse['output'] as Map<String, dynamic>;
          setState(() {
            _connectionStatus = 'Account list fetch failed: ${output['error'] ?? 'Unknown error'}';
            _connectionStatusColor = Colors.red;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('❌ Failed to fetch account list: ${output['error'] ?? 'Unknown error'}'),
              backgroundColor: Colors.red,
            ),
          );
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

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('❌ Failed to fetch account list: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (innerE) {
        // Even UI updates can fail - print to console as last resort
        print('❌ Critical error in _fetchAccountList: $e, UI update failed: $innerE');
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
        backgroundColor: _isDarkTheme ? const Color(0xFF1A1A1A) : Colors.grey[100],
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
                    // Total Asset Value
                    Container(
                      padding: const EdgeInsets.all(24),
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
                            'Total asset value',
                            style: TextStyle(
                              fontSize: 16,
                              color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '1,220 \$',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: _isDarkTheme ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              // Profit Card
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: _isDarkTheme ? const Color(0xFF404040) : Colors.grey[100],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Profit',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'N/A',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: _isDarkTheme ? Colors.white : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Investment gain/loss Card
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: _isDarkTheme ? const Color(0xFF404040) : Colors.grey[100],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Investment gain/loss',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'N/A',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: _isDarkTheme ? Colors.white : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
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
                        constraints: const BoxConstraints(maxHeight: 600), // Add max height constraint
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
                              child: ListView(
                                children: [
                                  _buildHoldingItem(
                                    themeService,
                                    'SFG',
                                    'San Francisco Giants',
                                    '100',
                                    '100',
                                    '0',
                                    '5.5',
                                    '5.5',
                                    '0%',
                                    '5.5',
                                    const Color(0xFFFF6B35),
                                  ),
                                  const SizedBox(height: 16),
                                  _buildHoldingItem(
                                    themeService,
                                    'AC1',
                                    'AC Milan',
                                    '100',
                                    '100',
                                    '0',
                                    '6.7',
                                    '6.7',
                                    '0%',
                                    '6.7',
                                    const Color(0xFFE53E3E),
                                  ),
                                ],
                              ),
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
          
          // Left spacer - make it larger to push buttons more to the right
          const Expanded(flex: 2, child: SizedBox.shrink()),
          
          // Center Navigation Buttons
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Portfolio Button (current page)
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    height: 32,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'Portfolio',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1a1754),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(width: 8),
                
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
                      height: 32,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Trading',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Right spacer - smaller to balance the layout
          const Expanded(flex: 1, child: SizedBox.shrink()),
          
          // User Profile with Dropdown
          PopupMenuButton<String>(
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
                      Icon(Icons.person, size: 18),
                      SizedBox(width: 8),
                      Text('Profile'),
                    ],
                  ),
                ),
                if (isAdmin)
                  const PopupMenuItem<String>(
                    value: 'users',
                    child: Row(
                      children: [
                        Icon(Icons.people, size: 18),
                        SizedBox(width: 8),
                        Text('View Users'),
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
