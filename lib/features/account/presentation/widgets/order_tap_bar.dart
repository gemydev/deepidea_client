import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_text.dart';

class OrderTabBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;
  final List<String> listOfTitles;

  const OrderTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
    required this.listOfTitles,
  });

  @override
  State<OrderTabBar> createState() => _OrderTabBarState();
}

class _OrderTabBarState extends State<OrderTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColorsManager.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        child: Container(
          decoration: BoxDecoration(
            color: CustomColorsManager.profileBGColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: _buildTabItem(widget.listOfTitles[0], 0)),
                Expanded(child: _buildTabItem(widget.listOfTitles[1], 1)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(String text, int index) {
    bool isSelected = widget.selectedIndex == index;
    return GestureDetector(
      onTap: () => widget.onTabChanged(index),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? CustomColorsManager.primaryColor : Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: CustomText(
            text,
            style: CustomStyleManger.normalText.copyWith(
              fontSize: 16,
              color: isSelected ? CustomColorsManager.white : CustomColorsManager.mainTextColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
