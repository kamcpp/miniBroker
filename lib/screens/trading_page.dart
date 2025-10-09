
import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:candlesticks/candlesticks.dart';
import '../services/auth_service.dart';
import '../services/theme_service.dart';
import '../services/real_grpc_client.dart';
import '../services/grpcurl_helper.dart';
import '../services/chart_service.dart';
import '../utils/connectivity_checker.dart';
import 'portfolio_page.dart';
import 'Cash_management_page.dart';
import 'activity_page.dart';
import 'profile_page.dart';
import 'users_admin_page.dart';

class TradingPage extends StatefulWidget {
  const TradingPage({super.key});

  @override
  State<TradingPage> createState() => _TradingPageState();
}

class _TradingPageState extends State<TradingPage> {
  Future<void> _fetchTradeHistoryForAsset(String symbol, {int pageSize = 15}) async {
    print('[TradeHistory] Fetching for symbol: $symbol, pageSize: $pageSize');

    setState(() {
      _isLoadingTradeHistory = pageSize == 15; // Loading initial data
      _isLoadingMoreTradeHistory = pageSize > 15; // Loading more data
    });

    // Find the asset data for this symbol
    final asset = _assets.firstWhere(
      (asset) => asset['symbol'] == symbol,
      orElse: () {
        print('[TradeHistory] Asset not found for symbol: $symbol');
        setState(() {
          _tradeHistory = [];
          _isLoadingTradeHistory = false;
          _isLoadingMoreTradeHistory = false;
        });
        return <String, dynamic>{};
      },
    );

    if (asset.isEmpty) {
      print('[TradeHistory] Asset is empty for symbol: $symbol');
      return;
    }

    final instrumentIid = asset['iid']?.toString() ?? '';
    print('[TradeHistory] instrumentIid: $instrumentIid');

    if (instrumentIid.isEmpty) {
      setState(() {
        _tradeHistory = [];
        _isLoadingTradeHistory = false;
        _isLoadingMoreTradeHistory = false;
      });
      return;
    }

    try {
      // Call GetInstrumentTrades gRPC function
      final result = await GrpcurlHelper.getInstrumentTrades(
        instrumentId: instrumentIid,
        pageNumber: 1, // Always page 1
        pageSize: pageSize,
      );

      List<Map<String, dynamic>> parsedTrades = [];

      if (result['success'] == true && result['output'] != null) {
        final output = result['output'] as Map<String, dynamic>;
        print('[TradeHistory] gRPC response: $output');

        // Extract trades from the response
        final trades = output['trades'] as List<dynamic>? ?? [];
        print('[TradeHistory] Found ${trades.length} trades');

        parsedTrades = trades.map<Map<String, dynamic>>((trade) {
          final tradeMap = trade as Map<String, dynamic>;
          final priceValue = tradeMap['price'];
          final quantityValue = tradeMap['quantity'];
          final timestampValue = tradeMap['timestamp'];
          final isBuy = tradeMap['isBuy'] ?? tradeMap['is_buy'] ?? false;

          // Parse price and quantity
          final price = priceValue is String
              ? double.tryParse(priceValue) ?? 0.0
              : (priceValue is num ? priceValue.toDouble() : 0.0);
          final quantity = quantityValue is String
              ? double.tryParse(quantityValue) ?? 0.0
              : (quantityValue is num ? quantityValue.toDouble() : 0.0);

          // Format timestamp
          final time = (() {
            if (timestampValue == null) return '';
            try {
              DateTime dt;
              if (timestampValue is String) {
                // Try parsing ISO format
                dt = DateTime.parse(timestampValue);
              } else if (timestampValue is int) {
                dt = DateTime.fromMillisecondsSinceEpoch(timestampValue * 1000);
              } else {
                return '';
              }
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
            } catch (e) {
              print('[TradeHistory] Error parsing timestamp: $e');
              return '';
            }
          })();

          final priceColor = isBuy ? const Color(0xFF00D4AA) : const Color(0xFFFF4081);

          return {
            'price': price,
            'quantity': quantity.toString(),
            'time': time,
            'priceColor': priceColor,
          };
        }).toList();
      } else {
        print('[TradeHistory] gRPC call failed. Response: $result');
      }

      if (mounted) {
        setState(() {
          _tradeHistory = List.from(parsedTrades); // Force UI update
          _tradeHistoryPageSize = pageSize; // Update current page size
          _hasMoreTradeHistory = true; // Always show "Show More" button
          _isLoadingTradeHistory = false;
          _isLoadingMoreTradeHistory = false;
          print('[TradeHistory] Updated with ${_tradeHistory.length} trades');
        });
      }
    } catch (e) {
      print('❌ Error fetching trade history for $symbol: $e');
      if (mounted) {
        setState(() {
          _tradeHistory = [];
          _isLoadingTradeHistory = false;
          _isLoadingMoreTradeHistory = false;
        });
      }
    }
  }
  
  void _loadMoreTradeHistory() {
    if (!_isLoadingMoreTradeHistory && _hasMoreTradeHistory && _selectedSymbol.isNotEmpty) {
      print('[TradeHistory] Loading more - increasing page size from $_tradeHistoryPageSize to ${_tradeHistoryPageSize + 10}');
      _fetchTradeHistoryForAsset(_selectedSymbol, pageSize: _tradeHistoryPageSize + 10);
    }
  }

