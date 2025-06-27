import 'package:get_it/get_it.dart';
import 'package:movies/core/navigation/navigation_service.dart';
import 'package:movies/core/network/api_client.dart';
import 'package:movies/data/repositories/movies_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// GetIt instance for dependency injection
final locator = GetIt.instance;

/// Setup all dependencies
void setupLocator() {
  // Navigation
  locator.registerLazySingleton<NavigationService>(() => NavigationService());

  // Services
  locator.registerLazySingleton<ApiClient>(
    () => ApiClient(
      baseUrl: dotenv.env['TMDB_API_BASE_URL']!,
      bearerToken: dotenv.env['TMDB_BEARER_TOKEN'],
    ),
  );

  // Repositories
  locator.registerLazySingleton<MoviesRepository>(
    () => MoviesRepository(apiClient: locator<ApiClient>()),
  );
}
