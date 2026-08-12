import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/network/dio_client.dart';
import '../../../../core/helpers/preferences_manager.dart';
import '../../../../injection_container/injection_container.dart';
import '../../data/api_service.dart';
import '../../models/request/send_message.dart';
import '../signal_r_service.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final SignalRService signalR;

  ChatCubit(this.signalR) : super(ChatInitial());

  Future<void> initChat({
    required int userId,
    required int conversationId,
  }) async {
    emit(ChatLoading());

    try {
      await signalR.initChatHub(
        userId: userId,
        conversationId: conversationId,
        onMessageReceived: (msg) {
          if (msg is Map<String, dynamic>) {
            final senderId = msg['senderId'] ?? msg['senderid'];
            final isFromMe =
                senderId ==
                TpPreferencesManager.retrieveString(
                  TpPreferencesManager.userId,
                );

            if (!isFromMe) {
              // Only emit received event for messages from others
              log("📨 [CUBIT] Received message from other user: $msg");
              emit(ChatMessageReceived(msg));
            } else {
              log("📨 [CUBIT] Received own message, ignoring: $msg");
            }
          }
        },
      );

      emit(ChatInitial());
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> sendMessage({
    required int senderId,
    required int receiverId,
    required int conversationId,
    required String message,
  }) async {
    try {
      log("📤 [CUBIT] Sending message: $message");

      await signalR.sendMessage(
        senderId,
        receiverId,
        conversationId,
        message,
        2,
      );
      ChatApiService(sl<NetworkClient>()).sendMessage(
        SendMessageRequest(
          senderId: senderId,
          receiverId: receiverId,
          content: message,
          userType: 2,
        ).toJson(),
      );

      // Don't emit ChatMessageSent here to avoid duplicates
      // The UI will handle optimistic updates if needed
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}
