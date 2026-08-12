import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:flutter/material.dart';

import '../utils/color_manager/color_manager.dart';
import 'custom_text.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final Color? backGroundColor;
  final Color? borderColor;
  final Color? textColor;
  final VoidCallback? onPressed;
  final bool withLoading;
  final bool withoutIcons;
  final Widget? arrowIcon;
  final double? fontSize;
  final Widget? child;

  const CustomButton({
    super.key,
    this.text = '',
    this.leftIcon,
    this.rightIcon,
    this.onPressed,
    this.backGroundColor,
    this.borderColor,
    this.withLoading = false,
    this.arrowIcon,
    this.withoutIcons = false,
    this.textColor,
    this.fontSize,
    this.child,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = widget.onPressed == null;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      cursor: isDisabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: isDisabled ? null : widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          transform: Matrix4.diagonal3Values(
            isHovering ? 1.03 : 1.0,
            isHovering ? 1.03 : 1.0,
            1.0,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          decoration: BoxDecoration(
            color: isDisabled
                ? (widget.backGroundColor ?? CustomColorsManager.primaryColor).withValues(alpha: 0.6)
                : isHovering
                ? (widget.backGroundColor ?? CustomColorsManager.primaryColor).withValues(alpha: 0.85)
                : widget.backGroundColor ?? CustomColorsManager.primaryColor,
            border: widget.borderColor != null ? Border.all(color: widget.borderColor!) : null,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isHovering
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child:
                  widget.child ??
                  CustomText(
                    widget.text,
                    style: CustomStyleManger.normalText.copyWith(
                      color: widget.textColor ?? CustomColorsManager.white,
                      fontWeight: FontWeight.w600,
                      fontSize: widget.fontSize ?? 15,
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
