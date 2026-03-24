import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/ui_constants.dart';
import '../../services/theme_service.dart';
import '../../services/real_grpc_client.dart';
import '../../services/grpc_helper.dart';
import '../../utils/menu_items_helper.dart';
import '../../widgets/base_page.dart';
import '../../widgets/styled_data_table.dart';
import '../../services/page_state_service.dart';

class SecurityOrderbooksPage extends StatefulWidget {
  const SecurityOrderbooksPage({super.key});

  @override
  State<SecurityOrderbooksPage> createState() => _SecurityOrderbooksPageState();
}

class _SecurityOrderbooksPageState extends State<SecurityOrderbooksPage> {
  // Markets, venues & securities
  List<Map<String, String>> _markets = [];
  Map<String, String> _selectedMarket = {};
  bool _isLoadingMarkets = false;

  List<Map<String, String>> _venues = [];
  Map<String, String> _selectedVenue = {'id': '', 'display': 'All Venues'};
  bool _isLoadingVenues = false;

  List<Map<String, dynamic>> _securities = [];
  Map<String, dynamic>? _selectedSecurity;
  bool _isLoadingSecurities = false;

  // Orderbook mode
  String _orderbookMode = 'ORDERBOOK_MODE_ENUM_L2_AGGREGATED_PRICE_LEVELS';
  static const _orderbookModeOptions = {
    'ORDERBOOK_MODE_ENUM_L1_BEST_BID_ASK': 'L1 Best Bid/Ask',
    'ORDERBOOK_MODE_ENUM_L2_AGGREGATED_PRICE_LEVELS': 'L2 Aggregated',
    'ORDERBOOK_MODE_ENUM_L3_INDIVIDUAL_ORDERS': 'L3 Individual Orders',
    'ORDERBOOK_MODE_ENUM_CUMULATIVE_DEPTH': 'Cumulative Depth',
    'ORDERBOOK_MODE_ENUM_ACTUAL': 'Actual',
  };

  // Orderbook data
  List<Map<String, dynamic>> _sellOrders = [];
  List<Map<String, dynamic>> _buyOrders = [];
  bool _isLoadingSellOrders = false;
  bool _isLoadingBuyOrders = false;
  int _currentSellOrdersPage = 1;
  int _currentBuyOrdersPage = 1;
  int _totalSellOrdersPages = 1;
  int _totalBuyOrdersPages = 1;
  static const int _orderbookPageSize = 5;

  // Trade history data
  List<Map<String, dynamic>> _tradeHistory = [];
  bool _isLoadingTradeHistory = false;
  int _currentTradeHistoryPage = 1;
  int _totalTradeHistoryPages = 1;
  static const int _tradeHistoryPageSize = 15;

  // Auto-refresh
  Timer? _refreshTimer;

  static const _pageId = 'security_orderbooks';

  void _saveState() {
    PageStateService.instance.save(_pageId, {
      'selectedMarket': _selectedMarket,
      'selectedVenue': _selectedVenue,
      'selectedSecuritySymbol': _selectedSecurity?['symbol'],
      'orderbookMode': _orderbookMode,
      'markets': _markets,
      'venues': _venues,
      'securities': _securities,
    });
  }

  void _restoreState() {
    final state = PageStateService.instance.get(_pageId);
    if (state != null) {
      _orderbookMode = state['orderbookMode'] ?? 'ORDERBOOK_MODE_ENUM_L2_AGGREGATED_PRICE_LEVELS';

      final savedMarkets = state['markets'];
      if (savedMarkets is List && savedMarkets.isNotEmpty) {
        _markets = savedMarkets.map((m) => Map<String, String>.from(m as Map)).toList();
        final savedMarketId = (state['selectedMarket'] as Map?)?['id'];
        if (savedMarketId != null) {
          _selectedMarket = _markets.firstWhere((m) => m['id'] == savedMarketId, orElse: () => _markets.first);
        }
      }
      final savedVenues = state['venues'];
      if (savedVenues is List && savedVenues.isNotEmpty) {
        _venues = savedVenues.map((v) => Map<String, String>.from(v as Map)).toList();
        final savedVenueId = (state['selectedVenue'] as Map?)?['id'];
        if (savedVenueId != null) {
          _selectedVenue = _venues.firstWhere((v) => v['id'] == savedVenueId, orElse: () => _venues.first);
        }
      }
      final savedSecurities = state['securities'];
      if (savedSecurities is List && savedSecurities.isNotEmpty) {
        _securities = savedSecurities.map((s) => Map<String, dynamic>.from(s as Map)).toList();
        final savedSymbol = state['selectedSecuritySymbol'];
        if (savedSymbol != null) {
          _selectedSecurity = _securities.firstWhere(
            (s) => s['symbol'] == savedSymbol,
            orElse: () => _securities.first,
          );
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _restoreState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_markets.isEmpty) {
        _fetchMarkets();
      } else if (_selectedSecurity != null) {
        // Already have state, just refresh data
        _onSecuritySelected(_selectedSecurity!);
      }
    });
  }

