import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/theme_service.dart';
import '../services/real_grpc_client.dart';
import '../config/ui_constants.dart';
import '../utils/connectivity_checker.dart';
import '../utils/menu_items_helper.dart';
import '../widgets/base_page.dart';

class SecuritiesPage extends StatefulWidget {
  const SecuritiesPage({super.key});

  @override
  State<SecuritiesPage> createState() => _SecuritiesPageState();
}

class _SecuritiesPageState extends State<SecuritiesPage> {
  Map<String, dynamic>? _securitiesData;
  bool _isLoadingSecurities = false;

  // Pagination
  int _currentPage = 0;
  final int _pageSize = 20;

  // Network error state
  bool _showNetworkError = false;
  String _networkErrorMessage = '';

  @override
  void initState() {
    super.initState();

    // Check server connectivity when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkConnectivityAndLoadData();
    });
  }

  Future<void> _checkConnectivityAndLoadData() async {
    try {
      final isConnected = await ConnectivityChecker().checkServerConnectivity();

      if (!isConnected) {
        setState(() {
          _showNetworkError = true;
          _networkErrorMessage = 'Server not reachable';
        });
        if (mounted) {
          _showErrorSnackBar('Server not reachable. Please check your connection.');
        }
        return;
      }

      // Server is reachable, load securitys directly
      await _fetchSecurities();
    } catch (e) {
      print('❌ Error checking connectivity: $e');
      setState(() {
        _showNetworkError = true;
        _networkErrorMessage = 'Connection check failed';
      });
    }
  }

  Future<void> _fetchSecurities({int? page}) async {
    try {
      setState(() {
        _isLoadingSecurities = true;
        _showNetworkError = false;
      });

      final pageToFetch = page ?? _currentPage;

      print('📋 Fetching securities, page: $pageToFetch');

      final securitysResponse = await realGrpcClient.getSecurityList(
        pageNumber: pageToFetch,
        pageSize: _pageSize,
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () => {
          'input': {},
          'output': {'error': 'Request timed out', 'message': 'Securities request timed out after 15 seconds'},
          'requestTime': (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString(),
          'serverType': 'timeout',
          'success': false,
        },
      );

      if (mounted) {
        setState(() {
          _securitiesData = securitysResponse;
          _isLoadingSecurities = false;

          if (page != null) {
            _currentPage = page;
          }
        });

        if (securitysResponse['success'] != true) {
          // Network error occurred
          final error = securitysResponse['output']['error'] ?? 'Unknown error';
          setState(() {
            _showNetworkError = true;
            _networkErrorMessage = error;
          });
          _showErrorSnackBar('Failed to load securities: $error');
        } else {
          setState(() {
            _showNetworkError = false;
          });
        }
      }
    } catch (e) {
      print('❌ Error in _fetchSecurities: $e');
      if (mounted) {
        setState(() {
          _isLoadingSecurities = false;
          _showNetworkError = true;
          _networkErrorMessage = 'Failed to fetch securities: $e';
        });
        _showErrorSnackBar('Network error: Failed to fetch securities');
      }
    }
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: UIConstants.spacingSm),
              Expanded(child: Text(message)),
            ],
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final isDarkTheme = themeService.isDarkTheme;

    return BasePage(
      menuItems: MenuItemsHelper.buildMenuItems(context, 'securities'),
      content: Column(
        children: [
          // Network Error Bar (if error exists)
          if (_showNetworkError)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: const BoxDecoration(
                color: Colors.red,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.white, size: 20),
                  const SizedBox(width: UIConstants.spacingSm),
                  Expanded(
                    child: Text(
                      'Network Error: $_networkErrorMessage',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh, color: Colors.white, size: 20),
                    onPressed: () => _checkConnectivityAndLoadData(),
                    tooltip: 'Retry',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),

          // Main Content
          Expanded(
            child: Padding(
              padding: UIConstants.paddingComfortable,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Securities List
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDarkTheme ? const Color(0xFF1e1e1e) : Colors.white,
                        borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
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
                                  'Securities List',
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
                              padding: UIConstants.paddingComfortable,
                              child: _buildSecuritiesContent(themeService, isDarkTheme),
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
    );
  }

  Widget _buildSecuritiesContent(ThemeService themeService, bool isDarkTheme) {
    if (_isLoadingSecurities) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: UIConstants.spacingMd),
            Text(
              'Loading securities...',
              style: TextStyle(
                fontSize: UIConstants.fontSizeBody,
                color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    if (_securitiesData == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 64,
              color: isDarkTheme ? Colors.grey[600] : Colors.grey[400],
            ),
            const SizedBox(height: UIConstants.spacingMd),
            Text(
              'No securities data available',
              style: TextStyle(
                fontSize: UIConstants.fontSizeMd,
                fontWeight: UIConstants.fontWeightMedium,
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: UIConstants.spacingSm),
            Text(
              'Select a market to view securities',
              style: TextStyle(
                fontSize: UIConstants.fontSizeBody,
                color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    if (_securitiesData!['success'] != true) {
      final output = _securitiesData!['output'] as Map<String, dynamic>?;
      final error = output?['error'] ?? 'Unknown error';
      final details = output?['details'] ?? '';
      final suggestion = output?['suggestion'] ?? '';

      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 24),
              Text(
                error,
                style: TextStyle(
                  fontSize: UIConstants.fontSizeMd,
                  fontWeight: UIConstants.fontWeightMedium,
                  color: isDarkTheme ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              if (details.isNotEmpty) ...[
                const SizedBox(height: UIConstants.spacingSm),
                Text(
                  details,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: UIConstants.fontSizeBody,
                    color: isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                  ),
                ),
              ],
              if (suggestion.isNotEmpty) ...[
                const SizedBox(height: UIConstants.spacingMd),
                Container(
                  padding: UIConstants.paddingStandard,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.lightbulb_outline, color: Colors.blue, size: 20),
                      const SizedBox(width: UIConstants.spacingSm),
                      Expanded(
                        child: Text(
                          suggestion,
                          style: const TextStyle(
                            fontSize: UIConstants.fontSizeSm,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => _fetchSecurities(),
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    // Display securitys list
    final securitysOutput = _securitiesData!['output'] as Map<String, dynamic>;
    final securitys = securitysOutput['securities'] as List<dynamic>? ?? [];

    if (securitys.isEmpty) {
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
              'No securities found',
              style: TextStyle(
                fontSize: UIConstants.fontSizeMd,
                fontWeight: UIConstants.fontWeightMedium,
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: UIConstants.spacingSm),
            Text(
              'This market has no securities',
              style: TextStyle(
                fontSize: UIConstants.fontSizeBody,
                color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: securitys.length,
      itemBuilder: (context, index) {
        final security = securitys[index] as Map<String, dynamic>;
        return Padding(
          padding: EdgeInsets.only(bottom: index < securitys.length - 1 ? 12 : 0),
          child: _buildSecurityItem(security, isDarkTheme),
        );
      },
    );
  }

  Widget _buildSecurityItem(Map<String, dynamic> security, bool isDarkTheme) {
    final securityId = security['id'] ?? security['iid'] ?? 'Unknown';
    final cfiCode = security['cfi_code'] ?? security['cfiCode'] ?? '';
    final issueCurrency = security['issue_currency'] ?? security['issueCurrency'] ?? '';

    // Extract symbol from identifiers if available
    String symbol = securityId;
    final identifiers = security['identifiers'] as List<dynamic>?;
    if (identifiers != null && identifiers.isNotEmpty) {
      for (var id in identifiers) {
        final ids = id['ids'] as List<dynamic>?;
        if (ids != null && ids.isNotEmpty) {
          symbol = ids.first['value'];
          break;
        }
      }
    }

    final status = 'active';
    final minOrderSize = cfiCode.isNotEmpty ? cfiCode : 'N/A';
    final maxOrderSize = issueCurrency.isNotEmpty ? issueCurrency : 'N/A';

    return Container(
      padding: UIConstants.paddingStandard,
      decoration: BoxDecoration(
        color: isDarkTheme ? const Color(0xFF404040) : Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDarkTheme ? Colors.grey[700]! : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Security Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _getColorForSecurity(symbol),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                symbol.length >= 2 ? symbol.substring(0, 2).toUpperCase() : (symbol.isNotEmpty ? symbol.toUpperCase() : '??'),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: UIConstants.fontSizeBody,
                  fontWeight: UIConstants.fontWeightMedium,
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Security Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      symbol,
                      style: TextStyle(
                        fontSize: UIConstants.fontSizeMd,
                        fontWeight: UIConstants.fontWeightMedium,
                        color: isDarkTheme ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(width: UIConstants.spacingSm),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(status),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        status.toString().toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: UIConstants.fontSizeXs,
                          fontWeight: UIConstants.fontWeightMedium,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: UIConstants.spacingSm),
                Text(
                  'ID: $securityId',
                  style: TextStyle(
                    fontSize: UIConstants.fontSizeSm,
                    color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // Security Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'CFI: $minOrderSize',
                style: TextStyle(
                  fontSize: UIConstants.fontSizeSm,
                  color: isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Currency: $maxOrderSize',
                style: TextStyle(
                  fontSize: UIConstants.fontSizeSm,
                  color: isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getColorForSecurity(String baseCurrency) {
    switch (baseCurrency.toUpperCase()) {
      case 'BTC':
        return const Color(0xFFF7931A);
      case 'ETH':
        return const Color(0xFF627EEA);
      case 'XRP':
        return const Color(0xFF23292F);
      case 'OXC':
        return const Color(0xFF85BB65);
      case 'USD':
      case 'USDT':
        return const Color(0xFF26A69A);
      default:
        return const Color(0xFF6B73FF);
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'enabled':
        return Colors.green;
      case 'disabled':
      case 'inactive':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}