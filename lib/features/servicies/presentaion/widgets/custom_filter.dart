import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomChipTabBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  const CustomChipTabBar({super.key, required this.selectedIndex, required this.onTabChanged});

  @override
  State<CustomChipTabBar> createState() => _CustomChipTabBarState();
}

class _CustomChipTabBarState extends State<CustomChipTabBar> {
  final List<String> tabs = ['تمويل 1', 'عقد عمل', 'محاسبة مالية', 'إقرار ضريبي', 'إقرار ضريبي'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(tabs.length, (index) {
          bool isSelected = widget.selectedIndex == index;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GestureDetector(
              onTap: () => widget.onTabChanged(index),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColorsManager.white,
                  border: Border.all(
                    color: isSelected
                        ? CustomColorsManager.primaryColor
                        : CustomColorsManager.lightTextColor,
                  ),
                ),
                child: CustomText(
                  tabs[index],
                  style: CustomStyleManger.normalText.copyWith(
                    fontSize: 16,
                    color: isSelected
                        ? CustomColorsManager.primaryColor
                        : CustomColorsManager.lightTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
