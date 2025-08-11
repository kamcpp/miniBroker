import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../services/auth_service.dart';
import '../services/fix_client_service.dart';
import '../config/environment_config.dart';
import '../main.dart';
import 'home_page.dart';

class MiniBrokerPage extends StatefulWidget {
  const MiniBrokerPage({super.key});

  @override
  State<MiniBrokerPage> createState() => _MiniBrokerPageState();
}

class _MiniBrokerPageState extends State<MiniBrokerPage> {
  bool _isDarkTheme = true;
  String _selectedSymbol = '';  // Will be set when assets are loaded
  String _orderType = 'Market';
  bool _isBuySelected = true;
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  
  // Message stream subscription
  StreamSubscription<String>? _messageSubscription;
  bool _hasRequestedSecurityDefinitions = false;
  Timer? _securityRequestTimeout;
  
  @override
  void initState() {
    super.initState();
    // Listen for connection status changes and show notifications
    _listenToConnectionStatus();
    // Listen for FIX messages to handle Security Definition Responses
    _listenToFixMessages();
  }
  
  void _listenToConnectionStatus() {
    FixClientService.instance.connectionStatusStream.listen((isConnected) {
      if (mounted) {
        if (isConnected) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ Connected to FIX staging environment'),
              backgroundColor: Colors.green,
              duration: Duration(milliseconds: 1500), // Reduced from 3 seconds to 1.5 seconds
            ),
          );
        } else {
          // Only show disconnection message if we were previously connected
          if (FixClientService.instance.isConnected == false) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('⚠️ FIX connection lost'),
                backgroundColor: Colors.orange,
                duration: Duration(seconds: 1), // Reduced from 2 seconds to 1 second
              ),
            );
          }
        }
      }
    });
    
    FixClientService.instance.logonStatusStream.listen((isLoggedOn) {
      if (mounted && isLoggedOn) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🎉 FIX Logon successful - Ready to trade!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2), // Reduced from 4 seconds to 2 seconds
          ),
        );
        
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
    if (_hasRequestedSecurityDefinitions) {
      return; // Already requested
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
              
              if (symbol.isNotEmpty) {
                _assets.add({
                  'symbol': symbol,
                  'name': title,
                  'logoAddress': logoAddress,
                  'price': '-', // Will be updated with market data later
                  'change': '-',
                  'changeColor': Colors.grey,
                });
              }
            }
            
            // Update selected symbol if this is the first time or current is empty
            if (_selectedSymbol.isEmpty && _assets.isNotEmpty) {
              _selectedSymbol = _assets.first['symbol'];
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
  
  @override
  void dispose() {
    _messageSubscription?.cancel();
    _securityRequestTimeout?.cancel();
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    
    return Theme(
      data: _isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        backgroundColor: _isDarkTheme ? const Color(0xFF1A1A1A) : Colors.grey[100],
        body: Column(
          children: [
            // Header Section
            _buildHeader(authService),
            
            // Main Content
            Expanded(
              child: Row(
                children: [
                  // Left Panel - Trading Controls
                  Container(
                    width: 300,
                    child: _buildTradingPanel(),
                  ),
                  
                  // Middle Panel - Asset Selection and Chart
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        // Asset Selection
                        Container(
                          height: 250,
                          child: _buildAssetSection(),
                        ),
                        // Chart Section
                        Expanded(
                          child: _buildChartSection(),
                        ),
                      ],
                    ),
                  ),
                  
                  // Right Panel - Order Book & Activity
                  Container(
                    width: 300,
                    child: _buildActivitySection(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(AuthService authService) {
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
          // Welcome message
          Expanded(
            child: Text(
              'Welcome, ${authService.username}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          
          // FIX Connection Status Indicator
                StreamBuilder<bool>(
                  stream: FixClientService.instance.connectionStatusStream,
                  initialData: false,
                  builder: (context, snapshot) {
                    final isConnected = snapshot.data ?? false;
                    return StreamBuilder<bool>(
                      stream: FixClientService.instance.logonStatusStream,
                      initialData: false,
                      builder: (context, logonSnapshot) {
                        final isLoggedOn = logonSnapshot.data ?? false;
                        
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
                          statusColor = Colors.grey;
                          statusIcon = Icons.cloud_off;
                        }
                        
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: statusColor, width: 1),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(statusIcon, size: 14, color: statusColor),
                              const SizedBox(width: 4),
                              Text(
                                statusText,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: statusColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),          const SizedBox(width: 16),
          
          // Theme toggle
          IconButton(
            onPressed: () {
              setState(() {
                _isDarkTheme = !_isDarkTheme;
              });
            },
            icon: Icon(
              _isDarkTheme ? Icons.wb_sunny : Icons.nights_stay,
              color: Colors.white,
            ),
            tooltip: _isDarkTheme ? 'Light Theme' : 'Dark Theme',
          ),
          
          const SizedBox(width: 16),
          
          // FIX Protocol button
          ElevatedButton(
            onPressed: () {
              // Get the current FixDictionaryProvider to pass it to HomePage
              final dictionaryProvider = Provider.of<FixDictionaryProvider>(context, listen: false);
              
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                    value: dictionaryProvider,
                    child: const HomePage(),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF1a1754),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text('FIX Protocol'),
          ),
          
          const SizedBox(width: 16),
          
          // Logout button
          ElevatedButton(
            onPressed: () async {
              await authService.logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
  Widget _buildTradingPanel() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _isDarkTheme ? const Color(0xFF1e1e1e) : Colors.white,
        border: Border(
          right: BorderSide(
            color: _isDarkTheme ? Colors.grey[700]! : Colors.grey[300]!,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Panel Title
          Text(
            'Trade',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Symbol Selection
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: _isDarkTheme ? Colors.grey[600]! : Colors.grey[400]!,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _assets.isEmpty ? '' : _selectedSymbol,
                isExpanded: true,
                onChanged: _assets.isEmpty ? null : (String? newValue) {
                  setState(() {
                    _selectedSymbol = newValue!;
                  });
                },
                dropdownColor: _isDarkTheme ? const Color(0xFF2d2d2d) : Colors.white,
                style: TextStyle(
                  color: _isDarkTheme ? Colors.white : Colors.black,
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
          
          const SizedBox(height: 20),
          
          // Buy/Sell Tabs
          Container(
            decoration: BoxDecoration(
              color: _isDarkTheme ? const Color(0xFF2d2d2d) : Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isBuySelected = true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _isBuySelected 
                            ? Colors.green 
                            : Colors.transparent,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: Text(
                        'BUY',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _isBuySelected 
                              ? Colors.white 
                              : (_isDarkTheme ? Colors.white : Colors.black),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isBuySelected = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: !_isBuySelected 
                            ? Colors.red 
                            : Colors.transparent,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Text(
                        'SELL',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: !_isBuySelected 
                              ? Colors.white 
                              : (_isDarkTheme ? Colors.white : Colors.black),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Order Type
          Text(
            'Order Type',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _isDarkTheme ? Colors.grey[300] : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: _isDarkTheme ? Colors.grey[600]! : Colors.grey[400]!,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _orderType,
                isExpanded: true,
                onChanged: (String? newValue) {
                  setState(() {
                    _orderType = newValue!;
                  });
                },
                dropdownColor: _isDarkTheme ? const Color(0xFF2d2d2d) : Colors.white,
                style: TextStyle(
                  color: _isDarkTheme ? Colors.white : Colors.black,
                ),
                items: ['Market', 'Limit', 'Stop']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Quantity
          Text(
            'Quantity',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _isDarkTheme ? Colors.grey[300] : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _quantityController,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: _isDarkTheme ? Colors.white : Colors.black,
            ),
            decoration: InputDecoration(
              hintText: 'Enter quantity',
              hintStyle: TextStyle(
                color: _isDarkTheme ? Colors.grey[500] : Colors.grey[400],
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: _isDarkTheme ? Colors.grey[600]! : Colors.grey[400]!,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: _isDarkTheme ? Colors.grey[600]! : Colors.grey[400]!,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF1a1754)),
              ),
            ),
          ),
          
          if (_orderType == 'Limit') ...[
            const SizedBox(height: 16),
            Text(
              'Price',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: _isDarkTheme ? Colors.grey[300] : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: _isDarkTheme ? Colors.white : Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'Enter price',
                hintStyle: TextStyle(
                  color: _isDarkTheme ? Colors.grey[500] : Colors.grey[400],
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isDarkTheme ? Colors.grey[600]! : Colors.grey[400]!,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isDarkTheme ? Colors.grey[600]! : Colors.grey[400]!,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF1a1754)),
                ),
              ),
            ),
          ],
          
          const SizedBox(height: 24),
          
          // Place Order Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _placeOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isBuySelected ? Colors.green : Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                _isBuySelected ? 'PLACE BUY ORDER' : 'PLACE SELL ORDER',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Account info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _isDarkTheme ? const Color(0xFF2d2d2d) : Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Account Balance',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _isDarkTheme ? Colors.grey[300] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$125,450.00',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Available: \$89,320.00',
                  style: TextStyle(
                    fontSize: 12,
                    color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssetSection() {
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
          const SizedBox(height: 16),
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
                        const SizedBox(height: 12),
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
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _assets.length,
                    itemBuilder: (context, index) {
                final asset = _assets[index];
                final isSelected = asset['symbol'] == _selectedSymbol;
                
                return Container(
                  width: 150,
                  margin: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedSymbol = asset['symbol'];
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? const Color(0xFF1a1754).withOpacity(0.2)
                            : (_isDarkTheme ? const Color(0xFF2d2d2d) : Colors.grey[100]),
                        borderRadius: BorderRadius.circular(8),
                        border: isSelected 
                            ? Border.all(color: const Color(0xFF1a1754), width: 2)
                            : null,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            asset['symbol'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _isDarkTheme ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            asset['name'],
                            style: TextStyle(
                              fontSize: 12,
                              color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            asset['price'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _isDarkTheme ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            asset['change'],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: asset['changeColor'],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartSection() {
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
            '$_selectedSymbol Chart',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 16),
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
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.show_chart,
                      size: 64,
                      color: _isDarkTheme ? Colors.grey[500] : Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '$_selectedSymbol Price Chart',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Real-time charting integration coming soon',
                      style: TextStyle(
                        fontSize: 14,
                        color: _isDarkTheme ? Colors.grey[500] : Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivitySection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _isDarkTheme ? const Color(0xFF1e1e1e) : Colors.white,
        border: Border(
          left: BorderSide(
            color: _isDarkTheme ? Colors.grey[700]! : Colors.grey[300]!,
            width: 1,
          ),
        ),
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
