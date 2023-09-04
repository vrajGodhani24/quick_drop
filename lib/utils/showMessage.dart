import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Global {
  static void snackMassage(String title, String message, Color color) {
    Get.snackbar(title, message, backgroundColor: color);
  }
}
