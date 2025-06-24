import 'package:flutter/material.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/presentation/views/movies/movies_screen/utils.dart';
import 'package:movies/presentation/views/movies/widgets/infinite_movies_list.dart';
import 'package:movies/presentation/widgets/text.dart';

class FavouriteMoviesScreen extends StatefulWidget {
  const FavouriteMoviesScreen({super.key});

  @override
  State<FavouriteMoviesScreen> createState() => _FavouriteMoviesScreenState();
}

class _FavouriteMoviesScreenState extends State<FavouriteMoviesScreen> {
  List<Movie> displayedMovies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFirstBatch();
  }

  _loadFirstBatch() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      displayedMovies = [...moviesThriller, ...moviesHistory];
      isLoading = false;
    });
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InfiniteMoviesList(
          movies: displayedMovies,
          isLoading: isLoading,
          hasMoreData: false,
          header: _buildHeader(context),
        ),
      ),
    );
  }
}
