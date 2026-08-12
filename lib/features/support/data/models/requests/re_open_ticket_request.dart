class ReOpenTicketRequest {
  final int ticketId;
  final String message;

  ReOpenTicketRequest({
    required this.ticketId,
    required this.message,
  });

  factory ReOpenTicketRequest.fromJson(Map<String, dynamic> json) {
    return ReOpenTicketRequest(
      ticketId: json['ticktId'] as int,
      message: json['msg'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticktId': ticketId,
      'msg': message,
    };
  }
}
