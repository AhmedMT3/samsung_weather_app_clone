import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/controller/settings_controller.dart';
import 'package:weather_app/core/config/app_routes.dart';
import 'package:weather_app/core/themes/app_themes.dart';
import 'package:weather_app/util/services/app_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage().initStorage;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      initialBinding: AppBindings(),
      getPages: AppRoutes.routes,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: controller.isDarkMode ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
