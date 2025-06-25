import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/core/enums/theme_enums.dart';
import 'package:movies/presentation/view_models/theme/theme_provider.dart';
import 'package:movies/presentation/views/movies/favourite_movies_screen.dart';
import 'package:movies/presentation/views/movies/movies_screen/movies_screen.dart';
import 'package:movies/presentation/views/movies/movies_search/movies_search_screen.dart';
import 'package:movies/presentation/widgets/text.dart';

import 'widgets/app_color_toggle.dart';

class MoviesTabScreen extends ConsumerWidget {
  const MoviesTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final primaryColor = themeState.themeColor.toColor();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: isDarkMode ? Colors.black : Colors.white,
      child: SafeArea(
        top: false,
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: appHeader(context, ref),
            body: TabBarView(children: [MoviesScreen(), MoviesSearchScreen()]),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: isDarkMode ? Color(0xFF1D1D1D) : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: BottomAppBar(
                color: Colors.transparent,
                padding: EdgeInsets.zero,
                child: TabBar(
                  dividerColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: TextStyle(fontSize: 11),
                  labelColor: primaryColor,
                  unselectedLabelColor: isDarkMode
                      ? Colors.grey
                      : Colors.black45,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 3,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.movie_creation_outlined, size: 26),
                      text: 'Movies',
                      iconMargin: EdgeInsets.only(bottom: 4),
                    ),
                    Tab(
                      icon: Icon(Icons.search_rounded, size: 26),
                      text: 'Search',
                      iconMargin: EdgeInsets.only(bottom: 4),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

PreferredSizeWidget appHeader(BuildContext context, WidgetRef ref) {
  final themeState = ref.watch(themeProvider);
  return AppBar(
    title: AppText(
      'MOVIES HOUSE',
      kind: TextKind.doToFamily,
      fontWeight: FontWeight.w900,
      fontSize: 26,
      color: themeState.themeColor.toColor(),
    ),
    actions: [
      IconButton(
        icon: Icon(
          themeState.isDarkMode ? Icons.dark_mode : Icons.dark_mode_outlined,
        ),
        onPressed: () async {
          await ref.read(themeProvider.notifier).toggleTheme();
        },
      ),
      AppColorToggle(),
      IconButton(
        icon: Icon(Icons.favorite_border),
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => FavouriteMoviesScreen(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
      ),
    ],
  );
}
