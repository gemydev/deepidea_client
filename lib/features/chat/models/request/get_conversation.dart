class GetConversationRequest {
  final int senderId;
  final int receiverId;

  GetConversationRequest({required this.senderId, required this.receiverId});

  String toPath() => '$senderId/$receiverId';

  @override
  String toString() =>
      'GetConversationRequest(senderId: $senderId, receiverId: $receiverId)';
}
