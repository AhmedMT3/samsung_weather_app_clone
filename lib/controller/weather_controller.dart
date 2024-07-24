import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/model/current_weather.dart';
import 'package:weather_app/model/forecast.dart';
import 'package:weather_app/util/helpers/app_helpers.dart';
import 'package:weather_app/util/services/api_services.dart';

class WeatherController extends GetxController {
  final ApiServices apiServices = ApiServices();
  late SharedPreferences _pref;
  String location = "London";
  RxBool isLoading = false.obs;
  CurrentWeather? currentWeather;
  ForecastWeather? forecastWeather;

  Future<void> getCurrentWeather(String location) async {
    isLoading(true);

    try {
      var response = await apiServices.getRequest(endPoint: "&q=$location");

      if (response != null) {
        log("Forecast: ${response.toString()}");
        currentWeather = CurrentWeather.fromJson(response);
        forecastWeather = ForecastWeather.fromJson(response);
      } else {
        AppHelpers.showSnackbar(title: "Error", message: "Incorrect location");
      }
    } catch (_) {
      AppHelpers.showSnackbar(
          title: 'Error', message: "Failed to get Location data.");
    } finally {
      isLoading(false);
      await _pref.setString('location', location);
      this.location = location;
      update();
    }
  }

  Future<void> refreshWeather() async {
    await getCurrentWeather(location);
  }

  @override
  void onInit() async {
    isLoading(true);
    _pref = await SharedPreferences.getInstance();
    location = _pref.getString('location') ?? location;
    await getCurrentWeather(location);
    super.onInit();
  }
}
