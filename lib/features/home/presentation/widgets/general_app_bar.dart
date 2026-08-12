import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/assets_manager/assets_manager.dart';
import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/utils/formatter/date_format.dart';
import '../../../../core/widgets/custom_image.dart';
import 'cart_button.dart';

class GeneralAppBar extends StatefulWidget {
  const GeneralAppBar({super.key, this.withDailyFilter = false});

  final bool withDailyFilter;

  @override
  State<GeneralAppBar> createState() => _GeneralAppBarState();
}

class _GeneralAppBarState extends State<GeneralAppBar> {
  int chipSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColorsManager.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.withDailyFilter
                    ? CustomText(getTodayNameInArabic(), style: CustomStyleManger.heading1)
                    : CustomImage(imagePath: CustomAssetsManager.logoPNG, height: 45),
                Row(
                  children: [
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.toNamed(Routes.notifications);
                    //   },
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(8),
                    //         color: CustomColorsManager.profileBGColor),
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: const CustomImage(
                    //           imagePath: CustomAssetsManager.notificationBing),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   width: 10,
                    // ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.toNamed(Routes.wallet);
                    //   },
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(8),
                    //         color: CustomColorsManager.profileBGColor),
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: CustomImage(
                    //         imagePath: CustomAssetsManager.wallet,
                    //         imageColor: CustomColorsManager.primaryColor,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   width: 10,
                    // ),
                    CartButton(),
                    const SizedBox(width: 10),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       color: CustomColorsManager.profileBGColor),
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //         vertical: 10, horizontal: 10),
                    //     child: Row(
                    //       children: [
                    //         const CustomImage(
                    //           imagePath: CustomAssetsManager.gift2,
                    //           height: 20,
                    //         ),
                    //         const SizedBox(
                    //           width: 8,
                    //         ),
                    //         CustomText(
                    //           "50 نقطة",
                    //           style: CustomStyleManger.normalText.copyWith(
                    //               fontSize: 16,
                    //               fontWeight: FontWeight.w600,
                    //               color: CustomColorsManager.mainTextColor),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            // widget.withDailyFilter
            //     ? DaysFilter(
            //         selectedIndex: chipSelectedIndex,
            //         onTabChanged: (index) {
            //           setState(() {
            //             chipSelectedIndex = index;
            //           });
            //         },
            //       )
            //     : Container()
          ],
        ),
      ),
    );
  }
}
