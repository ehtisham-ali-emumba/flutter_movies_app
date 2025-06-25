import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/presentation/view_models/movies/movies_favorite_provider.dart';
import 'package:movies/presentation/views/movies/widgets/infinite_movies_list.dart';
import 'package:movies/presentation/widgets/text.dart';

class FavouriteMoviesScreen extends ConsumerWidget {
  const FavouriteMoviesScreen({super.key});

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            const SizedBox(width: 8),
            const AppText(
              "What'd you like to watch?",
              kind: TextKind.heading,
              fontSize: 22,
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMovies = ref.watch(favoritesProvider).favoriteMovies;
    print("favoriteMovies count: ${favoriteMovies.length}");

    return Scaffold(
      body: SafeArea(
        child: favoriteMovies.isEmpty
            ? Column(
                children: [
                  _buildHeader(context),
                  const Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          AppText(
                            "No favorite movies yet",
                            kind: TextKind.caption,
                            fontSize: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : InfiniteMoviesList(
                movies: favoriteMovies,
                isLoading: false,
                hasMoreData: false,
                header: _buildHeader(context),
                heroIdPrefix: 'favourite_',
              ),
      ),
    );
  }
}
