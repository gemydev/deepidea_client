import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_image.dart';

class ServiceItem extends StatelessWidget {
  const ServiceItem({
    super.key,
    required this.index,
    required this.isSelected,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.imagePath,
  });

  final int index;
  final bool isSelected;
  final String title;
  final String subtitle;
  final String imagePath;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? CustomColorsManager.primaryColor
                : CustomColorsManager.unSelectedBorderColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title,
                    style: CustomStyleManger.normalText.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    subtitle,
                    style: CustomStyleManger.normalText.copyWith(
                      fontSize: 14,
                      color: CustomColorsManager.lightTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            CustomImage(imagePath: imagePath),
          ],
        ),
      ),
    );
  }
}