  @override
  void dispose() {
    _saveState();
    _refreshTimer?.cancel();
    super.dispose();
  }

  void _startRefreshTimer() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted && _selectedSecurity != null) {
        final symbol = _selectedSecurity!['symbol'] as String? ?? '';
        if (symbol.isNotEmpty) {
          _fetchOrderbookData(symbol);
          _fetchTradeHistoryForSecurity(symbol, pageNumber: _currentTradeHistoryPage);
        }
      }
    });
  }

  // ── Market fetching ──

  Future<void> _fetchMarkets() async {
    setState(() => _isLoadingMarkets = true);

    try {
      final result = await realGrpcClient.getMarketList().timeout(
        const Duration(minutes: 5),
        onTimeout: () => {'success': false, 'output': {'error': 'Timeout'}},
      );

      if (result['success'] == true && result['output'] != null) {
        final output = result['output'] as Map<String, dynamic>;
        final markets = output['markets'] as List<dynamic>? ?? [];
        final List<Map<String, String>> marketData = [];

        for (final market in markets) {
          if (market is Map<String, dynamic>) {
            final identifiers = market['identifiers'] as List<dynamic>? ?? [];
            final displayNames = market['displayNames'] as Map<String, dynamic>? ?? {};
            String? marketId;
            String? marketName;

            if (identifiers.isNotEmpty) {
              final identifier = identifiers[0] as Map<String, dynamic>? ?? {};
              final ids = identifier['ids'] as List<dynamic>? ?? [];
              if (ids.isNotEmpty) {
                final idObj = ids[0] as Map<String, dynamic>? ?? {};
                marketId = idObj['value'] as String?;
              }
            }
            if (marketId == null || marketId.isEmpty) {
              marketId = market['iid']?.toString();
            }
            marketName = displayNames['en'] as String? ?? marketId;

            if (marketId != null && marketId.isNotEmpty) {
              marketData.add({
                'id': marketId,
                'name': marketName ?? marketId,
                'display': marketName ?? marketId,
              });
            }
          }
        }

        setState(() {
          _markets = marketData;
          if (_markets.isNotEmpty) {
            if (_selectedMarket.isNotEmpty) {
              _selectedMarket = _markets.firstWhere((m) => m['id'] == _selectedMarket['id'], orElse: () => _markets.first);
            } else {
              _selectedMarket = _markets.first;
            }
          }
          _isLoadingMarkets = false;
        });

        if (_selectedMarket.isNotEmpty && _selectedMarket['id']!.isNotEmpty) {
          await _fetchVenues(_selectedMarket['id']!);
          _fetchMarketSecurities(_selectedMarket['id']!);
        }
      } else {
        setState(() => _isLoadingMarkets = false);
      }
    } catch (e) {
      print('Error fetching markets: $e');
      setState(() => _isLoadingMarkets = false);
    }
  }

  // ── Venue fetching ──

  Future<void> _fetchVenues(String marketId) async {
    if (_isLoadingVenues) return;
    setState(() => _isLoadingVenues = true);

    try {
      final result = await realGrpcClient.getVenueList().timeout(
        const Duration(minutes: 5),
        onTimeout: () => {'success': false, 'output': {'error': 'Timeout'}},
      );

      if (result['success'] == true && result['output'] != null) {
        final output = result['output'];
        final venues = output['venues'] as List<dynamic>? ?? [];
        final venueData = <Map<String, String>>[];
        final addedVenueIds = <String>{};

        venueData.add({'id': '', 'display': 'All Venues'});
        addedVenueIds.add('');

        for (final venue in venues) {
          if (venue is Map<String, dynamic>) {
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
            if (venueValue.isEmpty) {
              venueValue = venue['iid']?.toString() ?? '';
            }
            final displayNames = venue['displayNames'] as Map<String, dynamic>? ?? {};
            final displayName = displayNames['en']?.toString() ?? venueValue;

            if (venueValue.isNotEmpty && !addedVenueIds.contains(venueValue)) {
              venueData.add({
                'id': venueValue,
                'display': displayName.isNotEmpty ? displayName : venueValue,
              });
              addedVenueIds.add(venueValue);
            }
          }
        }

        setState(() {
          _venues = venueData;
          if (_venues.isNotEmpty) {
            if (_selectedVenue['id']!.isNotEmpty) {
              _selectedVenue = _venues.firstWhere((v) => v['id'] == _selectedVenue['id'], orElse: () => _venues.first);
            } else {
              _selectedVenue = _venues.first;
            }
          }
          _isLoadingVenues = false;
        });
      } else {
        setState(() {
          _venues = [{'id': '', 'display': 'All Venues'}];
          _selectedVenue = _venues.first;
          _isLoadingVenues = false;
        });
      }
    } catch (e) {
      print('Error fetching venues: $e');
      setState(() {
        _venues = [{'id': '', 'display': 'All Venues'}];
        _selectedVenue = _venues.first;
        _isLoadingVenues = false;
      });
    }
  }

  // ── Securities fetching ──

  Future<void> _fetchMarketSecurities(String marketId) async {
    setState(() {
      _isLoadingSecurities = true;
      _securities.clear();
      _selectedSecurity = null;
    });

    try {
      final result = await realGrpcClient.getMarketSecurityList(
        marketId: marketId,
        pageNumber: 0,
        pageSize: 0,
      ).timeout(
        const Duration(minutes: 5),
        onTimeout: () => {'success': false, 'output': {'error': 'Timeout'}},
      );

      if (result['success'] == true && result['output'] != null) {
        final output = result['output'] as Map<String, dynamic>;
        final securities = output['securityListings'] as List<dynamic>? ?? [];
        final List<Map<String, dynamic>> processed = [];
        final addedSymbols = <String>{};

        for (final security in securities) {
          if (security is Map<String, dynamic>) {
            String symbol = security['symbol'] as String? ?? '';
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
            }

            final iid = security['securityListingIid']?.toString() ?? security['security_listing_iid']?.toString() ?? '';
            final issueCurrency = security['currency'] as String? ?? security['issueCurrency']?.toString() ?? '';
            final securityStatus = security['securityStatus'] as String? ?? security['security_status'] as String? ?? '';

            if (securityStatus.isNotEmpty && securityStatus.toUpperCase() != 'ACTIVE' && securityStatus != '1') {
              continue;
            }

            if (symbol.isNotEmpty && !addedSymbols.contains(symbol)) {
              addedSymbols.add(symbol);
              processed.add({
                'symbol': symbol,
                'issueCurrency': issueCurrency,
                'iid': iid,
              });
            }
          }
        }

        setState(() {
          _securities = processed;
          if (_securities.isNotEmpty) {
            if (_selectedSecurity != null) {
              _selectedSecurity = _securities.firstWhere(
                (s) => s['symbol'] == _selectedSecurity!['symbol'],
                orElse: () => _securities.first,
              );
            } else {
              _selectedSecurity = _securities.first;
            }
          }
          _isLoadingSecurities = false;
        });

        if (_selectedSecurity != null) {
          _onSecuritySelected(_selectedSecurity!);
        }
      } else {
        setState(() => _isLoadingSecurities = false);
      }
    } catch (e) {
      print('Error fetching securities: $e');
      setState(() => _isLoadingSecurities = false);
    }
  }

  void _onSecuritySelected(Map<String, dynamic> security) {
    final symbol = security['symbol'] as String? ?? '';
    if (symbol.isEmpty) return;
    _fetchOrderbookData(symbol);
    _fetchTradeHistoryForSecurity(symbol, pageNumber: 1);
    _startRefreshTimer();
  }

  // ── Orderbook fetching ──

  Future<void> _fetchOrderbookData(String symbol) async {
    _currentSellOrdersPage = 1;
    _currentBuyOrdersPage = 1;
    _totalSellOrdersPages = 1;
    _totalBuyOrdersPages = 1;

    await Future.wait([
      _fetchSellOrders(symbol, pageNumber: 1),
      _fetchBuyOrders(symbol, pageNumber: 1),
    ]);
  }

  Future<void> _fetchSellOrders(String symbol, {int pageNumber = 1}) async {
    final security = _securities.firstWhere(
      (s) => s['symbol'] == symbol,
      orElse: () => <String, dynamic>{},
    );
    if (security.isEmpty) return;

    final securityIid = security['iid']?.toString() ?? '';
    if (securityIid.isEmpty) return;

    setState(() => _isLoadingSellOrders = true);

    try {
      final result = await GrpcHelper.getOrderbook(
        securityIid: securityIid,
        side: 'ORDER_SIDE_ENUM_SELL',
        pageNumber: pageNumber,
        pageSize: _orderbookPageSize,
        mode: _orderbookMode,
      );

      List<Map<String, dynamic>> sellOrders = [];

      if (result['success'] == true && result['output'] != null) {
        final output = result['output'] as Map<String, dynamic>;
        final sellList = output['sellList'] as Map<String, dynamic>? ?? {};
        final orders = sellList['orders'] as List<dynamic>? ?? [];

        sellOrders = orders.map<Map<String, dynamic>>((order) {
          final orderMap = order as Map<String, dynamic>;
          return _mapOrderbookOrder(orderMap);
        }).toList();
      }

      if (mounted) {
        setState(() {
          _sellOrders = sellOrders;
          _currentSellOrdersPage = pageNumber;
          if (sellOrders.length == _orderbookPageSize) {
            // Full page: there might be more — ensure total is at least pageNumber + 1
            if (_totalSellOrdersPages <= pageNumber) {
              _totalSellOrdersPages = pageNumber + 1;
            }
          } else {
            // Partial page: this is the last page
            _totalSellOrdersPages = pageNumber;
          }
          _isLoadingSellOrders = false;
        });
      }
    } catch (e) {
      print('Error fetching sell orders: $e');
      if (mounted) {
        setState(() {
          _sellOrders = [];
          _totalSellOrdersPages = 1;
          _isLoadingSellOrders = false;
        });
      }
    }
  }

  Future<void> _fetchBuyOrders(String symbol, {int pageNumber = 1}) async {
    final security = _securities.firstWhere(
      (s) => s['symbol'] == symbol,
      orElse: () => <String, dynamic>{},
    );
    if (security.isEmpty) return;

    final securityIid = security['iid']?.toString() ?? '';
    if (securityIid.isEmpty) return;

    setState(() => _isLoadingBuyOrders = true);

    try {
      final result = await GrpcHelper.getOrderbook(
        securityIid: securityIid,
        side: 'ORDER_SIDE_ENUM_BUY',
        pageNumber: pageNumber,
        pageSize: _orderbookPageSize,
        mode: _orderbookMode,
      );

      List<Map<String, dynamic>> buyOrders = [];

      if (result['success'] == true && result['output'] != null) {
        final output = result['output'] as Map<String, dynamic>;
        final buyList = output['buyList'] as Map<String, dynamic>? ?? {};
        final orders = buyList['orders'] as List<dynamic>? ?? [];

        buyOrders = orders.map<Map<String, dynamic>>((order) {
          final orderMap = order as Map<String, dynamic>;
          return _mapOrderbookOrder(orderMap);
        }).toList();
      }

      if (mounted) {
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
        });
      }
    } catch (e) {
      print('Error fetching buy orders: $e');
      if (mounted) {
        setState(() {
          _buyOrders = [];
          _totalBuyOrdersPages = 1;
          _isLoadingBuyOrders = false;
        });
      }
    }
  }

  Map<String, dynamic> _mapOrderbookOrder(Map<String, dynamic> orderMap) {
    final priceValue = orderMap['price'];
    final quantityValue = orderMap['quantity'];

    final rawPrice = priceValue is String
        ? double.tryParse(priceValue) ?? 0.0
        : (priceValue is num ? priceValue.toDouble() : 0.0);
    final price = rawPrice / 100.0;
    final quantity = quantityValue is String
        ? double.tryParse(quantityValue) ?? 0.0
        : (quantityValue is num ? quantityValue.toDouble() : 0.0);
    final total = _roundToDecimals(price * quantity, _getCurrencyDecimals());

    // L3: check expire_ts against now (orderbook sends seconds)
    final expireTs = orderMap['expireTimestamp'] ?? orderMap['expire_timestamp'] ?? orderMap['expireTs'] ?? orderMap['expire_ts'] ?? '';
    final expireNum = int.tryParse(expireTs.toString()) ?? 0;
    final hasExpiry = expireNum > 0;
    final expireMillis = expireNum * 1000;
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
  }

  // ── Trade history fetching ──

  Future<void> _fetchTradeHistoryForSecurity(String symbol, {int pageNumber = 1}) async {
    final security = _securities.firstWhere(
      (s) => s['symbol'] == symbol,
      orElse: () => <String, dynamic>{},
    );
    if (security.isEmpty) return;

    final securityIid = security['iid']?.toString() ?? '';
    if (securityIid.isEmpty) return;

    setState(() => _isLoadingTradeHistory = true);

    try {
      final result = await GrpcHelper.getSecurityTrades(
        securityId: securityIid,
        pageNumber: pageNumber,
        pageSize: _tradeHistoryPageSize,
      );

      List<Map<String, dynamic>> parsedTrades = [];

      if (result['success'] == true && result['output'] != null) {
        final output = result['output'] as Map<String, dynamic>;
        final trades = output['trades'] as List<dynamic>? ?? [];

        parsedTrades = trades.map<Map<String, dynamic>>((trade) {
          final tradeMap = trade as Map<String, dynamic>;
          final priceValue = tradeMap['price'];
          final quantityValue = tradeMap['quantity'];
          final timestampValue = tradeMap['timestamp'];
          final isBuy = tradeMap['isBuy'] ?? tradeMap['is_buy'] ?? false;

          final rawPrice = priceValue is String
              ? double.tryParse(priceValue) ?? 0.0
              : (priceValue is num ? priceValue.toDouble() : 0.0);
          final price = rawPrice / 100.0;
          final quantity = quantityValue is String
              ? double.tryParse(quantityValue) ?? 0.0
              : (quantityValue is num ? quantityValue.toDouble() : 0.0);

          final time = _formatTradeTimestamp(timestampValue);
          final priceColor = isBuy ? UIConstants.colorAccept : UIConstants.colorReject;

          return {
            'price': price.toStringAsFixed(2),
            'quantity': quantity.toInt().toString(),
            'time': time,
            'priceColor': priceColor,
          };
        }).toList();
      }

      if (mounted) {
        setState(() {
          _tradeHistory = List.from(parsedTrades);
          _currentTradeHistoryPage = pageNumber;
          _totalTradeHistoryPages = parsedTrades.length == _tradeHistoryPageSize ? pageNumber + 1 : pageNumber;
          _isLoadingTradeHistory = false;
        });
      }
    } catch (e) {
      print('Error fetching trade history: $e');
      if (mounted) {
        setState(() {
          _tradeHistory = [];
          _isLoadingTradeHistory = false;
        });
      }
    }
  }

  // ── Helpers ──

  String _formatTradeTimestamp(dynamic timestampValue) {
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
      final yy = (dt.year % 100).toString().padLeft(2, '0');
      return '${dt.day}/${dt.month}/$yy ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}';
    } catch (_) {
      return '';
    }
  }

  int _getCurrencyDecimals() {
    final currency = _selectedSecurity?['issueCurrency'] ?? '';
    return _defaultDivisibility(currency);
  }

  int _defaultDivisibility(String currencyCode) {
    final code = currencyCode.toUpperCase();
    final shortCode = code.length >= 3 ? code.substring(0, 3) : code;
    const zeroDivisibility = {'JPY', 'KRW', 'VND', 'CLP'};
    if (zeroDivisibility.contains(shortCode)) return 0;
    const threeDivisibility = {'BHD', 'KWD', 'OMR'};
    if (threeDivisibility.contains(shortCode)) return 3;
    return 2;
  }

  double _roundToDecimals(double value, int decimals) {
    double factor = 1;
    for (var i = 0; i < decimals; i++) factor *= 10;
    return (value * factor).roundToDouble() / factor;
  }

  String _formatPrice(double price) {
    final decimals = _getCurrencyDecimals();
    return _roundToDecimals(price, decimals).toStringAsFixed(decimals);
  }

  String _expiredDurationText(Map<String, dynamic> order) {
    final ts = order['expire_timestamp'];
    final unit = order['expire_ts_unit'] ?? 's';
    if (ts == null) return 'Expired';
    final str = ts.toString().trim();
    if (str.isEmpty || str == '0') return 'Expired';
    final n = int.tryParse(str);
    if (n == null || n <= 0) return 'Expired';
    final millis = unit == 's' ? n * 1000 : n;
    final dt = DateTime.fromMillisecondsSinceEpoch(millis);
    final diff = DateTime.now().difference(dt);
    if (diff.inDays > 0) return 'Expired ${diff.inDays}d ${diff.inHours % 24}h ago';
    if (diff.inHours > 0) return 'Expired ${diff.inHours}h ${diff.inMinutes % 60}m ago';
    if (diff.inMinutes > 0) return 'Expired ${diff.inMinutes}m ago';
    return 'Expired ${diff.inSeconds}s ago';
  }

  void _goToSellOrdersPage(int page) {
    if (page >= 1 && page != _currentSellOrdersPage && _selectedSecurity != null) {
      _fetchSellOrders(_selectedSecurity!['symbol'], pageNumber: page);
    }
  }

  void _goToBuyOrdersPage(int page) {
    if (page >= 1 && page != _currentBuyOrdersPage && _selectedSecurity != null) {
      _fetchBuyOrders(_selectedSecurity!['symbol'], pageNumber: page);
    }
  }

  void _goToTradeHistoryPage(int page) {
    if (page >= 1 && page != _currentTradeHistoryPage && _selectedSecurity != null) {
      _fetchTradeHistoryForSecurity(_selectedSecurity!['symbol'], pageNumber: page);
    }
  }

  // ── Build ──

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final isDarkTheme = themeService.isDarkTheme;

    return BasePage(
      menuItems: MenuItemsHelper.buildMenuItems(context, 'security_orderbooks'),
      content: Container(
        color: UIConstants.pageBackground(isDarkTheme),
        padding: UIConstants.paddingComfortable,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTitleRow(isDarkTheme),
            const SizedBox(height: UIConstants.spacingMd),
            _buildControlsRow(isDarkTheme),
            const SizedBox(height: UIConstants.spacingMd),
            Expanded(
              child: _selectedSecurity == null
                  ? Center(
                      child: Text(
                        _isLoadingSecurities ? 'Loading securities...' : 'Select a security to view its orderbook',
                        style: TextStyle(color: UIConstants.textSecondary(isDarkTheme), fontSize: 14),
                      ),
                    )
                  : _buildOrderbookAndTradeHistory(isDarkTheme),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleRow(bool isDarkTheme) {
    return Row(
      children: [
        Text(
          'Security Orderbooks',
          style: TextStyle(
            fontSize: UIConstants.fontSizeLg,
            fontWeight: UIConstants.fontWeightBold,
            color: UIConstants.textPrimary(isDarkTheme),
          ),
        ),
        const Spacer(),
        if (_selectedSecurity != null)
          IconButton(
            icon: const Icon(Icons.refresh, size: 20),
            tooltip: 'Refresh',
            color: UIConstants.textSecondary(isDarkTheme),
            onPressed: () {
              final symbol = _selectedSecurity!['symbol'] as String? ?? '';
              if (symbol.isNotEmpty) {
                _fetchOrderbookData(symbol);
                _fetchTradeHistoryForSecurity(symbol, pageNumber: 1);
              }
            },
          ),
      ],
    );
  }

  Widget _buildControlsRow(bool isDarkTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Line 1: Market + Venue
        Row(
          children: [
            SizedBox(width: 200, child: _buildMarketDropdown(isDarkTheme)),
            const SizedBox(width: 12),
            SizedBox(width: 200, child: _buildVenueDropdown(isDarkTheme)),
          ],
        ),
        const SizedBox(height: 8),
        // Line 2: Security
        Row(
          children: [
            SizedBox(width: 450, child: _buildSecurityDropdown(isDarkTheme)),
          ],
        ),
        const SizedBox(height: 8),
        // Line 3: Mode
        Row(
          children: [
            SizedBox(width: 220, child: _buildModeDropdown(isDarkTheme)),
          ],
        ),
      ],
    );
  }

  Widget _buildMarketDropdown(bool isDarkTheme) {
    return SizedBox(
      height: 34,
      child: DropdownButtonFormField<Map<String, String>>(
        value: _markets.isEmpty ? null : _selectedMarket,
        isDense: true,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: 'Market',
          labelStyle: TextStyle(color: UIConstants.textSecondary(isDarkTheme), fontSize: UIConstants.fontSizeSm),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          isDense: true,
        ),
        style: TextStyle(color: UIConstants.textPrimary(isDarkTheme), fontSize: UIConstants.fontSizeSm),
        dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
        items: _markets.map((m) => DropdownMenuItem(
          value: m,
          child: Text(m['display'] ?? m['id']!, style: TextStyle(color: UIConstants.textPrimary(isDarkTheme), fontSize: UIConstants.fontSizeSm)),
        )).toList(),
        onChanged: _markets.isEmpty ? null : (value) async {
          if (value != null) {
            setState(() {
              _selectedMarket = value;
              _venues = [{'id': '', 'display': 'All Venues'}];
              _selectedVenue = _venues.first;
            });
            await _fetchVenues(value['id']!);
            _fetchMarketSecurities(value['id']!);
          }
        },
      ),
    );
  }

  Widget _buildVenueDropdown(bool isDarkTheme) {
    return SizedBox(
      height: 34,
      child: DropdownButtonFormField<Map<String, String>>(
        value: _venues.isEmpty ? null : _selectedVenue,
        isDense: true,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: 'Venue',
          labelStyle: TextStyle(color: UIConstants.textSecondary(isDarkTheme), fontSize: UIConstants.fontSizeSm),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          isDense: true,
        ),
        style: TextStyle(color: UIConstants.textPrimary(isDarkTheme), fontSize: UIConstants.fontSizeSm),
        dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
        items: _venues.map((v) => DropdownMenuItem(
          value: v,
          child: Text(v['display'] ?? v['id']!, style: TextStyle(color: UIConstants.textPrimary(isDarkTheme), fontSize: UIConstants.fontSizeSm)),
        )).toList(),
        onChanged: _venues.isEmpty ? null : (value) {
          if (value != null) {
            setState(() => _selectedVenue = value);
          }
        },
      ),
    );
  }

  Widget _buildSecurityDropdown(bool isDarkTheme) {
    return SizedBox(
      height: 34,
      child: DropdownButtonFormField<Map<String, dynamic>>(
        value: _selectedSecurity,
        isDense: true,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: 'Security',
          labelStyle: TextStyle(color: UIConstants.textSecondary(isDarkTheme), fontSize: UIConstants.fontSizeSm),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          isDense: true,
        ),
        style: TextStyle(color: UIConstants.textPrimary(isDarkTheme), fontSize: UIConstants.fontSizeSm),
        dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
        items: _securities.map((s) {
          final symbol = s['symbol'] ?? '';
          final currency = s['issueCurrency'] ?? '';
          final iid = s['iid'] ?? '';
          final label = '$symbol  |  $currency  |  $iid';
          return DropdownMenuItem(
            value: s,
            child: Text(label, style: TextStyle(color: UIConstants.textPrimary(isDarkTheme), fontSize: UIConstants.fontSizeSm), overflow: TextOverflow.ellipsis),
          );
        }).toList(),
        onChanged: _securities.isEmpty ? null : (value) {
          if (value != null) {
            setState(() => _selectedSecurity = value);
            _onSecuritySelected(value);
          }
        },
      ),
    );
  }

  Widget _buildModeDropdown(bool isDarkTheme) {
    return SizedBox(
      height: 34,
      child: DropdownButtonFormField<String>(
        value: _orderbookMode,
        isDense: true,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: 'Mode',
          labelStyle: TextStyle(color: UIConstants.textSecondary(isDarkTheme), fontSize: UIConstants.fontSizeSm),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          isDense: true,
        ),
        style: TextStyle(color: UIConstants.textPrimary(isDarkTheme), fontSize: UIConstants.fontSizeSm),
        dropdownColor: UIConstants.dropdownBackground(isDarkTheme),
        items: _orderbookModeOptions.entries
            .map((e) => DropdownMenuItem(
                  value: e.key,
                  child: Text(e.value, style: TextStyle(color: UIConstants.textPrimary(isDarkTheme), fontSize: UIConstants.fontSizeSm)),
                ))
            .toList(),
        onChanged: (value) {
          if (value != null && value != _orderbookMode) {
            setState(() {
              _orderbookMode = value;
              _currentSellOrdersPage = 1;
              _currentBuyOrdersPage = 1;
            });
            if (_selectedSecurity != null) {
              _fetchOrderbookData(_selectedSecurity!['symbol']);
            }
          }
        },
      ),
    );
  }

  // ── Orderbook + Trade History panels ──

  Widget _buildOrderbookAndTradeHistory(bool isDarkTheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Orderbook panel
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: UIConstants.tabPanelBackground(isDarkTheme),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: UIConstants.visibleBorderColor(isDarkTheme)),
            ),
            child: _buildOrderbookPanel(isDarkTheme),
          ),
        ),
        const SizedBox(width: 12),
        // Trade History panel
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: UIConstants.tabPanelBackground(isDarkTheme),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: UIConstants.visibleBorderColor(isDarkTheme)),
            ),
            child: _buildTradeHistoryPanel(isDarkTheme),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderbookPanel(bool isDarkTheme) {
    return Container(
      padding: UIConstants.paddingStandard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Orderbook',
            style: TextStyle(
              fontSize: UIConstants.fontSizeMd,
              fontWeight: UIConstants.fontWeightBold,
              color: UIConstants.textPrimary(isDarkTheme),
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
                      Text('Sell Orders', style: TextStyle(fontSize: UIConstants.fontSizeMd, fontWeight: UIConstants.fontWeightMedium, color: UIConstants.textPrimary(isDarkTheme))),
                      const SizedBox(height: UIConstants.spacingSm),
                      _buildOrderbookHeader(isDarkTheme),
                      const SizedBox(height: UIConstants.spacingSm),
                      Divider(color: Colors.grey, thickness: 0.7, height: 1),
                      const SizedBox(height: UIConstants.spacingSm),
                      Expanded(child: _buildOrderbookSide(isDarkTheme, 'sell')),
                      _buildPaginationControls(_currentSellOrdersPage, _totalSellOrdersPages, _goToSellOrdersPage),
                    ],
                  ),
                ),
                const SizedBox(height: UIConstants.spacingMd),
                // Buy Orders Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Buy Orders', style: TextStyle(fontSize: UIConstants.fontSizeMd, fontWeight: UIConstants.fontWeightMedium, color: UIConstants.textPrimary(isDarkTheme))),
                      const SizedBox(height: UIConstants.spacingSm),
                      _buildOrderbookHeader(isDarkTheme),
                      const SizedBox(height: UIConstants.spacingSm),
                      Divider(color: Colors.grey, thickness: 0.7, height: 1),
                      const SizedBox(height: UIConstants.spacingSm),
                      Expanded(child: _buildOrderbookSide(isDarkTheme, 'buy')),
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

  Widget _buildOrderbookHeader(bool isDarkTheme) {
    return Row(
      children: [
        Expanded(child: Text('Price', style: TextStyle(color: Colors.grey[400], fontWeight: UIConstants.fontWeightMedium, fontSize: UIConstants.fontSizeSm), textAlign: TextAlign.left)),
        Expanded(child: Text('Quantity', style: TextStyle(color: Colors.grey[400], fontWeight: UIConstants.fontWeightMedium, fontSize: UIConstants.fontSizeSm), textAlign: TextAlign.center)),
        Expanded(child: Text('Total', style: TextStyle(color: Colors.grey[400], fontWeight: UIConstants.fontWeightMedium, fontSize: UIConstants.fontSizeSm), textAlign: TextAlign.right)),
      ],
    );
  }

  Widget _buildOrderbookSide(bool isDarkTheme, String side) {
    final orders = side == 'sell' ? _sellOrders : _buyOrders;
    final isLoading = side == 'sell' ? _isLoadingSellOrders : _isLoadingBuyOrders;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (orders.isEmpty) {
      return Center(
        child: Text('No $side orders', style: TextStyle(color: UIConstants.textSecondary(isDarkTheme), fontSize: UIConstants.textFieldFontSize)),
      );
    }

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        final color = side == 'sell' ? UIConstants.colorReject : UIConstants.colorAccept;
        final isExpired = order['is_expired'] == true;

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
          child: Row(
            children: [
              if (isExpired)
                Tooltip(
                  message: _expiredDurationText(order),
                  child: const Icon(Icons.warning_amber, size: 12, color: Colors.orange),
                ),
              if (isExpired) const SizedBox(width: 2),
              Expanded(
                child: Text(_formatPrice(order['price']), style: TextStyle(color: color, fontSize: UIConstants.fontSizeSm, fontWeight: UIConstants.fontWeightNormal), textAlign: TextAlign.left),
              ),
              Expanded(
                child: Text((order['quantity'] as num).toInt().toString(), style: TextStyle(color: UIConstants.textPrimary(isDarkTheme), fontSize: UIConstants.fontSizeSm), textAlign: TextAlign.center),
              ),
              Expanded(
                child: Text(_formatPrice(order['total'] ?? 0.0), style: TextStyle(color: UIConstants.textSecondary(isDarkTheme), fontSize: UIConstants.fontSizeSm), textAlign: TextAlign.right),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTradeHistoryPanel(bool isDarkTheme) {
    return Container(
      padding: UIConstants.paddingStandard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trade History',
            style: TextStyle(
              fontSize: UIConstants.fontSizeMd,
              fontWeight: UIConstants.fontWeightBold,
              color: UIConstants.textPrimary(isDarkTheme),
            ),
          ),
          const SizedBox(height: UIConstants.spacingMd),
          Expanded(
            child: _isLoadingTradeHistory
                ? const Center(child: CircularProgressIndicator())
                : _tradeHistory.isEmpty
                    ? Center(child: Text('No trades', style: TextStyle(color: UIConstants.textSecondary(isDarkTheme), fontSize: UIConstants.textFieldFontSize)))
                    : StyledDataTable(
                        isDarkTheme: isDarkTheme,
                        columns: const [
                          StyledColumn(label: 'Price', flex: 2),
                          StyledColumn(label: 'Quantity', flex: 1),
                          StyledColumn(label: 'Time', flex: 2),
                        ],
                        rows: _tradeHistory.map((trade) {
                          return StyledRow(cells: [
                            Text(trade['price'].toString(), style: TextStyle(color: UIConstants.textPrimary(isDarkTheme), fontWeight: UIConstants.fontWeightMedium, fontSize: UIConstants.fontSizeSm)),
                            Text(trade['quantity'].toString(), style: TextStyle(color: UIConstants.textPrimary(isDarkTheme), fontSize: UIConstants.fontSizeSm)),
                            Text(trade['time'].toString(), style: TextStyle(color: Colors.grey, fontSize: UIConstants.fontSizeSm)),
                          ]);
                        }).toList(),
                        onPageChanged: _goToTradeHistoryPage,
                        currentPage: _currentTradeHistoryPage,
                        totalPages: _totalTradeHistoryPages,
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationControls(int currentPage, int totalPages, Function(int) onPageTap) {
    if (totalPages <= 1) return const SizedBox.shrink();

    final themeService = Provider.of<ThemeService>(context, listen: false);
    final isDarkTheme = themeService.isDarkTheme;

    List<Widget> pageButtons = [];

    // Previous button
    pageButtons.add(
      InkWell(
        onTap: currentPage > 1 ? () => onPageTap(currentPage - 1) : null,
        child: Container(
          width: 24, height: 24,
          decoration: BoxDecoration(
            color: currentPage > 1 ? UIConstants.visibleBorderColor(isDarkTheme) : Colors.transparent,
            borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
          ),
          child: Icon(Icons.chevron_left, size: 16, color: currentPage > 1 ? UIConstants.textPrimary(isDarkTheme) : Colors.grey),
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
              width: 24, height: 24,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: i == currentPage ? Colors.blue : UIConstants.visibleBorderColor(isDarkTheme),
                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
              ),
              child: Center(
                child: Text(i.toString(), style: TextStyle(fontSize: UIConstants.fontSizeSm, color: i == currentPage ? Colors.white : UIConstants.textPrimary(isDarkTheme))),
              ),
            ),
          ),
        );
      } else if (i == currentPage - 2 || i == currentPage + 2) {
        pageButtons.add(
          Container(
            width: 24, height: 24,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            child: Center(child: Text('...', style: TextStyle(fontSize: UIConstants.fontSizeSm, color: isDarkTheme ? Colors.white70 : Colors.black54))),
          ),
        );
      }
    }

    // Next button
    pageButtons.add(
      InkWell(
        onTap: currentPage < totalPages ? () => onPageTap(currentPage + 1) : null,
        child: Container(
          width: 24, height: 24,
          decoration: BoxDecoration(
            color: currentPage < totalPages ? UIConstants.visibleBorderColor(isDarkTheme) : Colors.transparent,
            borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
          ),
          child: Icon(Icons.chevron_right, size: 16, color: currentPage < totalPages ? UIConstants.textPrimary(isDarkTheme) : Colors.grey),
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: pageButtons),
    );
  }
}
