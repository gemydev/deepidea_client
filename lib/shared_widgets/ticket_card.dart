import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/utils/assets_manager/assets_manager.dart';
import '../core/utils/color_manager/color_manager.dart';
import '../core/utils/formatter/date_format.dart';
import '../core/utils/style_manager/style_manager.dart';
import '../core/widgets/custom_text.dart';
import '../core/utils/routes_manager/routes_manager.dart';
import 'package:get/get.dart';

import '../features/support/data/models/responses/get_all_tickets_response.dart';
import '../features/support/presentation/screens/orders_follow.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({super.key, required this.ticket});

  final Ticket ticket;

  /// سطر توضيحي أسفل البطاقة حسب حالة التذكرة
  static String statusFooterMessage(Ticket ticket) {
    switch (ticket.statusId?.toInt()) {
      case 1:
        return 'تم إرسال التذكرة';
      case 2:
        return 'تمت معالجة طلبك';
      case 3:
        return 'تم الرد على تذكرتك';
      case 4:
        return 'التذكرة مغلقة';
      case 5:
        return 'تم حذف التذكرة';
      case 6:
        return 'خدمة العملاء في انتظار ردك';
      case 7:
        return 'تم تحويل التذكرة';
      case 8:
        return 'جاري معالجة تذكرتك';
      case 9:
        return 'التذكرة معلّقة';
      case 10:
        return 'تمت إعادة فتح التذكرة';
      case 11:
        return 'تم تصعيد التذكرة';
      case 12:
        return 'تم تحديث تصنيف التذكرة';
      default:
        final name = ticket.statusName?.trim();
        return name != null && name.isNotEmpty ? name : 'متابعة التذكرة';
    }
  }

  /// مغلقة → green، مفتوحة → orange، تحت المعالجة → blue؛ غير ذلك → red
  static Color statusAccentColor(num? statusId) {
    switch (statusId?.toInt()) {
      case 4:
        return CustomColorsManager.green;
      case 6:
        return CustomColorsManager.orangeColor;
      case 8:
        return CustomColorsManager.blueColor;
      default:
        return CustomColorsManager.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final accent = statusAccentColor(ticket.statusId);
    return GestureDetector(
      onTap: () {
        // showCurrentOrderDetailsBottomSheet(context, ticket);
        Get.toNamed(Routes.ticketDetails, arguments: ticket);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border(
            right: BorderSide(color: accent, width: 7),
            bottom: BorderSide(color: accent, width: 0.6),
            left: BorderSide(color: accent, width: 0.6),
            top: BorderSide(color: accent, width: 0.6),
          ),
        ),
        child: Column(
          spacing: 10,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 10),
                      CustomText(
                        ticket.statusName ?? '',
                        style: CustomStyleManger.normalText.copyWith(color: accent, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                StatusContainer(title: "#${ticket.ticketCode.toString()}"),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                    ticket.subject ?? '',
                    maxLines: 2,
                    style: CustomStyleManger.heading1.copyWith(
                      fontSize: 16,
                      color: CustomColorsManager.black,
                    ),
                  ),
                  CustomText(
                    ticket.msg ?? '',
                    maxLines: 4,
                    style: CustomStyleManger.normalText.copyWith(
                      fontSize: 13,
                      color: CustomColorsManager.lightGrayTextColor,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomText(
                    statusFooterMessage(ticket),
                    style: CustomStyleManger.normalText.copyWith(
                      color: CustomColorsManager.grayTextColor,
                      fontSize: 11,
                    ),
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(CustomAssetsManager.clock),
                    const SizedBox(width: 10),
                    CustomText(
                      formatArabicDate(ticket.startDate ?? ''),
                      style: CustomStyleManger.normalText.copyWith(
                        color: CustomColorsManager.black,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
