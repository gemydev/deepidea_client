import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomTabBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;
  final List<String> listOfTitles;

  const CustomTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
    required this.listOfTitles,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColorsManager.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTabItem(widget.listOfTitles[0], 0),
            _buildTabItem(widget.listOfTitles[1], 1),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(String text, int index) {
    bool isSelected = widget.selectedIndex == index;
    return GestureDetector(
      onTap: () => widget.onTabChanged(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text,
            style: CustomStyleManger.normalText.copyWith(
              fontSize: 15,
              color: isSelected
                  ? CustomColorsManager.primaryColor
                  : CustomColorsManager.lightTextColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 8),
          if (isSelected)
            Container(
              decoration: BoxDecoration(
                color: CustomColorsManager.primaryColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
              ),
              width: 22,
              height: 3,
            ),
        ],
      ),
    );
  }
}
