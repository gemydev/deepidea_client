import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/assets_manager/assets_manager.dart';

class CustomImage extends StatelessWidget {
  final String? imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? imageColor;
  final Widget? placeholder;
  final Widget? errorWidget;

  const CustomImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.imageColor,
    this.placeholder,
    this.errorWidget,
  });

  bool get _isNetwork =>
      imagePath != null &&
      (imagePath!.startsWith('http://') || imagePath!.startsWith('https://'));

  bool get _isSvg =>
      imagePath != null && imagePath!.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    // 🟢 لو imagePath فاضي أو null
    if (imagePath == null || imagePath!.isEmpty || imagePath == "null") {
      return errorWidget ??
          Image.asset(
            CustomAssetsManager.test,
            width: width,
            height: height,
            fit: fit,
          );
    }

    // 🟢 SVG من الإنترنت
    if (_isNetwork && _isSvg) {
      return SvgPicture.network(
        imagePath!,
        width: width,
        height: height,
        fit: fit,
        colorFilter: imageColor != null
            ? ColorFilter.mode(imageColor!, BlendMode.srcIn)
            : null,
        placeholderBuilder: (context) =>
            placeholder ??
            Center(
              child: SizedBox(
                width: width ?? 24,
                height: height ?? 24,
                child: const CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ??
            Image.asset(
              CustomAssetsManager.test,
              width: width,
              height: height,
              fit: fit,
            ),
      );
    }

    // 🟢 صورة عادية من الإنترنت
    if (_isNetwork) {
      return Image.network(
        imagePath!,
        width: width,
        height: height,
        fit: fit,
        color: imageColor,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return placeholder ??
              Center(
                child: SizedBox(
                  width: width ?? 24,
                  height: height ?? 24,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                ),
              );
        },
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ??
            Image.asset(
              CustomAssetsManager.test,
              width: width,
              height: height,
              fit: fit,
            ),
      );
    }

    // 🟣 SVG من الـ assets
    if (_isSvg) {
      return SvgPicture.asset(
        imagePath!,
        width: width,
        height: height,
        fit: fit,
        colorFilter: imageColor != null
            ? ColorFilter.mode(imageColor!, BlendMode.srcIn)
            : null,
      );
    }

    // 🟣 صورة عادية من الـ assets
    return Image.asset(
      imagePath!,
      width: width,
      height: height,
      fit: fit,
      color: imageColor,
      errorBuilder: (context, error, stackTrace) =>
          errorWidget ??
          Image.asset(
            CustomAssetsManager.test,
            width: width,
            height: height,
            fit: fit,
          ),
    );
  }
}
