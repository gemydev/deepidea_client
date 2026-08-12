class ReplyUserTicketRequest {
  final int ticketId;
  final String message;

  ReplyUserTicketRequest({
    required this.ticketId,
    required this.message,
  });

  factory ReplyUserTicketRequest.fromJson(Map<String, dynamic> json) {
    return ReplyUserTicketRequest(
      ticketId: json['TicketId'] as int,
      message: json['Msg'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TicketId': ticketId,
      'Msg': message,
    };
  }
}
