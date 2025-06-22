import 'package:flutter/material.dart';

enum ThemeModeEnums { light, dark }

enum ThemeColorEnum {
  deepOrange, // base theme color is deepOrange
  red,
  green,
  blue,
  brown,
}

extension ThemeColorEnumExtension on ThemeColorEnum {
  String get value => toString().split('.').last;

  Color toColor() {
    switch (this) {
      case ThemeColorEnum.deepOrange:
        return Colors.deepOrange;
      case ThemeColorEnum.red:
        return Colors.red;
      case ThemeColorEnum.green:
        return Colors.green;
      case ThemeColorEnum.blue:
        return Colors.blue;
      case ThemeColorEnum.brown:
        return Colors.brown;
    }
  }

  static ThemeColorEnum fromString(String value) {
    return ThemeColorEnum.values.firstWhere(
      (e) => e.value == value,
      orElse: () => ThemeColorEnum.deepOrange,
    );
  }
}
