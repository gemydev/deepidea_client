import 'package:remotely/core/utils/assets_manager/assets_manager.dart';
import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_image.dart';
import 'package:remotely/core/widgets/custom_text.dart';
import 'package:remotely/features/support/presentation/widgets/sub_app_bar.dart';
import 'package:flutter/material.dart';

class LoyaltyPoints extends StatefulWidget {
  const LoyaltyPoints({super.key});

  @override
  State<LoyaltyPoints> createState() => _LoyaltyPointsState();
}

class _LoyaltyPointsState extends State<LoyaltyPoints> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorsManager.scaffoldBGColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SubAppBar(title: "نقاط الولاء"),
            const SizedBox(height: 10),
            Container(
              color: CustomColorsManager.appGreen,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                "نقاط الولاء",
                                style: CustomStyleManger.normalText.copyWith(
                                  color: CustomColorsManager.white,
                                  fontSize: 17,
                                ),
                              ),
                              const SizedBox(height: 8),
                              CustomText(
                                "50 نقطة",
                                style: CustomStyleManger.heading1.copyWith(
                                  color: CustomColorsManager.white,
                                  fontSize: 30,
                                ),
                              ),
                              const SizedBox(height: 8),
                              CustomText(
                                "اكسب المزيد من النقاط واستمتع بالمزايا الحصرية",
                                style: CustomStyleManger.normalText.copyWith(
                                  color: CustomColorsManager.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const CustomImage(imagePath: CustomAssetsManager.notoWrapped, height: 70),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: CustomColorsManager.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: CustomColorsManager.white),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    "100 نقطة مجانية",
                                    style: CustomStyleManger.heading1.copyWith(
                                      color: CustomColorsManager.white,
                                      fontSize: 22,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  CustomText(
                                    "الوقت المتبقي : 10:45:22",
                                    style: CustomStyleManger.normalText.copyWith(
                                      color: CustomColorsManager.lightWhiteTextColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: CustomColorsManager.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40),
                                child: CustomText(
                                  "جمع",
                                  style: CustomStyleManger.normalText.copyWith(
                                    color: CustomColorsManager.primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              color: CustomColorsManager.white,
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    "احصل علي 100 ر.س",
                    style: CustomStyleManger.heading1.copyWith(fontSize: 15),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: CustomColorsManager.unSelectedBorderColor.withValues(alpha: 0.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: CustomColorsManager.lightTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "خصومات",
                    style: CustomStyleManger.normalText.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    "متاح لتجديد الاشتراك",
                    style: CustomStyleManger.normalText.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                      color: CustomColorsManager.lightTextColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: CustomColorsManager.white.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: CustomColorsManager.unSelectedBorderColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          CustomText(
                            "700",
                            style: CustomStyleManger.normalText.copyWith(
                              color: CustomColorsManager.appGreen,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          CustomText(
                            "نقطة",
                            style: CustomStyleManger.normalText.copyWith(
                              color: CustomColorsManager.appGreen,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    "خصم 50 ريال",
                                    style: CustomStyleManger.heading1.copyWith(fontSize: 20),
                                  ),
                                  CustomText(
                                    "قم بالضغط علي جمع لكي تحصل علي الكود",
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    style: CustomStyleManger.normalText.copyWith(
                                      color: CustomColorsManager.lightTextColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 5),
                            Container(
                              decoration: BoxDecoration(
                                color: CustomColorsManager.white,
                                border: Border.all(color: CustomColorsManager.primaryColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
                                child: CustomText(
                                  "جمع",
                                  style: CustomStyleManger.normalText.copyWith(
                                    color: CustomColorsManager.primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InvitationItem extends StatelessWidget {
  const InvitationItem({super.key, required this.title, required this.imagePath});

  final String title;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: CustomColorsManager.white,
            shape: BoxShape.circle,
            border: Border.all(color: CustomColorsManager.unSelectedBorderColor),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomImage(imagePath: imagePath, height: 25),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: CustomText(
            title,
            textAlign: TextAlign.start,
            maxLines: 3,
            style: CustomStyleManger.normalText.copyWith(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
