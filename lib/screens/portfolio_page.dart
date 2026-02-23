import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/theme_service.dart';
import '../services/grpcurl_helper.dart';
import '../services/real_grpc_client.dart';
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
  Set<String> _supportedCashTokenCodes = {};

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

    // Fetch supported cash tokens, security holdings, and cash holdings in parallel
    await Future.wait([
      _fetchSupportedCashTokens(),
      _fetchSecurityHoldings(),
      _fetchCashHoldings(),
    ]);
  }

  Future<void> _fetchSupportedCashTokens() async {
    if (!mounted) return;
    try {
      if (!realGrpcClient.isConnected) return;

      final result = await realGrpcClient.getSupportedCurrencies().timeout(
        const Duration(minutes: 5),
        onTimeout: () => {
          'success': false,
          'output': {'error': 'Request timed out'},
        },
      );

      if (result['success'] == true && result['output'] != null) {
        final output = result['output'] as Map<String, dynamic>;
        final cashTokens = output['cashTokens'] as List<dynamic>? ?? [];
        final codes = <String>{};

        for (final token in cashTokens) {
          if (token is Map<String, dynamic>) {
            // Collect all possible codes so we match however the holdings map keys them
            final identifiers = token['identifiers'] as List<dynamic>? ?? [];
            for (final identifier in identifiers) {
              if (identifier is Map<String, dynamic>) {
                final ids = identifier['ids'] as List<dynamic>? ?? [];
                for (final id in ids) {
                  if (id is Map<String, dynamic>) {
                    final value = id['value'] as String? ?? '';
                    if (value.isNotEmpty) codes.add(value);
                  }
                }
              }
            }
            final issueCurrency = token['issueCurrency'] as String? ?? '';
            if (issueCurrency.isNotEmpty) codes.add(issueCurrency);
            final iid = token['iid']?.toString() ?? '';
            if (iid.isNotEmpty) codes.add(iid);
          }
        }
        print('✅ Supported cash token codes: $codes');

        if (mounted) {
          setState(() {
            _supportedCashTokenCodes = codes;
          });
        }
      }
    } catch (e) {
      print('❌ Error fetching supported cash tokens: $e');
    }
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
        const Duration(minutes: 5),
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
        const Duration(minutes: 5),
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
        _fetchSupportedCashTokens(),
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
              final availableUnits = holdingData['availableUnits']?.toString() ?? '0';
              final lockedUnits = holdingData['lockedUnits']?.toString() ?? '0';

              return Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
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

    // Only show cash tokens that are supported by the gRPC CashTokenService
    final holdingsList = _supportedCashTokenCodes.isEmpty
        ? holdings.entries.toList()
        : holdings.entries.where((e) => _supportedCashTokenCodes.contains(e.key)).toList();

    if (holdingsList.isEmpty) {
      return _buildEmptyState(isDarkTheme, 'No cash holdings');
    }

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
              _buildHeaderCell('Actions', flex: 2, isDarkTheme: isDarkTheme, align: TextAlign.center),
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
              final totalBalance = holdingData['totalUnits']?.toString() ?? '0';
              final availableBalance = holdingData['availableUnits']?.toString() ?? '0';
              final reservedBalance = holdingData['lockedUnits']?.toString() ?? '0';

              return Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
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
                    _buildDataCell(totalBalance, flex: 2, isDarkTheme: isDarkTheme),
                    _buildDataCell(availableBalance, flex: 2, isDarkTheme: isDarkTheme, color: Colors.green),
                    _buildDataCell(reservedBalance, flex: 2, isDarkTheme: isDarkTheme, color: Colors.orange),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 28,
                            child: ElevatedButton(
                              onPressed: () => _showDepositDialog(currencyCode),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: UIConstants.colorSuccess,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: const Text('Deposit', style: TextStyle(color: Colors.white, fontSize: 11)),
                            ),
                          ),
                          const SizedBox(width: 6),
                          SizedBox(
                            height: 28,
                            child: ElevatedButton(
                              onPressed: () => _showWithdrawDialog(currencyCode, availableBalance),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: UIConstants.colorDanger,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: const Text('Withdraw', style: TextStyle(color: Colors.white, fontSize: 11)),
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

  void _showDepositDialog(String currencyCode) {
    final themeService = Provider.of<ThemeService>(context, listen: false);
    final isDarkTheme = themeService.isDarkTheme;
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDarkTheme ? const Color(0xFF2A2A2A) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UIConstants.borderRadiusLg),
          ),
          title: Text(
            'Deposit $currencyCode',
            style: TextStyle(
              color: isDarkTheme ? Colors.white : Colors.black,
              fontWeight: UIConstants.fontWeightMedium,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter amount to deposit:',
                style: TextStyle(
                  color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                decoration: InputDecoration(
                  hintText: '0.00',
                  hintStyle: TextStyle(
                    color: isDarkTheme ? Colors.grey[500] : Colors.grey[400],
                  ),
                  suffixText: currencyCode,
                  suffixStyle: TextStyle(
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                  ),
                  filled: true,
                  fillColor: isDarkTheme ? const Color(0xFF505050) : Colors.grey[200],
                ),
                style: TextStyle(
                  color: isDarkTheme ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final amount = amountController.text.trim();
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                final navigator = Navigator.of(context);

                if (amount.isEmpty) {
                  navigator.pop();
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(content: Text('Please enter an amount'), backgroundColor: Colors.red),
                  );
                  return;
                }

                final parsedAmount = double.tryParse(amount);
                if (parsedAmount == null || parsedAmount <= 0) {
                  navigator.pop();
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(content: Text('Please enter a valid positive amount'), backgroundColor: Colors.red),
                  );
                  return;
                }

                if (_investorId == null || _investorId!.isEmpty) {
                  navigator.pop();
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(content: Text('Investor not found. Please try again.'), backgroundColor: Colors.red),
                  );
                  return;
                }

                navigator.pop();

                scaffoldMessenger.showSnackBar(
                  const SnackBar(content: Text('Depositing cash...'), duration: Duration(seconds: 2)),
                );

                try {
                  final response = await GrpcurlHelper.depositCash(
                    investorId: _investorId!,
                    currencyCode: currencyCode,
                    amount: amount,
                  );

                  if (mounted) {
                    if (response['success'] == true) {
                      scaffoldMessenger.showSnackBar(
                        SnackBar(
                          content: Text('Successfully deposited $amount $currencyCode'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      _fetchCashHoldings();
                    } else {
                      final errorMessage = response['output']?['error'] ??
                          response['output']?['message'] ??
                          'Failed to deposit cash';
                      scaffoldMessenger.showSnackBar(
                        SnackBar(content: Text('Deposit failed: $errorMessage'), backgroundColor: Colors.red, duration: const Duration(seconds: 5)),
                      );
                    }
                  }
                } catch (e) {
                  if (mounted) {
                    scaffoldMessenger.showSnackBar(
                      SnackBar(content: Text('Error: ${e.toString()}'), backgroundColor: Colors.red),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: UIConstants.colorSuccess,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                ),
              ),
              child: const Text('Deposit', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showWithdrawDialog(String currencyCode, String availableBalance) {
    final themeService = Provider.of<ThemeService>(context, listen: false);
    final isDarkTheme = themeService.isDarkTheme;
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDarkTheme ? const Color(0xFF2A2A2A) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UIConstants.borderRadiusLg),
          ),
          title: Text(
            'Withdraw $currencyCode',
            style: TextStyle(
              color: isDarkTheme ? Colors.white : Colors.black,
              fontWeight: UIConstants.fontWeightMedium,
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
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                decoration: InputDecoration(
                  hintText: '0.00',
                  hintStyle: TextStyle(
                    color: isDarkTheme ? Colors.grey[500] : Colors.grey[400],
                  ),
                  suffixText: currencyCode,
                  suffixStyle: TextStyle(
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                  ),
                  filled: true,
                  fillColor: isDarkTheme ? const Color(0xFF505050) : Colors.grey[200],
                ),
                style: TextStyle(
                  color: isDarkTheme ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Available: ${_formatCurrency(availableBalance, currencyCode)}',
                style: TextStyle(
                  color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  fontSize: UIConstants.fontSizeSm,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final amount = amountController.text.trim();
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                final navigator = Navigator.of(context);

                if (amount.isEmpty) {
                  navigator.pop();
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(content: Text('Please enter an amount'), backgroundColor: Colors.red),
                  );
                  return;
                }

                final parsedAmount = double.tryParse(amount);
                if (parsedAmount == null || parsedAmount <= 0) {
                  navigator.pop();
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(content: Text('Please enter a valid positive amount'), backgroundColor: Colors.red),
                  );
                  return;
                }

                final availBal = double.tryParse(availableBalance) ?? 0.0;
                if (parsedAmount > availBal) {
                  navigator.pop();
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: Text('Insufficient balance. Available: ${_formatCurrency(availableBalance, currencyCode)}'),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 4),
                    ),
                  );
                  return;
                }

                if (_investorId == null || _investorId!.isEmpty) {
                  navigator.pop();
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(content: Text('Investor not found. Please try again.'), backgroundColor: Colors.red),
                  );
                  return;
                }

                navigator.pop();

                scaffoldMessenger.showSnackBar(
                  const SnackBar(content: Text('Withdrawing cash...'), duration: Duration(seconds: 2)),
                );

                try {
                  final response = await GrpcurlHelper.withdrawCash(
                    investorId: _investorId!,
                    currencyCode: currencyCode,
                    amount: amount,
                  );

                  if (mounted) {
                    if (response['success'] == true) {
                      scaffoldMessenger.showSnackBar(
                        SnackBar(
                          content: Text('Successfully withdrew $amount $currencyCode'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      _fetchCashHoldings();
                    } else {
                      final errorMessage = response['output']?['error'] ??
                          response['output']?['message'] ??
                          'Failed to withdraw cash';
                      scaffoldMessenger.showSnackBar(
                        SnackBar(content: Text('Withdrawal failed: $errorMessage'), backgroundColor: Colors.red, duration: const Duration(seconds: 5)),
                      );
                    }
                  }
                } catch (e) {
                  if (mounted) {
                    scaffoldMessenger.showSnackBar(
                      SnackBar(content: Text('Error: ${e.toString()}'), backgroundColor: Colors.red),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: UIConstants.colorDanger,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                ),
              ),
              child: const Text('Withdraw', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
