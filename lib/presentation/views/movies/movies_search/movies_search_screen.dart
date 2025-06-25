import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/core/utils/input_utils.dart';
import 'package:movies/presentation/view_models/movies/movie_search_provider.dart';
import 'package:movies/presentation/views/movies/widgets/infinite_movies_list.dart';
import 'package:movies/presentation/widgets/text.dart';

class MoviesSearchScreen extends ConsumerStatefulWidget {
  const MoviesSearchScreen({super.key});

  @override
  ConsumerState<MoviesSearchScreen> createState() => _MoviesSearchScreenState();
}

class _MoviesSearchScreenState extends ConsumerState<MoviesSearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final Debouncer _debouncer = Debouncer(milliseconds: 400);

  void _onSearchChanged(String value) {
    _debouncer(value, (val) {
      ref.read(movieSearchProvider.notifier).search(val);
    });
  }

  void _onLoadMore() {
    ref.read(movieSearchProvider.notifier).loadMore();
  }

  void setSearchFieldText(String text) {
    _controller.text = text;
    _onSearchChanged(text);
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _controller.dispose();
    super.dispose();
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
        header: _buildHeader(context),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText("What'd you like to watch?", kind: TextKind.heading),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search for movies...',
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
                size: 28,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  _controller.clear();
                  _onSearchChanged('');
                },
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).primaryColor,
                  size: 28,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 12),
          commonSearchesChip(context, setSearchFieldText),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

Widget commonSearchesChip(
  BuildContext context,
  void Function(String) onSearch,
) {
  final List<String> searches = [
    "Comedy Movies",
    "Action Movies",
    "Drama",
    "Horror",
    "Romance",
    "Sci-Fi",
    "Thriller",
    "Documentary",
  ];

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: List.generate(
        searches.length > 8 ? 8 : searches.length,
        (index) => ActionChip(
          label: Text(searches[index]),
          onPressed: () {
            onSearch(searches[index]);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    ),
  );
}
