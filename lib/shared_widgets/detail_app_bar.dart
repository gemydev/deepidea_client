import 'package:flutter/material.dart';

import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_text.dart';
import 'package:remotely/shared_widgets/circle_icon_button.dart';

/// App bar for detail screens: back button (circle) + centered title.
class DetailAppBar extends StatelessWidget {
  const DetailAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.backFilled = true,
  });

  final String title;
  final VoidCallback? onBack;
  final bool backFilled;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColorsManager.white,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
      child: Row(
        children: [
          CircleIconButton(
            icon: Icons.arrow_back,
            filled: backFilled,
            iconColor: backFilled ? CustomColorsManager.white : CustomColorsManager.black,
            onTap: onBack ?? () => Navigator.pop(context),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Center(
              child: CustomText(
                title,
                style: CustomStyleManger.heading1.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: CustomColorsManager.mainTextColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 44),
        ],
      ),
    );
  }
}
