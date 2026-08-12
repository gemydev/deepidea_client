import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/navigation/route_resume_refresh_mixin.dart';
import '../../../../core/utils/assets_manager/assets_manager.dart';
import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/utils/formatter/date_format.dart';
import '../../../../core/utils/style_manager/style_manager.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../../shared_widgets/circle_icon_button.dart';
import '../../../../shared_widgets/ticket_card.dart';
import '../../data/models/requests/re_open_ticket_request.dart';
import '../../data/models/responses/get_all_tickets_response.dart';
import '../../data/models/responses/get_ticket_details_response.dart';
import '../cubits/close_ticket/close_ticket_cubit.dart';
import '../cubits/get_all_tickets/get_all_tickets_cubit.dart';
import '../cubits/get_ticket_details/get_ticket_details_cubit.dart';
import '../cubits/re_open_ticket/re_open_ticket_cubit.dart';
import '../widgets/order_details_taps/actions_timeline.dart';
import '../widgets/order_details_taps/messages_list.dart';
import '../widgets/send_message_bottom_sheet.dart';
import 'orders_follow.dart';
import 'ticket_attachment_viewer_screen.dart';

class TicketDetailsScreen extends StatefulWidget {
  const TicketDetailsScreen({super.key});

  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen>
    with SingleTickerProviderStateMixin, RouteResumeRefreshMixin {
  late TabController _tabController;
  late Ticket ticket;
  late final GetTicketDetailsCubit _detailsCubit;

  @override
  void initState() {
    super.initState();
    ticket = Get.arguments as Ticket;
    _tabController = TabController(length: 2, vsync: this);
    _detailsCubit = sl<GetTicketDetailsCubit>();
    _detailsCubit.getTicketDetails(ticket.ticketId!.toString());
  }

  @override
  void refreshWhenRouteResumed() {
    _detailsCubit.getTicketDetails(ticket.ticketId!.toString());
  }

  @override
  void dispose() {
    _detailsCubit.close();
    _tabController.dispose();
    super.dispose();
  }

  Ticket _ticketFromState(GetTicketDetailsState state) {
    if (state is GetTicketDetailsLoaded) {
      return Ticket.fromTicketDetails(state.response.result);
    }
    return ticket;
  }

  void _closeTicket() {
    final t = _ticketFromState(_detailsCubit.state);
    sl<CloseTicketCubit>().closeTicket(t.ticketId!.toString());
    Get.back();
    sl<GetAllTicketsCubit>().getAllTickets();
  }

  void _reOpenTicket() {
    final t = _ticketFromState(_detailsCubit.state);
    sl<ReOpenTicketCubit>()
        .reOpenTicket(
          ReOpenTicketRequest(ticketId: t.ticketId!.toInt(), message: 'إعادة فتح التذكرة'),
        )
        .then((_) {
          Get.back();
          sl<GetAllTicketsCubit>().getAllTickets();
        });
  }

  void _showSendMessage() {
    showSendMessageBottomSheet(context, _ticketFromState(_detailsCubit.state));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetTicketDetailsCubit, GetTicketDetailsState>(
      bloc: _detailsCubit,
      listenWhen: (prev, curr) => curr is GetTicketDetailsError,
      listener: (context, state) {
        if (state is GetTicketDetailsError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('تعذّر تحميل تفاصيل التذكرة')));
        }
      },
      child: BlocBuilder<GetTicketDetailsCubit, GetTicketDetailsState>(
        bloc: _detailsCubit,
        builder: (context, state) {
          final displayTicket = _ticketFromState(state);
          final statusText = getStatusText(displayTicket.statusId);
          final files = state is GetTicketDetailsLoaded
              ? state.response.result.files
              : <FileItem>[];
          final attachmentsBusy = state is GetTicketDetailsLoading;
          final attachmentsFailed = state is GetTicketDetailsError;

          return Scaffold(
            backgroundColor: CustomColorsManager.scaffoldBGColor,
            body: SafeArea(
              child: Column(
                children: [
                  _buildHeader(statusText, displayTicket),
                  _buildTabBar(),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _TicketDetailsTab(
                          ticket: displayTicket,
                          files: files,
                          attachmentsLoading: attachmentsBusy,
                          attachmentsFailed: attachmentsFailed,
                          onCloseTicket: _closeTicket,
                          onSendMessage: _showSendMessage,
                          onReOpenTicket: displayTicket.statusId == 2 ? _reOpenTicket : null,
                        ),
                        _ConversationTab(ticket: displayTicket, onSendMessage: _showSendMessage),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(String statusText, Ticket ticket) {
    final accent = TicketCard.statusAccentColor(ticket.statusId);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      color: CustomColorsManager.white,
      child: Row(
        children: [
          CircleIconButton(icon: Icons.arrow_back, filled: true, onTap: () => Get.back()),

          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  'رقم التذكرة : ${ticket.ticketCode ?? ''} - RM',
                  style: CustomStyleManger.normalText.copyWith(
                    fontSize: 13,
                    color: CustomColorsManager.lightGrayTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                CustomText(
                  'تفاصيل التذكرة',
                  style: CustomStyleManger.heading1.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: CustomColorsManager.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(15),
            ),
            child: CustomText(
              statusText,
              style: CustomStyleManger.normalText.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: accent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: CustomColorsManager.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: TabBar(
          dividerColor: Colors.transparent,
          controller: _tabController,
          indicator: BoxDecoration(
            color: CustomColorsManager.primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: CustomColorsManager.white,
          unselectedLabelColor: CustomColorsManager.black,
          labelStyle: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 15),
          unselectedLabelStyle: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 15),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          tabs: const [
            Tab(text: 'تفاصيل التذكرة'),
            Tab(text: 'محادثة'),
          ],
        ),
      ),
    );
  }
}

class _ConversationTab extends StatelessWidget {
  const _ConversationTab({required this.ticket, required this.onSendMessage});

  final Ticket ticket;
  final VoidCallback onSendMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: MessagesList(ticketId: ticket.ticketId.toString())),
        _MessageInputBar(onSendMessage: onSendMessage),
      ],
    );
  }
}

class _MessageInputBar extends StatelessWidget {
  const _MessageInputBar({required this.onSendMessage});

  final VoidCallback onSendMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: onSendMessage,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: CustomColorsManager.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: CustomColorsManager.grayColorForIcons),
              ),
              child: Transform.rotate(
                angle: -math.pi,
                child: Icon(Icons.send, color: CustomColorsManager.grayColorForIcons, size: 20),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: onSendMessage,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: CustomColorsManager.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: CustomColorsManager.grayColorForIcons),
                ),
                child: CustomText(
                  'اكتب الرسالة هنا...',
                  style: CustomStyleManger.normalText.copyWith(
                    fontSize: 15,
                    color: CustomColorsManager.lightGrayTextColor,
                  ),
                ),
              ),
            ),
          ),
          // const SizedBox(width: 12),
          // Container(
          //   width: 48,
          //   height: 48,
          //   decoration: BoxDecoration(
          //     color: CustomColorsManager.unSelectedBorderColor,
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: SvgPicture.asset(
          //     CustomAssetsManager.uploadSvg,
          //     width: 24,
          //     height: 24,
          //     fit: BoxFit.scaleDown,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class _TicketDetailsTab extends StatelessWidget {
  const _TicketDetailsTab({
    required this.ticket,
    required this.files,
    required this.attachmentsLoading,
    required this.attachmentsFailed,
    required this.onCloseTicket,
    required this.onSendMessage,
    this.onReOpenTicket,
  });

  final Ticket ticket;
  final List<FileItem> files;
  final bool attachmentsLoading;
  final bool attachmentsFailed;
  final VoidCallback onCloseTicket;
  final VoidCallback onSendMessage;
  final VoidCallback? onReOpenTicket;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TicketInfoCard(ticket: ticket),
          const SizedBox(height: 24),
          _AttachmentsSection(
            files: files,
            loading: attachmentsLoading,
            loadFailed: attachmentsFailed,
          ),
          const SizedBox(height: 24),
          _UpdatesLogSection(ticketId: ticket.ticketId.toString()),
          const SizedBox(height: 24),
          if (onReOpenTicket != null)
            CustomButton(
              text: 'إعادة فتح التذكرة',
              textColor: CustomColorsManager.white,
              fontSize: 15,
              onPressed: onReOpenTicket,
            )
          else if (ticket.statusId != 4)
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'إغلاق التذكرة',
                    textColor: CustomColorsManager.white,
                    borderColor: CustomColorsManager.appRed,
                    backGroundColor: CustomColorsManager.appRed,
                    fontSize: 15,
                    onPressed: onCloseTicket,
                  ),
                ),
                // const SizedBox(width: 12),
                // Expanded(
                //   child: CustomButton(
                //     text: 'إرسال رسالة',
                //     textColor: CustomColorsManager.white,
                //     fontSize: 15,
                //     onPressed: onSendMessage,
                //   ),
                // ),
              ],
            ),
        ],
      ),
    );
  }
}

