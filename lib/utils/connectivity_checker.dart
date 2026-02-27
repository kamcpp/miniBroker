import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import '../config/app_config.dart';
import '../config/ui_constants.dart';
import '../main.dart';

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

  // Server configuration from centralized config
  static String get _host => AppConfig.grpcHost;
  static int get _port => AppConfig.grpcPort;

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
      builder: (BuildContext dialogContext) {
        return _ServerErrorDialogContent(
          parentContext: context,
          dialogContext: dialogContext,
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

/// Stateful dialog content for server error with retry functionality
class _ServerErrorDialogContent extends StatefulWidget {
  final BuildContext parentContext;
  final BuildContext dialogContext;

  const _ServerErrorDialogContent({
    required this.parentContext,
    required this.dialogContext,
  });

  @override
  State<_ServerErrorDialogContent> createState() => _ServerErrorDialogContentState();
}

class _ServerErrorDialogContentState extends State<_ServerErrorDialogContent> {
  bool _isRetrying = false;

  Future<void> _retryConnection() async {
    setState(() {
      _isRetrying = true;
    });

    try {
      final checker = ConnectivityChecker();
      final isConnected = await checker.forceCheckConnectivity();

      if (isConnected) {
        // Connection successful - close dialog
        if (mounted) {
          Navigator.of(widget.dialogContext).pop();
          ScaffoldMessenger.of(widget.parentContext).showSnackBar(
            const SnackBar(
              content: Text('Server connection restored!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        // Still not connected - show message
        if (mounted) {
          setState(() {
            _isRetrying = false;
          });
          ScaffoldMessenger.of(widget.parentContext).showSnackBar(
            const SnackBar(
              content: Text('Still unable to connect to server'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isRetrying = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final host = AppConfig.grpcHost;
    final port = AppConfig.grpcPort;

    return AlertDialog(
      backgroundColor: isDark ? const Color(0xFF2a2a2a) : Colors.white,
      title: Row(
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 28,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Server Connection Error',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cannot connect to the gRPC server:',
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.dns, size: 16, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Host: $host',
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.power, size: 16, color: Colors.red),
                    const SizedBox(width: 8),
                    Text(
                      'Port: $port',
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
                if (AppConfig.selectedBrokerName != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.business, size: 16, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Broker: ${AppConfig.selectedBrokerName}',
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Please check that:',
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '• The server is running\n'
            '• The host and port are correct\n'
            '• Your network connection is active',
            style: TextStyle(
              color: isDark ? Colors.grey[300] : Colors.grey[700],
              fontSize: 13,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isRetrying
              ? null
              : () {
                  Navigator.of(widget.dialogContext).pop();
                  // Navigate back to broker selection
                  Navigator.of(widget.parentContext).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const MyApp()),
                    (route) => false,
                  );
                },
          child: const Text('Change Broker'),
        ),
        ElevatedButton(
          onPressed: _isRetrying ? null : _retryConnection,
          style: UIConstants.buttonStyle(UIConstants.colorCommand),
          child: _isRetrying
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('Try Again'),
        ),
      ],
    );
  }
}