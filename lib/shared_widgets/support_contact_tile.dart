import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:remotely/core/utils/assets_manager/assets_manager.dart';
import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_text.dart';

/// A tappable tile with icon (primary circle), title, subtitle, and trailing icon.
class SupportContactTile extends StatelessWidget {
  const SupportContactTile({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.subtitleColor,
    this.showShadow = true,
  });

  final String iconPath;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Color? subtitleColor;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: CustomColorsManager.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: showShadow
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: CustomColorsManager.primaryColor,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                iconPath,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(CustomColorsManager.white, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    title,
                    style: CustomStyleManger.heading1.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: CustomColorsManager.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  CustomText(
                    subtitle,
                    style: CustomStyleManger.normalText.copyWith(
                      fontSize: 13,
                      color: subtitleColor ?? CustomColorsManager.lightTextColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(
              CustomAssetsManager.mouse,

              colorFilter: ColorFilter.mode(CustomColorsManager.primaryColor, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }
}
