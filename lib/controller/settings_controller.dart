import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/core/themes/app_themes.dart';

class SettingsController extends GetxController {
  GetStorage box = GetStorage();
  bool isDarkTheme = true;
  String unit = 'C';
  Duration refreshTime = const Duration(hours: 1);

  void setUnit(String unit) {
    this.unit = unit;
    box.write('unit', unit);
    log("Unit Changed To ˚$unit");
    update();
  }

  void setRefreshTime(int hours) {
    refreshTime = Duration(hours: hours);
    box.write('refreshTime', hours);
    log("Refresh Time updated: EVERY $hours Hours");
    update();
  }

  void swithTheme(bool value) {
    isDarkTheme = value;
    if (value) {
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      Get.changeThemeMode(ThemeMode.light);
    }
    update();
  }

  void updateData() {
    unit = box.read('unit') ?? unit;
    int? storedHrs = box.read('refreshTime');
    refreshTime = storedHrs != null ? Duration(hours: storedHrs) : refreshTime;
  }

  @override
  void onInit() {
    updateData();
    super.onInit();
  }
}
