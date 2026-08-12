import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:flutter/material.dart';

class CustomStyleManger {
  // Text Style for primary headings
  static TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: CustomColorsManager.mainTextColor,
  );

  // Text Style for primary headings
  static TextStyle normalText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: CustomColorsManager.mainTextColor,
  );
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
