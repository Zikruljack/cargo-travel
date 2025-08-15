import 'package:flutter/foundation.dart';
import '../models/auth_model.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

enum AuthState { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  AuthState _state = AuthState.initial;
  User? _currentUser;
  String? _errorMessage;

  AuthState get state => _state;
  User? get currentUser => _currentUser;
  String? get errorMessage => _errorMessage;

  bool get isAuthenticated => _state == AuthState.authenticated;
  bool get isLoading => _state == AuthState.loading;

  // Initialize auth state
  Future<void> initializeAuth() async {
    _setState(AuthState.loading);

    try {
      final isLoggedIn = await _authService.isLoggedIn();
      if (isLoggedIn) {
        _currentUser = await _authService.getCurrentUser();
        _setState(AuthState.authenticated);
      } else {
        _setState(AuthState.unauthenticated);
      }
    } catch (e) {
      _setError('Failed to initialize authentication');
    }
  }

  // Login
  Future<void> login(String email, String password) async {
    _setState(AuthState.loading);
    _clearError();

    final request = LoginRequest(email: email, password: password);
    final response = await _authService.login(request);

    if (response.isSuccess) {
      _currentUser = response.data?.user;
      _setState(AuthState.authenticated);
    } else {
      _setError(response.error ?? 'Login failed');
    }
  }

  // Register
  Future<void> register({
    required String email,
    required String password,
    required String fullName,
    String? phone,
  }) async {
    _setState(AuthState.loading);
    _clearError();

    final request = RegisterRequest(
      email: email,
      password: password,
      fullName: fullName,
      phone: phone,
    );

    final response = await _authService.register(request);

    if (response.isSuccess) {
      _currentUser = response.data?.user;
      _setState(AuthState.authenticated);
    } else {
      _setError(response.error ?? 'Registration failed');
    }
  }

  // Logout
  Future<void> logout() async {
    _setState(AuthState.loading);

    final response = await _authService.logout();

    if (response.isSuccess) {
      _currentUser = null;
      _setState(AuthState.unauthenticated);
    } else {
      _setError(response.error ?? 'Logout failed');
    }
  }

  // Clear error
  void clearError() {
    _clearError();
  }

  // Private methods
  void _setState(AuthState newState) {
    _state = newState;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    _state = AuthState.error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