class _TicketInfoCard extends StatelessWidget {
  const _TicketInfoCard({required this.ticket});

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    final accent = TicketCard.statusAccentColor(ticket.statusId);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CustomColorsManager.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              CustomText(
                'تذكرة ${getStatusText(ticket.statusId).toLowerCase()}',
                style: CustomStyleManger.normalText.copyWith(fontSize: 14, color: accent),
              ),
            ],
          ),
          const SizedBox(height: 12),
          CustomText(
            ticket.subject ?? '',
            style: CustomStyleManger.heading1.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: CustomColorsManager.black,
            ),
          ),
          const SizedBox(height: 8),
          CustomText(
            ticket.msg ?? '',
            style: CustomStyleManger.normalText.copyWith(
              fontSize: 14,
              color: CustomColorsManager.lightGrayTextColor,
              height: 1.5,
            ),
          ),
          Divider(color: CustomColorsManager.grayColorForIcons, endIndent: 10, indent: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomText(
                  TicketCard.statusFooterMessage(ticket),
                  style: CustomStyleManger.normalText.copyWith(
                    fontSize: 13,
                    color: CustomColorsManager.grayTextColor,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Row(
                  children: [
                    SvgPicture.asset(CustomAssetsManager.clock, width: 18, height: 18),
                    const SizedBox(width: 8),
                    CustomText(
                      formatArabicDate(ticket.startDate ?? ''),
                      style: CustomStyleManger.normalText.copyWith(
                        fontSize: 13,
                        color: CustomColorsManager.lightGrayTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AttachmentsSection extends StatelessWidget {
  const _AttachmentsSection({required this.files, required this.loading, required this.loadFailed});

  final List<FileItem> files;
  final bool loading;
  final bool loadFailed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          'المرفقات',
          style: CustomStyleManger.heading1.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: CustomColorsManager.black,
          ),
        ),
        const SizedBox(height: 12),
        if (loading && files.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: CircularProgressIndicator()),
          )
        else if (loadFailed && files.isEmpty)
          CustomText(
            'تعذّر تحميل المرفقات',
            style: CustomStyleManger.normalText.copyWith(
              fontSize: 14,
              color: CustomColorsManager.red,
            ),
          )
        else if (files.isEmpty)
          CustomText(
            'لا توجد مرفقات',
            style: CustomStyleManger.normalText.copyWith(
              fontSize: 14,
              color: CustomColorsManager.lightGrayTextColor,
            ),
          )
        else
          SizedBox(
            height: 88,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: files.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final file = files[index];
                final name = suggestedAttachmentFileName(file.fileUrl, file.docId);
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: file.fileUrl.isEmpty
                        ? null
                        : () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => TicketAttachmentViewerScreen(
                                  url: file.fileUrl,
                                  suggestedFileName: name,
                                ),
                              ),
                            );
                          },
                    borderRadius: BorderRadius.circular(12),
                    child: Ink(
                      width: 120,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: CustomColorsManager.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: CustomColorsManager.grayColorForIcons),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.attach_file,
                            color: CustomColorsManager.primaryColor,
                            size: 28,
                          ),
                          const SizedBox(height: 6),
                          CustomText(
                            name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: CustomStyleManger.normalText.copyWith(
                              fontSize: 12,
                              color: CustomColorsManager.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _UpdatesLogSection extends StatelessWidget {
  const _UpdatesLogSection({required this.ticketId});

  final String ticketId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CustomColorsManager.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(color: CustomColorsManager.black, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              CustomText(
                'سجل التحديثات',
                style: CustomStyleManger.heading1.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: CustomColorsManager.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ActionsTimeline(ticketId: ticketId),
        ],
      ),
    );
  }
}
