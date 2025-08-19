import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../services/auth_service.dart';
import '../services/fix_client_service.dart';
import '../services/theme_service.dart';
import '../config/environment_config.dart';
import '../main.dart';
import 'fix_client_page.dart';
import 'portfolio_page.dart';
import 'profile_page.dart';
import 'users_admin_page.dart';

class TradingPage extends StatefulWidget {
  const TradingPage({super.key});

  @override
  State<TradingPage> createState() => _TradingPageState();
}

class _TradingPageState extends State<TradingPage> {
  String _selectedSymbol = '';  // Will be set when assets are loaded
  String _orderType = 'Limit';
  String _expiryPeriod = '1 Month'; // Add expiry period variable
  bool _isBuySelected = true;
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  // Message stream subscription
  StreamSubscription<String>? _messageSubscription;
  StreamSubscription<bool>? _connectionStatusSubscription;
  StreamSubscription<bool>? _logonStatusSubscription;
  bool _hasRequestedSecurityDefinitions = false;
  Timer? _securityRequestTimeout;
  
  // Panel width variables for resizable panels
  double _leftPanelWidth = 255.0; // Reduced by 15% (300 * 0.85 = 255)
  double _rightPanelWidth = 255.0; // Reduced by 15% (300 * 0.85 = 255)
  bool _isDraggingLeft = false;
  bool _isDraggingRight = false;
  
  // Panel height variables for resizable horizontal sections
  double _orderbookHeight = 150.0; // Default orderbook height
  bool _isDraggingHorizontal = false;
  double _marketOverviewHeight = 237.0; // Increased by 1.1x (215 * 1.1 = 236.5)
  bool _isDraggingMarketOverview = false; // State for market overview splitter
  
  // Chart data variables
  Map<String, List<Map<String, dynamic>>> _chartData = {}; // Cache chart data by symbol
  bool _isLoadingChart = false;
  String _chartError = '';
  String _selectedTimePeriod = '1m'; // Default to 1 month
  
  @override
  void initState() {
    super.initState();
    // Listen for connection status changes and show notifications
    _listenToConnectionStatus();
    // Listen for FIX messages to handle Security Definition Responses
    _listenToFixMessages();
    
    // If we're already logged on when this widget is created, fetch pairs immediately
    if (FixClientService.instance.isLoggedOn && _assets.isEmpty) {
      _fetchPairsFromAPI();
    }
  }
  
  void _listenToConnectionStatus() {
    _connectionStatusSubscription = FixClientService.instance.connectionStatusStream.listen((isConnected) {
      if (mounted) {
        // Connection status changes are tracked but no notifications shown
        // to reduce UI noise in the trading page
      }
    });
    
    _logonStatusSubscription = FixClientService.instance.logonStatusStream.listen((isLoggedOn) {
      if (mounted && isLoggedOn) {
        // Automatically fetch pairs from API after successful logon
        _fetchPairsFromAPI();
      }
    });
  }
  
  void _listenToFixMessages() {
    // Keep the message subscription for potential future FIX message handling
    // Currently not needed since we're using REST API for pairs
    _messageSubscription = FixClientService.instance.messageStream.listen((message) {
      if (mounted) {
        // Process other FIX messages if needed in the future
        print('📨 FIX Message: $message');
      }
    });
  }
  
