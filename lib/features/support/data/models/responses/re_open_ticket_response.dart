class ReOpenTicketResponse {
  final int statusCode;
  final String message;
  final TicketResult result;

  ReOpenTicketResponse({
    required this.statusCode,
    required this.message,
    required this.result,
  });

  factory ReOpenTicketResponse.fromJson(Map<String, dynamic> json) {
    return ReOpenTicketResponse(
      statusCode: json['statusCode'] as int? ?? 0,
      message: json['message'] as String? ?? '',
      result: TicketResult.fromJson(json['result'] ?? {}),
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
  final String ticketMsg;
  final String ticketStatus;

  TicketResult({
    required this.ticketId,
    required this.ticketCode,
    required this.ticketMsg,
    required this.ticketStatus,
  });

  factory TicketResult.fromJson(Map<String, dynamic> json) {
    return TicketResult(
      ticketId: json['ticketId'] as int? ?? 0,
      ticketCode: json['ticketCode'] as String? ?? '',
      ticketMsg: json['ticketMsg'] as String? ?? '',
      ticketStatus: json['ticketStatus'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'ticketCode': ticketCode,
      'ticketMsg': ticketMsg,
      'ticketStatus': ticketStatus,
    };
  }
}
