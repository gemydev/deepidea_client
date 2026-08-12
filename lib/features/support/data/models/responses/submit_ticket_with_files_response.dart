class SubmitTicketWithFilesResponse {
  final int statusCode;
  final String message;
  final TicketResult result;

  SubmitTicketWithFilesResponse({
    required this.statusCode,
    required this.message,
    required this.result,
  });

  factory SubmitTicketWithFilesResponse.fromJson(Map<String, dynamic> json) {
    return SubmitTicketWithFilesResponse(
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

  TicketResult({
    required this.ticketId,
    required this.ticketCode,
  });

  factory TicketResult.fromJson(Map<String, dynamic> json) {
    return TicketResult(
      ticketId: json['ticketId'] as int,
      ticketCode: json['ticketCode'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'ticketCode': ticketCode,
    };
  }
}
