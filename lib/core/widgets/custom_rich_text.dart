import 'package:flutter/material.dart';

import '../utils/color_manager/color_manager.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText(
      {super.key,
      required this.firstText,
      this.firstTextColor,
      required this.secondText,
      this.secondTextColor,
      this.firstFontSize,
      this.secondFontSize,
      this.secondFontWeight,
      this.firstFontWeight});

  final String firstText;
  final Color? firstTextColor;
  final double? firstFontSize;
  final String secondText;
  final Color? secondTextColor;
  final double? secondFontSize;
  final FontWeight? secondFontWeight;
  final FontWeight? firstFontWeight;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: firstText,
            style: TextStyle(
                color: firstTextColor ?? CustomColorsManager.black,
                fontSize: firstFontSize,
                fontWeight: firstFontWeight)),
        TextSpan(
            text: secondText,
            style: TextStyle(
                color: secondTextColor ?? CustomColorsManager.black,
                fontSize: secondFontSize,
                fontWeight: secondFontWeight)),
      ]),
    );
  }
}
