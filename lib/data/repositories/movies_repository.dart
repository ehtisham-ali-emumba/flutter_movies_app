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

  Future<List<Movie>> fetchActionMovies({int limit = 8}) async {
    final data = await apiClient.get(
      '/discover/movie',
      queryParams: {
        'language': 'en-US',
        'page': '1',
        'with_genres': '28', // Action genre
      },
    );
    final results = data['results'] as List<dynamic>;
    return results
        .take(limit)
        .map<Movie>((json) => Movie.fromJson(json))
        .toList();
  }

  Future<List<Movie>> fetchTopRatedMovies({int limit = 8}) async {
    final data = await apiClient.get(
      '/movie/top_rated',
      queryParams: {'language': 'en-US', 'page': '1'},
    );
    final results = data['results'] as List<dynamic>;
    return results
        .take(limit)
        .map<Movie>((json) => Movie.fromJson(json))
        .toList();
  }

  Future<List<Movie>> searchMovies({
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    final data = await apiClient.get(
      '/search/movie',
      queryParams: {
        'language': 'en-US',
        'query': query,
        'page': page.toString(),
        'include_adult': 'false',
      },
    );
    final results = data['results'] as List<dynamic>;
    return results
        .take(limit)
        .map<Movie>((json) => Movie.fromJson(json))
        .toList();
  }
}
