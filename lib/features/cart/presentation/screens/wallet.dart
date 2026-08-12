import 'package:remotely/core/utils/assets_manager/assets_manager.dart';
import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_button.dart';
import 'package:remotely/core/widgets/custom_image.dart';
import 'package:remotely/core/widgets/custom_text.dart';
import 'package:remotely/features/support/presentation/widgets/sub_app_bar.dart';
import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorsManager.scaffoldBGColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SubAppBar(title: "محفظتي"),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: CustomColorsManager.primaryColor,
                ),
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            "الرصيد المتاح",
                            style: CustomStyleManger.normalText.copyWith(
                              color: CustomColorsManager.white,
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(height: 10),
                          CustomText(
                            "-250 \$",
                            style: CustomStyleManger.normalText.copyWith(
                              color: CustomColorsManager.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                      text: "تحويل",
                      fontSize: 17,
                      backGroundColor: CustomColorsManager.white,
                      textColor: CustomColorsManager.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              color: CustomColorsManager.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: Column(
                  children: [WalletItem(), Divider(), WalletItem(), Divider(), WalletItem()],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WalletItem extends StatelessWidget {
  const WalletItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: CustomColorsManager.white),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImage(imagePath: CustomAssetsManager.cardTick, height: 25),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "سحب من البطاقة",
                    style: CustomStyleManger.normalText.copyWith(
                      color: CustomColorsManager.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomText(
                    "(باستثناء رسوم 1٪)",
                    style: CustomStyleManger.normalText.copyWith(
                      color: CustomColorsManager.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomText(
                    "17 مارس 2023 | 8:00 مساءً",
                    maxLines: 1,
                    style: CustomStyleManger.normalText.copyWith(
                      color: CustomColorsManager.grayTextColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            CustomText(
              "+43 ر.س",
              style: CustomStyleManger.normalText.copyWith(
                color: CustomColorsManager.appRed,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
