import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/presentation/widgets/base_carousel.dart';
import 'package:movies/presentation/widgets/text.dart';

import 'carousel_movie_card.dart';

class MoviesListing extends StatelessWidget {
  final dynamic title;

  final List<Movie> movies;

  const MoviesListing({super.key, this.title, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                "Latest Movies",
                kind: TextKind.doToFamily,
                fontWeight: FontWeight.w900,
                fontSize: 22,
              ),
              Icon(Icons.movie, size: 24),
            ],
          ),
        ),
        BaseCarousel(
          options: CarouselOptions(
            enlargeCenterPage: false,
            autoPlay: false,
            height: 270,
            viewportFraction: 0.55,
            padEnds: false,
            enableInfiniteScroll: false,
          ),
          items: movies.map((movie) {
            return Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 5),
              child: CarouselMovieCard(movie: movie),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
