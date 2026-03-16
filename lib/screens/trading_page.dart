
import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/ui_constants.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:candlesticks/candlesticks.dart';
import '../services/auth_service.dart';
import '../services/theme_service.dart';
import '../services/real_grpc_client.dart';
import '../services/grpcurl_helper.dart';
import '../services/chart_service.dart';
import '../utils/connectivity_checker.dart';
import '../utils/menu_items_helper.dart';
import '../widgets/base_page.dart';
import '../widgets/styled_data_table.dart';
import '../services/page_state_service.dart';
import '../services/event_subscription_service.dart';

class TradingPage extends StatefulWidget {
  const TradingPage({super.key});

  @override
  State<TradingPage> createState() => _TradingPageState();
}

class _TradingPageState extends State<TradingPage> {
  Future<void> _fetchTradeHistoryForSecurity(String symbol, {int pageNumber = 1}) async {
    print('[TradeHistory] Fetching for symbol: $symbol, pageNumber: $pageNumber, pageSize: $_tradeHistoryPageSize');

    setState(() {
      _isLoadingTradeHistory = true;
    });

    // Find the security data for this symbol
    final security = _securities.firstWhere(
      (s) => s['symbol'] == symbol,
      orElse: () {
        print('[TradeHistory] Security not found for symbol: $symbol');
        setState(() {
          _tradeHistory = [];
          _isLoadingTradeHistory = false;
        });
        return <String, dynamic>{};
      },
    );

    if (security.isEmpty) {
      print('[TradeHistory] Security is empty for symbol: $symbol');
      return;
    }

    final securityIid = security['iid']?.toString() ?? '';
    print('[TradeHistory] securityIid: $securityIid');

    if (securityIid.isEmpty) {
      setState(() {
        _tradeHistory = [];
        _isLoadingTradeHistory = false;
      });
      return;
    }

    try {
      // Call GetSecurityTrades gRPC function
      final result = await GrpcurlHelper.getSecurityTrades(
        securityId: securityIid,
        pageNumber: pageNumber,
        pageSize: _tradeHistoryPageSize,
      );

      List<Map<String, dynamic>> parsedTrades = [];

      if (result['success'] == true && result['output'] != null) {
        final output = result['output'] as Map<String, dynamic>;
        // print('[TradeHistory] gRPC response: $output'); // Commented out - too verbose

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
          final rawPrice = priceValue is String
              ? double.tryParse(priceValue) ?? 0.0
              : (priceValue is num ? priceValue.toDouble() : 0.0);
          final price = rawPrice / 100.0;
          final quantity = quantityValue is String
              ? double.tryParse(quantityValue) ?? 0.0
              : (quantityValue is num ? quantityValue.toDouble() : 0.0);

          // Format timestamp
          final time = (() {
            if (timestampValue == null) return '';
            try {
              DateTime dt;
              if (timestampValue is int) {
                dt = DateTime.fromMillisecondsSinceEpoch(timestampValue * 1000);
              } else if (timestampValue is String) {
                final asInt = int.tryParse(timestampValue);
                if (asInt != null) {
                  dt = DateTime.fromMillisecondsSinceEpoch(asInt * 1000);
                } else {
                  dt = DateTime.parse(timestampValue);
                }
              } else {
                return '';
              }
              return '${dt.month}/${dt.day}/${dt.year.toString().substring(2)} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}';
            } catch (e) {
              print('[TradeHistory] Error parsing timestamp: $e');
              return '';
            }
          })();

          final priceColor = isBuy ? UIConstants.colorAccept : UIConstants.colorReject;

          return {
            'price': price.toStringAsFixed(2),
            'quantity': quantity.toInt().toString(),
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
          _currentTradeHistoryPage = pageNumber;
          // Estimate total pages: if we got a full page, assume there's at least one more
          if (parsedTrades.length == _tradeHistoryPageSize) {
            _totalTradeHistoryPages = pageNumber + 1;
          } else {
            _totalTradeHistoryPages = pageNumber; // This is the last page
          }
          _isLoadingTradeHistory = false;
          print('[TradeHistory] Updated with ${_tradeHistory.length} trades, page $pageNumber of $_totalTradeHistoryPages');
        });
      }
    } catch (e) {
      print('❌ Error fetching trade history for $symbol: $e');
      if (mounted) {
        setState(() {
          _tradeHistory = [];
          _isLoadingTradeHistory = false;
        });
      }
    }
  }
  
  void _goToTradeHistoryPage(int page) {
    if (page >= 1 && page != _currentTradeHistoryPage && _selectedSymbol.isNotEmpty) {
      _fetchTradeHistoryForSecurity(_selectedSymbol, pageNumber: page);
    }
  }

  void _resetAndFetchTradeHistory(String symbol) {
    _currentTradeHistoryPage = 1;
    _totalTradeHistoryPages = 1;
    _fetchTradeHistoryForSecurity(symbol, pageNumber: 1);
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
        const Duration(minutes: 5),
        onTimeout: () {
          print('⏰ GetSupportedCurrencies timed out after 5 minutes');
          return {
            'success': false,
            'output': {'error': 'Request timed out after 5 minutes'},
          };
        },
      );
      
      if (result['success'] == true && result['output'] != null) {
        final output = result['output'] as Map<String, dynamic>;
        final currencies = output['cashTokens'] as List<dynamic>? ?? [];
        
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

            // Fallback: use issueCurrency if identifiers didn't yield a value
            if (currencyValue.isEmpty) {
              currencyValue = currency['issueCurrency'] as String? ?? '';
            }

            // Also extract issueCurrency for matching with SecurityListing.currency
            final issueCurrency = currency['issueCurrency'] as String? ?? '';

            if (currencyValue.isNotEmpty) {
              // Use ISO code (issueCurrency like "EUR") for display, fall back to ticker
              final displayName = issueCurrency.isNotEmpty ? issueCurrency : currencyValue;
              final currencyMap = {
                'code': currencyValue,
                'symbol': issueCurrency.isNotEmpty ? issueCurrency : (currencySymbol.isNotEmpty ? currencySymbol : currencyValue),
                'display': displayName,
                'asset_id': currencyValue, // For compatibility with existing code
                'issueCurrency': issueCurrency,
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
          _allSupportedCurrencies = currencyData;
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

  /// Update the currency dropdown to only show currencies that have listings for the given security.
  /// Fetches currencies from CashTokenService if not yet loaded.
  Future<void> _updateCurrenciesForSecurity(String symbol) async {
    // Fetch currencies from server if not yet loaded
    if (_allSupportedCurrencies.isEmpty) {
      await _fetchSupportedCurrencies();
    }

    final availableCurrencies = _securityCurrencies[symbol] ?? {};
    print('💱 Filtering currencies for $symbol: available=$availableCurrencies');

    if (availableCurrencies.isEmpty) {
      return;
    }

    setState(() {
      // Match by code, issueCurrency, or prefix
      // SecurityListing.currency is e.g. "EUR", while CashToken code might be "EUR_THIRD_BROKER"
      _supportedCurrencies = _allSupportedCurrencies
          .where((c) {
            final code = c['code'] ?? '';
            final issueCurr = c['issueCurrency'] ?? '';
            return availableCurrencies.contains(code) ||
                   availableCurrencies.contains(issueCurr) ||
                   availableCurrencies.any((ac) => code.startsWith(ac) || ac.startsWith(code));
          })
          .toList();

      // Reset selected currency if it's no longer in the filtered list
      if (_supportedCurrencies.isNotEmpty) {
        final stillValid = _supportedCurrencies.any((c) => c['code'] == _selectedCurrency['code']);
        if (!stillValid) {
          _selectedCurrency = _supportedCurrencies.first;
        }
      }
    });

    print('💱 Filtered to ${_supportedCurrencies.length} currencies for $symbol');

    // Update buying power for the (potentially new) selected currency
    if (_cachedHoldings != null) {
      _updateBuyingPowerFromCachedData();
      setState(() {});
    } else {
      // Holdings not cached yet — fetch them (also handles investor ID lookup)
      _fetchCashHoldings();
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
        const Duration(minutes: 5),
        onTimeout: () {
          print('⏰ GetMarketList timed out after 5 minutes');
          return {
            'success': false,
            'output': {'error': 'Request timed out after 5 minutes'},
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

            // Fallback to iid if identifiers didn't yield a value
            if (marketId == null || marketId.isEmpty) {
              marketId = market['iid']?.toString();
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

        // Load venues and securities for the first market if available
        if (_selectedMarket.isNotEmpty && _selectedMarket['id']!.isNotEmpty) {
          await _fetchVenues(_selectedMarket['id']!);
          _fetchMarketSecurities(_selectedMarket['id']!);
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

  /// Fetch venues (optionally filtered by market)
  Future<void> _fetchVenues(String marketId) async {
    if (_isLoadingVenues) return;

    setState(() {
      _isLoadingVenues = true;
    });

    try {
      print('🏟️ Fetching venues for market: $marketId...');

      // Fetch all venues (no market filter) since the server may not support filtering by market
      final result = await realGrpcClient.getVenueList().timeout(
        const Duration(minutes: 5),
        onTimeout: () {
          print('⏰ GetVenueList timed out after 5 minutes');
          return {
            'success': false,
            'output': {'error': 'Request timed out after 5 minutes'},
          };
        },
      );

      print('🏟️ GetVenueList result: success=${result['success']}, output keys=${result['output']?.keys?.toList()}');

      if (result['success'] == true && result['output'] != null) {
        final output = result['output'];
        print('🏟️ GetVenueList output: $output');
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

            // Fallback to iid if identifiers didn't yield a value
            if (venueValue.isEmpty) {
              venueValue = venue['iid']?.toString() ?? '';
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

  /// Fetch securities for a specific market
  Future<void> _fetchMarketSecurities(String marketId) async {
    try {
      print('🏪 Fetching securities for market: $marketId');
      
      setState(() {
        _isLoadingMarketSecurities = true;
        _securities.clear(); // Clear existing assets
        _selectedSymbol = ''; // Reset selected symbol
      });
      
      final result = await realGrpcClient.getMarketSecurityList(
        marketId: marketId,
        pageNumber: 0,
        pageSize: 0,
      ).timeout(
        const Duration(minutes: 5),
        onTimeout: () {
          print('⏰ GetMarketSecurityList timed out after 5 minutes');
          return {
            'success': false,
            'output': {'error': 'Request timed out after 5 minutes'},
          };
        },
      );
      
      print('🏪 GetSecurityListingList result: success=${result['success']}, output keys=${result['output']?.keys?.toList()}');

      if (result['success'] == true && result['output'] != null) {
        final output = result['output'] as Map<String, dynamic>;
        print('🏪 GetSecurityListingList output keys: ${output.keys.toList()}');
        final securities = output['securityListings'] as List<dynamic>? ?? [];
        print('🏪 Found ${securities.length} security listings');

        final List<Map<String, dynamic>> processedSecurities = [];
        final addedSymbols = <String>{}; // Track symbols to prevent duplicates
        final securityCurrenciesMap = <String, Set<String>>{}; // symbol → currencies

        for (final security in securities) {
          if (security is Map<String, dynamic>) {
            // Extract fields from flat SecurityListing structure
            String symbol = security['symbol'] as String? ?? '';
            String description = symbol;

            // Fallback: try identifiers structure if flat fields are empty
            if (symbol.isEmpty) {
              final identifiers = security['identifiers'] as List<dynamic>? ?? [];
              if (identifiers.isNotEmpty) {
                final identifier = identifiers[0] as Map<String, dynamic>? ?? {};
                final ids = identifier['ids'] as List<dynamic>? ?? [];
                if (ids.isNotEmpty) {
                  final idObj = ids[0] as Map<String, dynamic>? ?? {};
                  symbol = idObj['value'] as String? ?? '';
                }
              }
              final displayNames = security['displayNames'] as Map<String, dynamic>? ?? {};
              description = displayNames['en'] as String? ?? symbol;
            }

            final iid = security['securityListingIid']?.toString() ?? security['security_listing_iid']?.toString() ?? '';
            final issueCurrency = security['currency'] as String? ?? security['issueCurrency']?.toString() ?? '';

            // security_status is FIX Tag 965 — proto field name is security_status, JSON key is securityStatus
            final securityStatus = security['securityStatus'] as String? ?? security['security_status'] as String? ?? '';
            print('🏪 Security: symbol=$symbol, currency=$issueCurrency, status=$securityStatus');

            // Track which currencies each active symbol has listings for
            if (symbol.isNotEmpty && issueCurrency.isNotEmpty) {
              // Only track currencies for active listings (or if status is empty/unknown, include them)
              if (securityStatus.isEmpty || securityStatus.toUpperCase() == 'ACTIVE' || securityStatus == '1') {
                securityCurrenciesMap.putIfAbsent(symbol, () => {}).add(issueCurrency);
              }
            }

            // Only show active listings on the trading page
            // FIX Tag 965 values: 1=Active, 2=Inactive — also handle string "ACTIVE"/"INACTIVE"
            if (securityStatus.isNotEmpty && securityStatus.toUpperCase() != 'ACTIVE' && securityStatus != '1') {
              continue;
            }

            if (symbol.isNotEmpty && !addedSymbols.contains(symbol)) {
              addedSymbols.add(symbol);
              final securityMap = {
                'symbol': symbol,
                'description': description,
                'exchangePairId': iid,
                'price': '0.00',
                'change': '0.00',
                'changePercent': '0.00%',
                'coverAddress': 'https://picsum.photos/112/120?random=${processedSecurities.length}',
                'last': 0.0,
                'orderbook': '',
                'quoteTokenDecimal': 8, // Default decimal places
                'issueCurrency': issueCurrency,
                'iid': iid,
              };
              processedSecurities.add(securityMap);
            }
          }
        }

        print('🏪 Security currencies map: $securityCurrenciesMap');
        
        setState(() {
          _securities.clear();
          _securities.addAll(processedSecurities);
          _securityCurrencies = securityCurrenciesMap;
          if (_selectedSymbol.isEmpty && _securities.isNotEmpty) {
            _selectedSymbol = _securities.first['symbol'];
            // Load chart immediately when symbol is first set
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _loadChartData(_selectedSymbol);
            });
          }
          _isLoadingMarketSecurities = false;
        });

        // Fetch and filter currencies for the selected security
        if (_selectedSymbol.isNotEmpty) {
          await _updateCurrenciesForSecurity(_selectedSymbol);
        }

        print('✅ Loaded ${_securities.length} securities for market $marketId');
        if (_securities.isNotEmpty) {
          print('📋 Sample securities: ${_securities.take(3).map((a) => a['symbol']).toList()}');
          
          // Fetch last prices for the loaded securities
          for (final security in _securities) {
            _fetchLastPriceForSecurity(security);
          }
          
          // Load trade history and orderbook for the first security
          if (_selectedSymbol.isNotEmpty) {
            _fetchTradeHistoryForSecurity(_selectedSymbol, pageNumber: 1);
            _fetchOrderbookData(_selectedSymbol);
          }
        }
      } else {
        print('❌ Failed to fetch securities for market $marketId: ${result['output']}');
        setState(() {
          _securities.clear();
          _isLoadingMarketSecurities = false;
        });
      }
    } catch (e) {
      print('❌ Error fetching securities for market $marketId: $e');
      setState(() {
        _securities.clear();
        _isLoadingMarketSecurities = false;
      });
    }
  }

  /// Extract available balance from a holding entry.
  /// Proto Holdings has total_units and stash_units (map). No availableUnits field.
  /// Stash keys can be lowercase (available/locked) or uppercase (LIQUID/LOCKED/TOTAL).
  String _getAvailableFromHolding(Map<String, dynamic> holdingData) {
    final stashUnits = holdingData['stashUnits'] as Map<String, dynamic>? ??
        holdingData['stash_units'] as Map<String, dynamic>? ?? {};
    if (stashUnits.containsKey('available')) {
      return stashUnits['available']?.toString() ?? '0';
    }
    if (stashUnits.containsKey('LIQUID')) {
      return stashUnits['LIQUID']?.toString() ?? '0';
    }
    return holdingData['totalUnits']?.toString() ??
        holdingData['total_units']?.toString() ?? '0';
  }

  /// Default divisibility for known fiat currencies when server doesn't return it.
  String _defaultDivisibility(String currencyCode) {
    final code = currencyCode.toUpperCase();
    final shortCode = code.length >= 3 ? code.substring(0, 3) : code;
    const zeroDivisibility = {'JPY', 'KRW', 'VND', 'CLP'};
    if (zeroDivisibility.contains(shortCode)) return '0';
    const threeDivisibility = {'BHD', 'KWD', 'OMR'};
    if (threeDivisibility.contains(shortCode)) return '3';
    return '2';
  }

  /// Format an amount using divisibility (decimal places).
  String _formatAmount(String rawAmount, String? divisibility) {
    if (divisibility == null || divisibility.isEmpty) {
      return rawAmount;
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

  /// Find a holding entry by currency code, trying multiple matching strategies.
  /// [currencyCode] is the issueCurrency (ISO code like "EUR").
  /// Also tries the full ticker from _selectedCurrency['code'] (e.g. "EUR_TOKENISE_BROKER").
  Map<String, dynamic> _findHoldingForCurrency(Map<String, dynamic> holdings, String currencyCode) {
    // 1. Direct key lookup by ISO code (e.g. "EUR")
    if (holdings.containsKey(currencyCode)) {
      return holdings[currencyCode] as Map<String, dynamic>? ?? {};
    }
    // 2. Direct key lookup by ticker code (e.g. "EUR_TOKENISE_BROKER")
    final ticker = _selectedCurrency['code'] ?? '';
    if (ticker.isNotEmpty && holdings.containsKey(ticker)) {
      return holdings[ticker] as Map<String, dynamic>? ?? {};
    }
    // 3. Scan entries for matching currencyCode field (in case map is keyed by IID)
    for (final entry in holdings.entries) {
      final data = entry.value as Map<String, dynamic>? ?? {};
      if (data['currencyCode'] == currencyCode || data['currencyCode'] == ticker) {
        return data;
      }
    }
    // 4. Case-insensitive prefix match (e.g. key "eur" matches "EUR")
    final lowerCode = currencyCode.toLowerCase();
    for (final entry in holdings.entries) {
      if (entry.key.toLowerCase() == lowerCode || entry.key.toLowerCase().startsWith('${lowerCode}_')) {
        return entry.value as Map<String, dynamic>? ?? {};
      }
    }
    return {};
  }

  /// Update buying power from cached holdings data when currency changes
  void _updateBuyingPowerFromCachedData() {
    if (_cachedHoldings == null || _selectedCurrency.isEmpty) {
      _buyingPower = '0';
      return;
    }

    // Use issueCurrency (ISO code like "EUR") to match holdings keys, not ticker
    final issueCurrency = _selectedCurrency['issueCurrency'] ?? _selectedCurrency['code'] ?? '';
    final currencyHolding = _findHoldingForCurrency(_cachedHoldings!, issueCurrency);
    final rawBalance = _getAvailableFromHolding(currencyHolding);

    // Apply divisibility formatting
    final divisibility = _defaultDivisibility(issueCurrency);
    _buyingPower = _formatAmount(rawBalance, divisibility);
    print('✅ Updated buying power from cache for $issueCurrency: $_buyingPower (raw=$rawBalance, div=$divisibility)');
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
        print('❌ No security selected for portfolio');
        return;
      }

      // Extract security ID from selected symbol (e.g., "ETH/USD" -> "ETH")
      final securityId = _selectedSymbol.split('/').first;

      print('📨 GetAccountMarketPortfolio REQUEST:');
      print('   account_id: ${_cachedAccountId!}');
      print('   market_id: $marketId');
      print('   asset_ids: [$securityId]');

      final portfolioResponse = await realGrpcClient.getAccountMarketPortfolio(
        accountId: _cachedAccountId!,
        marketId: marketId,
        securityIds: [securityId],
      ).timeout(const Duration(minutes: 5));

      print('📬 GetAccountMarketPortfolio RESPONSE: ${portfolioResponse.toString()}');

      if (portfolioResponse['success'] == true && portfolioResponse['output'] != null) {
        final output = portfolioResponse['output'] as Map<String, dynamic>;

        // Look for balance in the response
        // Proto: GetInvestorSecurityHoldingsResponse { portfolio: Portfolio { holdings: map<string, Holdings> } }
        // Holdings { instrument_iid, total_units, stash_units }
        String balance = '0';

        if (output['portfolio'] != null) {
          final portfolio = output['portfolio'] as Map<String, dynamic>? ?? {};
          print('📊 Found portfolio section: $portfolio');
          final holdings = portfolio['holdings'] as Map<String, dynamic>? ?? {};
          if (holdings.isNotEmpty) {
            // Try direct key lookup first
            Map<String, dynamic> holdingData = {};
            if (holdings.containsKey(securityId)) {
              holdingData = holdings[securityId] as Map<String, dynamic>? ?? {};
            } else {
              // Scan entries for matching instrumentIid or symbol substring in key
              final lowerSecId = securityId.toLowerCase();
              for (final entry in holdings.entries) {
                final data = entry.value as Map<String, dynamic>? ?? {};
                final instrIid = data['instrumentIid']?.toString() ?? data['instrument_iid']?.toString() ?? '';
                if (instrIid == securityId ||
                    entry.key.toLowerCase().contains(lowerSecId) ||
                    instrIid.toLowerCase().contains(lowerSecId)) {
                  holdingData = data;
                  break;
                }
              }
            }
            balance = _getAvailableFromHolding(holdingData);
            print('✅ Extracted balance for $securityId: $balance');
          }
        }

        // Apply divisibility formatting (security holdings are typically whole units, divisibility 0)
        final formattedBalance = _formatAmount(balance, '0');

        setState(() {
          _availableBalance = formattedBalance;
        });

        print('✅ Updated available balance for $securityId: $formattedBalance (raw=$balance, market: $marketId)');
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
  
  final List<Map<String, dynamic>> _securities = [];
  List<Map<String, dynamic>> _tradeHistory = [];
  String _selectedSymbol = '';  // Will be set when securities are loaded
  String _orderType = 'Limit';
  String _timeInForce = 'DAY';
  String _expiryPeriod = '1 Month'; // Add expiry period variable
  String _replaceExpiryPeriod = 'Select new expiration time'; // Add replace order expiry period variable
  bool _isBuySelected = true;
  
  // Market data
  List<Map<String, String>> _markets = [];
  Map<String, String> _selectedMarket = {};
  bool _isLoadingMarkets = false;
  bool _isLoadingMarketSecurities = false;

  // Venue data
  List<Map<String, String>> _venues = [];
  Map<String, String> _selectedVenue = {'id': '', 'display': 'All Venues'};
  bool _isLoadingVenues = false;

  // Supported currencies data
  List<Map<String, String>> _supportedCurrencies = [];
  List<Map<String, String>> _allSupportedCurrencies = []; // All currencies from CashTokenService
  Map<String, String> _selectedCurrency = {};
  bool _isLoadingSupportedCurrencies = false;

  // Map of security symbol → set of currencies it has listings for
  Map<String, Set<String>> _securityCurrencies = {};
  
  // Trade history pagination
  int _currentTradeHistoryPage = 1;
  static const int _tradeHistoryPageSize = 15;
  int _totalTradeHistoryPages = 1;
  bool _isLoadingTradeHistory = false;
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _feeController = TextEditingController();
  bool _feeManuallyEdited = false;
  final TextEditingController _orderIdController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _replaceOrderIdController = TextEditingController();
  final TextEditingController _newOrderIdController = TextEditingController();
  final TextEditingController _newQuantityController = TextEditingController();
  final TextEditingController _newPriceController = TextEditingController();
  final TextEditingController _replaceReasonController = TextEditingController();
  
  // Cash holdings data
  bool _isLoadingCashHoldings = false;
  String _buyingPower = '0'; // Default fallback value
  String _availableBalance = '0'; // For sell orders - available security balance
  String? _cachedAccountId; // Cache account ID for entire session (doesn't change until logout)
  Map<String, dynamic>? _cachedHoldings; // Cache all holdings data

  // Order fee calculation
  bool _isLoadingFee = false;
  String _estimatedFee = '';
  String _lastAutoFee = '';
  Timer? _feeDebounceTimer;
  
  // Message stream subscription
  StreamSubscription<String>? _messageSubscription;
  StreamSubscription<bool>? _connectionStatusSubscription;
  StreamSubscription<bool>? _logonStatusSubscription;
  bool _hasRequestedSecurityDefinitions = false;
  Timer? _securityRequestTimeout;
  Timer? _orderbookRefreshTimer;
  Timer? _ordersRefreshTimer;
  Timer? _tradeHistoryRefreshTimer;

  // Panel width variables for resizable panels
  double _leftPanelWidth = 329.0;
  double _rightPanelWidth = 362.0;
  bool _isDraggingLeft = false;
  bool _isDraggingRight = false;
  
  // Panel height variables for resizable horizontal sections
  double _orderbookHeight = 150.0; // Default orderbook height
  bool _isDraggingHorizontal = false;
  double _marketOverviewHeight = 100.0;
  bool _isDraggingMarketOverview = false; // State for market splitter

  // Bottom section width split (Orders vs Orderbook)
  double _bottomOrdersWidth = 0.71; // 71% for Orders, 29% for Orderbook
  bool _isDraggingBottomSplit = false;

  // Top/Bottom section height split
  double _topSectionRatio = 0.61; // 61% for top, 39% for bottom
  bool _isDraggingTopBottomSplit = false;

  // Activity section tabs
  int _activityTabIndex = 0;
  final List<String> _activityTabNames = ['Orderbook', 'Trade History'];

  // Orders section tabs
  int _ordersTabIndex = 0; // 0 = Orders (default), 1 = History
  final List<String> _ordersTabNames = ['Orders', 'History'];

  // Real orders data from GetAccountOrders API
  List<Map<String, dynamic>> _realOrders = [];
  bool _isLoadingRealOrders = false;
  String? _realOrdersError;

  // Order history data (filled, expired, cancelled orders from GetAccountOrders)
  List<Map<String, dynamic>> _orderHistory = [];

  // Pagination variables for orders and history (client-side)
  int _ordersCurrentPage = 1;
  int _historyCurrentPage = 1;
  static const int _ordersPerPage = 10;
  static const int _historyPerPage = 10;

  // Chart data variables using interactive_chart package
  List<Candle> _candles = [];
  bool _isLoadingChart = false;
  String _chartError = '';
  String _selectedTimePeriod = '1h'; // Default period
  ChartService? _chartService;
  Timer? _liveOhlcSubscription;
  int _chartRebuildKey = 0; // Key to force chart rebuild
  
  // Orderbook mode
  String _orderbookMode = 'ORDERBOOK_MODE_ENUM_L2_AGGREGATED_PRICE_LEVELS';
  static const _orderbookModeOptions = <String, String>{
    'ORDERBOOK_MODE_ENUM_L1_BEST_BID_ASK': 'L1 Best Bid/Ask',
    'ORDERBOOK_MODE_ENUM_L2_AGGREGATED_PRICE_LEVELS': 'L2 Aggregated',
    'ORDERBOOK_MODE_ENUM_L3_INDIVIDUAL_ORDERS': 'L3 Individual Orders',
    'ORDERBOOK_MODE_ENUM_CUMULATIVE_DEPTH': 'Cumulative Depth',
    'ORDERBOOK_MODE_ENUM_ACTUAL': 'Actual',
  };

  // Orderbook data variables
  List<Map<String, dynamic>> _sellOrders = [];
  List<Map<String, dynamic>> _buyOrders = [];
  bool _isLoadingSellOrders = false;
  bool _isLoadingBuyOrders = false;

  // Orderbook pagination
  int _currentSellOrdersPage = 1;
  int _currentBuyOrdersPage = 1;
  static const int _orderbookPageSize = 5;
  int _totalSellOrdersPages = 1;
  int _totalBuyOrdersPages = 1;


  static const _pageId = 'trading';

  void _savePageState() {
    PageStateService.instance.save(_pageId, {
      'selectedSymbol': _selectedSymbol,
      'selectedMarket': _selectedMarket,
      'selectedVenue': _selectedVenue,
      'selectedCurrency': _selectedCurrency,
      'orderbookMode': _orderbookMode,
      'isBuySelected': _isBuySelected,
      'orderType': _orderType,
      'timeInForce': _timeInForce,
      'expiryPeriod': _expiryPeriod,
      'selectedTimePeriod': _selectedTimePeriod,
      'activityTabIndex': _activityTabIndex,
      'ordersTabIndex': _ordersTabIndex,
      'quantity': _quantityController.text,
      'price': _priceController.text,
    });
  }

  void _restorePageState() {
    final state = PageStateService.instance.get(_pageId);
    if (state != null) {
      _selectedSymbol = state['selectedSymbol'] ?? '';
      if (state['selectedMarket'] is Map) {
        _selectedMarket = Map<String, String>.from(state['selectedMarket']);
      }
      if (state['selectedVenue'] is Map) {
        _selectedVenue = Map<String, String>.from(state['selectedVenue']);
      }
      if (state['selectedCurrency'] is Map) {
        _selectedCurrency = Map<String, String>.from(state['selectedCurrency']);
      }
      _orderbookMode = state['orderbookMode'] ?? 'ORDERBOOK_MODE_ENUM_L2_AGGREGATED_PRICE_LEVELS';
      _isBuySelected = state['isBuySelected'] ?? true;
      _orderType = state['orderType'] ?? 'Limit';
      _timeInForce = state['timeInForce'] ?? 'DAY';
      _expiryPeriod = state['expiryPeriod'] ?? '1 Month';
      _selectedTimePeriod = state['selectedTimePeriod'] ?? '1h';
      _activityTabIndex = state['activityTabIndex'] ?? 0;
      _ordersTabIndex = state['ordersTabIndex'] ?? 0;
      if (state['quantity'] != null && (state['quantity'] as String).isNotEmpty) {
        _quantityController.text = state['quantity'];
      }
      if (state['price'] != null && (state['price'] as String).isNotEmpty) {
        _priceController.text = state['price'];
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _restorePageState();

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
    _feeController.addListener(() {
      if (_feeController.text.isEmpty) {
        _feeManuallyEdited = false;
        _calculateOrderFees();
      } else if (_feeController.text != _lastAutoFee) {
        _feeManuallyEdited = true;
      }
      setState(() {});
    });

    // Fetch pairs from API immediately when page opens, independent of FIX connection
    // _fetchPairsFromAPI(); // Disabled - now using GetMarketSecurityList based on selected market
    
    // Fetch cash holdings for buying power
    _fetchCashHoldings();
    
    // Fetch market list for the dropdown
    _fetchMarketList();
    
    // Currencies are fetched after a security is selected (not at page load)

      // Fetch trade history, orderbook, and chart for default symbol when page is shown and assets are loaded
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_selectedSymbol.isNotEmpty) {
          _loadChartData(_selectedSymbol);
          _resetAndFetchTradeHistory(_selectedSymbol);
          _fetchOrderbookData(_selectedSymbol);
        }
        _startOrderbookRefreshTimer();
        _startOrdersRefreshTimer();
        _startTradeHistoryRefreshTimer();
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
    print('🔍 Searching for investor matching user: "$username"');
    print('📋 Available investors (${accounts.length}):');

    for (int i = 0; i < accounts.length; i++) {
      final accountMap = accounts[i] as Map<String, dynamic>;
      // Proto Investor: iid (field 1), external_investor_id (field 3) -> JSON: iid, externalInvestorId
      final externalId = accountMap['externalInvestorId'] ?? accountMap['external_investor_id'] ?? accountMap['externalId'] ?? accountMap['external_id'] ?? accountMap['externalAccountId'] ?? '';
      final accountId = accountMap['iid'] ?? accountMap['id'] ?? '';
      print('   [$i] IID: "$accountId", ExternalInvestorId: "$externalId"');

      // Try exact match first (case-sensitive)
      if (externalId == username) {
        print('✅ Found EXACT match for user "$username": IID="$accountId", ExternalInvestorId="$externalId"');
        return accountId;
      }
    }

    // If no exact match, try case-insensitive
    for (final account in accounts) {
      final accountMap = account as Map<String, dynamic>;
      final externalId = accountMap['externalInvestorId'] ?? accountMap['external_investor_id'] ?? accountMap['externalId'] ?? accountMap['external_id'] ?? accountMap['externalAccountId'] ?? '';
      final accountId = accountMap['iid'] ?? accountMap['id'] ?? '';
      
      if (externalId.toLowerCase() == username.toLowerCase()) {
        print('✅ Found case-insensitive match for user "$username": ID="$accountId", ExternalID="$externalId"');
        return accountId;
      }
    }
    
    // If still no match, try contains
    for (final account in accounts) {
      final accountMap = account as Map<String, dynamic>;
      final externalId = accountMap['externalInvestorId'] ?? accountMap['external_investor_id'] ?? accountMap['externalId'] ?? accountMap['external_id'] ?? accountMap['externalAccountId'] ?? '';
      final accountId = accountMap['iid'] ?? accountMap['id'] ?? '';

      if (externalId.toLowerCase().contains(username.toLowerCase()) ||
          accountId.toLowerCase().contains(username.toLowerCase())) {
        print('⚠️ Found partial match for user "$username": IID="$accountId", ExternalInvestorId="$externalId"');
        return accountId;
      }
    }

    // If no match found for the logged-in user, return empty string
    print('❌ No investor found for user "$username" on the server');
    print('🔍 Searched in ${accounts.length} investors');
    return '';
  }

  /// Fetch cash holdings for the logged-in user to get buying power.
  /// Uses the logged-in username directly as the investor ID
  /// (same approach as portfolio page).
  Future<void> _fetchCashHoldings() async {
    try {
      // Check if we already have cached account ID
      if (_cachedAccountId != null &&
          _cachedAccountId!.isNotEmpty &&
          !_isLoadingCashHoldings) {
        print('✅ Using cached account ID for fresh cash holdings: $_cachedAccountId');
        await _fetchCashHoldingsForInvestor(_cachedAccountId!);
        return;
      }

      setState(() {
        _isLoadingCashHoldings = true;
      });

      // Use the logged-in username directly as the investor ID (external_investor_id)
      final authService = Provider.of<AuthService>(context, listen: false);
      final currentUsername = authService.username;

      if (currentUsername.isEmpty) {
        setState(() {
          _isLoadingCashHoldings = false;
          _buyingPower = '0';
        });
        print('❌ No logged-in user found');
        return;
      }

      _cachedAccountId = currentUsername;
      print('✅ Using logged-in username as investor ID: $_cachedAccountId');

      // Fetch real orders now that we have the account ID
      _fetchRealOrders();

      await _fetchCashHoldingsForInvestor(currentUsername);
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

  /// Fetch cash holdings for a specific investor ID
  Future<void> _fetchCashHoldingsForInvestor(String investorId) async {
    try {
      final issueCurrency = _selectedCurrency.isNotEmpty ? (_selectedCurrency['issueCurrency'] ?? _selectedCurrency['code'] ?? 'USD') : 'USD';

      print('📋 Fetching ALL cash holdings (will look up $issueCurrency / ${_selectedCurrency['code']})');

      // Fetch ALL cash holdings without currency filter — the filter may not match
      // the server's key format, causing empty results. Instead, fetch everything
      // and look up the right entry client-side (same approach as portfolio page).
      final cashHoldingsResponse = await realGrpcClient.getInvestorCashHoldings(
        investorId: investorId,
      ).timeout(
        const Duration(minutes: 5),
        onTimeout: () => {
          'input': {'ref_request_id': 'timeout'},
          'output': {'error': 'Request timed out', 'message': 'Cash holdings request timed out after 5 minutes'},
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
          print('🔍 DEBUG cash holdings output keys: ${output.keys.toList()}');
          print('🔍 DEBUG cash holdings full output: $output');
          final cashPortfolio = output['cashPortfolio'] as Map<String, dynamic>? ?? {};
          print('🔍 DEBUG cashPortfolio keys: ${cashPortfolio.keys.toList()}');
          final holdings = cashPortfolio['holdings'] as Map<String, dynamic>? ?? {};
          print('🔍 DEBUG holdings keys: ${holdings.keys.toList()}');
          for (final entry in holdings.entries) {
            print('🔍 DEBUG holding[${entry.key}] = ${entry.value}');
          }

          // Cache the holdings data for currency switching
          _cachedHoldings = holdings;
          print('✅ Cash holdings cached (keys: ${holdings.keys.toList()})');

          // Only look up buying power if a currency is already selected;
          // otherwise it will be looked up when _updateCurrenciesForSecurity runs.
          if (_selectedCurrency.isNotEmpty) {
            _updateBuyingPowerFromCachedData();
          }

          setState(() {});
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

      final result = await GrpcurlHelper.getInvestorOrders(
        investorId: _cachedAccountId!,
        refRequestId: 'flutter-trading-page-${DateTime.now().millisecondsSinceEpoch}',
        pagination: {
          'page_size': 500,
        },
      ).timeout(const Duration(minutes: 5));

      if (result['success'] == true && result['output'] != null) {
        final output = result['output'];
        // print('📬 GetAccountOrders Response: $output'); // Commented out - too verbose

        if (output['orders'] != null && output['orders'] is List) {
          final List<dynamic> ordersData = output['orders'];

          // Process all orders first
          final allProcessedOrders = ordersData.map<Map<String, dynamic>>((order) {
            print('📋 [Orders] RAW ORDER KEYS: ${(order as Map).keys.toList()}');
            print('📋 [Orders] symbol=${order['symbol']}, securityIid=${order['securityIid']}, securityListingIid=${order['securityListingIid']}');
            print('📋 [Orders] expireTimestamp=${order['expireTimestamp']}, expire_timestamp=${order['expire_timestamp']}, expireAtDt=${order['expireAtDt']}, expire_at_dt=${order['expire_at_dt']}');
            // Extract creation timestamp: prefer explicit field, fall back to first event log
            final eventLogs = order['eventLogs'] ?? order['event_logs'] ?? [];
            String? createTs = order['createTimestamp'] ?? order['createdAtDt']?['ts'] ?? order['create_timestamp'];
            if (createTs == null && eventLogs is List && eventLogs.isNotEmpty) {
              createTs = eventLogs.first['timestamp'] ?? eventLogs.first['ts'];
            }
            return {
              'order_id': order['orderId'] ?? order['orderIid'] ?? order['order_id'] ?? 'N/A',
              'participantOrderId': order['participantOrderId'] ?? order['participant_order_id'] ?? order['orderIid'] ?? order['order_id'] ?? 'N/A',
              'side': order['side'] ?? 'N/A',
              'symbol': _resolveSymbol(order),
              'quantity': order['quantity'] ?? '0',
              'remainingQuantity': order['remainingQuantity'] ?? order['remaining_quantity'] ?? '?',
              'price': order['price'] ?? '0',
              'create_timestamp': createTs,
              'expire_timestamp': _extractExpireTimestamp(order),
              'expire_ts_unit': 'ms',
              'is_filled': order['isFilled'] ?? order['is_filled'] ?? false,
              'is_cancelled': order['isCancelled'] ?? order['is_cancelled'] ?? false,
              'is_expired': order['isExpired'] ?? order['is_expired'] ?? false,
              'order_status': order['orderStatus'] ?? order['order_status'] ?? 'UNKNOWN',
              'order_type': order['orderType'] ?? order['order_type'] ?? 'UNKNOWN',
              'status': order['orderStatus'] ?? order['status'] ?? '',
              'fee_amount': order['feeAmount'] ?? order['fee_amount'] ?? '',
              'event_logs': eventLogs,
              'security_listing_iid': order['securityListingIid'] ?? order['security_listing_iid'] ?? '',
              '_raw': order,
            };
          }).toList();

          // Split orders by status: active vs history
          final activeOrders = <Map<String, dynamic>>[];
          final historyOrders = <Map<String, dynamic>>[];

          // Orders from today go to Orders tab, older ones to History
          final now = DateTime.now();
          final todayStart = DateTime(now.year, now.month, now.day);

          for (final order in allProcessedOrders) {
            // Parse creation timestamp to determine if order is from today
            final createTs = order['create_timestamp']?.toString() ?? '';
            DateTime? createdAt;
            if (createTs.isNotEmpty) {
              // Try parsing as ISO string first, then as epoch ms
              createdAt = DateTime.tryParse(createTs);
              if (createdAt == null) {
                final ms = int.tryParse(createTs);
                if (ms != null) {
                  createdAt = DateTime.fromMillisecondsSinceEpoch(ms > 9999999999 ? ms : ms * 1000);
                }
              }
            }

            final isToday = createdAt != null && createdAt.isAfter(todayStart);

            if (isToday) {
              activeOrders.add(order);
            } else {
              historyOrders.add(order);
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

  void _goToOrdersPage(int page) {
    setState(() {
      _ordersCurrentPage = page;
    });
  }

  void _goToHistoryPage(int page) {
    setState(() {
      _historyCurrentPage = page;
    });
  }

  /// Cancel an order using CancelOrderAsync
  Future<void> _cancelOrder(String participantOrderId) async {
    try {
      print('🚫 Attempting to cancel order: $participantOrderId');

      // Show confirmation dialog
      final themeService = Provider.of<ThemeService>(context, listen: false);
      final isDark = themeService.isDarkTheme;
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: UIConstants.dialogBackground(isDark),
            shape: UIConstants.dialogShape(isDark),
            title: Text('Cancel Order', style: TextStyle(color: UIConstants.textPrimary(isDark))),
            content: Text('Are you sure you want to cancel order $participantOrderId?', style: TextStyle(color: UIConstants.textSecondary(isDark))),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: UIConstants.cancelTextButtonStyle(isDark),
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: UIConstants.dangerButtonStyle(),
                child: const Text('Yes, Cancel'),
              ),
            ],
          );
        },
      );

      if (confirmed != true) return;

      final result = await GrpcurlHelper.cancelOrderAsync(
        participantOrderId: participantOrderId,
        reason: 'User requested cancellation',
        refRequestId: 'flutter-cancel-${DateTime.now().millisecondsSinceEpoch}',
      ).timeout(const Duration(minutes: 5));

      if (result['success'] == true) {
        EventSubscriptionService().notify(
          title: 'Order Cancelled',
          message: 'Cancel request sent',
          icon: Icons.cancel_outlined,
        );
        _fetchRealOrders();
      } else {
        final errorMsg = result['output']?['error'] ?? 'Failed to cancel order';
        _showOrderErrorDialog('Cancel failed', errorMsg);
      }
    } catch (e) {
      _showOrderErrorDialog('Cancel failed', e.toString());
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

      final themeService = Provider.of<ThemeService>(context, listen: false);
      final isDark = themeService.isDarkTheme;

      // Show replace order dialog
      final result = await showDialog<Map<String, dynamic>>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                backgroundColor: UIConstants.dialogBackground(isDark),
                shape: UIConstants.dialogShape(isDark),
                title: Text('Replace Order $participantOrderId', style: TextStyle(color: UIConstants.textPrimary(isDark))),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: quantityController,
                        decoration: UIConstants.appInputDecoration(isDark: isDark, hintText: 'New Quantity'),
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: UIConstants.textPrimary(isDark)),
                      ),
                      const SizedBox(height: UIConstants.spacingMd),
                      TextField(
                        controller: priceController,
                        decoration: UIConstants.appInputDecoration(isDark: isDark, hintText: 'New Price'),
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: UIConstants.textPrimary(isDark)),
                      ),
                      const SizedBox(height: UIConstants.spacingMd),
                      Text(
                        'New Expiration Time (Optional)',
                        style: TextStyle(fontWeight: UIConstants.fontWeightMedium, fontSize: 14, color: UIConstants.textSecondary(isDark)),
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
                          const SizedBox(width: UIConstants.spacingSm),
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
                                    fontSize: UIConstants.fontSizeSm,
                                    color: UIConstants.textSecondary(isDark),
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
                    style: UIConstants.cancelTextButtonStyle(isDark),
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
                    style: UIConstants.confirmTextButtonStyle(),
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
        EventSubscriptionService().notify(title: 'Validation', message: 'Please provide new quantity, price, or expiration time', icon: Icons.warning_amber, color: const Color(0xFFE65100));
        return;
      }

      final newOrderId = '${participantOrderId}_repl_${DateTime.now().millisecondsSinceEpoch}';

      final replaceResult = await GrpcurlHelper.replaceOrderAsync(
        oldParticipantOrderId: participantOrderId,
        newParticipantOrderId: newOrderId,
        newQuantity: newQuantity,
        newPrice: newPrice,
        newExpireTime: expirationDateTime,
        reason: 'User requested replacement',
        refRequestId: 'flutter-replace-${DateTime.now().millisecondsSinceEpoch}',
      ).timeout(const Duration(minutes: 5));

      if (replaceResult['success'] == true) {
        EventSubscriptionService().notify(
          title: 'Order Replaced',
          message: 'Replace request sent',
          icon: Icons.swap_horiz,
        );
        _fetchRealOrders();
      } else {
        final errorMsg = replaceResult['output']?['error'] ?? 'Failed to replace order';
        _showOrderErrorDialog('Replace failed', errorMsg);
      }
    } catch (e) {
      _showOrderErrorDialog('Replace failed', e.toString());
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

  /// Calculate order fees as 1% of volume (amount * price) with debounce.
  void _calculateOrderFees() {
    _feeDebounceTimer?.cancel();

    final quantity = double.tryParse(_quantityController.text.trim()) ?? 0;
    final price = double.tryParse(_priceController.text.trim()) ?? 0;

    // Both fields must have values
    if (quantity <= 0 || price <= 0) {
      if (!_feeManuallyEdited) {
        setState(() {
          _estimatedFee = '';
          _isLoadingFee = false;
        });
      }
      return;
    }

    // Don't auto-calculate if user manually edited
    if (_feeManuallyEdited) return;

    _lastAutoFee = '...';
    _feeController.text = '...';
    _feeManuallyEdited = false;

    setState(() {
      _isLoadingFee = true;
    });

    // Debounce 500ms
    _feeDebounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      final volume = quantity * price;
      final fee = volume * 0.01; // 1% of volume
      final decimals = _getCurrencyDecimals();
      final feeStr = fee.toStringAsFixed(decimals);
      final currencySymbol = _selectedCurrency['symbol'] ?? _selectedCurrency['code'] ?? '';

      _lastAutoFee = feeStr;
      _feeController.text = feeStr;
      _feeManuallyEdited = false;

      setState(() {
        _estimatedFee = '$feeStr $currencySymbol';
        _isLoadingFee = false;
      });
    });
  }

  // Fetch last price for security using exchangePairId
  Future<void> _fetchLastPriceForSecurity(Map<String, dynamic> security) async {
    final exchangePairId = security['exchangePairId']?.toString() ?? '';
    final quoteTokenDecimal = security['quoteTokenDecimal'] ?? 0;
    if (exchangePairId.isEmpty) return;
    try {
      final response = await http.get(
        Uri.parse('https://brokerage-api-stage.tokenise.io/api/services/app/Pair/GetSinglePairByExchangePairId?ExchangePairId=$exchangePairId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(minutes: 5));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        if (jsonData['success'] == true && jsonData['result'] != null) {
          final result = jsonData['result'];
          final lastTradePriceRaw = result['last_trade_price'];
          if (lastTradePriceRaw != null) {
            final lastTradePrice = double.tryParse(lastTradePriceRaw.toString()) ?? 0.0;
            final lastPrice = lastTradePrice / (pow(10, quoteTokenDecimal));
            security['last'] = lastPrice;
            security['price'] = '${lastPrice.toStringAsFixed(2)}';
          }
        }
      }
    } catch (e) {
      print('Error fetching last price for $exchangePairId: $e');
    }
  }
  Future<void> _fetchPairsFromAPI() async {
    // Only skip if we already have data AND we've already requested it
    if (_hasRequestedSecurityDefinitions && _securities.isNotEmpty) {
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
        const Duration(minutes: 5),
        onTimeout: () {
          throw TimeoutException('API request timed out', const Duration(minutes: 5));
        },
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        
        if (jsonData['success'] == true && jsonData['result'] != null) {
          final List<dynamic> pairs = jsonData['result'];
          
          print('✅ Received ${pairs.length} trading pairs from API');
          
          _securities.clear(); // Clear any existing assets
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
              final securityItem = {
                'symbol': symbol,
                'name': title,
                'title': title,
                'logoAddress': logoAddress,
                'coverAddress': coverAddress.isNotEmpty ? coverAddress : 'https://picsum.photos/112/120?random=${_securities.length}',
                'orderbook': orderbook,
                'exchangePairId': exchangePairId,
                'quoteTokenDecimal': quoteTokenDecimal,
                'price': '\$0.00',
                'change': '+0.00%',
                'changeColor': Colors.grey,
                'last': null,
              };
              _securities.add(securityItem);
              // Fetch last price for this security
              if (exchangePairId.isNotEmpty) {
                priceFutures.add(_fetchLastPriceForSecurity(securityItem));
              }
            }
          }
          // Wait for all last price fetches to complete
          await Future.wait(priceFutures);
          setState(() {
            // Update selected symbol if this is the first time or current is empty
            if (_selectedSymbol.isEmpty && _securities.isNotEmpty) {
              _selectedSymbol = _securities.first['symbol'];
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
          
          print('🎉 Successfully loaded ${_securities.length} trading pairs');
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
          UIConstants.warningSnackBar('Failed to load trading pairs: ${e.toString()}', duration: const Duration(seconds: 2)),
        );
      }
      
      // Fallback: Add some default pairs if API fails
      setState(() {
        if (_securities.isEmpty) {
          _securities.addAll([
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
            _selectedSymbol = _securities.first['symbol'];
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

    // Cancel existing live stream before loading new data
    _liveOhlcSubscription?.cancel();

    setState(() {
      _isLoadingChart = true;
      _chartError = '';
    });

    try {
      // Call gRPC GetHistoricalOhlcData using grpcurl
      final result = await GrpcurlHelper.getHistoricalOhlcData(
        symbol: symbol,
        period: _selectedTimePeriod,
        pageSize: 500,
      );

      if (result['success'] == true && result['output'] != null) {
        final output = result['output'] as Map<String, dynamic>;
        final ohlcDataList = output['ohlcData'] as List<dynamic>? ?? [];

        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('📊 CHART DATA PROCESSING for $symbol:');
        print('✅ Received ${ohlcDataList.length} OHLC data points from server');
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

        // Convert to CandleData objects for interactive_chart package
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

            // Apply price divisibility (raw integers, e.g. 1450 with divis 2 = 14.50)
            final divisor = _pow10(_getCurrencyDecimals());
            final open = (double.tryParse(ohlcMap['open']?.toString() ?? '0') ?? 0.0) / divisor;
            final high = (double.tryParse(ohlcMap['high']?.toString() ?? '0') ?? 0.0) / divisor;
            final low = (double.tryParse(ohlcMap['low']?.toString() ?? '0') ?? 0.0) / divisor;
            final close = (double.tryParse(ohlcMap['close']?.toString() ?? '0') ?? 0.0) / divisor;
            final volume = double.tryParse(ohlcMap['volume']?.toString() ?? '0') ?? 0.0;

            final candle = Candle(
              date: timestamp,
              open: open,
              high: high,
              low: low,
              close: close,
              volume: volume,
            );

            candles.add(candle);
          } catch (e) {
            print('⚠️ Error parsing OHLC data point: $e');
          }
        }

        // Sort newest first (candlesticks package expects index 0 = newest)
        candles.sort((a, b) => b.date.compareTo(a.date));

        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('📊 CHART CONVERSION RESULT:');
        print('✅ Successfully converted ${candles.length} candles for $symbol');

        if (candles.isEmpty) {
          print('⚠️  WARNING: NO CANDLES CONVERTED! Chart will show empty.');
        } else if (candles.length < 2) {
          print('⚠️  WARNING: Only ${candles.length} candle(s) available - need at least 2 for chart!');
          print('   Sample candle: Open=${candles[0].open}, High=${candles[0].high}, Low=${candles[0].low}, Close=${candles[0].close}, Volume=${candles[0].volume}, Timestamp=${candles[0].date}');
        } else {
          print('✅ Chart ready with ${candles.length} candles');
          print('   First candle: Open=${candles[0].open}, High=${candles[0].high}, Low=${candles[0].low}, Close=${candles[0].close}, Timestamp=${candles[0].date}');
          print('   Last candle: Open=${candles.last.open}, High=${candles.last.high}, Low=${candles.last.low}, Close=${candles.last.close}, Timestamp=${candles.last.date}');
        }
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

        setState(() {
          _candles = candles;
          _isLoadingChart = false;
          _chartRebuildKey++; // Increment to force chart rebuild with new ScrollController
        });

        // Start live OHLC stream for real-time updates
        _startLiveOhlcStream(symbol, _selectedTimePeriod);
      } else {
        throw Exception('Failed to fetch chart data: ${result['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      print('❌ Error loading chart data: $e');
      if (mounted) {
        setState(() {
          _chartError = 'Failed to load chart data: $e';
          _isLoadingChart = false;
        });
        // Auto-retry after 10 seconds
        _scheduleChartRetry(symbol);
      }
    }
  }

  Timer? _chartRetryTimer;

  void _scheduleChartRetry(String symbol) {
    _chartRetryTimer?.cancel();
    _chartRetryTimer = Timer(const Duration(seconds: 10), () {
      if (mounted && _chartError.isNotEmpty && symbol == _selectedSymbol) {
        print('🔄 Auto-retrying chart load for $symbol');
        _loadChartData(symbol);
      }
    });
  }

  /// Start live OHLC data stream for real-time chart updates
  void _startLiveOhlcStream(String symbol, String period) {
    // Cancel existing subscription if any
    _liveOhlcSubscription?.cancel();

    print('📡 Starting live OHLC stream for $symbol, period: $period');

    // Subscribe to live OHLC updates using grpcurl
    _liveOhlcSubscription = _subscribeToLiveOhlcData(symbol, period);
  }

  /// Periodically reload chart data from server
  Timer? _subscribeToLiveOhlcData(String symbol, String period) {
    return Timer.periodic(const Duration(seconds: 30), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      _loadChartData(symbol);
    });
  }

  void _startOrderbookRefreshTimer() {
    _orderbookRefreshTimer?.cancel();
    _orderbookRefreshTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_selectedSymbol.isNotEmpty) {
        _fetchOrderbookData(_selectedSymbol);
      }
    });
  }

  void _startOrdersRefreshTimer() {
    _ordersRefreshTimer?.cancel();
    _ordersRefreshTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      _fetchRealOrders();
    });
  }

  void _startTradeHistoryRefreshTimer() {
    _tradeHistoryRefreshTimer?.cancel();
    _tradeHistoryRefreshTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_selectedSymbol.isNotEmpty) {
        _fetchTradeHistoryForSecurity(_selectedSymbol, pageNumber: _currentTradeHistoryPage);
      }
    });
  }

  Future<void> _fetchOrderbookData(String symbol) async {
    print('📊 [ORDERBOOK] _fetchOrderbookData CALLED for symbol: "$symbol", _securities count: ${_securities.length}');

    // Reset pagination when fetching new symbol
    _currentSellOrdersPage = 1;
    _currentBuyOrdersPage = 1;
    _totalSellOrdersPages = 1;
    _totalBuyOrdersPages = 1;

    // Fetch both sell and buy orders in parallel for faster loading
    await Future.wait([
      _fetchSellOrders(symbol, pageNumber: 1),
      _fetchBuyOrders(symbol, pageNumber: 1),
    ]);
  }
  
  Future<void> _fetchSellOrders(String symbol, {int pageNumber = 1}) async {
    print('📊 [ORDERBOOK] _fetchSellOrders CALLED for symbol: "$symbol", pageNumber: $pageNumber');

    // Find the security data for this symbol
    final security = _securities.firstWhere(
      (s) => s['symbol'] == symbol,
      orElse: () {
        print('[Orderbook] Security not found for symbol: $symbol');
        setState(() {
          _sellOrders = [];
          _isLoadingSellOrders = false;
        });
        return <String, dynamic>{};
      },
    );

    if (security.isEmpty) {
      print('❌ Security not found for sell orders: $symbol');
      return;
    }

    final securityIid = security['iid']?.toString() ?? '';

    print('[Orderbook-Sell] $symbol: securityIid="$securityIid"');

    if (securityIid.isEmpty) {
      print('❌ Missing security IID for sell orders $symbol - no orderbook data available');
      setState(() {
        _sellOrders = [];
        _isLoadingSellOrders = false;
      });
      return;
    }

    setState(() {
      _isLoadingSellOrders = true;
    });

    try {
      // Call GetOrderbook gRPC function
      final result = await GrpcurlHelper.getOrderbook(
        securityIid: securityIid,
        side: 'ORDER_SIDE_ENUM_SELL',
        pageNumber: pageNumber,
        pageSize: _orderbookPageSize,
        mode: _orderbookMode,
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
          print('[Orderbook-Sell] RAW ORDER KEYS: ${orderMap.keys.toList()}, data=${orderMap['data']}');
          final priceValue = orderMap['price'];
          final quantityValue = orderMap['quantity'];

          // Parse price (raw integer with divisibility 2, e.g. 1012 = 10.12)
          final rawPrice = priceValue is String
              ? double.tryParse(priceValue) ?? 0.0
              : (priceValue is num ? priceValue.toDouble() : 0.0);
          final price = rawPrice / 100.0;
          final quantity = quantityValue is String
              ? double.tryParse(quantityValue) ?? 0.0
              : (quantityValue is num ? quantityValue.toDouble() : 0.0);

          final total = _roundToCurrencyPrecision(price * quantity);

          print('[Orderbook-Sell] Mapping order: rawPrice=$rawPrice, price=$price, quantity=$quantity, total=$total');

          // L3: check expire_ts against now (orderbook sends seconds)
          final expireTs = orderMap['expireTimestamp'] ?? orderMap['expire_timestamp'] ?? orderMap['expireTs'] ?? orderMap['expire_ts'] ?? '';
          final expireNum = int.tryParse(expireTs.toString()) ?? 0;
          final hasExpiry = expireNum > 0;
          final expireMillis = expireNum * 1000; // orderbook uses seconds
          final isExpired = hasExpiry && DateTime.fromMillisecondsSinceEpoch(expireMillis).isBefore(DateTime.now());

          // L2: parse data JSON for has_expired_orders / earliest_expiry
          final dataStr = (orderMap['data'] ?? '').toString();
          bool l2Expired = false;
          String earliestExpiry = '';
          if (dataStr.isNotEmpty) {
            try {
              final dataJson = json.decode(dataStr) as Map<String, dynamic>;
              if (dataJson['has_expired_orders'] == true) l2Expired = true;
              if (dataJson['earliest_expiry'] != null) {
                earliestExpiry = dataJson['earliest_expiry'].toString();
              }
            } catch (_) {}
          }

          return {
            'price': price,
            'quantity': quantity,
            'total': total,
            'is_expired': isExpired || l2Expired,
            'expire_timestamp': earliestExpiry.isNotEmpty ? earliestExpiry : expireTs.toString(),
            'expire_ts_unit': 's',
          };
        }).toList();

        print('[Orderbook-Sell] ✅ Mapped ${sellOrders.length} sell orders');
        print('[Orderbook-Sell] First order: ${sellOrders.isNotEmpty ? sellOrders[0] : "none"}');
      } else {
        print('[Orderbook-Sell] $symbol: gRPC call failed. Response: $result');
      }

      setState(() {
        _sellOrders = sellOrders;
        _currentSellOrdersPage = pageNumber;
        if (sellOrders.length == _orderbookPageSize) {
          if (_totalSellOrdersPages <= pageNumber) {
            _totalSellOrdersPages = pageNumber + 1;
          }
        } else {
          _totalSellOrdersPages = pageNumber;
        }
        _isLoadingSellOrders = false;
        print('[Orderbook-Sell] Page $pageNumber of $_totalSellOrdersPages, ${sellOrders.length} orders');
      });

    } catch (e) {
      print('❌ Error fetching sell orders for $symbol: $e');
      setState(() {
        _sellOrders = [];
        _totalSellOrdersPages = 1;
        _isLoadingSellOrders = false;
      });
    }
  }
  
  Future<void> _fetchBuyOrders(String symbol, {int pageNumber = 1}) async {
    print('📊 [ORDERBOOK] _fetchBuyOrders CALLED for symbol: "$symbol", pageNumber: $pageNumber');

    // Find the security data for this symbol
    final security = _securities.firstWhere(
      (s) => s['symbol'] == symbol,
      orElse: () {
        print('[Orderbook] Security not found for symbol: $symbol');
        setState(() {
          _buyOrders = [];
          _isLoadingBuyOrders = false;
        });
        return <String, dynamic>{};
      },
    );

    if (security.isEmpty) {
      print('❌ Security not found for buy orders: $symbol');
      return;
    }

    final securityIid = security['iid']?.toString() ?? '';

    print('[Orderbook-Buy] $symbol: securityIid="$securityIid"');

    if (securityIid.isEmpty) {
      print('❌ Missing security IID for buy orders $symbol - no orderbook data available');
      setState(() {
        _buyOrders = [];
        _isLoadingBuyOrders = false;
      });
      return;
    }

    setState(() {
      _isLoadingBuyOrders = true;
    });

    try {
      // Call GetOrderbook gRPC function
      final result = await GrpcurlHelper.getOrderbook(
        securityIid: securityIid,
        side: 'ORDER_SIDE_ENUM_BUY',
        pageNumber: pageNumber,
        pageSize: _orderbookPageSize,
        mode: _orderbookMode,
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
          print('[Orderbook-Buy] RAW ORDER KEYS: ${orderMap.keys.toList()}, data=${orderMap['data']}');
          final priceValue = orderMap['price'];
          final quantityValue = orderMap['quantity'];

          // Parse price (raw integer with divisibility 2, e.g. 1012 = 10.12)
          final rawPrice = priceValue is String
              ? double.tryParse(priceValue) ?? 0.0
              : (priceValue is num ? priceValue.toDouble() : 0.0);
          final price = rawPrice / 100.0;
          final quantity = quantityValue is String
              ? double.tryParse(quantityValue) ?? 0.0
              : (quantityValue is num ? quantityValue.toDouble() : 0.0);

          final total = _roundToCurrencyPrecision(price * quantity);

          print('[Orderbook-Buy] Mapping order: rawPrice=$rawPrice, price=$price, quantity=$quantity, total=$total');

          // L3: check expire_ts against now (orderbook sends seconds)
          final expireTs = orderMap['expireTimestamp'] ?? orderMap['expire_timestamp'] ?? orderMap['expireTs'] ?? orderMap['expire_ts'] ?? '';
          final expireNum = int.tryParse(expireTs.toString()) ?? 0;
          final hasExpiry = expireNum > 0;
          final expireMillis = expireNum * 1000; // orderbook uses seconds
          final isExpired = hasExpiry && DateTime.fromMillisecondsSinceEpoch(expireMillis).isBefore(DateTime.now());

          // L2: parse data JSON for has_expired_orders / earliest_expiry
          final dataStr = (orderMap['data'] ?? '').toString();
          bool l2Expired = false;
          String earliestExpiry = '';
          if (dataStr.isNotEmpty) {
            try {
              final dataJson = json.decode(dataStr) as Map<String, dynamic>;
              if (dataJson['has_expired_orders'] == true) l2Expired = true;
              if (dataJson['earliest_expiry'] != null) {
                earliestExpiry = dataJson['earliest_expiry'].toString();
              }
            } catch (_) {}
          }

          return {
            'price': price,
            'quantity': quantity,
            'total': total,
            'is_expired': isExpired || l2Expired,
            'expire_timestamp': earliestExpiry.isNotEmpty ? earliestExpiry : expireTs.toString(),
            'expire_ts_unit': 's',
          };
        }).toList();

        print('[Orderbook-Buy] ✅ Mapped ${buyOrders.length} buy orders');
        print('[Orderbook-Buy] First order: ${buyOrders.isNotEmpty ? buyOrders[0] : "none"}');
      } else {
        print('[Orderbook-Buy] $symbol: gRPC call failed. Response: $result');
      }

      setState(() {
        _buyOrders = buyOrders;
        _currentBuyOrdersPage = pageNumber;
        if (buyOrders.length == _orderbookPageSize) {
          if (_totalBuyOrdersPages <= pageNumber) {
            _totalBuyOrdersPages = pageNumber + 1;
          }
        } else {
          _totalBuyOrdersPages = pageNumber;
        }
        _isLoadingBuyOrders = false;
        print('[Orderbook-Buy] Page $pageNumber of $_totalBuyOrdersPages, ${buyOrders.length} orders');
      });

    } catch (e) {
      print('❌ Error fetching buy orders for $symbol: $e');
      setState(() {
        _buyOrders = [];
        _totalBuyOrdersPages = 1;
        _isLoadingBuyOrders = false;
      });
    }
  }

  void _goToSellOrdersPage(int page) {
    if (page >= 1 && page != _currentSellOrdersPage && _selectedSymbol.isNotEmpty) {
      _fetchSellOrders(_selectedSymbol, pageNumber: page);
    }
  }

  void _goToBuyOrdersPage(int page) {
    if (page >= 1 && page != _currentBuyOrdersPage && _selectedSymbol.isNotEmpty) {
      _fetchBuyOrders(_selectedSymbol, pageNumber: page);
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
            color: currentPage > 1 ? (UIConstants.visibleBorderColor(isDarkTheme)) : Colors.transparent,
            borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
          ),
          child: Icon(
            Icons.chevron_left,
            size: 16,
            color: currentPage > 1 ? (UIConstants.textPrimary(isDarkTheme)) : Colors.grey,
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
                  : (UIConstants.visibleBorderColor(isDarkTheme)),
                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
              ),
              child: Center(
                child: Text(
                  i.toString(),
                  style: TextStyle(
                    fontSize: UIConstants.fontSizeSm,
                    color: i == currentPage 
                      ? Colors.white 
                      : (UIConstants.textPrimary(isDarkTheme)),
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
                  fontSize: UIConstants.fontSizeSm,
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
            color: currentPage < totalPages ? (UIConstants.visibleBorderColor(isDarkTheme)) : Colors.transparent,
            borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
          ),
          child: Icon(
            Icons.chevron_right,
            size: 16,
            color: currentPage < totalPages ? (UIConstants.textPrimary(isDarkTheme)) : Colors.grey,
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
  
  /// Get the number of decimal places for the current currency based on divisibility.
  int _getCurrencyDecimals() {
    final currency = _selectedCurrency['issueCurrency'] ?? _selectedCurrency['code'] ?? '';
    final div = _defaultDivisibility(currency);
    return int.tryParse(div) ?? 2;
  }

  /// Round a value to the currency's divisibility precision.
  double _roundToCurrencyPrecision(double value) {
    final decimals = _getCurrencyDecimals();
    final factor = _pow10(decimals);
    return (value * factor).roundToDouble() / factor;
  }

  static const _idChars = '23456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghjkmnpqrstuvwxyz';
  static String _generateId(int length) {
    final rng = Random();
    return String.fromCharCodes(List.generate(length, (_) => _idChars.codeUnitAt(rng.nextInt(_idChars.length))));
  }

  static double _pow10(int n) {
    double result = 1;
    for (var i = 0; i < n; i++) result *= 10;
    return result;
  }

  String _formatPrice(double price) {
    final decimals = _getCurrencyDecimals();
    return _roundToCurrencyPrecision(price).toStringAsFixed(decimals);
  }
  
  @override
  void dispose() {
    _savePageState();
    _messageSubscription?.cancel();
    _connectionStatusSubscription?.cancel();
    _logonStatusSubscription?.cancel();
    _securityRequestTimeout?.cancel();
    _liveOhlcSubscription?.cancel();
    _orderbookRefreshTimer?.cancel();
    _ordersRefreshTimer?.cancel();
    _tradeHistoryRefreshTimer?.cancel();
    _chartRetryTimer?.cancel();
    _feeDebounceTimer?.cancel();
    _quantityController.dispose();
    _priceController.dispose();
    _orderIdController.dispose();
    _reasonController.dispose();
    _replaceOrderIdController.dispose();
    _newOrderIdController.dispose();
    _newQuantityController.dispose();
    _newPriceController.dispose();
    _replaceReasonController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final isDarkTheme = themeService.isDarkTheme;

    return BasePage(
      menuItems: MenuItemsHelper.buildMenuItems(context, 'trading'),
      content: Expanded(
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

                            // Middle Panel - Security Selection and Chart
                            Expanded(
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  final maxMiddleHeight = constraints.maxHeight;
                                  final minMarketOverviewHeight = 100.0;
                                  final minChartHeight = 100.0;
                                  final maxMarketOverviewHeight = (maxMiddleHeight - minChartHeight).clamp(minMarketOverviewHeight, double.infinity);

                                  // Constrain market height
                                  _marketOverviewHeight = _marketOverviewHeight.clamp(minMarketOverviewHeight, maxMarketOverviewHeight);

                                  return Column(
                                    children: [
                                      // Security Selection at the top of middle panel
                                      Container(
                                        height: _marketOverviewHeight,
                                        child: _buildSecuritySection(themeService),
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
    );
  }

  Widget _buildVerticalSplitter({
    required Function(double) onDrag,
    required VoidCallback onDragStart,
    required VoidCallback onDragEnd,
    required bool isDragging,
    required ThemeService themeService,
  }) {
    final isDarkTheme = themeService.isDarkTheme;
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
                    : (UIConstants.visibleBorderColor(isDarkTheme)),
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
    final isDarkTheme = themeService.isDarkTheme;
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
                    : (UIConstants.visibleBorderColor(isDarkTheme)),
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

  
  Widget _buildTradingPanel(ThemeService themeService) {
    final isDarkTheme = themeService.isDarkTheme;
    return Container(
      padding: UIConstants.paddingStandard,
      decoration: BoxDecoration(
        color: isDarkTheme ? Colors.black : Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Trade Orders Tabs Section
          Expanded(
            child: _buildTradeOrdersTabs(isDarkTheme),
          ),

        ],
      ),
    );
  }

  // Helper method to get selected security symbol
  String _getSelectedSecuritySymbol() {
    if (_securities.isEmpty || _selectedSymbol.isEmpty) {
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

  // Parse fee value from the fee input controller
  double _parseFee() {
    return double.tryParse(_feeController.text.trim()) ?? 0.0;
  }

  // Helper method to calculate order total
  double _calculateTotal() {
    final quantity = double.tryParse(_quantityController.text) ?? 0.0;
    final fee = _parseFee();

    double subtotal;
    if (_orderType == 'Market') {
      final currentPrice = _candles.isNotEmpty ? _candles.first.close : 0.0;
      subtotal = quantity * currentPrice;
    } else {
      final price = double.tryParse(_priceController.text) ?? 0.0;
      subtotal = quantity * price;
    }

    final total = _isBuySelected ? subtotal + fee : subtotal - fee;
    return _roundToCurrencyPrecision(total);
  }

  /// Check if user has sufficient funds/holdings for the order
  bool _canPlaceOrder() {
    final quantity = double.tryParse(_quantityController.text) ?? 0.0;
    final price = double.tryParse(_priceController.text) ?? 0.0;

    // Disable if no amount entered
    if (quantity <= 0) return false;

    // Disable if limit order with no price
    if (_orderType == 'Limit' && price <= 0) return false;

    if (_isBuySelected) {
      final buyingPower = double.tryParse(_buyingPower.replaceAll(',', '').replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;
      if (_orderType == 'Market') {
        // Use current price (last candle close) to estimate market order cost
        final currentPrice = _candles.isNotEmpty ? _candles.first.close : 0.0;
        if (currentPrice > 0) {
          final estimatedCost = quantity * currentPrice;
          if (estimatedCost > buyingPower) return false;
        }
      } else {
        final total = _calculateTotal();
        if (total > buyingPower) return false;
      }
    } else {
      final available = double.tryParse(_availableBalance.replaceAll(',', '').replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;
      if (quantity > available) return false;
    }
    return true;
  }

  Widget _buildSecuritySection(ThemeService themeService) {
    final isDarkTheme = themeService.isDarkTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: UIConstants.pageBackground(isDarkTheme),
        border: Border(
          bottom: BorderSide(
            color: UIConstants.visibleBorderColor(isDarkTheme),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Market Row
          Row(
            children: [
              SizedBox(width: 52, child: Text('Market', style: TextStyle(fontSize: 11, color: UIConstants.textPrimary(isDarkTheme)))),
              Expanded(
                child: _HoverDropdownField(
                  isDarkTheme: isDarkTheme,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Map<String, String>>(
                      value: _markets.isEmpty ? null : _markets.cast<Map<String, String>?>().firstWhere((m) => m!['id'] == _selectedMarket['id'], orElse: () => _markets.isNotEmpty ? _markets.first : null),
                      isExpanded: true,
                      isDense: true,
                      onChanged: _markets.isEmpty ? null : (Map<String, String>? newValue) async {
                        if (newValue != null) {
                          setState(() {
                            _selectedMarket = newValue;
                            _venues = [{'id': '', 'display': 'All Venues'}];
                            _selectedVenue = _venues.first;
                          });
                          await _fetchVenues(newValue['id']!);
                          await _fetchMarketSecurities(newValue['id']!);
                          if (!_isBuySelected) { await _fetchAccountMarketPortfolioForMarket(newValue['id']!); }
                        }
                      },
                      dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
                      style: TextStyle(color: UIConstants.textPrimary(isDarkTheme), fontSize: 11),
                      items: _markets.isEmpty
                          ? [DropdownMenuItem<Map<String, String>>(value: {'id': '', 'description': '', 'display': ''}, child: Text(_isLoadingMarkets ? 'Loading markets...' : 'No markets available'))]
                          : _markets.map<DropdownMenuItem<Map<String, String>>>((market) => DropdownMenuItem<Map<String, String>>(value: market, child: Text(market['display'] ?? market['id']!))).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          // Venue Row
          Row(
            children: [
              SizedBox(width: 52, child: Text('Venue', style: TextStyle(fontSize: 11, color: UIConstants.textPrimary(isDarkTheme)))),
              Expanded(
                child: _HoverDropdownField(
                  isDarkTheme: isDarkTheme,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Map<String, String>>(
                      value: _venues.isEmpty ? null : _venues.cast<Map<String, String>?>().firstWhere((v) => v!['id'] == _selectedVenue['id'], orElse: () => _venues.isNotEmpty ? _venues.first : null),
                      isExpanded: true,
                      isDense: true,
                      onChanged: _venues.isEmpty ? null : (Map<String, String>? newValue) {
                        if (newValue != null) {
                          setState(() { _selectedVenue = newValue; });
                          print('📍 Selected venue: ${newValue['display']} (${newValue['id']})');
                        }
                      },
                      dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
                      style: TextStyle(color: UIConstants.textPrimary(isDarkTheme), fontSize: 11),
                      items: _venues.isEmpty
                          ? [DropdownMenuItem<Map<String, String>>(value: {'id': '', 'display': 'All Venues'}, child: Text(_isLoadingVenues ? 'Loading venues...' : 'All Venues'))]
                          : _venues.map<DropdownMenuItem<Map<String, String>>>((venue) => DropdownMenuItem<Map<String, String>>(value: venue, child: Text(venue['display'] ?? 'All Venues'))).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          // Security Row
          Row(
            children: [
              SizedBox(width: 52, child: Text('Security', style: TextStyle(fontSize: 11, color: UIConstants.textPrimary(isDarkTheme)))),
              Expanded(
                child: _HoverDropdownField(
                  isDarkTheme: isDarkTheme,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _securities.isEmpty ? null : (_securities.any((s) => s['symbol'] == _selectedSymbol) ? _selectedSymbol : _securities.isNotEmpty ? _securities.first['symbol'] as String : null),
                      isExpanded: true,
                      isDense: true,
                      onChanged: _securities.isEmpty ? null : (String? newValue) async {
                        if (newValue != null) {
                          setState(() { _selectedSymbol = newValue; });
                          await _updateCurrenciesForSecurity(newValue);
                          _loadChartData(newValue);
                          _resetAndFetchTradeHistory(newValue);
                          _fetchOrderbookData(newValue);
                          _calculateOrderFees();
                          if (!_isBuySelected) { await _fetchAccountMarketPortfolioForMarket(_selectedMarket['id'] ?? ''); }
                        }
                      },
                      dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
                      style: TextStyle(color: UIConstants.textPrimary(isDarkTheme), fontSize: 11),
                      items: _securities.isEmpty
                          ? [DropdownMenuItem<String>(value: '', child: Text(_isLoadingMarketSecurities ? 'Loading securities...' : 'No securities available'))]
                          : _securities.map<DropdownMenuItem<String>>((security) {
                              final symbol = security['symbol'] as String;
                              return DropdownMenuItem<String>(value: symbol, child: Text(symbol));
                            }).toList(),
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

  Widget _buildChartSection(ThemeService themeService) {
    final isDarkTheme = themeService.isDarkTheme;
    return Container(
      padding: UIConstants.paddingMinimal,
      decoration: BoxDecoration(
        color: isDarkTheme ? Colors.black : Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: UIConstants.filterBarBackground(isDarkTheme),
                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
              ),
              child: _buildChartContent(isDarkTheme),
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
            SizedBox(height: UIConstants.spacingMd),
            Text('Loading chart data...'),
          ],
        ),
      );
    }

    // Errors and empty state are handled inline below — no early return

    // Display candlestick chart
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Symbol and current price
          Stack(
            alignment: Alignment.center,
            children: [
              // Symbol at top-left with refresh button
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _selectedSymbol,
                      style: TextStyle(
                        fontSize: UIConstants.fontSizeSm,
                        fontWeight: UIConstants.fontWeightMedium,
                        color: UIConstants.textPrimary(isDarkTheme),
                      ),
                    ),
                    const SizedBox(width: 4),
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 14,
                        icon: Icon(Icons.refresh, color: isDarkTheme ? Colors.white54 : Colors.black45),
                        onPressed: _isLoadingChart ? null : () => _loadChartData(_selectedSymbol),
                        tooltip: 'Refresh chart',
                      ),
                    ),
                  ],
                ),
              ),
              // Last price at center
              if (_candles.isNotEmpty)
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '(Last Price: ',
                        style: TextStyle(
                          fontSize: UIConstants.fontSizeSm,
                          fontWeight: UIConstants.fontWeightMedium,
                          color: Colors.grey,
                        ),
                      ),
                      TextSpan(
                        text: '${_candles.first.close.toStringAsFixed(_getCurrencyDecimals())}',
                        style: TextStyle(
                          fontSize: UIConstants.fontSizeSm,
                          fontWeight: UIConstants.fontWeightMedium,
                          color: UIConstants.textPrimary(isDarkTheme),
                        ),
                      ),
                      TextSpan(
                        text: ')',
                        style: TextStyle(
                          fontSize: UIConstants.fontSizeSm,
                          fontWeight: UIConstants.fontWeightMedium,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: UIConstants.spacingMd),
          // Candlestick chart
          Expanded(
            child: Stack(
              children: [
                _isLoadingChart
                    ? const Center(child: CircularProgressIndicator())
                    : _candles.isEmpty
                        ? Center(
                            child: Text(
                              'No chart data available',
                              style: TextStyle(color: isDarkTheme ? Colors.white70 : Colors.black54),
                            ),
                          )
                        : _candles.length < 32
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _candles.first.close.toStringAsFixed(_getCurrencyDecimals()),
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: UIConstants.textPrimary(isDarkTheme),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${_candles.length} candle${_candles.length == 1 ? '' : 's'} available',
                                      style: TextStyle(color: isDarkTheme ? Colors.white54 : Colors.black45, fontSize: 12),
                                    ),
                                  ],
                                ),
                              )
                            : Theme(
                                data: isDarkTheme
                                    ? ThemeData(brightness: Brightness.dark)
                                    : ThemeData(brightness: Brightness.light),
                                child: Candlesticks(
                                  candles: _candles,
                                  onLoadMoreCandles: () async {},
                                ),
                              ),
                // Error overlay on top
                if (_chartError.isNotEmpty)
                  Positioned(
                    top: 4,
                    left: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '$_chartError (retrying...)',
                              style: const TextStyle(color: Colors.white, fontSize: 11),
                            ),
                          ),
                          const SizedBox(width: 4),
                          SizedBox(
                            width: 12,
                            height: 12,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: UIConstants.spacingMd),
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
                : (UIConstants.tabPanelBackground(isDarkTheme)),
            borderRadius: BorderRadius.circular(UIConstants.borderRadiusMd),
          ),
          child: Text(
            period,
            style: TextStyle(
              fontSize: UIConstants.fontSizeXs,
              fontWeight: isSelected ? UIConstants.fontWeightMedium : FontWeight.normal,
              color: isSelected 
                  ? Colors.white 
                  : (UIConstants.textPrimary(isDarkTheme)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActivitySection(ThemeService themeService) {
    final isDarkTheme = themeService.isDarkTheme;
    return Container(
      color: isDarkTheme ? Colors.black : Colors.white, // Section background matches table background
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align column content to the left
        children: [
          // Connected tab headers
          _buildActivityTabHeaders(isDarkTheme),
          // Connected content area with padding
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8), // Space between table and section edge
              decoration: BoxDecoration(
                color: UIConstants.tabPanelBackground(isDarkTheme), // Table background: dark gray / light gray
                border: Border.all(
                  color: UIConstants.tabPanelBackground(isDarkTheme), // Same as selected tab background
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: _buildActivityTabContent(isDarkTheme),
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
          children: [
            ..._activityTabNames.asMap().entries.map((entry) {
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
                      ? (UIConstants.tabPanelBackground(isDarkTheme)) // Selected tab same color as table
                      : (isDarkTheme
                          ? Colors.black.withOpacity(0.3)
                          : Colors.white.withOpacity(0.2)), // Unselected tab follows theme
                  border: isActive
                      ? null // No border for selected tab
                      : Border.all(
                          color: UIConstants.tabPanelBackground(isDarkTheme), // Same as selected background
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
                        ? (UIConstants.textPrimary(isDarkTheme))
                        : Colors.grey[400],
                    fontSize: UIConstants.textFieldFontSize,
                    fontWeight: isActive ? UIConstants.fontWeightMedium : UIConstants.fontWeightNormal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
            const SizedBox(width: 4),
            SizedBox(
              height: 28,
              width: 28,
              child: IconButton(
                padding: EdgeInsets.zero,
                iconSize: 15,
                splashRadius: 14,
                tooltip: 'Refresh',
                icon: Icon(
                  Icons.refresh,
                  color: UIConstants.textSecondary(isDarkTheme),
                ),
                onPressed: () {
                  if (_selectedSymbol.isNotEmpty) {
                    setState(() {
                      _sellOrders = [];
                      _buyOrders = [];
                      _tradeHistory = [];
                    });
                    _fetchOrderbookData(_selectedSymbol);
                    _resetAndFetchTradeHistory(_selectedSymbol);
                  }
                },
              ),
            ),
          ],
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
    final columns = [
      StyledColumn(label: 'Price'),
      StyledColumn(label: 'Quantity'),
      StyledColumn(label: 'Time'),
    ];

    return Container(
      padding: UIConstants.paddingStandard,
      decoration: BoxDecoration(
        color: UIConstants.tabPanelBackground(isDarkTheme),
      ),
      child: StyledDataTable(
        isDarkTheme: isDarkTheme,
        columns: columns,
        onPageChanged: (page) => _goToTradeHistoryPage(page),
        currentPage: _currentTradeHistoryPage,
        totalPages: _totalTradeHistoryPages,
        rows: List.generate(_tradeHistory.length, (index) {
          final trade = _tradeHistory[index];
          return StyledRow(cells: [
            Text(
              trade['price'].toString(),
              style: TextStyle(
                color: UIConstants.textPrimary(isDarkTheme),
                fontWeight: UIConstants.fontWeightMedium,
                fontSize: UIConstants.fontSizeSm,
              ),
            ),
            Text(
              trade['quantity'].toString(),
              style: TextStyle(
                color: UIConstants.textPrimary(isDarkTheme),
                fontSize: UIConstants.fontSizeSm,
              ),
            ),
            Text(
              trade['time'].toString(),
              style: TextStyle(
                color: Colors.grey,
                fontSize: UIConstants.fontSizeSm,
              ),
            ),
          ]);
        }),
      ),
    );
  }

  Widget _buildOrderbookTable(bool isDarkTheme) {
    return Container(
      padding: UIConstants.paddingStandard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Orderbook mode selector
          SizedBox(
            height: 28,
            child: DropdownButtonFormField<String>(
              value: _orderbookMode,
              isDense: true,
              isExpanded: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                  borderSide: BorderSide(color: Colors.grey[600]!),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                isDense: true,
              ),
              style: TextStyle(
                color: UIConstants.textPrimary(isDarkTheme),
                fontSize: UIConstants.fontSizeSm,
              ),
              dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
              items: _orderbookModeOptions.entries
                  .map((e) => DropdownMenuItem(
                        value: e.key,
                        child: Text(e.value, style: TextStyle(
                          color: UIConstants.textPrimary(isDarkTheme),
                          fontSize: UIConstants.fontSizeSm,
                        )),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null && value != _orderbookMode) {
                  setState(() {
                    _orderbookMode = value;
                    _currentSellOrdersPage = 1;
                    _currentBuyOrdersPage = 1;
                  });
                  if (_selectedSymbol.isNotEmpty) {
                    _fetchOrderbookData(_selectedSymbol);
                  }
                }
              },
            ),
          ),
          const SizedBox(height: UIConstants.spacingSm),
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
                          fontSize: UIConstants.fontSizeMd,
                          fontWeight: UIConstants.fontWeightMedium,
                          color: UIConstants.textPrimary(isDarkTheme),
                        ),
                      ),
                      const SizedBox(height: UIConstants.spacingSm),
                      // Sell Orders Headers
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Price',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontWeight: UIConstants.fontWeightMedium,
                                fontSize: UIConstants.fontSizeSm,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Quantity',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontWeight: UIConstants.fontWeightMedium,
                                fontSize: UIConstants.fontSizeSm,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Total',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontWeight: UIConstants.fontWeightMedium,
                                fontSize: UIConstants.fontSizeSm,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: UIConstants.spacingSm),
                      Divider(color: Colors.grey, thickness: 0.7, height: 1),
                      const SizedBox(height: UIConstants.spacingSm),
                      // Sell Orders List
                      Expanded(
                        child: _buildOrderbookSide(isDarkTheme, 'sell'),
                      ),
                      // Pagination for Sell Orders
                      _buildPaginationControls(_currentSellOrdersPage, _totalSellOrdersPages, _goToSellOrdersPage),
                    ],
                  ),
                ),

                // Spacing between sections
                const SizedBox(height: UIConstants.spacingMd),

                // Buy Orders Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Buy Orders Title
                      Text(
                        'Buy Orders',
                        style: TextStyle(
                          fontSize: UIConstants.fontSizeMd,
                          fontWeight: UIConstants.fontWeightMedium,
                          color: UIConstants.textPrimary(isDarkTheme),
                        ),
                      ),
                      const SizedBox(height: UIConstants.spacingSm),
                      // Buy Orders Headers
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Price',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontWeight: UIConstants.fontWeightMedium,
                                fontSize: UIConstants.fontSizeSm,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Quantity',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontWeight: UIConstants.fontWeightMedium,
                                fontSize: UIConstants.fontSizeSm,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Total',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontWeight: UIConstants.fontWeightMedium,
                                fontSize: UIConstants.fontSizeSm,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: UIConstants.spacingSm),
                      Divider(color: Colors.grey, thickness: 0.7, height: 1),
                      const SizedBox(height: UIConstants.spacingSm),
                      // Buy Orders List
                      Expanded(
                        child: _buildOrderbookSide(isDarkTheme, 'buy'),
                      ),
                      // Pagination for Buy Orders
                      _buildPaginationControls(_currentBuyOrdersPage, _totalBuyOrdersPages, _goToBuyOrdersPage),
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
            color: UIConstants.textSecondary(isDarkTheme),
            fontSize: UIConstants.textFieldFontSize,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        final color = side == 'sell' ? UIConstants.colorReject : UIConstants.colorAccept;

        final isExpired = order['is_expired'] == true;
        print('📊 [Orderbook] $side order[$index]: is_expired=$isExpired, expire_timestamp=${order['expire_timestamp']}, raw_order=$order');

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
          child: Row(
            children: [
              if (isExpired)
                Tooltip(
                  message: _orderbookExpiredTooltip(order),
                  child: Icon(Icons.warning_amber, size: 12, color: Colors.orange),
                ),
              if (isExpired) const SizedBox(width: 2),
              Expanded(
                child: Text(
                  _formatPrice(order['price']),
                  style: TextStyle(
                    color: color,
                    fontSize: UIConstants.fontSizeSm,
                    fontWeight: UIConstants.fontWeightNormal,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: Text(
                  (order['quantity'] as num).toInt().toString(),
                  style: TextStyle(
                    color: UIConstants.textPrimary(isDarkTheme),
                    fontSize: UIConstants.fontSizeSm,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  _formatPrice(order['total'] ?? 0.0),
                  style: TextStyle(
                    color: UIConstants.textSecondary(isDarkTheme),
                    fontSize: UIConstants.fontSizeSm,
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
    final isDarkTheme = themeService.isDarkTheme;
    return Container(
      color: isDarkTheme ? Colors.black : Colors.white, // Section background follows theme
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align column content to the left
        children: [
          // Connected tab headers
          _buildOrdersTabHeaders(isDarkTheme),
          // Connected content area with padding
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              decoration: BoxDecoration(
                color: UIConstants.tabPanelBackground(isDarkTheme), // Table background: dark gray / light gray
                border: Border.all(
                  color: UIConstants.tabPanelBackground(isDarkTheme), // Same as selected tab background
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: _buildOrdersTabContent(isDarkTheme),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersTabHeaders(bool isDarkTheme) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
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
                      ? (UIConstants.tabPanelBackground(isDarkTheme)) // Selected tab same color as table
                      : (isDarkTheme
                          ? Colors.black.withOpacity(0.3)
                          : Colors.white.withOpacity(0.2)), // Unselected tab follows theme
                  border: isActive
                      ? null // No border for selected tab
                      : Border.all(
                          color: UIConstants.tabPanelBackground(isDarkTheme), // Same as selected background
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
                        ? (UIConstants.textPrimary(isDarkTheme))
                        : Colors.grey[400],
                    fontSize: UIConstants.textFieldFontSize,
                    fontWeight: isActive ? UIConstants.fontWeightMedium : UIConstants.fontWeightNormal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
              ),
            ),
          ),
          SizedBox(
            height: 28,
            width: 28,
            child: IconButton(
              padding: EdgeInsets.zero,
              iconSize: 15,
              splashRadius: 14,
              tooltip: 'Refresh orders',
              icon: Icon(
                Icons.refresh,
                color: UIConstants.textSecondary(isDarkTheme),
              ),
              onPressed: _isLoadingRealOrders ? null : _fetchRealOrders,
            ),
          ),
          const SizedBox(width: 8),
        ],
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

  /// Clean enum prefix and title-case the result (e.g., ORDER_REQUEST_STATUS_ENUM_SUBMITTED → Submitted)
  String _cleanEnumPrefix(String raw) {
    // Strip known prefixes
    var cleaned = raw;
    for (final prefix in [
      'ORDER_REQUEST_STATUS_ENUM_',
      'ORDER_REQUEST_EVENT_TYPE_ENUM_',
      'ORDER_STATUS_ENUM_',
      'ORDER_STATUS_',
      'ORDER_SIDE_ENUM_',
    ]) {
      if (cleaned.toUpperCase().startsWith(prefix)) {
        cleaned = cleaned.substring(prefix.length);
        break;
      }
    }
    if (cleaned.isEmpty) return cleaned;
    // Title-case: replace underscores with spaces, capitalize each word
    return cleaned.split('_').map((w) =>
      w.isEmpty ? '' : w[0].toUpperCase() + w.substring(1).toLowerCase()
    ).join(' ');
  }

  /// Get display status preferring server order_status, falling back to boolean flags
  /// Resolve symbol for an order: use symbol field, or look up IID in loaded securities.
  String _resolveSymbol(Map<dynamic, dynamic> order) {
    final symbol = order['symbol']?.toString() ?? '';
    // If symbol is a proper ticker (not an IID), return it
    if (symbol.isNotEmpty && !symbol.startsWith('sec_listing_') && !symbol.startsWith('issued_instr_')) {
      return symbol;
    }
    // Try to resolve from IID
    final iid = symbol.isNotEmpty ? symbol
        : (order['securityListingIid']?.toString() ?? order['security_listing_iid']?.toString() ?? '');
    if (iid.isNotEmpty) {
      for (final sec in _securities) {
        if (sec['iid'] == iid) {
          final ticker = sec['symbol']?.toString() ?? '';
          final currency = sec['issueCurrency']?.toString() ?? '';
          return currency.isNotEmpty ? '$ticker:$currency' : ticker;
        }
      }
    }
    return symbol.isNotEmpty ? symbol : 'N/A';
  }

  String _getOrderStatus(Map<String, dynamic> order) {
    final rawStatus = (order['status'] ?? order['order_status'] ?? '').toString();
    if (rawStatus.isNotEmpty && rawStatus != 'UNKNOWN') {
      return _cleanEnumPrefix(rawStatus);
    }
    if (order['is_filled'] == true) return 'Filled';
    if (order['is_cancelled'] == true) return 'Cancelled';
    if (order['is_expired'] == true) return 'Expired';
    return 'Active';
  }

  /// Whether a status is terminal (non-actionable)
  bool _isTerminalStatus(String status) {
    final s = status.toLowerCase().trim();
    return ['filled', 'cancelled', 'expired', 'rejected', 'failed'].contains(s);
  }

  /// Get color for an order status
  Color _getStatusColor(String status, bool isDarkTheme) {
    switch (status.toLowerCase().trim()) {
      case 'submitted': return Colors.white;
      case 'accepted': return Colors.blue.shade300;
      case 'pending': return Colors.amber.shade600;
      case 'validated': return Colors.cyan.shade300;
      case 'active': return Colors.lightBlue.shade300;
      case 'partially filled': return Colors.teal.shade300;
      case 'filled': return Colors.green.shade400;
      case 'cancelled': return Colors.orange.shade400;
      case 'expired': return Colors.grey.shade500;
      case 'rejected': return Colors.red.shade400;
      case 'failed': return Colors.red.shade600;
      case 'error': return Colors.red.shade600;
      default: return UIConstants.textPrimary(isDarkTheme);
    }
  }

  /// Format a timestamp that could be ISO 8601 string, unix seconds, or null
  /// Extract expire timestamp from various possible field names/formats
  String _extractExpireTimestamp(Map<dynamic, dynamic> order) {
    // Try direct fields
    final candidates = [
      order['expireTimestamp'],
      order['expire_timestamp'],
      order['expireTs'],
      order['expire_ts'],
    ];
    for (final v in candidates) {
      if (v != null && v.toString().isNotEmpty && v.toString() != '0') return v.toString();
    }
    // Try nested DateTime message
    final expireAtDt = order['expireAtDt'] ?? order['expire_at_dt'];
    if (expireAtDt is Map) {
      final ts = expireAtDt['utcUnixEpochTsMillis'] ?? expireAtDt['utc_unix_epoch_ts_millis'] ?? expireAtDt['ts'];
      if (ts != null && ts.toString().isNotEmpty && ts.toString() != '0') return ts.toString();
    }
    return '';
  }

  String _fmtDt(DateTime dt) {
    final yy = (dt.year % 100).toString().padLeft(2, '0');
    return '${dt.day}/${dt.month}/$yy ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  /// Format a timestamp for display.
  /// [unit]: 'ms' = value is milliseconds, 's' = value is seconds.
  String _formatOrderTimestamp(dynamic timestamp, {String unit = 'ms'}) {
    final dt = _parseTimestamp(timestamp, unit: unit);
    if (dt == null) return '-';
    return _fmtDt(dt);
  }

  /// Parse a numeric timestamp to DateTime.
  /// [unit]: 'ms' = value is milliseconds, 's' = value is seconds.
  DateTime? _parseTimestamp(dynamic timestamp, {String unit = 'ms'}) {
    if (timestamp == null) return null;
    final str = timestamp.toString().trim();
    if (str.isEmpty || str == '0') return null;
    final n = int.tryParse(str);
    if (n != null && n > 0) {
      final millis = unit == 's' ? n * 1000 : n;
      return DateTime.fromMillisecondsSinceEpoch(millis);
    }
    return DateTime.tryParse(str);
  }

  bool _isExpiredTimestamp(dynamic timestamp, {String unit = 'ms'}) {
    final dt = _parseTimestamp(timestamp, unit: unit);
    return dt != null && dt.isBefore(DateTime.now());
  }

  String _expiredDurationText(dynamic timestamp, {String unit = 'ms'}) {
    final dt = _parseTimestamp(timestamp, unit: unit);
    if (dt == null) return 'Expired';
    final diff = DateTime.now().difference(dt);
    if (diff.inDays > 0) return 'Expired ${diff.inDays}d ${diff.inHours % 24}h ago';
    if (diff.inHours > 0) return 'Expired ${diff.inHours}h ${diff.inMinutes % 60}m ago';
    if (diff.inMinutes > 0) return 'Expired ${diff.inMinutes}m ago';
    return 'Expired ${diff.inSeconds}s ago';
  }

  String _orderbookExpiredTooltip(Map<String, dynamic> order) {
    final unit = order['expire_ts_unit'] ?? 'ms';
    return _expiredDurationText(order['expire_timestamp'], unit: unit);
  }

  /// Build expire timestamp cell with alarm icon if expired
  Widget _buildExpireTimestampCell(dynamic timestamp, bool isDarkTheme, {String unit = 'ms'}) {
    final formatted = _formatOrderTimestamp(timestamp, unit: unit);
    final isExpired = _isExpiredTimestamp(timestamp, unit: unit);
    return InkWell(
      onTap: () => _copyCell(formatted),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isExpired)
          Tooltip(
            message: _expiredDurationText(timestamp, unit: unit),
            child: Icon(Icons.warning_amber, size: 13, color: Colors.orange),
          ),
        if (isExpired) const SizedBox(width: 3),
        Flexible(
          child: Text(
            formatted,
            style: TextStyle(
              color: isExpired ? Colors.orange : UIConstants.textPrimary(isDarkTheme),
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
      ),
    );
  }

  /// Show order details dialog with info section, event logs, and refresh
  void _showOrderDetails(Map<String, dynamic> order) {
    final themeService = Provider.of<ThemeService>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            var currentOrder = Map<String, dynamic>.from(order);
            bool isRefreshing = false;
            final isDark = themeService.isDarkTheme;
            final textColor = UIConstants.textPrimary(isDark);
            final subtextColor = UIConstants.textSecondary(isDark);
            final bgColor = UIConstants.dialogBackground(isDark);
            final surfaceColor = UIConstants.dialogSurface(isDark);
            final borderColor = UIConstants.dialogBorder(isDark);

            void copyToClipboard(String text) {
              Clipboard.setData(ClipboardData(text: text));
              ScaffoldMessenger.of(dialogContext).showSnackBar(
                SnackBar(content: Text('Copied: $text'), duration: const Duration(seconds: 1)),
              );
            }

            Widget infoChip(String label, String value) {
              return Padding(
                padding: const EdgeInsets.only(right: 12, bottom: 8),
                child: InkWell(
                  onTap: () => copyToClipboard(value),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('$label: ', style: TextStyle(color: subtextColor, fontSize: 12)),
                      Text(value, style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w600)),
                      const SizedBox(width: 4),
                      Icon(Icons.copy, size: 12, color: subtextColor),
                    ],
                  ),
                ),
              );
            }

            final status = _getOrderStatus(currentOrder);
            final side = _cleanEnumPrefix(currentOrder['side']?.toString() ?? '');
            final eventLogs = (currentOrder['event_logs'] as List<dynamic>?) ?? [];

            // Format details map to readable string
            String formatDetails(dynamic details) {
              if (details == null) return '';
              if (details is Map) {
                return details.entries.map((e) => '${e.key}: ${e.value}').join(', ');
              }
              return details.toString();
            }

            return AlertDialog(
              backgroundColor: bgColor,
              shape: UIConstants.dialogShape(isDark),
              title: Row(
                children: [
                  Expanded(child: Text('Order Details', style: TextStyle(fontSize: 18, color: textColor))),
                  IconButton(
                    icon: isRefreshing
                        ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: textColor))
                        : Icon(Icons.refresh, color: textColor),
                    tooltip: 'Refresh order',
                    onPressed: isRefreshing ? null : () async {
                      setDialogState(() { isRefreshing = true; });
                      try {
                        final result = await GrpcurlHelper.getInvestorOrders(
                          investorId: _cachedAccountId!,
                          refRequestId: 'flutter-order-detail-${DateTime.now().millisecondsSinceEpoch}',
                          pagination: {'page_size': 100},
                        ).timeout(const Duration(minutes: 2));

                        if (result['success'] == true && result['output']?['orders'] != null) {
                          final orders = result['output']['orders'] as List<dynamic>;
                          final poid = currentOrder['participantOrderId']?.toString();
                          final match = orders.cast<Map<String, dynamic>>().where((o) =>
                            (o['participantOrderId'] ?? o['participant_order_id'] ?? o['orderIid'] ?? o['order_id'])?.toString() == poid
                          );
                          if (match.isNotEmpty) {
                            final raw = match.first;
                            final newEventLogs = raw['eventLogs'] ?? raw['event_logs'] ?? [];
                            String? newCreateTs = raw['createTimestamp'] ?? raw['createdAtDt']?['ts'] ?? raw['create_timestamp'];
                            if (newCreateTs == null && newEventLogs is List && newEventLogs.isNotEmpty) {
                              newCreateTs = newEventLogs.first['timestamp'] ?? newEventLogs.first['ts'];
                            }
                            setDialogState(() {
                              currentOrder = {
                                ...currentOrder,
                                'order_status': raw['orderStatus'] ?? raw['order_status'] ?? '',
                                'status': raw['orderStatus'] ?? raw['status'] ?? '',
                                'fee_amount': raw['feeAmount'] ?? raw['fee_amount'] ?? '',
                                'event_logs': newEventLogs,
                                'create_timestamp': newCreateTs ?? currentOrder['create_timestamp'],
                                'is_filled': raw['isFilled'] ?? raw['is_filled'] ?? false,
                                'is_cancelled': raw['isCancelled'] ?? raw['is_cancelled'] ?? false,
                                'is_expired': raw['isExpired'] ?? raw['is_expired'] ?? false,
                                '_raw': raw,
                              };
                              isRefreshing = false;
                            });
                            return;
                          }
                        }
                        setDialogState(() { isRefreshing = false; });
                      } catch (e) {
                        print('Error refreshing order: $e');
                        setDialogState(() { isRefreshing = false; });
                      }
                    },
                  ),
                ],
              ),
              content: SizedBox(
                width: 800,
                height: 500,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Info section
                      Wrap(
                        children: [
                          infoChip('Order ID', currentOrder['order_id']?.toString() ?? 'N/A'),
                          infoChip('Participant Order ID', currentOrder['participantOrderId']?.toString() ?? 'N/A'),
                          infoChip('Side', side),
                          infoChip('Symbol', currentOrder['symbol']?.toString() ?? 'N/A'),
                          infoChip('Quantity', currentOrder['quantity']?.toString() ?? '0'),
                          infoChip('Price', currentOrder['price']?.toString() ?? '0'),
                          infoChip('Type', _cleanEnumPrefix(currentOrder['order_type']?.toString() ?? 'N/A')),
                          infoChip('Status', status),
                          infoChip('Fee Amount', currentOrder['fee_amount']?.toString().isEmpty == true ? 'N/A' : currentOrder['fee_amount']?.toString() ?? 'N/A'),
                          infoChip('Security Listing IID', currentOrder['security_listing_iid']?.toString().isEmpty == true ? 'N/A' : currentOrder['security_listing_iid']?.toString() ?? 'N/A'),
                          infoChip('Created', _formatOrderTimestamp(currentOrder['create_timestamp'])),
                          infoChip('Expires', _formatOrderTimestamp(currentOrder['expire_timestamp'])),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Divider(color: borderColor),
                      const SizedBox(height: 8),
                      // Event Logs section
                      Text('Event Logs (${eventLogs.length})', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: textColor)),
                      const SizedBox(height: 8),
                      if (eventLogs.isEmpty)
                        Text('No event logs available.', style: TextStyle(color: subtextColor, fontSize: 12))
                      else
                        Table(
                          border: TableBorder.all(color: borderColor, width: 0.5),
                          columnWidths: const {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(2),
                            2: FlexColumnWidth(1.5),
                            3: FlexColumnWidth(3),
                            4: FlexColumnWidth(3),
                          },
                          children: [
                            TableRow(
                              decoration: BoxDecoration(color: surfaceColor),
                              children: [
                                Padding(padding: const EdgeInsets.all(6), child: Text('Timestamp', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11, color: textColor))),
                                Padding(padding: const EdgeInsets.all(6), child: Text('Type', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11, color: textColor))),
                                Padding(padding: const EdgeInsets.all(6), child: Text('Step', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11, color: textColor))),
                                Padding(padding: const EdgeInsets.all(6), child: Text('Message', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11, color: textColor))),
                                Padding(padding: const EdgeInsets.all(6), child: Text('Details', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11, color: textColor))),
                              ],
                            ),
                            ...eventLogs.map<TableRow>((log) {
                              final logMap = log is Map<String, dynamic> ? log : <String, dynamic>{};
                              final ts = _formatOrderTimestamp(logMap['timestamp'] ?? logMap['ts'] ?? logMap['createdAt']);
                              final type = _cleanEnumPrefix((logMap['type'] ?? logMap['eventType'] ?? logMap['event_type'] ?? '').toString());
                              final step = (logMap['stepName'] ?? logMap['step'] ?? logMap['sagaStep'] ?? logMap['saga_step'] ?? '').toString();
                              final message = (logMap['message'] ?? logMap['msg'] ?? '').toString();
                              final details = formatDetails(logMap['details'] ?? logMap['detail'] ?? logMap['error']);
                              return TableRow(
                                children: [
                                  _buildCopyableCell(ts, copyToClipboard, textColor),
                                  _buildCopyableCell(type, copyToClipboard, textColor),
                                  _buildCopyableCell(step, copyToClipboard, textColor),
                                  _buildCopyableCell(message, copyToClipboard, textColor),
                                  _buildCopyableCell(details, copyToClipboard, textColor),
                                ],
                              );
                            }),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: Text('Close', style: TextStyle(color: isDark ? Colors.white70 : null)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildCopyableCell(String text, void Function(String) onCopy, Color textColor) {
    return InkWell(
      onTap: text.isNotEmpty ? () => onCopy(text) : null,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Text(text.isEmpty ? '-' : text, style: TextStyle(fontSize: 11, color: textColor)),
      ),
    );
  }

  void _copyCell(String value) {
    if (value.isEmpty || value == '-' || value == 'N/A') return;
    Clipboard.setData(ClipboardData(text: value));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Copied: $value', style: const TextStyle(fontSize: 12)),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          width: 250,
        ),
      );
    }
  }

  void _copyOrderJson(Map<String, dynamic> order) {
    final raw = order['_raw'];
    final data = raw ?? order;
    final jsonStr = const JsonEncoder.withIndent('  ').convert(data);
    Clipboard.setData(ClipboardData(text: jsonStr));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Order JSON copied', style: TextStyle(fontSize: 12)),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          width: 250,
        ),
      );
    }
  }

  void _copyOrderCsv(Map<String, dynamic> order) {
    String formatSide(String side) {
      final s = side.toUpperCase();
      if (s.contains('BUY')) return 'BUY';
      if (s.contains('SELL')) return 'SELL';
      return side;
    }
    final side = formatSide(order['side'] ?? '');
    final symbol = order['symbol'] ?? 'N/A';
    final quantity = _formatDecimal(order['quantity'] ?? '0');
    final remaining = _formatDecimal(order['remainingQuantity'] ?? order['remaining_quantity'] ?? '?');
    final price = order['price'] ?? '0';
    final priceDisplay = (price == '0' || price == '0.00') ? 'Market' : _formatDecimal(price);
    final unit = order['expire_ts_unit'] ?? 'ms';
    final created = _formatOrderTimestamp(order['create_timestamp']);
    final expires = _formatOrderTimestamp(order['expire_timestamp'], unit: unit);
    final status = _getOrderStatus(order);
    final csv = '$side,$symbol,$remaining/$quantity,$priceDisplay,$created,$expires,$status';
    Clipboard.setData(ClipboardData(text: csv));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('CSV line copied', style: TextStyle(fontSize: 12)),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          width: 250,
        ),
      );
    }
  }

  Widget _copyableOrderCell(String value, bool isDarkTheme, {Color? color, double width = 140, double fontSize = 12, FontWeight? fontWeight, TextAlign textAlign = TextAlign.center}) {
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: () => _copyCell(value),
        child: Tooltip(
          message: value,
          waitDuration: const Duration(milliseconds: 500),
          child: Text(
            value,
            style: TextStyle(
              color: color ?? UIConstants.textPrimary(isDarkTheme),
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
            textAlign: textAlign,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget _buildOrderRow(Map<String, dynamic> order, bool isDarkTheme) {
    // Helper function to format side
    String formatSide(String side) {
      final s = side.toUpperCase();
      if (s.contains('BUY')) return 'BUY';
      if (s.contains('SELL')) return 'SELL';
      return side;
    }

    final side = formatSide(order['side'] ?? '');
    final status = _getOrderStatus(order);
    final statusColor = _getStatusColor(status, isDarkTheme);
    final sideColor = side == 'BUY' ? UIConstants.colorAccept : UIConstants.colorReject;
    final quantity = _formatDecimal(order['quantity'] ?? '0');
    final remaining = _formatDecimal(order['remainingQuantity'] ?? order['remaining_quantity'] ?? '?');
    final quantityDisplay = '$remaining / $quantity';
    final price = order['price'] ?? '0';
    final priceDisplay = (price == '0' || price == '0.00') ? 'Market' : _formatDecimal(price);

    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _copyableOrderCell(side, isDarkTheme, width: 75, color: sideColor, fontWeight: UIConstants.fontWeightMedium, fontSize: UIConstants.fontSizeSm, textAlign: TextAlign.left),
          _copyableOrderCell(order['symbol'] ?? 'N/A', isDarkTheme),
          _copyableOrderCell(quantityDisplay, isDarkTheme),
          _copyableOrderCell(priceDisplay, isDarkTheme),
          _copyableOrderCell(_formatOrderTimestamp(order['create_timestamp']), isDarkTheme, fontSize: 11),
          SizedBox(
            width: 140,
            child: _buildExpireTimestampCell(order['expire_timestamp'], isDarkTheme, unit: order['expire_ts_unit'] ?? 'ms'),
          ),
          _copyableOrderCell(status, isDarkTheme, color: statusColor, fontSize: UIConstants.fontSizeSm),
          Expanded(child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_isTerminalStatus(status)) ...[
                  IconButton(
                    icon: const Icon(Icons.cancel_outlined, size: 18),
                    color: Colors.red,
                    tooltip: 'Cancel',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                    onPressed: () => _cancelOrder(order['participantOrderId']?.toString() ?? ''),
                  ),
                  IconButton(
                    icon: const Icon(Icons.swap_horiz, size: 18),
                    color: Colors.blue,
                    tooltip: 'Replace',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                    onPressed: () => _replaceOrder(order['participantOrderId']?.toString() ?? '', order),
                  ),
                ],
                IconButton(
                  icon: const Icon(Icons.copy, size: 16),
                  color: Colors.grey,
                  tooltip: 'Copy CSV line',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                  onPressed: () => _copyOrderCsv(order),
                ),
                IconButton(
                  icon: const Icon(Icons.data_object, size: 16),
                  color: Colors.grey,
                  tooltip: 'Copy JSON',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                  onPressed: () => _copyOrderJson(order),
                ),
                IconButton(
                  icon: const Icon(Icons.info_outline, size: 18),
                  color: Colors.grey,
                  tooltip: 'Details',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                  onPressed: () => _showOrderDetails(order),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  StyledRow _buildOrderDataRow(Map<String, dynamic> order, int index, bool isDarkTheme) {
    String formatSide(String side) {
      final s = side.toUpperCase();
      if (s.contains('BUY')) return 'BUY';
      if (s.contains('SELL')) return 'SELL';
      return side;
    }

    final side = formatSide(order['side'] ?? '');
    final status = _getOrderStatus(order);
    final statusColor = _getStatusColor(status, isDarkTheme);
    final sideColor = side == 'BUY' ? UIConstants.colorAccept : UIConstants.colorReject;
    final quantity = _formatDecimal(order['quantity'] ?? '0');
    final remaining = _formatDecimal(order['remainingQuantity'] ?? order['remaining_quantity'] ?? '?');
    final quantityDisplay = '$remaining / $quantity';
    final price = order['price'] ?? '0';
    final priceDisplay = (price == '0' || price == '0.00') ? 'Market' : _formatDecimal(price);

    return StyledRow(cells: [
      _copyableOrderCell(side, isDarkTheme, width: 75, color: sideColor, fontWeight: UIConstants.fontWeightMedium, fontSize: UIConstants.fontSizeSm, textAlign: TextAlign.left),
      _copyableOrderCell(order['symbol'] ?? 'N/A', isDarkTheme),
      _copyableOrderCell(quantityDisplay, isDarkTheme),
      _copyableOrderCell(priceDisplay, isDarkTheme),
      _copyableOrderCell(_formatOrderTimestamp(order['create_timestamp']), isDarkTheme, fontSize: 11),
      SizedBox(
        width: 140,
        child: _buildExpireTimestampCell(order['expire_timestamp'], isDarkTheme, unit: order['expire_ts_unit'] ?? 'ms'),
      ),
      _copyableOrderCell(status, isDarkTheme, color: statusColor, fontSize: UIConstants.fontSizeSm),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!_isTerminalStatus(status)) ...[
            IconButton(
              icon: const Icon(Icons.cancel_outlined, size: 16),
              color: Colors.red,
              tooltip: 'Cancel',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
              onPressed: () => _cancelOrder(order['participantOrderId']?.toString() ?? ''),
            ),
            IconButton(
              icon: const Icon(Icons.swap_horiz, size: 16),
              color: Colors.blue,
              tooltip: 'Replace',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
              onPressed: () => _replaceOrder(order['participantOrderId']?.toString() ?? '', order),
            ),
          ],
          IconButton(
            icon: const Icon(Icons.copy, size: 14),
            color: Colors.grey,
            tooltip: 'Copy CSV',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 22, minHeight: 22),
            onPressed: () => _copyOrderCsv(order),
          ),
          IconButton(
            icon: const Icon(Icons.data_object, size: 14),
            color: Colors.grey,
            tooltip: 'Copy JSON',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 22, minHeight: 22),
            onPressed: () => _copyOrderJson(order),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline, size: 14),
            color: Colors.grey,
            tooltip: 'Details',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 22, minHeight: 22),
            onPressed: () => _showOrderDetails(order),
          ),
        ],
      ),
    ]);
  }

  Widget _buildOrdersTable(bool isDarkTheme) {
    return Container(
      padding: UIConstants.paddingStandard,
      child: Column(
        children: [
          Expanded(child: _buildOrdersContent(isDarkTheme)),
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
            SizedBox(height: UIConstants.spacingMd),
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
            const SizedBox(height: UIConstants.spacingMd),
            Text(
              'Failed to load orders',
              style: TextStyle(
                fontSize: UIConstants.textFieldFontSize,
                fontWeight: UIConstants.fontWeightNormal,
                color: UIConstants.textSecondary(isDarkTheme),
              ),
            ),
            const SizedBox(height: UIConstants.spacingSm),
            Text(
              _realOrdersError!,
              style: TextStyle(
                fontSize: UIConstants.fontSizeSm,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: UIConstants.spacingMd),
            ElevatedButton(
              onPressed: _fetchRealOrders,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return StyledDataTable(
      isDarkTheme: isDarkTheme,
      rowsPerPage: _ordersPerPage,
      columns: [
        StyledColumn(label: 'Side'),
        StyledColumn(label: 'Pair'),
        StyledColumn(label: 'Qty (Rem/Tot)'),
        StyledColumn(label: 'Price'),
        StyledColumn(label: 'Creation Time'),
        StyledColumn(label: 'Expiration Time'),
        StyledColumn(label: 'Status'),
        StyledColumn(label: 'Action'),
      ],
      rows: List.generate(_realOrders.length, (index) {
        final order = _realOrders[index];
        return _buildOrderDataRow(order, index, isDarkTheme);
      }),
    );
  }

  Widget _buildOrderHistoryTable(bool isDarkTheme) {
    return Container(
      padding: UIConstants.paddingStandard,
      child: StyledDataTable(
        isDarkTheme: isDarkTheme,
        rowsPerPage: _historyPerPage,
        columns: [
          StyledColumn(label: 'Side'),
          StyledColumn(label: 'Pair'),
          StyledColumn(label: 'Qty'),
          StyledColumn(label: 'Price'),
          StyledColumn(label: 'Creation Time'),
          StyledColumn(label: 'Expiration Time'),
          StyledColumn(label: 'Status'),
          StyledColumn(label: 'Action'),
        ],
        rows: List.generate(_orderHistory.length, (index) {
          final order = _orderHistory[index];
          return _buildOrderHistoryDataRow(order, index, isDarkTheme);
        }),
      ),
    );
  }

  Widget _buildOrderHistoryRow(Map<String, dynamic> order, bool isDarkTheme) {
    // Helper function to format side
    String formatSide(String side) {
      final s = side.toUpperCase();
      if (s.contains('BUY')) return 'BUY';
      if (s.contains('SELL')) return 'SELL';
      return side;
    }

    final side = formatSide(order['side'] ?? '');
    final status = _getOrderStatus(order);
    final statusColor = _getStatusColor(status, isDarkTheme);
    final sideColor = side == 'BUY' ? UIConstants.colorAccept : UIConstants.colorReject;
    final quantity = _formatDecimal(order['quantity'] ?? '0');
    final remaining = _formatDecimal(order['remainingQuantity'] ?? order['remaining_quantity'] ?? '?');
    final quantityDisplay = '$remaining / $quantity';
    final price = order['price'] ?? '0';
    final priceDisplay = (price == '0' || price == '0.00') ? 'Market' : _formatDecimal(price);

    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _copyableOrderCell(side, isDarkTheme, width: 75, color: sideColor, fontWeight: UIConstants.fontWeightMedium, fontSize: UIConstants.fontSizeSm, textAlign: TextAlign.left),
          _copyableOrderCell(order['symbol'] ?? 'N/A', isDarkTheme, width: 150),
          _copyableOrderCell(quantityDisplay, isDarkTheme, width: 150),
          _copyableOrderCell(priceDisplay, isDarkTheme, width: 150),
          _copyableOrderCell(_formatOrderTimestamp(order['create_timestamp']), isDarkTheme, width: 150, fontSize: 11),
          SizedBox(
            width: 150,
            child: _buildExpireTimestampCell(order['expire_timestamp'], isDarkTheme, unit: order['expire_ts_unit'] ?? 'ms'),
          ),
          _copyableOrderCell(status, isDarkTheme, color: statusColor, fontSize: UIConstants.fontSizeSm),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.copy, size: 16),
                  color: Colors.grey,
                  tooltip: 'Copy CSV line',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                  onPressed: () => _copyOrderCsv(order),
                ),
                IconButton(
                  icon: const Icon(Icons.data_object, size: 16),
                  color: Colors.grey,
                  tooltip: 'Copy JSON',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                  onPressed: () => _copyOrderJson(order),
                ),
                IconButton(
                  icon: const Icon(Icons.info_outline, size: 18),
                  color: Colors.grey,
                  tooltip: 'Details',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                  onPressed: () => _showOrderDetails(order),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  StyledRow _buildOrderHistoryDataRow(Map<String, dynamic> order, int index, bool isDarkTheme) {
    String formatSide(String side) {
      final s = side.toUpperCase();
      if (s.contains('BUY')) return 'BUY';
      if (s.contains('SELL')) return 'SELL';
      return side;
    }

    final side = formatSide(order['side'] ?? '');
    final status = _getOrderStatus(order);
    final statusColor = _getStatusColor(status, isDarkTheme);
    final sideColor = side == 'BUY' ? UIConstants.colorAccept : UIConstants.colorReject;
    final quantity = _formatDecimal(order['quantity'] ?? '0');
    final price = order['price'] ?? '0';
    final priceDisplay = (price == '0' || price == '0.00') ? 'Market' : _formatDecimal(price);

    return StyledRow(cells: [
      _copyableOrderCell(side, isDarkTheme, width: 75, color: sideColor, fontWeight: UIConstants.fontWeightMedium, fontSize: UIConstants.fontSizeSm, textAlign: TextAlign.left),
      _copyableOrderCell(order['symbol'] ?? 'N/A', isDarkTheme, width: 150),
      _copyableOrderCell(quantity, isDarkTheme, width: 150),
      _copyableOrderCell(priceDisplay, isDarkTheme, width: 150),
      _copyableOrderCell(_formatOrderTimestamp(order['create_timestamp']), isDarkTheme, width: 150, fontSize: 11),
      SizedBox(
        width: 150,
        child: _buildExpireTimestampCell(order['expire_timestamp'], isDarkTheme, unit: order['expire_ts_unit'] ?? 'ms'),
      ),
      _copyableOrderCell(status, isDarkTheme, color: statusColor, fontSize: UIConstants.fontSizeSm),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.copy, size: 14),
            color: Colors.grey,
            tooltip: 'Copy CSV',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 22, minHeight: 22),
            onPressed: () => _copyOrderCsv(order),
          ),
          IconButton(
            icon: const Icon(Icons.data_object, size: 14),
            color: Colors.grey,
            tooltip: 'Copy JSON',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 22, minHeight: 22),
            onPressed: () => _copyOrderJson(order),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline, size: 14),
            color: Colors.grey,
            tooltip: 'Details',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 22, minHeight: 22),
            onPressed: () => _showOrderDetails(order),
          ),
        ],
      ),
    ]);
  }

  Widget _buildOrderbookSection(ThemeService themeService) {
    final isDarkTheme = themeService.isDarkTheme;
    return Container(
      padding: UIConstants.paddingStandard,
      decoration: BoxDecoration(
        color: isDarkTheme ? Colors.black : Colors.white,
        border: Border(
          top: BorderSide(
            color: UIConstants.visibleBorderColor(isDarkTheme),
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
              fontSize: UIConstants.fontSizeMd,
              fontWeight: UIConstants.fontWeightMedium,
              color: UIConstants.textPrimary(isDarkTheme),
            ),
          ),
          const SizedBox(height: UIConstants.spacingMd),
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
                          fontSize: UIConstants.fontSizeMd,
                          fontWeight: UIConstants.fontWeightMedium,
                          color: UIConstants.textPrimary(isDarkTheme),
                        ),
                      ),
                      const SizedBox(height: UIConstants.spacingSm),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Price',
                              style: TextStyle(
                                fontSize: UIConstants.textFieldFontSize,
                                color: UIConstants.textSecondary(isDarkTheme),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Quantity',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: UIConstants.textFieldFontSize,
                                color: UIConstants.textSecondary(isDarkTheme),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Total',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: UIConstants.textFieldFontSize,
                                color: UIConstants.textSecondary(isDarkTheme),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: UIConstants.spacingSm),
                      Container(
                        height: 1,
                        color: UIConstants.visibleBorderColor(isDarkTheme),
                      ),
                      const SizedBox(height: UIConstants.spacingSm),
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
                                        color: UIConstants.textSecondary(isDarkTheme),
                                        fontSize: UIConstants.textFieldFontSize,
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
                                                        fontSize: UIConstants.textFieldFontSize,
                                                        color: UIConstants.colorReject,
                                                        fontWeight: UIConstants.fontWeightNormal,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      order['quantity'].toString(),
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: UIConstants.textFieldFontSize,
                                                        color: UIConstants.textPrimary(isDarkTheme),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      _formatPrice(order['total'] ?? 0.0),
                                                      textAlign: TextAlign.right,
                                                      style: TextStyle(
                                                        fontSize: UIConstants.textFieldFontSize,
                                                        color: UIConstants.textPrimary(isDarkTheme),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      // Pagination for Sell Orders
                                      _buildPaginationControls(_currentSellOrdersPage, _totalSellOrdersPages, _goToSellOrdersPage),
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
                          fontSize: UIConstants.fontSizeMd,
                          fontWeight: UIConstants.fontWeightMedium,
                          color: UIConstants.textPrimary(isDarkTheme),
                        ),
                      ),
                      const SizedBox(height: UIConstants.spacingSm),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Price',
                              style: TextStyle(
                                fontSize: UIConstants.textFieldFontSize,
                                color: UIConstants.textSecondary(isDarkTheme),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Quantity',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: UIConstants.textFieldFontSize,
                                color: UIConstants.textSecondary(isDarkTheme),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Total',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: UIConstants.textFieldFontSize,
                                color: UIConstants.textSecondary(isDarkTheme),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: UIConstants.spacingSm),
                      Container(
                        height: 1,
                        color: UIConstants.visibleBorderColor(isDarkTheme),
                      ),
                      const SizedBox(height: UIConstants.spacingSm),
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
                                        color: UIConstants.textSecondary(isDarkTheme),
                                        fontSize: UIConstants.textFieldFontSize,
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
                                                        fontSize: UIConstants.textFieldFontSize,
                                                        color: UIConstants.colorAccept,
                                                        fontWeight: UIConstants.fontWeightNormal,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      order['quantity'].toString(),
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: UIConstants.textFieldFontSize,
                                                        color: UIConstants.textPrimary(isDarkTheme),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      _formatPrice(order['total'] ?? 0.0),
                                                      textAlign: TextAlign.right,
                                                      style: TextStyle(
                                                        fontSize: UIConstants.textFieldFontSize,
                                                        color: UIConstants.textPrimary(isDarkTheme),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      // Pagination for Buy Orders
                                      _buildPaginationControls(_currentBuyOrdersPage, _totalBuyOrdersPages, _goToBuyOrdersPage),
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
        EventSubscriptionService().notify(title: 'Validation', message: 'Please enter a quantity', icon: Icons.warning_amber, color: const Color(0xFFE65100));
        return;
      }

      if (_orderType == 'Limit' && _priceController.text.isEmpty) {
        EventSubscriptionService().notify(title: 'Validation', message: 'Please enter a price for limit order', icon: Icons.warning_amber, color: const Color(0xFFE65100));
        return;
      }

      if (_cachedAccountId == null || _cachedAccountId!.isEmpty) {
        EventSubscriptionService().notify(title: 'Validation', message: 'Account ID not available', icon: Icons.warning_amber, color: const Color(0xFFE65100));
        return;
      }

      if (_selectedSymbol.isEmpty) {
        EventSubscriptionService().notify(title: 'Validation', message: 'No security selected', icon: Icons.warning_amber, color: const Color(0xFFE65100));
        return;
      }

      // Use the actual security_listing_iid from the selected security
      final selectedSecurity = _securities.firstWhere(
        (s) => s['symbol'] == _selectedSymbol,
        orElse: () => <String, dynamic>{},
      );
      final securityId = selectedSecurity['iid']?.toString() ?? '';
      if (securityId.isEmpty) {
        EventSubscriptionService().notify(title: 'Validation', message: 'Security listing ID not found', icon: Icons.warning_amber, color: const Color(0xFFE65100));
        return;
      }
      final currency = _selectedCurrency['issueCurrency'] ?? _selectedCurrency['code'] ?? '';
      print('🏷️ Using security_listing_iid: $securityId');

      // Generate unique investor order ID
      final investorOrderId = 'invord_${_generateId(16)}';

      // Determine order side
      final side = _isBuySelected ? 'BUY' : 'SELL';

      // Set price (0 for market orders), rounded to currency precision
      final decimals = _getCurrencyDecimals();
      final rawPrice = _orderType == 'Market' ? '0' : _priceController.text;
      final price = rawPrice == '0' ? '0' : _roundToCurrencyPrecision(double.tryParse(rawPrice) ?? 0.0).toStringAsFixed(decimals);

      print('📝 Order details: side=$side, type=${_orderType.toUpperCase()}, quantity=${_quantityController.text.trim()}, price=$price');

      EventSubscriptionService().notify(
        title: 'Placing Order',
        message: '$side $_selectedSymbol',
        icon: Icons.hourglass_top,
      );

      // Calculate expiry timestamp from selected period
      final DateTime? expireTime = _expiryPeriod == 'No Expiry'
          ? null
          : DateTime.now().add(switch (_expiryPeriod) {
              '5 Minutes' => const Duration(minutes: 5),
              '1 Day' => const Duration(days: 1),
              '3 Days' => const Duration(days: 3),
              '1 Week' => const Duration(days: 7),
              '2 Weeks' => const Duration(days: 14),
              '1 Month' => const Duration(days: 30),
              _ => const Duration(days: 30),
            });

      // Call CreateOrder API
      final result = await realGrpcClient.createOrder(
        accountId: _cachedAccountId!,
        feePayerAccountId: _cachedAccountId!,
        securityId: securityId,
        orderType: _orderType.toUpperCase(),
        side: side,
        quantity: _quantityController.text.trim(),
        price: price,
        timeInForce: _timeInForce,
        investorOrderId: investorOrderId,
        currency: currency,
        feeAmount: _roundToCurrencyPrecision(double.tryParse(_feeController.text.trim()) ?? 0.0).toStringAsFixed(decimals),
        expireTime: expireTime,
      );

      if (result['success'] == true) {
        // Success - handle ExecutionAsyncResponse structure
        final output = result['output'] as Map<String, dynamic>?;

        // For async responses, extract request_id / execution ID
        final requestId = output?['refExecutionId'] ??
                         output?['ref_execution_id'] ??
                         output?['id'] ??
                         output?['asyncResponseData']?['order_id'] ??
                         output?['metadata']?['order_id'] ??
                         'Unknown';

        print('📋 CreateOrderAsync response: $output');

        EventSubscriptionService().notify(
          title: 'Order Sent',
          message: 'Order request sent',
          icon: Icons.send,
        );

        // Refresh orders list to show the new order
        _fetchRealOrders();

        // Clear form after successful order
        _quantityController.clear();
        _priceController.clear();
      } else {
        // Error
        final errorMessage = result['output']?['error'] ?? 'Unknown error occurred';
        _showOrderErrorDialog('Order failed', errorMessage);
      }
    } catch (e) {
      _showOrderErrorDialog('Order failed', e.toString());
    } catch (e, stackTrace) {
      print('❌ Critical error in _placeOrder: $e');
      print('Stack trace: $stackTrace');
      _showOrderErrorDialog('Unexpected error', e.toString());
    }
  }

  void _showOrderErrorDialog(String title, String errorMessage) {
    final themeService = Provider.of<ThemeService>(context, listen: false);
    final isDark = themeService.isDarkTheme;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: UIConstants.dialogBackground(isDark),
        shape: UIConstants.dialogShape(isDark) as RoundedRectangleBorder,
        child: Container(
          width: 450,
          padding: UIConstants.paddingComfortable,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.error_outline, color: UIConstants.colorReject, size: 24),
                  const SizedBox(width: UIConstants.spacingSm),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: UIConstants.textPrimary(isDark),
                        fontSize: UIConstants.fontSizeMd,
                        fontWeight: UIConstants.fontWeightMedium,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: UIConstants.textSecondary(isDark), size: 18),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: UIConstants.spacingMd),
              Container(
                width: double.infinity,
                padding: UIConstants.paddingStandard,
                decoration: BoxDecoration(
                  color: UIConstants.dialogSurface(isDark),
                  borderRadius: BorderRadius.circular(UIConstants.borderRadiusMd),
                ),
                child: SelectableText(
                  errorMessage,
                  style: TextStyle(
                    color: UIConstants.colorReject,
                    fontSize: UIConstants.fontSizeSm,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: UIConstants.spacingLg),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: errorMessage));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Copied to clipboard'), duration: Duration(seconds: 2)),
                      );
                    },
                    icon: Icon(Icons.copy, size: 14, color: UIConstants.textSecondary(isDark)),
                    label: Text('Copy', style: TextStyle(color: UIConstants.textSecondary(isDark), fontSize: UIConstants.fontSizeSm)),
                  ),
                  const SizedBox(width: UIConstants.spacingSm),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: UIConstants.buttonStyle(UIConstants.colorCommand),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
                    fontSize: UIConstants.textFieldFontSize,
                    color: UIConstants.textSecondary(isDarkTheme),
                    fontWeight: UIConstants.fontWeightNormal,
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
                          : _supportedCurrencies.cast<Map<String, String>?>().firstWhere((c) => c!['code'] == _selectedCurrency['code'], orElse: () => _supportedCurrencies.isNotEmpty ? _supportedCurrencies.first : null),
                      isExpanded: true,
                      onChanged: _supportedCurrencies.isEmpty ? null : (Map<String, String>? newValue) async {
                        if (newValue != null) {
                          setState(() {
                            _selectedCurrency = newValue;
                          });
                          // Fetch fresh cash holdings for the new currency
                          if (_cachedAccountId != null && _cachedAccountId!.isNotEmpty) {
                            await _fetchCashHoldingsForInvestor(_cachedAccountId!);
                          }
                        }
                      },
                      dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
                      style: TextStyle(
                        color: UIConstants.textPrimary(isDarkTheme),
                        fontSize: UIConstants.textFieldFontSize, // Smaller font size
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

          const SizedBox(height: UIConstants.spacingMd), // Reduced from 20

          // Buy/Sell Toggle Buttons (stretches with container width)
          Container(
            decoration: BoxDecoration(
              color: UIConstants.cardBackground(isDarkTheme),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _HoverTradeButton(
                    text: 'Buy',
                    isSelected: _isBuySelected,
                    selectedColor: UIConstants.colorAccept,
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
                    selectedColor: UIConstants.colorReject,
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

          const SizedBox(height: UIConstants.spacingMd), // Reduced space before order type

          // Order Type Toggle Buttons with mouse cursor and smaller height (like buy/sell area)
          Container(
            decoration: BoxDecoration(
              color: UIConstants.cardBackground(isDarkTheme),
              borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
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
                      setState(() {
                        _orderType = 'Limit';
                        _feeController.clear();
                        _feeManuallyEdited = false;
                      });
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
                      setState(() {
                        _orderType = 'Market';
                        _feeController.clear();
                        _feeManuallyEdited = false;
                      });
                      _calculateOrderFees();
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: UIConstants.spacingSm),

          // Time In Force Dropdown
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  'TIF',
                  style: TextStyle(
                    fontSize: UIConstants.textFieldFontSize,
                    color: UIConstants.textSecondary(isDarkTheme),
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
                        value: _timeInForce,
                        isExpanded: true,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            _timeInForce = newValue!;
                          });
                        },
                        dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
                        style: TextStyle(
                          color: UIConstants.textPrimary(isDarkTheme),
                          fontSize: UIConstants.textFieldFontSize,
                        ),
                        items: ['DAY', 'GTC']
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

          const SizedBox(height: UIConstants.spacingSm),

          // Available Balance / Buying Power Row Layout
          SizedBox(
            height: 24,
            child: Row(
              children: [
                Text(
                  _isBuySelected ? 'Available to Invest' : 'Available',
                  style: TextStyle(
                    fontSize: UIConstants.textFieldFontSize,
                    color: UIConstants.textSecondary(isDarkTheme),
                  ),
                ),
                SizedBox(
                  width: 20,
                  height: 20,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    iconSize: 14,
                    icon: Icon(
                      Icons.refresh,
                      color: UIConstants.textSecondary(isDarkTheme),
                    ),
                    tooltip: 'Refresh balances',
                    onPressed: _isLoadingCashHoldings ? null : _fetchCashHoldings,
                  ),
                ),
                const SizedBox(width: UIConstants.spacingSm),
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
                                  UIConstants.textPrimary(isDarkTheme),
                                ),
                              ),
                            )
                          : Text(
                              _isBuySelected
                                  ? '$_buyingPower ${_selectedCurrency['symbol'] ?? ''}'
                                  : _availableBalance,
                              style: TextStyle(
                                fontSize: UIConstants.fontSizeMd,
                                fontWeight: UIConstants.fontWeightMedium,
                                color: UIConstants.textPrimary(isDarkTheme),
                              ),
                            ),
                      const SizedBox(width: 4),
                      (!_isBuySelected && _securities.isEmpty)
                          ? SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(
                                strokeWidth: 1.5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  UIConstants.textPrimary(isDarkTheme),
                                ),
                              ),
                            )
                          : (!_isBuySelected
                              ? Text(
                                  _getSelectedSecuritySymbol(),
                                  style: TextStyle(
                                    fontSize: UIConstants.fontSizeMd,
                                    fontWeight: UIConstants.fontWeightMedium,
                                    color: UIConstants.textPrimary(isDarkTheme),
                                  ),
                                )
                              : SizedBox.shrink()),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: UIConstants.spacingSm),

          // Amount Input
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  'Amount',
                  style: TextStyle(
                    fontSize: UIConstants.textFieldFontSize,
                    color: UIConstants.textSecondary(isDarkTheme),
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
                                  color: UIConstants.colorReject, // Pink for sell
                                  fontSize: UIConstants.textFieldFontSize,
                                  fontWeight: UIConstants.fontWeightMedium,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: UIConstants.spacingSm),
                        ],
                        _securities.isEmpty
                            ? SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(
                                  strokeWidth: 1.5,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    UIConstants.textPrimary(isDarkTheme),
                                  ),
                                ),
                              )
                            : Text(
                                _getSelectedSecuritySymbol(),
                                style: TextStyle(
                                  color: UIConstants.textPrimary(isDarkTheme),
                                  fontSize: UIConstants.textFieldFontSize,
                                  fontWeight: UIConstants.fontWeightNormal,
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
            const SizedBox(height: UIConstants.spacingSm),

            // Price Input
            Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Text(
                    'Price',
                    style: TextStyle(
                      fontSize: UIConstants.textFieldFontSize,
                      color: UIConstants.textSecondary(isDarkTheme),
                    ),
                  ),
                ),
                Expanded(
                  child: _HoverInputField(
                    controller: _priceController,
                    hintText: '0',
                    isDarkTheme: isDarkTheme,
                    inputFormatters: [
                      _DecimalInputFormatter(_getCurrencyDecimals()),
                    ],
                    suffixWidget: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Text(
                        _selectedCurrency['issueCurrency']?.isNotEmpty == true
                            ? _selectedCurrency['issueCurrency']!
                            : (_selectedCurrency['symbol'] ?? '\$'),
                        style: TextStyle(
                          color: UIConstants.textPrimary(isDarkTheme),
                          fontSize: UIConstants.textFieldFontSize,
                          fontWeight: UIConstants.fontWeightNormal,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: UIConstants.spacingSm),

            // Expiry Dropdown
            Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Text(
                    'Expiry',
                    style: TextStyle(
                      fontSize: UIConstants.textFieldFontSize,
                      color: UIConstants.textSecondary(isDarkTheme),
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
                          dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
                          style: TextStyle(
                            color: UIConstants.textPrimary(isDarkTheme),
                            fontSize: UIConstants.textFieldFontSize,
                          ),
                          items: ['5 Minutes', '1 Day', '3 Days', '1 Week', '2 Weeks', '1 Month', 'No Expiry']
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
            // Show calculated expiration time
            Padding(
              padding: const EdgeInsets.only(left: 80, top: 4),
              child: Builder(
                builder: (_) {
                  if (_expiryPeriod == 'No Expiry') {
                    return Text(
                      'No expiration',
                      style: TextStyle(
                        fontSize: 10,
                        color: UIConstants.textHint(isDarkTheme),
                      ),
                    );
                  }
                  final expiry = DateTime.now().add(switch (_expiryPeriod) {
                    '5 Minutes' => const Duration(minutes: 5),
                    '1 Day' => const Duration(days: 1),
                    '3 Days' => const Duration(days: 3),
                    '1 Week' => const Duration(days: 7),
                    '2 Weeks' => const Duration(days: 14),
                    '1 Month' => const Duration(days: 30),
                    _ => const Duration(days: 30),
                  });
                  return Text(
                    '${expiry.day.toString().padLeft(2, '0')}/${expiry.month.toString().padLeft(2, '0')}/${expiry.year} ${expiry.hour.toString().padLeft(2, '0')}:${expiry.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontSize: 10,
                      color: UIConstants.textHint(isDarkTheme),
                    ),
                  );
                },
              ),
            ),
          ],

          const SizedBox(height: UIConstants.spacingSm),

          // Fee Input
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Row(
                  children: [
                    Text(
                      'Fee',
                      style: TextStyle(
                        fontSize: UIConstants.textFieldFontSize,
                        color: UIConstants.textSecondary(isDarkTheme),
                      ),
                    ),
                    if (_isLoadingFee) ...[
                      const SizedBox(width: 4),
                      SizedBox(
                        width: 10,
                        height: 10,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            UIConstants.textSecondary(isDarkTheme),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Expanded(
                child: _HoverInputField(
                  controller: _feeController,
                  hintText: 'Auto (1%)',
                  isDarkTheme: isDarkTheme,
                  suffixWidget: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Text(
                      _selectedCurrency['issueCurrency']?.isNotEmpty == true
                          ? _selectedCurrency['issueCurrency']!
                          : (_selectedCurrency['symbol'] ?? '\$'),
                      style: TextStyle(
                        color: UIConstants.textPrimary(isDarkTheme),
                        fontSize: UIConstants.textFieldFontSize,
                        fontWeight: UIConstants.fontWeightNormal,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: UIConstants.spacingSm),

          // Order Summary
          Builder(builder: (context) {
            final quantity = double.tryParse(_quantityController.text) ?? 0.0;
            final price = double.tryParse(_priceController.text) ?? 0.0;
            final hasQuantity = quantity > 0;
            final hasPrice = _orderType == 'Market'
                ? (_candles.isNotEmpty && _candles.first.close > 0)
                : price > 0;
            final fee = _parseFee();
            final hasFee = fee > 0 || _isLoadingFee;
            final total = _calculateTotal();
            final currencySymbol = _selectedCurrency['symbol'] ?? '';

            return Container(
              padding: UIConstants.paddingStandard,
              decoration: BoxDecoration(
                color: UIConstants.filterBarBackground(isDarkTheme),
                borderRadius: BorderRadius.circular(UIConstants.borderRadiusMd),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Est. Fee',
                        style: TextStyle(
                          fontSize: UIConstants.textFieldFontSize,
                          color: UIConstants.textSecondary(isDarkTheme),
                        ),
                      ),
                      Text(
                        (hasQuantity && hasPrice && fee > 0)
                            ? '${_roundToCurrencyPrecision(fee).toStringAsFixed(_getCurrencyDecimals())} $currencySymbol'
                            : '-',
                        style: TextStyle(
                          fontSize: UIConstants.textFieldFontSize,
                          color: UIConstants.textPrimary(isDarkTheme),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: UIConstants.spacingSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _orderType == 'Market' ? 'Est. Total' : 'Total',
                        style: TextStyle(
                          fontSize: UIConstants.textFieldFontSize,
                          fontWeight: UIConstants.fontWeightMedium,
                          color: UIConstants.textSecondary(isDarkTheme),
                        ),
                      ),
                      Text(
                        (hasQuantity && hasPrice) ? '${_formatDecimal(_roundToCurrencyPrecision(total).toStringAsFixed(_getCurrencyDecimals()))} $currencySymbol' : '-',
                        style: TextStyle(
                          fontSize: UIConstants.textFieldFontSize,
                          fontWeight: UIConstants.fontWeightMedium,
                          color: UIConstants.textPrimary(isDarkTheme),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: UIConstants.spacingMd),

          // Buy/Sell Order Button
          Builder(builder: (context) {
            final canPlace = _canPlaceOrder();
            final quantity = double.tryParse(_quantityController.text) ?? 0.0;
            final price = double.tryParse(_priceController.text) ?? 0.0;
            final hasInput = quantity > 0 && (_orderType == 'Market' || price > 0);
            final label = !hasInput
                ? '${_isBuySelected ? 'Buy' : 'Sell'} Order'
                : (!canPlace
                    ? 'Insufficient ${_isBuySelected ? 'funds' : 'holdings'}'
                    : '${_isBuySelected ? 'Buy' : 'Sell'} Order');
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: canPlace ? _placeOrder : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: canPlace
                      ? (_isBuySelected ? UIConstants.colorAccept : UIConstants.colorReject)
                      : Colors.grey[700],
                  foregroundColor: canPlace ? Colors.white : Colors.grey[400],
                  disabledBackgroundColor: Colors.grey[700],
                  disabledForegroundColor: Colors.grey[400],
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(UIConstants.borderRadiusMd),
                  ),
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: UIConstants.textFieldFontSize,
                    fontWeight: UIConstants.fontWeightMedium,
                  ),
                ),
              ),
            );
          }),
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
              fontWeight: UIConstants.fontWeightMedium,
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
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: widget.isSelected
                  ? Colors.white
                  : (_isHovered
                      ? widget.selectedColor
                      : (UIConstants.textSecondary(widget.isDarkTheme))),
              fontWeight: UIConstants.fontWeightMedium,
              fontSize: UIConstants.textFieldFontSize,
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
      ? UIConstants.colorAccept  // Cyan for buy
      : UIConstants.colorReject; // Pink for sell

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
                      : (UIConstants.textSecondary(widget.isDarkTheme))),
              fontWeight: UIConstants.fontWeightNormal,
              fontSize: UIConstants.textFieldFontSize,
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
  final List<TextInputFormatter>? inputFormatters;

  const _HoverInputField({
    required this.controller,
    required this.hintText,
    required this.isDarkTheme,
    this.suffixWidget,
    this.inputFormatters,
  });

  @override
  State<_HoverInputField> createState() => _HoverInputFieldState();
}

class _HoverInputFieldState extends State<_HoverInputField> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = UIConstants.cardBackground(widget.isDarkTheme);
    final borderColor = _isHovered
        ? (UIConstants.textHint(widget.isDarkTheme))
        : backgroundColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
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
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: widget.inputFormatters,
                style: TextStyle(
                  color: UIConstants.textPrimary(widget.isDarkTheme),
                  fontSize: UIConstants.textFieldFontSize,
                ),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: UIConstants.textHint(widget.isDarkTheme),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: UIConstants.textFieldContentPadding,
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
    final backgroundColor = UIConstants.cardBackground(widget.isDarkTheme);
    final borderColor = _isHovered
        ? (UIConstants.textHint(widget.isDarkTheme))
        : backgroundColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        height: 28,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
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

/// Limits decimal input to a maximum number of decimal places.
class _DecimalInputFormatter extends TextInputFormatter {
  final int maxDecimals;
  _DecimalInputFormatter(this.maxDecimals);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    if (text.isEmpty) return newValue;
    // Allow only digits and one dot
    if (!RegExp(r'^\d*\.?\d*$').hasMatch(text)) return oldValue;
    // Check decimal places
    final dotIndex = text.indexOf('.');
    if (dotIndex >= 0 && text.length - dotIndex - 1 > maxDecimals) return oldValue;
    return newValue;
  }
}
