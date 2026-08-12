import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/widgets/custom_button.dart';
import 'package:remotely/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container/injection_container.dart';
import '../cubits/get_all_tickets/get_all_tickets_cubit.dart';
import 'current_order_details_bottom_sheet.dart';
import 'order_details_info_widget.dart';

// class CurrentOrdersDetails extends StatelessWidget {
//   const CurrentOrdersDetails({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       color: CustomColorsManager.white,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         spacing: 20,
//         children: [
//           OrderDetailsInfoWidget(),
//           CustomButton(
//             text: 'عرض تفاصيل الطلب',
//             textColor: CustomColorsManager.primaryColor,
//             borderColor: CustomColorsManager.primaryColor,
//             backGroundColor: CustomColorsManager.white,
//             fontSize: 15,
//             onPressed: () {
//               // showCurrentOrderDetailsBottomSheet(context);
//             },
//           )
//         ],
//       ),
//     );
//   }
// }

class CurrentOrdersDetails extends StatefulWidget {
  const CurrentOrdersDetails({super.key});

  @override
  State<CurrentOrdersDetails> createState() => _CurrentOrdersDetailsState();
}

class _CurrentOrdersDetailsState extends State<CurrentOrdersDetails> {
  late GetAllTicketsCubit getAllTicketsCubit;
  @override
  initState() {
    super.initState();
    getAllTicketsCubit = sl<GetAllTicketsCubit>();
    getAllTicketsCubit.getAllTickets();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllTicketsCubit, GetAllTicketsState>(
      bloc: getAllTicketsCubit,
      builder: (context, state) {
        if (state is GetAllTicketsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetAllTicketsError) {
          return Center(child: Text(state.message));
        } else if (state is GetAllTicketsLoaded) {
          if (state.currentTickets.isEmpty) {
            return const Center(child: CustomText("لا توجد طلبات حالية"));
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) {
              final ticket = state.currentTickets[0];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  OrderDetailsInfoWidget(ticket: ticket, isCurrent: true),
                  CustomButton(
                    text: 'عرض تفاصيل الطلب',
                    textColor: CustomColorsManager.primaryColor,
                    borderColor: CustomColorsManager.primaryColor,
                    backGroundColor: CustomColorsManager.white,
                    fontSize: 15,
                    onPressed: () {
                      showCurrentOrderDetailsBottomSheet(context, ticket);
                    },
                  ),
                ],
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
