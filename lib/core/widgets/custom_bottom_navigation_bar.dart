import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/assets_manager/assets_manager.dart';
import '../utils/color_manager/color_manager.dart';
import 'custom_image.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar(
      {super.key, required this.selectedPageIndex, this.onTap});

  final int selectedPageIndex;
  final ValueChanged<int>? onTap;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: CustomImage(
        imagePath: CustomAssetsManager.home,
        imageColor: CustomColorsManager.unSelectedBorderColor,
      ),
      activeIcon: CustomImage(
          imagePath: CustomAssetsManager.home,
          imageColor: CustomColorsManager.primaryColor),
      label: 'الرئيسية'.tr,
    ),
    BottomNavigationBarItem(
      icon: CustomImage(
        imagePath: CustomAssetsManager.progress,
        imageColor: CustomColorsManager.unSelectedBorderColor,
      ),
      activeIcon: CustomImage(
          imagePath: CustomAssetsManager.progress,
          imageColor: CustomColorsManager.primaryColor),
      label: 'التقدم'.tr,
    ),
    BottomNavigationBarItem(
      icon: CustomImage(
        imagePath: CustomAssetsManager.headphone,
        imageColor: CustomColorsManager.unSelectedBorderColor,
      ),
      activeIcon: CustomImage(
          imagePath: CustomAssetsManager.headphone,
          imageColor: CustomColorsManager.primaryColor),
      label: 'الدعم'.tr,
    ),
    BottomNavigationBarItem(
      icon: CustomImage(
        imagePath: CustomAssetsManager.user,
        imageColor: CustomColorsManager.unSelectedBorderColor,
      ),
      activeIcon: CustomImage(
          imagePath: CustomAssetsManager.user,
          imageColor: CustomColorsManager.primaryColor),
      label: 'الحساب'.tr,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        items: _bottomNavBarItems,
        currentIndex: widget.selectedPageIndex,
        onTap: widget.onTap,
        backgroundColor: CustomColorsManager.white,
        selectedItemColor: CustomColorsManager.mainTextColor,
        unselectedItemColor: CustomColorsManager.unSelectedBorderColor,
        type: BottomNavigationBarType.fixed,
        enableFeedback: false,
        useLegacyColorScheme: false,
        elevation: 0,
      ),
    );
  }
}
