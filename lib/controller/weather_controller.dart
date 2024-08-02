import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:weather_app/controller/settings_controller.dart';
import 'package:weather_app/core/config/app_routes.dart';
import 'package:weather_app/core/themes/app_themes.dart';
import 'package:weather_app/model/enums.dart';
import 'package:weather_app/model/search_location.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/util/helpers/app_helpers.dart';
import 'package:weather_app/util/services/api_services.dart';
import 'package:weather_app/util/services/location_services.dart';

class WeatherController extends GetxController {
  final ApiServices apiServices = ApiServices();
  final LocationServices locationServices = LocationServices();
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
  Future<void> getWeatherData(String location, {bool newLoc = false}) async {
    isLoading(true);
    var response = await apiServices.getRequest(endPoint: "&q=$location");

    if (response.isRight()) {
      responseStatus = ApiResponse.ok;
      log(responseStatus.toString());

      Map<String, dynamic> jsonResponse = response.getOrElse(() => {});
      // log("Response: ${jsonResponse.toString()}");

      weathers.add(Weather.fromJson(jsonResponse));
      _updateWeathersList(newLoc: newLoc);
      saveWeatherData(location, weathers);
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
  ====================[ Save Weather Data ]==================
  ===========================================================
  */
  void saveWeatherData(String location, List<Weather> weathers) {
    box.write('location', location);
    List<Map<String, dynamic>> weatherList =
        weathers.map((weather) => weather.toJson()).toList();
    box.write('weathers', weatherList);
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
  }

  /*
  =============================================================
  ====================[ Select Location ]======================
  =============================================================
  */
  void selectLocation(String loc) async {
    //Get weather, add it to the first and remove last one
    await getWeatherData(loc, newLoc: true);
    searchedLocations.clear();
    searchStatus.value = ApiResponse.unknownErr;
    updateBackgrounColor();
    Get.toNamed(AppRoutes.home);
    log("Weathers count = ${weathers.length}");
    update();
  }

  Future<void> refreshWeather() async {
    await loadWeatherData();
    updateBackgrounColor();
    update();
  }

  void _updateWeathersList({bool newLoc = false}) {
    if (newLoc) {
      if (weathers.length > 1) {
        weathers.insert(0, weathers.last);
        weathers.removeLast();
      }
    } else {
      if (weathers.length > 1) {
        weathers.first = weathers.last;
        weathers.removeLast();
      }
    }
  }

  void onOutlookPageChange(index) {
    currOutlookPage = index;
    update();
  }

  void updateBackgrounColor() {
    if (weathers.first.current!.isDay == 1) {
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

  /// Function to gets the current device location
  Future<void> loadWeatherData() async {
    log("Getting Location...");
    Either<LocationError, LocationData> result =
        await locationServices.getLocation();
    result.fold((left) async {
      log(left.toString());
      _handelLocationError(left);
    }, (right) async {
      log(right.toString());
      final String lon = right.longitude.toString();
      final String lat = right.latitude.toString();
      location = "$lat,$lon";
      await getWeatherData(location);
      updateBackgrounColor();
    });
  }

  _handelLocationError(LocationError error) async {
    loadWeatherCallBack() async {
      Get.back();
      await Future.delayed(const Duration(seconds: 2));
      await loadWeatherData();
    }

    if (error == LocationError.offline) {
      await AppHelpers.showOffLineDialog(
          cancelFunction: Get.back, confirmFunction: loadWeatherCallBack);
    } else if (error == LocationError.notEnabled) {
      await AppHelpers.notEnabledDialog(
          cancelFunction: Get.back, confirmFunction: loadWeatherCallBack);
    } else if (error == LocationError.denied) {
      await AppHelpers.deniedDialog(
          cancelFunction: Get.back, confirmFunction: loadWeatherCallBack);
    }
  }

  @override
  void onInit() async {
    isLoading(true);
    location = box.read<String>('location') ?? location;
    List<dynamic>? savedWeatherList = box.read<List<dynamic>>('weathers');
    if (savedWeatherList != null) {
      log("Weather before: $weathers");
      weathers.value =
          savedWeatherList.map((json) => Weather.fromJson(json)).toList();
      await refreshWeather();
    } else {
      await loadWeatherData();
    }

    timer =
        Timer.periodic(settingsController.refreshTime, (t) => _autoRefresh());
    isLoading(false);
    super.onInit();
  }

  @override
  void onClose() async {
    await box.remove('weathers');
    weathers.clear();
    super.onClose();
  }
}
