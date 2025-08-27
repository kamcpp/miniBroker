import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

class FixClientService {
  // Singleton pattern to share connection across the app
  static final FixClientService _instance = FixClientService._internal();
  factory FixClientService() => _instance;
  static FixClientService get instance => _instance;
  FixClientService._internal();

  Socket? _socket;
  bool _isConnected = false;
  bool _isLoggedOn = false; // Track FIX session logon state
  String? _senderCompID;
  String? _targetCompID;
  int _msgSeqNum = 1;
  
  final StreamController<String> _messageController = StreamController<String>.broadcast();
  final StreamController<bool> _connectionStatusController = StreamController<bool>.broadcast();
  final StreamController<bool> _logonStatusController = StreamController<bool>.broadcast();
  
  Stream<String> get messageStream => _messageController.stream;
  Stream<bool> get connectionStatusStream => _connectionStatusController.stream;
  Stream<bool> get logonStatusStream => _logonStatusController.stream;
  
  bool get isConnected => _isConnected;
  bool get isLoggedOn => _isLoggedOn;
  
  Future<bool> connect(String host, int port, String senderCompID, String targetCompID) async {
    try {
      _senderCompID = senderCompID;
      _targetCompID = targetCompID;
      
      // Reset sequence number for new connection
      _msgSeqNum = 1;
      print('Starting new connection - sequence number reset to 1');
      
      print('Attempting to connect to $host:$port...');
      
      // Create actual TCP socket connection
      _socket = await Socket.connect(host, port, timeout: const Duration(seconds: 10));
      
      print('TCP connection established to $host:$port');
      
      // Listen for incoming data
      _socket!.listen(
        (Uint8List data) {
          final message = String.fromCharCodes(data);
          print('Received: $message');
          _messageController.add('Received: $message');
          
          // Process incoming FIX messages for automatic responses
          _processIncomingMessage(message);
        },
        onError: (error) {
          print('Socket error: $error');
          _handleDisconnection();
        },
        onDone: () {
          print('Socket connection closed');
          _handleDisconnection();
        },
      );
      
      _isConnected = true;
      _connectionStatusController.add(true); // Notify UI of connection
      print('FIX client connected successfully');
      
      // DON'T send automatic Logon message - wait for user action like mini-broker app
      // await _sendLogonMessage();
      
      return true;
    } catch (e) {
      print('Connection failed: $e');
      _isConnected = false;
      return false;
    }
  }
  
  void _handleDisconnection() {
    _isConnected = false;
    _isLoggedOn = false; // Reset logon state when disconnected
    _connectionStatusController.add(false); // Notify UI of disconnection
    _logonStatusController.add(false); // Notify UI of logoff
    _socket = null;
    // Only reset sequence number for completely new connections, not disconnections
    print('Connection lost');
    _messageController.add('Connection lost');
  }
  
  void _processIncomingMessage(String message) {
    try {
      // Handle multiple FIX messages in one packet (split by SOH character)
      final messages = message.split(RegExp(r'(?=8=FIX)'));
      
      for (final singleMessage in messages) {
        if (singleMessage.trim().isEmpty) continue;
        
        print('Processing single message: ${singleMessage.trim()}');
        
        // Parse FIX message fields
        final fields = <String, String>{};
        final parts = singleMessage.split('\x01');
        
        for (final part in parts) {
          if (part.contains('=')) {
            final fieldParts = part.split('=');
            if (fieldParts.length == 2) {
              fields[fieldParts[0]] = fieldParts[1];
            }
          }
        }
        
        final msgType = fields['35'];
        print('Message type detected: $msgType');
        
        if (msgType == '1') {
          // Test Request received - must respond with Heartbeat
          final testReqID = fields['112'];
          print('🚨 Test Request received with TestReqID: $testReqID - sending heartbeat response');
          _sendHeartbeatResponse(testReqID);
        } else if (msgType == '0') {
          // Heartbeat received
          print('💓 Heartbeat received from server');
        } else if (msgType == 'A') {
          // Logon response received
          print('✅ Logon response received from server');
          _isLoggedOn = true;
          _logonStatusController.add(true); // Notify UI of successful logon
        } else if (msgType == '5') {
          // Logout response received
          print('✅ Logout response received from server');
          _isLoggedOn = false;
          _logonStatusController.add(false); // Notify UI of logout
        } else {
          print('📨 Other message type received: $msgType');
        }
      }
      
    } catch (e) {
      print('❌ Error processing incoming message: $e');
    }
  }
  
