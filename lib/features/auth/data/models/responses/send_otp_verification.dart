class SendOtpVerificationResponse {
  final String message;

  const SendOtpVerificationResponse({required this.message});

  factory SendOtpVerificationResponse.fromJson(Map<String, dynamic> json) {
    return SendOtpVerificationResponse(message: json['message'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }

  @override
  String toString() {
    return 'SendOtpVerificationResponse(message: $message)';
  }
}
