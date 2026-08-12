import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class DaysFilter extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  const DaysFilter({super.key, required this.selectedIndex, required this.onTabChanged});

  @override
  State<DaysFilter> createState() => _DaysFilterState();
}

class _DaysFilterState extends State<DaysFilter> {
  final List<String> tabs = ['أمس', 'اليوم', 'الغد', '28 مايو', '29 مايو', '30 مايو'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(tabs.length, (index) {
          bool isSelected = widget.selectedIndex == index;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
            child: GestureDetector(
              onTap: () => widget.onTabChanged(index),
              child: Column(
                children: [
                  CustomText(
                    tabs[index],
                    style: CustomStyleManger.normalText.copyWith(
                      fontSize: 17,
                      color: isSelected
                          ? CustomColorsManager.primaryColor
                          : CustomColorsManager.lightTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 2.5,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: isSelected ? CustomColorsManager.primaryColor : Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
