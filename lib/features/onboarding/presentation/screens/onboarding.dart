import 'package:remotely/core/helpers/preferences_manager.dart';
import 'package:remotely/core/utils/assets_manager/assets_manager.dart';
import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_button.dart';
import 'package:remotely/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/routes_manager/routes_manager.dart';
import '../../../../core/widgets/custom_text.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;

  void _navigateToLogin() {
    TpPreferencesManager.saveBool(TpPreferencesManager.hasSeenOnboarding, true);
    Get.offNamed(Routes.login);
  }

  void _nextPage() {
    if (_currentPage == onboardingData.length - 1) {
      _navigateToLogin();
    } else {
      setState(() => _currentPage++);
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() => _currentPage--);
    }
  }

  List<Map<String, String>> onboardingData = [
    {
      "title": "تحكم كامل في طلباتك",
      "description":
          "ارفع تذكرة، تابع حالتها (مفتوحة – تحت المعالجة – مقفلة)، وتواصل معنا نصيًا أو صوتيًا أو بالفيديو.",
      "image": CustomAssetsManager.onBoarding1PNG,
    },
    {
      "title": "باقة واحدة… كل شغلك",
      "description": "إدارة التذاكر، التواصل مع الدعم، ومتابعة حسابك كله في مكان واحد وبسهولة.",
      "image": CustomAssetsManager.onBoarding2PNG,
    },
    {
      "title": "متابعتك أسهل معنا",
      "description": "اطّلع على باقتك، تفاصيل اشتراكك، وتاريخ التجديد في أي وقت ومن غير تعقيد.",
      "image": CustomAssetsManager.onBoarding3PNG,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: OnboardingContent(
                    key: ValueKey<int>(_currentPage),
                    image: onboardingData[_currentPage]["image"]!,
                    title: onboardingData[_currentPage]["title"]!,
                    description: onboardingData[_currentPage]["description"]!,
                    itemCount: onboardingData.length,
                    currentPageIndex: _currentPage,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30, right: 50, left: 50),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomButton(
                      text: _currentPage == onboardingData.length - 1 ? "أبدا الان ←" : "التالي ←",
                      textColor: CustomColorsManager.white,
                      onPressed: _nextPage,
                    ),
                    if (_currentPage > 0) ...[
                      const SizedBox(height: 12),
                      CustomButton(
                        text: "→ السابق",
                        textColor: CustomColorsManager.primaryColor,
                        backGroundColor: CustomColorsManager.white,
                        borderColor: CustomColorsManager.primaryColor,
                        onPressed: _previousPage,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 50,
            right: 20,
            left: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                CustomImage(
                  imagePath: CustomAssetsManager.logoPNG,
                  width: 60,
                  height: 60,
                  fit: BoxFit.contain,
                ),
                GestureDetector(
                  onTap: _navigateToLogin,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: CustomColorsManager.black),
                    ),
                    child: CustomText(
                      "تخطي",
                      style: CustomStyleManger.normalText.copyWith(
                        fontSize: 20,
                        color: CustomColorsManager.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String image, title, description;
  final int itemCount;
  final int currentPageIndex;

  const OnboardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.itemCount,
    required this.currentPageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CustomImage(
              imagePath: image,
              height: 350,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                itemCount,
                (index) => Container(
                  margin: const EdgeInsets.only(right: 5),
                  height: 8,
                  width: currentPageIndex == index ? 25 : 8,
                  decoration: BoxDecoration(
                    color: currentPageIndex == index
                        ? CustomColorsManager.primaryColor
                        : CustomColorsManager.unSelectedBorderColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          CustomText(
            title,
            style: CustomStyleManger.heading1.copyWith(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: CustomColorsManager.primaryColor,
            ),
          ),
          const SizedBox(height: 5),
          CustomText(
            description,
            maxLines: 2,
            style: CustomStyleManger.normalText.copyWith(
              fontSize: 16,
              color: CustomColorsManager.lightTextColor,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
