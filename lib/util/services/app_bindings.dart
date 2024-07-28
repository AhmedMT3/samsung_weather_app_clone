import 'package:get/get.dart';
import 'package:weather_app/controller/settings_controller.dart';
import 'package:weather_app/controller/weather_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
    Get.lazyPut(() => WeatherController());
  }
}
