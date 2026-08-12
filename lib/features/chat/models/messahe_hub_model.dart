class MessageModel {
  final int senderId;
  final int receiverId;
  final int conversationId;
  final String content;
  final int userType;
  final DateTime timestamp;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.conversationId,
    required this.content,
    required this.userType,
    required this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json["senderId"],
      receiverId: json["receiverId"],
      conversationId: json["conversationId"],
      content: json["content"],
      userType: json["userType"],
      timestamp: DateTime.parse(json["timestamp"]),
    );
  }
}
