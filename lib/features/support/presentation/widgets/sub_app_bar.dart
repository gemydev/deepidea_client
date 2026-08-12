import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/utils/style_manager/style_manager.dart';
import '../../../../core/widgets/custom_text.dart';

class SubAppBar extends StatelessWidget {
  const SubAppBar({
    super.key,
    required this.title,
    this.withBottomPadding = true,
    this.widget,
    this.onTap,
  });

  final String title;
  final bool withBottomPadding;
  final Widget? widget;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: CustomColorsManager.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap:
                          onTap ??
                          () {
                            Get.back();
                          },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: CustomColorsManager.unSelectedBorderColor,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Icon(
                            Icons.arrow_back,
                            color: CustomColorsManager.lightTextColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    CustomText(
                      title,
                      style: CustomStyleManger.normalText.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                widget ?? Container(),
              ],
            ),
          ),
        ),
        SizedBox(height: withBottomPadding ? 15 : 0),
      ],
    );
  }
}
