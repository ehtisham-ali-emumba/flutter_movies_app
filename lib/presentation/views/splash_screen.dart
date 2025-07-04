import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/core/constants/app_strings.dart';
import 'package:movies/core/di/index.dart';
import 'package:movies/core/navigation/index.dart';
import 'package:movies/presentation/view_models/movies/movie_reviews_provider.dart';
import 'package:movies/presentation/view_models/movies/movies_favorite_provider.dart';
import 'package:movies/presentation/widgets/text.dart';

final appIntializationProvider = FutureProvider.autoDispose<void>((ref) async {
  ref.keepAlive();
  final favoritesNotifier = ref.read(favoritesProvider.notifier);
  await favoritesNotifier.loadMoviesFromSharedPreferences();
  final movieReviewsNotifier = ref.read(movieReviewsProvider.notifier);
  await movieReviewsNotifier.loadReviewsFromPrefs();
  await Future.delayed(const Duration(seconds: 2));
});

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initWatch = ref.watch(appIntializationProvider);
    return Scaffold(
      body: Center(
        child: initWatch.when(
          data: (_) {
            Future.microtask(() {
              locator<NavigationService>().replaceToWithoutAnimation(
                Routes.moviesTab,
              );
            });
            return Column(children: []);
          },
          error: (error, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(error.toString(), kind: TextKind.error),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => ref.refresh(appIntializationProvider),
                  child: const AppText(AppStrings.reloadApp),
                ),
              ],
            );
          },
          loading: () {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                AppText(
                  AppStrings.loading,
                  fontSize: 24,
                  kind: TextKind.doToFamily,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
