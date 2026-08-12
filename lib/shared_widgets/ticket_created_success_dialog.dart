import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/utils/color_manager/color_manager.dart';
import '../core/utils/routes_manager/routes_manager.dart';
import '../core/utils/style_manager/style_manager.dart';
import '../core/widgets/custom_text.dart';

/// Success dialog shown when a ticket is created successfully.
/// Matches the design: green check icon, title, description, and "Return to Home" button.
void showTicketCreatedSuccessDialog() {
  Get.dialog(
    TicketCreatedSuccessDialog(),
    barrierDismissible: false,
  );
}

class TicketCreatedSuccessDialog extends StatelessWidget {
  static const Color _successGreen = Color(0xFF66BB6A);

  const TicketCreatedSuccessDialog({super.key});

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
                color: _successGreen,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            CustomText(
              'تم انشاء التذكرة بنجاح',
              style: CustomStyleManger.heading1.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: CustomColorsManager.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            CustomText(
              'سيتم مراجعة التذكرة والرد عليك في أقرب وقت ممكن عبر الإشعارات داخل المنصة',
              style: CustomStyleManger.normalText.copyWith(
                fontSize: 14,
                color: CustomColorsManager.lightGrayTextColor,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: Material(
                color: _successGreen,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  onTap: () {
                    Get.back();
                    Get.offAllNamed(Routes.baseOfApp);
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: CustomText(
                      'العودة للرئيسية',
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
          ],
        ),
      ),
    );
  }
}
