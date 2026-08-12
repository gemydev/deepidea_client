class ReplyUserTicketResponse {
  final int statusCode;
  final String message;
  final TicketResult result;

  ReplyUserTicketResponse({
    required this.statusCode,
    required this.message,
    required this.result,
  });

  factory ReplyUserTicketResponse.fromJson(Map<String, dynamic> json) {
    return ReplyUserTicketResponse(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      result: TicketResult.fromJson(json['result']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
      'result': result.toJson(),
    };
  }
}

class TicketResult {
  final int ticketId;
  final String ticketCode;
  final String ticketStatus;

  TicketResult({
    required this.ticketId,
    required this.ticketCode,
    required this.ticketStatus,
  });

  factory TicketResult.fromJson(Map<String, dynamic> json) {
    return TicketResult(
      ticketId: json['ticketId'] as int,
      ticketCode: json['ticketCode'] as String,
      ticketStatus: json['ticketStatus'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'ticketCode': ticketCode,
      'ticketStatus': ticketStatus,
    };
  }
}
