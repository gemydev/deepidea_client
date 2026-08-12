class SendOtpVerificationRequest {
  final int userId;
  final String email;

  SendOtpVerificationRequest({required this.userId, required this.email});

  factory SendOtpVerificationRequest.fromJson(Map<String, dynamic> json) {
    return SendOtpVerificationRequest(
      userId: json['UserId'] as int,
      email: json['Email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'UserId': userId, 'Email': email};
  }

  @override
  String toString() {
    return 'SendOtpVerificationRequest(userId: $userId, email: $email)';
  }
}
