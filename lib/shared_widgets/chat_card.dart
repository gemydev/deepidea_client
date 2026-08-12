import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_text.dart';

/// A tappable card with icon in colored circle, title, subtitle, and trailing arrow.
class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.iconPath,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    this.onTap,
    required this.hintColor,
    required this.hintText,
  });

  final String iconPath;
  final Color iconBgColor;
  final Color hintColor;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: CustomColorsManager.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(color: iconBgColor, shape: BoxShape.circle),
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(iconPath),
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
                          color: CustomColorsManager.lightTextColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: CustomColorsManager.icontBGColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: CustomText(
                    'محادثة',
                    style: CustomStyleManger.normalText.copyWith(
                      fontSize: 12,
                      color: CustomColorsManager.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 30,
          top: -15,
          child: Container(
            decoration: BoxDecoration(color: hintColor, borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: CustomText(
              hintText,
              style: CustomStyleManger.normalText.copyWith(
                fontSize: 12,
                color: CustomColorsManager.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
