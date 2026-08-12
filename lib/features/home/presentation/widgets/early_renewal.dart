import 'package:remotely/core/utils/assets_manager/assets_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_image.dart';
import 'package:remotely/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/color_manager/color_manager.dart';

class EarlyRenewal extends StatelessWidget {
  const EarlyRenewal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColorsManager.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          height: 125,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xffFCBE1F), Color(0xffF48A27)]),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          "التجديد المبكر",
                          style: CustomStyleManger.heading1.copyWith(
                            fontSize: 20,
                            color: CustomColorsManager.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const CustomImage(imagePath: CustomAssetsManager.bird),
                      ],
                    ),
                    SizedBox(height: 5),
                    CustomText(
                      "اشتركك لم ينتهي, ولكن يجيب عليك التجديد قبل 3 أشهر من الانتهاء",
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      style: CustomStyleManger.normalText.copyWith(
                        color: CustomColorsManager.white,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
              CustomImage(imagePath: CustomAssetsManager.discount),
            ],
          ),
        ),
      ),
    );
  }
}
