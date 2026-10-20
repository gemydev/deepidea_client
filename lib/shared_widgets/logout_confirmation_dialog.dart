import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/utils/color_manager/color_manager.dart';
import '../core/utils/style_manager/style_manager.dart';
import '../core/widgets/custom_text.dart';

/// Asks the user to confirm before the session is ended.
/// Resolves to true only when the user picks "تسجيل الخروج".
Future<bool> showLogoutConfirmationDialog() async {
  if (Get.isDialogOpen == true) return false;

  final confirmed = await Get.dialog<bool>(
    const LogoutConfirmationDialog(),
    barrierDismissible: true,
  );

  return confirmed ?? false;
}

class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        decoration: BoxDecoration(
          color: CustomColorsManager.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: CustomColorsManager.appRed,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.logout, color: Colors.white, size: 36),
            ),
            const SizedBox(height: 20),
            CustomText(
              'هل أنت متأكد من تسجيل الخروج؟',
              style: CustomStyleManger.heading1.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: CustomColorsManager.black,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            CustomText(
              'سيتم إنهاء جلستك الحالية وستحتاج إلى تسجيل الدخول مرة أخرى.',
              style: CustomStyleManger.normalText.copyWith(
                fontSize: 14,
                color: CustomColorsManager.lightGrayTextColor,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _DialogAction(
                    label: 'إلغاء',
                    backgroundColor: CustomColorsManager.white,
                    textColor: CustomColorsManager.black,
                    borderColor: CustomColorsManager.grayColorForIcons,
                    onTap: () => Get.back(result: false),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DialogAction(
                    label: 'تسجيل الخروج',
                    backgroundColor: CustomColorsManager.appRed,
                    textColor: CustomColorsManager.white,
                    onTap: () => Get.back(result: true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogAction extends StatelessWidget {
  const _DialogAction({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
    this.borderColor,
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: borderColor != null ? Border.all(color: borderColor!) : null,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: CustomText(
              label,
              style: CustomStyleManger.normalText.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }
}
