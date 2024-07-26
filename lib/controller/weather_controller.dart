import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/model/api_response.dart';
import 'package:weather_app/model/current_weather.dart';
import 'package:weather_app/model/forecast.dart';
import 'package:weather_app/util/helpers/app_helpers.dart';
import 'package:weather_app/util/services/api_services.dart';

class WeatherController extends GetxController {
  final ApiServices apiServices = ApiServices();
  late SharedPreferences _pref;
  String location = "Paris";
  RxBool isLoading = false.obs;
  CurrentWeather? currentWeather;
  ForecastWeather? forecastWeather;
  PageController outlookPageController = PageController();
  int currOutlookPage = 0;
  late ApiResponse responseStatus;

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
      await _pref.setString('location', location);
      this.location = location;
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

  @override
  void onInit() async {
    isLoading(true);
    _pref = await SharedPreferences.getInstance();
    location = _pref.getString('location') ?? location;
    await getWeatherData(location);
    super.onInit();
  }
}
