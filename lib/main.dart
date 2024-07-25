import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/core/themes/app_themes.dart';
import 'package:weather_app/view/home_view.dart';
import 'package:weather_app/view/manage_locations_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => HomeView(),
        ),
        GetPage(
          name: '/manage_loc',
          page: () => const ManageLocationsView(),
        ),
      ],
      theme: AppThemes.darkTheme,
    );
  }
}