  Future<void> _fetchPairsFromAPI() async {
    // Only skip if we already have data AND we've already requested it
    if (_hasRequestedSecurityDefinitions && _assets.isNotEmpty) {
      return; // Already requested and have data
    }
    
    try {
      print('🌐 Fetching pairs from API...');
      
      // Removed notification for fetching pairs to reduce UI noise
      
      final response = await http.get(
        Uri.parse('https://brokerage-api-stage.tokenise.io/api/services/app/Pair/GetPairs'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('API request timed out', const Duration(seconds: 10));
        },
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        
        if (jsonData['success'] == true && jsonData['result'] != null) {
          final List<dynamic> pairs = jsonData['result'];
          
          print('✅ Received ${pairs.length} trading pairs from API');
          
          setState(() {
            _assets.clear(); // Clear any existing assets
            
            for (final pair in pairs) {
              final symbol = pair['symbol']?.toString() ?? '';
              final title = pair['title']?.toString() ?? symbol;
              final logoAddress = pair['logoAddress']?.toString() ?? '';
              final coverAddress = pair['coverAddress']?.toString() ?? '';
              final orderbook = pair['orderbook']?.toString() ?? '';
              final exchangePairId = pair['exchangePairId']?.toString() ?? '';
              final quoteTokenDecimal = pair['quoteTokenDecimal']?.toString() ?? '0';
              // Debug print to see what fields we're getting
              print('Asset: $symbol, Title: $title, Orderbook: $orderbook, ExchangePairId: $exchangePairId, quoteTokenDecimal: $quoteTokenDecimal');
              if (symbol.isNotEmpty) {
                _assets.add({
                  'symbol': symbol,
                  'name': title,
                  'title': title,
                  'logoAddress': logoAddress,
                  'coverAddress': coverAddress.isNotEmpty ? coverAddress : 'https://picsum.photos/112/120?random=${_assets.length}', // Test image if no cover
                  'orderbook': orderbook,
                  'exchangePairId': exchangePairId,
                  'quoteTokenDecimal': quoteTokenDecimal,
                  'price': '\$0.00', // Will be updated with market data later
                  'change': '+0.00%',
                  'changeColor': Colors.grey,
                });
              }
            }
            
            // Update selected symbol if this is the first time or current is empty
            if (_selectedSymbol.isEmpty && _assets.isNotEmpty) {
              _selectedSymbol = _assets.first['symbol'];
              // Fetch chart data for the first selected symbol with a delay
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Future.delayed(const Duration(milliseconds: 500), () {
                  if (mounted) {
                    _fetchChartData(_selectedSymbol);
                  }
                });
              });
            }
          });
          
          _hasRequestedSecurityDefinitions = true;
          
          // Removed notification for loaded pairs count to reduce UI noise
          
          print('🎉 Successfully loaded ${_assets.length} trading pairs');
        } else {
          throw Exception('API response indicates failure: ${jsonData['error'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.reasonPhrase}');
      }
      
    } catch (e) {
      print('❌ Error fetching pairs from API: $e');
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('⚠️ Failed to load trading pairs: ${e.toString()}'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 2), // Reduced from 4 seconds to 2 seconds
          ),
        );
      }
      
      // Fallback: Add some default pairs if API fails
      setState(() {
        if (_assets.isEmpty) {
          _assets.addAll([
            {
              'symbol': 'BTC-USD',
              'name': 'Bitcoin / US Dollar',
              'logoAddress': '',
              'price': '-',
              'change': '-',
              'changeColor': Colors.grey,
            },
            {
              'symbol': 'ETH-USD', 
              'name': 'Ethereum / US Dollar',
              'logoAddress': '',
              'price': '-',
              'change': '-',
              'changeColor': Colors.grey,
            },
          ]);
          
          if (_selectedSymbol.isEmpty) {
            _selectedSymbol = _assets.first['symbol'];
          }
        }
      });
    }
  }
  
  Future<void> _fetchChartData(String symbol) async {
    print('🔍 DEBUG: Starting _fetchChartData for symbol: $symbol, period: $_selectedTimePeriod');
    
    // Create unique key that includes time period
    final chartKey = '${symbol}_$_selectedTimePeriod';
    
    // Skip if we already have chart data for this symbol and time period
    if (_chartData.containsKey(chartKey)) {
      print('📊 Chart data already cached for $symbol ($_selectedTimePeriod)');
      return;
    }
    
    // Find the asset data for this symbol
    final asset = _assets.firstWhere(
      (asset) => asset['symbol'] == symbol,
      orElse: () => {},
    );

    print('🔍 DEBUG: Found asset: $asset');

    if (asset.isEmpty) {
      print('❌ Asset not found for symbol: $symbol');
      setState(() {
        _chartError = 'Asset not found for symbol: $symbol';
      });
      return;
    }

    final orderbook = asset['orderbook']?.toString() ?? '';
    final exchangePairId = asset['exchangePairId']?.toString() ?? '';
    // Get quoteTokenDecimal for normalization
    final quoteTokenDecimal = int.tryParse(asset['quoteTokenDecimal']?.toString() ?? '0') ?? 0;

    print('🔍 DEBUG: orderbook="$orderbook", exchangePairId="$exchangePairId", quoteTokenDecimal=$quoteTokenDecimal');

    if (orderbook.isEmpty || exchangePairId.isEmpty) {
      print('❌ Missing required fields for $symbol: orderbook="$orderbook", exchangePairId="$exchangePairId"');
      // For testing - create fake chart data if API fields are missing
      print('🧪 Creating test chart data for $symbol ($_selectedTimePeriod)');
      setState(() {
        _isLoadingChart = false;
        _chartError = '';
        _chartData[chartKey] = _generateTestChartData();
      });
      return;
    }
    
    setState(() {
      _isLoadingChart = true;
      _chartError = '';
    });
    
    try {
      print('📊 Fetching chart data for symbol: $symbol');
      
      // Calculate timestamps based on selected time period
      final now = DateTime.now();
      DateTime startDate;
      int intervalMinutes;
      
      switch (_selectedTimePeriod) {
        case '1d':
          startDate = now.subtract(const Duration(days: 1));
          intervalMinutes = 60; // 1 hour candles
          break;
        case '7d':
          startDate = now.subtract(const Duration(days: 7));
          intervalMinutes = 240; // 4 hour candles
          break;
        case '1m':
          startDate = now.subtract(const Duration(days: 30));
          intervalMinutes = 1440; // Daily candles
          break;
        case 'all':
          startDate = now.subtract(const Duration(days: 365));
          intervalMinutes = 10080; // Weekly candles
          break;
        default:
          startDate = now.subtract(const Duration(days: 30));
          intervalMinutes = 1440;
      }
      
      final fromTs = (startDate.millisecondsSinceEpoch / 1000).floor();
      final toTs = (now.millisecondsSinceEpoch / 1000).floor();
      
      final requestBody = {
        "chain_id": "131074",
        "from_ts": fromTs,
        "interval_minutes": intervalMinutes,
        "orderbook": orderbook,
        "pair_id": exchangePairId,
        "to_ts": toTs,
      };
      
      print('📊 Chart request for $symbol: $requestBody');
      
      final response = await http.post(
        Uri.parse('https://brokerage-api-stage.tokenise.io/api/services/app/Agora/Ohlc'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'text/plain',
          'X-XSRF-TOKEN': 'null',
        },
        body: json.encode(requestBody),
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          throw TimeoutException('Chart API request timed out', const Duration(seconds: 15));
        },
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        
        print('🔍 DEBUG: API Response: $jsonData');
        
        if (jsonData['success'] == true && jsonData['result'] != null) {
          // Check if result is a List or contains a List
          dynamic resultData = jsonData['result'];
          List<dynamic> ohlcData = [];
          
          if (resultData is List) {
            ohlcData = resultData;
          } else if (resultData is Map && resultData.containsKey('data')) {
            // Some APIs wrap the array in a 'data' field
            if (resultData['data'] is List) {
              ohlcData = resultData['data'];
            }
          } else {
            throw Exception('API result is not in expected format: ${resultData.runtimeType}');
          }
          
          print('✅ Received ${ohlcData.length} chart data points for $symbol');
          
          // Convert to chart format
          final List<Map<String, dynamic>> chartPoints = [];
          
          for (var point in ohlcData) {
            try {
              if (point is Map<String, dynamic>) {
                final decimalDiv = quoteTokenDecimal > 0 ? pow(10, quoteTokenDecimal).toDouble() : 1.0;
                chartPoints.add({
                  'timestamp': (point['timestamp'] ?? 0).toInt(),
                  'open': _safeToDouble(point['open']) / decimalDiv,
                  'high': _safeToDouble(point['high']) / decimalDiv,
                  'low': _safeToDouble(point['low']) / decimalDiv,
                  'close': _safeToDouble(point['close']) / decimalDiv,
                  'volume': _safeToDouble(point['volume']),
                });
              }
            } catch (e) {
              print('⚠️ Skipping invalid data point: $point, error: $e');
            }
          }
          
          setState(() {
            _chartData[chartKey] = chartPoints;
            _isLoadingChart = false;
          });
          
          print('🎉 Successfully loaded chart data for $symbol ($_selectedTimePeriod) with ${chartPoints.length} points');
        } else {
          throw Exception('Chart API response indicates failure: ${jsonData['error'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception('Chart API HTTP ${response.statusCode}: ${response.reasonPhrase}');
      }
      
    } catch (e) {
      print('❌ Error fetching chart data for $symbol: $e');
      
      // Fallback to test data for now
      print('🧪 Falling back to test chart data for $symbol ($_selectedTimePeriod)');
      setState(() {
        _isLoadingChart = false;
        _chartError = '';
        _chartData[chartKey] = _generateTestChartData();
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('⚠️ Using test data for $symbol chart'),
            backgroundColor: Colors.blue,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }
  
  List<Map<String, dynamic>> _generateTestChartData() {
    final List<Map<String, dynamic>> testData = [];
    final basePrice = 670.0; // Start with a realistic price like in your image
    final now = DateTime.now();
    
    for (int i = 0; i < 42; i++) { // Generate 42 data points like in your image
      final date = now.subtract(Duration(days: 41 - i));
      // Create some realistic price movement
      final randomVariation = (i * 0.5) + (DateTime.now().millisecond % 20) - 10;
      final price = basePrice + randomVariation;
      
      testData.add({
        'timestamp': date.millisecondsSinceEpoch ~/ 1000,
        'open': price - 1,
        'high': price + 2,
        'low': price - 3,
        'close': price,
        'volume': 1000.0 + (i * 100),
      });
    }
    
    print('🧪 Generated ${testData.length} test chart data points');
    print('🧪 Price range: ${testData.map((d) => d['close']).reduce((a, b) => a < b ? a : b)} - ${testData.map((d) => d['close']).reduce((a, b) => a > b ? a : b)}');
    
    return testData;
  }
  
  double _safeToDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }
    return 0.0;
  }
  
  @override
  void dispose() {
    _messageSubscription?.cancel();
    _connectionStatusSubscription?.cancel();
    _logonStatusSubscription?.cancel();
    _securityRequestTimeout?.cancel();
    _quantityController.dispose();
    _priceController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  
  void _scrollLeft() {
    if (_assets.isNotEmpty) {
      final currentIndex = _assets.indexWhere((asset) => asset['symbol'] == _selectedSymbol);
      final newIndex = currentIndex > 0 ? currentIndex - 1 : _assets.length - 1;
      
      setState(() {
        _selectedSymbol = _assets[newIndex]['symbol'];
      });
      
      // Fetch chart data for newly selected symbol
      _fetchChartData(_assets[newIndex]['symbol']);
      
      // Scroll to center the selected asset (162px width + 16px margin = 178px per card)
      _scrollToIndex(newIndex);
    }
  }
  
  void _scrollRight() {
    if (_assets.isNotEmpty) {
      final currentIndex = _assets.indexWhere((asset) => asset['symbol'] == _selectedSymbol);
      final newIndex = currentIndex < _assets.length - 1 ? currentIndex + 1 : 0;
      
      setState(() {
        _selectedSymbol = _assets[newIndex]['symbol'];
      });
      
      // Fetch chart data for newly selected symbol
      _fetchChartData(_assets[newIndex]['symbol']);
      
      // Scroll to center the selected asset (162px width + 16px margin = 178px per card)
      _scrollToIndex(newIndex);
    }
  }
  
  void _scrollToSelectedAsset() {
    if (_assets.isNotEmpty && _scrollController.hasClients) {
      final currentIndex = _assets.indexWhere((asset) => asset['symbol'] == _selectedSymbol);
      if (currentIndex >= 0) {
        // Add a small delay to ensure the UI has updated
        Future.delayed(const Duration(milliseconds: 50), () {
          _scrollToIndex(currentIndex);
        });
      }
    }
  }
  
  void _scrollToIndex(int index) {
    if (_scrollController.hasClients) {
      // Calculate position to center the selected asset
      final cardWidth = 162.0; // Width of each card
      final cardMargin = 16.0; // margin between cards (only right margin)
      final totalCardWidth = cardWidth + cardMargin;
      
      // Get the available width of the ListView viewport
      final viewportWidth = _scrollController.position.viewportDimension;
      
      // Calculate the scroll offset to center the card
      // Position of the left edge of the card in the ListView content
      final cardLeftPosition = index * totalCardWidth;
      
      // To center the card:
      // We want the card center to be at the center of the ListView viewport
      // Card center position = cardLeftPosition + (cardWidth / 2)
      // Viewport center = viewportWidth / 2
      // Required scroll offset = cardLeftPosition + (cardWidth / 2) - (viewportWidth / 2)
      final targetOffset = cardLeftPosition + (cardWidth / 2) - (viewportWidth / 2);
      
      print('📍 Centering card $index: cardLeft=$cardLeftPosition, viewportWidth=$viewportWidth, targetOffset=$targetOffset');
      
      _scrollController.animateTo(
        targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }
  
  final List<Map<String, dynamic>> _assets = [
    // This list will be populated dynamically from API call
  ];

  final List<Map<String, dynamic>> _orderHistory = [
    {'type': 'BUY', 'symbol': 'AAPL', 'quantity': '100', 'price': '\$175.00', 'time': '14:30:25'},
    {'type': 'SELL', 'symbol': 'GOOGL', 'quantity': '50', 'price': '\$2,840.00', 'time': '14:28:12'},
    {'type': 'BUY', 'symbol': 'MSFT', 'quantity': '75', 'price': '\$406.50', 'time': '14:25:08'},
    {'type': 'SELL', 'symbol': 'TSLA', 'quantity': '200', 'price': '\$245.80', 'time': '14:20:45'},
    {'type': 'BUY', 'symbol': 'AMZN', 'quantity': '25', 'price': '\$156.20', 'time': '14:15:30'},
  ];

  // Orderbook data
  final List<Map<String, dynamic>> _sellOrders = [
    {'price': 5.7, 'quantity': 550},
    {'price': 6.0, 'quantity': 1000},
    {'price': 7.0, 'quantity': 100},
  ];

  final List<Map<String, dynamic>> _buyOrders = [
    {'price': 1.0, 'quantity': 10},
    {'price': 1.0, 'quantity': 10},
  ];

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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final maxWidth = constraints.maxWidth;
                  final maxHeight = constraints.maxHeight;
                  final minPanelWidth = 200.0;
                  final minOrderbookHeight = 150.0;
                  final maxOrderbookHeight = maxHeight - 100; // Leave space for main content
                  final maxLeftPanelWidth = maxWidth - _rightPanelWidth - minPanelWidth - 8; // 8 for splitters
                  final maxRightPanelWidth = maxWidth - _leftPanelWidth - minPanelWidth - 8;
                  
                  // Constrain panel widths and heights
                  _leftPanelWidth = _leftPanelWidth.clamp(minPanelWidth, maxLeftPanelWidth);
                  _rightPanelWidth = _rightPanelWidth.clamp(minPanelWidth, maxRightPanelWidth);
                  _orderbookHeight = _orderbookHeight.clamp(minOrderbookHeight, maxOrderbookHeight);
                  
                  return Row(
                    children: [
                      // Left Panel - Trading Controls (Yellow area)
                      Container(
                        width: _leftPanelWidth,
                        child: _buildTradingPanel(themeService),
                      ),
                      
                      // Left Splitter
                      _buildVerticalSplitter(
                        onDrag: (delta) {
                          setState(() {
                            _leftPanelWidth = (_leftPanelWidth + delta).clamp(minPanelWidth, maxLeftPanelWidth);
                          });
                        },
                        onDragStart: () => setState(() => _isDraggingLeft = true),
                        onDragEnd: () => setState(() => _isDraggingLeft = false),
                        isDragging: _isDraggingLeft,
                        themeService: themeService,
                      ),
                      
                      // Middle Panel - Asset Selection, Chart and Orderbook
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final maxMiddleHeight = constraints.maxHeight;
                            final minMarketOverviewHeight = 150.0;
                            final maxMarketOverviewHeight = maxMiddleHeight - 200; // Leave space for chart and orderbook
                            
                            // Constrain market overview height
                            _marketOverviewHeight = _marketOverviewHeight.clamp(minMarketOverviewHeight, maxMarketOverviewHeight);
                            
                            return Column(
                              children: [
                                // Asset Selection at the top of middle panel only
                                Container(
                                  height: _marketOverviewHeight,
                                  child: _buildAssetSection(themeService),
                                ),
                                
                                // Horizontal Splitter between Market Overview and Chart
                                _buildHorizontalSplitter(
                                  onDrag: (delta) {
                                    setState(() {
                                      _marketOverviewHeight = (_marketOverviewHeight + delta).clamp(minMarketOverviewHeight, maxMarketOverviewHeight);
                                    });
                                  },
                                  onDragStart: () => setState(() => _isDraggingMarketOverview = true),
                                  onDragEnd: () => setState(() => _isDraggingMarketOverview = false),
                                  isDragging: _isDraggingMarketOverview,
                                  themeService: themeService,
                                ),
                                
                                // Chart and Orderbook area
                                Expanded(
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      final availableHeight = constraints.maxHeight;
                                      final minOrderbookHeight = 100.0;
                                      final maxOrderbookHeight = availableHeight - 100; // Leave space for chart
                                      
                                      // Set equal heights for chart and orderbook by default
                                      if (_orderbookHeight == 150.0) { // If still at default
                                        _orderbookHeight = availableHeight / 2; // Half of available space
                                      }
                                      
                                      _orderbookHeight = _orderbookHeight.clamp(minOrderbookHeight, maxOrderbookHeight);
                                      
                                      return Column(
                                        children: [
                                          // Chart Section (top) - takes remaining space
                                          Expanded(
                                            child: _buildChartSection(themeService),
                                          ),
                                          
                                          // Horizontal Splitter between Chart and Orderbook
                                          _buildHorizontalSplitter(
                                            onDrag: (delta) {
                                              setState(() {
                                                _orderbookHeight = (_orderbookHeight - delta).clamp(minOrderbookHeight, maxOrderbookHeight);
                                              });
                                            },
                                            onDragStart: () => setState(() => _isDraggingHorizontal = true),
                                            onDragEnd: () => setState(() => _isDraggingHorizontal = false),
                                            isDragging: _isDraggingHorizontal,
                                            themeService: themeService,
                                          ),
                                          
                                          // Orderbook Section (Red area)
                                          Container(
                                            height: _orderbookHeight,
                                            child: _buildOrderbookSection(themeService),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      
                      // Right Splitter
                      _buildVerticalSplitter(
                        onDrag: (delta) {
                          setState(() {
                            _rightPanelWidth = (_rightPanelWidth - delta).clamp(minPanelWidth, maxRightPanelWidth);
                          });
                        },
                        onDragStart: () => setState(() => _isDraggingRight = true),
                        onDragEnd: () => setState(() => _isDraggingRight = false),
                        isDragging: _isDraggingRight,
                        themeService: themeService,
                      ),
                      
                      // Right Panel - Order History (Green area)
                      Container(
                        width: _rightPanelWidth,
                        child: _buildActivitySection(themeService),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalSplitter({
    required Function(double) onDrag,
    required VoidCallback onDragStart,
    required VoidCallback onDragEnd,
    required bool isDragging,
    required ThemeService themeService,
  }) {
    final _isDarkTheme = themeService.isDarkTheme;
    
    return GestureDetector(
      onPanStart: (_) => onDragStart(),
      onPanUpdate: (details) => onDrag(details.delta.dx),
      onPanEnd: (_) => onDragEnd(),
      child: MouseRegion(
        cursor: SystemMouseCursors.resizeColumn,
        child: Container(
          width: 4, // Reduced from 10 to 4 to make it thinner
          decoration: BoxDecoration(
            color: isDragging 
                ? Colors.blue.withOpacity(0.3)
                : (_isDarkTheme ? Colors.grey[700] : Colors.grey[300]),
            border: isDragging
                ? Border.all(color: Colors.blue, width: 1) // Reduced border width
                : null,
          ),
          child: Center(
            child: Container(
              width: 1, // Reduced from 2 to 1 for thinner line
              height: double.infinity,
              decoration: BoxDecoration(
                color: isDragging 
                    ? Colors.blue
                    : (_isDarkTheme ? Colors.grey[600] : Colors.grey[400]),
                borderRadius: BorderRadius.circular(0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalSplitter({
    required Function(double) onDrag,
    required VoidCallback onDragStart,
    required VoidCallback onDragEnd,
    required bool isDragging,
    required ThemeService themeService,
  }) {
    final _isDarkTheme = themeService.isDarkTheme;
    
    return GestureDetector(
      onPanStart: (_) => onDragStart(),
      onPanUpdate: (details) => onDrag(details.delta.dy),
      onPanEnd: (_) => onDragEnd(),
      child: MouseRegion(
        cursor: SystemMouseCursors.resizeRow,
        child: Container(
          height: 4, // Consistent with vertical splitter
          decoration: BoxDecoration(
            color: isDragging 
                ? Colors.blue.withOpacity(0.3)
                : (_isDarkTheme ? Colors.grey[700] : Colors.grey[300]),
            border: isDragging
                ? Border.all(color: Colors.blue, width: 1)
                : null,
          ),
          child: Center(
            child: Container(
              height: 1, // Thin horizontal line
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDragging 
                    ? Colors.blue
                    : (_isDarkTheme ? Colors.grey[600] : Colors.grey[400]),
                borderRadius: BorderRadius.circular(0.5),
              ),
            ),
          ),
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
              color: const Color(0xFF1E88E5), // Blue background for the logo
            ),
            child: ClipOval(
              child: Padding(
                padding: const EdgeInsets.all(4.0), // Small padding for the logo
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF1E88E5), // Blue background matching the logo
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
          
          // Vertical divider line
          Container(
            height: 30,
            width: 1,
            color: Colors.white.withOpacity(0.3),
          ),
          
          const SizedBox(width: 16),
          
          // FIX Connection Status Indicator (admin-only clickable)
          StreamBuilder<bool>(
            stream: FixClientService.instance.connectionStatusStream,
            initialData: FixClientService.instance.isConnected,
            builder: (context, snapshot) {
              final isConnected = snapshot.data ?? FixClientService.instance.isConnected;
              return StreamBuilder<bool>(
                stream: FixClientService.instance.logonStatusStream,
                initialData: FixClientService.instance.isLoggedOn,
                builder: (context, logonSnapshot) {
                  final isLoggedOn = logonSnapshot.data ?? FixClientService.instance.isLoggedOn;
                  
                  String statusText;
                  Color statusColor;
                  IconData statusIcon;
                  
                  if (isConnected && isLoggedOn) {
                    statusText = 'FIX: Logon';
                    statusColor = Colors.green;
                    statusIcon = Icons.check_circle;
                  } else if (isConnected && !isLoggedOn) {
                    statusText = 'FIX: Connected';
                    statusColor = Colors.orange;
                    statusIcon = Icons.sync;
                  } else {
                    statusText = 'FIX: Disconnected';
                    statusColor = Colors.red;
                    statusIcon = Icons.cancel;
                  }
                  
                  // Check if current user is admin
                  final isAdmin = authService.username.toLowerCase() == 'admin';
                  
                  Widget statusWidget = Container(
                    width: 160,
                    height: 32,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: statusColor, width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(statusIcon, size: 14, color: statusColor),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            statusText,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                  
                  // Only make it clickable for admin users
                  if (isAdmin) {
                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          try {
                            // Get the current FixDictionaryProvider to pass it to FIXClientPage
                            final dictionaryProvider = Provider.of<FixDictionaryProvider>(context, listen: false);
                            
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => ChangeNotifierProvider.value(
                                  value: dictionaryProvider,
                                  child: const FIXClientPage(),
                                ),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          } catch (e) {
                            print('Error accessing FixDictionaryProvider: $e');
                            // Fallback: navigate without the provider
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => const FIXClientPage(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          }
                        },
                        child: statusWidget,
                      ),
                    );
                  } else {
                    // For non-admin users, return the status as non-clickable text
                    return statusWidget;
                  }
                },
              );
            },
          ),
          
          // Spacer to center the navigation buttons
          const Spacer(),
          
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
                    child: Container(
                      height: 32,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Portfolio',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(width: 8),
                
                // Trading Button (current page)
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
                      'Trading',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1a1754),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Spacer to balance the layout
          const Spacer(),
          
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
                print('🚪 Trading page logout initiated...');
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
  
  Widget _buildTradingPanel(ThemeService themeService) {
    final _isDarkTheme = themeService.isDarkTheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _isDarkTheme ? const Color(0xFF1e1e1e) : Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Panel Title
          Text(
            'Trade',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Asset Selection Dropdown (made 2x smaller)
          Container(
            height: 35, // Made much smaller (was default ~48)
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Reduced padding
            decoration: BoxDecoration(
              border: Border.all(
                color: _isDarkTheme ? Colors.grey[600]! : Colors.grey[400]!,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _assets.isEmpty ? '' : _selectedSymbol,
                isExpanded: true,
                onChanged: _assets.isEmpty ? null : (String? newValue) {
                  setState(() {
                    _selectedSymbol = newValue!;
                  });
                  // Fetch chart data for newly selected symbol
                  _fetchChartData(newValue!);
                  // Scroll to the selected asset in market overview with a slight delay
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Future.delayed(const Duration(milliseconds: 200), () {
                      if (mounted && _scrollController.hasClients) {
                        _scrollToSelectedAsset();
                      }
                    });
                  });
                },
                dropdownColor: _isDarkTheme ? const Color(0xFF2d2d2d) : Colors.white,
                style: TextStyle(
                  color: _isDarkTheme ? Colors.white : Colors.black,
                  fontSize: 14, // Smaller font size
                ),
                items: _assets.isEmpty 
                    ? [DropdownMenuItem<String>(
                        value: '',
                        child: Text('Loading symbols...'),
                      )]
                    : _assets.map<DropdownMenuItem<String>>((asset) {
                        final symbol = asset['symbol'] as String;
                        return DropdownMenuItem<String>(
                          value: symbol,
                          child: Text(symbol),
                        );
                      }).toList(),
              ),
            ),
          ),
          
          const SizedBox(height: 16), // Reduced from 20
          
          // Buy/Sell Toggle Buttons (stretches with container width)
          Container(
            decoration: BoxDecoration(
              color: _isDarkTheme ? const Color(0xFF2d2d2d) : Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click, // Pointer cursor
                    child: GestureDetector(
                      onTap: () => setState(() => _isBuySelected = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8), // Much smaller padding
                        decoration: BoxDecoration(
                          color: _isBuySelected 
                              ? const Color(0xFF00D4AA) // Cyan color for buy
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Buy',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _isBuySelected 
                                ? Colors.white 
                                : (_isDarkTheme ? Colors.grey[400] : Colors.grey[600]),
                            fontWeight: FontWeight.w600,
                            fontSize: 14, // Smaller font size
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click, // Pointer cursor
                    child: GestureDetector(
                      onTap: () => setState(() => _isBuySelected = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8), // Much smaller padding
                        decoration: BoxDecoration(
                          color: !_isBuySelected 
                              ? const Color(0xFFFF4081) // Pink/red color for sell
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Sell',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: !_isBuySelected 
                                ? Colors.white 
                                : (_isDarkTheme ? Colors.grey[400] : Colors.grey[600]),
                            fontWeight: FontWeight.w600,
                            fontSize: 14, // Smaller font size
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16), // Reduced space before order type
          
          // Order Type Toggle Buttons with mouse cursor and smaller height (like buy/sell area)
          Container(
            decoration: BoxDecoration(
              color: _isDarkTheme ? const Color(0xFF2d2d2d) : Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click, // Pointer cursor
                    child: GestureDetector(
                      onTap: () => setState(() => _orderType = 'Limit'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8), // Reduced to match buy/sell area
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Text(
                          'Limit order',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _orderType == 'Limit' 
                                ? (_isBuySelected 
                                    ? const Color(0xFF00D4AA) // Cyan for buy
                                    : const Color(0xFFFF4081)) // Pink for sell
                                : (_isDarkTheme ? Colors.grey[400] : Colors.grey[600]),
                            fontWeight: FontWeight.w500,
                            fontSize: 14, // Reduced to match buy/sell area
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click, // Pointer cursor
                    child: GestureDetector(
                      onTap: () => setState(() => _orderType = 'Market'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8), // Reduced to match buy/sell area
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Text(
                          'Market order',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _orderType == 'Market' 
                                ? (_isBuySelected 
                                    ? const Color(0xFF00D4AA) // Cyan for buy
                                    : const Color(0xFFFF4081)) // Pink for sell
                                : (_isDarkTheme ? Colors.grey[400] : Colors.grey[600]),
                            fontWeight: FontWeight.w500,
                            fontSize: 14, // Reduced to match buy/sell area
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16), // Reduced space after order type
          
          // Available Balance / Buying Power
          Text(
            _isBuySelected ? 'Buying power' : 'Available',
            style: TextStyle(
              fontSize: 14,
              color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _isBuySelected ? '100 \$' : '100 ${_getSelectedAssetSymbol()}', // Show $ for buy, asset symbol for sell
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: _isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Amount Input
          Text(
            'Amount',
            style: TextStyle(
              fontSize: 14,
              color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: _isDarkTheme ? const Color(0xFF2d2d2d) : Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: _isDarkTheme ? Colors.white : Colors.black,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: 'E.g 1',
                      hintStyle: TextStyle(
                        color: _isDarkTheme ? Colors.grey[500] : Colors.grey[400],
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click, // Pointer cursor for Max button
                        child: GestureDetector(
                          onTap: () {
                            // Set quantity to maximum (100) for now
                            setState(() {
                              _quantityController.text = '100';
                            });
                          },
                          child: Text(
                            'Max',
                            style: TextStyle(
                              color: _isBuySelected 
                                  ? const Color(0xFF00D4AA) // Cyan for buy
                                  : const Color(0xFFFF4081), // Pink for sell
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _getSelectedAssetSymbol(), // Dynamic asset symbol
                        style: TextStyle(
                          color: _isDarkTheme ? Colors.white : Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          if (_orderType == 'Limit') ...[
            const SizedBox(height: 20),
            
            // Price Input
            Text(
              'Price',
              style: TextStyle(
                fontSize: 14,
                color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: _isDarkTheme ? const Color(0xFF2d2d2d) : Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        color: _isDarkTheme ? Colors.white : Colors.black,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        hintText: 'E.g 1',
                        hintStyle: TextStyle(
                          color: _isDarkTheme ? Colors.grey[500] : Colors.grey[400],
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      '\$',
                      style: TextStyle(
                        color: _isDarkTheme ? Colors.white : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Expiry Dropdown
            Text(
              'Expiry',
              style: TextStyle(
                fontSize: 14,
                color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: _isDarkTheme ? const Color(0xFF2d2d2d) : Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _expiryPeriod,
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      _expiryPeriod = newValue!;
                    });
                  },
                  dropdownColor: _isDarkTheme ? const Color(0xFF2d2d2d) : Colors.white,
                  style: TextStyle(
                    color: _isDarkTheme ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  ),
                  items: ['1 Day', '3 Days', '1 Week', '2 Weeks', '1 Month']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
          
          const Spacer(),
          
          const SizedBox(height: 20), // Add space between amount field and est.fee total area
          
          // Order Summary (no border)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _isDarkTheme ? const Color(0xFF2d2d2d) : Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              // Removed border
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Est. Fee',
                      style: TextStyle(
                        fontSize: 14,
                        color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                    Text(
                      '0 \$',
                      style: TextStyle(
                        fontSize: 14,
                        color: _isDarkTheme ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                    Text(
                      '0 \$',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _isDarkTheme ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Buy/Sell Order Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _placeOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isBuySelected 
                    ? const Color(0xFF00D4AA) // Cyan for buy
                    : const Color(0xFFFF4081), // Pink for sell
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: Text(
                '${_isBuySelected ? 'Buy' : 'Sell'} Order',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to get selected asset symbol
  String _getSelectedAssetSymbol() {
    if (_assets.isEmpty || _selectedSymbol.isEmpty) {
      return 'AC1'; // Default fallback
    }
    
    // Extract the base symbol from the trading pair
    // For example: "BTC-USD" -> "BTC", "ETH-USD" -> "ETH"
    final parts = _selectedSymbol.split('-');
    return parts.isNotEmpty ? parts[0] : 'AC1';
  }

  Widget _buildAssetSection(ThemeService themeService) {
    final _isDarkTheme = themeService.isDarkTheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _isDarkTheme ? const Color(0xFF1e1e1e) : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: _isDarkTheme ? Colors.grey[700]! : Colors.grey[300]!,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Market Overview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
          Expanded(
            child: _assets.isEmpty 
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.hourglass_empty,
                          size: 48,
                          color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Loading trading pairs...',
                          style: TextStyle(
                            fontSize: 16,
                            color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Fetching from API...',
                          style: TextStyle(
                            fontSize: 12,
                            color: _isDarkTheme ? Colors.grey[500] : Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    height: 100, // Reduced from 200 to 100 for half-size boxes
                    child: Stack(
                      children: [
                        // Main scrollable list
                        ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          itemCount: _assets.length,
                          itemBuilder: (context, index) {
                            final asset = _assets[index];
                            final isSelected = asset['symbol'] == _selectedSymbol;
                            
                            return Container(
                              width: 139, // 1.2 times wider (116 * 1.2 = 139.2)
                              height: 500, // Reduced from 1552 to 500
                              margin: const EdgeInsets.only(right: 8), // Reduced margin
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedSymbol = asset['symbol'];
                                  });
                                  // Fetch chart data for newly selected symbol
                                  _fetchChartData(asset['symbol']);
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: isSelected 
                                        ? [
                                            const Color(0xFF1a1754),
                                            const Color(0xFF2a2764),
                                          ]
                                        : _isDarkTheme 
                                        ? [
                                            const Color(0xFF2d2d2d),
                                            const Color(0xFF1e1e1e),
                                          ]
                                        : [
                                            Colors.white,
                                            Colors.grey[50]!,
                                          ],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    border: isSelected 
                                        ? Border.all(color: const Color(0xFF4CAF50), width: 2)
                                        : Border.all(
                                            color: _isDarkTheme ? Colors.grey[700]! : Colors.grey[300]!,
                                            width: 1,
                                          ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      // Cover photo background (faded)
                                      Positioned.fill(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Opacity(
                                            opacity: _isDarkTheme ? 0.4 : 0.2, // More faded in light theme
                                            child: asset['coverAddress'] != null && asset['coverAddress'].isNotEmpty
                                                ? Image.network(
                                                    asset['coverAddress'],
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context, error, stackTrace) {
                                                      return Container(
                                                        decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                            begin: Alignment.topLeft,
                                                            end: Alignment.bottomRight,
                                                            colors: [
                                                              const Color(0xFF1a1754).withOpacity(0.3),
                                                              const Color(0xFF2a2764).withOpacity(0.6),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : Container(
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin: Alignment.topLeft,
                                                        end: Alignment.bottomRight,
                                                        colors: [
                                                          const Color(0xFF1a1754).withOpacity(0.3),
                                                          const Color(0xFF2a2764).withOpacity(0.6),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                      
                                      // Overlay gradient for text readability
                                      Positioned.fill(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: _isDarkTheme 
                                                ? [
                                                    Colors.black.withOpacity(0.3),
                                                    Colors.black.withOpacity(0.7),
                                                  ]
                                                : [
                                                    Colors.white.withOpacity(0.1),
                                                    Colors.black.withOpacity(0.3),
                                                  ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      
                                      // Content
                                      Padding(
                                        padding: const EdgeInsets.all(20), // Increased padding for bigger box (180px)
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Header with logo and symbol
                                            Row(
                                              children: [
                                                Container(
                                                  width: 32, // Bigger logo for 180px box
                                                  height: 32,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white.withOpacity(0.2),
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: asset['logoAddress'] != null && asset['logoAddress'].isNotEmpty
                                                      ? ClipRRect(
                                                          borderRadius: BorderRadius.circular(10),
                                                          child: Image.network(
                                                            asset['logoAddress'],
                                                            width: 32,
                                                            height: 32,
                                                            fit: BoxFit.cover,
                                                            errorBuilder: (context, error, stackTrace) {
                                                              return const Icon(
                                                                Icons.currency_exchange,
                                                                color: Colors.white,
                                                                size: 18,
                                                              );
                                                            },
                                                          ),
                                                        )
                                                      : const Icon(
                                                          Icons.currency_exchange,
                                                          color: Colors.white,
                                                          size: 18,
                                                        ),
                                                ),
                                                const SizedBox(width: 12),
                                                Expanded(
                                                  child: Text(
                                                    asset['symbol'],
                                                    style: TextStyle(
                                                      fontSize: asset['symbol'].length > 8 ? 11.0 : 14.0, // Smaller font for longer names
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                    maxLines: asset['symbol'].length > 12 ? 2 : 1, // Use 2 lines for very long names
                                                    overflow: TextOverflow.visible, // Show full text instead of ellipsis
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            
                                            // Title (second row)
                                            Text(
                                              asset['title'] ?? asset['name'] ?? '',
                                              style: TextStyle(
                                                fontSize: (asset['title'] ?? asset['name'] ?? '').length > 20 ? 10.0 : 11.0, // Smaller font for longer titles
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              maxLines: 2, // Allow 2 lines for titles
                                              overflow: TextOverflow.visible, // Show full text instead of ellipsis
                                            ),
                                            
                                            const Spacer(),
                                            
                                            // Price
                                            Text(
                                              asset['price'],
                                              style: const TextStyle(
                                                fontSize: 16, // Smaller price text
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            
                                            // Change
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: asset['change'] == '-' 
                                                    ? Colors.grey.withOpacity(0.3)
                                                    : asset['changeColor'].withOpacity(0.3),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                asset['change'],
                                                style: TextStyle(
                                                  fontSize: 10, // Smaller change text
                                                  fontWeight: FontWeight.w600,
                                                  color: asset['change'] == '-' 
                                                      ? Colors.white
                                                      : asset['changeColor'],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        
                        // Left fade and button
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            width: 50,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  _isDarkTheme ? const Color(0xFF1e1e1e) : Colors.grey[50]!,
                                  (_isDarkTheme ? const Color(0xFF1e1e1e) : Colors.grey[50]!).withOpacity(0),
                                ],
                              ),
                            ),
                            child: Center(
                              child: GestureDetector(
                                onTap: _scrollLeft,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: _isDarkTheme ? Colors.grey[800] : Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.chevron_left,
                                    color: _isDarkTheme ? Colors.white : Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        
                        // Right fade and button
                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            width: 50,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [
                                  _isDarkTheme ? const Color(0xFF1e1e1e) : Colors.grey[50]!,
                                  (_isDarkTheme ? const Color(0xFF1e1e1e) : Colors.grey[50]!).withOpacity(0),
                                ],
                              ),
                            ),
                            child: Center(
                              child: GestureDetector(
                                onTap: _scrollRight,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: _isDarkTheme ? Colors.grey[800] : Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.chevron_right,
                                    color: _isDarkTheme ? Colors.white : Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
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

  Widget _buildChartSection(ThemeService themeService) {
    final _isDarkTheme = themeService.isDarkTheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _isDarkTheme ? const Color(0xFF1e1e1e) : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: _isDarkTheme ? Colors.grey[700]! : Colors.grey[300]!,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: _isDarkTheme ? const Color(0xFF2d2d2d) : Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _isDarkTheme ? Colors.grey[600]! : Colors.grey[300]!,
                ),
              ),
              child: _buildChartContent(_isDarkTheme),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartContent(bool isDarkTheme) {
    if (_isLoadingChart) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading chart data...'),
          ],
        ),
      );
    }

    if (_chartError.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: isDarkTheme ? Colors.grey[500] : Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Chart Error',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _chartError,
              style: TextStyle(
                fontSize: 14,
                color: isDarkTheme ? Colors.grey[500] : Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _fetchChartData(_selectedSymbol),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final chartKey = '${_selectedSymbol}_$_selectedTimePeriod';
    final chartData = _chartData[chartKey];
    if (chartData == null || chartData.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.show_chart,
              size: 64,
              color: isDarkTheme ? Colors.grey[500] : Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              '$_selectedSymbol Price Chart',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'No chart data available',
              style: TextStyle(
                fontSize: 14,
                color: isDarkTheme ? Colors.grey[500] : Colors.grey[500],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Clear cached data to force refresh
                final chartKey = '${_selectedSymbol}_$_selectedTimePeriod';
                _chartData.remove(chartKey);
                _fetchChartData(_selectedSymbol);
              },
              child: const Text('Load Chart'),
            ),
          ],
        ),
      );
    }

    // Display simple line chart
    return _buildSimpleLineChart(chartData, isDarkTheme);
  }

  Widget _buildSimpleLineChart(List<Map<String, dynamic>> data, bool isDarkTheme) {
    if (data.isEmpty) {
      print('❌ Chart data is empty');
      return const SizedBox();
    }

    print('📊 Building chart with ${data.length} data points');
    print('📊 Sample data point: ${data.first}');

    // Find min/max values for scaling using _safeToDouble
    double minPrice = double.infinity;
    double maxPrice = double.negativeInfinity;
    
    for (final point in data) {
      final low = _safeToDouble(point['low']);
      final high = _safeToDouble(point['high']);
      if (low < minPrice) minPrice = low;
      if (high > maxPrice) maxPrice = high;
    }
    
    double priceRange = maxPrice - minPrice;
    if (priceRange == 0) priceRange = 1; // Avoid division by zero
    
    print('📊 Price range: $minPrice - $maxPrice (range: $priceRange)');

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Symbol and price on one centered line
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$_selectedSymbol',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDarkTheme ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(width: 16),
              if (data.isNotEmpty)
                Text(
                  '\$${_safeToDouble(data.last['close']).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          // Chart with scale and min/max lines
          Expanded(
            child: Container(
              width: double.infinity,
              height: 200, // Set a minimum height
              child: Row(
                children: [
                  // Main chart area
                  Expanded(
                    child: CustomPaint(
                      size: const Size(double.infinity, 200),
                      painter: SimpleLinePainter(
                        data: data,
                        minPrice: minPrice,
                        maxPrice: maxPrice,
                        isDarkTheme: isDarkTheme,
                      ),
                    ),
                  ),
                  // Price scale on the right
                  Container(
                    width: 60,
                    child: _buildPriceScale(minPrice, maxPrice, isDarkTheme),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Time period buttons at the bottom
          Container(
            margin: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTimePeriodButton('1d', isDarkTheme),
                const SizedBox(width: 4),
                _buildTimePeriodButton('7d', isDarkTheme),
                const SizedBox(width: 4),
                _buildTimePeriodButton('1m', isDarkTheme),
                const SizedBox(width: 4),
                _buildTimePeriodButton('all', isDarkTheme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimePeriodButton(String period, bool isDarkTheme) {
    final isSelected = _selectedTimePeriod == period;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTimePeriod = period;
          });
          // Clear cache and fetch new data
          final chartKey = '${_selectedSymbol}_$period';
          _chartData.remove(chartKey);
          _fetchChartData(_selectedSymbol);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isSelected 
                ? (isDarkTheme ? Colors.blue[600] : Colors.blue[500])
                : (isDarkTheme ? Colors.grey[700] : Colors.grey[200]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            period,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected 
                  ? Colors.white 
                  : (isDarkTheme ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceScale(double minPrice, double maxPrice, bool isDarkTheme) {
    if (minPrice == maxPrice) {
      // Only show one label if min and max are equal
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '\$${minPrice.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 10,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }
    final steps = 5;
    final priceRange = maxPrice - minPrice;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(steps + 1, (index) {
        final price = maxPrice - (priceRange * index / steps);
        Color priceColor;
        if (price.toStringAsFixed(2) == maxPrice.toStringAsFixed(2)) {
          priceColor = Colors.green;
        } else if (price.toStringAsFixed(2) == minPrice.toStringAsFixed(2)) {
          priceColor = Colors.red;
        } else {
          priceColor = isDarkTheme ? Colors.grey[400]! : Colors.grey[600]!;
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Text(
            '\$${price.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 10,
              color: priceColor,
              fontWeight: (priceColor == Colors.green || priceColor == Colors.red) ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildActivitySection(ThemeService themeService) {
    final _isDarkTheme = themeService.isDarkTheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _isDarkTheme ? const Color(0xFF1e1e1e) : Colors.white,
        // Removed left border since we have a splitter now
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order History',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _orderHistory.length,
              itemBuilder: (context, index) {
                final order = _orderHistory[index];
                final isBuy = order['type'] == 'BUY';
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _isDarkTheme ? const Color(0xFF2d2d2d) : Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isBuy ? Colors.green.withOpacity(0.3) : Colors.red.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: isBuy ? Colors.green : Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              order['type'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            order['time'],
                            style: TextStyle(
                              fontSize: 12,
                              color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${order['symbol']} × ${order['quantity']}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _isDarkTheme ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Price: ${order['price']}',
                        style: TextStyle(
                          fontSize: 12,
                          color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderbookSection(ThemeService themeService) {
    final _isDarkTheme = themeService.isDarkTheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _isDarkTheme ? const Color(0xFF1e1e1e) : Colors.white,
        border: Border(
          top: BorderSide(
            color: _isDarkTheme ? Colors.grey[700]! : Colors.grey[300]!,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Orderbook',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Row(
              children: [
                // Sell Orders (Left side)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sell Orders',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _isDarkTheme ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'price',
                              style: TextStyle(
                                fontSize: 14,
                                color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Quantity',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 14,
                                color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 1,
                        color: _isDarkTheme ? Colors.grey[700] : Colors.grey[300],
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _sellOrders.length,
                          itemBuilder: (context, index) {
                            final order = _sellOrders[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      order['price'].toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      order['quantity'].toString(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: _isDarkTheme ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 40),
                
                // Buy Orders (Right side)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Buy Orders',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _isDarkTheme ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'price',
                              style: TextStyle(
                                fontSize: 14,
                                color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Quantity',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 14,
                                color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 1,
                        color: _isDarkTheme ? Colors.grey[700] : Colors.grey[300],
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _buyOrders.length,
                          itemBuilder: (context, index) {
                            final order = _buyOrders[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      order['price'].toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.green,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      order['quantity'].toString(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: _isDarkTheme ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _placeOrder() {
    if (_quantityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a quantity'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_orderType == 'Limit' && _priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a price for limit order'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Simulate order placement
    final orderType = _isBuySelected ? 'BUY' : 'SELL';
    final price = _orderType == 'Limit' ? _priceController.text : 'Market';
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$orderType order placed: $_selectedSymbol × ${_quantityController.text} at $price',
        ),
        backgroundColor: _isBuySelected ? Colors.green : Colors.red,
      ),
    );

    // Clear form
    _quantityController.clear();
    _priceController.clear();
  }
}

// Custom painter for simple line chart
class SimpleLinePainter extends CustomPainter {
  final List<Map<String, dynamic>> data;
  final double minPrice;
  final double maxPrice;
  final bool isDarkTheme;

  SimpleLinePainter({
    required this.data,
    required this.minPrice,
    required this.maxPrice,
    required this.isDarkTheme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) {
      print('❌ CustomPainter: No data to paint');
      return;
    }

    print('🎨 CustomPainter: Painting chart with size: ${size.width}x${size.height}');
    print('🎨 CustomPainter: Data points: ${data.length}');

    final lineColor = isDarkTheme ? Colors.blue[400]! : Colors.blue[600]!;
    final fillColor = lineColor.withOpacity(0.3);
    
    // Paint for the line
    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // Paint for the fill
    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final linePath = Path();
    final fillPath = Path();
    double minYPrice = minPrice;
    double maxYPrice = maxPrice;
    // If only one price, show a range around it (±2%)
    if ((maxPrice - minPrice).abs() < 1e-6) {
      minYPrice = minPrice * 0.98;
      maxYPrice = maxPrice * 1.02;
    }
    final priceRange = maxYPrice - minYPrice;
    if (priceRange <= 0) {
      minYPrice -= 1;
      maxYPrice += 1;
    }
    // Create paths for line and fill
    for (int i = 0; i < data.length; i++) {
      final x = (i / (data.length - 1)) * size.width;
      final closePrice = _safeToDouble(data[i]['close']);
      final normalizedPrice = (closePrice - minYPrice) / priceRange;
      final y = size.height - (normalizedPrice * size.height);
      if (i == 0) {
        linePath.moveTo(x, y);
        fillPath.moveTo(x, size.height); // Start fill from bottom
        fillPath.lineTo(x, y);
      } else {
        linePath.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }
    // Complete the fill path
    fillPath.lineTo(size.width, size.height);
    fillPath.close();
    // Draw fill first, then line
    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(linePath, linePaint);

    // Draw min/max lines and spots only if maxPrice != minPrice
    if ((maxPrice - minPrice).abs() > 1e-6) {
      final minMaxPaint = Paint()
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;
      // Find max and min points
      int maxIdx = 0;
      int minIdx = 0;
      double maxVal = _safeToDouble(data[0]['close']);
      double minVal = _safeToDouble(data[0]['close']);
      for (int i = 1; i < data.length; i++) {
        double val = _safeToDouble(data[i]['close']);
        if (val > maxVal) {
          maxVal = val;
          maxIdx = i;
        }
        if (val < minVal) {
          minVal = val;
          minIdx = i;
        }
      }
      // Calculate positions
      final maxX = (maxIdx / (data.length - 1)) * size.width;
      final maxYSpot = size.height - ((maxVal - minYPrice) / priceRange * size.height);
      final minX = (minIdx / (data.length - 1)) * size.width;
      final minYSpot = size.height - ((minVal - minYPrice) / priceRange * size.height);
      // Draw max spot (green)
      final spotRadius = 6.0;
      final spotPaintMax = Paint()..color = Colors.green;
      canvas.drawCircle(Offset(maxX, maxYSpot), spotRadius, spotPaintMax);
      // Draw min spot (red)
      final spotPaintMin = Paint()..color = Colors.red;
      canvas.drawCircle(Offset(minX, minYSpot), spotRadius, spotPaintMin);
      // Max line at maxYSpot
      canvas.drawLine(
        Offset(0, maxYSpot),
        Offset(size.width, maxYSpot),
        minMaxPaint..color = Colors.green,
      );
      // Min line at minYSpot
      canvas.drawLine(
        Offset(0, minYSpot),
        Offset(size.width, minYSpot),
        minMaxPaint..color = Colors.red,
      );
    }

    // Draw subtle grid lines
    final gridPaint = Paint()
      ..color = (isDarkTheme ? Colors.grey[700]! : Colors.grey[300]!).withOpacity(0.3)
      ..strokeWidth = 0.5;

    // Horizontal grid lines (fewer lines, more subtle)
    for (int i = 1; i <= 3; i++) {
      final y = (i / 4) * size.height;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    // Draw horizontal date scale
    if (data.isNotEmpty) {
      final labelStyle = TextStyle(
        color: isDarkTheme ? Colors.white : Colors.black,
        fontSize: 10,
      );
      final labelHeight = 16.0;
      final labelY = size.height + 2;
      int labelCount = 6;
      for (int i = 0; i < labelCount; i++) {
        final dataIdx = ((i / (labelCount - 1)) * (data.length - 1)).round();
        final point = data[dataIdx];
        final ts = point['timestamp'] ?? 0;
        DateTime dt = DateTime.fromMillisecondsSinceEpoch(ts * 1000);
        String label;
        if (_is1dPeriod()) {
          label = _formatHour(dt);
        } else {
          label = _formatDay(dt);
        }
        final tp = TextPainter(
          text: TextSpan(text: label, style: labelStyle),
          textDirection: TextDirection.ltr,
        )..layout();
        final x = (dataIdx / (data.length - 1)) * size.width - tp.width / 2;
        tp.paint(canvas, Offset(x, labelY));
      }
    }
    print('🎨 CustomPainter: Chart painting completed');

  }

  bool _is1dPeriod() {
    // You may want to pass the period as a parameter, but for now infer from data
    // If data covers less than 2 days, treat as intraday
    if (data.length < 2) return true;
    final first = DateTime.fromMillisecondsSinceEpoch((data.first['timestamp'] ?? 0) * 1000);
    final last = DateTime.fromMillisecondsSinceEpoch((data.last['timestamp'] ?? 0) * 1000);
    return last.difference(first).inDays < 2;
  }
  String _formatHour(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:00';
  }
  String _formatDay(DateTime dt) {
    return '${dt.day} ${_monthShort(dt.month)}';
  }
  String _monthShort(int m) {
    const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return months[m-1];
  }
  // Helper method to safely convert values to double
  double _safeToDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }
    return 0.0;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
