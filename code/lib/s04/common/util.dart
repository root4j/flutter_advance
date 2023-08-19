import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Util {
  final int time = 10;
  void showInfo(String title, String message) {
    Get.snackbar(
      title,
      message,
      icon: const Icon(
        Icons.info,
        color: Colors.blue,
      ),
      snackPosition: SnackPosition.TOP,
      duration: Duration(
        seconds: time,
      ),
    );
  }

  void showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      icon: const Icon(
        Icons.error,
        color: Colors.red,
      ),
      snackPosition: SnackPosition.TOP,
      duration: Duration(
        seconds: time,
      ),
    );
  }
}
