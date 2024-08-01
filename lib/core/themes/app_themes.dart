import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 90,
      ),
    ),
  );
  static ThemeData lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      displayLarge: TextStyle(
        fontSize: 90,
      ),
    ),
  );
  static const widgetLight = Color(0xff104084);
  static const widgetDark = Color(0xff104084);
  static const Color nightBackground = Color(0xff0B42AB);
  static const Color dayBackground = Color(0xff33AADD);
}
