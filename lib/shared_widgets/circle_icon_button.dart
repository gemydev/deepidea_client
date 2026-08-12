import 'package:flutter/material.dart';

import 'package:remotely/core/utils/color_manager/color_manager.dart';

/// Circle button with an icon. Can be filled (primary) or outlined (border only).
class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.filled = false,
    this.fillColor,
    this.borderColor,
    this.iconColor,
    this.size = 44,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final bool filled;
  final Color? fillColor;
  final Color? borderColor;
  final Color? iconColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    final bg = filled
        ? (fillColor ?? CustomColorsManager.primaryColor)
        : Colors.transparent;
    final border = borderColor ?? CustomColorsManager.black;
    final color = iconColor ?? (filled ? CustomColorsManager.white : border);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(size / 2),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bg,
            border: filled ? null : Border.all(color: border, width: 1),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: color, size: size * 0.5),
        ),
      ),
    );
  }
}
