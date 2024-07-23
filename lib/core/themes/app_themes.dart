import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xff0B42AB),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 90,
      ),
    ),
  );
}
