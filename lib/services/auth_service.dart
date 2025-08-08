import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _userEmail = '';
  
  bool get isLoggedIn => _isLoggedIn;
  String get userEmail => _userEmail;

  Future<void> init() async {
    // Always start with logged-out state - user must login each time
    _isLoggedIn = false;
    _userEmail = '';
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    // Simple validation - in real app you'd validate against a server
    if (email.isNotEmpty && password.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userEmail', email);
      
      _isLoggedIn = true;
      _userEmail = email;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> signup(String email, String password, String confirmPassword) async {
    // Simple validation
    if (email.isNotEmpty && password.isNotEmpty && password == confirmPassword) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userEmail', email);
      
      _isLoggedIn = true;
      _userEmail = email;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('userEmail');
    
    _isLoggedIn = false;
    _userEmail = '';
    notifyListeners();
  }
}
