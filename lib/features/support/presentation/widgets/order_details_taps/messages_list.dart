import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/formatter/date_format.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../injection_container/injection_container.dart';
import '../../../data/models/responses/get_ticket_conversation_response.dart';
import '../../cubits/get_ticket_conversation/get_ticket_conversation_cubit.dart';
import '../../screens/ticket_attachment_viewer_screen.dart';

class MessagesList extends StatefulWidget {
  const MessagesList({super.key, required this.ticketId, this.cubit});

  final String ticketId;

  /// Passed in when the screen also needs to send messages through the same
  /// cubit; otherwise the list owns its own instance.
  final GetTicketConversationCubit? cubit;

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  late GetTicketConversationCubit getTicketConversationCubit;
  late final bool _ownsCubit;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _ownsCubit = widget.cubit == null;
    getTicketConversationCubit = widget.cubit ?? sl<GetTicketConversationCubit>();
    if (_ownsCubit) {
      getTicketConversationCubit.getTicketConversation(widget.ticketId);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    if (_ownsCubit) {
      getTicketConversationCubit.close();
    }
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetTicketConversationCubit, GetTicketConversationState>(
      bloc: getTicketConversationCubit,
      listenWhen: (prev, curr) => curr is GetTicketConversationLoaded,
      listener: (context, state) => _scrollToBottom(),
      builder: (context, state) {
        if (state is GetTicketConversationLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetTicketConversationError) {
          return Center(
            child: CustomText(
              state.message,
              style: CustomStyleManger.heading1.copyWith(fontSize: 14, color: Colors.red),
            ),
          );
        } else if (state is GetTicketConversationLoaded) {
          final List<Conversation> conversations = state.response.conversation ?? const [];
          final pending = state.pendingMessages;

          if (conversations.isEmpty && pending.isEmpty) {
            return Center(
              child: CustomText(
                "لا توجد محادثات بعد",
                style: CustomStyleManger.heading1.copyWith(
                  fontSize: 14,
                  color: CustomColorsManager.lightGrayTextColor,
                ),
              ),
            );
          }

          return ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: conversations.length + pending.length,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              if (index >= conversations.length) {
                final message = pending[index - conversations.length];
                return _PendingMessageBubble(
                  message: message,
                  onRetry: () => getTicketConversationCubit.retryPendingMessage(
                    ticketId: widget.ticketId,
                    localId: message.localId,
                  ),
                  onDiscard: () =>
                      getTicketConversationCubit.discardPendingMessage(message.localId),
                );
              }

              final item = conversations[index];

              final bool isClientMessage = item.isClientToEmp == true;
              final senderLabel = item.userFrom?.trim().isNotEmpty == true
                  ? item.userFrom!
                  : (isClientMessage ? 'أنت' : 'الدعم الفني');

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: isClientMessage
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: [
                  if (isClientMessage) const SizedBox(width: 10),

                  /// Bubble Container
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: isClientMessage ? Colors.blue.shade50 : Colors.green.shade50,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(16),
                          topRight: const Radius.circular(16),
                          bottomLeft: Radius.circular(isClientMessage ? 0 : 16),
                          bottomRight: Radius.circular(isClientMessage ? 16 : 0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: isClientMessage
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        children: [
                          CustomText(
                            senderLabel,
                            style: CustomStyleManger.heading1.copyWith(
                              fontSize: 14,
                              color: CustomColorsManager.nameColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          CustomText(
                            item.msg ?? '',
                            maxLines: 100,
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
                          ),
                          if (item.filesList.isNotEmpty) ...[
                            const SizedBox(height: 10),
                            _ConversationAttachments(files: item.filesList),
                          ],
                          const SizedBox(height: 6),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                formatArabicDateTime(item.createdDate?.toString() ?? ''),
                                style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                              ),
                              if (isClientMessage) ...[
                                const SizedBox(width: 4),
                                Icon(Icons.done_all, size: 13, color: Colors.grey.shade600),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  if (!isClientMessage) const SizedBox(width: 10),
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

/// Bubble for a message that is still being sent, was just sent, or failed.
class _PendingMessageBubble extends StatelessWidget {
  const _PendingMessageBubble({
    required this.message,
    required this.onRetry,
    required this.onDiscard,
  });

  final PendingMessage message;
  final VoidCallback onRetry;
  final VoidCallback onDiscard;

  @override
  Widget build(BuildContext context) {
    final failed = message.status == PendingMessageStatus.failed;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: 10),
        Flexible(
          child: Opacity(
            opacity: message.status == PendingMessageStatus.sending ? 0.6 : 1,
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: failed ? Colors.red.shade50 : Colors.blue.shade50,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                border: failed ? Border.all(color: CustomColorsManager.appRed) : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    'أنت',
                    style: CustomStyleManger.heading1.copyWith(
                      fontSize: 14,
                      color: CustomColorsManager.nameColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (message.message.isNotEmpty)
                    CustomText(
                      message.message,
                      maxLines: 100,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
                    ),
                  for (final file in message.attachments)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.attach_file, size: 16, color: CustomColorsManager.primaryColor),
                          const SizedBox(width: 4),
                          Flexible(
                            child: CustomText(
                              file.path.split(RegExp(r'[/\\]')).last,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        formatArabicDateTime(message.createdAt.toIso8601String()),
                        style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                      ),
                      const SizedBox(width: 6),
                      _StatusIndicator(status: message.status),
                    ],
                  ),
                  if (failed) ...[
                    const SizedBox(height: 6),
                    CustomText(
                      message.errorMessage?.trim().isNotEmpty == true
                          ? message.errorMessage!
                          : 'تعذّر إرسال الرسالة',
                      maxLines: 3,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 11, color: CustomColorsManager.appRed),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton.icon(
                          onPressed: onRetry,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            minimumSize: const Size(0, 32),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          icon: const Icon(Icons.refresh, size: 16),
                          label: const Text('إعادة المحاولة', style: TextStyle(fontSize: 12)),
                        ),
                        TextButton(
                          onPressed: onDiscard,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            minimumSize: const Size(0, 32),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            foregroundColor: CustomColorsManager.lightGrayTextColor,
                          ),
                          child: const Text('حذف', style: TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusIndicator extends StatelessWidget {
  const _StatusIndicator({required this.status});

  final PendingMessageStatus status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case PendingMessageStatus.sending:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 10,
              height: 10,
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(width: 4),
            CustomText(
              'جاري الإرسال...',
              style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
            ),
          ],
        );
      case PendingMessageStatus.sent:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.done_all, size: 13, color: Colors.green),
            const SizedBox(width: 4),
            const CustomText(
              'تم الإرسال',
              style: TextStyle(fontSize: 10, color: Colors.green),
            ),
          ],
        );
      case PendingMessageStatus.failed:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 13, color: CustomColorsManager.appRed),
            const SizedBox(width: 4),
            CustomText(
              'فشل الإرسال',
              style: TextStyle(fontSize: 10, color: CustomColorsManager.appRed),
            ),
          ],
        );
    }
  }
}

class _ConversationAttachments extends StatelessWidget {
  const _ConversationAttachments({required this.files});

  final List<String> files;

  void _openAttachment(BuildContext context, String url, int index) {
    final name = suggestedAttachmentFileName(url, index);
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => TicketAttachmentViewerScreen(
          url: url,
          suggestedFileName: name,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < files.length; i++) ...[
          if (i > 0) const SizedBox(height: 8),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _openAttachment(context, files[i], i),
              borderRadius: BorderRadius.circular(10),
              child: Ink(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: CustomColorsManager.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: CustomColorsManager.grayColorForIcons),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.attach_file,
                      size: 22,
                      color: CustomColorsManager.primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CustomText(
                        suggestedAttachmentFileName(files[i], i),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: CustomStyleManger.normalText.copyWith(
                          fontSize: 12,
                          color: CustomColorsManager.black,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.download_outlined,
                      size: 20,
                      color: CustomColorsManager.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
