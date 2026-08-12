import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackBar {
  static void show({
    required String title,
    required String message,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    SnackPosition position = SnackPosition.BOTTOM,
    int durationSeconds = 2,
    IconData? icon,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: position,
      backgroundColor: backgroundColor,
      colorText: textColor,
      duration: Duration(seconds: durationSeconds),
      margin: const EdgeInsets.all(12),
      borderRadius: 12,
      icon: icon != null ? Icon(icon, color: textColor) : null,
    );
  }

  static void success(String message) {
    show(
      title: "نجاح ✅",
      message: message,
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
    );
  }

  static void error(String message, {SnackPosition? position}) {
    show(
      title: "خطأ ❌",
      message: message,
      backgroundColor: Colors.red,
      icon: Icons.error,
      position: position ?? SnackPosition.BOTTOM,
    );
  }

  static void info(String message) {
    show(
      title: "معلومة ℹ️",
      message: message,
      backgroundColor: Colors.blue,
      icon: Icons.info,
    );
  }

  static void warning(String message) {
    show(
      title: "تنبيه ⚠️",
      message: message,
      backgroundColor: Colors.orange,
      icon: Icons.warning,
    );
  }
}
