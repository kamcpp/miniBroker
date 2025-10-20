import 'package:flutter/material.dart';
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
            // Fetch cash holdings for the initially selected currency
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _fetchCashHoldings();
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
    final themeService = Provider.of<ThemeService>(context);
    final isDarkTheme = themeService.isDarkTheme;

    return BasePage(
      menuItems: MenuItemsHelper.buildMenuItems(context, 'cash'),
      content: Padding(
        padding: UIConstants.paddingStandard,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cash Management Section
            Expanded(
                      child: Container(
                        padding: UIConstants.paddingStandard,
                        decoration: BoxDecoration(
                          color: isDarkTheme ? const Color(0xFF2A2A2A) : Colors.white,
                          borderRadius: BorderRadius.circular(UIConstants.borderRadiusMd),
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
                              'Cash Management',
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeMd,
                                fontWeight: UIConstants.fontWeightMedium,
                                color: isDarkTheme ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: UIConstants.spacingMd),
                            _buildBalanceContent(themeService, isDarkTheme),
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
      padding: UIConstants.paddingStandard,
      height:220,
      decoration: BoxDecoration(
        color: isDarkTheme ? const Color(0xFF404040) : Colors.grey[50],
        borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
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
              width: 180,
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
                      _fetchCashHoldingsForCurrency(newValue['asset_id']!);
                    }
                  },
                  dropdownColor: isDarkTheme ? const Color(0xFF1e1e1e) : Colors.white,
                  style: TextStyle(
                    color: isDarkTheme ? Colors.white : Colors.black,
                    fontSize: UIConstants.fontSizeSm, // Smaller font for more compact appearance
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
                  backgroundColor: const Color(0xFF4CAF50),
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
                  backgroundColor: const Color(0xFFFF4081),
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '0.00',
                  suffixText: _selectedCurrency['symbol'] ?? '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
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

                // Check if we have account ID and currency
                if (_cachedAccountId == null || _cachedAccountId!.isEmpty) {
                  navigator.pop();
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text('Account not found. Please try again.'),
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
                    accountId: _cachedAccountId!,
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
                      _fetchCashHoldingsForCurrency(_selectedCurrency['asset_id']!);
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '0.00',
                  suffixText: _selectedCurrency['symbol'] ?? '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
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

                // Check if we have account ID and currency
                if (_cachedAccountId == null || _cachedAccountId!.isEmpty) {
                  navigator.pop();
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text('Account not found. Please try again.'),
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
                    accountId: _cachedAccountId!,
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
                      _fetchCashHoldingsForCurrency(_selectedCurrency['asset_id']!);
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
                backgroundColor: Colors.red,
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