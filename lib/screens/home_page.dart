import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../config/environment_config.dart';
import '../main.dart';
import '../services/fix_client_service.dart';
import '../services/fix_message_service.dart';
import 'logon_page.dart';
import 'new_order_single_page.dart';
import 'order_cancel_request_page.dart';
import 'security_definition_request_page.dart';
import 'users_admin_page.dart';

// FIX Message class for tracking messages
class FixMessage {
  final String messageType;
  final String direction; // 'outgoing' or 'incoming'
  final int sequence;
  final DateTime timestamp;
  final String rawMessage;
  final Map<String, String> fields;

  FixMessage({
    required this.messageType,
    required this.direction,
    required this.sequence,
    required this.timestamp,
    required this.rawMessage,
    required this.fields,
  });

  String get displayName {
    switch (messageType) {
      case 'A': return 'Logon';
      case '5': return 'Logout';
      case '8': return 'Execution Report';
      case '9': return 'OrderCancelReject';
      case 'D': return 'New Order Single';
      case 'F': return 'Order Cancel Request';
      case 'c': return 'Security Definition Request';
      case 'd': return 'Security Definition Response';
      case '0': return 'Heartbeat';
      case '1': return 'Test Request';
      case '2': return 'Resend Request';
      case '4': return 'Sequence Reset';
      default: return 'Message $messageType';
    }
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedFixVersion = 'FIX.4.2';
  String selectedEnvironment = 'DEV'; // Updated to match new config structure
  bool isConnected = false;
  bool isConnecting = false;
  bool isLoggedOn = false; // Track FIX logon state
  List<String> logMessages = []; // Add log messages list
  List<FixMessage> fixMessages = []; // Add FIX message tracking
  FixMessage? selectedMessage; // Add selected message tracking
  StreamSubscription<bool>? _connectionStatusSubscription;
  StreamSubscription<bool>? _logonStatusSubscription;
  StreamSubscription<String>? _messageSubscription; // Add message tracking subscription
  
  // Use singleton instance to share connection across screens
  FixClientService get _fixClientService => FixClientService.instance;
  
  // Add log message method
  void _addLogMessage(String message) {
    setState(() {
      logMessages.insert(0, '${DateTime.now().toString().substring(11, 19)}: $message');
      // Keep only last 50 messages
      if (logMessages.length > 50) {
        logMessages = logMessages.take(50).toList();
      }
    });
  }
  
  // Add FIX message tracking method
  void _addFixMessage(String messageType, String direction, String rawMessage, Map<String, String> fields) {
    setState(() {
      // Use the actual FIX sequence number if available, otherwise use a counter
      int sequenceNumber;
      if (fields.containsKey('34')) {
        sequenceNumber = int.tryParse(fields['34'] ?? '0') ?? (fixMessages.length + 1);
      } else {
        sequenceNumber = fixMessages.length + 1;
      }
      
      final message = FixMessage(
        messageType: messageType,
        direction: direction,
        sequence: sequenceNumber,
        timestamp: DateTime.now(),
        rawMessage: rawMessage,
        fields: fields,
      );
      
      // Check if this exact message already exists to avoid duplicates
      bool isDuplicate = fixMessages.any((existingMessage) => 
        existingMessage.rawMessage == rawMessage && 
        existingMessage.direction == direction &&
        existingMessage.messageType == messageType
      );
      
      if (!isDuplicate) {
        fixMessages.insert(0, message);
        // Keep only last 100 messages
        if (fixMessages.length > 100) {
          fixMessages = fixMessages.take(100).toList();
        }
      }
    });
  }
  
  // Process messages from the FIX service stream
  void _processFixMessage(String message) {
    try {
      // Determine direction based on message prefix
      String direction = 'unknown';
      String actualMessage = message;
      
      if (message.startsWith('Sent:')) {
        direction = 'outgoing';
        actualMessage = message.substring(5).trim();
      } else if (message.startsWith('Received:')) {
        direction = 'incoming';
        actualMessage = message.substring(9).trim();
      } else {
        // Skip non-message log entries
        return;
      }
      
      // Split multiple messages if they're concatenated
      // FIX messages start with "8=FIX" and end with a checksum field (10=XXX)
      List<String> individualMessages = [];
      
      // Look for multiple message patterns in the string
      RegExp messagePattern = RegExp(r'8=FIX\.4\.2.*?10=\d{3}');
      Iterable<RegExpMatch> matches = messagePattern.allMatches(actualMessage);
      
      if (matches.isNotEmpty) {
        for (RegExpMatch match in matches) {
          individualMessages.add(match.group(0)!);
        }
      } else {
        // Fallback: treat as single message if pattern doesn't match
        individualMessages.add(actualMessage);
      }
      
      // Process each individual message
      for (String singleMessage in individualMessages) {
        _processSingleFixMessage(singleMessage, direction);
      }
      
    } catch (e) {
      print('Error processing FIX message: $e');
    }
  }
  
  // Process a single FIX message
  void _processSingleFixMessage(String rawMessage, String direction) {
    try {
      // Parse FIX message fields
      final fields = <String, String>{};
      final parts = rawMessage.split('\x01');
      
      for (final part in parts) {
        if (part.contains('=')) {
          final fieldParts = part.split('=');
          if (fieldParts.length >= 2) {
            fields[fieldParts[0]] = fieldParts.sublist(1).join('=');
          }
        }
      }
      
      // Get message type (35)
      final msgType = fields['35'] ?? 'Unknown';
      
      // Add to message tracking
      _addFixMessage(msgType, direction, rawMessage, fields);
      
    } catch (e) {
      print('Error processing single FIX message: $e');
    }
  }
  
  final Map<String, String> fixVersions = {
    'FIX.4.2': 'FIX.4.2',
  };
  
  @override
  void initState() {
    super.initState();
    
    // Set default environment to first available configuration
    final configs = EnvironmentConfig.getConfigs();
    if (configs.isNotEmpty && !configs.containsKey(selectedEnvironment)) {
      selectedEnvironment = configs.keys.first;
    }
    
    // Initialize connection status from the service
    isConnected = _fixClientService.isConnected;
    isLoggedOn = _fixClientService.isLoggedOn;
    
    // Listen to connection status changes
    _connectionStatusSubscription = _fixClientService.connectionStatusStream.listen((bool connected) {
      if (mounted) {
        setState(() {
          isConnected = connected;
          if (!connected) {
            isConnecting = false; // Reset connecting state if disconnected
            isLoggedOn = false; // Reset logon state if disconnected
          }
        });
        
        // Add log message for automatic disconnections
        if (!connected && !isConnecting) {
          _addLogMessage('Connection lost - automatically disconnected');
        }
      }
    });
    
    // Listen to logon status changes
    _logonStatusSubscription = _fixClientService.logonStatusStream.listen((bool loggedOn) {
      if (mounted) {
        setState(() {
          isLoggedOn = loggedOn;
        });
        
        // Add log message for logon/logout events
        _addLogMessage(loggedOn ? 'Successfully logged on to FIX server' : 'Logged out from FIX server');
      }
    });
    
    // Listen to FIX messages (both sent and received)
    _messageSubscription = _fixClientService.messageStream.listen((String message) {
      if (mounted) {
        _processFixMessage(message);
      }
    });
  }
  
  void _showEditConfigurationDialog() {
    final configs = EnvironmentConfig.getConfigs();
    final currentConfig = configs[selectedEnvironment];
    
    if (currentConfig == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Configuration not found for $selectedEnvironment environment. Please check Config.json file.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    // Controllers for editing (only the editable fields)
    final nameController = TextEditingController(text: currentConfig.name);
    final ipController = TextEditingController(text: currentConfig.ipAddress);
    final portController = TextEditingController(text: currentConfig.port.toString());
    final senderController = TextEditingController(text: currentConfig.senderCompID);
    final targetController = TextEditingController(text: currentConfig.targetCompID);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Configuration - $selectedEnvironment'),
          content: SizedBox(
            width: 400,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: ipController,
                    decoration: const InputDecoration(
                      labelText: 'IP Address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: portController,
                    decoration: const InputDecoration(
                      labelText: 'Port',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: senderController,
                    decoration: const InputDecoration(
                      labelText: 'Sender Comp ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: targetController,
                    decoration: const InputDecoration(
                      labelText: 'Target Comp ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Validate and parse input values
                try {
                  final newPort = int.parse(portController.text);
                  
                  // Create updated configuration (keeping heartbeat, fixVersion, and other fields unchanged)
                  final updatedConfig = currentConfig.copyWith(
                    name: nameController.text,
                    ipAddress: ipController.text,
                    port: newPort,
                    senderCompID: senderController.text,
                    targetCompID: targetController.text,
                  );
                  
                  // Update the configuration
                  await EnvironmentConfig.updateConfig(selectedEnvironment, updatedConfig);
                  
                  // Close dialog
                  if (mounted) Navigator.of(context).pop();
                  
                  // Refresh the UI to show updated configuration
                  if (mounted) {
                    setState(() {
                      // This will trigger a rebuild with the new configuration
                    });
                  }
                  
                  // Show success message
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Configuration updated for $selectedEnvironment environment!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } catch (e) {
                  // Show error message for invalid input
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Invalid input: ${e.toString()}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                foregroundColor: Colors.white,
              ),
              child: const Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }
  
  @override
  void dispose() {
    _connectionStatusSubscription?.cancel();
    _logonStatusSubscription?.cancel();
    _messageSubscription?.cancel();
    super.dispose();
  }

  Future<void> _handleConnection() async {
    final configs = EnvironmentConfig.getConfigs();
    final currentConfig = configs[selectedEnvironment];
    
    if (currentConfig == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Configuration not found for $selectedEnvironment environment. Please check Config.json file.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    if (isConnected) {
      // Disconnect - send logout first if logged on
      setState(() {
        isConnecting = true;
      });
      
      try {
        // Send logout message if logged on
        if (isLoggedOn) {
          Map<String, String> logoutFields = {
            '35': '5', // Logout
            '58': 'User requested logout', // Text
          };
          
          final logoutSuccess = await _fixClientService.sendMessage(logoutFields);
          if (logoutSuccess) {
            _addLogMessage('Logout message sent successfully!');
            
            // Wait a moment for the logout to process
            await Future.delayed(const Duration(milliseconds: 500));
          }
        }
        
        await _fixClientService.disconnect();
        
        setState(() {
          isConnected = false;
          isConnecting = false;
        });
        
        if (mounted) {
          _addLogMessage('Disconnected from FIX server');
        }
      } catch (e) {
        setState(() {
          isConnecting = false;
        });
        
        if (mounted) {
          _addLogMessage('Disconnection error: $e');
        }
      }
    } else {
      // Connect
      setState(() {
        isConnecting = true;
      });
      
      try {
        print('Attempting connection to ${currentConfig.ipAddress}:${currentConfig.port}');
        
        // Make real FIX connection
        final success = await _fixClientService.connect(
          currentConfig.ipAddress,
          currentConfig.port,
          currentConfig.senderCompID,
          currentConfig.targetCompID,
        );
        
        setState(() {
          isConnected = success;
          isConnecting = false;
        });
        
        if (mounted) {
          if (success) {
            _addLogMessage('Connected to ${currentConfig.name} (${currentConfig.ipAddress}:${currentConfig.port})');
          } else {
            _addLogMessage('Connection failed to ${currentConfig.ipAddress}:${currentConfig.port}');
          }
        }
      } catch (e) {
        setState(() {
          isConnected = false;
          isConnecting = false;
        });
        
        if (mounted) {
          _addLogMessage('Connection failed: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final configs = EnvironmentConfig.getConfigs();
    final dictionaryProvider = Provider.of<FixDictionaryProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('mini Broker - Connect by FIX protocol'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'users') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UsersAdminPage(),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'users',
                child: Row(
                  children: [
                    Icon(Icons.people),
                    SizedBox(width: 8),
                    Text('View Users'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0), // Reduced padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Configuration Section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0), // Even smaller padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Configuration header
                    Text(
                      'Configuration',
                      style: Theme.of(context).textTheme.titleLarge, // Smaller title
                    ),
                    const SizedBox(height: 8), // Spacing after title
                    
                    // FIX Version, Environment Selection, and Edit Configuration Button - Combined row
                    Row(
                      children: [
                        // FIX Version part
                        const Text('FIX Version: ', style: TextStyle(fontSize: 13)),
                        DropdownButton<String>(
                          value: selectedFixVersion,
                          isDense: true, // Make dropdown more compact
                          items: fixVersions.entries.map((entry) {
                            return DropdownMenuItem(
                              value: entry.key,
                              child: Text(entry.value, style: const TextStyle(fontSize: 13)),
                            );
                          }).toList(),
                          onChanged: isConnected ? null : (value) { // Disable when connected
                            setState(() {
                              selectedFixVersion = value!;
                            });
                          },
                        ),
                        const SizedBox(width: 20), // Space between FIX Version and Environment
                        // Environment part - all in same row
                        const Text('Environment: ', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                        ...configs.keys.map((env) {
                          // Extract just the environment name (after the last hyphen)
                          final envDisplayName = env.split('-').last;
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<String>(
                                value: env,
                                groupValue: selectedEnvironment,
                                onChanged: isConnected ? null : (value) { // Disable when connected
                                  setState(() {
                                    selectedEnvironment = value!;
                                  });
                                },
                                visualDensity: VisualDensity.compact,
                              ),
                              Text(envDisplayName, style: const TextStyle(fontSize: 12)),
                              const SizedBox(width: 10),
                            ],
                          );
                        }).toList(),
                        // Add spacer to push Edit Configuration button to the right
                        const Spacer(),
                        // Edit Configuration Button moved to same line
                        ElevatedButton.icon(
                          onPressed: isConnected ? null : _showEditConfigurationDialog,
                          icon: Icon(
                            Icons.settings,
                            size: 16, // Slightly smaller for header
                          ),
                          label: const Text(
                            'Edit Configuration',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold), // Smaller for header
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[600],
                            foregroundColor: Colors.white,
                            elevation: 4,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // More compact
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16), // Reduced spacing
                    
                    const SizedBox(height: 8), // Much smaller spacing
                    const Divider(thickness: 1), // Thinner divider
                    const SizedBox(height: 8), // Much smaller spacing
                    
                    // Connection Status and Button - Make it much more compact
                    Container(
                      padding: const EdgeInsets.all(8), // Much smaller padding
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Status: ',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isConnected ? Colors.green : Colors.red,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  isConnected ? 'CONNECTED' : 'DISCONNECTED',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            height: 36, // Much smaller height
                            child: ElevatedButton.icon(
                              onPressed: isConnecting ? null : _handleConnection,
                              icon: isConnecting 
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Icon(
                                    isConnected ? Icons.link_off : Icons.link,
                                    size: 18, // Smaller icon
                                  ),
                              label: Text(
                                isConnecting 
                                  ? 'Connecting...' 
                                  : (isConnected ? 'Disconnect' : 'Connect'),
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold), // Smaller text
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isConnected ? Colors.red[600] : Colors.blue[600],
                                foregroundColor: Colors.white,
                                elevation: 4,
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
            
            const SizedBox(height: 10), // Much smaller spacing
            
            // Message Types Section
            Text(
              'FIX Messages',
              style: Theme.of(context).textTheme.titleLarge, // Smaller title
            ),
            const SizedBox(height: 8), // Much smaller spacing
            
            SizedBox(
              height: 130, // Reduced height since it's a single row
              child: GridView.count(
                crossAxisCount: 4, // Changed to 4 columns for single row
                crossAxisSpacing: 8, // Smaller spacing
                mainAxisSpacing: 8, // Smaller spacing
                childAspectRatio: 1.8, // Adjusted ratio for smaller cards in single row
                children: [
                  _buildMessageCard(
                    'Logon',
                    Icons.login,
                    () => _sendDirectMessage(context, 'A', 'Logon'),
                    () => _navigateToMessage(context, 'A', const LogonPage()),
                    isConnected && dictionaryProvider.getMessageDefinition('A') != null,
                    !isLoggedOn, // Logon is only available when NOT logged on
                  ),
                  _buildMessageCard(
                    'Security Definition Request',
                    Icons.security,
                    () => _sendDirectMessage(context, 'c', 'Security Definition Request'),
                    () => _navigateToMessage(context, 'c', const SecurityDefinitionRequestPage()),
                    isConnected && dictionaryProvider.getMessageDefinition('c') != null && isLoggedOn, // Requires logon
                    true, // Always enabled when available
                  ),
                  _buildMessageCard(
                    'New Order Single',
                    Icons.add_shopping_cart,
                    () => _sendDirectMessage(context, 'D', 'New Order Single'),
                    () => _navigateToMessage(context, 'D', NewOrderSinglePage(selectedEnvironment: selectedEnvironment)),
                    isConnected && dictionaryProvider.getMessageDefinition('D') != null && isLoggedOn, // Requires logon
                    true, // Always enabled when available
                  ),
                  _buildMessageCard(
                    'Order Cancel Request',
                    Icons.cancel,
                    () => _sendDirectMessage(context, 'F', 'Order Cancel Request'),
                    () => _navigateToMessage(context, 'F', OrderCancelRequestPage(selectedEnvironment: selectedEnvironment)),
                    isConnected && dictionaryProvider.getMessageDefinition('F') != null && isLoggedOn, // Requires logon
                    true, // Always enabled when available
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Message Stream and Message View Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FIX Message Monitor',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 340,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          // Message Stream (Left Panel)
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(right: BorderSide(color: Colors.grey[300]!)),
                                color: Colors.grey[50],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Header
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.primaryContainer,
                                      border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.message, color: Theme.of(context).colorScheme.onPrimaryContainer, size: 16),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Message Stream',
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Column Headers
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'Messages',
                                            style: TextStyle(color: Colors.grey[700], fontSize: 10, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'Sequence',
                                            style: TextStyle(color: Colors.grey[700], fontSize: 10, fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'Time',
                                            style: TextStyle(color: Colors.grey[700], fontSize: 10, fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Messages List and Clear Button
                                  Expanded(
                                    child: Column(
                                      children: [
                                        // Messages List
                                        Expanded(
                                          child: fixMessages.isEmpty
                                              ? Center(
                                                  child: Text(
                                                    'No messages',
                                                    style: TextStyle(
                                                      color: Colors.grey[500],
                                                      fontSize: 11,
                                                    ),
                                                  ),
                                                )
                                              : Scrollbar(
                                                  thumbVisibility: true,
                                                  child: ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    itemCount: fixMessages.length,
                                                    itemBuilder: (context, index) {
                                                      final message = fixMessages[index];
                                                      final isSelected = selectedMessage == message;
                                                      return InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            selectedMessage = message;
                                                          });
                                                        },
                                                        child: Container(
                                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                          decoration: BoxDecoration(
                                                            color: isSelected ? Theme.of(context).colorScheme.primaryContainer : Colors.transparent,
                                                            border: isSelected ? Border.all(color: Theme.of(context).colorScheme.primary) : null,
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              // Direction Icon and Message Type
                                                              Expanded(
                                                                flex: 2,
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      message.direction == 'outgoing' 
                                                                          ? Icons.arrow_upward
                                                                          : Icons.arrow_downward,
                                                                      color: message.direction == 'outgoing' 
                                                                          ? Colors.green[600]
                                                                          : Colors.red[600],
                                                                      size: 12,
                                                                    ),
                                                                    const SizedBox(width: 4),
                                                                    Expanded(
                                                                      child: Text(
                                                                        message.displayName,
                                                                        style: TextStyle(
                                                                          color: Colors.grey[800],
                                                                          fontSize: 10,
                                                                        ),
                                                                        overflow: TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              // Sequence
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  message.sequence.toString(),
                                                                  style: TextStyle(
                                                                    color: Colors.grey[800],
                                                                    fontSize: 10,
                                                                  ),
                                                                  textAlign: TextAlign.center,
                                                                ),
                                                              ),
                                                              // Time
                                                              Expanded(
                                                                flex: 2,
                                                                child: Text(
                                                                  '${message.timestamp.hour.toString().padLeft(2, '0')}:${message.timestamp.minute.toString().padLeft(2, '0')}:${message.timestamp.second.toString().padLeft(2, '0')}:${message.timestamp.millisecond.toString().padLeft(3, '0')}',
                                                                  style: TextStyle(
                                                                    color: Colors.grey[800],
                                                                    fontSize: 10,
                                                                  ),
                                                                  textAlign: TextAlign.right,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                        ),
                                        // Clear link
                                        if (fixMessages.isNotEmpty)
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              border: Border(top: BorderSide(color: Colors.grey[300]!)),
                                              color: Colors.grey[50],
                                            ),
                                            child: MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    fixMessages.clear();
                                                    selectedMessage = null;
                                                  });
                                                },
                                                child: Text(
                                                  'clear',
                                                  style: TextStyle(
                                                    color: Colors.blue[700],
                                                    fontSize: 10,
                                                    decoration: TextDecoration.underline,
                                                    decorationColor: Colors.blue[700],
                                                  ),
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
                          ),
                          // Message View (Right Panel)
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Header
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.primaryContainer,
                                      border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.visibility, color: Theme.of(context).colorScheme.onPrimaryContainer, size: 16),
                                        const SizedBox(width: 8),
                                        Text(
                                          selectedMessage != null 
                                              ? 'Message: ${selectedMessage!.displayName}'
                                              : 'Message View',
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Message Details
                                  Expanded(
                                    child: selectedMessage == null
                                        ? Center(
                                            child: Text(
                                              'Select a message to view details',
                                              style: TextStyle(
                                                color: Colors.grey[500],
                                                fontSize: 11,
                                              ),
                                            ),
                                          )
                                        : SingleChildScrollView(
                                            padding: const EdgeInsets.all(8),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // Field Headers
                                                Container(
                                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[100],
                                                    borderRadius: BorderRadius.circular(4),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          'Tag',
                                                          style: TextStyle(
                                                            color: Colors.grey[700],
                                                            fontSize: 10,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          'Name',
                                                          style: TextStyle(
                                                            color: Colors.grey[700],
                                                            fontSize: 10,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          'Value',
                                                          style: TextStyle(
                                                            color: Colors.grey[700],
                                                            fontSize: 10,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                // Fields
                                                ..._getSortedFields(selectedMessage!.fields).map((entry) {
                                                  return Container(
                                                    padding: const EdgeInsets.symmetric(vertical: 2),
                                                    decoration: BoxDecoration(
                                                      border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 0.5)),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: SelectableText(
                                                            entry.key,
                                                            style: TextStyle(
                                                              color: Colors.grey[800],
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 3,
                                                          child: SelectableText(
                                                            _getFieldName(entry.key),
                                                            style: TextStyle(
                                                              color: Colors.grey[700],
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: SelectableText(
                                                            _getFieldValueDescription(entry.key, entry.value),
                                                            style: TextStyle(
                                                              color: Colors.grey[800],
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }).toList(),
                                                const SizedBox(height: 16),
                                                // Raw Message Section
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Raw Message',
                                                      style: TextStyle(
                                                        color: Colors.grey[700],
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    IconButton(
                                                      onPressed: () async {
                                                        // Fix the raw message display by replacing ^ with proper separator
                                                        String rawMessage = selectedMessage!.rawMessage;
                                                        // Copy to clipboard
                                                        await Clipboard.setData(ClipboardData(text: rawMessage));
                                                        // Show confirmation
                                                        if (mounted) {
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                            const SnackBar(
                                                              content: Text('Raw message copied to clipboard'),
                                                              duration: Duration(seconds: 2),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      icon: Icon(
                                                        Icons.copy,
                                                        size: 14,
                                                        color: Colors.grey[600],
                                                      ),
                                                      tooltip: 'Copy raw message',
                                                      padding: EdgeInsets.zero,
                                                      constraints: const BoxConstraints(),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 4),
                                                Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[100],
                                                    border: Border.all(color: Colors.grey[300]!),
                                                    borderRadius: BorderRadius.circular(4),
                                                  ),
                                                  child: SelectableText(
                                                    // Fix display by replacing \x01 with | for better readability
                                                    selectedMessage!.rawMessage.replaceAll('\x01', '|'),
                                                    style: TextStyle(
                                                      color: Colors.grey[800],
                                                      fontSize: 9,
                                                      fontFamily: 'monospace',
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ], // <- Column children
        ), // <- Column close
      ), // <- SingleChildScrollView close  
    ), // <- Scrollbar close
  ); // <- Scaffold close
  } // <- Method close

  // Helper method to get field names
  String _getFieldName(String tag) {
    switch (tag) {
      case '8': return 'BeginString';
      case '9': return 'BodyLength';
      case '10': return 'CheckSum';
      case '34': return 'MsgSeqNum';
      case '35': return 'MsgType';
      case '49': return 'SenderCompID';
      case '52': return 'SendingTime';
      case '56': return 'TargetCompID';
      case '98': return 'EncryptMethod';
      case '108': return 'HeartBtInt';
      case '141': return 'ResetSeqNumFlag';
      case '11': return 'ClOrdID';
      case '1': return 'Account';
      case '15': return 'Currency';
      case '21': return 'HandlInst';
      case '55': return 'Symbol';
      case '54': return 'Side';
      case '59': return 'TimeInForce';
      case '60': return 'TransactTime';
      case '40': return 'OrdType';
      case '44': return 'Price';
      case '38': return 'OrderQty';
      case '168': return 'EffectiveTime';
      case '126': return 'ExpireTime';
      case '320': return 'SecurityReqID';
      case '321': return 'SecurityRequestType';
      case '322': return 'SecurityResponseID';
      case '323': return 'SecurityResponseType';
      case '460': return 'Product';
      case '461': return 'CFICode';
      case '107': return 'SecurityDesc';
      case '541': return 'MaturityDate';
      case '58': return 'Text';
      case '96': return 'RawData';
      case '95': return 'RawDataLength';
      // Execution Report fields
      case '37': return 'OrderID';
      case '17': return 'ExecID';
      case '20': return 'ExecTransType';
      case '150': return 'ExecType';
      case '39': return 'OrdStatus';
      case '151': return 'LeavesQty';
      case '14': return 'CumQty';
      case '6': return 'AvgPx';
      // Order Cancel Request fields
      case '41': return 'OrigClOrdID';
      // Order Cancel Reject fields
      case '102': return 'CxlRejReason';
      case '434': return 'CxlRejResponseTo';
      default: return 'Field $tag';
    }
  }

  // Helper method to get field value descriptions for enum fields
  String _getFieldValueDescription(String tag, String value) {
    switch (tag) {
      case '20': // ExecTransType
        switch (value) {
          case '0': return 'NEW [0]';
          case '1': return 'CANCEL [1]';
          case '2': return 'CORRECT [2]';
          case '3': return 'STATUS [3]';
          default: return value;
        }
      case '150': // ExecType
        switch (value) {
          case '0': return 'NEW [0]';
          case '1': return 'PARTIAL_FILL [1]';
          case '2': return 'FILL [2]';
          case '4': return 'CANCELED [4]';
          case '8': return 'REJECTED [8]';
          case 'A': return 'PENDING_NEW [A]';
          case 'C': return 'EXPIRED [C]';
          case 'D': return 'RESTATED [D]';
          case 'E': return 'PENDING_CANCEL [E]';
          case 'F': return 'TRADE [F]';
          case 'I': return 'ORDER_STATUS [I]';
          default: return value;
        }
      case '39': // OrdStatus
        switch (value) {
          case '0': return 'NEW [0]';
          case '1': return 'PARTIALLY_FILLED [1]';
          case '2': return 'FILLED [2]';
          case '4': return 'CANCELED [4]';
          case '6': return 'PENDING_CANCEL [6]';
          case '8': return 'REJECTED [8]';
          case 'A': return 'PENDING_NEW [A]';
          case 'C': return 'EXPIRED [C]';
          case 'E': return 'PENDING_REPLACE [E]';
          default: return value;
        }
      case '54': // Side
        switch (value) {
          case '1': return 'BUY [1]';
          case '2': return 'SELL [2]';
          case '3': return 'BUY_MINUS [3]';
          case '4': return 'SELL_PLUS [4]';
          case '5': return 'SELL_SHORT [5]';
          case '6': return 'SELL_SHORT_EXEMPT [6]';
          case '7': return 'UNDISCLOSED [7]';
          case '8': return 'CROSS [8]';
          case '9': return 'CROSS_SHORT [9]';
          default: return value;
        }
      case '40': // OrdType
        switch (value) {
          case '1': return 'MARKET [1]';
          case '2': return 'LIMIT [2]';
          case '3': return 'STOP [3]';
          case '4': return 'STOP_LIMIT [4]';
          case '5': return 'MARKET_ON_CLOSE [5]';
          default: return value;
        }
      case '59': // TimeInForce
        switch (value) {
          case '0': return 'DAY [0]';
          case '1': return 'GOOD_TILL_CANCEL [1]';
          case '2': return 'AT_THE_OPENING [2]';
          case '3': return 'IMMEDIATE_OR_CANCEL [3]';
          case '4': return 'FILL_OR_KILL [4]';
          default: return value;
        }
      case '102': // CxlRejReason
        switch (value) {
          case '0': return 'TOO_LATE_TO_CANCEL [0]';
          case '1': return 'UNKNOWN_ORDER [1]';
          case '2': return 'BROKER_EXCHANGE_OPTION [2]';
          case '3': return 'ORDER_ALREADY_IN_PENDING_CANCEL_OR_PENDING_REPLACE_STATUS [3]';
          case '4': return 'UNABLE_TO_PROCESS_ORDER_MASS_CANCEL_REQUEST [4]';
          case '5': return 'ORIGORDMODTIME_DID_NOT_MATCH_LAST_ORDMODTIME_OF_ORDER [5]';
          case '6': return 'DUPLICATE_CLORDID_RECEIVED [6]';
          case '18': return 'INVALID_PRICE_INCREMENT [18]';
          default: return value;
        }
      case '434': // CxlRejResponseTo
        switch (value) {
          case '1': return 'ORDER_CANCEL_REQUEST [1]';
          case '2': return 'ORDER_CANCEL_REPLACE_REQUEST [2]';
          default: return value;
        }
      default:
        return value;
    }
  }

  // Helper method to sort fields in execution report order
  List<MapEntry<String, String>> _getSortedFields(Map<String, String> fields) {
    // Define the desired order for execution report fields
    final executionReportOrder = [
      '37', // OrderID
      '11', // ClOrdID
      '17', // ExecID
      '20', // ExecTransType
      '150', // ExecType
      '39', // OrdStatus
      '55', // Symbol
      '54', // Side
      '38', // OrderQty
      '44', // Price
      '15', // Currency
      '151', // LeavesQty
      '14', // CumQty
      '6', // AvgPx
      '60', // TransactTime
    ];
    
    // Get the message type to determine if this is an execution report
    final msgType = fields['35'];
    
    // If this is an execution report (msgType = '8'), use the custom order
    if (msgType == '8') {
      List<MapEntry<String, String>> sortedFields = [];
      
      // First, add fields in the execution report order if they exist
      for (String tag in executionReportOrder) {
        if (fields.containsKey(tag)) {
          sortedFields.add(MapEntry(tag, fields[tag]!));
        }
      }
      
      // Then add any remaining fields that weren't in the predefined order
      for (MapEntry<String, String> entry in fields.entries) {
        if (!executionReportOrder.contains(entry.key)) {
          sortedFields.add(entry);
        }
      }
      
      return sortedFields;
    } else {
      // For other message types, return fields in their original order
      return fields.entries.toList();
    }
  }

  Widget _buildMessageCard(
    String title,
    IconData icon,
    VoidCallback onSend,
    VoidCallback onEdit,
    bool isAvailable,
    bool isEnabled, // New parameter to control individual button states
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Even smaller padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20, // Even smaller icon
              color: (isAvailable && isEnabled) ? Theme.of(context).primaryColor : Colors.grey,
            ),
            const SizedBox(height: 4), // Much smaller spacing
            Text(
              title,
              style: const TextStyle(
                fontSize: 11, // Much smaller text
                fontWeight: FontWeight.w500,
              ).copyWith(
                color: (isAvailable && isEnabled) ? null : Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6), // Small spacing
            if (isAvailable) ...[
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isEnabled ? onSend : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isEnabled ? Colors.blue : Colors.grey[300],
                        foregroundColor: isEnabled ? Colors.white : Colors.grey[600],
                        padding: const EdgeInsets.symmetric(vertical: 4), // Much smaller padding
                        minimumSize: const Size(0, 28), // Smaller button height
                      ),
                      child: const Text('Send', style: TextStyle(fontSize: 10)), // Smaller text
                    ),
                  ),
                  const SizedBox(width: 4), // Much smaller spacing
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isEnabled ? onEdit : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isEnabled ? Colors.grey : Colors.grey[300],
                        foregroundColor: isEnabled ? Colors.white : Colors.grey[600],
                        padding: const EdgeInsets.symmetric(vertical: 4), // Much smaller padding
                        minimumSize: const Size(0, 28), // Smaller button height
                      ),
                      child: const Text('Edit', style: TextStyle(fontSize: 10)), // Smaller text
                    ),
                  ),
                ],
              ),
            ] else ...[
              Text(
                !isConnected ? 'Connect First' : (!isLoggedOn && (title == 'New Order Single' || title == 'Security Definition Request') ? 'Logon Required' : 'Logon Required'),
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 9, // Much smaller text
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _sendDirectMessage(BuildContext context, String msgType, String messageName) async {
    // Check if we have a FIX connection
    if (!_fixClientService.isConnected) {
      _addLogMessage('Not connected to FIX server. Please connect first.');
      return;
    }

    try {
      bool success = false;
      
      // Use centralized service for sending messages
      switch (msgType) {
        case 'A': // Logon
          success = await FixMessageService.sendQuickLogon();
          break;
        case '5': // Logout
          success = await FixMessageService.sendQuickLogout();
          break;
        case 'D': // New Order Single
          success = await FixMessageService.sendQuickNewOrderSingle(selectedEnvironment);
          break;
        case 'c': // Security Definition Request
          success = await FixMessageService.sendQuickSecurityDefinitionRequest();
          break;
        case 'F': // Order Cancel Request
          success = await FixMessageService.sendQuickOrderCancelRequest(selectedEnvironment);
          break;
      }
      
      if (success) {
        _addLogMessage('$messageName message sent successfully!');
      } else {
        _addLogMessage('Failed to send $messageName message');
      }
    } catch (e) {
      _addLogMessage('Error sending $messageName: $e');
    }
  }

  void _navigateToMessage(BuildContext context, String msgType, Widget page) {
    // Capture the Provider value before navigation
    final dictionaryProvider = Provider.of<FixDictionaryProvider>(context, listen: false);
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (newContext) => ChangeNotifierProvider.value(
          value: dictionaryProvider,
          child: page,
        ),
      ),
    );
  }
}
