import '../../core/network/api_client.dart';
import '../models/movie.dart';

class MoviesRepository {
  final ApiClient apiClient;

  MoviesRepository({required this.apiClient});

  Future<List<Movie>> fetchPopularMovies({int limit = 8}) async {
    final data = await apiClient.get(
      '/movie/popular',
      queryParams: {'language': 'en-US', 'page': '1'},
    );
    final results = data['results'] as List<dynamic>;
    return results
        .take(limit)
        .map<Movie>((json) => Movie.fromJson(json))
        .toList();
  }
}
