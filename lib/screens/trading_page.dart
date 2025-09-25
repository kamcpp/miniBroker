
import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../services/auth_service.dart';
import '../services/theme_service.dart';
import '../services/real_grpc_client.dart';
import '../services/grpcurl_helper.dart';
import '../utils/connectivity_checker.dart';
import 'portfolio_page.dart';
import 'balance_page.dart';
import 'activity_page.dart';
import 'profile_page.dart';
import 'users_admin_page.dart';

class TradingPage extends StatefulWidget {
  const TradingPage({super.key});

  @override
  State<TradingPage> createState() => _TradingPageState();
}

class _TradingPageState extends State<TradingPage> {
  Future<void> _fetchTradeHistoryForAsset(String symbol, {int page = 1, bool append = false}) async {
  print('[TradeHistory] Fetching for symbol: $symbol, page: $page');
  print('[TradeHistory] Asset list: ${_assets.map((a) => a['symbol']).toList()}');
    
    if (!append) {
      setState(() {
        _isLoadingTradeHistory = true;
        _currentTradeHistoryPage = page;
      });
    }
    
    // Find the asset data for this symbol
    final asset = _assets.firstWhere(
      (asset) => asset['symbol'] == symbol,
      orElse: () {
        print('[TradeHistory] Asset not found for symbol: $symbol');
        setState(() {
          _tradeHistory = [
            {
              'price': '-',
              'quantity': '-',
              'time': 'No trades available for this asset.'
            }
          ];
          _isLoadingTradeHistory = false;
        });
        return <String, dynamic>{};
      },
    );
    final exchangePairId = asset['exchangePairId']?.toString() ?? '';
  final quoteTokenDecimal = asset != null ? int.tryParse(asset['quoteTokenDecimal']?.toString() ?? '0') ?? 0 : 0;
  print('[TradeHistory] exchangePairId: $exchangePairId, quoteTokenDecimal: $quoteTokenDecimal');
    if (exchangePairId.isEmpty) {
      setState(() {
        _tradeHistory = [
          {
            'price': '-',
            'quantity': '-',
            'time': 'No trades available for this asset.'
          }
        ];
        _isLoadingTradeHistory = false;
      });
      return;
    }
    try {
      // Prepare payload for POST request
      final orderbook = asset['orderbook']?.toString() ?? '';
      final payload = {
        "account": "",
        "page": page,
        "page_size": _tradeHistoryPageSize,
        "chain_id": "131074",
        "orderbook": orderbook,
        "pair_id": exchangePairId
      };
      print('[TradeHistory] API POST: https://brokerage-api-stage.tokenise.io/api/services/app/Agora/OrderbookTrades');
      print('[TradeHistory] Payload: ' + json.encode(payload));
      final apiCallStart = DateTime.now();
      final response = await http.post(
        Uri.parse('https://brokerage-api-stage.tokenise.io/api/services/app/Agora/OrderbookTrades'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(payload),
      ).timeout(const Duration(seconds: 10));
        // Debug info logged below
      final apiCallEnd = DateTime.now();
      print('[TradeHistory] API call duration: ${apiCallEnd.difference(apiCallStart).inMilliseconds} ms');
      if (response.statusCode == 200) {
  print('[TradeHistory] API response received at: ${DateTime.now()}');
  print('[TradeHistory] API response: ${response.body}');
        final Map<String, dynamic> jsonData = json.decode(response.body);
        if (jsonData['success'] == true && jsonData['result'] != null) {
          print('[TradeHistory] API result: ${jsonData['result']}');
          final result = jsonData['result'];
          if (result is Map && result.containsKey('trades') && result['trades'] is List) {
            final List<dynamic> trades = result['trades'];
            final List<Map<String, dynamic>> parsedTrades = trades.map<Map<String, dynamic>>((trade) {
              print('[TradeHistory] Raw trade: $trade');
              final priceRaw = trade['price'];
              final quantityRaw = trade['quantity'];
              final timestampRaw = trade['timestamp'];
              final buyRaw = trade['buy'];
              final price = priceRaw != null ? double.tryParse(priceRaw.toString()) ?? 0.0 : 0.0;
                final quantityDouble = quantityRaw != null ? double.tryParse(quantityRaw.toString()) ?? 0.0 : 0.0;
                final quantity = (quantityDouble % 1 == 0)
                    ? quantityDouble.toInt().toString()
                    : quantityDouble.toString();
              final time = (() {
                if (timestampRaw == null) return '';
                final tsInt = int.tryParse(timestampRaw.toString());
                if (tsInt == null) return '';
                final dt = DateTime.fromMillisecondsSinceEpoch(tsInt * 1000).toLocal();
                // Format: Aug 12 2025 13:48:27
                final months = [
                  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
                ];
                final monthStr = months[dt.month - 1];
                final dayStr = dt.day.toString().padLeft(2, '0');
                final yearStr = dt.year.toString();
                final hourStr = dt.hour.toString().padLeft(2, '0');
                final minStr = dt.minute.toString().padLeft(2, '0');
                final secStr = dt.second.toString().padLeft(2, '0');
                return '$monthStr $dayStr $yearStr $hourStr:$minStr:$secStr';
              })();
              final priceColor = buyRaw == true ? Color(0xFF00D4AA) : Color(0xFFFF4081);
              final normalizedPrice = price / pow(10, quoteTokenDecimal);
              return {
                'price': normalizedPrice,
                  'quantity': quantity,
                'time': time,
                'priceColor': priceColor,
              };
            }).toList();
            setState(() {
              if (append) {
                _tradeHistory.addAll(parsedTrades);
              } else {
                _tradeHistory = parsedTrades;
              }
              _hasMoreTradeHistory = parsedTrades.length == _tradeHistoryPageSize;
              _isLoadingTradeHistory = false;
              print('[TradeHistory] Parsed trades: $_tradeHistory');
            });
          } else {
            setState(() {
              if (!append) {
                _tradeHistory = [
                  {
                    'price': '-',
                    'quantity': '-',
                    'time': 'No trades available for this asset.'
                  }
                ];
              }
              _hasMoreTradeHistory = false;
              _isLoadingTradeHistory = false;
            });
          }
        }
      }
    } catch (e) {
      print('❌ Error fetching trade history for $symbol: $e');
      setState(() {
        if (!append) {
          _tradeHistory = [];
        }
        _isLoadingTradeHistory = false;
      });
    }
  }
  
  void _loadMoreTradeHistory() {
    if (!_isLoadingTradeHistory && _hasMoreTradeHistory && _selectedSymbol.isNotEmpty) {
      _fetchTradeHistoryForAsset(_selectedSymbol, page: _currentTradeHistoryPage + 1, append: true);
      _currentTradeHistoryPage++;
    }
  }
  
  void _resetAndFetchTradeHistory(String symbol) {
    _currentTradeHistoryPage = 1;
    _hasMoreTradeHistory = true;
    _fetchTradeHistoryForAsset(symbol, page: 1, append: false);
  }

  /// Fetch supported currencies from the server
  Future<void> _fetchSupportedCurrencies() async {
    if (_isLoadingSupportedCurrencies) return;
    
    setState(() {
      _isLoadingSupportedCurrencies = true;
    });

    try {
      print('🏦 Fetching supported currencies...');
      final result = await realGrpcClient.getSupportedCurrencies().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print('⏰ GetSupportedCurrencies timed out after 10 seconds');
          return {
            'success': false,
            'output': {'error': 'Request timed out after 10 seconds'},
          };
        },
      );
      
      if (result['success'] == true && result['output'] != null) {
        final output = result['output'] as Map<String, dynamic>;
        final currencies = output['currencies'] as List<dynamic>? ?? [];
        
        final List<Map<String, String>> currencyData = [];
        
        for (final currency in currencies) {
          if (currency is Map<String, dynamic>) {
            // Extract currency value from currencies > identifiers > ids[0] > value
            String currencyValue = '';
            final identifiers = currency['identifiers'] as List<dynamic>? ?? [];
            if (identifiers.isNotEmpty) {
              final firstIdentifier = identifiers.first as Map<String, dynamic>? ?? {};
              final ids = firstIdentifier['ids'] as List<dynamic>? ?? [];
              if (ids.isNotEmpty) {
                final firstId = ids.first as Map<String, dynamic>? ?? {};
                currencyValue = firstId['value'] as String? ?? '';
              }
            }

            // Get display name and labels
            final displayNames = currency['displayNames'] as Map<String, dynamic>? ?? {};
            final currencyName = displayNames['en'] as String? ?? '';
            final labels = currency['labels'] as Map<String, dynamic>? ?? {};
            final currencySymbol = labels['symbol'] as String? ?? '';

            if (currencyValue.isNotEmpty) {
              final currencyMap = {
                'code': currencyValue,
                'symbol': currencySymbol.isNotEmpty ? currencySymbol : currencyValue,
                'display': currencyValue, // Show currencies > identifiers > ids[0] > value
                'asset_id': currencyValue, // For compatibility with existing code
              };
              currencyData.add(currencyMap);
              continue;
            }

            // Fallback: Handle old zonedSymbols structure if new structure not available
            final zonedSymbols = currency['zonedSymbols'] as List<dynamic>? ?? [];
            for (final zonedSymbol in zonedSymbols) {
              if (zonedSymbol is Map<String, dynamic>) {
                final symbols = zonedSymbol['symbols'] as List<dynamic>? ?? [];

                // Extract currency name and symbol
                String? fallbackCode;
                String? fallbackSymbol;

                for (final symbol in symbols) {
                  if (symbol is Map<String, dynamic>) {
                    final value = symbol['value'] as String?;
                    if (value != null && value.isNotEmpty) {
                      // First symbol is typically the currency code (USD)
                      if (fallbackCode == null) {
                        fallbackCode = value;
                      }
                      // Second symbol is typically the currency symbol ($)
                      else if (fallbackSymbol == null) {
                        fallbackSymbol = value;
                      }
                    }
                  }
                }

                // Add currency data if we have at least the code
                if (fallbackCode != null) {
                  final currencyMap = {
                    'code': fallbackCode,
                    'symbol': fallbackSymbol ?? fallbackCode, // fallback to code if no symbol
                    'display': fallbackSymbol != null && fallbackSymbol != fallbackCode
                        ? '$fallbackCode($fallbackSymbol)'
                        : fallbackCode,
                    'asset_id': fallbackCode,
                  };
                  currencyData.add(currencyMap);
                }
              }
            }
          }
        }
        
        setState(() {
          _supportedCurrencies = currencyData;
          if (_selectedCurrency.isEmpty && _supportedCurrencies.isNotEmpty) {
            _selectedCurrency = _supportedCurrencies.first;
          }
          _isLoadingSupportedCurrencies = false;
        });
        
        print('✅ Loaded ${_supportedCurrencies.length} supported currencies');
      } else {
        print('❌ Failed to fetch supported currencies: ${result['output']}');
        setState(() {
          _isLoadingSupportedCurrencies = false;
        });
      }
    } catch (e) {
      print('❌ Error fetching supported currencies: $e');
      setState(() {
        _isLoadingSupportedCurrencies = false;
      });
    }
  }

  /// Fetch markets from the server
  Future<void> _fetchMarketList() async {
    if (_isLoadingMarkets) return;
    
    setState(() {
      _isLoadingMarkets = true;
    });

    try {
      print('🏪 Fetching market list...');
      final result = await realGrpcClient.getMarketList().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print('⏰ GetMarketList timed out after 10 seconds');
          return {
            'success': false,
            'output': {'error': 'Request timed out after 10 seconds'},
          };
        },
      );
      
      if (result['success'] == true && result['output'] != null) {
        final output = result['output'] as Map<String, dynamic>;
        final markets = output['markets'] as List<dynamic>? ?? [];
        
        final List<Map<String, String>> marketData = [];
        
        for (final market in markets) {
          if (market is Map<String, dynamic>) {
            // Extract market ID from identifiers structure
            final identifiers = market['identifiers'] as List<dynamic>? ?? [];
            final displayNames = market['displayNames'] as Map<String, dynamic>? ?? {};

            String? marketId;
            String? marketName;

            // Extract market ID from the complex identifier structure
            if (identifiers.isNotEmpty) {
              final identifier = identifiers[0] as Map<String, dynamic>? ?? {};
              final ids = identifier['ids'] as List<dynamic>? ?? [];
              if (ids.isNotEmpty) {
                final idObj = ids[0] as Map<String, dynamic>? ?? {};
                marketId = idObj['value'] as String?;
              }
            }

            // Use display name in English, or fall back to market ID
            marketName = displayNames['en'] as String? ?? marketId;

            if (marketId != null && marketId.isNotEmpty) {
              final marketMap = {
                'id': marketId,
                'name': marketName ?? marketId,
                'description': marketName ?? marketId,
                'display': marketName ?? marketId, // Show the name in dropdown
              };
              marketData.add(marketMap);
            }
          }
        }
        
        setState(() {
          _markets = marketData;
          if (_selectedMarket.isEmpty && _markets.isNotEmpty) {
            _selectedMarket = _markets.first;
          }
          _isLoadingMarkets = false;
        });
        
        print('✅ Loaded ${_markets.length} markets');
        
        // Load instruments for the first market if available
        if (_selectedMarket.isNotEmpty && _selectedMarket['id']!.isNotEmpty) {
          _fetchMarketInstruments(_selectedMarket['id']!);
        }
      } else {
        print('❌ Failed to fetch markets: ${result['output']}');
        setState(() {
          _isLoadingMarkets = false;
        });
      }
    } catch (e) {
      print('❌ Error fetching markets: $e');
      setState(() {
        _isLoadingMarkets = false;
      });
    }
  }

  /// Fetch instruments for a specific market
  Future<void> _fetchMarketInstruments(String marketId) async {
    try {
      print('🏪 Fetching instruments for market: $marketId');
      
      setState(() {
        _isLoadingMarketInstruments = true;
        _assets.clear(); // Clear existing assets
        _selectedSymbol = ''; // Reset selected symbol
      });
      
      final result = await realGrpcClient.getMarketInstrumentList(
        marketId: marketId,
        pageNumber: 1,
        pageSize: 100, // Get more instruments
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print('⏰ GetMarketInstrumentList timed out after 10 seconds');
          return {
            'success': false,
            'output': {'error': 'Request timed out after 10 seconds'},
          };
        },
      );
      
      if (result['success'] == true && result['output'] != null) {
        final output = result['output'] as Map<String, dynamic>;
        final instruments = output['instruments'] as List<dynamic>? ?? [];
        
        final List<Map<String, dynamic>> processedAssets = [];
        
        for (final instrument in instruments) {
          if (instrument is Map<String, dynamic>) {
            // Extract symbol from identifiers structure
            String symbol = '';
            String description = '';

            final identifiers = instrument['identifiers'] as List<dynamic>? ?? [];
            final displayNames = instrument['displayNames'] as Map<String, dynamic>? ?? {};

            // Extract symbol from the complex identifier structure
            if (identifiers.isNotEmpty) {
              final identifier = identifiers[0] as Map<String, dynamic>? ?? {};
              final ids = identifier['ids'] as List<dynamic>? ?? [];
              if (ids.isNotEmpty) {
                final idObj = ids[0] as Map<String, dynamic>? ?? {};
                symbol = idObj['value'] as String? ?? '';
              }
            }

            // Use display name in English, or fall back to symbol
            description = displayNames['en'] as String? ?? symbol;

            final iid = instrument['iid']?.toString() ?? '';
            final issueCurrency = instrument['issueCurrency']?.toString() ?? '';

            if (symbol.isNotEmpty) {
              final assetMap = {
                'symbol': symbol,
                'description': description,
                'exchangePairId': iid,
                'price': '0.00',
                'change': '0.00',
                'changePercent': '0.00%',
                'coverAddress': 'https://picsum.photos/112/120?random=${processedAssets.length}',
                'last': 0.0,
                'orderbook': '',
                'quoteTokenDecimal': 8, // Default decimal places
                'issueCurrency': issueCurrency,
                'iid': iid,
              };
              processedAssets.add(assetMap);
            }
          }
        }
        
        setState(() {
          _assets.clear();
          _assets.addAll(processedAssets);
          if (_selectedSymbol.isEmpty && _assets.isNotEmpty) {
            _selectedSymbol = _assets.first['symbol'];
            // Load chart immediately when symbol is first set
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _fetchChartData(_selectedSymbol);
            });
          }
          _isLoadingMarketInstruments = false;
        });
        
        print('✅ Loaded ${_assets.length} instruments for market $marketId');
        if (_assets.isNotEmpty) {
          print('📋 Sample instruments: ${_assets.take(3).map((a) => a['symbol']).toList()}');
          
          // Fetch last prices for the loaded instruments
          for (final asset in _assets) {
            _fetchLastPriceForAsset(asset);
          }
          
          // Load trade history and orderbook for the first asset
          if (_selectedSymbol.isNotEmpty) {
            _fetchTradeHistoryForAsset(_selectedSymbol, page: 1, append: false);
            _fetchOrderbookData(_selectedSymbol);
          }
        }
      } else {
        print('❌ Failed to fetch instruments for market $marketId: ${result['output']}');
        setState(() {
          _assets.clear();
          _isLoadingMarketInstruments = false;
        });
      }
    } catch (e) {
      print('❌ Error fetching instruments for market $marketId: $e');
      setState(() {
        _assets.clear();
        _isLoadingMarketInstruments = false;
      });
    }
  }

  /// Update buying power from cached holdings data when currency changes
  void _updateBuyingPowerFromCachedData() {
    if (_cachedHoldings == null || _selectedCurrency.isEmpty) {
      _buyingPower = '0';
      return;
    }

    final selectedCurrencyCode = _selectedCurrency['code'];
    final currencyHolding = _cachedHoldings![selectedCurrencyCode] as Map<String, dynamic>? ?? {};
    final currencyBalance = currencyHolding['totalUnits']?.toString() ?? '0';

    _buyingPower = currencyBalance;
    print('✅ Updated buying power from cache for $selectedCurrencyCode: $currencyBalance');
  }


  /// Fetch account market portfolio for available balance
  Future<void> _fetchAccountMarketPortfolio() async {
    // Call the new method with current selected market
    await _fetchAccountMarketPortfolioForMarket(_selectedMarket['id'] ?? '');
  }

  Future<void> _fetchAccountMarketPortfolioForMarket(String marketId) async {
    try {
      print('📊 Fetching account market portfolio for market: $marketId...');

      // Check if we have required data
      if (_cachedAccountId == null || _cachedAccountId!.isEmpty) {
        print('❌ No cached account ID available for portfolio');
        return;
      }

      if (marketId.isEmpty) {
        print('❌ No market ID provided for portfolio');
        return;
      }

      if (_selectedSymbol.isEmpty) {
        print('❌ No asset selected for portfolio');
        return;
      }

      // Extract asset ID from selected symbol (e.g., "ETH/USD" -> "ETH")
      final assetId = _selectedSymbol.split('/').first;

      print('📨 GetAccountMarketPortfolio REQUEST:');
      print('   account_id: ${_cachedAccountId!}');
      print('   market_id: $marketId');
      print('   asset_ids: [$assetId]');

      final portfolioResponse = await realGrpcClient.getAccountMarketPortfolio(
        accountId: _cachedAccountId!,
        marketId: marketId,
        assetIds: [assetId],
      ).timeout(const Duration(seconds: 10));

      print('📬 GetAccountMarketPortfolio RESPONSE: ${portfolioResponse.toString()}');

      if (portfolioResponse['success'] == true && portfolioResponse['output'] != null) {
        final output = portfolioResponse['output'] as Map<String, dynamic>;

        // Look for balance in the response
        String balance = '0';

        // Check if response has portfolio.balances structure
        if (output['portfolio'] != null) {
          final portfolio = output['portfolio'] as Map<String, dynamic>? ?? {};
          print('📊 Found portfolio section: $portfolio');
          if (portfolio['balances'] != null) {
            final balances = portfolio['balances'] as Map<String, dynamic>? ?? {};
            print('💰 Found balances: $balances');
            balance = balances[assetId]?.toString() ?? '0';
            print('✅ Extracted balance for $assetId: $balance');
          }
        } else if (output['balances'] != null) {
          final balances = output['balances'] as Map<String, dynamic>? ?? {};
          balance = balances[assetId]?.toString() ?? '0';
        } else if (output['balance'] != null) {
          balance = output['balance'].toString();
        } else if (output['holdings'] != null) {
          final holdings = output['holdings'] as List<dynamic>? ?? [];
          for (final holding in holdings) {
            if (holding is Map<String, dynamic> && holding['asset_id'] == assetId) {
              balance = holding['balance']?.toString() ?? '0';
              break;
            }
          }
        }

        setState(() {
          _availableBalance = balance;
        });

        print('✅ Updated available balance for $assetId: $balance (market: $marketId)');
      } else {
        print('❌ Failed to fetch account market portfolio: ${portfolioResponse['output']}');
        setState(() {
          _availableBalance = '0';
        });
      }
    } catch (e) {
      print('❌ Error fetching account market portfolio for market $marketId: $e');
      setState(() {
        _availableBalance = '0';
      });
    }
  }
  
  final List<Map<String, dynamic>> _assets = [];
  List<Map<String, dynamic>> _tradeHistory = [];
  String _selectedSymbol = '';  // Will be set when assets are loaded
  String _orderType = 'Limit';
  String _expiryPeriod = '1 Month'; // Add expiry period variable
  String _replaceExpiryPeriod = 'Select new expiration time'; // Add replace order expiry period variable
  bool _isBuySelected = true;
  
  // Market data
  List<Map<String, String>> _markets = [];
  Map<String, String> _selectedMarket = {};
  bool _isLoadingMarkets = false;
  bool _isLoadingMarketInstruments = false;

  // Supported currencies data
  List<Map<String, String>> _supportedCurrencies = [];
  Map<String, String> _selectedCurrency = {};
  bool _isLoadingSupportedCurrencies = false;
  
  // Trade history pagination
  int _currentTradeHistoryPage = 0;
  int _tradeHistoryPageSize = 0;
  bool _hasMoreTradeHistory = true;
  bool _isLoadingTradeHistory = false;
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _orderIdController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _replaceOrderIdController = TextEditingController();
  final TextEditingController _newOrderIdController = TextEditingController();
  final TextEditingController _newQuantityController = TextEditingController();
  final TextEditingController _newPriceController = TextEditingController();
  final TextEditingController _replaceReasonController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  // Cash holdings data
  bool _isLoadingCashHoldings = false;
  String _buyingPower = '0'; // Default fallback value
  String _availableBalance = '0'; // For sell orders - available asset balance
  String? _cachedAccountId; // Cache account ID for entire session (doesn't change until logout)
  Map<String, dynamic>? _cachedHoldings; // Cache all holdings data

  // Order fee calculation
  bool _isLoadingFee = false;
  String _estimatedFee = '0 \$'; // Store the estimated fee
  
  // Message stream subscription
  StreamSubscription<String>? _messageSubscription;
  StreamSubscription<bool>? _connectionStatusSubscription;
  StreamSubscription<bool>? _logonStatusSubscription;
  bool _hasRequestedSecurityDefinitions = false;
  Timer? _securityRequestTimeout;
  
  // Panel width variables for resizable panels
  double _leftPanelWidth = 357.0; // Increased by 40% (255 * 1.40 = 357)
  double _rightPanelWidth = 357.0; // Increased by 40% (255 * 1.40 = 357)
  bool _isDraggingLeft = false;
  bool _isDraggingRight = false;
  
  // Panel height variables for resizable horizontal sections
  double _orderbookHeight = 150.0; // Default orderbook height
  bool _isDraggingHorizontal = false;
  double _marketOverviewHeight = 190.0; // Increased by 1.1x (215 * 1.1 = 236.5)
  bool _isDraggingMarketOverview = false; // State for market splitter

  // Bottom section width split (Orders vs Orderbook)
  double _bottomOrdersWidth = 0.71; // 71% for Orders, 29% for Orderbook
  bool _isDraggingBottomSplit = false;

  // Top/Bottom section height split
  double _topSectionRatio = 0.67; // 67% for top, 33% for bottom
  bool _isDraggingTopBottomSplit = false;

  // Activity section tabs
  int _activityTabIndex = 0;
  final List<String> _activityTabNames = ['Orderbook', 'Trade History'];

  // Orders section tabs
  int _ordersTabIndex = 0; // 0 = Orders (default), 1 = History
  final List<String> _ordersTabNames = ['Orders', 'History'];

  // Sample orders data
  final List<Map<String, dynamic>> _sampleOrders = [
    {
      "order_id": "ord_789abc",
      "side": "ORDER_SIDE__BUY",
      "symbol": "BTC/USD",
      "quantity": "0.5",
      "price": "67500.00",
      "create_timestamp": "1726580536",
      "expire_timestamp": "1727185337",
      "is_filled": false,
      "is_cancelled": false,
      "is_expired": false,
    },
    {
      "order_id": "ord_456def",
      "side": "ORDER_SIDE__SELL",
      "symbol": "ETH/USD",
      "quantity": "2.0",
      "price": "0.00",
      "create_timestamp": "1726580200",
      "expire_timestamp": null,
      "is_filled": false,
      "is_cancelled": false,
      "is_expired": false,
    },
    {
      "order_id": "ord_123ghi",
      "side": "ORDER_SIDE__SELL",
      "symbol": "BTC/USD",
      "quantity": "0.25",
      "price": "68000.00",
      "create_timestamp": "1726579800",
      "expire_timestamp": null,
      "is_filled": false,
      "is_cancelled": false,
      "is_expired": false,
    },
  ];

  // Real orders data from GetAccountOrders API
  List<Map<String, dynamic>> _realOrders = [];
  bool _isLoadingRealOrders = false;
  String? _realOrdersError;

  // Order history data (filled, expired, cancelled orders from GetAccountOrders)
  List<Map<String, dynamic>> _orderHistory = [];

  // Chart data variables
  Map<String, List<Map<String, dynamic>>> _chartData = {}; // Cache chart data by symbol
  bool _isLoadingChart = false;
  String _chartError = '';
  String _selectedTimePeriod = '1m'; // Default to 1 month
  
  // Orderbook data variables
  List<Map<String, dynamic>> _sellOrders = [];
  List<Map<String, dynamic>> _buyOrders = [];
  bool _isLoadingSellOrders = false;
  bool _isLoadingBuyOrders = false;
  bool _isLoadingMoreSellOrders = false;
  bool _isLoadingMoreBuyOrders = false;
  
  // Orderbook pagination
  int _currentSellOrdersPage = 1;
  int _currentBuyOrdersPage = 1;
  int _orderbookPageSize = 4;
  bool _hasMoreSellOrders = true;
  bool _hasMoreBuyOrders = true;
  int _totalSellOrdersPages = 1;
  int _totalBuyOrdersPages = 1;


  @override
  void initState() {
    super.initState();
    
    // Check server connectivity when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ConnectivityChecker.checkAndShowErrorIfNeeded(context, 'Trading');
    });
    
    // Listen for connection status changes and show notifications
    _listenToConnectionStatus();
    // Listen for FIX messages to handle Security Definition Responses
    _listenToFixMessages();
    
    // Add listeners to text controllers to update total calculation
    _quantityController.addListener(() {
      setState(() {});
      _calculateOrderFees();
    });
    _priceController.addListener(() {
      setState(() {});
      _calculateOrderFees();
    });
    
    // Fetch pairs from API immediately when page opens, independent of FIX connection
    // _fetchPairsFromAPI(); // Disabled - now using GetMarketInstrumentList based on selected market
    
    // Fetch cash holdings for buying power
    _fetchCashHoldings();
    
    // Fetch market list for the dropdown
    _fetchMarketList();
    
    // Fetch supported currencies for the dropdown
    _fetchSupportedCurrencies();

      // Fetch trade history, orderbook, and chart for default symbol when page is shown and assets are loaded
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_selectedSymbol.isNotEmpty) {
          _fetchChartData(_selectedSymbol);
          _resetAndFetchTradeHistory(_selectedSymbol);
          _fetchOrderbookData(_selectedSymbol);
        }
      });

    // Initialize sample data for demonstration
    _initializeSampleTradeOrdersData();
  }

  void _initializeSampleTradeOrdersData() {
    // No longer needed since Replace Order and Cancel Order tabs were removed
  }

  void _listenToConnectionStatus() {
    // FIX connection status removed - no longer needed
    print('Connection status monitoring disabled - FIX functionality removed');
  }
  
  void _listenToFixMessages() {
    // FIX message listening removed - no longer needed
    print('FIX message monitoring disabled - FIX functionality removed');
  }
  
  /// Find the account that belongs to the logged-in user
  String? _findUserAccount(List<dynamic> accounts, String username) {
    print('🔍 Searching for account matching user: "$username"');
    print('📋 Available accounts:');
    
    for (int i = 0; i < accounts.length; i++) {
      final accountMap = accounts[i] as Map<String, dynamic>;
      final externalId = accountMap['external_id'] ?? accountMap['externalId'] ?? accountMap['externalAccountId'] ?? '';
      final accountId = accountMap['id'] ?? accountMap['iid'] ?? '';
      print('   [$i] ID: "$accountId", ExternalID: "$externalId"');
      
      // Try exact match first (case-sensitive)
      if (externalId == username) {
        print('✅ Found EXACT match for user "$username": ID="$accountId", ExternalID="$externalId"');
        return accountId;
      }
    }
    
    // If no exact match, try case-insensitive
    for (final account in accounts) {
      final accountMap = account as Map<String, dynamic>;
      final externalId = accountMap['external_id'] ?? accountMap['externalId'] ?? accountMap['externalAccountId'] ?? '';
      final accountId = accountMap['id'] ?? accountMap['iid'] ?? '';
      
      if (externalId.toLowerCase() == username.toLowerCase()) {
        print('✅ Found case-insensitive match for user "$username": ID="$accountId", ExternalID="$externalId"');
        return accountId;
      }
    }
    
    // If still no match, try contains
    for (final account in accounts) {
      final accountMap = account as Map<String, dynamic>;
      final externalId = accountMap['external_id'] ?? accountMap['externalId'] ?? accountMap['externalAccountId'] ?? '';
      final accountId = accountMap['id'] ?? accountMap['iid'] ?? '';
      
      if (externalId.toLowerCase().contains(username.toLowerCase()) || 
          accountId.toLowerCase().contains(username.toLowerCase())) {
        print('⚠️ Found partial match for user "$username": ID="$accountId", ExternalID="$externalId"');
        return accountId;
      }
    }
    
    // If no match found for the logged-in user, return empty string
    print('❌ No account found for user "$username" on the server');
    print('🔍 Searched in ${accounts.length} accounts');
    return '';
  }

  /// Fetch cash holdings for the logged-in user to get buying power
  Future<void> _fetchCashHoldings() async {
    try {
      if (!realGrpcClient.isConnected) {
        print('❌ Not connected to real gRPC server for cash holdings');
        return;
      }

      // Check if we already have cached account ID (account ID doesn't change during session)
      if (_cachedAccountId != null && 
          _cachedAccountId!.isNotEmpty &&
          !_isLoadingCashHoldings) {
        print('✅ Using cached account ID for fresh cash holdings: $_cachedAccountId');
        await _fetchCashHoldingsForAccount(_cachedAccountId!);
        return;
      }

      // First time - need to lookup account ID
      setState(() {
        _isLoadingCashHoldings = true;
      });

      final authService = Provider.of<AuthService>(context, listen: false);
      final currentUsername = authService.username;
      print('🔍 First time lookup for user: $currentUsername');

      // Get account list to find the user's account ID
      final accountListResponse = await realGrpcClient.getAccountList().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print('⏰ GetAccountList timed out after 10 seconds');
          return {
            'success': false,
            'output': {'error': 'Request timed out after 10 seconds'},
          };
        },
      );
      
      String? accountId;
      if (accountListResponse['success'] == true) {
        final accounts = accountListResponse['output']['accounts'] as List<dynamic>;
        accountId = _findUserAccount(accounts, currentUsername);
      }

      print('🔍 Account ID found: "$accountId" for user: $currentUsername');

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

      // Fetch real orders now that we have the account ID
      _fetchRealOrders();

      await _fetchCashHoldingsForAccount(accountId);
    } catch (e) {
      // Ultimate crash protection
      try {
        if (mounted) {
          setState(() {
            _isLoadingCashHoldings = false;
            // Don't reset buying power on error if we have valid cached data
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

  /// Fetch cash holdings for a specific account ID
  Future<void> _fetchCashHoldingsForAccount(String accountId) async {
    try {

      // Fetch cash holdings with comprehensive crash protection
      final cashHoldingsResponse = await realGrpcClient.getAccountCashHoldings(
        accountId: accountId,
        cashAssetIds: [],
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
          // Extract balance for selected currency from the response
          final output = cashHoldingsResponse['output'] as Map<String, dynamic>;
          final cashPortfolio = output['cashPortfolio'] as Map<String, dynamic>? ?? {};
          final holdings = cashPortfolio['holdings'] as Map<String, dynamic>? ?? {};

          // Cache the holdings data for currency switching
          _cachedHoldings = holdings;

          // Get balance for currently selected currency
          final selectedCurrencyCode = _selectedCurrency.isNotEmpty ? _selectedCurrency['code'] : 'USD';
          final currencyHolding = holdings[selectedCurrencyCode] as Map<String, dynamic>? ?? {};
          final currencyBalance = currencyHolding['totalUnits']?.toString() ?? '0';

          setState(() {
            _buyingPower = currencyBalance;
          });

          print('✅ Cash holdings loaded successfully! $selectedCurrencyCode balance: $currencyBalance');
        } else {
          final output = cashHoldingsResponse['output'] as Map<String, dynamic>;
          setState(() {
            _buyingPower = '0'; // Set to 0 on error
          });
          print('❌ Failed to fetch cash holdings: ${output['error'] ?? 'Unknown error'}');
        }
      }
    } catch (e) {
      // Ultimate crash protection
      try {
        if (mounted) {
          setState(() {
            _isLoadingCashHoldings = false;
            _buyingPower = '0'; // Set to 0 on error
          });
        }
        print('❌ Failed to fetch cash holdings: ${e.toString()}');
      } catch (innerE) {
        print('❌ Critical error in _fetchCashHoldings: $e, UI update failed: $innerE');
      }
    }
  }

  /// Fetch real account orders using GetAccountOrders API
  Future<void> _fetchRealOrders() async {
    if (_cachedAccountId == null || _cachedAccountId!.isEmpty) {
      print('❌ No cached account ID available for fetching orders');
      return;
    }

    if (_isLoadingRealOrders) return;

    setState(() {
      _isLoadingRealOrders = true;
      _realOrdersError = null;
    });

    try {
      print('📋 Fetching real orders for account: $_cachedAccountId');

      final result = await GrpcurlHelper.getAccountOrders(
        accountId: _cachedAccountId!,
        refRequestId: 'flutter-trading-page-${DateTime.now().millisecondsSinceEpoch}',
        pagination: {
          'page_nr': 0,
          'page_size': 50, // Get up to 50 orders
          'page_token': '',
        },
      ).timeout(const Duration(seconds: 10));

      if (result['success'] == true && result['output'] != null) {
        final output = result['output'];
        print('📬 GetAccountOrders Response: $output');

        if (output['orders'] != null && output['orders'] is List) {
          final List<dynamic> ordersData = output['orders'];

          // Process all orders first
          final allProcessedOrders = ordersData.map<Map<String, dynamic>>((order) {
            return {
              'order_id': order['orderIid'] ?? order['order_id'] ?? 'N/A',
              'side': order['side'] ?? 'N/A',
              'symbol': order['instrumentIid'] ?? order['symbol'] ?? 'N/A',
              'quantity': order['quantity'] ?? '0',
              'price': order['price'] ?? '0',
              'create_timestamp': order['createTimestamp'] ?? order['createdAtDt']?['ts'] ?? order['create_timestamp'],
              'expire_timestamp': order['expireTimestamp'] ?? order['expireAtDt']?['ts'] ?? order['expire_timestamp'],
              'is_filled': order['isFilled'] ?? order['is_filled'] ?? false,
              'is_cancelled': order['isCancelled'] ?? order['is_cancelled'] ?? false,
              'is_expired': order['isExpired'] ?? order['is_expired'] ?? false,
              'order_status': order['orderStatus'] ?? 'UNKNOWN',
              'order_type': order['orderType'] ?? order['order_type'] ?? 'UNKNOWN',
            };
          }).toList();

          // Split orders by status: active vs history
          final activeOrders = <Map<String, dynamic>>[];
          final historyOrders = <Map<String, dynamic>>[];

          for (final order in allProcessedOrders) {
            final isFilled = order['is_filled'] as bool;
            final isCancelled = order['is_cancelled'] as bool;
            final isExpired = order['is_expired'] as bool;

            // History orders: filled, cancelled, or expired
            if (isFilled || isCancelled || isExpired) {
              historyOrders.add(order);
            } else {
              // Active orders: not filled, not cancelled, not expired
              activeOrders.add(order);
            }
          }

          setState(() {
            _realOrders = activeOrders;  // Only active orders in main orders table
            _orderHistory = historyOrders;  // Filled/cancelled/expired in history table
            _isLoadingRealOrders = false;
          });

          print('✅ Successfully loaded ${activeOrders.length} active orders and ${historyOrders.length} history orders');
        } else {
          print('📝 No orders found in response');
          setState(() {
            _realOrders = [];
            _orderHistory = [];
            _isLoadingRealOrders = false;
          });
        }
      } else {
        final errorMsg = result['output']?['error'] ?? 'Failed to fetch orders';
        print('❌ GetAccountOrders failed: $errorMsg');
        setState(() {
          _realOrdersError = errorMsg;
          _isLoadingRealOrders = false;
        });
      }
    } catch (e) {
      print('❌ Exception in _fetchRealOrders: $e');
      setState(() {
        _realOrdersError = 'Exception: ${e.toString()}';
        _isLoadingRealOrders = false;
      });
    }
  }

  /// Calculate order fees using the real GetOrderFees API
  Future<void> _calculateOrderFees() async {
    // Reset fee to default if required fields are missing
    if (_cachedAccountId == null ||
        _selectedSymbol.isEmpty ||
        _quantityController.text.trim().isEmpty) {
      setState(() {
        _estimatedFee = '0 \$';
        _isLoadingFee = false;
      });
      return;
    }

    // Reset fee for Limit orders without price
    if (_orderType == 'Limit' && _priceController.text.trim().isEmpty) {
      setState(() {
        _estimatedFee = '0 \$';
        _isLoadingFee = false;
      });
      return;
    }

    if (_isLoadingFee) return;

    setState(() {
      _isLoadingFee = true;
    });

    try {
      print('💰 Calculating order fees...');

      final instrumentId = _selectedSymbol.split('/').first; // Extract asset part from symbol
      final orderTypeApi = _orderType == 'Limit' ? 'LIMIT' : 'MARKET';
      final sideApi = _isBuySelected ? 'BUY' : 'SELL';
      final quantity = _quantityController.text.trim();
      final price = _priceController.text.trim();

      final result = await realGrpcClient.getOrderFees(
        accountId: _cachedAccountId!,
        feePayerAccountId: _cachedAccountId!,
        instrumentId: instrumentId,
        orderType: orderTypeApi,
        side: sideApi,
        quantity: quantity,
        price: orderTypeApi == 'LIMIT' ? price : null,
        timeInForce: "0",
      );

      if (result['success'] == true && result['output'] != null) {
        final output = result['output'] as Map<String, dynamic>;
        final feeStructure = output['feeStructure'] as Map<String, dynamic>?;

        if (feeStructure != null && feeStructure['totalEstimatedFee'] != null) {
          final totalFee = feeStructure['totalEstimatedFee'].toString();
          final currency = feeStructure['currency']?.toString() ?? '\$';
          final formattedFee = _formatDecimal(totalFee);

          setState(() {
            _estimatedFee = '$formattedFee $currency';
            _isLoadingFee = false;
          });

          print('✅ Fee calculated successfully: $_estimatedFee');
        } else {
          // Fallback to 0.00 if fee structure is incomplete
          setState(() {
            _estimatedFee = '0 \$';
            _isLoadingFee = false;
          });
          print('⚠️ Fee structure incomplete, using default');
        }
      } else {
        // On error, fallback to 0.00
        setState(() {
          _estimatedFee = '0 \$';
          _isLoadingFee = false;
        });
        final error = result['output']?['error'] ?? 'Unknown error';
        print('❌ Failed to calculate fees: $error');
      }
    } catch (e) {
      // On exception, fallback to 0.00
      setState(() {
        _estimatedFee = '0 \$';
        _isLoadingFee = false;
      });
      print('❌ Error calculating fees: $e');
    }
  }

  // Fetch last price for asset using exchangePairId
  Future<void> _fetchLastPriceForAsset(Map<String, dynamic> asset) async {
    final exchangePairId = asset['exchangePairId']?.toString() ?? '';
    final quoteTokenDecimal = asset['quoteTokenDecimal'] ?? 0;
    if (exchangePairId.isEmpty) return;
    try {
      final response = await http.get(
        Uri.parse('https://brokerage-api-stage.tokenise.io/api/services/app/Pair/GetSinglePairByExchangePairId?ExchangePairId=$exchangePairId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        if (jsonData['success'] == true && jsonData['result'] != null) {
          final result = jsonData['result'];
          final lastTradePriceRaw = result['last_trade_price'];
          if (lastTradePriceRaw != null) {
            final lastTradePrice = double.tryParse(lastTradePriceRaw.toString()) ?? 0.0;
            final lastPrice = lastTradePrice / (pow(10, quoteTokenDecimal));
            asset['last'] = lastPrice;
            asset['price'] = '${lastPrice.toStringAsFixed(2)}';
          }
        }
      }
    } catch (e) {
      print('Error fetching last price for $exchangePairId: $e');
    }
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
          
          _assets.clear(); // Clear any existing assets
          List<Future<void>> priceFutures = [];
          for (final pair in pairs) {
            final symbol = pair['symbol']?.toString() ?? '';
            final title = pair['title']?.toString() ?? symbol;
            final logoAddress = pair['logoAddress']?.toString() ?? '';
            final coverAddress = pair['coverAddress']?.toString() ?? '';
            final orderbook = pair['orderbook']?.toString() ?? '';
            final exchangePairId = pair['exchangePairId']?.toString() ?? '';
            final quoteTokenDecimal = int.tryParse(pair['quoteTokenDecimal']?.toString() ?? '0') ?? 0;
            if (symbol.isNotEmpty) {
              final asset = {
                'symbol': symbol,
                'name': title,
                'title': title,
                'logoAddress': logoAddress,
                'coverAddress': coverAddress.isNotEmpty ? coverAddress : 'https://picsum.photos/112/120?random=${_assets.length}',
                'orderbook': orderbook,
                'exchangePairId': exchangePairId,
                'quoteTokenDecimal': quoteTokenDecimal,
                'price': '\$0.00',
                'change': '+0.00%',
                'changeColor': Colors.grey,
                'last': null,
              };
              _assets.add(asset);
              // Fetch last price for this asset
              if (exchangePairId.isNotEmpty) {
                priceFutures.add(_fetchLastPriceForAsset(asset));
              }
            }
          }
          // Wait for all last price fetches to complete
          await Future.wait(priceFutures);
          setState(() {
            // Update selected symbol if this is the first time or current is empty
            if (_selectedSymbol.isEmpty && _assets.isNotEmpty) {
              _selectedSymbol = _assets.first['symbol'];
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Future.delayed(const Duration(milliseconds: 500), () {
                  if (mounted) {
                    _fetchChartData(_selectedSymbol);
                    _resetAndFetchTradeHistory(_selectedSymbol);
                    _fetchOrderbookData(_selectedSymbol);
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
            // Load chart immediately when symbol is first set
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _fetchChartData(_selectedSymbol);
            });
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
  
  Future<void> _fetchOrderbookData(String symbol) async {
    print('📊 Fetching orderbook data for symbol: $symbol');
    
    // Reset pagination when fetching new symbol
    _currentSellOrdersPage = 1;
    _currentBuyOrdersPage = 1;
    _hasMoreSellOrders = true;
    _hasMoreBuyOrders = true;
    _totalSellOrdersPages = 1;
    _totalBuyOrdersPages = 1;
    
    // Fetch both sell and buy orders in parallel for faster loading
    await Future.wait([
      _fetchSellOrders(symbol, page: 1, append: false),
      _fetchBuyOrders(symbol, page: 1, append: false),
    ]);
  }
  
  Future<void> _fetchSellOrders(String symbol, {int page = 1, bool append = false}) async {
    print('📊 Fetching sell orders for symbol: $symbol, page: $page');
    
    // Find the asset data for this symbol
    final asset = _assets.firstWhere(
      (asset) => asset['symbol'] == symbol,
      orElse: () {
        print('[Orderbook] Asset not found for symbol: $symbol');
        setState(() {
          if (!append) _sellOrders = [];
          _isLoadingSellOrders = false;
        });
        return <String, dynamic>{};
      },
    );

    if (asset.isEmpty) {
      print('❌ Asset not found for sell orders: $symbol');
      return;
    }

    final orderbook = asset['orderbook']?.toString() ?? '';
    final exchangePairId = asset['exchangePairId']?.toString() ?? '';
    final quoteTokenDecimal = int.tryParse(asset['quoteTokenDecimal']?.toString() ?? '0') ?? 0;

    print('[Orderbook-Sell] $symbol: orderbook="$orderbook", exchangePairId="$exchangePairId"');

    if (orderbook.isEmpty || exchangePairId.isEmpty) {
      print('❌ Missing required fields for sell orders $symbol - no orderbook data available');
      setState(() {
        if (!append) _sellOrders = [];
        _hasMoreSellOrders = false; // No more data to load
        _totalSellOrdersPages = 1; // Reset total pages
        _isLoadingSellOrders = false;
      });
      return;
    }
    
    if (!append) {
      setState(() {
        _isLoadingSellOrders = true;
      });
    } else {
      setState(() {
        _isLoadingMoreSellOrders = true;
      });
    }
    
    try {
      final response = await http.post(
        Uri.parse('https://brokerage-api-stage.tokenise.io/api/services/app/Agora/OrderbookQueue'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          "page": page,
          "page_size": _orderbookPageSize,
          "chain_id": "131074",
          "orderbook": orderbook,
          "pair_id": exchangePairId,
          "queue_id": "bids"
        }),
      ).timeout(const Duration(seconds: 10));
      
      List<Map<String, dynamic>> sellOrders = [];
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> bidsData = json.decode(response.body);
        print('[Orderbook-Sell] $symbol API response: ${response.body}');
        
        if (bidsData['success'] == true && bidsData['result'] != null) {
          final result = bidsData['result'];
          print('[Orderbook-Sell] $symbol result structure: ${result.keys}');
          
          if (result is Map && result.containsKey('orders') && result['orders'] is List) {
            final List<dynamic> orders = result['orders'];
            print('[Orderbook-Sell] $symbol found ${orders.length} orders');
            sellOrders = orders.map<Map<String, dynamic>>((order) {
              final priceRaw = order['price'];
              final quantityRaw = order['quantity'];
              
              final price = priceRaw != null ? double.tryParse(priceRaw.toString()) ?? 0.0 : 0.0;
              final quantity = quantityRaw != null ? double.tryParse(quantityRaw.toString()) ?? 0.0 : 0.0;
              
              // Normalize price using quoteTokenDecimal
              final normalizedPrice = price / pow(10, quoteTokenDecimal);
              
              return {
                'price': normalizedPrice,
                'quantity': quantity,
              };
            }).toList();
          } else {
            print('[Orderbook-Sell] $symbol: No orders field found or orders is not a list. Result: $result');
          }
        } else {
          print('[Orderbook-Sell] $symbol: API response not successful or result is null. Response: $bidsData');
        }
      } else {
        print('❌ Sell orders API error: ${response.statusCode} - ${response.body}');
      }
      
      setState(() {
        if (append) {
          _sellOrders.addAll(sellOrders);
        } else {
          _sellOrders = sellOrders;
        }
        _hasMoreSellOrders = sellOrders.length == _orderbookPageSize;
        _currentSellOrdersPage = page;
        
        // Calculate total pages for pagination
        if (!_hasMoreSellOrders) {
          _totalSellOrdersPages = page;
        } else {
          // If we have more orders, estimate total pages (will be updated as user navigates)
          _totalSellOrdersPages = page + 1;
        }
        
        if (!append) _isLoadingSellOrders = false;
        if (append) _isLoadingMoreSellOrders = false;
      });
      
    } catch (e) {
      print('❌ Error fetching sell orders for $symbol: $e');
      setState(() {
        if (!append) {
          _sellOrders = [];
          _hasMoreSellOrders = false; // No more data to load due to error
          _totalSellOrdersPages = 1; // Reset total pages
          _isLoadingSellOrders = false;
        } else {
          _isLoadingMoreSellOrders = false;
        }
      });
    }
  }
  
  Future<void> _fetchBuyOrders(String symbol, {int page = 1, bool append = false}) async {
    print('📊 Fetching buy orders for symbol: $symbol, page: $page');
    
    // Find the asset data for this symbol
    final asset = _assets.firstWhere(
      (asset) => asset['symbol'] == symbol,
      orElse: () {
        print('[Orderbook] Asset not found for symbol: $symbol');
        setState(() {
          if (!append) _buyOrders = [];
          _isLoadingBuyOrders = false;
        });
        return <String, dynamic>{};
      },
    );

    if (asset.isEmpty) {
      print('❌ Asset not found for buy orders: $symbol');
      return;
    }

    final orderbook = asset['orderbook']?.toString() ?? '';
    final exchangePairId = asset['exchangePairId']?.toString() ?? '';
    final quoteTokenDecimal = int.tryParse(asset['quoteTokenDecimal']?.toString() ?? '0') ?? 0;

    print('[Orderbook-Buy] $symbol: orderbook="$orderbook", exchangePairId="$exchangePairId"');

    if (orderbook.isEmpty || exchangePairId.isEmpty) {
      print('❌ Missing required fields for buy orders $symbol - no orderbook data available');
      setState(() {
        if (!append) _buyOrders = [];
        _hasMoreBuyOrders = false; // No more data to load
        _totalBuyOrdersPages = 1; // Reset total pages
        _isLoadingBuyOrders = false;
      });
      return;
    }
    
    if (!append) {
      setState(() {
        _isLoadingBuyOrders = true;
      });
    } else {
      setState(() {
        _isLoadingMoreBuyOrders = true;
      });
    }
    
    try {
      final response = await http.post(
        Uri.parse('https://brokerage-api-stage.tokenise.io/api/services/app/Agora/OrderbookQueue'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          "page": page,
          "page_size": _orderbookPageSize,
          "chain_id": "131074",
          "orderbook": orderbook,
          "pair_id": exchangePairId,
          "queue_id": "asks"
        }),
      ).timeout(const Duration(seconds: 10));
      
      List<Map<String, dynamic>> buyOrders = [];
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> asksData = json.decode(response.body);
        print('[Orderbook-Buy] $symbol API response: ${response.body}');
        
        if (asksData['success'] == true && asksData['result'] != null) {
          final result = asksData['result'];
          print('[Orderbook-Buy] $symbol result structure: ${result.keys}');
          
          if (result is Map && result.containsKey('orders') && result['orders'] is List) {
            final List<dynamic> orders = result['orders'];
            print('[Orderbook-Buy] $symbol found ${orders.length} orders');
            buyOrders = orders.map<Map<String, dynamic>>((order) {
              final priceRaw = order['price'];
              final quantityRaw = order['quantity'];
              
              final price = priceRaw != null ? double.tryParse(priceRaw.toString()) ?? 0.0 : 0.0;
              final quantity = quantityRaw != null ? double.tryParse(quantityRaw.toString()) ?? 0.0 : 0.0;
              
              // Normalize price using quoteTokenDecimal
              final normalizedPrice = price / pow(10, quoteTokenDecimal);
              
              return {
                'price': normalizedPrice,
                'quantity': quantity,
              };
            }).toList();
          } else {
            print('[Orderbook-Buy] $symbol: No orders field found or orders is not a list. Result: $result');
          }
        } else {
          print('[Orderbook-Buy] $symbol: API response not successful or result is null. Response: $asksData');
        }
      } else {
        print('❌ Buy orders API error: ${response.statusCode} - ${response.body}');
      }
      
      setState(() {
        if (append) {
          _buyOrders.addAll(buyOrders);
        } else {
          _buyOrders = buyOrders;
        }
        _hasMoreBuyOrders = buyOrders.length == _orderbookPageSize;
        _currentBuyOrdersPage = page;
        
        // Calculate total pages for pagination
        if (!_hasMoreBuyOrders) {
          _totalBuyOrdersPages = page;
        } else {
          // If we have more orders, estimate total pages (will be updated as user navigates)
          _totalBuyOrdersPages = page + 1;
        }
        
        if (!append) _isLoadingBuyOrders = false;
        if (append) _isLoadingMoreBuyOrders = false;
      });
      
    } catch (e) {
      print('❌ Error fetching buy orders for $symbol: $e');
      setState(() {
        if (!append) {
          _buyOrders = [];
          _hasMoreBuyOrders = false; // No more data to load due to error
          _totalBuyOrdersPages = 1; // Reset total pages
          _isLoadingBuyOrders = false;
        } else {
          _isLoadingMoreBuyOrders = false;
        }
      });
    }
  }
  
  void _goToSellOrdersPage(int page) {
    if (page >= 1 && page <= _totalSellOrdersPages && page != _currentSellOrdersPage && _selectedSymbol.isNotEmpty) {
      _fetchSellOrders(_selectedSymbol, page: page, append: false);
    }
  }
  
  void _goToBuyOrdersPage(int page) {
    if (page >= 1 && page <= _totalBuyOrdersPages && page != _currentBuyOrdersPage && _selectedSymbol.isNotEmpty) {
      _fetchBuyOrders(_selectedSymbol, page: page, append: false);
    }
  }
  
  Widget _buildPaginationControls(int currentPage, int totalPages, Function(int) onPageTap) {
    if (totalPages <= 1) return SizedBox.shrink();
    
    final themeService = Provider.of<ThemeService>(context, listen: false);
    final isDarkTheme = themeService.isDarkTheme;
    
    List<Widget> pageButtons = [];
    
    // Previous button
    pageButtons.add(
      InkWell(
        onTap: currentPage > 1 ? () => onPageTap(currentPage - 1) : null,
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: currentPage > 1 ? (isDarkTheme ? Colors.grey[700] : Colors.grey[300]) : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(
            Icons.chevron_left,
            size: 16,
            color: currentPage > 1 ? (isDarkTheme ? Colors.white : Colors.black) : Colors.grey,
          ),
        ),
      ),
    );
    
    // Page numbers
    for (int i = 1; i <= totalPages; i++) {
      if (i == 1 || i == totalPages || (i >= currentPage - 1 && i <= currentPage + 1)) {
        pageButtons.add(
          InkWell(
            onTap: () => onPageTap(i),
            child: Container(
              width: 24,
              height: 24,
              margin: EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: i == currentPage 
                  ? Colors.blue 
                  : (isDarkTheme ? Colors.grey[700] : Colors.grey[300]),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  i.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: i == currentPage 
                      ? Colors.white 
                      : (isDarkTheme ? Colors.white : Colors.black),
                  ),
                ),
              ),
            ),
          ),
        );
      } else if (i == currentPage - 2 || i == currentPage + 2) {
        pageButtons.add(
          Container(
            width: 24,
            height: 24,
            margin: EdgeInsets.symmetric(horizontal: 2),
            child: Center(
              child: Text(
                '...',
                style: TextStyle(
                  fontSize: 12,
                  color: isDarkTheme ? Colors.white70 : Colors.black54,
                ),
              ),
            ),
          ),
        );
      }
    }
    
    // Next button
    pageButtons.add(
      InkWell(
        onTap: currentPage < totalPages ? () => onPageTap(currentPage + 1) : null,
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: currentPage < totalPages ? (isDarkTheme ? Colors.grey[700] : Colors.grey[300]) : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(
            Icons.chevron_right,
            size: 16,
            color: currentPage < totalPages ? (isDarkTheme ? Colors.white : Colors.black) : Colors.grey,
          ),
        ),
      ),
    );
    
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: pageButtons,
      ),
    );
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
  
  String _formatPrice(double price) {
    // Format price to remove unnecessary trailing zeros
    // If price is a whole number, show without decimal places
    // Otherwise, show up to 4 decimal places but remove trailing zeros
    if (price % 1 == 0) {
      return price.toInt().toString();
    } else {
      String formatted = price.toStringAsFixed(4);
      // Remove trailing zeros
      formatted = formatted.replaceAll(RegExp(r'0*$'), '');
      // Remove trailing decimal point if all decimal places were zeros
      formatted = formatted.replaceAll(RegExp(r'\.$'), '');
      return formatted;
    }
  }
  
  @override
  void dispose() {
    _messageSubscription?.cancel();
    _connectionStatusSubscription?.cancel();
    _logonStatusSubscription?.cancel();
    _securityRequestTimeout?.cancel();
    _quantityController.dispose();
    _priceController.dispose();
    _orderIdController.dispose();
    _reasonController.dispose();
    _replaceOrderIdController.dispose();
    _newOrderIdController.dispose();
    _newQuantityController.dispose();
    _newPriceController.dispose();
    _replaceReasonController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  
  void _scrollLeft() async {
    if (_assets.isNotEmpty) {
      final currentIndex = _assets.indexWhere((asset) => asset['symbol'] == _selectedSymbol);
      final newIndex = currentIndex > 0 ? currentIndex - 1 : _assets.length - 1;

      setState(() {
        _selectedSymbol = _assets[newIndex]['symbol'];
      });

  // Fetch chart data for newly selected symbol
  _fetchChartData(_assets[newIndex]['symbol']);
  // Fetch trade history for newly selected symbol
  _resetAndFetchTradeHistory(_assets[newIndex]['symbol']);
  // Fetch orderbook data for newly selected symbol
  _fetchOrderbookData(_assets[newIndex]['symbol']);
  // Update portfolio for sell orders if currently in sell mode
  // Asset has changed, so asset_ids parameter changes
  if (!_isBuySelected) {
    await _fetchAccountMarketPortfolioForMarket(_selectedMarket['id'] ?? '');
  }
      
      // Scroll to center the selected asset (162px width + 16px margin = 178px per card)
      _scrollToIndex(newIndex);
    }
  }
  
  void _scrollRight() async {
    if (_assets.isNotEmpty) {
      final currentIndex = _assets.indexWhere((asset) => asset['symbol'] == _selectedSymbol);
      final newIndex = currentIndex < _assets.length - 1 ? currentIndex + 1 : 0;

      setState(() {
        _selectedSymbol = _assets[newIndex]['symbol'];
      });

  // Fetch chart data for newly selected symbol
  _fetchChartData(_assets[newIndex]['symbol']);
  // Fetch trade history for newly selected symbol
  _resetAndFetchTradeHistory(_assets[newIndex]['symbol']);
  // Fetch orderbook data for newly selected symbol
  _fetchOrderbookData(_assets[newIndex]['symbol']);
  // Update portfolio for sell orders if currently in sell mode
  // Asset has changed, so asset_ids parameter changes
  if (!_isBuySelected) {
    await _fetchAccountMarketPortfolioForMarket(_selectedMarket['id'] ?? '');
  }
      
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
                  
                  return Column(
                    children: [
                      // Top Row - Trade, Chart, Trade History
                      Expanded(
                        flex: (_topSectionRatio * 100).round(), // Dynamic height based on ratio
                        child: Row(
                          children: [
                            // Left Panel - Trading Controls
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

                            // Middle Panel - Asset Selection and Chart
                            Expanded(
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  final maxMiddleHeight = constraints.maxHeight;
                                  final minMarketOverviewHeight = 150.0;
                                  final maxMarketOverviewHeight = maxMiddleHeight - 100; // Leave space for chart

                                  // Constrain market height
                                  _marketOverviewHeight = _marketOverviewHeight.clamp(minMarketOverviewHeight, maxMarketOverviewHeight);

                                  return Column(
                                    children: [
                                      // Asset Selection at the top of middle panel
                                      Container(
                                        height: _marketOverviewHeight,
                                        child: _buildAssetSection(themeService),
                                      ),

                                      // Horizontal Splitter between Market and Chart
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

                                      // Chart Section - takes remaining space
                                      Expanded(
                                        child: _buildChartSection(themeService),
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

                            // Right Panel - Trade History
                            Container(
                              width: _rightPanelWidth,
                              child: _buildActivitySection(themeService),
                            ),
                          ],
                        ),
                      ),

                      // Horizontal Splitter between top and bottom sections
                      _buildHorizontalSplitter(
                        onDrag: (delta) {
                          setState(() {
                            // Use a simpler approach - adjust ratio based on delta
                            final sensitivity = 0.002; // Adjust sensitivity as needed
                            final deltaRatio = delta * sensitivity;
                            final newRatio = (_topSectionRatio + deltaRatio).clamp(0.3, 0.8);
                            print('🔧 Horizontal drag: delta=$delta, deltaRatio=$deltaRatio, newRatio=$newRatio');
                            _topSectionRatio = newRatio;
                          });
                        },
                        onDragStart: () => setState(() => _isDraggingTopBottomSplit = true),
                        onDragEnd: () => setState(() => _isDraggingTopBottomSplit = false),
                        isDragging: _isDraggingTopBottomSplit,
                        themeService: themeService,
                      ),

                      // Bottom Row - Orders Section Only
                      Expanded(
                        flex: ((1.0 - _topSectionRatio) * 100).round(), // Dynamic height based on ratio
                        child: _buildOrdersSection(themeService),
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
    return MouseRegion(
      cursor: SystemMouseCursors.resizeColumn,
      child: GestureDetector(
        onPanStart: (_) => onDragStart(),
        onPanUpdate: (details) => onDrag(details.delta.dx),
        onPanEnd: (_) => onDragEnd(),
        child: Container(
          width: 8, // Increased hit area for better dragging
          color: Colors.transparent, // Transparent background for larger hit area
          child: Center(
            child: Container(
              width: 4, // Visual splitter width
              decoration: BoxDecoration(
                color: isDragging
                    ? Colors.blue.withOpacity(0.3)
                    : (_isDarkTheme ? Colors.grey[700] : Colors.grey[300]),
                border: isDragging
                    ? Border.all(color: Colors.blue, width: 1)
                    : null,
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
    return MouseRegion(
      cursor: SystemMouseCursors.resizeRow,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque, // Ensure gesture detection works properly
        onPanStart: (_) => onDragStart(),
        onPanUpdate: (details) => onDrag(details.delta.dy),
        onPanEnd: (_) => onDragEnd(),
        child: Container(
          height: 8, // Increased hit area for better dragging
          width: double.infinity,
          color: Colors.transparent, // Transparent background for larger hit area
          child: Center(
            child: Container(
              height: 4, // Visual splitter height
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDragging
                    ? Colors.blue.withOpacity(0.3)
                    : (_isDarkTheme ? Colors.grey[700] : Colors.grey[300]),
                border: isDragging
                    ? Border.all(color: Colors.blue, width: 1)
                    : null,
              ),
            ),
          ),
        ),
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
          
          const SizedBox(width: 16),
          
          // Navigation Tabs - Left side beside logo
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
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
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              // Trading Button (current page)
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  height: 55,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isDarkTheme ? Colors.black : Colors.white,
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
                    'Trading',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isDarkTheme ? Colors.white : Colors.black,
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
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Balance Button
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => const BalancePage(),
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
                          'Balance',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
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
                PopupMenuItem<String>(
                  value: 'profile',
                  child: Row(
                    children: [
                      Icon(Icons.person, size: 18, color: Colors.white),
                      SizedBox(width: 8),
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
                  PopupMenuItem<String>(
                    value: 'users',
                    child: Row(
                      children: [
                        Icon(Icons.people, size: 18, color: Colors.white),
                        SizedBox(width: 8),
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
                print('🔓 Trading page logout initiated...');
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
                      backgroundColor: const Color(0xFFFF4081),
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
        color: _isDarkTheme ? Colors.black : Colors.white,
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

          // Trade Orders Tabs Section
          Expanded(
            child: _buildTradeOrdersTabs(_isDarkTheme),
          ),

        ],
      ),
    );
  }

  // Helper method to get selected asset symbol
  String _getSelectedAssetSymbol() {
    if (_assets.isEmpty || _selectedSymbol.isEmpty) {
      return ''; // Default fallback
    }
    
    // Extract the base symbol from the trading pair
    // For example: "ETH/USD" -> "ETH", "BTC/USD" -> "BTC"
    final parts = _selectedSymbol.split('/');
    return parts.isNotEmpty ? parts[0] : '';
  }

  // Helper method to format decimal numbers cleanly
  String _formatDecimal(String value) {
    try {
      final double number = double.parse(value);

      // If it's a whole number, show without decimals
      if (number == number.toInt()) {
        return number.toInt().toString();
      }

      // Remove trailing zeros after decimal point
      String formatted = number.toString();
      if (formatted.contains('.')) {
        formatted = formatted.replaceAll(RegExp(r'0*$'), '');
        formatted = formatted.replaceAll(RegExp(r'\.$'), '');
      }

      return formatted;
    } catch (e) {
      // If parsing fails, return original value
      return value;
    }
  }

  // Helper method to calculate order total
  double _calculateTotal() {
    final quantity = double.tryParse(_quantityController.text) ?? 0.0;
    final price = _orderType == 'Market' ? 0.0 : (double.tryParse(_priceController.text) ?? 0.0);

    // Parse estimated fee (remove currency symbols and parse)
    double estimatedFee = 0.0;
    try {
      String feeStr = _estimatedFee.replaceAll(RegExp(r'[^\d.]'), ''); // Remove non-numeric characters
      estimatedFee = double.tryParse(feeStr) ?? 0.0;
    } catch (e) {
      estimatedFee = 0.0;
    }

    if (_orderType == 'Market') {
      // For market orders, we don't show total (return 0)
      return 0.0;
    }

    final subtotal = quantity * price;

    if (_isBuySelected) {
      // Buy limit order: (amount * price) + EST.fee
      return subtotal + estimatedFee;
    } else {
      // Sell limit order: (amount * price) - EST.fee
      return subtotal - estimatedFee;
    }
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
            'Market',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 10), // Space between title and dropdown
          
          // Market Dropdown
          _HoverDropdownField(
            isDarkTheme: _isDarkTheme,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Map<String, String>>(
                value: _markets.isEmpty 
                    ? null 
                    : (_markets.any((market) => market['id'] == _selectedMarket['id']) 
                        ? _selectedMarket 
                        : _markets.isNotEmpty ? _markets.first : null),
                isExpanded: true,
                onChanged: _markets.isEmpty ? null : (Map<String, String>? newValue) async {
                  if (newValue != null) {
                    setState(() {
                      _selectedMarket = newValue;
                    });
                    // Load instruments for the selected market first
                    await _fetchMarketInstruments(newValue['id']!);
                    // Update portfolio for sell orders if currently in sell mode
                    // Use the newValue market ID to ensure we're using the correct market
                    if (!_isBuySelected) {
                      await _fetchAccountMarketPortfolioForMarket(newValue['id']!);
                    }
                  }
                },
                dropdownColor: _isDarkTheme ? const Color(0xFF1e1e1e) : Colors.white,
                style: TextStyle(
                  color: _isDarkTheme ? Colors.white : Colors.black,
                  fontSize: 14,
                ),
                items: _markets.isEmpty 
                    ? [DropdownMenuItem<Map<String, String>>(
                        value: {'id': '', 'description': '', 'display': ''},
                        child: Text(_isLoadingMarkets ? 'Loading markets...' : 'No markets available'),
                      )]
                    : _markets.map<DropdownMenuItem<Map<String, String>>>((market) {
                        return DropdownMenuItem<Map<String, String>>(
                          value: market,
                          child: Text(market['display'] ?? market['id']!),
                        );
                      }).toList(),
              ),
            ),
          ),
          
          const SizedBox(height: 10), // Space between dropdown and asset boxes
          Expanded(
            child: _isLoadingMarketInstruments 
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _isDarkTheme ? Colors.white : const Color(0xFF1a1754),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Loading...',
                          style: TextStyle(
                            fontSize: 14,
                            color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : _assets.isEmpty 
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 48,
                              color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                            ),
                            SizedBox(height: 12),
                            Text(
                              'No asset found',
                              style: TextStyle(
                                fontSize: 14,
                                color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      )
                : SizedBox(
                    height: 70, // Reduced from 200 to 100 for half-size boxes
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
                              width: 120,
                              margin: const EdgeInsets.only(right: 12),
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      _selectedSymbol = asset['symbol'];
                                    });
                                    _fetchChartData(asset['symbol']);
                                    _resetAndFetchTradeHistory(asset['symbol']);
                                    _fetchOrderbookData(asset['symbol']);
                                    _calculateOrderFees();
                                    // Update portfolio for sell orders if currently in sell mode
                                    // Asset has changed, so asset_ids parameter changes
                                    if (!_isBuySelected) {
                                      await _fetchAccountMarketPortfolioForMarket(_selectedMarket['id'] ?? '');
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      border: isSelected 
                                          ? Border.all(color: const Color(0xFF00b8fb), width: 2)
                                          : Border.all(
                                              color: _isDarkTheme ? Colors.grey[700]! : Colors.grey[300]!,
                                              width: 1,
                                            ),
                                      borderRadius: BorderRadius.circular(8),
                                      color: isSelected 
                                          ? (_isDarkTheme ? const Color(0xFF00b8fb).withOpacity(0.1) : const Color(0xFF00b8fb).withOpacity(0.05))
                                          : (_isDarkTheme ? Colors.black : Colors.white),
                                    ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Value (symbol)
                                      Text(
                                        asset['symbol'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected
                                              ? (_isDarkTheme ? Colors.white : Colors.black)
                                              : Colors.grey,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      // Description
                                      Text(
                                        asset['description'] ?? '',
                                        style: TextStyle(
                                          fontSize: 7,
                                          color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
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
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
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
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
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
        color: _isDarkTheme ? Colors.black : Colors.white,
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
                color: _isDarkTheme ? const Color(0xFF3d3d3d) : Colors.grey[50],
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
      final close = _safeToDouble(point['close']);
      if (low < minPrice) minPrice = low;
      if (close > maxPrice) maxPrice = close;
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
    final labelCount = 5;
    final labels = <double>[];
    for (int i = 0; i < labelCount; i++) {
      // Linear interpolation between min and max, so top is max, bottom is min, never exceeding max
      double value = minPrice + (maxPrice - minPrice) * (labelCount - 1 - i) / (labelCount - 1);
      labels.add(value);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: labels.map((price) {
        Color priceColor;
        if (price.toStringAsFixed(2) == maxPrice.toStringAsFixed(2)) {
          priceColor = const Color(0xFF00D4AA);
        } else if (price.toStringAsFixed(2) == minPrice.toStringAsFixed(2)) {
          priceColor = const Color(0xFFFF4081);
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
              fontWeight: (priceColor == const Color(0xFF00D4AA) || priceColor == const Color(0xFFFF4081)) ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActivitySection(ThemeService themeService) {
    final _isDarkTheme = themeService.isDarkTheme;
    return Container(
      color: _isDarkTheme ? Colors.black : Colors.white, // Section background matches table background
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align column content to the left
        children: [
          // Connected tab headers
          _buildActivityTabHeaders(_isDarkTheme),
          // Connected content area with padding
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8), // Space between table and section edge
              decoration: BoxDecoration(
                color: _isDarkTheme ? Colors.grey[800] : Colors.grey[200], // Table background: dark gray / light gray
                border: Border.all(
                  color: _isDarkTheme ? Colors.grey[800]! : Colors.grey[200]!, // Same as selected tab background
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: _buildActivityTabContent(_isDarkTheme),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTabHeaders(bool isDarkTheme) {
    return Container(
      margin: const EdgeInsets.only(left: 8), // Add left margin to match table
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start, // Align tabs to the left
          children: _activityTabNames.asMap().entries.map((entry) {
          final index = entry.key;
          final tabName = entry.value;
          final isActive = _activityTabIndex == index;

          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _activityTabIndex = index;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: isActive ? 7 : 5,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? (isDarkTheme ? Colors.grey[800] : Colors.grey[200]) // Selected tab same color as table
                      : (isDarkTheme
                          ? Colors.black.withOpacity(0.3)
                          : Colors.white.withOpacity(0.2)), // Unselected tab follows theme
                  border: isActive
                      ? null // No border for selected tab
                      : Border.all(
                          color: isDarkTheme ? Colors.grey[800]! : Colors.grey[200]!, // Same as selected background
                        ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Text(
                  tabName,
                  style: TextStyle(
                    color: isActive
                        ? (isDarkTheme ? Colors.white : Colors.black)
                        : Colors.grey[400],
                    fontSize: 14,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
        ),
      ),
    );
  }

  Widget _buildActivityTabContent(bool isDarkTheme) {
    switch (_activityTabIndex) {
      case 0: // Orderbook (default)
        return _buildOrderbookTable(isDarkTheme);
      case 1: // Trade History
        return _buildTradeHistoryTable(isDarkTheme);
      default:
        return _buildOrderbookTable(isDarkTheme); // Default to Orderbook
    }
  }

  Widget _buildTradeHistoryTable(bool isDarkTheme) {
    if (_tradeHistory.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 60,
                  child: Text('Price', style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.left),
                ),
                SizedBox(
                  width: 70,
                  child: Text('Quantity', style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center),
                ),
                Expanded(
                  child: Text('Time', style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.right),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Divider(color: Colors.grey, thickness: 0.7, height: 1),
            // No rows if empty
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkTheme ? Colors.grey[800] : Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 50,
                      child: Text(
                        'Price',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: Text(
                        'Quantity',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Time',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Divider(
                  color: Colors.grey,
                  thickness: 0.7,
                  height: 1,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tradeHistory.length + (_hasMoreTradeHistory ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _tradeHistory.length) {
                  // Load more button
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: _isLoadingTradeHistory
                        ? const Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : TextButton(
                            onPressed: _loadMoreTradeHistory,
                            child: Text(
                              'Load More',
                              style: TextStyle(
                                color: isDarkTheme ? Colors.blue[300] : Colors.blue,
                                fontSize: 14,
                              ),
                            ),
                          ),
                  );
                }

                final trade = _tradeHistory[index];
                Color priceColor = trade['priceColor'] ?? (isDarkTheme ? Colors.white : Colors.black);
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 50,
                        child: Text(
                          trade['price'].toString(),
                          style: TextStyle(
                            color: priceColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        child: Text(
                          trade['quantity'].toString(),
                          style: TextStyle(
                            color: isDarkTheme ? Colors.white : Colors.black,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          trade['time'].toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.right,
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

  Widget _buildOrderbookTable(bool isDarkTheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          // Orderbook headers
          Row(
            children: [
              Expanded(
                child: Text(
                  'Price',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: Text(
                  'Quantity',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Total',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Divider(color: Colors.grey, thickness: 0.7, height: 1),
          const SizedBox(height: 8),
          Expanded(
            child: Column(
              children: [
                // Sell orders (top half)
                Expanded(
                  child: _buildOrderbookSide(isDarkTheme, 'sell'),
                ),
                // Spread section
                Container(
                  height: 30,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: isDarkTheme ? Colors.grey[800] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      'Spread: 0.05',
                      style: TextStyle(
                        color: isDarkTheme ? Colors.white : Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                // Buy orders (bottom half)
                Expanded(
                  child: _buildOrderbookSide(isDarkTheme, 'buy'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderbookSide(bool isDarkTheme, String side) {
    // Sample orderbook data - replace with real data
    final sampleOrders = List.generate(10, (index) {
      final price = side == 'sell' ? 100.0 + index : 100.0 - index;
      final quantity = (index + 1) * 10.0;
      return {
        'price': price.toStringAsFixed(2),
        'quantity': quantity.toStringAsFixed(0),
        'total': (price * quantity).toStringAsFixed(2),
      };
    });

    return ListView.builder(
      itemCount: sampleOrders.length,
      itemBuilder: (context, index) {
        final order = sampleOrders[index];
        final color = side == 'sell' ? const Color(0xFFFF4081) : const Color(0xFF00D4AA);

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  order['price']!,
                  style: TextStyle(
                    color: color,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: Text(
                  order['quantity']!,
                  style: TextStyle(
                    color: isDarkTheme ? Colors.white : Colors.black,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  order['total']!,
                  style: TextStyle(
                    color: isDarkTheme ? Colors.grey[300] : Colors.grey[600],
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOrdersSection(ThemeService themeService) {
    final _isDarkTheme = themeService.isDarkTheme;
    return Container(
      color: _isDarkTheme ? Colors.black : Colors.white, // Section background follows theme
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align column content to the left
        children: [
          // Connected tab headers
          _buildOrdersTabHeaders(_isDarkTheme),
          // Connected content area with padding
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              decoration: BoxDecoration(
                color: _isDarkTheme ? Colors.grey[800] : Colors.grey[200], // Table background: dark gray / light gray
                border: Border.all(
                  color: _isDarkTheme ? Colors.grey[800]! : Colors.grey[200]!, // Same as selected tab background
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: _buildOrdersTabContent(_isDarkTheme),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersTabHeaders(bool isDarkTheme) {
    return Container(
      margin: const EdgeInsets.only(left: 8), // Add left margin to match table
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start, // Align tabs to the left
          children: _ordersTabNames.asMap().entries.map((entry) {
          final index = entry.key;
          final tabName = entry.value;
          final isActive = _ordersTabIndex == index;

          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _ordersTabIndex = index;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: isActive ? 7 : 5,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? (isDarkTheme ? Colors.grey[800] : Colors.grey[200]) // Selected tab same color as table
                      : (isDarkTheme
                          ? Colors.black.withOpacity(0.3)
                          : Colors.white.withOpacity(0.2)), // Unselected tab follows theme
                  border: isActive
                      ? null // No border for selected tab
                      : Border.all(
                          color: isDarkTheme ? Colors.grey[800]! : Colors.grey[200]!, // Same as selected background
                        ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Text(
                  tabName,
                  style: TextStyle(
                    color: isActive
                        ? (isDarkTheme ? Colors.white : Colors.black)
                        : Colors.grey[400],
                    fontSize: 14,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
        ),
      ),
    );
  }

  Widget _buildOrdersTabContent(bool isDarkTheme) {
    switch (_ordersTabIndex) {
      case 0: // Orders (default)
        return _buildOrdersTable(isDarkTheme);
      case 1: // History
        return _buildOrderHistoryTable(isDarkTheme);
      default:
        return _buildOrdersTable(isDarkTheme); // Default to Orders
    }
  }

  Widget _buildOrderRow(Map<String, dynamic> order, bool isDarkTheme) {
    // Helper function to format timestamps
    String formatTimestamp(String? timestamp) {
      if (timestamp == null) return 'N/A';
      try {
        final dt = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);
        return '${dt.day}/${dt.month}/${dt.year.toString().substring(2)} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
      } catch (e) {
        return 'N/A';
      }
    }

    // Helper function to format side
    String formatSide(String side) {
      return side.replaceAll('ORDER_SIDE__', '');
    }

    // Helper function to get status
    String getStatus(Map<String, dynamic> order) {
      if (order['is_filled'] == true) return 'Filled';
      if (order['is_cancelled'] == true) return 'Cancelled';
      if (order['is_expired'] == true) return 'Expired';
      return 'Active';
    }

    // Helper function to get status color
    Color getStatusColor(String status) {
      switch (status) {
        case 'Filled': return const Color(0xFF00D4AA);
        case 'Cancelled': return const Color(0xFFFF4081);
        case 'Expired': return Colors.orange;
        case 'Active': return Colors.blue;
        default: return isDarkTheme ? Colors.white : Colors.black;
      }
    }

    final side = formatSide(order['side'] ?? '');
    final status = getStatus(order);
    final statusColor = getStatusColor(status);
    final sideColor = side == 'BUY' ? const Color(0xFF00D4AA) : const Color(0xFFFF4081);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 110,
            child: Text(side, style: TextStyle(color: sideColor, fontSize: 12, fontWeight: FontWeight.bold), textAlign: TextAlign.left),
          ),
          SizedBox(
            width: 140,
            child: Text(order['symbol'] ?? 'N/A', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black, fontSize: 12), textAlign: TextAlign.center),
          ),
          SizedBox(
            width: 140,
            child: Text(order['quantity'] ?? 'N/A', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black, fontSize: 12), textAlign: TextAlign.center),
          ),
          SizedBox(
            width: 140,
            child: Text(order['price'] == '0.00' ? 'Market' : '${order['price'] ?? 'N/A'}', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black, fontSize: 12), textAlign: TextAlign.center),
          ),
          SizedBox(
            width: 140,
            child: Text(formatTimestamp(order['create_timestamp']), style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black, fontSize: 11), textAlign: TextAlign.center),
          ),
          SizedBox(
            width: 140,
            child: Text(formatTimestamp(order['expire_timestamp']), style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black, fontSize: 11), textAlign: TextAlign.center),
          ),
          SizedBox(
            width: 140,
            child: Text(status, style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
          ),
          Expanded(child: status == 'Active' ?
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: _HoverButton(
                    text: 'Cancel',
                    color: const Color(0xFFFF4081),
                    onTap: () {
                      // TODO: Implement cancel order functionality
                      print('Cancel order: ${order['order_id']}');
                    },
                  ),
                ),
                const SizedBox(width: 2),
                Expanded(
                  child: _HoverButton(
                    text: 'Replace',
                    color: Colors.blue,
                    onTap: () {
                      // TODO: Implement replace order functionality
                      print('Replace order: ${order['order_id']}');
                    },
                  ),
                ),
              ],
            ) :
            Text('-', style: TextStyle(color: isDarkTheme ? Colors.grey : Colors.grey[600], fontSize: 12))
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersTable(bool isDarkTheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 2),
          // Orders table header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 110,
                child: Text('Side', style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.left),
              ),
              SizedBox(
                width: 140,
                child: Text('Pair', style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center),
              ),
              SizedBox(
                width: 140,
                child: Text('Quantity', style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center),
              ),
              SizedBox(
                width: 140,
                child: Text('Price', style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center),
              ),
              SizedBox(
                width: 140,
                child: Text('Creation Time', style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center),
              ),
              SizedBox(
                width: 140,
                child: Text('Expiration Time', style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center),
              ),
              SizedBox(
                width: 140,
                child: Text('Status', style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center),
              ),
              Expanded(
                child: Text('Action', style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Divider(
            color: Colors.grey,
            thickness: 0.7,
            height: 1,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _buildOrdersContent(isDarkTheme),
          ),
        ],
      ),
    );
  }

  /// Build orders content with loading states and real data
  Widget _buildOrdersContent(bool isDarkTheme) {
    if (_isLoadingRealOrders) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading orders...'),
          ],
        ),
      );
    }

    if (_realOrdersError != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: const Color(0xFFFF4081),
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load orders',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDarkTheme ? Colors.grey[300] : Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _realOrdersError!,
              style: TextStyle(
                fontSize: 12,
                color: const Color(0xFFFF4081),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchRealOrders,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    // Show only real orders (no sample data fallback)
    return ListView(
      children: [
        // Orders from real data only
        ..._realOrders.map((order) => _buildOrderRow(order, isDarkTheme)),
        // Empty state message if no orders
        if (_realOrders.isEmpty)
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.list_alt,
                    size: 48,
                    color: isDarkTheme ? Colors.grey[600] : Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No orders found',
                    style: TextStyle(
                      color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your active orders will appear here',
                    style: TextStyle(
                      color: isDarkTheme ? Colors.grey[500] : Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        // Add a refresh button at the bottom (always show)
        Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ElevatedButton.icon(
              onPressed: _fetchRealOrders,
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('Refresh Orders'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderHistoryTable(bool isDarkTheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 2),
          // History table header (without Action column)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 110,
                child: Text('Side', style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.left),
              ),
              SizedBox(
                width: 150,
                child: Text('Pair', style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center),
              ),
              SizedBox(
                width: 150,
                child: Text('Quantity', style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center),
              ),
              SizedBox(
                width: 150,
                child: Text('Price', style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center),
              ),
              SizedBox(
                width: 150,
                child: Text('Creation Time', style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center),
              ),
              SizedBox(
                width: 150,
                child: Text('Expiration Time', style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center),
              ),
              Expanded(
                child: Text('Status', style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Divider(
            color: Colors.grey,
            thickness: 0.7,
            height: 1,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              children: [
                // History from GetAccountOrders (filled, expired, cancelled)
                ..._orderHistory.map((order) => _buildOrderHistoryRow(order, isDarkTheme)),
                // Empty state message if no history
                if (_orderHistory.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        'No order history found',
                        style: TextStyle(
                          color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderHistoryRow(Map<String, dynamic> order, bool isDarkTheme) {
    // Helper function to format timestamps
    String formatTimestamp(String? timestamp) {
      if (timestamp == null) return 'N/A';
      try {
        final dt = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);
        return '${dt.day}/${dt.month}/${dt.year.toString().substring(2)} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
      } catch (e) {
        return 'N/A';
      }
    }

    // Helper function to format side
    String formatSide(String side) {
      return side.replaceAll('ORDER_SIDE__', '');
    }

    // Helper function to get status
    String getStatus(Map<String, dynamic> order) {
      if (order['is_filled'] == true) return 'Filled';
      if (order['is_cancelled'] == true) return 'Cancelled';
      if (order['is_expired'] == true) return 'Expired';
      return 'Active';
    }

    // Helper function to get status color
    Color getStatusColor(String status) {
      switch (status) {
        case 'Filled': return const Color(0xFF00D4AA);
        case 'Cancelled': return const Color(0xFFFF4081);
        case 'Expired': return Colors.orange;
        case 'Active': return Colors.blue;
        default: return isDarkTheme ? Colors.white : Colors.black;
      }
    }

    final side = formatSide(order['side'] ?? '');
    final status = getStatus(order);
    final statusColor = getStatusColor(status);
    final sideColor = side == 'BUY' ? const Color(0xFF00D4AA) : const Color(0xFFFF4081);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 110,
            child: Text(side, style: TextStyle(color: sideColor, fontSize: 12, fontWeight: FontWeight.bold), textAlign: TextAlign.left),
          ),
          SizedBox(
            width: 150,
            child: Text(order['symbol'] ?? 'N/A', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black, fontSize: 12), textAlign: TextAlign.center),
          ),
          SizedBox(
            width: 150,
            child: Text(order['quantity'] ?? 'N/A', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black, fontSize: 12), textAlign: TextAlign.center),
          ),
          SizedBox(
            width: 150,
            child: Text(order['price'] == '0.00' ? 'Market' : '${order['price'] ?? 'N/A'}', style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black, fontSize: 12), textAlign: TextAlign.center),
          ),
          SizedBox(
            width: 150,
            child: Text(formatTimestamp(order['create_timestamp']), style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black, fontSize: 11), textAlign: TextAlign.center),
          ),
          SizedBox(
            width: 150,
            child: Text(formatTimestamp(order['expire_timestamp']), style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black, fontSize: 11), textAlign: TextAlign.center),
          ),
          Expanded(
            child: Text(status, style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
          ),
          // Note: No Action column for history
        ],
      ),
    );
  }

  Widget _buildOrderbookSection(ThemeService themeService) {
    final _isDarkTheme = themeService.isDarkTheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _isDarkTheme ? Colors.black : Colors.white,
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
                      const SizedBox(height: 8),
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
                      const SizedBox(height: 8),
                      Expanded(
                        child: _isLoadingSellOrders
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : _sellOrders.isEmpty
                                ? Center(
                                    child: Text(
                                      'No sell orders',
                                      style: TextStyle(
                                        color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                : Column(
                                    children: [
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
                                                      _formatPrice(order['price']),
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Color(0xFFFF4081),
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      order['quantity'].toString(),
                                                      textAlign: TextAlign.right,
                                                      style: TextStyle(
                                                        fontSize: 14,
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
                                      // Load More button for Sell Orders
                                      if (_hasMoreSellOrders)
                                        Container(
                                          margin: const EdgeInsets.symmetric(vertical: 8),
                                          child: _isLoadingMoreSellOrders
                                              ? const Center(
                                                  child: SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child: CircularProgressIndicator(strokeWidth: 2),
                                                  ),
                                                )
                                              : TextButton(
                                                  onPressed: () {
                                                    _fetchSellOrders(_selectedSymbol, page: _currentSellOrdersPage + 1, append: true);
                                                  },
                                                  child: Text(
                                                    'Load More',
                                                    style: TextStyle(
                                                      color: _isDarkTheme ? Colors.blue[300] : Colors.blue,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                    ],
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
                      const SizedBox(height: 8),
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
                      const SizedBox(height: 8),
                      Expanded(
                        child: _isLoadingBuyOrders
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : _buyOrders.isEmpty
                                ? Center(
                                    child: Text(
                                      'No buy orders',
                                      style: TextStyle(
                                        color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                : Column(
                                    children: [
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
                                                      _formatPrice(order['price']),
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Color(0xFF00D4AA),
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      order['quantity'].toString(),
                                                      textAlign: TextAlign.right,
                                                      style: TextStyle(
                                                        fontSize: 14,
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
                                      // Load More button for Buy Orders
                                      if (_hasMoreBuyOrders)
                                        Container(
                                          margin: const EdgeInsets.symmetric(vertical: 8),
                                          child: _isLoadingMoreBuyOrders
                                              ? const Center(
                                                  child: SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child: CircularProgressIndicator(strokeWidth: 2),
                                                  ),
                                                )
                                              : TextButton(
                                                  onPressed: () {
                                                    _fetchBuyOrders(_selectedSymbol, page: _currentBuyOrdersPage + 1, append: true);
                                                  },
                                                  child: Text(
                                                    'Load More',
                                                    style: TextStyle(
                                                      color: _isDarkTheme ? Colors.blue[300] : Colors.blue,
                                                      fontSize: 14,
                                                    ),
                                                  ),
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
          ),
        ],
      ),
    );
  }

  void _placeOrder() async {
    try {
      print('🎯 _placeOrder() called');

      // Check if the widget is still mounted
      if (!mounted) {
        print('❌ Widget is not mounted, aborting order placement');
        return;
      }

      // Check if controllers are initialized
      if (_quantityController == null || _priceController == null) {
        print('❌ Controllers not initialized');
        return;
      }

      // Log current state for debugging
      print('📊 Current state: _isBuySelected=$_isBuySelected, _orderType=$_orderType, _selectedSymbol=$_selectedSymbol');
      print('📊 Account: _cachedAccountId=$_cachedAccountId');
      print('📊 Controllers: quantity="${_quantityController.text}", price="${_priceController.text}"');

      if (_quantityController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a quantity'),
            backgroundColor: const Color(0xFFFF4081),
          ),
        );
        return;
      }

      if (_orderType == 'Limit' && _priceController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a price for limit order'),
            backgroundColor: const Color(0xFFFF4081),
          ),
        );
        return;
      }

      if (_cachedAccountId == null || _cachedAccountId!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account ID not available'),
            backgroundColor: const Color(0xFFFF4081),
          ),
        );
        return;
      }

      if (_selectedSymbol.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No instrument selected'),
            backgroundColor: const Color(0xFFFF4081),
          ),
        );
        return;
      }

      // Use the full symbol as instrument listing ID (e.g., "ETH/USD")
      final instrumentId = _selectedSymbol;
      print('🏷️ Using instrumentId: $instrumentId');

      // Generate unique participant order ID
      final participantOrderId = 'order_${DateTime.now().millisecondsSinceEpoch}';

      // Determine order side
      final side = _isBuySelected ? 'BUY' : 'SELL';

      // Set price (0 for market orders)
      final price = _orderType == 'Market' ? '0' : _priceController.text;

      print('📝 Order details: side=$side, type=${_orderType.toUpperCase()}, quantity=${_quantityController.text.trim()}, price=$price');

      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              SizedBox(width: 12),
              Text('Placing ${side.toLowerCase()} order...'),
            ],
          ),
          duration: Duration(seconds: 30), // Long duration for loading
          backgroundColor: _isBuySelected ? const Color(0xFF00D4AA) : const Color(0xFFFF4081),
        ),
      );

      // Call CreateOrder API
      final result = await realGrpcClient.createOrder(
        accountId: _cachedAccountId!,
        feePayerAccountId: _cachedAccountId!,
        instrumentId: instrumentId,
        orderType: _orderType.toUpperCase(),
        side: side,
        quantity: _quantityController.text.trim(),
        price: price,
        timeInForce: "0", // GTC by default
        participantOrderId: participantOrderId,
      );

      // Hide loading indicator
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (result['success'] == true) {
        // Success - handle ExecutionAsyncResponse structure
        final output = result['output'] as Map<String, dynamic>?;

        // For async responses, extract order ID from different possible fields
        final orderId = output?['id'] ??
                       output?['refExecutionId'] ??
                       output?['asyncResponseData']?['order_id'] ??
                       output?['metadata']?['order_id'] ??
                       'Unknown';

        print('📋 CreateOrderAsync response: $output');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '$side order submitted successfully!\nExecution ID: $orderId',
            ),
            backgroundColor: const Color(0xFF00D4AA),
            duration: Duration(seconds: 5),
          ),
        );

        // Refresh orders list to show the new order
        _fetchRealOrders();

        // Order list functionality removed since tabs were removed

        // Clear form after successful order
        _quantityController.clear();
        _priceController.clear();
      } else {
        // Error
        final errorMessage = result['output']?['error'] ?? 'Unknown error occurred';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Order failed: $errorMessage'),
            backgroundColor: const Color(0xFFFF4081),
            duration: Duration(seconds: 7),
          ),
        );
      }
    } catch (e) {
      // Hide loading indicator
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      // Show error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order failed: $e'),
          backgroundColor: const Color(0xFFFF4081),
          duration: Duration(seconds: 7),
        ),
      );
    } catch (e, stackTrace) {
      // Global catch block to prevent app crashes
      print('❌ Critical error in _placeOrder: $e');
      print('Stack trace: $stackTrace');

      // Hide any loading indicators
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      // Show error to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred: $e'),
          backgroundColor: const Color(0xFFFF4081),
          duration: Duration(seconds: 7),
        ),
      );
    }
  }

  Widget _buildTradeOrdersTabs(bool isDarkTheme) {
    return SingleChildScrollView(
      child: _buildCreateOrderForm(isDarkTheme),
    );
  }


  Widget _buildCreateOrderForm(bool isDarkTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          // Currency Row Layout
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  'Currency',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: _HoverDropdownField(
                  isDarkTheme: isDarkTheme,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Map<String, String>>(
                      value: _supportedCurrencies.isEmpty
                          ? null
                          : (_supportedCurrencies.any((currency) => currency['code'] == _selectedCurrency['code'])
                              ? _selectedCurrency
                              : _supportedCurrencies.isNotEmpty ? _supportedCurrencies.first : null),
                      isExpanded: true,
                      onChanged: _supportedCurrencies.isEmpty ? null : (Map<String, String>? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedCurrency = newValue;
                            // Update buying power from already-fetched cash holdings data
                            _updateBuyingPowerFromCachedData();
                          });
                        }
                      },
                      dropdownColor: isDarkTheme ? const Color(0xFF1e1e1e) : Colors.white,
                      style: TextStyle(
                        color: isDarkTheme ? Colors.white : Colors.black,
                        fontSize: 14, // Smaller font size
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
              ),
            ],
          ),

          const SizedBox(height: 16), // Reduced from 20

          // Buy/Sell Toggle Buttons (stretches with container width)
          Container(
            decoration: BoxDecoration(
              color: isDarkTheme ? const Color(0xFF2d2d2d) : Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _HoverTradeButton(
                    text: 'Buy',
                    isSelected: _isBuySelected,
                    selectedColor: const Color(0xFF00D4AA),
                    isDarkTheme: isDarkTheme,
                    onTap: () {
                      setState(() => _isBuySelected = true);
                      _calculateOrderFees();
                    },
                  ),
                ),
                Expanded(
                  child: _HoverTradeButton(
                    text: 'Sell',
                    isSelected: !_isBuySelected,
                    selectedColor: const Color(0xFFFF4081),
                    isDarkTheme: isDarkTheme,
                    onTap: () {
                      setState(() => _isBuySelected = false);
                      _calculateOrderFees();
                      _fetchAccountMarketPortfolio();
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16), // Reduced space before order type

          // Order Type Toggle Buttons with mouse cursor and smaller height (like buy/sell area)
          Container(
            decoration: BoxDecoration(
              color: isDarkTheme ? const Color(0xFF2d2d2d) : Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _HoverOrderTypeButton(
                    text: 'Limit order',
                    isSelected: _orderType == 'Limit',
                    isBuySelected: _isBuySelected,
                    isDarkTheme: isDarkTheme,
                    onTap: () {
                      setState(() => _orderType = 'Limit');
                      _calculateOrderFees();
                    },
                  ),
                ),
                Expanded(
                  child: _HoverOrderTypeButton(
                    text: 'Market order',
                    isSelected: _orderType == 'Market',
                    isBuySelected: _isBuySelected,
                    isDarkTheme: isDarkTheme,
                    onTap: () {
                      setState(() => _orderType = 'Market');
                      _calculateOrderFees();
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16), // Reduced space after order type

          // Available Balance / Buying Power Row Layout
          Row(
            children: [
              Text(
                _isBuySelected ? 'Available to Invest' : 'Available',
                style: TextStyle(
                  fontSize: 14,
                  color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Row(
                  children: [
                    _isLoadingCashHoldings
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                isDarkTheme ? Colors.white : Colors.black,
                              ),
                            ),
                          )
                        : Text(
                            _isBuySelected
                                ? '$_buyingPower ${_selectedCurrency['symbol'] ?? ''}'
                                : _availableBalance,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: isDarkTheme ? Colors.white : Colors.black,
                            ),
                          ),
                    const SizedBox(width: 4),
                    (!_isBuySelected && _assets.isEmpty)
                        ? SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                isDarkTheme ? Colors.white : Colors.black,
                              ),
                            ),
                          )
                        : (!_isBuySelected
                            ? Text(
                                _getSelectedAssetSymbol(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: isDarkTheme ? Colors.white : Colors.black,
                                ),
                              )
                            : SizedBox.shrink()),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Amount Input
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  'Amount',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ),
              Expanded(
                child: _HoverInputField(
                  controller: _quantityController,
                  hintText: '0',
                  isDarkTheme: isDarkTheme,
                  suffixWidget: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Show Max button only for Sell orders (when _isBuySelected is false)
                        if (!_isBuySelected) ...[
                          MouseRegion(
                            cursor: SystemMouseCursors.click, // Pointer cursor for Max button
                            child: GestureDetector(
                              onTap: () {
                                // Set quantity to maximum available amount
                                setState(() {
                                  _quantityController.text = _availableBalance;
                                });
                              },
                              child: Container(
                                child: Text(
                                  'Max',
                                  style: TextStyle(
                                    color: const Color(0xFFFF4081), // Pink for sell
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        _assets.isEmpty
                            ? SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(
                                  strokeWidth: 1.5,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    isDarkTheme ? Colors.white : Colors.black,
                                  ),
                                ),
                              )
                            : Text(
                                _getSelectedAssetSymbol(),
                                style: TextStyle(
                                  color: isDarkTheme ? Colors.white : Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          if (_orderType == 'Limit') ...[
            const SizedBox(height: 12),

            // Price Input
            Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Text(
                    'Price',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ),
                Expanded(
                  child: _HoverInputField(
                    controller: _priceController,
                    hintText: '0',
                    isDarkTheme: isDarkTheme,
                    suffixWidget: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Text(
                        '\$',
                        style: TextStyle(
                          color: isDarkTheme ? Colors.white : Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Expiry Dropdown
            Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Text(
                    'Expiry',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ),
                Expanded(
                  child: _HoverDropdownField(
                    isDarkTheme: isDarkTheme,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _expiryPeriod,
                          isExpanded: true,
                          isDense: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              _expiryPeriod = newValue!;
                            });
                          },
                          dropdownColor: isDarkTheme ? const Color(0xFF1e1e1e) : Colors.white,
                          style: TextStyle(
                            color: isDarkTheme ? Colors.white : Colors.black,
                            fontSize: 14,
                          ),
                          items: ['1 Day', '3 Days', '1 Week', '2 Weeks', '1 Month']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],

          // Show Order Summary only for Limit orders
          if (_orderType == 'Limit') ...[
            const SizedBox(height: 12), // Add space between amount field and est.fee total area

            // Order Summary (no border)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkTheme ? const Color(0xFF3d3d3d) : Colors.grey[50],
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
                          color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                      _isLoadingFee
                          ? SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  isDarkTheme ? Colors.white : Colors.black,
                                ),
                              ),
                            )
                          : Text(
                              _estimatedFee,
                              style: TextStyle(
                                fontSize: 14,
                                color: isDarkTheme ? Colors.white : Colors.black,
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
                          color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                      Text(
                        '${_formatDecimal(_calculateTotal().toString())} \$',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDarkTheme ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],

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
    );
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
      final spotPaintMax = Paint()..color = const Color(0xFF00D4AA);
      canvas.drawCircle(Offset(maxX, maxYSpot), spotRadius, spotPaintMax);
      // Draw min spot (red)
      final spotPaintMin = Paint()..color = const Color(0xFFFF4081);
      canvas.drawCircle(Offset(minX, minYSpot), spotRadius, spotPaintMin);
      // Max line at maxYSpot
      canvas.drawLine(
        Offset(0, maxYSpot),
        Offset(size.width, maxYSpot),
        minMaxPaint..color = const Color(0xFF00D4AA),
      );
      // Min line at minYSpot
      canvas.drawLine(
        Offset(0, minYSpot),
        Offset(size.width, minYSpot),
        minMaxPaint..color = const Color(0xFFFF4081),
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

class _HoverButton extends StatefulWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;

  const _HoverButton({
    required this.text,
    required this.color,
    required this.onTap,
  });

  @override
  State<_HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<_HoverButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          decoration: BoxDecoration(
            color: widget.color.withOpacity(_isHovered ? 0.8 : 0.1),
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: widget.color, width: 0.5),
          ),
          child: Text(
            widget.text,
            style: TextStyle(
              color: _isHovered ? Colors.white : widget.color,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _HoverTradeButton extends StatefulWidget {
  final String text;
  final bool isSelected;
  final Color selectedColor;
  final bool isDarkTheme;
  final VoidCallback onTap;

  const _HoverTradeButton({
    required this.text,
    required this.isSelected,
    required this.selectedColor,
    required this.isDarkTheme,
    required this.onTap,
  });

  @override
  State<_HoverTradeButton> createState() => _HoverTradeButtonState();
}

class _HoverTradeButtonState extends State<_HoverTradeButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? widget.selectedColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: widget.isSelected
                  ? Colors.white
                  : (_isHovered
                      ? widget.selectedColor
                      : (widget.isDarkTheme ? Colors.grey[400] : Colors.grey[600])),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class _HoverOrderTypeButton extends StatefulWidget {
  final String text;
  final bool isSelected;
  final bool isBuySelected;
  final bool isDarkTheme;
  final VoidCallback onTap;

  const _HoverOrderTypeButton({
    required this.text,
    required this.isSelected,
    required this.isBuySelected,
    required this.isDarkTheme,
    required this.onTap,
  });

  @override
  State<_HoverOrderTypeButton> createState() => _HoverOrderTypeButtonState();
}

class _HoverOrderTypeButtonState extends State<_HoverOrderTypeButton> {
  bool _isHovered = false;

  Color get _selectedColor => widget.isBuySelected
      ? const Color(0xFF00D4AA)  // Cyan for buy
      : const Color(0xFFFF4081); // Pink for sell

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: widget.isSelected
                  ? _selectedColor
                  : (_isHovered
                      ? _selectedColor
                      : (widget.isDarkTheme ? Colors.grey[400] : Colors.grey[600])),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class _HoverInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isDarkTheme;
  final Widget? suffixWidget;

  const _HoverInputField({
    required this.controller,
    required this.hintText,
    required this.isDarkTheme,
    this.suffixWidget,
  });

  @override
  State<_HoverInputField> createState() => _HoverInputFieldState();
}

class _HoverInputFieldState extends State<_HoverInputField> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.isDarkTheme ? const Color(0xFF2d2d2d) : Colors.grey[200]!;
    final borderColor = _isHovered
        ? (widget.isDarkTheme ? Colors.grey[500]! : Colors.grey[400]!)
        : backgroundColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: widget.controller,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: widget.isDarkTheme ? Colors.white : Colors.black,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: widget.isDarkTheme ? Colors.grey[500] : Colors.grey[400],
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                ),
              ),
            ),
            if (widget.suffixWidget != null) widget.suffixWidget!,
          ],
        ),
      ),
    );
  }
}

class _HoverDropdownField extends StatefulWidget {
  final bool isDarkTheme;
  final Widget child;

  const _HoverDropdownField({
    required this.isDarkTheme,
    required this.child,
  });

  @override
  State<_HoverDropdownField> createState() => _HoverDropdownFieldState();
}

class _HoverDropdownFieldState extends State<_HoverDropdownField> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.isDarkTheme ? const Color(0xFF2d2d2d) : Colors.grey[200]!;
    final borderColor = _isHovered
        ? (widget.isDarkTheme ? Colors.grey[500]! : Colors.grey[400]!)
        : backgroundColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        height: 35,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
