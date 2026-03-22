import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/theme_service.dart';
import '../services/real_grpc_client.dart';
import '../config/ui_constants.dart';
import '../utils/connectivity_checker.dart';
import '../utils/menu_items_helper.dart';
import '../widgets/base_page.dart';
import '../widgets/detail_modal.dart';
import '../widgets/styled_data_table.dart';

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
        UIConstants.errorSnackBar(message),
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
                        color: UIConstants.pageBackground(isDarkTheme),
                        borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Table header
                          Container(
                            padding: UIConstants.paddingStandard,
                            decoration: BoxDecoration(
                              color: UIConstants.tableHeaderBackground(isDarkTheme),
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
                                    color: UIConstants.textPrimary(isDarkTheme),
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: Icon(Icons.refresh, color: UIConstants.textSecondary(isDarkTheme), size: 20),
                                  onPressed: _isLoadingSecurities ? null : () => _fetchSecurities(),
                                  tooltip: 'Refresh',
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
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
                color: UIConstants.textSecondary(isDarkTheme),
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
              color: UIConstants.textHint(isDarkTheme),
            ),
            const SizedBox(height: UIConstants.spacingMd),
            Text(
              'No securities data available',
              style: TextStyle(
                fontSize: UIConstants.fontSizeMd,
                fontWeight: UIConstants.fontWeightMedium,
                color: UIConstants.textPrimary(isDarkTheme),
              ),
            ),
            const SizedBox(height: UIConstants.spacingSm),
            Text(
              'Select a market to view securities',
              style: TextStyle(
                fontSize: UIConstants.fontSizeBody,
                color: UIConstants.textSecondary(isDarkTheme),
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
                  color: UIConstants.textPrimary(isDarkTheme),
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
                    color: UIConstants.textSecondary(isDarkTheme),
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

    // Display security listings
    final securitysOutput = _securitiesData!['output'] as Map<String, dynamic>;
    final listings = securitysOutput['securityListings'] as List<dynamic>?
        ?? securitysOutput['security_listings'] as List<dynamic>?
        ?? [];

    if (listings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox,
              size: 64,
              color: UIConstants.textHint(isDarkTheme),
            ),
            const SizedBox(height: UIConstants.spacingMd),
            Text(
              'No security listings found',
              style: TextStyle(
                fontSize: UIConstants.fontSizeMd,
                fontWeight: UIConstants.fontWeightMedium,
                color: UIConstants.textPrimary(isDarkTheme),
              ),
            ),
          ],
        ),
      );
    }

    final cellStyle = StyledDataTable.cellStyle(isDarkTheme);
    final symbolStyle = cellStyle.copyWith(fontWeight: UIConstants.fontWeightMedium);

    final columns = [
      const StyledColumn(label: 'Symbol', flex: 1),
      const StyledColumn(label: 'Type', flex: 1),
      const StyledColumn(label: 'Currency', flex: 1),
      const StyledColumn(label: 'Tick', flex: 1),
      const StyledColumn(label: 'Venue', flex: 1),
      const StyledColumn(label: 'Status', flex: 1),
    ];

    final rows = listings.map((item) {
      final listing = item as Map<String, dynamic>;
      final symbol = listing['symbol'] ?? '';
      final securityType = listing['securityType'] ?? '';
      final cfiCode = listing['cfiCode'] ?? '';
      final currency = listing['currency'] ?? '';
      final minPriceIncrement = listing['minPriceIncrement'] ?? '';
      final venueSymbol = listing['venueSymbol'] ?? '';
      final rawStatus = listing['securityStatus'] ?? '';

      final typeDisplay = cfiCode.toString().isNotEmpty ? '$securityType / $cfiCode' : securityType;
      final statusLabel = _formatSecurityStatus(rawStatus.toString());

      return StyledRow(
        onTap: () => _showSecurityDetailModal(listing),
        cells: [
          Text(symbol.toString(), style: symbolStyle, overflow: TextOverflow.ellipsis),
          Text(typeDisplay.toString(), style: cellStyle, overflow: TextOverflow.ellipsis),
          Text(currency.toString(), style: cellStyle),
          Text(minPriceIncrement.toString(), style: cellStyle),
          Text(venueSymbol.toString(), style: cellStyle, overflow: TextOverflow.ellipsis),
          _statusBadge(statusLabel),
        ],
      );
    }).toList();

    return StyledDataTable(
      isDarkTheme: isDarkTheme,
      columns: columns,
      rows: rows,
    );
  }

  void _showSecurityDetailModal(Map<String, dynamic> listing) {
    final themeService = Provider.of<ThemeService>(context, listen: false);
    final isDarkTheme = themeService.isDarkTheme;
    final symbol = (listing['symbol'] ?? '').toString();

    DetailModal.show(
      context,
      title: '$symbol — Security Details',
      isDarkTheme: isDarkTheme,
      fields: {
        'Symbol': symbol,
        'Security ID': (listing['securityId'] ?? '').toString(),
        'Security ID Source': (listing['securityIdSource'] ?? '').toString(),
        'Security Type': (listing['securityType'] ?? '').toString(),
        'CFI Code': (listing['cfiCode'] ?? '').toString(),
        'Security Exchange': (listing['securityExchange'] ?? '').toString(),
        'Security Description': (listing['securityDesc'] ?? '').toString(),
        'Security Status': _formatSecurityStatus((listing['securityStatus'] ?? '').toString()),
        'Currency': (listing['currency'] ?? '').toString(),
        'Min Price Increment': (listing['minPriceIncrement'] ?? '').toString(),
        'Price Type': (listing['priceType'] ?? '').toString(),
        'Trade Date': (listing['tradeDate'] ?? '').toString(),
        'No Tick Rules': (listing['noTickRules'] ?? '').toString(),
        'Start Tick Price Range': (listing['startTickPriceRange'] ?? '').toString(),
        'End Tick Price Range': (listing['endTickPriceRange'] ?? '').toString(),
        'Tick Increment': (listing['tickIncrement'] ?? '').toString(),
        'No Security Alt ID': (listing['noSecurityAltId'] ?? '').toString(),
        'Security Alt ID': (listing['securityAltId'] ?? '').toString(),
        'Security Alt ID Source': (listing['securityAltIdSource'] ?? '').toString(),
        'Security Listing IID': (listing['securityListingIid'] ?? '').toString(),
        'Venue IID': (listing['venueIid'] ?? '').toString(),
        'Venue Symbol': (listing['venueSymbol'] ?? '').toString(),
      },
    );
  }

  /// FIX Tag 965 SecurityStatus:
  /// 1 = Active, 2 = Inactive, others mapped as needed
  String _formatSecurityStatus(String raw) {
    // Handle enum-style values
    if (raw.contains('SECURITY_LISTING_STATUS_ENUM_')) {
      final stripped = raw
          .replaceAll('SECURITY_LISTING_STATUS_ENUM_', '')
          .replaceAll('_', ' ');
      if (stripped.isEmpty) return 'Unknown';
      return stripped[0].toUpperCase() + stripped.substring(1).toLowerCase();
    }
    // Handle FIX numeric status codes
    switch (raw) {
      case '1': return 'Active';
      case '2': return 'Inactive';
      case '3': return 'Active';
      default: return raw.isNotEmpty ? raw : 'Unknown';
    }
  }

  Widget _statusBadge(String status) {
    final color = _getStatusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: UIConstants.fontSizeXs,
          fontWeight: UIConstants.fontWeightMedium,
          color: color,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'listed':
      case 'enabled':
        return Colors.green;
      case 'inactive':
      case 'suspended':
      case 'halted':
        return Colors.orange;
      case 'delisted':
      case 'liquidated':
      case 'disabled':
        return Colors.red;
      case 'pending':
      case 'pre listing':
      case 'when issued':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}