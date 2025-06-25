import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/core/providers/movie_api_client_provider.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/data/repositories/movies_repository.dart';

class MovieSearchState {
  final List<Movie> movies;
  final bool isLoading;
  final bool hasMore;
  final int page;
  final String query;

  MovieSearchState({
    this.movies = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.page = 1,
    this.query = '',
  });

  MovieSearchState copyWith({
    List<Movie>? movies,
    bool? isLoading,
    bool? hasMore,
    int? page,
    String? query,
  }) {
    return MovieSearchState(
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      page: page ?? this.page,
      query: query ?? this.query,
    );
  }
}

class MovieSearchNotifier extends StateNotifier<MovieSearchState> {
  final MoviesRepository repository;

  MovieSearchNotifier(this.repository) : super(MovieSearchState());

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      state = MovieSearchState(); // Reset state: no data, no loader
      return;
    }
    state = state.copyWith(isLoading: true, query: query, page: 1, movies: []);
    final movies = await repository.searchMovies(query: query, page: 1);
    state = state.copyWith(
      movies: movies,
      isLoading: false,
      hasMore: movies.length == 20,
      page: 1,
    );
  }

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore || state.query.trim().isEmpty) return;
    final nextPage = state.page + 1;
    state = state.copyWith(isLoading: true);
    final movies = await repository.searchMovies(
      query: state.query,
      page: nextPage,
    );
    state = state.copyWith(
      movies: [...state.movies, ...movies],
      isLoading: false,
      hasMore: movies.length == 20,
      page: nextPage,
    );
  }
}

final movieSearchProvider =
    StateNotifierProvider<MovieSearchNotifier, MovieSearchState>((ref) {
      final apiClient = ref.watch(movieApiClientProvider);
      final repo = MoviesRepository(apiClient: apiClient);
      return MovieSearchNotifier(repo);
    });
