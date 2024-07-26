import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppHelpers {
  static double screenWidth(BuildContext ctx) => MediaQuery.of(ctx).size.width;
  static double screenHight(BuildContext ctx) => MediaQuery.of(ctx).size.height;

  static SnackbarController showSnackbar({
    required String title,
    required String message,
    bool isError = true,
  }) {
    return Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      isDismissible: true,
      backgroundColor: isError ? Colors.red[400] : Colors.green,
      colorText: Colors.white,
    );
  }

  static String getHumanReadableDate(String dateString) {
    DateTime inputDate = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(const Duration(days: 1));

    if (inputDate == today) {
      return 'Today';
    } else if (inputDate == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('EEEE').format(inputDate); //Returns day of the week
    }
  }

  static String getUVIndexDescription(double uvIndex) {
    if (uvIndex <= 2.0) {
      return 'Low';
    } else if (uvIndex <= 5.0) {
      return 'Moderate';
    } else if (uvIndex <= 7.0) {
      return 'High';
    } else if (uvIndex <= 10.0) {
      return 'Very High';
    } else {
      return 'Extreme';
    }
  }

  static Future<bool> checkInternet() async {
    try {
      var result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
