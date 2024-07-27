import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/core/themes/app_themes.dart';
import 'package:weather_app/model/api_response.dart';
import 'package:weather_app/model/current_weather.dart';
import 'package:weather_app/model/forecast.dart';
import 'package:weather_app/util/services/api_services.dart';

class WeatherController extends GetxController {
  final ApiServices apiServices = ApiServices();
  final GetStorage box = GetStorage();
  String location = "Paris";
  RxBool isLoading = false.obs;
  CurrentWeather? currentWeather;
  ForecastWeather? forecastWeather;
  PageController outlookPageController = PageController();
  int currOutlookPage = 0;
  late ApiResponse responseStatus;
  Color? backgroundColor;

/*
===========================================================
===================[ Get Weather Data ]====================
===========================================================
 */
  Future<void> getWeatherData(String location) async {
    isLoading(true);
    var response = await apiServices.getRequest(endPoint: "&q=$location");

    if (response.isRight()) {
      responseStatus = ApiResponse.ok;
      log(responseStatus.toString());

      Map<String, dynamic> jsonResponse = response.getOrElse(() => {});
      // log("Response: ${jsonResponse.toString()}");
      currentWeather = CurrentWeather.fromJson(jsonResponse);
      forecastWeather = ForecastWeather.fromJson(jsonResponse);
      box.write('location', location);
      this.location = location;
      updateBackgrounColor();
    } else {
      responseStatus = response.fold((l) => l, (r) => ApiResponse.unknownErr);
      log(responseStatus.toString());
    }
    isLoading(false);
    update();
  }

  Future<void> refreshWeather() async {
    await getWeatherData(location);
  }

  void onOutlookPageChange(index) {
    currOutlookPage = index;
    update();
  }

  void updateBackgrounColor() {
    if (currentWeather!.current!.isDay == 1) {
      backgroundColor = AppThemes.dayBackground;
    } else {
      backgroundColor = AppThemes.nightBackground;
    }
  }

  @override
  void onInit() async {
    isLoading(true);
    location = box.read('location') ?? location;
    await getWeatherData(location);
    super.onInit();
  }
}
