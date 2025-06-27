import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/presentation/view_models/movies/movie_search_provider.dart';
import 'package:movies/presentation/views/movies/movies_search/search_header.dart';
import 'package:movies/presentation/views/movies/widgets/infinite_movies_list.dart';

class MoviesSearchScreen extends ConsumerStatefulWidget {
  const MoviesSearchScreen({super.key});

  @override
  ConsumerState<MoviesSearchScreen> createState() => _MoviesSearchScreenState();
}

class _MoviesSearchScreenState extends ConsumerState<MoviesSearchScreen> {
  void _onLoadMore() {
    ref.read(movieSearchProvider.notifier).loadMore();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(movieSearchProvider);

    return SafeArea(
      top: false,
      child: InfiniteMoviesList(
        movies: state.movies,
        onLoadMore: _onLoadMore,
        isLoading: state.isLoading && state.query.isNotEmpty,
        hasMoreData: state.hasMore,
        header: SearchHeader(),
        heroIdPrefix: 'search_',
      ),
    );
  }
}
