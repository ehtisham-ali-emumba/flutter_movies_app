import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/core/constants/app_strings.dart';
import 'package:movies/presentation/view_models/movies/movies_favorite_provider.dart';
import 'package:movies/presentation/views/movies/widgets/infinite_movies_list.dart';
import 'package:movies/presentation/widgets/text.dart';

class FavouriteMoviesScreen extends ConsumerWidget {
  const FavouriteMoviesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMovies = ref.watch(favoritesProvider).favoriteMovies;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: AppText(AppStrings.favoriteMovies, fontSize: 22),
      ),
      body: SafeArea(
        child: favoriteMovies.isEmpty
            ? Column(
                children: [
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
                            AppStrings.noFavoriteMovies,
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
                heroIdPrefix: 'favourite_',
              ),
      ),
    );
  }
}
