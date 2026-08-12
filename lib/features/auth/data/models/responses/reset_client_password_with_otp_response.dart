class ResetClientPasswordWithOtpResult {
  final num? clientId;
  final String? clientEmail;

  const ResetClientPasswordWithOtpResult({this.clientId, this.clientEmail});

  factory ResetClientPasswordWithOtpResult.fromJson(Map<String, dynamic> json) {
    return ResetClientPasswordWithOtpResult(
      clientId: json['clientId'] as num?,
      clientEmail: json['clientEmail']?.toString(),
    );
  }
}

class ResetClientPasswordWithOtpResponse {
  final num? statusCode;
  final String? statusMessage;
  final ResetClientPasswordWithOtpResult? result;

  const ResetClientPasswordWithOtpResponse({
    this.statusCode,
    this.statusMessage,
    this.result,
  });

  factory ResetClientPasswordWithOtpResponse.fromJson(Map<String, dynamic> json) {
    return ResetClientPasswordWithOtpResponse(
      statusCode: json['statusCode'] as num?,
      statusMessage: json['statusMessage']?.toString(),
      result: json['result'] is Map<String, dynamic>
          ? ResetClientPasswordWithOtpResult.fromJson(json['result'] as Map<String, dynamic>)
          : null,
    );
  }

  String get message => statusMessage ?? '';
}
