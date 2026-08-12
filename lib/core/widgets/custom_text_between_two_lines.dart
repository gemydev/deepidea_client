import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:flutter/material.dart';

import '../utils/color_manager/color_manager.dart';
import 'custom_text.dart';

class CustomTextBetweenTwoLines extends StatelessWidget {
  const CustomTextBetweenTwoLines({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: CustomColorsManager.mainTextColor.withValues(alpha: 0.25),
              thickness: 1,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: CustomText(
              text,
              style: CustomStyleManger.normalText.copyWith(
                color: CustomColorsManager.lightTextColor,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: CustomColorsManager.mainTextColor.withValues(alpha: 0.25),
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