  Future<void> _sendHeartbeatResponse(String? testReqID) async {
    try {
      print('Sending Heartbeat response to Test Request...');
      
      final heartbeatFields = <String, String>{
        '35': '0', // MsgType=Heartbeat
      };
      
      // Include TestReqID if provided
      if (testReqID != null && testReqID.isNotEmpty) {
        heartbeatFields['112'] = testReqID;
        print('Including TestReqID: $testReqID');
      }
      
      final success = await sendMessage(heartbeatFields);
      
      if (success) {
        print('Heartbeat response sent successfully');
      } else {
        print('Failed to send heartbeat response');
      }
      
    } catch (e) {
      print('Error sending heartbeat response: $e');
    }
  }
  
  Future<void> disconnect() async {
    try {
      if (_socket != null) {
        await _socket!.close();
        print('Socket closed');
      }
      _isConnected = false;
      _isLoggedOn = false; // Reset logon state on manual disconnect
      _connectionStatusController.add(false); // Notify UI of manual disconnection
      _logonStatusController.add(false); // Notify UI of logoff
      _socket = null;
      // Don't reset sequence number on manual disconnect - maintain session state
      print('Manual disconnect completed');
    } catch (e) {
      print('Error disconnecting: $e');
    }
  }
  
  Future<bool> sendMessage(Map<String, String> fields) async {
    if (!_isConnected || _socket == null) {
      print('Not connected to FIX server');
      return false;
    }

    try {
      // Check if this is a Logon message with ResetSeqNumFlag=Y
      final isLogon = fields['35'] == 'A';
      final isLogout = fields['35'] == '5';
      final resetSeqNumFlag = fields['141'] == 'Y';
      final resetSeqNum = fields['141'] == 'Y';
      
      if (isLogon && resetSeqNum) {
        print('Logon with ResetSeqNumFlag=Y detected, sequence will continue normally');
      }
      
      // Build FIX message (this increments _msgSeqNum internally)
      final message = _buildFixMessage(fields);

      print('Sending FIX message: $message');

      // Send via socket
      _socket!.add(utf8.encode(message));

      _messageController.add('Sent: $message');
      
      // DO NOT reset sequence number here - let it increment naturally
      // The ResetSeqNumFlag only affects the session state, not the message numbering flow

      return true;
    } catch (e) {
      print('Error sending message: $e');
      return false;
    }
  }

  // Manual logon method - call this explicitly when user wants to logon
  Future<bool> sendLogon([Map<String, String>? logonDefaults]) async {
    if (!_isConnected || _socket == null) {
      print('Not connected to FIX server - cannot send logon');
      return false;
    }

    try {
      await _sendLogonMessage(logonDefaults);
      return true;
    } catch (e) {
      print('Error sending logon: $e');
      return false;
    }
  }
  
  // Reset sequence number to 1 (useful for new sessions)
  void resetSequenceNumber() {
    _msgSeqNum = 1;
    print('Sequence number manually reset to 1');
  }
  
