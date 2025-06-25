import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/presentation/view_models/movies/movies_favorite_provider.dart';
import 'package:movies/presentation/views/movies/movies_tab_screen/movies_tab_screen.dart';
import 'package:movies/presentation/widgets/text.dart';

final intializationProvider = FutureProvider.autoDispose<void>((ref) async {
  ref.keepAlive();
  final favoritesNotifier = ref.read(favoritesProvider.notifier);
  await favoritesNotifier.loadMoviesFromSharedPreferences();
  await Future.delayed(const Duration(seconds: 3));
  await Future.microtask(() async {});
});

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initWatch = ref.watch(intializationProvider);
    return Scaffold(
      body: Center(
        child: initWatch.when(
          data: (_) {
            return MoviesTabScreen();
          },
          error: (error, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(error.toString(), kind: TextKind.error),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => ref.refresh(intializationProvider),
                  child: const AppText("Reload App"),
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
                AppText("Loading...", fontSize: 24, kind: TextKind.doToFamily),
              ],
            );
          },
        ),
      ),
    );
  }
}
