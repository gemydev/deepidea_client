import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/navigation/base_shell_navigation_controller.dart';
import '../../../../core/utils/assets_manager/assets_manager.dart';
import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/utils/routes_manager/routes_manager.dart';
import '../../../../core/utils/style_manager/style_manager.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../support/presentation/cubits/get_all_tickets/get_all_tickets_cubit.dart';

void _openTicketsInShellWithFilter(BuildContext context, int statusId) {
  if (Get.isRegistered<BaseShellNavigationController>()) {
    Get.find<BaseShellNavigationController>().goToTicketsWithStatusFilter(statusId);
    if (Navigator.of(context).canPop()) {
      Get.until((route) => route.settings.name == Routes.baseOfApp);
    }
  } else {
    Get.toNamed(Routes.ticketOrdersFollow, arguments: [statusId]);
  }
}

class LegalInfoScreen extends StatelessWidget {
  const LegalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllTicketsCubit, GetAllTicketsState>(
      builder: (context, state) {
        int totalCount = 0;
        int closedCount = 0;
        int openCount = 0;
        int underProgressCount = 0;

        final bool loaded = state is GetAllTicketsLoaded;
        if (loaded) {
          totalCount = state.response.result?.length ?? 0;
          closedCount = state.closedTickets.length;
          openCount = state.currentTickets.length;
          underProgressCount = state.underProgressTickets.length;
        }

        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText('ملخص التذاكر', style: CustomStyleManger.heading1.copyWith(fontSize: 18)),
              const SizedBox(height: 17),
              state is GetAllTicketsLoading
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : loaded && totalCount == 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: CustomText(
                        'لا توجد تذاكر حتى الآن',
                        style: CustomStyleManger.normalText.copyWith(
                          fontSize: 15,
                          color: CustomColorsManager.lightGrayTextColor,
                        ),
                      ),
                    )
                  : Row(
                      children: [
                        // Expanded(
                        //   child: InfoCard(
                        //     label: 'اجمالي التذاكر',
                        //     count: '$totalCount',
                        //     cardColor: CustomColorsManager.black,
                        //     onTap: () {
                        //       Get.toNamed(Routes.ticketOrdersFollow, arguments: [0]);
                        //     },
                        //   ),
                        // ),
                        // const SizedBox(width: 8),
                        Expanded(
                          child: InfoCard(
                            iconPath: CustomAssetsManager.openTicket,
                            label: 'تذاكر مفتوحة',
                            count: '$openCount',
                            cardColor: CustomColorsManager.orangeColor,
                            onTap: () => _openTicketsInShellWithFilter(context, 6),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: InfoCard(
                            iconPath: CustomAssetsManager.refreshSquare,
                            label: 'تذاكر تحت المعالجه',
                            count: '$underProgressCount',
                            cardColor: CustomColorsManager.blueColor,
                            onTap: () => _openTicketsInShellWithFilter(context, 8),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: InfoCard(
                            iconPath: CustomAssetsManager.trueCircle,
                            label: 'تذاكر مغلقه',
                            count: '$closedCount',
                            cardColor: CustomColorsManager.green,
                            onTap: () => _openTicketsInShellWithFilter(context, 4),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }
}

class InfoCard extends StatelessWidget {
  final String? iconPath;
  final String label;
  final String count;
  final Color cardColor;
  final GestureTapCallback? onTap;

  const InfoCard({
    super.key,
    this.iconPath,
    required this.label,
    required this.count,
    required this.cardColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        decoration: BoxDecoration(
          color: cardColor.withValues(alpha: 0.20),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cardColor, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon area: fixed height so all cards align
            SizedBox(
              height: 36,
              child: iconPath != null
                  ? Center(
                      child: SvgPicture.asset(
                        iconPath!,
                        width: 28,
                        height: 28,
                        colorFilter: ColorFilter.mode(cardColor, BlendMode.srcIn),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(height: 10),
            CustomText(
              count,
              style: CustomStyleManger.heading1.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: cardColor,
              ),
            ),
            const SizedBox(height: 6),
            CustomText(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: CustomStyleManger.normalText.copyWith(fontSize: 13, color: cardColor),
            ),
          ],
        ),
      ),
    );
  }
}
