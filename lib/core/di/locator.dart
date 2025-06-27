import 'package:get_it/get_it.dart';
import 'package:movies/core/navigation/navigation_service.dart';

/// GetIt instance for dependency injection
final locator = GetIt.instance;

/// Setup all dependencies
void setupLocator() {
  // Navigation
  locator.registerLazySingleton<NavigationService>(() => NavigationService());

  // Services

  // Repositories
}
