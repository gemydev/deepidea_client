import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/formatter/date_format.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../injection_container/injection_container.dart';
import '../../../data/models/responses/get_ticket_conversation_response.dart';
import '../../cubits/get_ticket_conversation/get_ticket_conversation_cubit.dart';

/// Warm beige / brown accents (timeline in design reference).
class _TimelinePalette {
  static const Color circleFill = Color(0xFFF5EBE0);
  static const Color line = Color(0xFFC4A882);
  static const Color iconAndBorder = Color(0xFF8B6F52);
}

String _arabicRelativeTime(DateTime? date) {
  if (date == null) return '—';
  final now = DateTime.now();
  var diff = now.difference(date);
  if (diff.isNegative) {
    return formatArabicDate(date.toIso8601String());
  }
  final minutes = diff.inMinutes;
  if (minutes < 1) return 'الآن';
  if (minutes < 60) return 'منذ $minutes دقيقة';
  final hours = diff.inHours;
  if (hours < 24) {
    if (hours == 1) return 'منذ ساعة';
    if (hours == 2) return 'منذ ساعتين';
    return 'منذ $hours ساعات';
  }
  final days = diff.inDays;
  if (days == 1) return 'منذ يوم';
  if (days == 2) return 'منذ يومين';
  if (days < 7) return 'منذ $days أيام';
  if (days < 30) return 'منذ ${days ~/ 7} أسابيع';
  return formatArabicDate(date.toIso8601String());
}

IconData _timelineIconForStatus(String status) {
  final t = status.toLowerCase();
  if (t.contains('إنشاء') ||
      t.contains('انشاء') ||
      t.contains('إنشئ') ||
      t.contains('success') ||
      t.contains('جديد')) {
    return Icons.description_outlined;
  }
  if (t.contains('رد') || t.contains('دعم') || t.contains('رسالة') || t.contains('support')) {
    return Icons.reply_rounded;
  }
  if (t.contains('حالة') ||
      t.contains('تغيير') ||
      t.contains('معالج') ||
      t.contains('مفتوح') ||
      t.contains('مغلق')) {
    return Icons.confirmation_number_outlined;
  }
  return Icons.circle_notifications_outlined;
}

class ActionsTimeline extends StatefulWidget {
  const ActionsTimeline({super.key, required this.ticketId});

  final String ticketId;

  @override
  State<ActionsTimeline> createState() => _ActionsTimelineState();
}

class _ActionsTimelineState extends State<ActionsTimeline> {
  late final GetTicketConversationCubit _conversationCubit;

  @override
  void initState() {
    super.initState();
    _conversationCubit = sl<GetTicketConversationCubit>();
    _conversationCubit.getTicketConversation(widget.ticketId);
  }

  @override
  void dispose() {
    _conversationCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTicketConversationCubit, GetTicketConversationState>(
      bloc: _conversationCubit,
      builder: (context, state) {
        if (state is GetTicketConversationLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetTicketConversationError) {
          return Center(
            child: CustomText(
              state.message,
              style: CustomStyleManger.heading1.copyWith(fontSize: 14, color: Colors.red),
            ),
          );
        }
        if (state is! GetTicketConversationLoaded) {
          return const SizedBox.shrink();
        }

        final List<Conversation>? conversations = state.response.conversation;
        final List<TicketStatusEntry>? statusHistory = state.response.statusHistory;

        if ((statusHistory == null || statusHistory.isEmpty) &&
            (conversations == null || conversations.isEmpty)) {
          return Center(
            child: CustomText(
              'لا توجد إجراءات بعد',
              style: CustomStyleManger.heading1.copyWith(
                fontSize: 14,
                color: CustomColorsManager.lightGrayTextColor,
              ),
            ),
          );
        }

        final List<Map<String, dynamic>> timelineItems = [];

        if (statusHistory != null && statusHistory.isNotEmpty) {
          for (final entry in statusHistory) {
            final traceTitle = entry.traceTitle?.trim() ?? '';
            final title = traceTitle.isNotEmpty ? traceTitle : (entry.statusName ?? '');
            Conversation? relatedConversation;
            if (conversations != null && entry.createdDate != null) {
              for (final conv in conversations) {
                if (conv.createdDate == null) continue;
                final delta = conv.createdDate!.difference(entry.createdDate!).inMinutes.abs();
                if (delta <= 2) {
                  relatedConversation = conv;
                  break;
                }
              }
            }

            timelineItems.add({
              'status': title,
              'date': entry.createdDate,
              'formatted': entry.createdDate != null
                  ? formatArabicDateTime(entry.createdDate!.toIso8601String())
                  : entry.createdDateFormatted,
              'msg': entry.message ?? relatedConversation?.msg ?? relatedConversation?.briefMsg,
            });
          }
        } else if (conversations != null) {
          for (final conv in conversations) {
            timelineItems.add({
              'status': conv.statusName ?? '',
              'date': conv.createdDate,
              'msg': conv.msg ?? conv.briefMsg,
            });
          }
        }

        // Newest first (matches design: أحدث التحديثات في الأعلى)
        final items = timelineItems.reversed.toList();

        final timelineChildren = <Widget>[];
        for (var i = 0; i < items.length; i++) {
          if (i > 0) timelineChildren.add(const SizedBox(height: 20));
          final item = items[i];
          final status = item['status']?.toString() ?? '';
          final date = item['date'] as DateTime?;
          final subtitleRaw = item['msg']?.toString();
          final subtitle = subtitleRaw != null && subtitleRaw.trim().isNotEmpty
              ? subtitleRaw.trim()
              : null;

          timelineChildren.add(
            _TimelineRow(
              title: status.isNotEmpty ? status : 'تحديث',
              subtitle: subtitle,
              relativeTime: _arabicRelativeTime(date),
              formattedDate: item['formatted']?.toString(),
              icon: _timelineIconForStatus(status),
            ),
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: timelineChildren,
        );
      },
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({
    required this.title,
    required this.subtitle,
    required this.relativeTime,
    required this.icon,
    this.formattedDate,
  });

  final String title;
  final String? subtitle;
  final String relativeTime;
  final String? formattedDate;
  final IconData icon;

  static const double _stripWidth = 48;
  static const double _circleSize = 40;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: _stripWidth,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: (_stripWidth - 2) / 2,
                  top: 0,
                  bottom: 0,
                  child: Container(width: 2, color: _TimelinePalette.line),
                ),
                Container(
                  width: _circleSize,
                  height: _circleSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _TimelinePalette.circleFill,
                    border: Border.all(color: _TimelinePalette.iconAndBorder, width: 1.5),
                  ),
                  alignment: Alignment.center,
                  child: Icon(icon, size: 20, color: _TimelinePalette.iconAndBorder),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 10, end: 6, top: 6, bottom: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: CustomStyleManger.heading1.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: CustomColorsManager.black,
                      height: 1.25,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    CustomText(
                      subtitle!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: CustomStyleManger.normalText.copyWith(
                        fontSize: 12,
                        color: CustomColorsManager.lightGrayTextColor,
                        height: 1.3,
                      ),
                    ),
                  ],
                  if (formattedDate != null && formattedDate!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    CustomText(
                      formattedDate!,
                      style: CustomStyleManger.normalText.copyWith(
                        fontSize: 11,
                        color: CustomColorsManager.grayTextColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 72, maxWidth: 100),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 4, top: 6),
              child: CustomText(
                relativeTime,
                textAlign: TextAlign.end,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: CustomStyleManger.normalText.copyWith(
                  fontSize: 11,
                  color: CustomColorsManager.grayTextColor,
                  height: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
