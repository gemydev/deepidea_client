import 'package:remotely/core/utils/assets_manager/assets_manager.dart';
import 'package:remotely/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/utils/style_manager/style_manager.dart';
import '../../../../core/widgets/custom_text.dart';

class NewServices extends StatelessWidget {
  const NewServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColorsManager.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomText(
                  "خدمات جديدة ",
                  style: CustomStyleManger.heading1.copyWith(fontSize: 15),
                ),
                const SizedBox(width: 5),
                const CustomImage(imagePath: CustomAssetsManager.stars),
              ],
            ),
            const SizedBox(height: 5),
            //  AAPService(),
          ],
        ),
      ),
    );
  }
}
