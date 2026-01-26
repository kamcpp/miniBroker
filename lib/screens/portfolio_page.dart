import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/theme_service.dart';
import '../services/grpcurl_helper.dart';
import '../utils/connectivity_checker.dart';
import '../utils/menu_items_helper.dart';
import '../config/ui_constants.dart';
import '../widgets/base_page.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  Map<String, dynamic>? _securityHoldingsData;
  Map<String, dynamic>? _cashHoldingsData;
  bool _isLoadingSecurities = false;
  bool _isLoadingCash = false;
  String? _investorId;

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

    // Get the logged-in username - this IS the investor ID (external_investor_id)
    final authService = Provider.of<AuthService>(context, listen: false);
    final currentUsername = authService.username;

    if (currentUsername.isEmpty) {
      print('❌ No logged-in user found');
      return;
    }

    // Use the username directly as the investor ID (external_investor_id)
    _investorId = currentUsername;
    print('✅ Using logged-in username as investor ID: $_investorId');

    // Fetch both security and cash holdings in parallel
    await Future.wait([
      _fetchSecurityHoldings(),
      _fetchCashHoldings(),
    ]);
  }

  Future<void> _fetchSecurityHoldings() async {
    if (!mounted || _investorId == null || _investorId!.isEmpty) return;

    setState(() {
      _isLoadingSecurities = true;
    });

    try {
      final response = await GrpcurlHelper.getInvestorSecurityHoldings(
        investorId: _investorId!,
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => {
          'input': {'proposed_execution_id': 'timeout'},
          'output': {'error': 'Request timed out', 'message': 'Security holdings request timed out'},
          'requestTime': (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString(),
          'serverType': 'timeout',
          'success': false,
        },
      );

      print('📊 Security holdings response: $response');

      if (mounted) {
        setState(() {
          _securityHoldingsData = response;
          _isLoadingSecurities = false;
        });
      }
    } catch (e) {
      print('❌ Error fetching security holdings: $e');
      if (mounted) {
        setState(() {
          _isLoadingSecurities = false;
          _securityHoldingsData = {
            'success': false,
            'output': {
              'error': 'Failed to load security holdings',
              'message': e.toString(),
            },
          };
        });
      }
    }
  }

  Future<void> _fetchCashHoldings() async {
    if (!mounted || _investorId == null || _investorId!.isEmpty) return;

    setState(() {
      _isLoadingCash = true;
    });

    try {
      final response = await GrpcurlHelper.getInvestorCashHoldings(
        investorId: _investorId!,
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => {
          'input': {'proposed_execution_id': 'timeout'},
          'output': {'error': 'Request timed out', 'message': 'Cash holdings request timed out'},
          'requestTime': (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString(),
          'serverType': 'timeout',
          'success': false,
        },
      );

      print('💰 Cash holdings response: $response');

      if (mounted) {
        setState(() {
          _cashHoldingsData = response;
          _isLoadingCash = false;
        });
      }
    } catch (e) {
      print('❌ Error fetching cash holdings: $e');
      if (mounted) {
        setState(() {
          _isLoadingCash = false;
          _cashHoldingsData = {
            'success': false,
            'output': {
              'error': 'Failed to load cash holdings',
              'message': e.toString(),
            },
          };
        });
      }
    }
  }

  Future<void> _refreshData() async {
    if (_investorId != null && _investorId!.isNotEmpty) {
      await Future.wait([
        _fetchSecurityHoldings(),
        _fetchCashHoldings(),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final isDarkTheme = themeService.isDarkTheme;

    return BasePage(
      menuItems: MenuItemsHelper.buildMenuItems(context, 'portfolio'),
      content: Padding(
        padding: UIConstants.paddingComfortable,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Refresh button row
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: isDarkTheme ? Colors.white70 : Colors.black54,
                  ),
                  onPressed: _refreshData,
                  tooltip: 'Refresh holdings',
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Security Holdings (top section)
            Expanded(
              flex: 1,
              child: _buildHoldingsPane(
                title: 'Security Holdings',
                icon: Icons.account_balance_wallet,
                isDarkTheme: isDarkTheme,
                isLoading: _isLoadingSecurities,
                data: _securityHoldingsData,
                buildContent: () => _buildSecurityHoldingsContent(isDarkTheme),
              ),
            ),

            const SizedBox(height: 16),

            // Cash Token Holdings (bottom section)
            Expanded(
              flex: 1,
              child: _buildHoldingsPane(
                title: 'Cash Token Holdings',
                icon: Icons.payments,
                isDarkTheme: isDarkTheme,
                isLoading: _isLoadingCash,
                data: _cashHoldingsData,
                buildContent: () => _buildCashHoldingsContent(isDarkTheme),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHoldingsPane({
    required String title,
    required IconData icon,
    required bool isDarkTheme,
    required bool isLoading,
    required Map<String, dynamic>? data,
    required Widget Function() buildContent,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkTheme ? const Color(0xFF1e1e1e) : Colors.white,
        borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
        border: Border.all(
          color: isDarkTheme ? Colors.grey[800]! : Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: UIConstants.paddingStandard,
            decoration: BoxDecoration(
              color: isDarkTheme ? const Color(0xFF2d2d2d) : Colors.grey[50],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isDarkTheme ? Colors.white70 : Colors.black54,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: UIConstants.fontSizeMd,
                    fontWeight: UIConstants.fontWeightMedium,
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: Padding(
              padding: UIConstants.paddingStandard,
              child: isLoading
                  ? _buildLoadingState(isDarkTheme)
                  : (_investorId == null || _investorId!.isEmpty)
                      ? _buildNoInvestorState(isDarkTheme)
                      : data == null
                          ? _buildEmptyState(isDarkTheme, 'No data available')
                          : data['success'] != true
                              ? _buildErrorState(isDarkTheme, data['output']?['error'] ?? 'Unknown error')
                              : buildContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(bool isDarkTheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(height: 12),
          Text(
            'Loading...',
            style: TextStyle(
              fontSize: UIConstants.fontSizeBody,
              color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoInvestorState(bool isDarkTheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_outline,
            size: 48,
            color: isDarkTheme ? Colors.grey[600] : Colors.grey[400],
          ),
          const SizedBox(height: 12),
          Text(
            'No investor found',
            style: TextStyle(
              fontSize: UIConstants.fontSizeBody,
              fontWeight: UIConstants.fontWeightMedium,
              color: isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Please sign up to create an investor profile',
            style: TextStyle(
              fontSize: UIConstants.fontSizeSm,
              color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool isDarkTheme, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 48,
            color: isDarkTheme ? Colors.grey[600] : Colors.grey[400],
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: TextStyle(
              fontSize: UIConstants.fontSizeBody,
              color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(bool isDarkTheme, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Colors.red[400],
          ),
          const SizedBox(height: 12),
          Text(
            'Failed to load data',
            style: TextStyle(
              fontSize: UIConstants.fontSizeBody,
              fontWeight: UIConstants.fontWeightMedium,
              color: isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            error,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: UIConstants.fontSizeSm,
              color: Colors.red[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityHoldingsContent(bool isDarkTheme) {
    final output = _securityHoldingsData!['output'] as Map<String, dynamic>;
    final portfolio = output['portfolio'] as Map<String, dynamic>? ?? {};
    final holdings = portfolio['holdings'] as Map<String, dynamic>? ?? {};

    if (holdings.isEmpty) {
      return _buildEmptyState(isDarkTheme, 'No security holdings');
    }

    final holdingsList = holdings.entries.toList();

    return Column(
      children: [
        // Table header
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: isDarkTheme ? const Color(0xFF2d2d2d) : Colors.grey[100],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              _buildHeaderCell('Symbol', flex: 2, isDarkTheme: isDarkTheme),
              _buildHeaderCell('Total Units', flex: 2, isDarkTheme: isDarkTheme, align: TextAlign.right),
              _buildHeaderCell('Available', flex: 2, isDarkTheme: isDarkTheme, align: TextAlign.right),
              _buildHeaderCell('Locked', flex: 2, isDarkTheme: isDarkTheme, align: TextAlign.right),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Table body
        Expanded(
          child: ListView.separated(
            itemCount: holdingsList.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: isDarkTheme ? Colors.grey[800] : Colors.grey[200],
            ),
            itemBuilder: (context, index) {
              final entry = holdingsList[index];
              final securityId = entry.key;
              final holdingData = entry.value as Map<String, dynamic>? ?? {};
              final totalUnits = holdingData['totalUnits']?.toString() ?? '0';
              final availableUnits = holdingData['availableUnits']?.toString() ?? totalUnits;
              final lockedUnits = holdingData['lockedUnits']?.toString() ?? '0';

              return Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: _getColorForAsset(securityId),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Text(
                                securityId.length >= 2 ? securityId.substring(0, 2).toUpperCase() : securityId.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              securityId,
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeBody,
                                fontWeight: UIConstants.fontWeightMedium,
                                color: isDarkTheme ? Colors.white : Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildDataCell(totalUnits, flex: 2, isDarkTheme: isDarkTheme),
                    _buildDataCell(availableUnits, flex: 2, isDarkTheme: isDarkTheme, color: Colors.green),
                    _buildDataCell(lockedUnits, flex: 2, isDarkTheme: isDarkTheme, color: Colors.orange),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCashHoldingsContent(bool isDarkTheme) {
    final output = _cashHoldingsData!['output'] as Map<String, dynamic>;
    // The response structure is: output.cashPortfolio.holdings
    final cashPortfolio = output['cashPortfolio'] as Map<String, dynamic>? ?? {};
    final holdings = cashPortfolio['holdings'] as Map<String, dynamic>? ?? {};

    if (holdings.isEmpty) {
      return _buildEmptyState(isDarkTheme, 'No cash holdings');
    }

    final holdingsList = holdings.entries.toList();

    return Column(
      children: [
        // Table header
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: isDarkTheme ? const Color(0xFF2d2d2d) : Colors.grey[100],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              _buildHeaderCell('Currency', flex: 2, isDarkTheme: isDarkTheme),
              _buildHeaderCell('Total Balance', flex: 2, isDarkTheme: isDarkTheme, align: TextAlign.right),
              _buildHeaderCell('Available', flex: 2, isDarkTheme: isDarkTheme, align: TextAlign.right),
              _buildHeaderCell('Reserved', flex: 2, isDarkTheme: isDarkTheme, align: TextAlign.right),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Table body
        Expanded(
          child: ListView.separated(
            itemCount: holdingsList.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: isDarkTheme ? Colors.grey[800] : Colors.grey[200],
            ),
            itemBuilder: (context, index) {
              final entry = holdingsList[index];
              final currencyCode = entry.key;
              final holdingData = entry.value as Map<String, dynamic>? ?? {};
              // The API returns totalUnits, availableUnits, lockedUnits
              final totalBalance = holdingData['totalUnits']?.toString() ?? holdingData['totalBalance']?.toString() ?? '0';
              final availableBalance = holdingData['availableUnits']?.toString() ?? holdingData['availableBalance']?.toString() ?? totalBalance;
              final reservedBalance = holdingData['lockedUnits']?.toString() ?? holdingData['reservedBalance']?.toString() ?? '0';

              return Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: _getColorForCurrency(currencyCode),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Text(
                                _getCurrencySymbol(currencyCode),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              currencyCode,
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeBody,
                                fontWeight: UIConstants.fontWeightMedium,
                                color: isDarkTheme ? Colors.white : Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildDataCell(_formatCurrency(totalBalance, currencyCode), flex: 2, isDarkTheme: isDarkTheme),
                    _buildDataCell(_formatCurrency(availableBalance, currencyCode), flex: 2, isDarkTheme: isDarkTheme, color: Colors.green),
                    _buildDataCell(_formatCurrency(reservedBalance, currencyCode), flex: 2, isDarkTheme: isDarkTheme, color: Colors.orange),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderCell(String text, {required int flex, required bool isDarkTheme, TextAlign align = TextAlign.left}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: align,
        style: TextStyle(
          fontSize: UIConstants.fontSizeSm,
          fontWeight: UIConstants.fontWeightMedium,
          color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildDataCell(String text, {required int flex, required bool isDarkTheme, Color? color}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: UIConstants.fontSizeBody,
          fontWeight: FontWeight.w500,
          color: color ?? (isDarkTheme ? Colors.white : Colors.black87),
        ),
      ),
    );
  }

  Color _getColorForAsset(String assetId) {
    switch (assetId.toUpperCase()) {
      case 'ETH':
        return const Color(0xFF627EEA);
      case 'BTC':
        return const Color(0xFFF7931A);
      case 'OXC':
        return const Color(0xFF85BB65);
      case 'XRP':
        return const Color(0xFF23292F);
      default:
        // Generate a color based on the asset ID hash
        final hash = assetId.hashCode;
        return Color.fromRGBO(
          (hash & 0xFF0000) >> 16,
          (hash & 0x00FF00) >> 8,
          hash & 0x0000FF,
          1,
        );
    }
  }

  Color _getColorForCurrency(String currencyCode) {
    switch (currencyCode.toUpperCase()) {
      case 'USD':
        return const Color(0xFF2E7D32); // Green
      case 'EUR':
        return const Color(0xFF1565C0); // Blue
      case 'GBP':
        return const Color(0xFF6A1B9A); // Purple
      case 'JPY':
        return const Color(0xFFC62828); // Red
      case 'CHF':
        return const Color(0xFFD84315); // Deep Orange
      default:
        return const Color(0xFF37474F); // Blue Grey
    }
  }

  String _getCurrencySymbol(String currencyCode) {
    switch (currencyCode.toUpperCase()) {
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      case 'JPY':
        return '¥';
      case 'CHF':
        return 'Fr';
      default:
        return currencyCode.length >= 1 ? currencyCode[0] : '?';
    }
  }

  String _formatCurrency(String amount, String currencyCode) {
    try {
      final value = double.parse(amount);
      final symbol = _getCurrencySymbol(currencyCode);
      if (currencyCode.toUpperCase() == 'JPY') {
        return '$symbol${value.toStringAsFixed(0)}';
      }
      return '$symbol${value.toStringAsFixed(2)}';
    } catch (e) {
      return amount;
    }
  }
}
