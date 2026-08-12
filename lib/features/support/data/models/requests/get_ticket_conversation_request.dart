class GetTicketConversationRequest {
  final String ticketId;

  GetTicketConversationRequest({required this.ticketId});

  factory GetTicketConversationRequest.fromJson(Map<String, dynamic> json) {
    return GetTicketConversationRequest(
      ticketId: json['ticketId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
    };
  }
}
