import 'package:movies/core/enums/theme_enums.dart';

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
