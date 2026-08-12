import 'package:remotely/core/utils/assets_manager/assets_manager.dart';
import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/routes_manager/routes_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_image.dart';
import 'package:remotely/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Additions extends StatelessWidget {
  const Additions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: CustomColorsManager.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  "إضافات علي الاشتراك",
                  style: CustomStyleManger.heading1.copyWith(fontSize: 20),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.services, arguments: [1]);
                  },
                  child: CustomText(
                    "عرض الكل",
                    style: CustomStyleManger.normalText.copyWith(
                      fontSize: 15,
                      color: CustomColorsManager.lightTextColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            CustomText(
              "استمتع بمجموعة مختارة من الإضافة عند الاشتراك الذي تفضله",
              style: CustomStyleManger.normalText.copyWith(
                fontSize: 16,
                color: CustomColorsManager.lightTextColor,
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InfoCard(label: "إضافة 1"),
                InfoCard(label: "إضافة 2"),
                InfoCard(label: "إضافة 3"),
                InfoCard(label: "إضافة 4"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Widget for Each Card
class InfoCard extends StatelessWidget {
  final String label;

  const InfoCard({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CustomColorsManager.unSelectedBorderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              label,
              textAlign: TextAlign.center,
              style: CustomStyleManger.normalText.copyWith(
                fontSize: 17,
                color: CustomColorsManager.mainTextColor,
              ),
            ),
            const SizedBox(height: 8),
            CustomImage(
              imagePath: CustomAssetsManager.legal2,
              imageColor: CustomColorsManager.appGreen,
              width: 35,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
