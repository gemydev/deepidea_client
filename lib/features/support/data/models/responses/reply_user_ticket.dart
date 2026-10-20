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
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: json['message']?.toString() ?? '',
      result: json['result'] is Map
          ? TicketResult.fromJson(Map<String, dynamic>.from(json['result'] as Map))
          : TicketResult(ticketId: 0, ticketCode: '', ticketStatus: ''),
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
      ticketId: (json['ticketId'] as num?)?.toInt() ?? 0,
      ticketCode: json['ticketCode']?.toString() ?? '',
      ticketStatus: json['ticketStatus']?.toString() ?? '',
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
