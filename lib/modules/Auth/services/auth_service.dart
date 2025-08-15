import '../../../core/core.dart';
import '../models/auth_model.dart';
import '../models/user_model.dart';

class AuthService {
  // Dummy users untuk simulasi
  static final List<User> _dummyUsers = [
    User(
      id: '1',
      email: 'admin@cargo.com',
      fullName: 'Admin Cargo',
      phone: '+6281234567890',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    User(
      id: '2',
      email: 'user@example.com',
      fullName: 'John Doe',
      phone: '+6289876543210',
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
  ];

  // Login dengan dummy data
  Future<ApiResponse<AuthResponse>> login(LoginRequest request) async {
    try {
      // Simulasi delay network
      await Future.delayed(const Duration(seconds: 2));

      // Cari user berdasarkan email
      final user = _dummyUsers.firstWhere(
        (user) => user.email == request.email,
        orElse: () => throw Exception('User not found'),
      );

      // Simulasi validasi password (dalam real app, ini akan dihandle di backend)
      if (request.password.length < 6) {
        return ApiResponse.error('Invalid email or password');
      }

      // Buat dummy token
      final token = _generateDummyToken(user.id);
      final refreshToken = _generateDummyToken('${user.id}_refresh');

      final authResponse = AuthResponse(
        accessToken: token,
        refreshToken: refreshToken,
        user: user,
        expiresAt: DateTime.now().add(const Duration(hours: 24)),
      );

      // Simpan token ke local storage
      await StorageService.setString('access_token', token);
      await StorageService.setString('refresh_token', refreshToken);
      await StorageService.setString('user_data', user.toJson().toString());

      return ApiResponse.success(authResponse, message: 'Login successful');
    } catch (e) {
      return ApiResponse.error('Invalid email or password');
    }
  }

  // Register dengan dummy data
  Future<ApiResponse<AuthResponse>> register(RegisterRequest request) async {
    try {
      // Simulasi delay network
      await Future.delayed(const Duration(seconds: 2));

      // Cek apakah email sudah terdaftar
      final existingUser = _dummyUsers.where(
        (user) => user.email == request.email,
      );

      if (existingUser.isNotEmpty) {
        return ApiResponse.error('Email already registered');
      }

      // Buat user baru
      final newUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: request.email,
        fullName: request.fullName,
        phone: request.phone,
        createdAt: DateTime.now(),
      );

      // Tambahkan ke dummy users (dalam real app, ini akan disimpan ke database)
      _dummyUsers.add(newUser);

      // Buat dummy token
      final token = _generateDummyToken(newUser.id);
      final refreshToken = _generateDummyToken('${newUser.id}_refresh');

      final authResponse = AuthResponse(
        accessToken: token,
        refreshToken: refreshToken,
        user: newUser,
        expiresAt: DateTime.now().add(const Duration(hours: 24)),
      );

      // Simpan token ke local storage
      await StorageService.setString('access_token', token);
      await StorageService.setString('refresh_token', refreshToken);
      await StorageService.setString('user_data', newUser.toJson().toString());

      return ApiResponse.success(
        authResponse,
        message: 'Registration successful',
      );
    } catch (e) {
      return ApiResponse.error('Registration failed');
    }
  }

  // Logout
  Future<ApiResponse<void>> logout() async {
    try {
      // Simulasi delay network
      await Future.delayed(const Duration(seconds: 1));

      // Hapus token dari local storage
      await StorageService.remove('access_token');
      await StorageService.remove('refresh_token');
      await StorageService.remove('user_data');

      return ApiResponse.success(null, message: 'Logout successful');
    } catch (e) {
      return ApiResponse.error('Logout failed');
    }
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = StorageService.getString('access_token');
    return token != null && token.isNotEmpty;
  }

  // Get current user from storage
  Future<User?> getCurrentUser() async {
    try {
      final userDataString = StorageService.getString('user_data');
      if (userDataString == null) return null;

      // Note: Dalam implementasi real, Anda perlu menggunakan JSON.decode
      // dan proper JSON parsing. Untuk demo ini, kita return user pertama
      return _dummyUsers.isNotEmpty ? _dummyUsers.first : null;
    } catch (e) {
      return null;
    }
  }

  // Generate dummy token
  String _generateDummyToken(String userId) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'dummy_token_${userId}_$timestamp';
  }
}
