class VerifyOtpResponse {
  final String message;

  const VerifyOtpResponse({required this.message});

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(message: json['message'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }

  @override
  String toString() {
    return 'SendOtpVerificationResponse(message: $message)';
  }
}
