import 'package:get_it/get_it.dart';
import '../api/api_service.dart';
import '../config/storage_service.dart';

final GetIt getIt = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {
    // Initialize storage service first
    await StorageService.init();

    // Register services
    _registerServices();

    // Register repositories (will be added later)
    _registerRepositories();

    // Register providers (will be added later)
    _registerProviders();
  }

  static void _registerServices() {
    // Register API Service
    getIt.registerLazySingleton<ApiService>(() => ApiService());

    // Register Storage Service (already initialized)
    getIt.registerLazySingleton<StorageService>(() => StorageService());
  }

  static void _registerRepositories() {
    // Repositories will be registered here when created
    // Example:
    // getIt.registerLazySingleton<AuthRepository>(() => AuthRepository(getIt()));
  }

  static void _registerProviders() {
    // Providers will be registered here when created
    // Example:
    // getIt.registerFactory<AuthProvider>(() => AuthProvider(getIt()));
  }

  static void reset() {
    getIt.reset();
  }
}
