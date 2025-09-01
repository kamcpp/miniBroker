import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database_helper.dart';

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
    
    // Ensure admin user exists on app startup
    await _databaseHelper.ensureAdminUserExists();
    
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
      
      // Prevent creating another admin user
      if (user.toLowerCase().trim() == 'admin') {
        throw 'Username "admin" is reserved - please choose a different username';
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
