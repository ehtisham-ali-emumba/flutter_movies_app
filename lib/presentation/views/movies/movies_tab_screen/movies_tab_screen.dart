import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/core/enums/theme_enums.dart';
import 'package:movies/presentation/view_models/theme/theme_provider.dart';
import 'package:movies/presentation/views/movies/movies_screen/movies_screen.dart';
import 'package:movies/presentation/views/movies/movies_search/movies_search_screen.dart';
import 'package:movies/presentation/widgets/text.dart';

import 'widgets/AppColorToggle.dart';

class MoviesTabScreen extends ConsumerWidget {
  const MoviesTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: appHeader(context, ref),
            bottomNavigationBar: TabBar(
              tabs: [
                Tab(text: 'Search'),
                Tab(text: 'Movies'),
              ],
            ),
            body: TabBarView(children: [MoviesSearchScreen(), MoviesScreen()]),
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
      IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
    ],
  );
}
