import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  GetStorage box = GetStorage();
  bool isDarkMode = true;
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
    isDarkMode = value;
    if (!value) {
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      Get.changeThemeMode(ThemeMode.light);
    }
    box.write('isDarkMode', isDarkMode);
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
