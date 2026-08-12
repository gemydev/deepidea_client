import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:flutter/material.dart';

class CustomCircularButton extends StatelessWidget {
  final double size;
  final double progress;
  final GestureTapCallback? onPressed;

  const CustomCircularButton({
    super.key,
    this.size = 50.0,
    this.progress = 0.7,
    this.onPressed, // Change this value to adjust the progress
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 2,
            color: CustomColorsManager.primaryColor, // Set the color of the progress indicator
            backgroundColor: CustomColorsManager.unSelectedBorderColor, // Background track color
          ),
          GestureDetector(
            onTap: onPressed,
            child: Container(
              width: 30,
              decoration: BoxDecoration(
                color: CustomColorsManager.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
