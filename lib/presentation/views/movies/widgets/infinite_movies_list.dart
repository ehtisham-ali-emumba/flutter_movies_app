import 'package:flutter/material.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/presentation/views/movies/widgets/movie_card.dart';

class InfiniteMoviesList extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback? onLoadMore;
  final bool isLoading;
  final bool hasMoreData;
  final Widget? header;
  final String heroIdPrefix;

  const InfiniteMoviesList({
    super.key,
    required this.movies,
    required this.heroIdPrefix,
    this.onLoadMore,
    this.isLoading = false,
    this.hasMoreData = true,
    this.header,
  });

  @override
  State<InfiniteMoviesList> createState() => _InfiniteMoviesListState();
}

class _InfiniteMoviesListState extends State<InfiniteMoviesList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      if (widget.hasMoreData &&
          !widget.isLoading &&
          widget.onLoadMore != null) {
        widget.onLoadMore!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount:
          widget.movies.length +
          (widget.header != null ? 1 : 0) +
          1, // header + movies + loader
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context, index) {
        if (widget.header != null && index == 0) {
          return widget.header!;
        }
        final movieIndex = widget.header != null ? index - 1 : index;
        if (movieIndex < widget.movies.length) {
          final movie = widget.movies[movieIndex];
          return Container(
            height: 280,
            margin: const EdgeInsets.only(bottom: 16),
            child: MovieCard(
              movie: movie,
              heroId: '${widget.heroIdPrefix}_${movie.id}',
            ),
          );
        } else {
          // Loader at the end
          if (widget.isLoading || widget.isLoading && widget.hasMoreData) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }
      },
    );
  }
}