  // Send a manual heartbeat message
  Future<bool> sendHeartbeat([String? testReqID]) async {
    if (!_isConnected || _socket == null) {
      print('Not connected to FIX server - cannot send heartbeat');
      return false;
    }

    try {
      final heartbeatFields = <String, String>{
        '35': '0', // MsgType=Heartbeat
      };
      
      if (testReqID != null && testReqID.isNotEmpty) {
        heartbeatFields['112'] = testReqID;
      }
      
      return await sendMessage(heartbeatFields);
    } catch (e) {
      print('Error sending manual heartbeat: $e');
      return false;
    }
  }  Future<void> _sendLogonMessage([Map<String, String>? logonDefaults]) async {
    try {
      print('Sending FIX Logon message...');
      
      // Start with basic logon fields
      final logonFields = <String, String>{
        '35': 'A', // MsgType=Logon
        '98': '0', // EncryptMethod=None
        '108': '30', // HeartBtInt=30 seconds
        '141': 'Y', // ResetSeqNumFlag=Y (default for new sessions)
      };
      
      // Add defaults from Config.json if provided
      if (logonDefaults != null) {
        logonDefaults.forEach((key, value) {
          // Map known field names to FIX tag numbers
          switch (key) {
            case 'EncryptMethod':
              logonFields['98'] = value;
              break;
            case 'HeartBtInt':
              logonFields['108'] = value;
              break;
            case 'RawData':
              logonFields['95'] = value.length.toString(); // RawDataLength
              logonFields['96'] = value; // RawData
              print('🔐 Including authentication RawData in logon');
              break;
            case 'ResetSeqNumFlag':
              logonFields['141'] = value;
              break;
            default:
              // For any other fields, try to add them directly if they're numeric tags
              if (key.contains(RegExp(r'^\d+$'))) {
                logonFields[key] = value;
              }
              break;
          }
        });
      }
      
      final logonMessage = _buildFixMessage(logonFields);
      
      print('Sending Logon: $logonMessage');
      
      // Send logon message
      _socket!.add(utf8.encode(logonMessage));
      
      _messageController.add('Sent Logon: $logonMessage');
      
    } catch (e) {
      print('Error sending logon message: $e');
      throw e;
    }
  }

  String _buildFixMessage(Map<String, String> fields) {
    final now = DateTime.now().toUtc();
    // Format SendingTime correctly for FIX 4.2: YYYYMMDD-HH:MM:SS.fff
    final sendingTime = '${now.year.toString().padLeft(4, '0')}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}-${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}.${now.millisecond.toString().padLeft(3, '0')}';
    
    print('DEBUG: Formatted SendingTime: $sendingTime');
    
    // Build message body with proper FIX header ordering
    final bodyBuffer = StringBuffer();
    
    // Standard FIX header sequence (after BeginString and BodyLength):
    // 1. MsgType (35) - MUST be first in body
    final msgType = fields['35'] ?? 'D';
    bodyBuffer.write('35=$msgType\x01');
    
    // 2. SenderCompID (49)
    bodyBuffer.write('49=${_senderCompID ?? 'SENDER'}\x01');
    
    // 3. TargetCompID (56)
    bodyBuffer.write('56=${_targetCompID ?? 'TARGET'}\x01');
    
    // 4. MsgSeqNum (34)
    bodyBuffer.write('34=${_msgSeqNum.toString()}\x01');
    
    // 5. SendingTime (52)
    bodyBuffer.write('52=$sendingTime\x01');
    
    // Add message-specific fields (excluding header fields to avoid duplication)
    final headerFields = {'35', '49', '56', '34', '52', '8', '9', '10'};
    final messageTags = fields.keys.where((tag) => !headerFields.contains(tag)).toList()
      ..sort((a, b) => int.parse(a).compareTo(int.parse(b)));
    
    for (final tag in messageTags) {
      bodyBuffer.write('$tag=${fields[tag]}\x01');
    }
    
    final bodyString = bodyBuffer.toString();
    final bodyLength = bodyString.length;
    
    // Build complete message: BeginString + BodyLength + Body + CheckSum
    final messageWithoutChecksum = '8=FIX.4.2\x019=$bodyLength\x01$bodyString';
    
    // Calculate checksum
    final checksum = _calculateChecksum(messageWithoutChecksum);
    
    final finalMessage = '${messageWithoutChecksum}10=${checksum.toString().padLeft(3, '0')}\x01';
    
    _msgSeqNum++;
    
    // Log the properly formatted message for debugging
    print('FIX Message breakdown:');
    print('- BeginString: 8=FIX.4.2');
    print('- BodyLength: 9=$bodyLength');
    print('- MsgType: 35=$msgType');
    print('- SenderCompID: 49=${_senderCompID}');
    print('- TargetCompID: 56=${_targetCompID}');
    print('- MsgSeqNum: 34=${_msgSeqNum - 1}');
    print('- SendingTime: 52=$sendingTime');
    print('- Checksum: 10=${checksum.toString().padLeft(3, '0')}');
    
    return finalMessage;
  }
  
  int _calculateChecksum(String message) {
    int sum = 0;
    for (int i = 0; i < message.length; i++) {
      sum += message.codeUnitAt(i);
    }
    return sum % 256;
  }

  void dispose() {
    _messageController.close();
    _connectionStatusController.close();
    _logonStatusController.close();
    disconnect();
  }
}
