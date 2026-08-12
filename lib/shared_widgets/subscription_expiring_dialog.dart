import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/helpers/subscription_expiry_reminder.dart';
import '../core/helpers/whatsapp_launcher.dart';
import '../core/utils/color_manager/color_manager.dart';
import '../core/utils/formatter/date_format.dart';
import '../core/utils/style_manager/style_manager.dart';
import '../core/widgets/custom_text.dart';

void showSubscriptionExpiringDialog({
  required int remainingDays,
  String? endDateLabel,
}) {
  if (Get.isDialogOpen == true) return;

  Get.dialog(
    SubscriptionExpiringDialog(
      remainingDays: remainingDays,
      endDateLabel: endDateLabel,
    ),
    barrierDismissible: true,
  );
}

class SubscriptionExpiringDialog extends StatelessWidget {
  static const Color _accentOrange = Color(0xFFFF9800);

  const SubscriptionExpiringDialog({
    super.key,
    required this.remainingDays,
    this.endDateLabel,
  });

  final int remainingDays;
  final String? endDateLabel;

  Future<void> _renewViaWhatsApp() async {
    Get.back();
    final message = 'مرحباً، أود تجديد اشتراكي قبل انتهائه.';
    await openSupportWhatsApp(prefilledMessage: message);
  }

  @override
  Widget build(BuildContext context) {
    final formattedEnd = formatArabicDate(endDateLabel);
    final body = subscriptionRemainingDaysMessage(remainingDays);

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
              decoration: const BoxDecoration(
                color: _accentOrange,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 20),
            CustomText(
              'تنبيه انتهاء الاشتراك',
              style: CustomStyleManger.heading1.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: CustomColorsManager.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            CustomText(
              body,
              style: CustomStyleManger.normalText.copyWith(
                fontSize: 14,
                color: CustomColorsManager.lightGrayTextColor,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
              maxLines: 4,
            ),
            if (formattedEnd.isNotEmpty) ...[
              const SizedBox(height: 8),
              CustomText(
                'تاريخ الانتهاء: $formattedEnd',
                style: CustomStyleManger.normalText.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: CustomColorsManager.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: Material(
                color: CustomColorsManager.primaryColor,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  onTap: _renewViaWhatsApp,
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: CustomText(
                      'تجديد عبر واتساب',
                      style: CustomStyleManger.normalText.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: CustomColorsManager.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Get.back(),
              child: CustomText(
                'حسناً',
                style: CustomStyleManger.normalText.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: CustomColorsManager.lightGrayTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
