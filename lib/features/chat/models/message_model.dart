class Message {
  final int autoId;
  final int senderId;
  final int receiverId;
  final int conversationId;
  final String content;
  final bool isRead;
  final DateTime timestamp;

  Message({
    required this.autoId,
    required this.senderId,
    required this.receiverId,
    required this.conversationId,
    required this.content,
    required this.isRead,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      autoId: json['autoId'] as int,
      senderId: json['senderId'] as int,
      receiverId: json['receiverId'] as int,
      conversationId: json['conversationId'] as int,
      content: json['content'] as String,
      isRead: json['isRead'] as bool,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'autoId': autoId,
      'senderId': senderId,
      'receiverId': receiverId,
      'conversationId': conversationId,
      'content': content,
      'isRead': isRead,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
