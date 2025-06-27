import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/core/constants/app_constants.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/presentation/view_models/movies/movies_favorite_provider.dart';
import 'package:movies/presentation/widgets/text.dart';

class MovieDetails extends ConsumerWidget {
  final Movie movie;

  const MovieDetails({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavoriteMovie = ref
        .watch(favoritesProvider)
        .isFavoriteMovie(movie.id);
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    movie.title,
                    kind: TextKind.heading,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      AppText(movie.releaseDate, kind: TextKind.caption),
                      _dot(),
                      AppText('18+', kind: TextKind.caption),
                      _dot(),
                      AppText('TV Drama', kind: TextKind.caption),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: List.generate(
                      5,
                      (index) =>
                          Icon(Icons.star, color: Colors.amber, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 50,
              child: IconButton(
                onPressed: () async {
                  ref.read(favoritesProvider.notifier).toggleFavorite(movie);
                },
                icon: Icon(
                  isFavoriteMovie ? Icons.favorite : Icons.favorite_outline,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 12),
        AppText(movie.description, kind: TextKind.body),
        SizedBox(height: 24),
        AppText('Star Cast', kind: TextKind.heading, fontSize: 20),
        SizedBox(height: 12),

        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              10,
              (index) => _actorCard('Lee Chu', AppConstants.catAvatar),
            ),
          ),
        ),

        SizedBox(height: 24),
      ],
    );
  }
}

Widget _dot() => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 6),
  child: Text('•', style: TextStyle(color: Colors.white)),
);

Widget _actorCard(String name, String imagePath) {
  return Container(
    width: 80,
    margin: EdgeInsets.only(right: 12),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imagePath,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 8),
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70, fontSize: 12),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}
