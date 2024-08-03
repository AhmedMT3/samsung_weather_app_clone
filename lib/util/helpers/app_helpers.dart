import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/themes/app_styles.dart';

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

  /// Checks internet connection, Returns `true` if online, `false` if offline
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

  /// The default dialog template for the app
  static Future showDialog({
    required String title,
    required String message,
    required String cancelButtonText,
    required String confirmButtonText,
    required void Function()? onPressCancel,
    required void Function()? onPressConfirm,
  }) async {
    return await Get.dialog(
      AlertDialog(
        title: Text(title),
        titleTextStyle: AppStyles.bodyMediumXL,
        content: Text(message),
        contentTextStyle:
            AppStyles.bodyRegularL.copyWith(color: Colors.grey[400]),
        actions: [
          MaterialButton(
            onPressed: onPressCancel,
            child: Text(cancelButtonText),
          ),
          MaterialButton(
            onPressed: onPressConfirm,
            color: Colors.blue.shade700,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(confirmButtonText),
          )
        ],
      ),
      barrierDismissible: false,
    );
  }

  /// Dialog for offline case
  static Future showOffLineDialog(
      {required void Function()? cancelFunction,
      required void Function()? confirmFunction}) {
    return AppHelpers.showDialog(
      title: "No Internet connection",
      message: "Make sure you have stable internet connection and try again.",
      cancelButtonText: "Discard",
      confirmButtonText: "Try again",
      onPressCancel: cancelFunction,
      onPressConfirm: confirmFunction,
    );
  }

  /// \nDialog for Not-enabled location service case
  static Future notEnabledDialog(
      {required void Function()? cancelFunction,
      required void Function()? confirmFunction}) {
    return AppHelpers.showDialog(
      title: "Location services not enabled",
      message:
          "Make sure to enable location service on your phone and try again.",
      cancelButtonText: "Discard",
      confirmButtonText: "Try again",
      onPressCancel: cancelFunction,
      onPressConfirm: confirmFunction,
    );
  }

  /// Dialog for *Denied* location service case
  static Future deniedDialog(
      {required void Function()? cancelFunction,
      required void Function()? confirmFunction}) {
    return AppHelpers.showDialog(
      title: "Location services denied",
      message:
          "Make sure to allow location access for this app from app settings.",
      cancelButtonText: "Discard",
      confirmButtonText: "Allow",
      onPressCancel: cancelFunction,
      onPressConfirm: confirmFunction,
    );
  }

  /// Toast message template
  static Future<bool?> showToast(String message) {
    return Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black87,
    );
  }
}
