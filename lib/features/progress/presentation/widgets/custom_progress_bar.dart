import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final double progress;
  final String label;

  const CustomProgressBar({super.key, required this.progress, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Container(
            height: 25.0,
            decoration: BoxDecoration(
              color: CustomColorsManager.unSelectedBorderColor.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          FractionallySizedBox(
            widthFactor: progress,
            child: Container(
              height: 25.0,
              decoration: BoxDecoration(
                color: CustomColorsManager.appGreen, // Customize this color as needed
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      label,
                      style: CustomStyleManger.normalText.copyWith(
                        fontSize: 16,
                        color: CustomColorsManager.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
