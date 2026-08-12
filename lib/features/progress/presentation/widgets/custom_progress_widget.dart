import 'dart:math';

import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_text.dart';

class CustomProgressWidget extends StatelessWidget {
  final num percentage;

  const CustomProgressWidget({super.key, required this.percentage});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(100, 50),
      painter: SemiCirclePainter(percentage: percentage),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              '${percentage.toString()}%',
              style: CustomStyleManger.normalText.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            CustomText('مكتمل', style: CustomStyleManger.normalText.copyWith(fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

// Painter for the semi-circle
class SemiCirclePainter extends CustomPainter {
  final num percentage;

  SemiCirclePainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final paintBackground = Paint()
      ..color = Color(0xff1E8BAF).withValues(alpha: 0.2)
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final paintForeground = Paint()
      ..color = CustomColorsManager.primaryColor
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 5;

    // Draw the background semi-circle
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      pi, // Full semi-circle
      false,
      paintBackground,
    );

    // Draw the progress semi-circle
    final sweepAngle = pi * (percentage / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      sweepAngle,
      false,
      paintForeground,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
