import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/presentation/widgets/base_carousel.dart';

import '../../../view_models/movies/movies_carousel_provider.dart';
import '../widgets/movie_card.dart';
import 'widgets/movies_listing.dart';

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
                      .map((movie) => MovieCard(movie: movie))
                      .toList(),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Failed to load movies')),
              ),
              SizedBox(height: 20),
              carouselActionMoviesAsync.when(
                data: (movies) =>
                    MoviesListing(title: "Action Movies", movies: movies),
                loading: () => Container(),
                error: (e, _) => Center(child: Text('Failed to load movies')),
              ),
              SizedBox(height: 20),
              carouselTopRatedMoviesAsync.when(
                data: (movies) =>
                    MoviesListing(title: "Top Rated Movies", movies: movies),
                loading: () => Container(),
                error: (e, _) => Center(child: Text('Failed to load movies')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
