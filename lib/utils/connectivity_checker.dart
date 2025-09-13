import 'package:flutter/material.dart';
import '../services/real_grpc_client.dart';

/// Utility class for checking server connectivity and showing error dialogs
class ConnectivityChecker {
  static final RealGrpcClient _grpcClient = RealGrpcClient();

  /// Check server connectivity using ping
  static Future<bool> checkServerConnectivity() async {
    try {
      // Ensure client is configured (doesn't need to be connected for ping)
      if (!_grpcClient.isConnected) {
        await _grpcClient.connect(host: 'localhost', port: 50051);
      }
      
      final result = await _grpcClient.ping(
        stringToBePonged: 'connectivity-test',
      );
      
      return result['success'] == true;
    } catch (e) {
      print('❌ Connectivity check failed: $e');
      return false;
    }
  }

  /// Show error dialog when server is not reachable
  static void showServerErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).brightness == Brightness.dark 
              ? const Color(0xFF2a2a2a) 
              : Colors.white,
          title: Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 28,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Server Error',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark 
                        ? Colors.white 
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.grey,
                ),
                tooltip: 'Close',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          content: Text(
            'No response from the server',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark 
                  ? Colors.white 
                  : Colors.black,
            ),
          ),
        );
      },
    );
  }

  /// Perform connectivity check and show dialog if server is unreachable
  static Future<void> checkAndShowErrorIfNeeded(BuildContext context, String pageName) async {
    print('🏓 Checking server connectivity for $pageName page...');
    
    final isConnected = await checkServerConnectivity();
    
    if (!isConnected) {
      print('❌ Server not reachable on $pageName page - showing error dialog');
      if (context.mounted) {
        showServerErrorDialog(context);
      }
    } else {
      print('✅ Server connectivity confirmed for $pageName page');
    }
  }
}