import 'package:remotely/core/navigation/route_resume_refresh_mixin.dart';
import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/navigation/base_shell_navigation_controller.dart';
import 'package:remotely/features/support/data/models/responses/get_all_tickets_response.dart';
import 'package:remotely/features/support/presentation/cubits/get_all_tickets/get_all_tickets_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/utils/assets_manager/assets_manager.dart';
import '../../../../core/utils/style_manager/style_manager.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../../shared_widgets/app_header_with_avatar.dart';
import '../../../../shared_widgets/ticket_card.dart';

/// Screen to show ticket orders (current + filtered previous)
class TicketOrdersFollow extends StatefulWidget {
  const TicketOrdersFollow({super.key});

  @override
  State<TicketOrdersFollow> createState() => _TicketOrdersFollowState();
}

class _TicketFilterChipData {
  const _TicketFilterChipData({required this.label, this.statusId});

  /// `null` = جميع التذاكر
  final int? statusId;
  final String label;
}

const List<_TicketFilterChipData> _kTicketFilters = [
  _TicketFilterChipData(label: 'جميع التذاكر', statusId: null),
  _TicketFilterChipData(label: 'مفتوحة', statusId: 6),
  _TicketFilterChipData(label: 'جاري المعالجة', statusId: 8),
  _TicketFilterChipData(label: 'مغلقة', statusId: 4),
];

