import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  GetStorage box = GetStorage();
  final RxBool isDarkTheme = true.obs;
  String unit = 'C';
  Duration refreshTime = const Duration(hours: 1);

  void setUnit(String unit) {
    if (unit == 'C') {
      this.unit = 'C';
    } else {
      this.unit = 'F';
    }
    box.write('unit', unit);
    log("Unit Changed To [˚$unit]");
    update();
  }

  void setRefreshTime(int hours) {
    refreshTime = Duration(hours: hours);
    box.write('refreshTime', hours);
    log("Refresh Time Changed [ EVERY $hours hours]");
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
