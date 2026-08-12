import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../injection_container/injection_container.dart';
import '../../data/models/requests/reply_user_ticket_request.dart';
import '../../data/models/responses/get_all_tickets_response.dart';
import '../cubits/reply_user_ticket/reply_user_ticket_cubit.dart';

void showSendMessageBottomSheet(BuildContext context, Ticket ticket) {
  TextEditingController msgController = TextEditingController();
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25.0),
      ),
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
            CustomTextFormField(
              controller: msgController,
              hintText: "اكتب رسالتك هنا",
              maxLines: 6,
            ),
            CustomButton(
              text: "إرسال رسالة",
              textColor: CustomColorsManager.white,
              fontSize: 15,
              onPressed: () {
                sl<ReplyUserTicketCubit>().replyUserTicket(
                    ReplyUserTicketRequest(
                        ticketId: ticket.ticketId!.toInt(),
                        message: msgController.text));
                Get.back();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}
