import 'package:remotely/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/color_manager/color_manager.dart';
import '../../../../../core/utils/style_manager/style_manager.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../data/models/responses/get_all_services_by_web_id_response.dart';

void showExternalServiceDetailsBottomSheet(BuildContext context, ServiceItem service) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: Colors.white,
    isScrollControlled: true,
    builder: (_) {
      final s = service.service;
      final price = service.subProductPrices?.firstOrNull;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    'تفاصيل الخدمة',
                    style: CustomStyleManger.heading1.copyWith(fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close_rounded, size: 26),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // صورة الخدمة
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 2.5,
                    child: CustomImage(
                      imagePath: (service.images?.isNotEmpty ?? false)
                          ? service.images!.first.toString()
                          : '', //
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // الاسم
              CustomText(
                s?.pkgName ?? s?.productName ?? 'اسم غير متاح',
                style: CustomStyleManger.heading1.copyWith(fontSize: 15),
              ),
              const SizedBox(height: 15),

              // الوصف
              if (s?.details?.isNotEmpty ?? false)
                CustomText(
                  s!.details!,
                  style: CustomStyleManger.normalText.copyWith(
                    color: CustomColorsManager.lightTextColor,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.start,
                  maxLines: 5,
                ),

              _buildDivider(),

              // تفاصيل الخدمة العامة
              _buildDetailRow("الكمية المتاحة", s?.measureCount?.toString() ?? "-"),
              _buildDetailRow("نوع الوحدة", s?.measureName ?? "-"),
              _buildDetailRow("هل متاحة للبيع", s?.isSale == true ? "نعم" : "لا"),
              _buildDetailRow("تظهر في المتجر", s?.isShowInStore == true ? "نعم" : "لا"),

              _buildDivider(),

              // تفاصيل السعر
              if (price != null) ...[
                CustomText(
                  "تفاصيل السعر",
                  style: CustomStyleManger.heading1.copyWith(fontSize: 17),
                ),
                const SizedBox(height: 8),
                _buildDetailRow("السعر", "${price.price ?? 0} ر.س"),
                if (price.details?.isNotEmpty ?? false)
                  _buildDetailRow("الوصف السعري", price.details),
              ],
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildDetailRow(String title, String? value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: CustomText(
            title,
            textAlign: TextAlign.start,
            style: CustomStyleManger.normalText.copyWith(
              fontSize: 16,
              color: CustomColorsManager.mainTextColor.withValues(alpha: 0.8),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: CustomText(
            value ?? '-',
            textAlign: TextAlign.end,
            style: CustomStyleManger.normalText.copyWith(fontSize: 16),
          ),
        ),
      ],
    ),
  );
}

Divider _buildDivider() {
  return Divider(
    color: CustomColorsManager.lightTextColor.withValues(alpha: 0.2),
    thickness: 1,
    height: 25,
  );
}
