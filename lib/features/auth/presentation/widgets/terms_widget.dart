import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remotely/core/utils/routes_manager/routes_manager.dart';

class TermsAndPrivacyWidget extends StatelessWidget {
  const TermsAndPrivacyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl, // Set text direction to RTL for Arabic
      text: TextSpan(
        text: 'الانضمام إلى تطبيقنا يعني موافقتك على ',
        style: TextStyle(color: CustomColorsManager.lightTextColor, fontSize: 16),
        children: [
          TextSpan(
            text: 'شروط الاستخدام',
            style: TextStyle(color: CustomColorsManager.primaryColor, fontSize: 16),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Handle Terms of Use tap
              },
          ),
          TextSpan(
            text: ' و ',
            style: TextStyle(color: CustomColorsManager.lightTextColor, fontSize: 16),
          ),
          TextSpan(
            text: 'سياسة الخصوصية',
            style: TextStyle(color: CustomColorsManager.primaryColor, fontSize: 16),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.toNamed(Routes.privacy);
              },
          ),
        ],
      ),
    );
  }
}
