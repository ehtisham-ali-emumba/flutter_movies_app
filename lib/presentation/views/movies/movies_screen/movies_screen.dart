import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/core/constants/app_strings.dart';
import 'package:movies/presentation/view_models/movies/movies_carousel_provider.dart';
import 'package:movies/presentation/widgets/base_carousel.dart';

import '../widgets/movie_card.dart';
import 'movies_listing.dart';

class MoviesScreen extends ConsumerWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carouselMoviesAsync = ref.watch(mainCarouselMoviesProvider);
    final carouselActionMoviesAsync = ref.watch(actionMoviesProvider);
    final carouselTopRatedMoviesAsync = ref.watch(topRatedMoviesProvider);

    return Scaffold(
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              carouselMoviesAsync.when(
                data: (movies) => BaseCarousel(
                  items: movies
                      .map(
                        (movie) => MovieCard(
                          movie: movie,
                          heroId: 'main_carousel_${movie.id}',
                        ),
                      )
                      .toList(),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) =>
                    Center(child: Text(AppStrings.failedToLoadMovies)),
              ),
              SizedBox(height: 20),
              carouselActionMoviesAsync.when(
                data: (movies) => MoviesListing(
                  title: AppStrings.actionMovies,
                  movies: movies,
                ),
                loading: () => Container(),
                error: (e, _) =>
                    Center(child: Text(AppStrings.failedToLoadMovies)),
              ),
              SizedBox(height: 20),
              carouselTopRatedMoviesAsync.when(
                data: (movies) => MoviesListing(
                  title: AppStrings.topRatedMovies,
                  movies: movies,
                ),
                loading: () => Container(),
                error: (e, _) =>
                    Center(child: Text(AppStrings.failedToLoadMovies)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
