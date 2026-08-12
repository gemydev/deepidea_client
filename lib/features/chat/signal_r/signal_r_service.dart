import 'dart:convert';
import 'dart:developer';

import 'package:signalr_netcore/signalr_client.dart';

class SignalRService {
  late HubConnection chatConnection;
  late HubConnection notificationConnection;

  // ==============================================================
  //                         CHAT HUB
  // ==============================================================

  Future<void> initChatHub({
    required int userId,
    required int conversationId,
    required Function(dynamic msg) onMessageReceived,
  }) async {
    log("🔵 [CHAT] Initializing Chat Hub...");
    log("🔵 [CHAT] UserID: $userId | ConversationID: $conversationId");

    try {
      chatConnection = HubConnectionBuilder()
          .withUrl(
            "https://dev2.newgooobig.com/chathub?userId=$userId&conversationId=$conversationId",
            options: HttpConnectionOptions(
              transport: HttpTransportType.WebSockets,
              skipNegotiation: true,
            ),
          )
          .build();

      // Listen to incoming messages
      chatConnection.on("ReceiveMessage", (msg) {
        log("📩 [CHAT] Raw SignalR Message: $msg");

        if (msg != null && msg.isNotEmpty) {
          final messageData = msg.first;

          // Ensure the message is properly formatted as a Map
          Map<String, dynamic> formattedMessage;
          if (messageData is Map<String, dynamic>) {
            formattedMessage = messageData;
          } else if (messageData is String) {
            try {
              formattedMessage = json.decode(messageData);
            } catch (e) {
              formattedMessage = {
                'content': messageData.toString(),
                'senderId': null,
                'timestamp': DateTime.now().toIso8601String(),
              };
            }
          } else {
            formattedMessage = {
              'content': messageData.toString(),
              'senderId': null,
              'timestamp': DateTime.now().toIso8601String(),
            };
          }

          log("📩 [CHAT] Formatted Message: $formattedMessage");
          onMessageReceived(formattedMessage);
        }
      });

      await chatConnection.start();
      log("✅ [CHAT] ChatHub Connected Successfully");

      await chatConnection.invoke("JoinConversationGroup", args: [conversationId]);
      log("👥 [CHAT] Joined Conversation Group: $conversationId");
    } catch (e) {
      log("❌ [CHAT] Failed to Init ChatHub: $e");
    }
  }

  Future<void> sendMessage(
    int senderId,
    int receiverId,
    int conversationId,
    String message,
    int userType,
  ) async {
    log("📤 [CHAT] Sending Message...");
    log("📤 [CHAT] Sender: $senderId | Receiver: $receiverId | Conv: $conversationId");
    log("📤 [CHAT] Message: $message");

    try {
      await chatConnection.invoke(
        "BroadcastMessage",
        args: [senderId, receiverId, conversationId, message, userType],
      );
      log("✅ [CHAT] Message Sent Successfully");
    } catch (e) {
      log("❌ [CHAT] Error Sending Message: $e");
    }
  }

  // ==============================================================
  //                   NOTIFICATION HUB
  // ==============================================================

  Future<void> initNotificationHub({
    required int userId,
    required Function(dynamic) onNotification,
  }) async {
    log("🔔 [NOTIF] Initializing Notification Hub...");
    log("🔔 [NOTIF] UserID: $userId");

    try {
      notificationConnection = HubConnectionBuilder()
          .withUrl(
            "https://dev2.newgooobig.com/notificationcallshub?userId=$userId",
            options: HttpConnectionOptions(
              transport: HttpTransportType.WebSockets,
              skipNegotiation: true,
            ),
          )
          .build();

      notificationConnection.on("ReceiveNotification", (msg) {
        log("📨 [NOTIF] Notification Received: $msg");
        onNotification(msg?.first);
      });

      await notificationConnection.start();
      log("✅ [NOTIF] Notifications Hub Connected Successfully");
    } catch (e) {
      log("❌ [NOTIF] Error Connecting Notifications Hub: $e");
    }
  }

  Future<void> sendNotification(String userId, String title, String message) async {
    log("📤 [NOTIF] Sending Notification...");
    log("📤 [NOTIF] TargetUser: $userId | Title: $title | Msg: $message");

    try {
      await notificationConnection.invoke("SendNotificationToUser", args: [userId, title, message]);
      log("✅ [NOTIF] Notification Sent");
    } catch (e) {
      log("❌ [NOTIF] Error Sending Notification: $e");
    }
  }

  // ==============================================================
  //                          DISPOSE
  // ==============================================================

  Future<void> dispose() async {
    log("🧹 [SERVICE] Disposing SignalR Connections...");

    try {
      await chatConnection.stop();
      log("🛑 [CHAT] ChatHub Disconnected");
    } catch (e) {
      log("❌ [CHAT] Error Disconnecting: $e");
    }

    try {
      await notificationConnection.stop();
      log("🛑 [NOTIF] NotificationsHub Disconnected");
    } catch (e) {
      log("❌ [NOTIF] Error Disconnecting: $e");
    }
  }
}
