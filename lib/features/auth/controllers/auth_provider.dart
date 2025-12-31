import 'package:flutter/material.dart';
import '../service/auth_service.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  bool get isAuthenticated => _user != null;

  AuthProvider() {
    tryAutoLogin();
  }

  Future<void> tryAutoLogin() async {
    _isLoading = true;
    notifyListeners();
    await fetchProfile();
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> login(String phonenumber, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = await _authService.login(phonenumber: phonenumber, password: password);
      final token = data['token'] ?? data['access_token'];
      if (token != null) {
        print("AuthProvider: Login token found. Token: ${token.substring(0, 5)}...");
        if (data['user'] != null) {
          print("AuthProvider: User data found in login response. Parsing...");
          _user = User.fromJson(data['user']);
          print("AuthProvider: User set initially: ${_user?.fullname}, role: ${_user?.role}");
          notifyListeners();
        }
        
        print("AuthProvider: Fetching fresh profile...");
        await fetchProfile();
        print("AuthProvider: Profile fetch complete. User: ${_user?.fullname}, role: ${_user?.role}");
        _isLoading = false;
        notifyListeners();
        return true;
      }
 else {
        _errorMessage = data['message'] ?? 'Login failed';
      }
    } catch (e) {
      _errorMessage = 'An error occurred during login';
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<void> fetchProfile() async {
    _user = await _authService.getProfile();
    notifyListeners();
  }

  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    notifyListeners();
  }
}
