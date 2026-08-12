class VerifyOtpRequest {
  final int userId;
  final String otp;
  final String? email;
  final String? password;

  VerifyOtpRequest({
    this.email,
    this.password,
    required this.userId,
    required this.otp,
  });

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) {
    return VerifyOtpRequest(
      userId: json['UserId'] as int,
      otp: json['Otp'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'UserId': userId, 'Otp': otp};
  }

  @override
  String toString() {
    return 'VerifyOtpRequest(userId: $userId, otp: $otp, email: $email)';
  }
}
