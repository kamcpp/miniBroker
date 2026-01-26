import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/theme_service.dart';
import '../services/real_grpc_client.dart';
import '../config/ui_constants.dart';
import '../utils/menu_items_helper.dart';
import '../widgets/base_page.dart';import '../utils/connectivity_checker.dart';

class CashManagementPage extends StatefulWidget {
  const CashManagementPage({super.key});

  @override
  State<CashManagementPage> createState() => _CashManagementPageState();
}

class _CashManagementPageState extends State<CashManagementPage> {
  bool _isLoadingCashHoldings = false;
  String _buyingPower = '0';
  String? _investorId;

  // Supported currencies data - now includes asset_id for cash holdings
  List<Map<String, String>> _supportedCurrencies = [];
  Map<String, String> _selectedCurrency = {};
  bool _isLoadingSupportedCurrencies = false;

  @override
  void initState() {
    super.initState();

    // Check server connectivity when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ConnectivityChecker.checkAndShowErrorIfNeeded(context, 'Cash Management');
    });

    // Initialize data
    _initializeBalanceData();
  }

  Future<void> _initializeBalanceData() async {
    if (mounted) {
      _fetchSupportedCurrencies();
    }
  }

  // Fetch supported currencies using CashTokenService.GetCashTokenList
  Future<void> _fetchSupportedCurrencies() async {
    try {
      if (!realGrpcClient.isConnected) {
        print('❌ Not connected to real gRPC server for cash tokens');
        return;
      }

      setState(() {
        _isLoadingSupportedCurrencies = true;
      });

      // Use CashTokenService.GetCashTokenList to get supported cash tokens
      final result = await realGrpcClient.getSupportedCurrencies();

      if (result['success'] == true) {
        final output = result['output'] as Map<String, dynamic>;
        // Response format: { cash_tokens: [...], pagination_info: {...} }
        final cashTokens = output['cashTokens'] as List<dynamic>? ??
                          output['cash_tokens'] as List<dynamic>? ?? [];

        final currencyData = cashTokens.map((token) {
          final tokenMap = token as Map<String, dynamic>;

          // Get the cash token iid
          final iid = tokenMap['iid']?.toString() ?? '';

          // Get display name - try displayNames map first
          String displayName = '';
          final displayNames = tokenMap['displayNames'] as Map<String, dynamic>? ??
                               tokenMap['display_names'] as Map<String, dynamic>? ?? {};
          if (displayNames.isNotEmpty) {
            // Try 'en' first, then any available language
            displayName = displayNames['en']?.toString() ??
                         displayNames.values.first?.toString() ?? '';
          }

          // Extract TICKER identifier from identifiers if available
          String ticker = '';
          final identifiers = tokenMap['identifiers'] as List<dynamic>? ?? [];
          for (var identifier in identifiers) {
            final identifierMap = identifier as Map<String, dynamic>? ?? {};
            final idType = identifierMap['id_type']?.toString() ??
                          identifierMap['idType']?.toString() ?? '';
            if (idType == 'TICKER' || idType == 'ticker') {
              final ids = identifierMap['ids'] as List<dynamic>? ?? [];
              if (ids.isNotEmpty) {
                final firstId = ids.first as Map<String, dynamic>? ?? {};
                ticker = firstId['value']?.toString() ?? '';
                break;
              }
            }
          }
          // Fallback: if no TICKER found, try first identifier
          if (ticker.isEmpty && identifiers.isNotEmpty) {
            final firstIdentifier = identifiers.first as Map<String, dynamic>? ?? {};
            final ids = firstIdentifier['ids'] as List<dynamic>? ?? [];
            if (ids.isNotEmpty) {
              final firstId = ids.first as Map<String, dynamic>? ?? {};
              ticker = firstId['value']?.toString() ?? '';
            }
          }

          // Use issue_currency if available
          final issueCurrency = tokenMap['issueCurrency']?.toString() ??
                                tokenMap['issue_currency']?.toString() ?? '';

          // Determine the code to use (prefer issue_currency, then ticker, then iid)
          final code = issueCurrency.isNotEmpty ? issueCurrency :
                      (ticker.isNotEmpty ? ticker : iid);

          // Display format: "issueCurrency (ticker)" e.g., "EUR (EUR_THIRD_BROKER)"
          // If no ticker, use displayName, otherwise iid
          final tickerDisplay = ticker.isNotEmpty ? ticker :
                               (displayName.isNotEmpty ? displayName : iid);
          final display = issueCurrency.isNotEmpty
              ? '$issueCurrency ($tickerDisplay)'
              : tickerDisplay;

          return {
            'asset_id': iid, // Use iid as asset_id for API calls
            'code': code,
            'symbol': issueCurrency.isNotEmpty ? issueCurrency : code,
            'display': display,
          };
        }).where((currency) => currency['asset_id']!.isNotEmpty).toList();

        setState(() {
          _supportedCurrencies = currencyData;
          if (_selectedCurrency.isEmpty && _supportedCurrencies.isNotEmpty) {
            _selectedCurrency = _supportedCurrencies.first;
            // Fetch cash holdings for the initially selected currency
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _fetchCashHoldings();
            });
          }
          _isLoadingSupportedCurrencies = false;
        });

        print('✅ Loaded ${_supportedCurrencies.length} cash tokens from CashTokenService');
      } else {
        print('❌ Failed to fetch cash tokens: ${result['output']}');
        setState(() {
          _isLoadingSupportedCurrencies = false;
        });
      }
    } catch (e) {
      print('❌ Error fetching cash tokens: $e');
      setState(() {
        _isLoadingSupportedCurrencies = false;
      });
    }
  }

  // Fetch cash holdings using investor ID (username)
  Future<void> _fetchCashHoldings() async {
    try {
      if (!realGrpcClient.isConnected) {
        print('❌ Not connected to real gRPC server for cash holdings');
        return;
      }

      // Get the current logged-in username from AuthService - this IS the investor ID
      final authService = Provider.of<AuthService>(context, listen: false);
      final currentUsername = authService.username;

      if (currentUsername.isEmpty) {
        print('❌ No logged-in user found');
        setState(() {
          _isLoadingCashHoldings = false;
          _buyingPower = '0';
        });
        return;
      }

      // Use the username directly as the investor ID
      _investorId = currentUsername;
      print('✅ Using logged-in username as investor ID: $_investorId');

      // Check if we already have investor ID and currency selected
      if (_investorId != null &&
          _investorId!.isNotEmpty &&
          _selectedCurrency.isNotEmpty) {
        await _fetchCashHoldingsForInvestor(_investorId!);
        return;
      }

      setState(() {
        _isLoadingCashHoldings = true;
      });

      await _fetchCashHoldingsForInvestor(_investorId!);

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

  Future<void> _fetchCashHoldingsForInvestor(String investorId) async {
    try {
      setState(() {
        _isLoadingCashHoldings = true;
      });

      // Get the current selected currency's code (e.g., "USD", "AED", "EUR")
      final selectedCurrencyCode = _selectedCurrency['code'];
      final cashHoldingsResponse = await realGrpcClient.getInvestorCashHoldings(
        investorId: investorId,
        currencyCodes: selectedCurrencyCode != null && selectedCurrencyCode.isNotEmpty ? [selectedCurrencyCode] : [],
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

  Future<void> _fetchCashHoldingsForCurrency(String currencyCode) async {
    print('🔍 _fetchCashHoldingsForCurrency called with currencyCode: $currencyCode');
    if (_investorId == null || _investorId!.isEmpty) {
      print('❌ No investor ID available for currency fetch');
      return;
    }

    try {
      setState(() {
        _isLoadingCashHoldings = true;
      });

      final cashHoldingsResponse = await realGrpcClient.getInvestorCashHoldings(
        investorId: _investorId!,
        currencyCodes: [currencyCode], // Use the currency code (e.g., "USD", "AED", "EUR")
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

          // The currencyCode parameter is already the code (e.g., "AED", "USD", "EUR")
          // Strip any 'cash_' prefix if present (for backward compatibility)
          String normalizedCode = currencyCode;
          if (normalizedCode.startsWith('cash_')) {
            normalizedCode = normalizedCode.replaceFirst('cash_', '');
          }

          print('🔍 Looking for currency code: $normalizedCode in holdings: ${holdings.keys}');
          print('🔍 Holdings content: $holdings');

          // Try to find the holding by currency code
          Map<String, dynamic>? assetHolding;
          String assetBalance = '0';

          // First try direct lookup
          if (holdings.containsKey(normalizedCode)) {
            assetHolding = holdings[normalizedCode] as Map<String, dynamic>?;
            print('🔍 Direct lookup found: $assetHolding');
          } else {
            // If not found, try to find any holding that matches
            for (String key in holdings.keys) {
              if (key.toUpperCase() == normalizedCode.toUpperCase()) {
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

          print('✅ Updated buying power for $normalizedCode: $assetBalance');
        } else {
          print('❌ Failed to fetch cash holdings for currency $currencyCode: ${cashHoldingsResponse['output']}');
          setState(() {
            _buyingPower = '0';
          });
        }
      }
    } catch (e) {
      print('❌ Error fetching cash holdings for currency $currencyCode: $e');
      setState(() {
        _buyingPower = '0';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final isDarkTheme = themeService.isDarkTheme;

    return BasePage(
      menuItems: MenuItemsHelper.buildMenuItems(context, 'cash'),
      content: Padding(
        padding: UIConstants.paddingComfortable,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cash Management Section
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: isDarkTheme ? const Color(0xFF1e1e1e) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
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
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Cash Management',
                            style: TextStyle(
                              fontSize: UIConstants.fontSizeMd,
                              fontWeight: UIConstants.fontWeightMedium,
                              color: isDarkTheme ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: UIConstants.paddingStandard,
                        child: _isLoadingSupportedCurrencies
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CircularProgressIndicator(),
                                    const SizedBox(height: UIConstants.spacingMd),
                                    Text(
                                      'Loading cash tokens...',
                                      style: TextStyle(
                                        fontSize: UIConstants.fontSizeBody,
                                        color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : _buildBalanceContent(themeService, isDarkTheme),
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

  Widget _buildBalanceContent(ThemeService themeService, bool isDarkTheme) {
    return Container(
      padding: UIConstants.paddingComfortable,
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
                fontSize: UIConstants.textFieldFontSize,
                color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              width: 280,
              height: 40,
              decoration: BoxDecoration(
                color: isDarkTheme ? const Color(0xFF505050) : Colors.white, // Enhanced background color
                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
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
                      _fetchCashHoldingsForCurrency(newValue['code']!);
                    }
                  },
                  dropdownColor: isDarkTheme ? const Color(0xFF1e1e1e) : Colors.white,
                  style: TextStyle(
                    color: isDarkTheme ? Colors.white : Colors.black,
                    fontSize: UIConstants.fontSizeMd,
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

        // Available
        SizedBox(
          height: 24,
          child: Row(
            children: [
              Text(
                'Available: ',
                style: TextStyle(
                  fontSize: UIConstants.textFieldFontSize, // Same as Currency title
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
                        fontSize: UIConstants.fontSizeMd,
                        fontWeight: UIConstants.fontWeightMedium,
                        color: isDarkTheme ? Colors.white : Colors.black,
                      ),
                    ),
            ],
          ),
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
                  style: TextStyle(color: Colors.white, fontWeight: UIConstants.fontWeightMedium),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: UIConstants.colorSuccess,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                  ),
                ),
              ),
            ),
            const SizedBox(width: UIConstants.spacingMd),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Withdraw Cash functionality
                  _showWithdrawCashDialog();
                },
                icon: const Icon(Icons.remove, color: Colors.white),
                label: const Text(
                  'Withdraw Cash',
                  style: TextStyle(color: Colors.white, fontWeight: UIConstants.fontWeightMedium),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: UIConstants.colorDanger,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UIConstants.borderRadiusLg),
          ),
          title: Text(
            'Add Cash',
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
                'Enter amount to add:',
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
                  suffixText: _selectedCurrency['symbol'] ?? '',
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
              onPressed: () async {
                final amount = amountController.text.trim();
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                final navigator = Navigator.of(context);

                // Validate amount
                if (amount.isEmpty) {
                  navigator.pop();
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text('Please enter an amount'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                final parsedAmount = double.tryParse(amount);
                if (parsedAmount == null || parsedAmount <= 0) {
                  navigator.pop();
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid positive amount'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                // Check if we have investor ID and currency
                if (_investorId == null || _investorId!.isEmpty) {
                  navigator.pop();
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text('Investor not found. Please try again.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                if (_selectedCurrency.isEmpty || _selectedCurrency['code'] == null) {
                  navigator.pop();
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text('Please select a currency'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                navigator.pop();

                // Show loading indicator
                scaffoldMessenger.showSnackBar(
                  const SnackBar(
                    content: Text('Depositing cash...'),
                    duration: Duration(seconds: 2),
                  ),
                );

                // Call DepositCash API
                try {
                  final response = await realGrpcClient.depositCash(
                    investorId: _investorId!,
                    currencyCode: _selectedCurrency['code']!,
                    amount: amount,
                  );

                  if (mounted) {
                    if (response['success'] == true) {
                      scaffoldMessenger.showSnackBar(
                        SnackBar(
                          content: Text('Successfully deposited $amount ${_selectedCurrency['symbol']}'),
                          backgroundColor: Colors.green,
                        ),
                      );

                      // Refresh balance
                      _fetchCashHoldingsForCurrency(_selectedCurrency['code']!);
                    } else {
                      final errorMessage = response['output']?['error'] ??
                                         response['output']?['message'] ??
                                         'Failed to deposit cash';
                      scaffoldMessenger.showSnackBar(
                        SnackBar(
                          content: Text('Deposit failed: $errorMessage'),
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 5),
                        ),
                      );
                    }
                  }
                } catch (e) {
                  if (mounted) {
                    scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: Text('Error: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UIConstants.borderRadiusLg),
          ),
          title: Text(
            'Withdraw Cash',
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
                  suffixText: _selectedCurrency['symbol'] ?? '',
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
                'Available: $_buyingPower ${_selectedCurrency['symbol'] ?? ''}',
                style: TextStyle(
                  color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  fontSize: UIConstants.fontSizeSm,
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
              onPressed: () async {
                final amount = amountController.text.trim();
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                final navigator = Navigator.of(context);

                // Validate amount
                if (amount.isEmpty) {
                  navigator.pop();
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text('Please enter an amount'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                final parsedAmount = double.tryParse(amount);
                if (parsedAmount == null || parsedAmount <= 0) {
                  navigator.pop();
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid positive amount'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                // Check if amount exceeds available balance
                final availableBalance = double.tryParse(_buyingPower) ?? 0.0;
                if (parsedAmount > availableBalance) {
                  navigator.pop();
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: Text('Insufficient balance. Available: $_buyingPower ${_selectedCurrency['symbol']}'),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 4),
                    ),
                  );
                  return;
                }

                // Check if we have investor ID and currency
                if (_investorId == null || _investorId!.isEmpty) {
                  navigator.pop();
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text('Investor not found. Please try again.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                if (_selectedCurrency.isEmpty || _selectedCurrency['code'] == null) {
                  navigator.pop();
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text('Please select a currency'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                navigator.pop();

                // Show loading indicator
                scaffoldMessenger.showSnackBar(
                  const SnackBar(
                    content: Text('Withdrawing cash...'),
                    duration: Duration(seconds: 2),
                  ),
                );

                // Call WithdrawCash API
                try {
                  final response = await realGrpcClient.withdrawCash(
                    investorId: _investorId!,
                    currencyCode: _selectedCurrency['code']!,
                    amount: amount,
                  );

                  if (mounted) {
                    if (response['success'] == true) {
                      scaffoldMessenger.showSnackBar(
                        SnackBar(
                          content: Text('Successfully withdrew $amount ${_selectedCurrency['symbol']}'),
                          backgroundColor: Colors.green,
                        ),
                      );

                      // Refresh balance
                      _fetchCashHoldingsForCurrency(_selectedCurrency['code']!);
                    } else {
                      final errorMessage = response['output']?['error'] ??
                                         response['output']?['message'] ??
                                         'Failed to withdraw cash';
                      scaffoldMessenger.showSnackBar(
                        SnackBar(
                          content: Text('Withdrawal failed: $errorMessage'),
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 5),
                        ),
                      );
                    }
                  }
                } catch (e) {
                  if (mounted) {
                    scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: Text('Error: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
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