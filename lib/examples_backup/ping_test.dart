// Simple ping test to verify gRPC connection
// This file demonstrates how to test the connection with the ping example

import 'package:mini_broker/services/grpc_client.dart';
import 'package:mini_broker/services/agent_service.dart';

class PingTest {
  /// Simple ping test to verify gRPC connection
  static Future<void> testPingConnection() async {
    try {
      print('🔄 Starting ping connection test...');
      
      // Check if already connected
      if (!grpcClient.isConnected) {
        print('🔌 Connecting to gRPC server...');
        await grpcClient.connect(
          host: 'your-server-host',
          port: 9090,
          useSecure: false,
        );
      }
      
      print('✅ Connected to ${grpcClient.currentHost}:${grpcClient.currentPort}');
      
      // Test ping
      print('🏓 Sending ping...');
      final pingResponse = await AgentService.ping(
        stringToBePonged: 'Hello from Flutter ping test!',
      );
      
      print('✅ Ping successful!');
      print('📨 Sent: "Hello from Flutter ping test!"');
      print('📬 Received: "${pingResponse.pongString}"');
      
      return;
      
    } catch (e) {
      print('❌ Ping test failed: $e');
      if (e.toString().contains('UNAVAILABLE')) {
        print('💡 Server might be offline or unreachable');
        print('   - Check if the server is running');
        print('   - Verify host and port configuration');
        print('   - Check network connectivity');
      }
      rethrow;
    }
  }
  
  /// Test connection with custom host and port
  static Future<void> testPingWithCustomConnection({
    required String host,
    required int port,
    bool useSecure = false,
  }) async {
    try {
      print('🔄 Testing ping with custom connection...');
      print('🔧 Host: $host, Port: $port, Secure: $useSecure');
      
      // Disconnect existing connection
      if (grpcClient.isConnected) {
        await grpcClient.disconnect();
      }
      
      // Connect with custom parameters
      await grpcClient.connect(
        host: host,
        port: port,
        useSecure: useSecure,
      );
      
      // Test ping
      final pingResponse = await AgentService.ping(
        stringToBePonged: 'Custom connection test!',
      );
      
      print('✅ Custom connection ping successful!');
      print('📨 Sent: "Custom connection test!"');
      print('📬 Received: "${pingResponse.pongString}"');
      
    } catch (e) {
      print('❌ Custom connection ping failed: $e');
      rethrow;
    }
  }
}

// Example usage function for testing
Future<void> runPingTests() async {
  print('🚀 Starting gRPC Ping Tests\n');
  
  try {
    // Test 1: Default connection ping
    print('=== Test 1: Default Connection Ping ===');
    await PingTest.testPingConnection();
    print('✅ Test 1 passed!\n');
    
    // Test 2: Custom connection ping (example with localhost)
    print('=== Test 2: Custom Connection Ping ===');
    await PingTest.testPingWithCustomConnection(
      host: 'localhost',
      port: 9090,
      useSecure: false,
    );
    print('✅ Test 2 passed!\n');
    
  } catch (e) {
    print('❌ Ping tests failed: $e');
  } finally {
    // Always disconnect when done
    if (grpcClient.isConnected) {
      await grpcClient.disconnect();
      print('🔌 Disconnected from gRPC server');
    }
    print('🏁 Ping tests completed!');
  }
}

// Uncomment to run the ping test:
// void main() async {
//   await runPingTests();
// }