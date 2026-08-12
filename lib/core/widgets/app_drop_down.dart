import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class AppDropdown extends StatefulWidget {
  const AppDropdown({
    super.key,
    required this.options,
    required this.hint,
    this.header,
    this.borderColor,
    this.buttonColor,
    this.onChanged,
    this.icon,
    this.value,
    this.withRiyalSign = false,
  });

  final List<String> options;
  final String hint;
  final String? header;
  final String? value;
  final Color? borderColor;
  final Color? buttonColor;
  final ValueChanged<String>? onChanged;
  final Widget? icon;
  final bool withRiyalSign;

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  String? selectedValue;

  @override
  void initState() {
    selectedValue = widget.value;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AppDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      selectedValue = widget.value;
    }
    if (selectedValue != null && !widget.options.contains(selectedValue)) {
      selectedValue = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onChanged != null && widget.options.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: widget.buttonColor ?? CustomColorsManager.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: widget.borderColor ?? CustomColorsManager.lightTextColor),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DropdownButton<String>(
            hint: CustomText(widget.hint, style: CustomStyleManger.normalText),
            value: selectedValue,
            isExpanded: true,
            underline: const SizedBox(),
            dropdownColor: CustomColorsManager.white,
            icon: widget.icon ?? const Icon(Icons.keyboard_arrow_down_rounded),
            onChanged: enabled
                ? (String? newValue) {
                    if (newValue == null) return;
                    widget.onChanged!(newValue);
                    setState(() {
                      selectedValue = newValue;
                    });
                  }
                : null,
            items: widget.options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: CustomText(
                  value,
                  style: CustomStyleManger.normalText.copyWith(
                    fontSize: 13,
                    color: CustomColorsManager.mainTextColor,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
