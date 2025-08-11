import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database_helper.dart';
import 'auto_connect_service.dart';

class AuthService extends ChangeNotifier {
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

  // Auto-connect to staging environment (async, non-blocking)
  void _autoConnectToStaging() async {
    try {
      final autoConnectService = AutoConnectService();
      
      // Run in background without blocking the login UI - give more time for app to stabilize
      Future.delayed(const Duration(milliseconds: 2000), () async {
        print('🚀 Starting auto-connect to staging after login...');
        final success = await autoConnectService.connectToStagingAndLogon();
        if (success) {
          print('✅ Auto-connect to staging completed successfully');
        } else {
          print('⚠️ Auto-connect to staging failed - user can connect manually');
        }
      });
    } catch (e) {
      print('❌ Error in auto-connect process: $e');
    }
  }

  Future<bool> signup(String user, String password, String confirmPassword) async {
    try {
      // Validate input
      if (user.trim().isEmpty || password.isEmpty || confirmPassword.isEmpty) {
        throw 'Please fill in all fields';
      }
      
      if (password != confirmPassword) {
        throw 'Passwords do not match';
      }
      
      if (password.length < 6) {
        throw 'Password must be at least 6 characters long';
      }
      
      // Check if username already exists
      final usernameExists = await _databaseHelper.isUsernameExists(user);
      if (usernameExists) {
        throw 'Username already exists';
      }
      
      // Create new user in database
      final success = await _databaseHelper.createUser(user, password);
      
      if (success) {
        // Don't auto-login - user should login manually
        return true;
      }
      
      throw 'Failed to create account';
    } catch (e) {
      print('Signup error: $e');
      rethrow; // Re-throw to show specific error messages to user
    }
  }

  Future<void> logout() async {
    // Disconnect from staging environment
    try {
      final autoConnectService = AutoConnectService();
      await autoConnectService.disconnect();
      print('📤 Disconnected from staging environment during logout');
    } catch (e) {
      print('❌ Error disconnecting from staging during logout: $e');
    }
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('username');
    
    _isLoggedIn = false;
    _username = '';
    notifyListeners();
  }
}
