import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/theme_service.dart';
import '../services/real_grpc_client.dart';
import '../config/ui_constants.dart';
import '../utils/connectivity_checker.dart';
import 'portfolio_page.dart';
import 'trading_page.dart';
import 'Cash_management_page.dart';
import 'activity_page.dart';
import 'profile_page.dart';
import 'users_admin_page.dart';

class InstrumentsPage extends StatefulWidget {
  const InstrumentsPage({super.key});

  @override
  State<InstrumentsPage> createState() => _InstrumentsPageState();
}

class _InstrumentsPageState extends State<InstrumentsPage> {
  Map<String, dynamic>? _instrumentsData;
  bool _isLoadingInstruments = false;

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

      // Server is reachable, load instruments directly
      await _fetchInstruments();
    } catch (e) {
      print('❌ Error checking connectivity: $e');
      setState(() {
        _showNetworkError = true;
        _networkErrorMessage = 'Connection check failed';
      });
    }
  }

  Future<void> _fetchInstruments({int? page}) async {
    try {
      setState(() {
        _isLoadingInstruments = true;
        _showNetworkError = false;
      });

      final pageToFetch = page ?? _currentPage;

      print('📋 Fetching instruments, page: $pageToFetch');

      final instrumentsResponse = await realGrpcClient.getInstrumentList(
        pageNumber: pageToFetch,
        pageSize: _pageSize,
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () => {
          'input': {},
          'output': {'error': 'Request timed out', 'message': 'Instruments request timed out after 15 seconds'},
          'requestTime': (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString(),
          'serverType': 'timeout',
          'success': false,
        },
      );

      if (mounted) {
        setState(() {
          _instrumentsData = instrumentsResponse;
          _isLoadingInstruments = false;

          if (page != null) {
            _currentPage = page;
          }
        });

        if (instrumentsResponse['success'] != true) {
          // Network error occurred
          final error = instrumentsResponse['output']['error'] ?? 'Unknown error';
          setState(() {
            _showNetworkError = true;
            _networkErrorMessage = error;
          });
          _showErrorSnackBar('Failed to load instruments: $error');
        } else {
          setState(() {
            _showNetworkError = false;
          });
        }
      }
    } catch (e) {
      print('❌ Error in _fetchInstruments: $e');
      if (mounted) {
        setState(() {
          _isLoadingInstruments = false;
          _showNetworkError = true;
          _networkErrorMessage = 'Failed to fetch instruments: $e';
        });
        _showErrorSnackBar('Network error: Failed to fetch instruments');
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
    final authService = Provider.of<AuthService>(context);
    final themeService = Provider.of<ThemeService>(context);
    final isDarkTheme = themeService.isDarkTheme;

    return Theme(
      data: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        backgroundColor: isDarkTheme ? const Color(0x000000) : Colors.grey[100],
        body: Column(
          children: [
            // Header Section
            _buildHeader(authService, themeService),

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
                    // Market Selector and Title Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Instruments',
                          style: TextStyle(
                            fontSize: UIConstants.fontSizeLg,
                            fontWeight: UIConstants.fontWeightMedium,
                            color: isDarkTheme ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: UIConstants.spacingMd),

                    // Instruments List
                    Expanded(
                      child: Container(
                        padding: UIConstants.paddingComfortable,
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
                            Expanded(
                              child: _buildInstrumentsContent(themeService, isDarkTheme),
                            ),
                            // Pagination Controls
                            if (_instrumentsData != null && _instrumentsData!['success'] == true)
                              _buildPaginationControls(isDarkTheme),
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

  Widget _buildInstrumentsContent(ThemeService themeService, bool isDarkTheme) {
    if (_isLoadingInstruments) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: UIConstants.spacingMd),
            Text(
              'Loading instruments...',
              style: TextStyle(
                fontSize: UIConstants.fontSizeBody,
                color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    if (_instrumentsData == null) {
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
              'No instruments data available',
              style: TextStyle(
                fontSize: UIConstants.fontSizeMd,
                fontWeight: UIConstants.fontWeightMedium,
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: UIConstants.spacingSm),
            Text(
              'Select a market to view instruments',
              style: TextStyle(
                fontSize: UIConstants.fontSizeBody,
                color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    if (_instrumentsData!['success'] != true) {
      final output = _instrumentsData!['output'] as Map<String, dynamic>?;
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
                    borderRadius: BorderRadius.circular(UIConstants.borderRadiusSm),
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
                onPressed: () => _fetchInstruments(),
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    // Display instruments list
    final instrumentsOutput = _instrumentsData!['output'] as Map<String, dynamic>;
    final instruments = instrumentsOutput['instruments'] as List<dynamic>? ?? [];

    if (instruments.isEmpty) {
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
              'No instruments found',
              style: TextStyle(
                fontSize: UIConstants.fontSizeMd,
                fontWeight: UIConstants.fontWeightMedium,
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: UIConstants.spacingSm),
            Text(
              'This market has no instruments',
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
      itemCount: instruments.length,
      itemBuilder: (context, index) {
        final instrument = instruments[index] as Map<String, dynamic>;
        return Padding(
          padding: EdgeInsets.only(bottom: index < instruments.length - 1 ? 12 : 0),
          child: _buildInstrumentItem(instrument, themeService, isDarkTheme),
        );
      },
    );
  }

  Widget _buildInstrumentItem(
    Map<String, dynamic> instrument,
    ThemeService themeService,
    bool isDarkTheme,
  ) {
    final instrumentId = instrument['id'] ?? instrument['iid'] ?? 'Unknown';
    final cfiCode = instrument['cfi_code'] ?? instrument['cfiCode'] ?? '';
    final issueCurrency = instrument['issue_currency'] ?? instrument['issueCurrency'] ?? '';

    // Extract symbol from identifiers if available
    String symbol = instrumentId;
    final identifiers = instrument['identifiers'] as List<dynamic>?;
    if (identifiers != null && identifiers.isNotEmpty) {
      for (var id in identifiers) {
        final ids = id['ids'] as List<dynamic>?;
        if (ids != null && ids.isNotEmpty) {
          symbol = ids.first.toString();
          break;
        }
      }
    }

    // Instrument doesn't have these fields - they're on InstrumentListing
    final status = 'active';
    final minOrderSize = cfiCode.isNotEmpty ? cfiCode : 'N/A';
    final maxOrderSize = issueCurrency.isNotEmpty ? issueCurrency : 'N/A';

    return Container(
      padding: UIConstants.paddingStandard,
      decoration: BoxDecoration(
        color: isDarkTheme ? const Color(0xFF404040) : Colors.grey[50],
        borderRadius: BorderRadius.circular(UIConstants.borderRadiusSm),
        border: Border.all(
          color: isDarkTheme ? Colors.grey[700]! : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Instrument Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _getColorForInstrument(symbol),
              borderRadius: BorderRadius.circular(UIConstants.borderRadiusSm),
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

          // Instrument Details
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
                        borderRadius: BorderRadius.circular(4),
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
                  'ID: $instrumentId',
                  style: TextStyle(
                    fontSize: UIConstants.fontSizeSm,
                    color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // Instrument Info
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

  Color _getColorForInstrument(String baseCurrency) {
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

  Widget _buildPaginationControls(bool isDarkTheme) {
    final totalItems = (_instrumentsData?['output']?['total_count'] ?? 0) as int;
    final totalPages = (totalItems / _pageSize).ceil();

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: isDarkTheme ? Colors.grey[700]! : Colors.grey[300]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Page ${_currentPage + 1} of ${totalPages > 0 ? totalPages : 1} (Total: $totalItems items)',
            style: TextStyle(
              fontSize: UIConstants.fontSizeBody,
              color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: _currentPage > 0
                    ? () => _fetchInstruments(page: _currentPage - 1)
                    : null,
                icon: const Icon(Icons.chevron_left),
                tooltip: 'Previous Page',
                color: isDarkTheme ? Colors.white : Colors.black,
                disabledColor: Colors.grey,
              ),
              const SizedBox(width: UIConstants.spacingSm),
              IconButton(
                onPressed: _currentPage < totalPages - 1
                    ? () => _fetchInstruments(page: _currentPage + 1)
                    : null,
                icon: const Icon(Icons.chevron_right),
                tooltip: 'Next Page',
                color: isDarkTheme ? Colors.white : Colors.black,
                disabledColor: Colors.grey,
              ),
            ],
          ),
        ],
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
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF1E88E5),
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
                // Instruments Button (current page)
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    height: 55,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isDarkTheme ? Colors.black : Colors.grey[100],
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
                      'Instruments',
                      style: TextStyle(
                        fontSize: UIConstants.fontSizeSm,
                        fontWeight: UIConstants.fontWeightMedium,
                        color: isDarkTheme ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),

                // Portfolio Button
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const PortfolioPage(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Container(
                          height: 45,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
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
                            'Portfolio',
                            style: TextStyle(
                              fontSize: UIConstants.fontSizeSm,
                              fontWeight: UIConstants.fontWeightNormal,
                              color: Colors.white70,
                            ),
                          ),
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
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Container(
                          height: 45,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
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
                              fontSize: UIConstants.fontSizeSm,
                              fontWeight: UIConstants.fontWeightNormal,
                              color: Colors.white70,
                            ),
                          ),
                        ),
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
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Container(
                          height: 45,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
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
                              fontSize: UIConstants.fontSizeSm,
                              fontWeight: UIConstants.fontWeightNormal,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Cash Management Button
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const CashManagementPage(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Container(
                          height: 45,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
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
                            'Cash Management',
                            style: TextStyle(
                              fontSize: UIConstants.fontSizeSm,
                              fontWeight: UIConstants.fontWeightNormal,
                              color: Colors.white70,
                            ),
                          ),
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
                const PopupMenuItem<String>(
                  value: 'profile',
                  child: Row(
                    children: [
                      Icon(Icons.person, size: 18, color: Colors.white),
                      SizedBox(width: UIConstants.spacingSm),
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
                        SizedBox(width: UIConstants.spacingSm),
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
                const SizedBox(width: UIConstants.spacingSm),
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
              padding: UIConstants.paddingMinimal,
            ),
          ),

          const SizedBox(width: UIConstants.spacingSm),

          // Vertical divider line
          Container(
            height: 30,
            width: 1,
            color: Colors.white.withOpacity(0.3),
          ),

          const SizedBox(width: UIConstants.spacingSm),

          // Logout icon button
          IconButton(
            onPressed: () async {
              try {
                print('🚪 Instruments page logout initiated...');
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
            padding: UIConstants.paddingMinimal,
          ),
        ],
      ),
    );
  }
}
