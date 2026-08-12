import 'package:remotely/core/utils/assets_manager/assets_manager.dart';
import 'package:remotely/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/utils/style_manager/style_manager.dart';
import '../../../../core/widgets/custom_text.dart';

class BestPlan extends StatelessWidget {
  const BestPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColorsManager.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              "ما الذي يجعل خطتنا الأفضل",
              style: CustomStyleManger.heading1.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      const CustomImage(imagePath: CustomAssetsManager.dolarPNG),
                      const SizedBox(height: 10),
                      CustomText(
                        "أسعار معقولة وخدمة سريعة",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: CustomStyleManger.normalText.copyWith(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      const CustomImage(imagePath: CustomAssetsManager.expertsPNG),
                      const SizedBox(height: 10),
                      CustomText(
                        "خبراء استشاريون في مجالهم",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: CustomStyleManger.normalText.copyWith(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      const CustomImage(imagePath: CustomAssetsManager.giftsPNG),
                      const SizedBox(height: 10),
                      CustomText(
                        "نقاط الولاد المكتسبة",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: CustomStyleManger.normalText.copyWith(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
