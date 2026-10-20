import 'package:remotely/core/helpers/subscription_guard.dart';
import 'package:flutter/material.dart';

import '../../../../core/helpers/snakbar_manager.dart';
import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../injection_container/injection_container.dart';
import '../../data/models/requests/reply_user_ticket_request.dart';
import '../../data/models/responses/get_all_tickets_response.dart';
import '../cubits/reply_user_ticket/reply_user_ticket_cubit.dart';

/// Returns true when the message was sent successfully.
Future<bool?> showSendMessageBottomSheet(BuildContext context, Ticket ticket) {
  return showModalBottomSheet<bool>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25.0),
      ),
    ),
    backgroundColor: Colors.white,
    isScrollControlled: true,
    isDismissible: true,
    builder: (BuildContext context) => _SendMessageSheet(ticket: ticket),
  );
}

class _SendMessageSheet extends StatefulWidget {
  const _SendMessageSheet({required this.ticket});

  final Ticket ticket;

  @override
  State<_SendMessageSheet> createState() => _SendMessageSheetState();
}

class _SendMessageSheetState extends State<_SendMessageSheet> {
  final TextEditingController msgController = TextEditingController();
  final ReplyUserTicketCubit _replyCubit = sl<ReplyUserTicketCubit>();
  bool _sending = false;

  @override
  void dispose() {
    msgController.dispose();
    _replyCubit.close();
    super.dispose();
  }

  Future<void> _send() async {
    if (_sending) return;

    final text = msgController.text.trim();
    if (text.isEmpty) {
      AppSnackBar.warning('من فضلك اكتب رسالتك أولاً');
      return;
    }

    if (!await ensureActiveSubscription()) return;
    if (!mounted) return;

    setState(() => _sending = true);

    await _replyCubit.replyUserTicket(
      ReplyUserTicketRequest(ticketId: widget.ticket.ticketId!.toInt(), message: text),
    );

    if (!mounted) return;
    final sent = _replyCubit.state is ReplyUserTicketLoaded;
    setState(() => _sending = false);

    if (sent) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
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
            enabled: !_sending,
          ),
          _sending
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: CircularProgressIndicator(),
                  ),
                )
              : CustomButton(
                  text: "إرسال رسالة",
                  textColor: CustomColorsManager.white,
                  fontSize: 15,
                  onPressed: _send,
                ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
