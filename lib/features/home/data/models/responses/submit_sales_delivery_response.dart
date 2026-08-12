class SubmitSalesDeliveryResponse {
  final int statusCode;
  final String message;
  final Result result;

  SubmitSalesDeliveryResponse({
    required this.statusCode,
    required this.message,
    required this.result,
  });

  factory SubmitSalesDeliveryResponse.fromJson(Map<String, dynamic> json) {
    return SubmitSalesDeliveryResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      result: Result.fromJson(json['result']),
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

class Result {
  final int ticketId;
  final String ticketCode;
  final int salesDeliveryId;

  Result({
    required this.ticketId,
    required this.ticketCode,
    required this.salesDeliveryId,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      ticketId: json['ticketId'],
      ticketCode: json['ticketCode'],
      salesDeliveryId: json['salesDeliveryId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'ticketCode': ticketCode,
      'salesDeliveryId': salesDeliveryId,
    };
  }
}
