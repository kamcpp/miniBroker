import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _username = '';
  
  bool get isLoggedIn => _isLoggedIn;
  String get username => _username;

  Future<void> init() async {
    // Always start with logged-out state - user must login each time
    _isLoggedIn = false;
    _username = '';
    notifyListeners();
  }

  Future<bool> login(String user, String password) async {
    // Simple validation - in real app you'd validate against a server
    if (user.isNotEmpty && password.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('username', user);
      
      _isLoggedIn = true;
      _username = user;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> signup(String user, String password, String confirmPassword) async {
    // Simple validation
    if (user.isNotEmpty && password.isNotEmpty && password == confirmPassword) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('username', user);
      
      _isLoggedIn = true;
      _username = user;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('username');
    
    _isLoggedIn = false;
    _username = '';
    notifyListeners();
  }
}
