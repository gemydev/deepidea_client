class GetConversationResponse {
  final int autoId;
  final DateTime lastMessageTime;
  final bool isFirstUserEmp;
  final bool isSecondUserEmp;
  final ChatUser? user1;
  final ChatUser? user2;
  final List<ChatMessage> messages;

  GetConversationResponse({
    required this.autoId,
    required this.lastMessageTime,
    required this.isFirstUserEmp,
    required this.isSecondUserEmp,
    required this.user1,
    required this.user2,
    required this.messages,
  });

  factory GetConversationResponse.fromJson(Map<String, dynamic> json) {
    return GetConversationResponse(
      autoId: json["autoId"],
      lastMessageTime: DateTime.parse(json["lastMessageTime"]),
      isFirstUserEmp: json["isFirstUserEmp"],
      isSecondUserEmp: json["isSecondUserEmp"],
      user1: json["user1"] != null ? ChatUser.fromJson(json["user1"]) : null,
      user2: json["user2"] != null ? ChatUser.fromJson(json["user2"]) : null,
      messages: (json["messages"] as List)
          .map((m) => ChatMessage.fromJson(m))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "autoId": autoId,
      "lastMessageTime": lastMessageTime.toIso8601String(),
      "isFirstUserEmp": isFirstUserEmp,
      "isSecondUserEmp": isSecondUserEmp,
      "user1": user1?.toJson(),
      "user2": user2?.toJson(),
      "messages": messages.map((m) => m.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'ConversationResponse('
        'autoId: $autoId, '
        'lastMessageTime: $lastMessageTime, '
        'isFirstUserEmp: $isFirstUserEmp, '
        'isSecondUserEmp: $isSecondUserEmp, '
        'user1: $user1, '
        'user2: $user2, '
        'messages: $messages'
        ')';
  }
}

class ChatUser {
  final int autoId;
  final String name;
  final int? fileId;

  ChatUser({required this.autoId, required this.name, required this.fileId});

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      autoId: json["autoId"],
      name: json["name"],
      fileId: json["fileId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"autoId": autoId, "name": name, "fileId": fileId};
  }

  @override
  String toString() =>
      'ChatUser(autoId: $autoId, name: $name, fileId: $fileId)';
}

class ChatMessage {
  final int autoId;
  final int senderId;
  final int receiverId;
  final String content;
  final DateTime createdDate;
  final bool isRead;
  final ChatUser? sender;
  final ChatUser? receiver;

  ChatMessage({
    required this.autoId,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.createdDate,
    required this.isRead,
    required this.sender,
    required this.receiver,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      autoId: json["autoId"],
      senderId: json["senderId"],
      receiverId: json["receiverId"],
      content: json["content"],
      createdDate: DateTime.parse(json["createdDate"]),
      isRead: json["isRead"],
      sender: json["sender"] != null ? ChatUser.fromJson(json["sender"]) : null,
      receiver: json["receiver"] != null
          ? ChatUser.fromJson(json["receiver"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "autoId": autoId,
      "senderId": senderId,
      "receiverId": receiverId,
      "content": content,
      "createdDate": createdDate.toIso8601String(),
      "isRead": isRead,
      "sender": sender?.toJson(),
      "receiver": receiver?.toJson(),
    };
  }

  @override
  String toString() {
    return 'ChatMessage('
        'autoId: $autoId, senderId: $senderId, receiverId: $receiverId, '
        'content: "$content", createdDate: $createdDate, isRead: $isRead, '
        'sender: $sender, receiver: $receiver'
        ')';
  }
}
