import 'package:remotely/core/utils/assets_manager/assets_manager.dart';
import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_image.dart';
import 'package:remotely/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class EndedServices extends StatelessWidget {
  const EndedServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      color: CustomColorsManager.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText("تتبع خدماتك", style: CustomStyleManger.heading1.copyWith(fontSize: 20)),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomText(
                    "تم الانتهاء من الاقرار الضريبي, لاتنسي تقييم الخدمة",
                    style: CustomStyleManger.normalText.copyWith(
                      fontSize: 16,
                      color: CustomColorsManager.lightTextColor,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const CustomImage(imagePath: CustomAssetsManager.star2PNG),
              ],
            ),
            const SizedBox(height: 5),
            // const Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     InfoCard(
            //       iconPath: CustomAssetsManager.windowSign,
            //       label: "رقم التسجيل",
            //       count: "#214",
            //     ),
            //     InfoCard(
            //       iconPath: CustomAssetsManager.calendar,
            //       label: "فترة الضريبة",
            //       count: "XXX-XXX",
            //     ),
            //     InfoCard(
            //       iconPath: CustomAssetsManager.dollarSquare,
            //       label: "إجمالي الضريبة",
            //       count: "56%",
            //     ),
            //     InfoCard(
            //       iconPath: CustomAssetsManager.timer,
            //       label: "وقت الانتهاء",
            //       count: "6ص-10ص",
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}

// Custom Widget for Each Card
class InfoCard extends StatelessWidget {
  final String iconPath;
  final String label;
  final String count;

  const InfoCard({super.key, required this.iconPath, required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: CustomColorsManager.green.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomImage(
                imagePath: iconPath,
                imageColor: CustomColorsManager.appGreen,
                width: 20,
                height: 20,
              ),
            ),
          ),
          const SizedBox(height: 3),
          CustomText(
            label,
            textAlign: TextAlign.center,
            style: CustomStyleManger.normalText.copyWith(
              fontSize: 14,
              color: CustomColorsManager.lightTextColor,
            ),
          ),
          const SizedBox(height: 3),
          CustomText(count, style: CustomStyleManger.normalText.copyWith(fontSize: 12)),
        ],
      ),
    );
  }
}
