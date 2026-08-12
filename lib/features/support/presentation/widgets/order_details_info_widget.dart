import 'package:flutter/material.dart';

import '../../../../core/utils/formatter/date_format.dart';
import '../../data/models/responses/get_all_tickets_response.dart';
import '../screens/orders_follow.dart';
import 'order_details_header.dart';
import 'order_details_item.dart';

class OrderDetailsInfoWidget extends StatelessWidget {
  const OrderDetailsInfoWidget({
    super.key,
    required this.ticket,
    this.isCurrent = false,
  });

  final Ticket ticket;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        OrderDetailsHeader(
          status: getStatusText(ticket.statusId),
          isCurrent: isCurrent,
        ),

        // CustomProgressWidget(),
        // SizedBox(
        //   height: 15,
        // ),

        Column(
          spacing: 15,
          children: [
            OrderDetailsItem(
              title: 'تاريخ إنشاء الطلب',
              data: formatArabicDate(ticket.startDate ?? ''),
            ),
            OrderDetailsItem(
              title: 'كود الطلب',
              data: ticket.ticketCode ?? '',
            ),
            OrderDetailsItem(
              title: 'الموضوع',
              data: ticket.subject ?? '',
            ),
          ],
        ),
      ],
    );
  }
}
