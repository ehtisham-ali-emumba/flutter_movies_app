import 'package:flutter/material.dart';
import 'package:movies/data/models/movie.dart';

import 'movie_details.dart';
import 'movie_reviews.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;
  final String heroId;

  const MovieDetailsScreen({
    super.key,
    required this.movie,
    required this.heroId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Hero(
                    tag: heroId,
                    child: Image.network(
                      movie.imageUrl,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Dark transparent overlay
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0.4),
                          Color.fromRGBO(0, 0, 0, 0.6),
                        ],
                      ),
                    ),
                  ),

                  // Play icon
                  Icon(
                    Icons.play_circle_fill,
                    color: Theme.of(context).colorScheme.primary,
                    size: 64,
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: CircleAvatar(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHigh,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MovieDetails(movie: movie),
                    MovieReviews(movie: movie),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