  void _resetAndFetchTradeHistory(String symbol) {
    _tradeHistoryPageSize = 15;
    _hasMoreTradeHistory = true;
    _fetchTradeHistoryForAsset(symbol, pageSize: 15);
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

        // Load venues and instruments for the first market if available
        if (_selectedMarket.isNotEmpty && _selectedMarket['id']!.isNotEmpty) {
          await _fetchVenues(_selectedMarket['id']!);
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

  /// Fetch venues for a specific market
  Future<void> _fetchVenues(String marketId) async {
    if (_isLoadingVenues) return;

    setState(() {
      _isLoadingVenues = true;
    });

    try {
      print('🏟️ Fetching venues for market: $marketId...');

      final result = await realGrpcClient.getVenueList(
        marketId: marketId,
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print('⏰ GetVenueList timed out after 10 seconds');
          return {
            'success': false,
            'output': {'error': 'Request timed out after 10 seconds'},
          };
        },
      );

      if (result['success'] == true && result['output'] != null) {
        final output = result['output'];
        final venues = output['venues'] as List<dynamic>? ?? [];

        final venueData = <Map<String, String>>[];
        final addedVenueIds = <String>{}; // Track added venue IDs to prevent duplicates

        // Add "All Venues" option first
        venueData.add({'id': '', 'display': 'All Venues'});
        addedVenueIds.add(''); // Mark empty string as added

        for (final venue in venues) {
          if (venue is Map<String, dynamic>) {
            // Extract value from identifiers
            String venueValue = '';
            final identifiers = venue['identifiers'] as List<dynamic>? ?? [];

            for (final identifier in identifiers) {
              if (identifier is Map<String, dynamic>) {
                final ids = identifier['ids'] as List<dynamic>? ?? [];
                if (ids.isNotEmpty && ids.first is Map<String, dynamic>) {
                  venueValue = ids.first['value']?.toString() ?? '';
                  if (venueValue.isNotEmpty) break;
                }
              }
            }

            // Fallback to displayName if value not found
            final displayNames = venue['displayNames'] as Map<String, dynamic>? ?? {};
            final displayName = displayNames['en']?.toString() ?? venueValue;

            // Only add if venueValue is not empty and not already added
            if (venueValue.isNotEmpty && !addedVenueIds.contains(venueValue)) {
              venueData.add({
                'id': venueValue,
                'display': displayName.isNotEmpty ? displayName : venueValue,
              });
              addedVenueIds.add(venueValue); // Mark this venue ID as added
            }
          }
        }

        setState(() {
          _venues = venueData;
          if (_selectedVenue['id']!.isEmpty && _venues.isNotEmpty) {
            _selectedVenue = _venues.first; // Default to "All Venues"
          }
          _isLoadingVenues = false;
        });

        print('✅ Loaded ${_venues.length} venues');
      } else {
        print('❌ Failed to fetch venues: ${result['output']}');
        setState(() {
          _venues = [{'id': '', 'display': 'All Venues'}];
          _selectedVenue = _venues.first;
          _isLoadingVenues = false;
        });
      }
    } catch (e) {
      print('❌ Error fetching venues: $e');
      setState(() {
        _venues = [{'id': '', 'display': 'All Venues'}];
        _selectedVenue = _venues.first;
        _isLoadingVenues = false;
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
        pageNumber: 0,
        pageSize: 0,
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
              _loadChartData(_selectedSymbol);
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
            _fetchTradeHistoryForAsset(_selectedSymbol, pageSize: 15);
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

  // Venue data
  List<Map<String, String>> _venues = [];
  Map<String, String> _selectedVenue = {'id': '', 'display': 'All Venues'};
  bool _isLoadingVenues = false;

  // Supported currencies data
  List<Map<String, String>> _supportedCurrencies = [];
  Map<String, String> _selectedCurrency = {};
  bool _isLoadingSupportedCurrencies = false;
  
  // Trade history pagination
  int _currentTradeHistoryPage = 1;
  int _tradeHistoryPageSize = 15; // Start with 15, then increase by 10 (15, 25, 35, ...)
  bool _hasMoreTradeHistory = true;
  bool _isLoadingTradeHistory = false;
  bool _isLoadingMoreTradeHistory = false;
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
  double _marketOverviewHeight = 200.0; // Increased to accommodate Market and Venue dropdowns
  bool _isDraggingMarketOverview = false; // State for market splitter

  // Bottom section width split (Orders vs Orderbook)
  double _bottomOrdersWidth = 0.71; // 71% for Orders, 29% for Orderbook
  bool _isDraggingBottomSplit = false;

  // Top/Bottom section height split
  double _topSectionRatio = 0.72; // 72% for top, 28% for bottom - ensures Buy Order button is visible
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

  // Pagination variables for orders and history
  int _ordersPageSize = 10;  // Start with 10, increase by 10 each load more
  int _historyPageSize = 10; // Start with 10, increase by 10 each load more
  bool _isLoadingMoreOrders = false;
  bool _isLoadingMoreHistory = false;

  // Chart data variables using candlesticks package
  List<Candle> _candles = [];
  bool _isLoadingChart = false;
  String _chartError = '';
  String _selectedTimePeriod = '1h'; // Default period
  ChartService? _chartService;
  StreamSubscription? _liveOhlcSubscription;
  
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
  int _orderbookPageSize = 5;
  int _currentSellOrdersPageSize = 5; // Track current page size for sell orders
  int _currentBuyOrdersPageSize = 5;  // Track current page size for buy orders
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
          _loadChartData(_selectedSymbol);
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
      // Get the selected currency code to pass to GetAccountCashHoldings
      final selectedCurrencyCode = _selectedCurrency.isNotEmpty ? _selectedCurrency['code'] : 'USD';
      final currencyCodes = selectedCurrencyCode != null && selectedCurrencyCode.isNotEmpty
          ? [selectedCurrencyCode]
          : <String>[];

      print('📋 Fetching cash holdings for currency: $selectedCurrencyCode');

      // Fetch cash holdings with comprehensive crash protection
      final cashHoldingsResponse = await realGrpcClient.getAccountCashHoldings(
        accountId: accountId,
        cashAssetIds: currencyCodes,
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
          'page_nr': 1,
          'page_size': _ordersPageSize > _historyPageSize ? _ordersPageSize : _historyPageSize, // Use the larger page size to get enough data for both tables
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
              'participantOrderId': order['participantOrderId'] ?? order['participant_order_id'] ?? order['orderIid'] ?? order['order_id'] ?? 'N/A',
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

  /// Load more orders by increasing page size for orders table
  Future<void> _loadMoreOrders() async {
    if (_isLoadingMoreOrders || _cachedAccountId == null) return;

    setState(() {
      _isLoadingMoreOrders = true;
      _ordersPageSize += 10; // Increase page size by 10
    });

    await _fetchRealOrders();

    setState(() {
      _isLoadingMoreOrders = false;
    });
  }

  /// Load more history by increasing page size for history table
  Future<void> _loadMoreHistory() async {
    if (_isLoadingMoreHistory || _cachedAccountId == null) return;

    setState(() {
      _isLoadingMoreHistory = true;
      _historyPageSize += 10; // Increase page size by 10
    });

    await _fetchRealOrders();

    setState(() {
      _isLoadingMoreHistory = false;
    });
  }

  /// Cancel an order using CancelOrderAsync
  Future<void> _cancelOrder(String participantOrderId) async {
    try {
      print('🚫 Attempting to cancel order: $participantOrderId');

      // Show confirmation dialog
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Cancel Order'),
            content: Text('Are you sure you want to cancel order $participantOrderId?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          );
        },
      );

      if (confirmed != true) return;

      // Show loading snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text('Cancelling order...'),
            ],
          ),
          duration: Duration(seconds: 30),
        ),
      );

      // Call CancelOrderAsync
      final result = await GrpcurlHelper.cancelOrderAsync(
        participantOrderId: participantOrderId,
        reason: 'User requested cancellation',
        refRequestId: 'flutter-cancel-${DateTime.now().millisecondsSinceEpoch}',
      ).timeout(const Duration(seconds: 10));

      // Hide loading snackbar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (result['success'] == true) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Order $participantOrderId cancelled successfully!'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );

        // Refresh orders to show updated status
        _fetchRealOrders();
      } else {
        final errorMsg = result['output']?['error'] ?? 'Failed to cancel order';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to cancel order: $errorMsg'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } catch (e) {
      // Hide loading snackbar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error cancelling order: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
      print('❌ Error in _cancelOrder: $e');
    }
  }

  /// Replace an order using ReplaceOrderAsync
  Future<void> _replaceOrder(String participantOrderId, Map<String, dynamic> currentOrder) async {
    try {
      print('🔄 Attempting to replace order: $participantOrderId');

      // Controllers for the dialog
      final quantityController = TextEditingController(text: currentOrder['quantity']?.toString() ?? '');
      final priceController = TextEditingController(text: currentOrder['price']?.toString() ?? '');

      // State variables for the dialog
      DateTime? selectedExpirationDate;
      TimeOfDay? selectedExpirationTime;

      // Show replace order dialog
      final result = await showDialog<Map<String, dynamic>>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                title: Text('Replace Order $participantOrderId'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: quantityController,
                        decoration: const InputDecoration(labelText: 'New Quantity'),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: priceController,
                        decoration: const InputDecoration(labelText: 'New Price'),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'New Expiration Time (Optional)',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(height: 10),
                      // Date picker
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: selectedExpirationDate ?? DateTime.now().add(const Duration(days: 1)),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(const Duration(days: 365)),
                                );
                                if (date != null) {
                                  setState(() {
                                    selectedExpirationDate = date;
                                  });
                                }
                              },
                              icon: const Icon(Icons.calendar_today, size: 16),
                              label: Text(
                                selectedExpirationDate != null
                                    ? '${selectedExpirationDate!.day}/${selectedExpirationDate!.month}/${selectedExpirationDate!.year}'
                                    : 'Select Date',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () async {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: selectedExpirationTime ?? const TimeOfDay(hour: 17, minute: 0),
                                );
                                if (time != null) {
                                  setState(() {
                                    selectedExpirationTime = time;
                                  });
                                }
                              },
                              icon: const Icon(Icons.access_time, size: 16),
                              label: Text(
                                selectedExpirationTime != null
                                    ? '${selectedExpirationTime!.hour.toString().padLeft(2, '0')}:${selectedExpirationTime!.minute.toString().padLeft(2, '0')}'
                                    : 'Select Time',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (selectedExpirationDate != null || selectedExpirationTime != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Selected: ${_formatSelectedDateTime(selectedExpirationDate, selectedExpirationTime)}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    selectedExpirationDate = null;
                                    selectedExpirationTime = null;
                                  });
                                },
                                child: const Text('Clear', style: TextStyle(fontSize: 12)),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Combine date and time if both are selected
                      DateTime? fullExpirationDateTime;
                      if (selectedExpirationDate != null) {
                        final time = selectedExpirationTime ?? const TimeOfDay(hour: 0, minute: 0);
                        fullExpirationDateTime = DateTime(
                          selectedExpirationDate!.year,
                          selectedExpirationDate!.month,
                          selectedExpirationDate!.day,
                          time.hour,
                          time.minute,
                        );
                      }

                      Navigator.of(context).pop({
                        'quantity': quantityController.text,
                        'price': priceController.text,
                        'expirationDateTime': fullExpirationDateTime,
                      });
                    },
                    child: const Text('Replace'),
                  ),
                ],
              );
            },
          );
        },
      );

      if (result == null) return;

      final newQuantity = result['quantity']?.trim();
      final newPrice = result['price']?.trim();
      final DateTime? expirationDateTime = result['expirationDateTime'];

      if ((newQuantity == null || newQuantity.isEmpty) &&
          (newPrice == null || newPrice.isEmpty) &&
          expirationDateTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please provide new quantity, price, or expiration time'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Show loading snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text('Replacing order...'),
            ],
          ),
          duration: Duration(seconds: 30),
        ),
      );

      // Generate new order ID
      final newOrderId = '${participantOrderId}_repl_${DateTime.now().millisecondsSinceEpoch}';

      // Call ReplaceOrderAsync
      final replaceResult = await GrpcurlHelper.replaceOrderAsync(
        oldParticipantOrderId: participantOrderId,
        newParticipantOrderId: newOrderId,
        newQuantity: newQuantity,
        newPrice: newPrice,
        newExpireTime: expirationDateTime,
        reason: 'User requested replacement',
        refRequestId: 'flutter-replace-${DateTime.now().millisecondsSinceEpoch}',
      ).timeout(const Duration(seconds: 10));

      // Hide loading snackbar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (replaceResult['success'] == true) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Order $participantOrderId replaced successfully!'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );

        // Refresh orders to show updated status
        _fetchRealOrders();
      } else {
        final errorMsg = replaceResult['output']?['error'] ?? 'Failed to replace order';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to replace order: $errorMsg'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } catch (e) {
      // Hide loading snackbar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error replacing order: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
      print('❌ Error in _replaceOrder: $e');
    }
  }

  /// Helper method to format selected date and time for display
  String _formatSelectedDateTime(DateTime? date, TimeOfDay? time) {
    if (date == null && time == null) return 'None';

    String result = '';
    if (date != null) {
      result += '${date.day}/${date.month}/${date.year}';
    }
    if (time != null) {
      if (result.isNotEmpty) result += ' ';
      result += '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }
    return result;
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
                    _loadChartData(_selectedSymbol);
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
              _loadChartData(_selectedSymbol);
            });
          }
        }
      });
    }
  }
  
  /// Load chart data using gRPC GetHistoricalOhlcData
  Future<void> _loadChartData(String symbol) async {
    print('📊 Loading chart data for $symbol, period: $_selectedTimePeriod');

    setState(() {
      _isLoadingChart = true;
      _chartError = '';
    });

    try {
      // Call gRPC GetHistoricalOhlcData using grpcurl
      final result = await GrpcurlHelper.getHistoricalOhlcData(
        symbol: symbol,
        period: _selectedTimePeriod,
        pageSize: 0,
      );

      if (result['success'] == true && result['output'] != null) {
        final output = result['output'] as Map<String, dynamic>;
        final ohlcDataList = output['ohlcDatas'] as List<dynamic>? ?? [];

        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('📊 CHART DATA PROCESSING for $symbol:');
        print('✅ Received ${ohlcDataList.length} OHLC data points from server');
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

        // Convert to Candle objects
        final List<Candle> candles = [];
        for (var ohlcData in ohlcDataList) {
          try {
            final ohlcMap = ohlcData as Map<String, dynamic>;

            // Parse timestamp from duration
            DateTime timestamp = DateTime.now();
            if (ohlcMap.containsKey('duration')) {
              final duration = ohlcMap['duration'] as Map<String, dynamic>?;
              if (duration != null && duration.containsKey('startDt')) {
                final startDt = duration['startDt'] as Map<String, dynamic>?;
                if (startDt != null && startDt.containsKey('date')) {
                  final date = startDt['date'] as Map<String, dynamic>?;
                  if (date != null) {
                    final year = date['year'] ?? 0;
                    final month = date['month'] ?? 1;
                    final day = date['day'] ?? 1;
                    int hour = 0;
                    int minute = 0;

                    if (startDt.containsKey('time')) {
                      final time = startDt['time'] as Map<String, dynamic>?;
                      if (time != null && time.containsKey('hms')) {
                        final hms = time['hms'] as Map<String, dynamic>?;
                        if (hms != null) {
                          hour = hms['hour'] ?? 0;
                          minute = hms['minute'] ?? 0;
                        }
                      }
                    }

                    timestamp = DateTime(year, month, day, hour, minute);
                  }
                }
              }
            }

            final candle = Candle(
              date: timestamp,
              open: double.tryParse(ohlcMap['open']?.toString() ?? '0') ?? 0.0,
              high: double.tryParse(ohlcMap['high']?.toString() ?? '0') ?? 0.0,
              low: double.tryParse(ohlcMap['low']?.toString() ?? '0') ?? 0.0,
              close: double.tryParse(ohlcMap['close']?.toString() ?? '0') ?? 0.0,
              volume: double.tryParse(ohlcMap['volume']?.toString() ?? '0') ?? 0.0,
            );

            candles.add(candle);
          } catch (e) {
            print('⚠️ Error parsing OHLC data point: $e');
          }
        }

        // Sort by date (newest first for candlesticks package)
        candles.sort((a, b) => b.date.compareTo(a.date));

        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('📊 CHART CONVERSION RESULT:');
        print('✅ Successfully converted ${candles.length} candles for $symbol');

        if (candles.isEmpty) {
          print('⚠️  WARNING: NO CANDLES CONVERTED! Chart will show empty.');
        } else if (candles.length < 2) {
          print('⚠️  WARNING: Only ${candles.length} candle(s) available - need at least 2 for chart!');
          print('   Sample candle: Open=${candles[0].open}, High=${candles[0].high}, Low=${candles[0].low}, Close=${candles[0].close}, Volume=${candles[0].volume}, Date=${candles[0].date}');
        } else {
          print('✅ Chart ready with ${candles.length} candles');
          print('   First candle: Open=${candles[0].open}, High=${candles[0].high}, Low=${candles[0].low}, Close=${candles[0].close}, Date=${candles[0].date}');
          print('   Last candle: Open=${candles.last.open}, High=${candles.last.high}, Low=${candles.last.low}, Close=${candles.last.close}, Date=${candles.last.date}');
        }
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

        setState(() {
          _candles = candles;
          _isLoadingChart = false;
        });
      } else {
        throw Exception('Failed to fetch chart data: ${result['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      print('❌ Error loading chart data: $e');
      setState(() {
        _chartError = 'Failed to load chart data: $e';
        _isLoadingChart = false;
      });
    }
  }
  
  Future<void> _fetchOrderbookData(String symbol) async {
    print('📊 Fetching orderbook data for symbol: $symbol');

    // Reset pagination when fetching new symbol
    _currentSellOrdersPage = 1;
    _currentBuyOrdersPage = 1;
    _currentSellOrdersPageSize = 5;
    _currentBuyOrdersPageSize = 5;
    _hasMoreSellOrders = true;
    _hasMoreBuyOrders = true;
    _totalSellOrdersPages = 1;
    _totalBuyOrdersPages = 1;

    // Fetch both sell and buy orders in parallel for faster loading
    await Future.wait([
      _fetchSellOrders(symbol, pageSize: 5, append: false),
      _fetchBuyOrders(symbol, pageSize: 5, append: false),
    ]);
  }
  
  Future<void> _fetchSellOrders(String symbol, {int pageSize = 5, bool append = false}) async {
    print('📊 Fetching sell orders for symbol: $symbol, pageSize: $pageSize');

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

    final instrumentIid = asset['iid']?.toString() ?? '';

    print('[Orderbook-Sell] $symbol: instrumentIid="$instrumentIid"');

    if (instrumentIid.isEmpty) {
      print('❌ Missing instrument IID for sell orders $symbol - no orderbook data available');
      setState(() {
        if (!append) _sellOrders = [];
        _hasMoreSellOrders = false;
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
      // Call GetOrderbook gRPC function
      final result = await GrpcurlHelper.getOrderbook(
        instrumentIid: instrumentIid,
        side: 'ORDER_SIDE__SELL',
        pageNumber: 1,  // Always page 1
        pageSize: pageSize,  // Increase page size instead
      );

      List<Map<String, dynamic>> sellOrders = [];

      if (result['success'] == true && result['output'] != null) {
        final output = result['output'] as Map<String, dynamic>;
        print('[Orderbook-Sell] $symbol gRPC response: $output');

        // Extract sell_list from the response
        final sellList = output['sellList'] as Map<String, dynamic>? ?? {};
        final orders = sellList['orders'] as List<dynamic>? ?? [];

        print('[Orderbook-Sell] $symbol found ${orders.length} orders');

        sellOrders = orders.map<Map<String, dynamic>>((order) {
          final orderMap = order as Map<String, dynamic>;
          final priceValue = orderMap['price'];
          final quantityValue = orderMap['quantity'];

          // Parse price and quantity
          final price = priceValue is String
              ? double.tryParse(priceValue) ?? 0.0
              : (priceValue is num ? priceValue.toDouble() : 0.0);
          final quantity = quantityValue is String
              ? double.tryParse(quantityValue) ?? 0.0
              : (quantityValue is num ? quantityValue.toDouble() : 0.0);

          // Calculate total (price * quantity)
          final total = price * quantity;

          print('[Orderbook-Sell] Mapping order: price=$price, quantity=$quantity, total=$total');

          return {
            'price': price,
            'quantity': quantity,
            'total': total,
          };
        }).toList();

        print('[Orderbook-Sell] ✅ Mapped ${sellOrders.length} sell orders');
        print('[Orderbook-Sell] First order: ${sellOrders.isNotEmpty ? sellOrders[0] : "none"}');
      } else {
        print('[Orderbook-Sell] $symbol: gRPC call failed. Response: $result');
      }

      setState(() {
        _sellOrders = sellOrders;  // Always replace with new data
        print('[Orderbook-Sell] setState called: _sellOrders now has ${_sellOrders.length} orders');
        print('[Orderbook-Sell] _sellOrders content: $_sellOrders');
        print('[Orderbook-Sell] Requested pageSize: $pageSize, Got: ${sellOrders.length}');

        _currentSellOrdersPageSize = pageSize;  // Update current page size
        _hasMoreSellOrders = true;  // Always show "Show More" button

        if (!append) _isLoadingSellOrders = false;
        if (append) _isLoadingMoreSellOrders = false;
      });

    } catch (e) {
      print('❌ Error fetching sell orders for $symbol: $e');
      setState(() {
        if (!append) {
          _sellOrders = [];
          _hasMoreSellOrders = false;
          _totalSellOrdersPages = 1;
          _isLoadingSellOrders = false;
        } else {
          _isLoadingMoreSellOrders = false;
        }
      });
    }
  }
  
  Future<void> _fetchBuyOrders(String symbol, {int pageSize = 5, bool append = false}) async {
    print('📊 Fetching buy orders for symbol: $symbol, pageSize: $pageSize');

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

    final instrumentIid = asset['iid']?.toString() ?? '';

    print('[Orderbook-Buy] $symbol: instrumentIid="$instrumentIid"');

    if (instrumentIid.isEmpty) {
      print('❌ Missing instrument IID for buy orders $symbol - no orderbook data available');
      setState(() {
        if (!append) _buyOrders = [];
        _hasMoreBuyOrders = false;
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
      // Call GetOrderbook gRPC function
      final result = await GrpcurlHelper.getOrderbook(
        instrumentIid: instrumentIid,
        side: 'ORDER_SIDE__BUY',
        pageNumber: 1,  // Always page 1
        pageSize: pageSize,  // Increase page size instead
      );

      List<Map<String, dynamic>> buyOrders = [];

      if (result['success'] == true && result['output'] != null) {
        final output = result['output'] as Map<String, dynamic>;
        print('[Orderbook-Buy] $symbol gRPC response: $output');

        // Extract buy_list from the response
        final buyList = output['buyList'] as Map<String, dynamic>? ?? {};
        final orders = buyList['orders'] as List<dynamic>? ?? [];

        print('[Orderbook-Buy] $symbol found ${orders.length} orders');

        buyOrders = orders.map<Map<String, dynamic>>((order) {
          final orderMap = order as Map<String, dynamic>;
          final priceValue = orderMap['price'];
          final quantityValue = orderMap['quantity'];

          // Parse price and quantity
          final price = priceValue is String
              ? double.tryParse(priceValue) ?? 0.0
              : (priceValue is num ? priceValue.toDouble() : 0.0);
          final quantity = quantityValue is String
              ? double.tryParse(quantityValue) ?? 0.0
              : (quantityValue is num ? quantityValue.toDouble() : 0.0);

          // Calculate total (price * quantity)
          final total = price * quantity;

          print('[Orderbook-Buy] Mapping order: price=$price, quantity=$quantity, total=$total');

          return {
            'price': price,
            'quantity': quantity,
            'total': total,
          };
        }).toList();

        print('[Orderbook-Buy] ✅ Mapped ${buyOrders.length} buy orders');
        print('[Orderbook-Buy] First order: ${buyOrders.isNotEmpty ? buyOrders[0] : "none"}');
      } else {
        print('[Orderbook-Buy] $symbol: gRPC call failed. Response: $result');
      }

      setState(() {
        _buyOrders = buyOrders;  // Always replace with new data
        print('[Orderbook-Buy] setState called: _buyOrders now has ${_buyOrders.length} orders');
        print('[Orderbook-Buy] _buyOrders content: $_buyOrders');
        print('[Orderbook-Buy] Requested pageSize: $pageSize, Got: ${buyOrders.length}');

        _currentBuyOrdersPageSize = pageSize;  // Update current page size
        _hasMoreBuyOrders = true;  // Always show "Show More" button

        if (!append) _isLoadingBuyOrders = false;
        if (append) _isLoadingMoreBuyOrders = false;
      });

    } catch (e) {
      print('❌ Error fetching buy orders for $symbol: $e');
      setState(() {
        if (!append) {
          _buyOrders = [];
          _hasMoreBuyOrders = false;
          _totalBuyOrdersPages = 1;
          _isLoadingBuyOrders = false;
        } else {
          _isLoadingMoreBuyOrders = false;
        }
      });
    }
  }
  
  void _goToSellOrdersPage(int page) {
    if (page >= 1 && page <= _totalSellOrdersPages && page != _currentSellOrdersPage && _selectedSymbol.isNotEmpty) {
      _fetchSellOrders(_selectedSymbol, pageSize: _currentSellOrdersPageSize, append: false);
    }
  }

  void _goToBuyOrdersPage(int page) {
    if (page >= 1 && page <= _totalBuyOrdersPages && page != _currentBuyOrdersPage && _selectedSymbol.isNotEmpty) {
      _fetchBuyOrders(_selectedSymbol, pageSize: _currentBuyOrdersPageSize, append: false);
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
    _liveOhlcSubscription?.cancel();
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
  _loadChartData(_assets[newIndex]['symbol']);
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
  _loadChartData(_assets[newIndex]['symbol']);
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
                                  final minChartHeight = 100.0;
                                  final maxMarketOverviewHeight = (maxMiddleHeight - minChartHeight).clamp(minMarketOverviewHeight, double.infinity);

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
        color: _isDarkTheme ? Colors.black : Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          // Market Row - Label and Dropdown on same line
          Row(
            children: [
              SizedBox(
                width: 60,
                child: Text(
                  'Market',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: _HoverDropdownField(
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
                            // Clear venue dropdown items before fetching new venues
                            _venues = [{'id': '', 'display': 'All Venues'}];
                            _selectedVenue = _venues.first;
                          });
                          // Load venues for the selected market
                          await _fetchVenues(newValue['id']!);
                          // Load instruments for the selected market
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
              ),
            ],
          ),

          const SizedBox(height: 10), // Space between rows

          // Venue Row - Label and Dropdown on same line
          Row(
            children: [
              SizedBox(
                width: 60,
                child: Text(
                  'Venue',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: _HoverDropdownField(
                  isDarkTheme: _isDarkTheme,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Map<String, String>>(
                      value: _venues.isEmpty
                          ? null
                          : (_venues.any((venue) => venue['id'] == _selectedVenue['id'])
                              ? _selectedVenue
                              : _venues.isNotEmpty ? _venues.first : null),
                      isExpanded: true,
                      onChanged: _venues.isEmpty ? null : (Map<String, String>? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedVenue = newValue;
                          });
                          // TODO: Filter instruments by venue if needed
                          print('📍 Selected venue: ${newValue['display']} (${newValue['id']})');
                        }
                      },
                      dropdownColor: _isDarkTheme ? const Color(0xFF1e1e1e) : Colors.white,
                      style: TextStyle(
                        color: _isDarkTheme ? Colors.white : Colors.black,
                        fontSize: 14,
                      ),
                      items: _venues.isEmpty
                          ? [DropdownMenuItem<Map<String, String>>(
                              value: {'id': '', 'display': 'All Venues'},
                              child: Text(_isLoadingVenues ? 'Loading venues...' : 'All Venues'),
                            )]
                          : _venues.map<DropdownMenuItem<Map<String, String>>>((venue) {
                              return DropdownMenuItem<Map<String, String>>(
                                value: venue,
                                child: Text(venue['display'] ?? 'All Venues'),
                              );
                            }).toList(),
                    ),
                  ),
                ),
              ),
            ],
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
                        SizedBox(height: 20),
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
                    height: 70,
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
                                    _loadChartData(asset['symbol']);
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
              onPressed: () => _loadChartData(_selectedSymbol),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_candles.isEmpty) {
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
              onPressed: () => _loadChartData(_selectedSymbol),
              child: const Text('Load Chart'),
            ),
          ],
        ),
      );
    }

    // Display candlestick chart
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Symbol and current price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedSymbol,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDarkTheme ? Colors.white : Colors.black,
                ),
              ),
              if (_candles.isNotEmpty)
                Text(
                  '\$${_candles.first.close.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          // Candlestick chart
          Expanded(
            child: _isLoadingChart
                ? const Center(child: CircularProgressIndicator())
                : _chartError.isNotEmpty
                    ? Center(
                        child: Text(
                          _chartError,
                          style: const TextStyle(color: Colors.red),
                        ),
                      )
                    : _candles.length < 14
                        ? Center(
                            child: Text(
                              'Insufficient data to display chart\n(${_candles.length} candles available, minimum 14 required)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDarkTheme ? Colors.white70 : Colors.black54,
                              ),
                            ),
                          )
                        : Candlesticks(
                            candles: _candles,
                          ),
          ),
          const SizedBox(height: 16),
          // Time period buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTimePeriodButton('1m', isDarkTheme),
              const SizedBox(width: 4),
              _buildTimePeriodButton('5m', isDarkTheme),
              const SizedBox(width: 4),
              _buildTimePeriodButton('15m', isDarkTheme),
              const SizedBox(width: 4),
              _buildTimePeriodButton('1h', isDarkTheme),
              const SizedBox(width: 4),
              _buildTimePeriodButton('1d', isDarkTheme),
            ],
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
          // Load new data for selected period
          _loadChartData(_selectedSymbol);
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
                      width: 75,
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
                  // Show more button
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
                              '+ Show More',
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
                  margin: const EdgeInsets.only(bottom: 4),
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 75,
                        child: Text(
                          trade['price'].toString(),
                          style: TextStyle(
                            color: isDarkTheme ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
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
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          trade['time'].toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
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
          Expanded(
            child: Column(
              children: [
                // Sell Orders Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sell Orders Title
                      Text(
                        'Sell Orders',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkTheme ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Sell Orders Headers
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
                      // Sell Orders List
                      Expanded(
                        child: _buildOrderbookSide(isDarkTheme, 'sell'),
                      ),
                      // Show More Button for Sell Orders (Centered)
                      Center(child: _buildShowMoreButton(isDarkTheme, 'sell')),
                    ],
                  ),
                ),

                // Spacing between sections
                const SizedBox(height: 16),

                // Buy Orders Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Buy Orders Title
                      Text(
                        'Buy Orders',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkTheme ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Buy Orders Headers
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
                      // Buy Orders List
                      Expanded(
                        child: _buildOrderbookSide(isDarkTheme, 'buy'),
                      ),
                      // Show More Button for Buy Orders (Centered)
                      Center(child: _buildShowMoreButton(isDarkTheme, 'buy')),
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

  Widget _buildOrderbookSide(bool isDarkTheme, String side) {
    // Use real data from _sellOrders and _buyOrders
    final orders = side == 'sell' ? _sellOrders : _buyOrders;
    final isLoading = side == 'sell' ? _isLoadingSellOrders : _isLoadingBuyOrders;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (orders.isEmpty) {
      return Center(
        child: Text(
          'No ${side} orders',
          style: TextStyle(
            color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
            fontSize: 14,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        final color = side == 'sell' ? const Color(0xFFFF4081) : const Color(0xFF00D4AA);

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _formatPrice(order['price']),
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
                  order['quantity'].toString(),
                  style: TextStyle(
                    color: isDarkTheme ? Colors.white : Colors.black,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  _formatPrice(order['total'] ?? 0.0),
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

  /// Build Show More button for orderbook sections
  Widget _buildShowMoreButton(bool isDarkTheme, String side) {
    final hasMore = side == 'sell' ? _hasMoreSellOrders : _hasMoreBuyOrders;
    final isLoadingMore = side == 'sell' ? _isLoadingMoreSellOrders : _isLoadingMoreBuyOrders;
    final currentPageSize = side == 'sell' ? _currentSellOrdersPageSize : _currentBuyOrdersPageSize;

    if (!hasMore) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: StatefulBuilder(
        builder: (context, setState) {
          bool isHovered = false;

          return MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: GestureDetector(
              onTap: isLoadingMore ? null : () {
                print('Show more ${side} orders clicked - increasing page size from $currentPageSize to ${currentPageSize + 5}');
                if (side == 'sell') {
                  _fetchSellOrders(_selectedSymbol, pageSize: currentPageSize + 5, append: true);
                } else {
                  _fetchBuyOrders(_selectedSymbol, pageSize: currentPageSize + 5, append: true);
                }
              },
              child: isLoadingMore
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isHovered
                            ? Colors.blue.withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add,
                            color: isHovered ? Colors.blue[700] : Colors.blue,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Show More',
                            style: TextStyle(
                              color: isHovered ? Colors.blue[700] : Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          );
        },
      ),
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
        case 'Filled': return Colors.green;
        case 'Cancelled': return Colors.red;
        case 'Expired': return Colors.orange;
        case 'Active': return const Color(0xFF000080);
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
                    color: Colors.red,
                    onTap: () {
                      _cancelOrder(order['participantOrderId']?.toString() ?? '');
                    },
                  ),
                ),
                const SizedBox(width: 2),
                Expanded(
                  child: _HoverButton(
                    text: 'Replace',
                    color: Colors.blue,
                    onTap: () {
                      _replaceOrder(order['participantOrderId']?.toString() ?? '', order);
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
              color: Colors.red,
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
                color: Colors.red,
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
        // Add a load more button at the bottom (always show)
        Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ElevatedButton.icon(
              onPressed: _isLoadingMoreOrders ? null : _loadMoreOrders,
              icon: _isLoadingMoreOrders
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.add, size: 16),
              label: Text(_isLoadingMoreOrders ? 'Loading...' : 'Show More Orders'),
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
                // Add a load more button at the bottom (always show)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: ElevatedButton.icon(
                      onPressed: _isLoadingMoreHistory ? null : _loadMoreHistory,
                      icon: _isLoadingMoreHistory
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.add, size: 16),
                      label: Text(_isLoadingMoreHistory ? 'Loading...' : 'Show More History'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        case 'Filled': return Colors.green;
        case 'Cancelled': return Colors.red;
        case 'Expired': return Colors.orange;
        case 'Active': return const Color(0xFF000080);
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
                              'Price',
                              style: TextStyle(
                                fontSize: 14,
                                color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Quantity',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Total',
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
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: _isDarkTheme ? Colors.white : Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      _formatPrice(order['total'] ?? 0.0),
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
                                                    _fetchSellOrders(_selectedSymbol, pageSize: _currentSellOrdersPageSize + 5, append: true);
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
                              'Price',
                              style: TextStyle(
                                fontSize: 14,
                                color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Quantity',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Total',
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
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: _isDarkTheme ? Colors.white : Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      _formatPrice(order['total'] ?? 0.0),
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
                                                    _fetchBuyOrders(_selectedSymbol, pageSize: _currentBuyOrdersPageSize + 5, append: true);
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

      if (_cachedAccountId == null || _cachedAccountId!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account ID not available'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (_selectedSymbol.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No instrument selected'),
            backgroundColor: Colors.red,
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
          backgroundColor: _isBuySelected ? const Color(0xFF00D4AA) : Colors.red,
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
            backgroundColor: Colors.green,
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
            backgroundColor: Colors.red,
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
          backgroundColor: Colors.red,
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
          backgroundColor: Colors.red,
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
                      onChanged: _supportedCurrencies.isEmpty ? null : (Map<String, String>? newValue) async {
                        if (newValue != null) {
                          setState(() {
                            _selectedCurrency = newValue;
                          });
                          // Fetch fresh cash holdings for the new currency
                          if (_cachedAccountId != null && _cachedAccountId!.isNotEmpty) {
                            await _fetchCashHoldingsForAccount(_cachedAccountId!);
                          }
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
          SizedBox(
            height: 24,
            child: Row(
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
                    height: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                              child: Text(
                                'Max',
                                style: TextStyle(
                                  color: const Color(0xFFFF4081), // Pink for sell
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
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
                                  fontSize: 14,
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

// Custom painter for simple line chart removed - now using Candlesticks widget

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
