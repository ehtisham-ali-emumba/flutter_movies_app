import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_client.dart';
import '../../data/models/movie.dart';
import '../../data/repositories/movies_repository.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(
    baseUrl: dotenv.env['TMDB_API_BASE_URL']!,
    bearerToken: dotenv.env['TMDB_BEARER_TOKEN'],
  );
});

final moviesRepositoryProvider = Provider<MoviesRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return MoviesRepository(apiClient: apiClient);
});

final carouselMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final repo = ref.watch(moviesRepositoryProvider);
  return repo.fetchPopularMovies();
});
