import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/core/enums/theme_enums.dart';
import 'package:movies/presentation/view_models/theme/theme_provider.dart';
import 'package:movies/presentation/views/movies/favourite_movies_screen.dart';
import 'package:movies/presentation/widgets/text.dart';

import 'app_color_toggle.dart';

PreferredSizeWidget AppHeader(BuildContext context, WidgetRef ref) {
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FavouriteMoviesScreen()),
          );
        },
      ),
    ],
  );
}
