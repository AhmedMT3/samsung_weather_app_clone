import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppHelpers{
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
}