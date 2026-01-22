import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database_helper.dart';
import 'real_grpc_client.dart';
import '../config/app_config.dart';

/// Result of a signup operation containing both local and server status
class SignupResult {
  final bool localSuccess;
  final bool serverSuccess;
  final String? serverInvestorId;
  final String? serverError;

  SignupResult({
    required this.localSuccess,
    required this.serverSuccess,
    this.serverInvestorId,
    this.serverError,
  });

  /// Returns true if both local and server signup succeeded
  bool get isFullySuccessful => localSuccess && serverSuccess;

  /// Returns a user-friendly message describing the result
  String get message {
    if (isFullySuccessful) {
      return 'Account created successfully on server!';
    } else if (localSuccess && !serverSuccess) {
      return 'Local account created. Server: ${serverError ?? "unavailable"}';
    } else {
      return 'Failed to create account';
    }
  }
}

class AuthService extends ChangeNotifier {
  
  /// Convert DateTime to Unix timestamp (seconds since epoch)
  static int _toUnixTimestamp(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch ~/ 1000;
  }
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  bool _isLoggedIn = false;
  String _username = '';
  bool _hasBeenInitialized = false;
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  
  bool get isLoggedIn => _isLoggedIn;
  String get username => _username;

  Future<void> init() async {
    // Set the broker name for the database
    final brokerName = AppConfig.selectedBrokerName;
    if (brokerName == null) {
      throw Exception('Broker name not set. Config must be selected before initializing AuthService.');
    }

    _databaseHelper.setBrokerName(brokerName);
    print('✅ AuthService initialized with broker: $brokerName');

    // Always reset to logged-out state when app starts (for fresh sessions each time)
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('username');

    _isLoggedIn = false;
    _username = '';

    notifyListeners();
  }

  // Method to handle app restart - ensures user must login again
  Future<void> handleAppRestart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('username');
    
    _isLoggedIn = false;
    _username = '';
    notifyListeners();
  }

  Future<bool> login(String user, String password) async {
    try {
      // Validate input
      if (user.trim().isEmpty || password.isEmpty) {
        return false;
      }

      // Verify user credentials against database
      final userData = await _databaseHelper.verifyUser(user, password);
      
      if (userData != null) {
        // Save login state
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('username', userData['username']);
        
        _isLoggedIn = true;
        _username = userData['username'];
        notifyListeners();
        
        // Automatically connect to staging and send logon
        print('🚀 Login successful for ${userData['username']} - starting auto-connect to staging...');
        _autoConnectToStaging();
        
        return true;
      }
      
      return false;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  // Auto-connect functionality removed - no longer needed without FIX
  void _autoConnectToStaging() async {
    // No auto-connection needed anymore
    print('✅ Auto-connect disabled - FIX functionality removed');
  }

  /// Result class for signup operation
  Future<SignupResult> signup(String user, String password, String confirmPassword) async {
    try {
      // Validate input
      if (user.trim().isEmpty || password.isEmpty || confirmPassword.isEmpty) {
        throw 'Please fill in all fields';
      }

      if (password != confirmPassword) {
        throw 'Passwords do not match';
      }

      if (password.length < 5) {
        throw 'Password must be at least 5 characters long';
      }

      // Check if username already exists
      final usernameExists = await _databaseHelper.isUsernameExists(user);
      if (usernameExists) {
        throw 'Username already exists';
      }

      // Create new user in local database first
      final localSuccess = await _databaseHelper.createUser(user, password);

      if (!localSuccess) {
        throw 'Failed to create local account';
      }

      // Try to create investor on server via NewInvestor gRPC call
      bool serverSuccess = false;
      String? serverInvestorId;
      String? serverError;

      try {
        print('🌐 Creating investor on server for user: $user');
        final serverResponse = await realGrpcClient.newInvestor(
          externalInvestorId: user.toLowerCase().trim(),
          auxData: 'Created from Flutter app signup - ${_toUnixTimestamp(DateTime.now()).toString()}',
        );

        if (serverResponse['success'] == true) {
          serverSuccess = true;
          serverInvestorId = serverResponse['output']['newInvestorIid'] ??
                            serverResponse['output']['new_investor_iid'] ??
                            serverResponse['output']['refExecutionId'] ??
                            serverResponse['output']['ref_execution_id'];
          print('✅ Server investor created successfully: $serverInvestorId');
        } else {
          // Server investor creation failed - extract error message
          final errorOutput = serverResponse['output'];
          if (errorOutput != null) {
            if (errorOutput['error'] != null) {
              serverError = errorOutput['error'].toString();
            } else if (errorOutput['message'] != null) {
              serverError = errorOutput['message'].toString();
            }
          }
          serverError ??= 'Server investor creation failed';
          print('⚠️ Server investor creation failed: $serverError');
        }
      } catch (e) {
        serverError = e.toString();
        print('⚠️ Server investor creation failed with exception: $e');
      }

      return SignupResult(
        localSuccess: true,
        serverSuccess: serverSuccess,
        serverInvestorId: serverInvestorId,
        serverError: serverError,
      );
    } catch (e) {
      print('Signup error: $e');
      rethrow; // Re-throw to show specific error messages to user
    }
  }

  Future<void> logout() async {
    // FIX disconnect functionality removed
    print('📤 Logout process - no external connections to disconnect');
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('username');
    
    _isLoggedIn = false;
    _username = '';
    notifyListeners();
  }

  // Update current user's password
  Future<bool> updatePassword(String newPassword) async {
    try {
      if (!_isLoggedIn || _username.isEmpty) {
        return false;
      }

      final success = await _databaseHelper.updateUserPassword(_username, newPassword);
      return success;
    } catch (e) {
      print('Error updating password: $e');
      return false;
    }
  }

  // Update current user's username
  Future<bool> updateUsername(String newUsername) async {
    try {
      if (!_isLoggedIn || _username.isEmpty) {
        return false;
      }

      final success = await _databaseHelper.updateUsername(_username, newUsername);
      if (success) {
        // Update the stored username in preferences and local state
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', newUsername.toLowerCase().trim());
        _username = newUsername.toLowerCase().trim();
        notifyListeners();
      }
      return success;
    } catch (e) {
      print('Error updating username: $e');
      return false;
    }
  }
}
