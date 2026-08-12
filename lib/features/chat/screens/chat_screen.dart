import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/data/network/dio_client.dart';
import '../../../core/helpers/preferences_manager.dart';
import '../../../core/utils/color_manager/color_manager.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../injection_container/injection_container.dart';
import '../../call_feature/data/call_service.dart';
import '../../call_feature/data/models/requests/set_busy_state.dart';
import '../../support/presentation/widgets/sub_app_bar.dart';
import '../data/api_service.dart';
import '../models/request/send_message.dart';
import '../signal_r/signal_r_service.dart';

class ChatScreen extends StatefulWidget {
  final int userId;
  final int receiverId;
  final String clientName;

  const ChatScreen({
    super.key,
    required this.userId,
    required this.receiverId,
    required this.clientName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  final SignalRService _signalR = SignalRService();
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scroll = ScrollController();

  List<Map<String, dynamic>> messages = [];
  bool loading = true;
  int conversationId = 0;

  /// لمنع تكرار الرسائل
  String? lastSentStableKey;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    CallApiService(sl<NetworkClient>()).getAvailableSupporter();
    _loadConversation().then((_) => _initializeChat());
  }

  // ============================ KEYBOARD LISTENER =============================

  @override
  void didChangeMetrics() {
    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
  }

  // ============================ Load Messages =============================

  Future<void> _loadConversation() async {
    try {
      final response = await ChatApiService(sl<NetworkClient>()).getConversation(
        senderId: widget.userId.toString(),
        receiverId: widget.receiverId.toString(),
      );

      final loadedMessages = response.messages ?? [];
      conversationId = response.autoId!.toInt();

      messages = loadedMessages.map((m) {
        final senderId = m.senderId;
        final content = m.content;
        final timestamp = m.timestamp ?? DateTime.now().toIso8601String();

        final stableKey = "$senderId-$content".hashCode.toString();

        return {
          "stableKey": stableKey,
          "text": content,
          "isMe": senderId == widget.userId,
          "isFile": false,
          "senderId": senderId,
          "timestamp": timestamp,
        };
      }).toList();

      setState(() => loading = false);
      _scrollToBottom();
    } catch (e) {
      log("❌ Error loading conversation: $e");
      setState(() => loading = false);
    }
  }

  // ============================ Init SignalR =============================

  void _initializeChat() {
    _signalR.initChatHub(
      userId: widget.userId,
      conversationId: conversationId,
      onMessageReceived: (msg) {
        Map<String, dynamic> parsed;

        if (msg is Map<String, dynamic>) {
          parsed = msg;
        } else if (msg is String) {
          try {
            parsed = json.decode(msg);
          } catch (_) {
            parsed = {"content": msg};
          }
        } else {
          return;
        }

        _handleIncomingMessage(parsed);
      },
    );
  }

  // ============================ Incoming Message =============================

  void _handleIncomingMessage(Map<String, dynamic> messageData) {
    final senderId = messageData['senderId'] ?? messageData['senderid'] ?? 0;
    final content = messageData['content'] ?? messageData['text'] ?? "";
    final timestamp = messageData['timestamp'] ?? DateTime.now().toIso8601String();

    final stableKey = "$senderId-$content".hashCode.toString();

    if (stableKey == lastSentStableKey) return;

    if (messages.any((e) => e["stableKey"] == stableKey)) return;

    setState(() {
      messages.add({
        "stableKey": stableKey,
        "text": content,
        "isMe": senderId == widget.userId,
        "isFile": false,
        "senderId": senderId,
        "timestamp": timestamp,
      });
    });

    _scrollToBottom();
  }

  // ============================ Scroll =============================

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent + 80,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // ============================ Send Message =============================

  void sendMsg() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final timestamp = DateTime.now().toIso8601String();

    final stableKey = "${widget.userId}-$text".hashCode.toString();
    lastSentStableKey = stableKey;

    setState(() {
      messages.add({
        "stableKey": stableKey,
        "text": text,
        "isMe": true,
        "isFile": false,
        "senderId": widget.userId,
        "timestamp": timestamp,
      });
    });

    _scrollToBottom();

    _signalR.sendMessage(widget.userId, widget.receiverId, conversationId, text, 2);

    ChatApiService(sl<NetworkClient>()).sendMessage(
      SendMessageRequest(
        senderId: widget.userId,
        receiverId: widget.receiverId,
        content: text,
        userType: 2,
      ).toJson(),
    );

    _controller.clear();
  }

  // ============================ Message Bubble =============================

  Widget _buildMessageBubble(String text, bool isMe, bool isFile) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        constraints: const BoxConstraints(maxWidth: 260),
        decoration: BoxDecoration(
          color: isMe ? CustomColorsManager.primaryColor : CustomColorsManager.grayColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isMe ? 16 : 0),
            topRight: Radius.circular(isMe ? 0 : 16),
            bottomLeft: const Radius.circular(16),
            bottomRight: const Radius.circular(16),
          ),
        ),
        child: CustomText(
          text,
          maxLines: 100,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black87,
            fontSize: 15,
            height: 1.35,
            fontWeight: isFile ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // ============================ UI =============================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // ⭐ مهم جداً
      backgroundColor: CustomColorsManager.white,
      body: SafeArea(
        child: Column(
          children: [
            SubAppBar(
              title: widget.clientName,
              widget: GestureDetector(
                onTap: () {
                  TpPreferencesManager.saveBool(TpPreferencesManager.supportChatOpend, false);
                  Get.back();
                },
                child: CustomText(
                  "إغلاق الدردشة",
                  style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : messages.isEmpty
                  ? Center(
                      child: CustomText(
                        "لا توجد رسائل بعد",
                        style: TextStyle(color: CustomColorsManager.lightTextColor, fontSize: 15),
                      ),
                    )
                  : ListView.builder(
                      controller: _scroll,
                      physics: const BouncingScrollPhysics(),
                      itemCount: messages.length,
                      itemBuilder: (_, index) {
                        final m = messages[index];
                        return _buildMessageBubble(m["text"], m["isMe"], m["isFile"]);
                      },
                    ),
            ),
            _buildInputBar(),
          ],
        ),
      ),
    );
  }

  // ============================ Input Bar =============================

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: CustomColorsManager.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: CustomColorsManager.black),
              ),
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "اكتب رسالة...",
                  hintStyle: TextStyle(color: CustomColorsManager.lightTextColor),
                ),
                onSubmitted: (_) => sendMsg(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 22,
            backgroundColor: CustomColorsManager.primaryColor,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: sendMsg,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _signalR.dispose();
    _controller.dispose();
    _scroll.dispose();

    CallApiService(sl<NetworkClient>()).setBusyState(
      SetBusyStateRequest(
        userId: int.parse(TpPreferencesManager.retrieveString(TpPreferencesManager.userId) ?? "0"),
        status: false,
      ),
    );

    super.dispose();
  }
}
