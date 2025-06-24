import 'package:flutter/material.dart';
import 'package:movies/presentation/views/movies/movies_screen/utils.dart';
import 'package:movies/presentation/widgets/text.dart';

import 'widgets/movies_list.dart';

class MoviesSearchScreen extends StatelessWidget {
  const MoviesSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText("What'd you like to watch?", kind: TextKind.heading),
                  SizedBox(height: 12),
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
                  SizedBox(height: 12),
                  commonSearchesChip(context),
                  SizedBox(height: 24),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
              child: MoviesList(movies: movies),
            ),
          ],
        ),
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
    "Animation", // 9th item, will be ignored
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
