import 'package:flutter/material.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/presentation/views/movies/add_rate_movie_screen.dart';
import 'package:movies/presentation/views/movies/favourite_movies_screen.dart';
import 'package:movies/presentation/views/movies/movie_details_screen/movie_details_screen.dart';
import 'package:movies/presentation/views/movies/movies_tab_screen/movies_tab_screen.dart';
import 'package:movies/presentation/views/splash_screen.dart';

import 'routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.moviesTab:
        return MaterialPageRoute(builder: (_) => const MoviesTabScreen());

      case Routes.favoriteMovies:
        return MaterialPageRoute(builder: (_) => const FavouriteMoviesScreen());

      case Routes.movieDetails:
        final movie = settings.arguments as Movie;
        final heroId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => MovieDetailsScreen(movie: movie, heroId: heroId),
        );

      case Routes.rateMovieReview:
        final movieId = settings.arguments as String;
        final movieTitle = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) =>
              AddRateMovieScreen(movieId: movieId, movieTitle: movieTitle),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  static Widget buildPageForRoute(String routeName, Object? arguments) {
    switch (routeName) {
      case Routes.splash:
        return const SplashScreen();
      case Routes.moviesTab:
        return const MoviesTabScreen();
      default:
        return Scaffold(
          body: Center(child: Text('No route defined for $routeName')),
        );
    }
  }
}
