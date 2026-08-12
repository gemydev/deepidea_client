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
  const MessagesList({super.key, required this.ticketId});

  final String ticketId;

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  late GetTicketConversationCubit getTicketConversationCubit;

  @override
  void initState() {
    super.initState();
    getTicketConversationCubit = sl<GetTicketConversationCubit>();
    getTicketConversationCubit.getTicketConversation(widget.ticketId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTicketConversationCubit, GetTicketConversationState>(
      bloc: getTicketConversationCubit,
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
          final List<Conversation>? conversations = state.response.conversation;

          if (conversations == null || conversations.isEmpty) {
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
            padding: const EdgeInsets.all(16),
            itemCount: conversations.length,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
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
                          CustomText(
                            formatArabicDate(item.createdDate?.toString() ?? ''),
                            style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
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