class _TicketOrdersFollowState extends State<TicketOrdersFollow>
    with RouteResumeRefreshMixin {
  final GetAllTicketsCubit getAllTicketsCubit = sl<GetAllTicketsCubit>();
  final TextEditingController _searchController = TextEditingController();

  /// `null` = جميع التذاكر (matches statusId 0 from navigation)
  int? _filterStatusId;

  String _emptyMessage = 'لا توجد طلبات لعرضها';

  void _syncEmptyMessageForFilter() {
    switch (_filterStatusId) {
      case 4:
        _emptyMessage = 'لا توجد طلبات مغلقة';
        break;
      case 6:
        _emptyMessage = 'لا توجد طلبات مفتوحة';
        break;
      case 8:
        _emptyMessage = 'لا توجد طلبات تحت المعالجة';
        break;
      default:
        _emptyMessage = 'لا توجد طلبات لعرضها';
    }
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));

    if (Get.isRegistered<BaseShellNavigationController>()) {
      final fromShell = Get.find<BaseShellNavigationController>().ticketOrdersFilterStatusId.value;
      if (fromShell != null) {
        _filterStatusId = fromShell;
      }
    }
    if (_filterStatusId == null &&
        Get.arguments != null &&
        Get.arguments is List &&
        Get.arguments.isNotEmpty) {
      final arg = Get.arguments[0] as int?;
      if (arg != null && arg != 0) {
        _filterStatusId = arg;
      }
    }
    _syncEmptyMessageForFilter();

    getAllTicketsCubit.getAllTickets();
  }

  @override
  void refreshWhenRouteResumed() {
    getAllTicketsCubit.getAllTickets();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Ticket> _filterByStatus(List<Ticket> all) {
    if (_filterStatusId == null) return all;
    return all.where((t) => t.statusId == _filterStatusId).toList();
  }

  List<Ticket> _filterBySearch(List<Ticket> list) {
    final query = _searchController.text.trim();
    if (query.isEmpty) return list;
    return list.where((ticket) {
      final code = ticket.ticketCode?.toString() ?? '';
      final title = ticket.subject ?? '';
      final qLower = query.toLowerCase();
      return code.contains(query) ||
          title.contains(query) ||
          code.toLowerCase().contains(qLower) ||
          title.toLowerCase().contains(qLower);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorsManager.scaffoldBGColor,
      body: SafeArea(
        child: Column(
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Custom AppBar with dynamic title
            AppHeaderWithAvatar(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextFormField(
                controller: _searchController,
                borderRadius: 24,
                hintText: 'ابحث برقم التذكرة أو عنوانها...',
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CustomImage(imagePath: CustomAssetsManager.searchNormal),
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: CustomColorsManager.lightGrayTextColor),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _kTicketFilters.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final chip = _kTicketFilters[index];
                    final selected = _filterStatusId == chip.statusId;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _filterStatusId = chip.statusId;
                          _syncEmptyMessageForFilter();
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        decoration: BoxDecoration(
                          color: selected
                              ? CustomColorsManager.primaryColor
                              : CustomColorsManager.white,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: selected
                                ? CustomColorsManager.primaryColor
                                : CustomColorsManager.unSelectedBorderColor,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: CustomText(
                            chip.label,
                            style: CustomStyleManger.normalText.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: selected
                                  ? CustomColorsManager.white
                                  : CustomColorsManager.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            /// Show current order details + header only if filter is null
            // if (filterStatusId == null)
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         CurrentOrdersDetails(),
            //         SizedBox(height: 10),
            //         Align(
            //           alignment: Alignment.centerRight,
            //           child: CustomText(
            //             "طلبات التذاكر السابقة",
            //             style: CustomStyleManger.heading1.copyWith(fontSize: 15),
            //           ),
            //         ),
            //         SizedBox(height: 10),
            //       ],
            //     ),
            //   ),

            /// Ticket list takes remaining space
            Expanded(
              child: BlocBuilder<GetAllTicketsCubit, GetAllTicketsState>(
                bloc: getAllTicketsCubit,
                builder: (context, state) {
                  if (state is GetAllTicketsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GetAllTicketsError) {
                    return _TicketsEmptyState(
                      message: 'تعذّر تحميل التذاكر',
                      subtitle: 'تحقق من الاتصال وحاول مرة أخرى',
                    );
                  } else if (state is GetAllTicketsLoaded) {
                    final raw = state.response.result ?? [];
                    final byStatus = _filterByStatus(raw);
                    final tickets = _filterBySearch(byStatus);
                    final hasSearch = _searchController.text.trim().isNotEmpty;

                    if (raw.isEmpty) {
                      return _TicketsEmptyState(
                        message: 'لا توجد تذاكر',
                        subtitle: 'يمكنك رفع تذكرة جديدة من قسم الدعم',
                      );
                    }

                    if (byStatus.isEmpty) {
                      return _TicketsEmptyState(message: _emptyMessage);
                    }

                    if (tickets.isEmpty) {
                      return _TicketsEmptyState(
                        message: hasSearch ? 'لا توجد نتائج تطابق البحث' : _emptyMessage,
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: tickets.length,
                      itemBuilder: (context, index) {
                        final ticket = tickets[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: TicketCard(ticket: ticket),
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TicketsEmptyState extends StatelessWidget {
  const _TicketsEmptyState({required this.message, this.subtitle});

  final String message;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CustomColorsManager.profileBGColor,
                border: Border.all(color: CustomColorsManager.unSelectedBorderColor),
              ),
              padding: const EdgeInsets.all(24),
              child: CustomImage(
                imagePath: CustomAssetsManager.ticket2,
                height: 56,
              ),
            ),
            const SizedBox(height: 16),
            CustomText(
              message,
              textAlign: TextAlign.center,
              style: CustomStyleManger.heading1.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: CustomColorsManager.black,
              ),
            ),
            if (subtitle != null && subtitle!.isNotEmpty) ...[
              const SizedBox(height: 8),
              CustomText(
                subtitle!,
                textAlign: TextAlign.center,
                maxLines: 3,
                style: CustomStyleManger.normalText.copyWith(
                  fontSize: 14,
                  color: CustomColorsManager.lightGrayTextColor,
                  height: 1.4,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Container widget to show ticket status
class StatusContainer extends StatelessWidget {
  const StatusContainer({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColorsManager.grayColor,
        border: Border.all(color: CustomColorsManager.white, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: CustomText(
        title,
        style: CustomStyleManger.normalText.copyWith(
          color: CustomColorsManager.black,
          fontSize: 14,
        ),
      ),
    );
  }
}

/// Mapping of ticket status IDs to Arabic text
const Map<int, String> statusTextMap = {
  1: "مرسلة",
  2: "تمت المعالجة",
  3: "تم الرد",
  4: "مغلقة",
  5: "تم الحذف",
  6: "مفتوحة",
  7: "محولة",
  8: "تحت المعالجة",
  9: "معلَّقة",
  10: "معادة",
  11: "مُصعَّدة",
  12: "تغيير التصنيف",
};

String getStatusText(num? statusId) {
  return statusTextMap[statusId] ?? "غير معروف";
}
