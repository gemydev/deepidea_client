class ChatMessageResponse {
  final int autoId;
  final int senderId;
  final int receiverId;
  final bool? isReceiverEmp;
  final int conversationId;
  final String content;
  final bool? isRead;
  final DateTime timestamp;
  final int userType;

  ChatMessageResponse({
    required this.autoId,
    required this.senderId,
    required this.receiverId,
    required this.isReceiverEmp,
    required this.conversationId,
    required this.content,
    required this.isRead,
    required this.timestamp,
    required this.userType,
  });

  factory ChatMessageResponse.fromJson(Map<String, dynamic> json) {
    return ChatMessageResponse(
      autoId: json["autoId"],
      senderId: json["senderId"],
      receiverId: json["receiverId"],
      isReceiverEmp: json["isReceiverEmp"],
      conversationId: json["conversationId"],
      content: json["content"],
      isRead: json["isRead"],
      timestamp: DateTime.parse(json["timestamp"]),
      userType: json["userType"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "autoId": autoId,
      "senderId": senderId,
      "receiverId": receiverId,
      "isReceiverEmp": isReceiverEmp,
      "conversationId": conversationId,
      "content": content,
      "isRead": isRead,
      "timestamp": timestamp.toIso8601String(),
      "userType": userType,
    };
  }

  @override
  String toString() {
    return 'ChatMessageResponse('
        'autoId: $autoId, '
        'senderId: $senderId, '
        'receiverId: $receiverId, '
        'isReceiverEmp: $isReceiverEmp, '
        'conversationId: $conversationId, '
        'content: "$content", '
        'isRead: $isRead, '
        'timestamp: $timestamp, '
        'userType: $userType'
        ')';
  }
}
