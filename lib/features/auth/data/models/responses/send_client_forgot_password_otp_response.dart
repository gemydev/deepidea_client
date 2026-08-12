class SendClientForgotPasswordOtpResponse {
  final num? statusCode;
  final String? statusMessage;

  const SendClientForgotPasswordOtpResponse({
    this.statusCode,
    this.statusMessage,
  });

  factory SendClientForgotPasswordOtpResponse.fromJson(Map<String, dynamic> json) {
    return SendClientForgotPasswordOtpResponse(
      statusCode: json['statusCode'] as num?,
      statusMessage: json['statusMessage']?.toString(),
    );
  }

  String get message => statusMessage ?? '';
}
