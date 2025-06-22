import 'package:flutter/material.dart';

class AppThemeData {
  static ThemeData lightTheme(Color primaryColor) {
    return ThemeData.light().copyWith(
      primaryColor: primaryColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        surface: Colors.white,
      ),
    );
  }

  static ThemeData darkTheme(Color primaryColor) {
    return ThemeData.dark().copyWith(
      primaryColor: primaryColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      colorScheme: ColorScheme.dark(primary: primaryColor),
    );
  }
}
