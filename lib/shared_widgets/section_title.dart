import 'package:flutter/material.dart';

import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_text.dart';

/// Section title with consistent padding and style.
class SectionTitle extends StatelessWidget {
  const SectionTitle(
    this.title, {
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.fontSize = 18,
  });

  final String title;
  final EdgeInsetsGeometry padding;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: CustomText(
        title,
        style: CustomStyleManger.heading1.copyWith(fontSize: fontSize, fontWeight: FontWeight.w500),
      ),
    );
  }
}
