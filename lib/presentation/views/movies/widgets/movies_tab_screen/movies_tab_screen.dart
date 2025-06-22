import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/presentation/view_models/theme/theme_provider.dart';
import 'package:movies/presentation/views/movies/movies_screen.dart';
import 'package:movies/presentation/views/movies/movies_search_screen.dart';

import '../../favourite_movies_screen.dart';
import 'widgets/AppColorToggle.dart';

class MoviesTabScreen extends ConsumerWidget {
  const MoviesTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Movies'),
              actions: [
                IconButton(
                  icon: Icon(
                    themeState.isDarkMode
                        ? Icons.dark_mode
                        : Icons.dark_mode_outlined,
                  ),
                  onPressed: () async {
                    await ref.read(themeProvider.notifier).toggleTheme();
                  },
                ),
                AppColorToggle(),
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavouriteMoviesScreen(),
                      ),
                    );
                  },
                ),
              ],
              bottom: TabBar(
                tabs: [
                  Tab(text: 'Movies'),
                  Tab(text: 'Search'),
                ],
              ),
            ),
            body: TabBarView(children: [MoviesScreen(), MoviesSearchScreen()]),
          ),
        ),
      ),
    );
  }
}
