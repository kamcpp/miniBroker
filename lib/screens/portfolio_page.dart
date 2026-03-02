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
  String? _selectedCashToken;
  Map<String, String> _securityIidToSymbol = {};
  // Cash token info: key (IID, currency code, ticker) → {currency, divisibility}
  Map<String, Map<String, String>> _cashTokenInfo = {};

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

        final tokenInfo = <String, Map<String, String>>{};
        for (final token in cashTokens) {
          if (token is Map<String, dynamic>) {
            final issueCurrency = token['issueCurrency'] as String? ??
                token['issue_currency'] as String? ?? '';
            final issueDivisibility = token['issueDivisibility']?.toString() ??
                token['issue_divisibility']?.toString() ?? '';
            final iid = token['iid']?.toString() ?? '';
            final entry = {'currency': issueCurrency, 'divisibility': issueDivisibility};

            // Collect all possible codes so we match however the holdings map keys them
            final identifiers = token['identifiers'] as List<dynamic>? ?? [];
            for (final identifier in identifiers) {
              if (identifier is Map<String, dynamic>) {
                final ids = identifier['ids'] as List<dynamic>? ?? [];
                for (final id in ids) {
                  if (id is Map<String, dynamic>) {
                    final value = id['value'] as String? ?? '';
                    if (value.isNotEmpty) {
                      codes.add(value);
                      tokenInfo[value] = entry;
                    }
                  }
                }
              }
            }
            if (issueCurrency.isNotEmpty) {
              codes.add(issueCurrency);
              tokenInfo[issueCurrency] = entry;
            }
            if (iid.isNotEmpty) {
              codes.add(iid);
              tokenInfo[iid] = entry;
            }
          }
        }
        print('✅ Supported cash token codes: $codes');

        if (mounted) {
          setState(() {
            _supportedCashTokenCodes = codes;
            _cashTokenInfo = tokenInfo;
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

      // Log individual security balances
      if (response['success'] == true) {
        final output = response['output'] as Map<String, dynamic>? ?? {};
        final portfolio = output['portfolio'] as Map<String, dynamic>? ?? {};
        final holdings = portfolio['holdings'] as Map<String, dynamic>? ?? {};
        print('📊 Security holdings count: ${holdings.length}');
        for (final entry in holdings.entries) {
          final holdingData = entry.value as Map<String, dynamic>? ?? {};
          final totalUnits = holdingData['totalUnits'] ?? holdingData['total_units'] ?? '0';
          final stashUnits = holdingData['stashUnits'] ?? holdingData['stash_units'] ?? {};
          print('📊 Security [${entry.key}]: total=$totalUnits, stashes=$stashUnits');
        }
      }

      // Set holdings data first, then resolve symbols asynchronously
      if (mounted) {
        setState(() {
          _securityHoldingsData = response;
          _isLoadingSecurities = false;
        });
      }

      // Resolve IIDs to symbols in the background (non-blocking)
      if (response['success'] == true) {
        final output = response['output'] as Map<String, dynamic>? ?? {};
        final portfolio = output['portfolio'] as Map<String, dynamic>? ?? {};
        final holdings = portfolio['holdings'] as Map<String, dynamic>? ?? {};
        if (holdings.isNotEmpty) {
          _resolveSecuritySymbols(holdings.keys.toList());
        }
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

  Future<void> _resolveSecuritySymbols(List<String> iids) async {
    try {
      final result = await GrpcurlHelper.getSecurityListingInfoBatch(
        symbolAndSecurityIdRegexes: iids,
      ).timeout(
        const Duration(minutes: 5),
        onTimeout: () => {
          'success': false,
          'output': {'error': 'Request timed out'},
        },
      );

      if (result['success'] == true) {
        final output = result['output'] as Map<String, dynamic>? ?? {};
        final listings = output['securityListings'] ?? output['security_listings'];
        final listingsList = listings is List<dynamic> ? listings : <dynamic>[];
        final symbolMap = <String, String>{};

        print('📊 SecurityListingInfoBatch returned ${listingsList.length} listings');

        for (final listing in listingsList) {
          if (listing is Map<String, dynamic>) {
            final securityId = listing['securityId'] ?? listing['security_id'] ?? '';
            final symbol = listing['symbol']?.toString() ?? '';

            if (securityId.toString().isNotEmpty && symbol.isNotEmpty) {
              symbolMap[securityId.toString()] = symbol;
              print('📊 Resolved security ID $securityId -> $symbol');
            }
          }
        }

        if (mounted && symbolMap.isNotEmpty) {
          setState(() {
            _securityIidToSymbol = symbolMap;
          });
        }
      } else {
        print('⚠️ Failed to resolve security symbols: ${result['output']?['error']}');
      }
    } catch (e) {
      print('⚠️ Error resolving security symbols: $e');
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

      // Log individual cash balances
      if (response['success'] == true) {
        final output = response['output'] as Map<String, dynamic>? ?? {};
        final cashPortfolio = output['cashPortfolio'] as Map<String, dynamic>? ??
            output['cash_portfolio'] as Map<String, dynamic>? ?? {};
        final holdings = cashPortfolio['holdings'] as Map<String, dynamic>? ?? {};
        print('💰 Cash holdings count: ${holdings.length}');
        for (final entry in holdings.entries) {
          final holdingData = entry.value as Map<String, dynamic>? ?? {};
          final totalUnits = holdingData['totalUnits'] ?? holdingData['total_units'] ?? '0';
          final stashUnits = holdingData['stashUnits'] ?? holdingData['stash_units'] ?? {};
          print('💰 Cash [${entry.key}]: total=$totalUnits, stashes=$stashUnits');
        }
      }

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
            // Deposit/Withdraw row with cash token selector
            Row(
              children: [
                // Cash token dropdown
                SizedBox(
                  width: 180,
                  height: UIConstants.buttonHeightStandard,
                  child: DropdownButtonFormField<String>(
                    value: _selectedCashToken,
                    decoration: InputDecoration(
                      labelText: 'Cash Token',
                      labelStyle: TextStyle(
                        color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                        fontSize: UIConstants.fontSizeSm,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                      ),
                      contentPadding: UIConstants.textFieldContentPadding,
                      isDense: true,
                      filled: true,
                      fillColor: isDarkTheme ? UIConstants.colorDarkFill : Colors.white,
                    ),
                    dropdownColor: isDarkTheme ? UIConstants.colorDarkFill : Colors.white,
                    style: TextStyle(
                      color: isDarkTheme ? Colors.white : Colors.black,
                      fontSize: UIConstants.fontSizeBody,
                    ),
                    items: _getAvailableCashTokens().map((code) {
                      return DropdownMenuItem<String>(
                        value: code,
                        child: Text(code),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCashToken = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                // Deposit button
                SizedBox(
                  height: UIConstants.buttonHeightStandard,
                  child: ElevatedButton.icon(
                    onPressed: _selectedCashToken == null ? null : () => _showDepositDialog(_selectedCashToken!),
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Deposit'),
                    style: UIConstants.buttonStyle(UIConstants.colorAccept),
                  ),
                ),
                const SizedBox(width: 8),
                // Withdraw button
                SizedBox(
                  height: UIConstants.buttonHeightStandard,
                  child: ElevatedButton.icon(
                    onPressed: _selectedCashToken == null ? null : () {
                      final availableBalance = _getAvailableBalanceForToken(_selectedCashToken!);
                      _showWithdrawDialog(_selectedCashToken!, availableBalance);
                    },
                    icon: const Icon(Icons.remove, size: 16),
                    label: const Text('Withdraw'),
                    style: UIConstants.buttonStyle(UIConstants.colorReject),
                  ),
                ),
                const Spacer(),
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
              color: isDarkTheme ? UIConstants.colorDarkFill : Colors.grey[50],
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
    print('📊 _buildSecurityHoldingsContent: portfolio keys=${portfolio.keys.toList()}, holdings keys=${holdings.keys.toList()}');
    if (holdings.isNotEmpty) {
      final firstEntry = holdings.entries.first;
      print('📊 First holding entry: key=${firstEntry.key}, value=${firstEntry.value}');
    }

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
            color: isDarkTheme ? UIConstants.colorDarkFill : Colors.grey[100],
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
              final securityIid = entry.key;
              final symbol = _securityIidToSymbol[securityIid] ?? securityIid;
              final holdingData = entry.value as Map<String, dynamic>? ?? {};
              final totalUnits = holdingData['totalUnits']?.toString()
                  ?? holdingData['total_units']?.toString() ?? '0';
              final availableUnits = _getAvailableFromHolding(holdingData);
              final lockedUnits = _getLockedFromHolding(holdingData);

              return Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Tooltip(
                        message: securityIid,
                        child: Text(
                          symbol,
                          style: TextStyle(
                            fontSize: UIConstants.fontSizeBody,
                            fontWeight: UIConstants.fontWeightMedium,
                            color: isDarkTheme ? Colors.white : Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
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
            color: isDarkTheme ? UIConstants.colorDarkFill : Colors.grey[100],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              _buildHeaderCell('Currency', flex: 2, isDarkTheme: isDarkTheme),
              _buildHeaderCell('Div', flex: 1, isDarkTheme: isDarkTheme),
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
              final totalBalanceRaw = holdingData['totalUnits']?.toString()
                  ?? holdingData['total_units']?.toString() ?? '0';
              final availableBalanceRaw = _getAvailableFromHolding(holdingData);
              final reservedBalanceRaw = _getLockedFromHolding(holdingData);

              // Look up divisibility from cash token info, fallback to default for fiat
              final info = _cashTokenInfo[currencyCode];
              var divisibility = info?['divisibility'] ?? '';
              if (divisibility.isEmpty) {
                divisibility = _defaultDivisibility(currencyCode);
              }

              final totalBalance = _formatAmountWithDivisibility(totalBalanceRaw, divisibility);
              final availableBalance = _formatAmountWithDivisibility(availableBalanceRaw, divisibility);
              final reservedBalance = _formatAmountWithDivisibility(reservedBalanceRaw, divisibility);

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
                    _buildDataCell(divisibility, flex: 1, isDarkTheme: isDarkTheme),
                    _buildDataCell(totalBalance, flex: 2, isDarkTheme: isDarkTheme),
                    _buildDataCell(availableBalance, flex: 2, isDarkTheme: isDarkTheme, color: Colors.green),
                    _buildDataCell(reservedBalance, flex: 2, isDarkTheme: isDarkTheme, color: Colors.orange),
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

  List<String> _getAvailableCashTokens() {
    if (_cashHoldingsData == null || _cashHoldingsData!['success'] != true) {
      return _supportedCashTokenCodes.toList()..sort();
    }
    final output = _cashHoldingsData!['output'] as Map<String, dynamic>;
    final cashPortfolio = output['cashPortfolio'] as Map<String, dynamic>? ?? {};
    final holdings = cashPortfolio['holdings'] as Map<String, dynamic>? ?? {};

    // Combine holdings keys with supported cash token codes, only 3-letter codes
    final allCodes = <String>{};
    if (_supportedCashTokenCodes.isNotEmpty) {
      for (final key in holdings.keys) {
        if (_supportedCashTokenCodes.contains(key) && key.length == 3) {
          allCodes.add(key);
        }
      }
      for (final code in _supportedCashTokenCodes) {
        if (code.length == 3) allCodes.add(code);
      }
    } else {
      for (final key in holdings.keys) {
        if (key.length == 3) allCodes.add(key);
      }
    }
    return allCodes.toList()..sort();
  }

  /// Format an amount using divisibility (decimal places).
  /// If the amount already contains a decimal point, format to correct decimal places.
  /// If it's a raw integer, divide by 10^divisibility.
  String _formatAmountWithDivisibility(String rawAmount, String? divisibility) {
    if (divisibility == null || divisibility.isEmpty) {
      try {
        final value = double.parse(rawAmount);
        if (rawAmount.contains('.')) return rawAmount;
        return value.toStringAsFixed(0);
      } catch (_) {
        return rawAmount;
      }
    }
    try {
      final decimals = int.parse(divisibility);
      if (decimals <= 0) return rawAmount;
      final value = double.parse(rawAmount);

      if (rawAmount.contains('.')) {
        return value.toStringAsFixed(decimals);
      } else {
        double divisor = 1;
        for (var i = 0; i < decimals; i++) {
          divisor *= 10;
        }
        return (value / divisor).toStringAsFixed(decimals);
      }
    } catch (_) {
      return rawAmount;
    }
  }

  /// Default divisibility for known fiat currencies when server doesn't return it.
  String _defaultDivisibility(String currencyCode) {
    final code = currencyCode.toUpperCase();
    // Extract 3-letter currency code if the key is longer (e.g. "EUR" from "EUR_TOKENISE_BROKER")
    final shortCode = code.length >= 3 ? code.substring(0, 3) : code;
    const zeroDivisibility = {'JPY', 'KRW', 'VND', 'CLP'};
    if (zeroDivisibility.contains(shortCode)) return '0';
    // Most fiat currencies use 2 decimal places
    const threeDivisibility = {'BHD', 'KWD', 'OMR'};
    if (threeDivisibility.contains(shortCode)) return '3';
    return '2';
  }

  /// Extract available units from a holding entry.
  /// The proto Holdings has total_units and stash_units (map<string,string>).
  /// Available balance comes from stashUnits['available'] or ['LIQUID'], falling back to totalUnits.
  String _getAvailableFromHolding(Map<String, dynamic> holdingData) {
    final stashUnits = holdingData['stashUnits'] as Map<String, dynamic>?
        ?? holdingData['stash_units'] as Map<String, dynamic>? ?? {};
    if (stashUnits.containsKey('available')) {
      return stashUnits['available']?.toString() ?? '0';
    }
    if (stashUnits.containsKey('LIQUID')) {
      return stashUnits['LIQUID']?.toString() ?? '0';
    }
    // If no stash breakdown, total = available
    return holdingData['totalUnits']?.toString()
        ?? holdingData['total_units']?.toString() ?? '0';
  }

  /// Extract locked/reserved units from a holding entry.
  String _getLockedFromHolding(Map<String, dynamic> holdingData) {
    final stashUnits = holdingData['stashUnits'] as Map<String, dynamic>?
        ?? holdingData['stash_units'] as Map<String, dynamic>? ?? {};
    if (stashUnits.containsKey('locked')) {
      return stashUnits['locked']?.toString() ?? '0';
    }
    if (stashUnits.containsKey('LOCKED')) {
      return stashUnits['LOCKED']?.toString() ?? '0';
    }
    if (stashUnits.containsKey('reserved')) {
      return stashUnits['reserved']?.toString() ?? '0';
    }
    // If stashUnits has 'available' or 'LIQUID', locked = total - available
    final availableKey = stashUnits.containsKey('available') ? 'available' :
        stashUnits.containsKey('LIQUID') ? 'LIQUID' : null;
    if (availableKey != null) {
      final totalStr = holdingData['totalUnits']?.toString()
          ?? holdingData['total_units']?.toString() ?? '0';
      final total = double.tryParse(totalStr) ?? 0;
      final available = double.tryParse(stashUnits[availableKey]?.toString() ?? '0') ?? 0;
      final locked = total - available;
      return locked > 0 ? locked.toString() : '0';
    }
    return '0';
  }

  String _getAvailableBalanceForToken(String currencyCode) {
    if (_cashHoldingsData == null || _cashHoldingsData!['success'] != true) {
      return '0';
    }
    final output = _cashHoldingsData!['output'] as Map<String, dynamic>;
    final cashPortfolio = output['cashPortfolio'] as Map<String, dynamic>? ?? {};
    final holdings = cashPortfolio['holdings'] as Map<String, dynamic>? ?? {};
    final holdingData = holdings[currencyCode] as Map<String, dynamic>? ?? {};
    return _getAvailableFromHolding(holdingData);
  }

  void _showDepositDialog(String currencyCode) {
    final themeService = Provider.of<ThemeService>(context, listen: false);
    final isDarkTheme = themeService.isDarkTheme;
    final amountController = TextEditingController();
    final pageScaffoldMessenger = ScaffoldMessenger.of(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        bool isLoading = false;
        String? errorText;

        return StatefulBuilder(
          builder: (context, setDialogState) {
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
                  if (isLoading) ...[
                    const Center(child: CircularProgressIndicator()),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        'Depositing...',
                        style: TextStyle(color: isDarkTheme ? Colors.grey[400] : Colors.grey[600]),
                      ),
                    ),
                  ] else ...[
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
                        errorText: errorText,
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
                ],
              ),
              actions: isLoading ? null : [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
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

                    if (amount.isEmpty) {
                      setDialogState(() => errorText = 'Please enter an amount');
                      return;
                    }

                    final parsedAmount = double.tryParse(amount);
                    if (parsedAmount == null || parsedAmount <= 0) {
                      setDialogState(() => errorText = 'Please enter a valid positive amount');
                      return;
                    }

                    if (_investorId == null || _investorId!.isEmpty) {
                      setDialogState(() => errorText = 'Investor not found');
                      return;
                    }

                    setDialogState(() {
                      isLoading = true;
                      errorText = null;
                    });

                    try {
                      final response = await GrpcurlHelper.depositCash(
                        investorId: _investorId!,
                        currencyCode: currencyCode,
                        amount: amount,
                      );

                      if (!mounted) return;
                      Navigator.of(dialogContext).pop();

                      if (response['success'] == true) {
                        pageScaffoldMessenger.showSnackBar(
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
                        pageScaffoldMessenger.showSnackBar(
                          SnackBar(content: Text('Deposit failed: $errorMessage'), backgroundColor: Colors.red, duration: const Duration(seconds: 5)),
                        );
                      }
                    } catch (e) {
                      if (!mounted) return;
                      Navigator.of(dialogContext).pop();
                      pageScaffoldMessenger.showSnackBar(
                        SnackBar(content: Text('Error: ${e.toString()}'), backgroundColor: Colors.red),
                      );
                    }
                  },
                  style: UIConstants.buttonStyle(UIConstants.colorAccept),
                  child: const Text('Deposit', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showWithdrawDialog(String currencyCode, String availableBalance) {
    final themeService = Provider.of<ThemeService>(context, listen: false);
    final isDarkTheme = themeService.isDarkTheme;
    final amountController = TextEditingController();
    final pageScaffoldMessenger = ScaffoldMessenger.of(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        bool isLoading = false;
        String? errorText;

        return StatefulBuilder(
          builder: (context, setDialogState) {
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
                  if (isLoading) ...[
                    const Center(child: CircularProgressIndicator()),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        'Withdrawing...',
                        style: TextStyle(color: isDarkTheme ? Colors.grey[400] : Colors.grey[600]),
                      ),
                    ),
                  ] else ...[
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
                        errorText: errorText,
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
                ],
              ),
              actions: isLoading ? null : [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
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

                    if (amount.isEmpty) {
                      setDialogState(() => errorText = 'Please enter an amount');
                      return;
                    }

                    final parsedAmount = double.tryParse(amount);
                    if (parsedAmount == null || parsedAmount <= 0) {
                      setDialogState(() => errorText = 'Please enter a valid positive amount');
                      return;
                    }

                    final availBal = double.tryParse(availableBalance) ?? 0.0;
                    if (parsedAmount > availBal) {
                      setDialogState(() => errorText = 'Insufficient balance. Available: ${_formatCurrency(availableBalance, currencyCode)}');
                      return;
                    }

                    if (_investorId == null || _investorId!.isEmpty) {
                      setDialogState(() => errorText = 'Investor not found');
                      return;
                    }

                    setDialogState(() {
                      isLoading = true;
                      errorText = null;
                    });

                    try {
                      final response = await GrpcurlHelper.withdrawCash(
                        investorId: _investorId!,
                        currencyCode: currencyCode,
                        amount: amount,
                      );

                      if (!mounted) return;
                      Navigator.of(dialogContext).pop();

                      if (response['success'] == true) {
                        pageScaffoldMessenger.showSnackBar(
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
                        pageScaffoldMessenger.showSnackBar(
                          SnackBar(content: Text('Withdrawal failed: $errorMessage'), backgroundColor: Colors.red, duration: const Duration(seconds: 5)),
                        );
                      }
                    } catch (e) {
                      if (!mounted) return;
                      Navigator.of(dialogContext).pop();
                      pageScaffoldMessenger.showSnackBar(
                        SnackBar(content: Text('Error: ${e.toString()}'), backgroundColor: Colors.red),
                      );
                    }
                  },
                  style: UIConstants.buttonStyle(UIConstants.colorReject),
                  child: const Text('Withdraw', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
