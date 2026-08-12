import 'dart:developer';

import 'package:remotely/core/utils/assets_manager/assets_manager.dart';
import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_button.dart';
import 'package:remotely/core/widgets/custom_image.dart';
import 'package:remotely/core/widgets/custom_text.dart';
import 'package:remotely/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../../../servicies/presentaion/widgets/custom_rating_bar.dart';

class CustomBottomSheets {
  static void showNotesAdditionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      // Allows full-screen height
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 20.0,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: CustomColorsManager.unSelectedBorderColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomText(
                'اضافة ملاحظات',
                style: CustomStyleManger.heading1.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const CustomTextFormField(hintText: "اضف ملاحظاتك", maxLines: 5),
              const SizedBox(height: 15),
              const CustomButton(text: "إرسال", textColor: CustomColorsManager.white),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  static void showServiceRateBottomSheet(
    BuildContext context, {
    required int currentRate,
    required ValueChanged<int> onRatingChanged,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      // Allows full-screen height
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 20.0,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: CustomColorsManager.unSelectedBorderColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: const CustomImage(imagePath: CustomAssetsManager.test, fit: BoxFit.fill),
              ),
              const SizedBox(height: 15),
              CustomText(
                'إضافة تقييم للخدمة',
                style: CustomStyleManger.normalText.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              CustomRatingBar(
                maxRating: 5,
                onRatingSelected: (rating) {
                  log("Selected rating: $rating");
                },
              ),
              // StarRating(
              //   rating: currentRate,
              //   maxRating: 5,
              //   starSize: 32,
              //   onRatingChanged: onRatingChanged,
              // ),
              const SizedBox(height: 15),
              const CustomButton(text: "إرسال", textColor: CustomColorsManager.white),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
