import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/core/enums/theme_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeState {
  final bool isDarkMode;
  final ThemeColorEnum themeColor;

  ThemeState({
    this.isDarkMode = true,
    this.themeColor = ThemeColorEnum.deepOrange,
  });

  ThemeState copyWith({bool? isDarkMode, ThemeColorEnum? themeColor}) {
    return ThemeState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      themeColor: themeColor ?? this.themeColor,
    );
  }
}

final themeProvider = StateNotifierProvider<ThemeProvider, ThemeState>(
  (_) => ThemeProvider(),
);

class ThemeProvider extends StateNotifier<ThemeState> {
  final prefsKey = "isDarkMode";
  final themeColorKey = "themeColor";

  ThemeProvider() : super(ThemeState()) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(prefsKey) ?? true;
    final themeColorString = prefs.getString(themeColorKey) ?? "deepOrange";
    final themeColor = ThemeColorEnumExtension.fromString(themeColorString);
    state = state.copyWith(isDarkMode: isDarkMode, themeColor: themeColor);
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final newMode = !state.isDarkMode;
    state = state.copyWith(isDarkMode: newMode);
    await prefs.setBool(prefsKey, newMode);
  }

  Future<void> changeThemeColor(ThemeColorEnum color) async {
    final prefs = await SharedPreferences.getInstance();
    state = state.copyWith(themeColor: color);
    await prefs.setString(themeColorKey, color.value);
  }
}
