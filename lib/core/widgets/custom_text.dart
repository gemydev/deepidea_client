import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;

  // Styling parameters
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextDecoration? decoration;
  final double? letterSpacing;
  final double? height;

  // Layout parameters
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextStyle? style;

  const CustomText(
    this.text, {
    super.key,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.decoration,
    this.letterSpacing,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = TextStyle(
      fontSize: fontSize ?? 16,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? CustomColorsManager.black,
      decoration: decoration,
      letterSpacing: letterSpacing,
      height: height,
    );

    return Text(
      text,
      style: style != null ? defaultStyle.merge(style) : defaultStyle,
      textAlign: textAlign,
      softWrap: true,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
    );
  }
}
