class AppConfig {
  static const String appName = 'Cargo Travel';
  static const String baseUrl = 'https://localhost/api/v1';

  // Environment settings
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  );

  static bool get isDevelopment => environment == 'development';
  static bool get isProduction => environment == 'production';
  static bool get isStaging => environment == 'staging';

  // API Configuration
  static const Duration apiTimeout = Duration(seconds: 30);
  static const int maxRetryAttempts = 3;

  // Storage keys
  static const String tokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String languageKey = 'language';
  static const String themeKey = 'theme_mode';
}
