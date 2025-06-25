import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/data/models/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesState {
  final List<Movie> favoriteMovies;

  FavoritesState({this.favoriteMovies = const []});

  FavoritesState copyWith({List<Movie>? favoriteMovies}) {
    return FavoritesState(
      favoriteMovies: favoriteMovies ?? this.favoriteMovies,
    );
  }

  bool isFavoriteMovie(String movieId) {
    return favoriteMovies.any((element) => element.id == movieId);
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesProvider, FavoritesState>(
      (_) => FavoritesProvider(),
    );

class FavoritesProvider extends StateNotifier<FavoritesState> {
  FavoritesProvider() : super(FavoritesState()) {
    loadMoviesFromSharedPreferences();
  }
  final favoriteMoviesKey = "favoriteMoviesKey";

  bool isFavorite(String movieId) {
    return state.favoriteMovies.any((element) => element.id == movieId);
  }

  void toggleFavorite(Movie movie) {
    final isFavoriteFound = isFavorite(movie.id);
    late List<Movie> filteredFavoriteMovies;
    if (isFavoriteFound) {
      filteredFavoriteMovies = state.favoriteMovies
          .where((element) => element.id != movie.id)
          .toList();
    } else {
      filteredFavoriteMovies = [...state.favoriteMovies, movie];
    }
    state = state.copyWith(favoriteMovies: filteredFavoriteMovies);
    saveMoviesInSharedPreferences(filteredFavoriteMovies);
  }

  Future<void> saveMoviesInSharedPreferences(
    List<Movie> moviesListToSave,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      favoriteMoviesKey,
      moviesListToSave.map((movie) => json.encode(movie.toJson())).toList(),
    );
    await loadMoviesFromSharedPreferences();
  }

  Future<void> loadMoviesFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final favMoviesList = prefs.getStringList(favoriteMoviesKey) ?? const [];
    final movies = favMoviesList
        .map((movieJson) => Movie.fromJson(json.decode(movieJson)))
        .toList();
    state = state.copyWith(favoriteMovies: movies);
  }
}
