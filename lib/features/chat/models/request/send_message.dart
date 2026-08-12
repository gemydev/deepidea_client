class SendMessageRequest {
  final int senderId;
  final int receiverId;
  final String content;
  final int userType;

  SendMessageRequest({
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.userType,
  });

  Map<String, dynamic> toJson() {
    return {
      "SenderId": senderId,
      "ReceiverId": receiverId,
      "Content": content,
      "UserType": userType,
    };
  }

  factory SendMessageRequest.fromJson(Map<String, dynamic> json) {
    return SendMessageRequest(
      senderId: json["SenderId"],
      receiverId: json["ReceiverId"],
      content: json["Content"],
      userType: json["UserType"],
    );
  }

  @override
  String toString() {
    return 'SendMessageRequest('
        'senderId: $senderId, '
        'receiverId: $receiverId, '
        'content: "$content", '
        'userType: $userType'
        ')';
  }
}
