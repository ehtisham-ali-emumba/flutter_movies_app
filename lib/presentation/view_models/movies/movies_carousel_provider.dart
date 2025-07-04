import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/core/di/locator.dart';

import '../../../data/models/movie.dart';
import '../../../data/repositories/movies_repository.dart';

final moviesRepositoryProvider = Provider<MoviesRepository>((ref) {
  return locator<MoviesRepository>();
});

final mainCarouselMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final repo = ref.watch(moviesRepositoryProvider);
  return repo.fetchPopularMovies();
});

final actionMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final repo = ref.watch(moviesRepositoryProvider);
  return repo.fetchActionMovies();
});

final topRatedMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final repo = ref.watch(moviesRepositoryProvider);
  return repo.fetchTopRatedMovies();
});
