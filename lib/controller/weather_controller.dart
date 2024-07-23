import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/model/current_weather.dart';
import 'package:weather_app/model/forecast.dart';
import 'package:weather_app/util/services/api_services.dart';

class WeatherController extends GetxController {
  final ApiServices apiServices = ApiServices();
  late SharedPreferences _pref;
  String location = "London";
  RxBool isLoading = false.obs;
  CurrentWeather? weather;
  ForecastWeather? forecastWeather;

  Future<void> getCurrentWeather(String location) async {
    isLoading(true);
    await _pref.setString('location', location);
    this.location = location;
    var response = await apiServices.getRequest(endPoint: "&q=$location");

    if (response != null) {
      log(response.toString());
      weather = CurrentWeather.fromJson(response);
      forecastWeather = ForecastWeather.fromJson(response['forecast']);
    } else {
      log("Request Failed");
    }
    isLoading(false);
    update();
  }

  @override
  void onInit() async {
    _pref = await SharedPreferences.getInstance();
    location = _pref.getString('location') ?? location;

    await getCurrentWeather(location);
    super.onInit();
  }
}
