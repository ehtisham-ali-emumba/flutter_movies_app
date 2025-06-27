import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/core/constants/app_theme_data.dart';
import 'package:movies/core/di/index.dart';
import 'package:movies/core/enums/theme_enums.dart';
import 'package:movies/core/navigation/index.dart';
import 'package:movies/presentation/view_models/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  setupLocator(); // Initialize dependency injection
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final themeColor = themeState.themeColor;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: themeState.isDarkMode
          ? const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
            )
          : const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies App',
        navigatorKey: locator<NavigationService>().navigatorKey,
        initialRoute: Routes.splash,
        onGenerateRoute: AppRouter.onGenerateRoute,
        theme: themeState.isDarkMode
            ? AppThemeData.darkTheme(themeColor.toColor())
            : AppThemeData.lightTheme(themeColor.toColor()),
      ),
    );
  }
}
