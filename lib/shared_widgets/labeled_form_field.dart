import 'package:flutter/material.dart';

import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_text.dart';

/// A label above a child widget (e.g. TextField or dropdown). Use for consistent form layout.
class LabeledFormField extends StatelessWidget {
  const LabeledFormField({
    super.key,
    required this.label,
    required this.child,
    this.labelStyle,
    this.spacing = 8,
  });

  final String label;
  final Widget child;
  final TextStyle? labelStyle;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          label,
          style: labelStyle ??
              CustomStyleManger.normalText.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: CustomColorsManager.mainTextColor,
              ),
        ),
        SizedBox(height: spacing),
        child,
      ],
    );
  }
}
