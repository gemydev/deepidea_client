import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:remotely/core/utils/assets_manager/assets_manager.dart';
import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_text.dart';

/// Primary-colored CTA card with icon in white circle, title, subtitle, and trailing icon.
class PrimaryCtaCard extends StatelessWidget {
  const PrimaryCtaCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    this.trailingIconPath,
    this.onTap,
  });

  final String iconPath;
  final String title;
  final String subtitle;
  final String? trailingIconPath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final trailing = trailingIconPath ?? CustomAssetsManager.mouse;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: CustomColorsManager.primaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: CustomColorsManager.white,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: SvgPicture.asset(
                iconPath,
                colorFilter: ColorFilter.mode(
                  CustomColorsManager.primaryColor,
                  BlendMode.srcIn,
                ),
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
                      fontWeight: FontWeight.bold,
                      color: CustomColorsManager.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  CustomText(
                    subtitle,
                    style: CustomStyleManger.normalText.copyWith(
                      fontSize: 13,
                      color: CustomColorsManager.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(
              trailing,
              colorFilter: const ColorFilter.mode(
                CustomColorsManager.white,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
