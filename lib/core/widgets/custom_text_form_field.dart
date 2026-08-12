import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/color_manager/color_manager.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final int? maxLines;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final bool enabled;
  final TextInputAction? textInputAction;
  final double borderRadius;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.keyboardType,
    this.maxLines,
    this.onChanged,
    this.enabled = true,
    this.onFieldSubmitted,
    this.textInputAction,
    this.borderRadius = 12,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Focus(
        onFocusChange: (focus) => setState(() => _isFocused = focus),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: CustomColorsManager.primaryColor.withValues(alpha: 0.12),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [],
          ),
          child: TextFormField(
            controller: widget.controller,
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onFieldSubmitted,
            textInputAction: widget.textInputAction,
            obscureText: widget.obscureText,
            enabled: widget.enabled,
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines ?? 1,
            validator: widget.validator,
            style: CustomStyleManger.normalText.copyWith(
              fontSize: 16,
              color: widget.enabled
                  ? CustomColorsManager.black
                  : CustomColorsManager.lightTextColor,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.enabled
                  ? CustomColorsManager.white
                  : CustomColorsManager.white.withValues(alpha: 0.9),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(color: CustomColorsManager.lightTextColor.withValues(alpha: 0.4)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(color: CustomColorsManager.lightTextColor, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(color: CustomColorsManager.primaryColor, width: 1.6),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(color: CustomColorsManager.appRed, width: 1.2),
              ),
              errorStyle: TextStyle(color: CustomColorsManager.appRed, fontSize: 13),
              hintText: widget.hintText,
              hintStyle: CustomStyleManger.normalText.copyWith(
                color: CustomColorsManager.lightTextColor,
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            ),
          ),
        ),
      ),
    );
  }
}
