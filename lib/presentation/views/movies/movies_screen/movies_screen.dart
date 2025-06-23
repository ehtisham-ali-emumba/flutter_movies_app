import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/presentation/widgets/base_carousel.dart';

import '../widgets/movie_card.dart';
import 'utils.dart';
import 'widgets/movies_listing.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              BaseCarousel(
                controller: _carouselController,
                items: movies.map((movie) {
                  return MovieCard(movie: movie);
                }).toList(),
              ),
              SizedBox(height: 20),
              MoviesListing(title: "Popular Movies", movies: moviesHistory),
              SizedBox(height: 20),
              MoviesListing(title: "Latest Movies", movies: moviesThriller),
            ],
          ),
        ),
      ),
    );
  }
}
