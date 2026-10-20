import 'package:flutter/material.dart';

import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/widgets/custom_text.dart';

/// A label above a child widget (e.g. TextField or dropdown). Use for consistent form layout.
class LabeledFormField extends StatelessWidget {
  const LabeledFormField({
    super.key,
    required this.label,
    required this.child,
    this.labelStyle,
    this.spacing = 8,
    this.isOptional = false,
  });

  static const TextStyle _defaultLabelStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: CustomColorsManager.mainTextColor,
  );

  final String label;
  final Widget child;

  /// Appends a muted "(اختياري)" hint so the user knows the field can be left empty.
  final bool isOptional;
  final TextStyle? labelStyle;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Flexible(child: CustomText(label, style: labelStyle ?? _defaultLabelStyle)),
            if (isOptional) ...[
              const SizedBox(width: 6),
              CustomText(
                '(اختياري)',
                style: (labelStyle ?? _defaultLabelStyle).copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: CustomColorsManager.lightGrayTextColor,
                ),
              ),
            ],
          ],
        ),
        SizedBox(height: spacing),
        child,
      ],
    );
  }
}
