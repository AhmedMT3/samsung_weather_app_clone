import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/controller/settings_controller.dart';
import 'package:weather_app/core/config/app_routes.dart';
import 'package:weather_app/core/themes/app_themes.dart';
import 'package:weather_app/model/api_response.dart';
import 'package:weather_app/model/current_weather.dart';
import 'package:weather_app/model/forecast.dart';
import 'package:weather_app/model/search_location.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/util/services/api_services.dart';

class WeatherController extends GetxController {
  final ApiServices apiServices = ApiServices();
  final GetStorage box = GetStorage();
  String location = "Paris";
  RxBool isLoading = false.obs;

  PageController outlookPageController = PageController();
  int currOutlookPage = 0;
  late ApiResponse responseStatus;
  Rx<ApiResponse> searchStatus = ApiResponse.unknownErr.obs;
  Color? backgroundColor;
  SettingsController settingsController = Get.find<SettingsController>();
  Timer? timer;
  RxList<Weather> weathers = <Weather>[].obs;
  RxList<SearchLocation> searchedLocations = <SearchLocation>[].obs;

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

      weathers.add(Weather(
        currentWeather: CurrentWeather.fromJson(jsonResponse),
        forecastWeather: ForecastWeather.fromJson(jsonResponse),
      ));
      box.write('location', location);
      this.location = location;
    } else {
      responseStatus = response.fold((l) => l, (r) => ApiResponse.unknownErr);
      log(responseStatus.toString());
    }
    isLoading(false);
    update();
  }

  /*
  ===========================================================
  ====================[ Search Location ]====================
  ===========================================================
  */
  void searchLocation(String query) async {
    searchStatus(ApiResponse.loading);
    var response =
        await apiServices.getRequest(endPoint: "&q=$query", isSearch: true);
    response.fold((left) {
      searchStatus.value = left;
      log(left.toString());
    }, (right) {
      List<dynamic> jsonRes = right;
      if (jsonRes.isNotEmpty) {
        searchStatus(ApiResponse.ok);
        searchedLocations.value = jsonRes
            .map(
                (json) => SearchLocation.fromJson(json as Map<String, dynamic>))
            .toList();
      }
    });
    // update();
  }

  void selectLocation(String loc) async {
    //Get weather, add it to the first and remove last one
    await getWeatherData(loc);
    weathers.insert(0, weathers.last);
    weathers.removeLast();
    searchedLocations.clear();
    searchStatus.value = ApiResponse.unknownErr;
    updateBackgrounColor();
    Get.toNamed(AppRoutes.home);
    log("Weathers Lenght: ${weathers.length}");
    update();
  }

  Future<void> refreshWeather() async {
    final String loc = weathers.first.currentWeather.location!.name!;
    await getWeatherData(loc);
    weathers.first = weathers.last;
    weathers.removeLast();
    updateBackgrounColor();
    update();
  }

  void onOutlookPageChange(index) {
    currOutlookPage = index;
    update();
  }

  void updateBackgrounColor() {
    if (weathers.first.currentWeather.current!.isDay == 1) {
      backgroundColor = AppThemes.dayBackground;
    } else {
      backgroundColor = AppThemes.nightBackground;
    }
  }

  void _autoRefresh() {
    if (settingsController.refreshTime.inHours != 0) {
      refreshWeather();
      log("Auto Refreshed at ${DateTime.now()}");
    }
  }

  void onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex--;
    final Weather tempWeather = weathers.removeAt(oldIndex);
    weathers.insert(newIndex, tempWeather);

    refreshWeather();
    update();
  }

  @override
  void onInit() async {
    isLoading(true);
    location = box.read('location') ?? location;
    await getWeatherData(location);
    updateBackgrounColor();
    timer =
        Timer.periodic(settingsController.refreshTime, (t) => _autoRefresh());
    super.onInit();
  }
}
