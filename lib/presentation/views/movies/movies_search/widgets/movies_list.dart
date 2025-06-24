import 'package:flutter/material.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/presentation/views/movies/widgets/movie_card.dart';
import 'package:movies/presentation/widgets/text.dart';

class MoviesList extends StatelessWidget {
  final List<Movie> movies;
  const MoviesList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const AppText(
        'No movies found.',
        kind: TextKind.error,
        fontSize: 18,
      );
    }

    return Column(
      children: movies
          .map(
            (movie) => SizedBox(
              height: 280,
              child: MovieCard(
                movie: movie, // Fixed height for listing
              ),
            ),
          )
          .toList(),
    );
  }
}
