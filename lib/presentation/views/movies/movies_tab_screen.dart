import 'package:flutter/material.dart';
import 'package:movies/presentation/views/movies/movies_screen.dart';
import 'package:movies/presentation/views/movies/movies_search_screen.dart';

import 'favourite_movies_screen.dart';

class MoviesTabScreen extends StatelessWidget {
  const MoviesTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Movies'),
            actions: [
              IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {
                  // Navigate to search screen or perform search action
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavouriteMoviesScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          body: DefaultTabController(
            length: 2,
            child: Scaffold(
              body: TabBarView(
                children: [MoviesScreen(), MoviesSearchScreen()],
              ),
              bottomNavigationBar: Material(
                color: Theme.of(context).primaryColorDark,
                child: TabBar(
                  tabs: [
                    Tab(text: 'Movies'),
                    Tab(text: 'Search'),
                  ],
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                  indicatorColor: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
