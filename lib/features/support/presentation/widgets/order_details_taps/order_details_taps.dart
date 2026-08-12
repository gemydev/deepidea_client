import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:flutter/material.dart';

import 'actions_timeline.dart';
import 'messages_list.dart';

class OrderDetailsTaps extends StatelessWidget {
  const OrderDetailsTaps({super.key, required this.ticketId});

  final String ticketId;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: TabBar(
              labelColor: Colors.teal,
              unselectedLabelColor: CustomColorsManager.lightGrayTextColor,
              indicatorColor: CustomColorsManager.primaryColor,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(text: "سجل الإجراءات"),
                Tab(text: "الرسائل"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                ActionsTimeline(ticketId: ticketId),
                MessagesList(ticketId: ticketId),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
