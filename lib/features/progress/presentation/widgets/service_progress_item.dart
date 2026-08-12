import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/assets_manager/assets_manager.dart';
import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/utils/routes_manager/routes_manager.dart';
import '../../../../core/utils/style_manager/style_manager.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../../../core/widgets/custom_text.dart';
import 'custom_progress_bar.dart';

class ServiceProgressItem extends StatelessWidget {
  const ServiceProgressItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.serviceDetails, arguments: [false, true]);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: CustomColorsManager.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomImage(
                imagePath: CustomAssetsManager.test,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 5,
              ),
              CustomText(
                "أقرار ضريبي",
                style: CustomStyleManger.heading1.copyWith(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: BookingStart(),
                  ),
                  Flexible(
                    flex: 1,
                    child: ServiceEnd(),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              CustomProgressBar(
                label: 'يوم',
                progress: 0.75,
              ),
              const SizedBox(
                height: 5,
              ),
              CustomText(
                "متبقي 4 يوم علي الانتهاء من العمل",
                style: CustomStyleManger.normalText.copyWith(fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceEnd extends StatelessWidget {
  const ServiceEnd({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomImage(
          imagePath: CustomAssetsManager.calendar,
          height: 18,
          imageColor: CustomColorsManager.lightTextColor,
        ),
        const SizedBox(
          width: 10,
        ),
        CustomText(
          "انهاء الخدمة:",
          style: CustomStyleManger.normalText.copyWith(
              fontSize: 15, color: CustomColorsManager.lightTextColor),
        ),
        const SizedBox(
          width: 5,
        ),
        CustomText(
          "16 مارس",
          style: CustomStyleManger.normalText.copyWith(
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}

class BookingStart extends StatelessWidget {
  const BookingStart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomImage(
          imagePath: CustomAssetsManager.calendar,
          height: 18,
          imageColor: CustomColorsManager.lightTextColor,
        ),
        const SizedBox(
          width: 5,
        ),
        CustomText(
          "بداية الحجز:",
          style: CustomStyleManger.normalText.copyWith(
              fontSize: 15, color: CustomColorsManager.lightTextColor),
        ),
        const SizedBox(
          width: 5,
        ),
        CustomText(
          "12 مارس",
          style: CustomStyleManger.normalText.copyWith(
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
