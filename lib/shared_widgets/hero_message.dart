import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_text.dart';

/// Hero block: icon in circle, title, and optional description.
class HeroMessage extends StatelessWidget {
  const HeroMessage({
    super.key,
    required this.iconPath,
    required this.title,
    this.description,
    this.iconColor,
    this.iconBgColor,
    this.iconSize = 80,
    this.iconPadding = 20,
  });

  final String iconPath;
  final String title;
  final String? description;
  final Color? iconColor;
  final Color? iconBgColor;
  final double iconSize;
  final double iconPadding;

  @override
  Widget build(BuildContext context) {
    final color = iconColor ?? CustomColorsManager.primaryColor;
    final bg = iconBgColor ?? color.withValues(alpha: 0.4);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            width: iconSize,
            height: iconSize,
            decoration: BoxDecoration(shape: BoxShape.circle, color: bg),
            padding: EdgeInsets.all(iconPadding),
            child: SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
          ),
          const SizedBox(height: 16),
          CustomText(
            title,
            style: CustomStyleManger.heading1.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: CustomColorsManager.black,
            ),
            textAlign: TextAlign.center,
          ),
          if (description != null && description!.isNotEmpty) ...[
            const SizedBox(height: 8),
            CustomText(
              description!,
              style: CustomStyleManger.normalText.copyWith(
                fontSize: 14,
                color: CustomColorsManager.lightTextColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 4,
            ),
          ],
        ],
      ),
    );
  }
}
