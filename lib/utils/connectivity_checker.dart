import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

/// Singleton connectivity manager with caching and debouncing
class ConnectivityChecker {
  static final ConnectivityChecker _instance = ConnectivityChecker._internal();
  factory ConnectivityChecker() => _instance;
  ConnectivityChecker._internal();

  // Connection state cache
  bool? _lastConnectionState;
  DateTime? _lastCheckTime;
  Timer? _debounceTimer;

  // Cache duration - consider connection good for 30 seconds
  static const Duration _cacheTimeout = Duration(seconds: 30);
  // Debounce duration - wait 2 seconds between checks
  static const Duration _debounceTimeout = Duration(seconds: 2);

  // Server configuration
  static const String _host = 'localhost';
  static const int _port = 50051;

  /// Lightweight connectivity check using socket connection only
  Future<bool> _testConnection() async {
    try {
      final socket = await Socket.connect(_host, _port, timeout: const Duration(seconds: 1));
      await socket.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Check server connectivity with caching and debouncing
  Future<bool> checkServerConnectivity() async {
    final now = DateTime.now();

    // Return cached result if still valid
    if (_lastConnectionState != null &&
        _lastCheckTime != null &&
        now.difference(_lastCheckTime!) < _cacheTimeout) {
      return _lastConnectionState!;
    }

    // Use debouncing for rapid consecutive calls
    if (_debounceTimer?.isActive == true) {
      // Return last known state while debouncing
      return _lastConnectionState ?? false;
    }

    // Perform actual check
    final isConnected = await _testConnection();

    // Cache the result
    _lastConnectionState = isConnected;
    _lastCheckTime = now;

    // Set up debounce timer
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_debounceTimeout, () {});

    return isConnected;
  }

  /// Force refresh the connection state (bypass cache)
  Future<bool> forceCheckConnectivity() async {
    _lastConnectionState = null;
    _lastCheckTime = null;
    return await checkServerConnectivity();
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

  /// Perform non-blocking connectivity check and show dialog if server is unreachable
  static void checkAndShowErrorIfNeeded(BuildContext context, String pageName) {
    // Make this asynchronous and non-blocking
    _performConnectivityCheck(context, pageName);
  }

  /// Private method to perform the actual connectivity check
  static Future<void> _performConnectivityCheck(BuildContext context, String pageName) async {
    final checker = ConnectivityChecker();

    try {
      final isConnected = await checker.checkServerConnectivity();

      if (!isConnected) {
        print('❌ Server not reachable on $pageName page');
        if (context.mounted) {
          showServerErrorDialog(context);
        }
      } else {
        print('✅ Server connectivity confirmed for $pageName page');
      }
    } catch (e) {
      print('❌ Connectivity check failed for $pageName page: $e');
      if (context.mounted) {
        showServerErrorDialog(context);
      }
    }
  }

  /// Instance method for direct use
  Future<void> checkAndShowError(BuildContext context, String pageName) async {
    await _performConnectivityCheck(context, pageName);
  }
}