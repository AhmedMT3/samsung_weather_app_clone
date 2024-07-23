import 'package:flutter/material.dart';
import 'package:weather_app/core/themes/app_themes.dart';
import 'package:weather_app/view/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
      theme: AppThemes.darkTheme,
    );
  }
}
