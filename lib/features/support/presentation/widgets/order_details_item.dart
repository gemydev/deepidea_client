import 'package:flutter/material.dart';

import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/utils/style_manager/style_manager.dart';
import '../../../../core/widgets/custom_text.dart';

class OrderDetailsItem extends StatelessWidget {
  const OrderDetailsItem({super.key, required this.title, required this.data});

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          title,
          style: CustomStyleManger.heading1.copyWith(
            fontSize: 14,
            color: CustomColorsManager.lightGrayTextColor,
          ),
        ),
        Expanded(
          child: CustomText(
            data,
            textAlign: TextAlign.end,
            style: CustomStyleManger.heading1.copyWith(
              fontSize: 14,
              color: CustomColorsManager.mainTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
