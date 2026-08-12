import 'package:remotely/features/support/data/models/requests/re_open_ticket_request.dart';
import 'package:remotely/features/support/presentation/cubits/close_ticket/close_ticket_cubit.dart';
import 'package:remotely/features/support/presentation/cubits/re_open_ticket/re_open_ticket_cubit.dart';
import 'package:remotely/features/support/presentation/widgets/send_message_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../injection_container/injection_container.dart';
import '../../data/models/responses/get_all_tickets_response.dart';
import '../cubits/get_all_tickets/get_all_tickets_cubit.dart';
import 'order_details_info_widget.dart';
import 'order_details_taps/order_details_taps.dart';

void showCurrentOrderDetailsBottomSheet(BuildContext context, Ticket ticket) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    backgroundColor: Colors.white,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 20.0,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          spacing: 20,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: CustomColorsManager.unSelectedBorderColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            OrderDetailsInfoWidget(ticket: ticket),
            if (ticket.statusId == 2)
              CustomButton(
                text: "إعادة فتح التذكرة",
                textColor: CustomColorsManager.white,
                fontSize: 15,
                onPressed: () {
                  sl<ReOpenTicketCubit>()
                      .reOpenTicket(
                        ReOpenTicketRequest(
                          ticketId: ticket.ticketId!.toInt(),
                          message: 'إعادة فتح التذكرة',
                        ),
                      )
                      .then((value) {
                        Get.back();
                        sl<GetAllTicketsCubit>().getAllTickets();
                      });
                },
              ),
            SizedBox(height: 300, child: OrderDetailsTaps(ticketId: ticket.ticketId.toString())),
            ticket.statusId == 4
                ? Container()
                : Row(
                    spacing: 20,
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: "إغلاق التذكرة",
                          textColor: CustomColorsManager.primaryColor,
                          borderColor: CustomColorsManager.primaryColor,
                          backGroundColor: CustomColorsManager.white,
                          fontSize: 15,
                          onPressed: () {
                            sl<CloseTicketCubit>().closeTicket(ticket.ticketId!.toString());
                            Get.back();
                            sl<GetAllTicketsCubit>().getAllTickets();
                          },
                        ),
                      ),
                      //  if (ticket.statusId == 3)
                      Expanded(
                        child: CustomButton(
                          text: "إرسال رسالة",
                          textColor: CustomColorsManager.white,
                          fontSize: 15,
                          onPressed: () {
                            Get.back();
                            showSendMessageBottomSheet(context, ticket);
                          },
                        ),
                      ),
                    ],
                  ),
            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}
