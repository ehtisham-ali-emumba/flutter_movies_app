import 'package:flutter/material.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/presentation/views/movies/movies_screen/utils.dart';
import 'package:movies/presentation/views/movies/widgets/infinite_movies_list.dart';
import 'package:movies/presentation/widgets/text.dart';

class MoviesSearchScreen extends StatefulWidget {
  const MoviesSearchScreen({super.key});

  @override
  State<MoviesSearchScreen> createState() => _MoviesSearchScreenState();
}

class _MoviesSearchScreenState extends State<MoviesSearchScreen> {
  List<Movie> displayedMovies = [];
  bool isLoading = true;
  bool hasMoreData = true;
  int currentArrayIndex = 0;

  // Your movie arrays
  List<List<Movie>> movieArrays = [];

  @override
  void initState() {
    super.initState();
    _setupMovieArrays();
    _loadFirstBatch();
  }

  void _setupMovieArrays() {
    movieArrays = [moviesThriller, moviesHistory];
  }

  _loadFirstBatch() async {
    if (movieArrays.isNotEmpty) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        displayedMovies = List.from(movieArrays[0]);
        currentArrayIndex = 0;
        hasMoreData = movieArrays.length > 1;
        isLoading = false;
      });
    }
  }

  _loadMoreMovies() async {
    if (isLoading || !hasMoreData) return;

    setState(() {
      isLoading = true;
    });

    // 2 second delay
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      currentArrayIndex++;
      if (currentArrayIndex < movieArrays.length) {
        displayedMovies.addAll(movieArrays[currentArrayIndex]);
        hasMoreData = currentArrayIndex < movieArrays.length - 1;
      } else {
        hasMoreData = false;
      }
      isLoading = false;
    });
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
            decoration: InputDecoration(
              hintText: 'Search for movies...',
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
                size: 28,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 12),
          commonSearchesChip(context),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: InfiniteMoviesList(
        movies: displayedMovies,
        onLoadMore: _loadMoreMovies,
        isLoading: isLoading,
        hasMoreData: hasMoreData,
        header: _buildHeader(context),
      ),
    );
  }
}

Widget commonSearchesChip(BuildContext context) {
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
            print('Selected search: ${searches[index]}');
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    ),
  );
}
