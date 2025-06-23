import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  Map<String, dynamic>? _user;

  Map<String, dynamic>? get user => _user;

  Future<bool> login(String mobile, String password) async {
    final user = await AuthService.logIn(mobile, password);
    if (user != null) {
      _user = user;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', user['user_id']);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    _user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }
}
