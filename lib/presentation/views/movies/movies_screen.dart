import 'package:flutter/material.dart';

import 'widgets/movie_card.dart';

final movies = [
  {
    'posterUrl':
        'https://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg',
    'title': 'Wonder Woman 1984',
    'rating': 6.8,
    'description':
        'Diana Prince comes into conflict with the Soviet Union during the Cold War in the 1980s.',
  },
  {
    'posterUrl':
        'https://image.tmdb.org/t/p/w500/6KErczPBROQty7QoIsaa6wJYXZi.jpg',
    'title': 'Soul',
    'rating': 8.2,
    'description':
        'A musician who has lost his passion for music is transported out of his body and must find his way back.',
  },
  {
    'posterUrl':
        'https://image.tmdb.org/t/p/w500/6KErczPBROQty7QoIsaa6wJYXZi.jpg',
    'title': 'Soul2',
    'rating': 8.2,
    'description':
        'A musician who has lost his passion for music is transported out of his body and must find his way back.',
  },
];

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example movie data

    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MovieCard(
          posterUrl: movie['posterUrl'] as String,
          title: movie['title'] as String,
          rating: movie['rating'] as double,
          description: movie['description'] as String,
        );
      },
    );
  }
}
