class ResetClientPasswordWithOtpRequest {
  final String email;
  final String otpCode;
  final String newPassword;
  final String confirmPassword;

  const ResetClientPasswordWithOtpRequest({
    required this.email,
    required this.otpCode,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'otpCode': otpCode,
    'newPassword': newPassword,
    'confirmPassword': confirmPassword,
  };

  @override
  String toString() =>
      'ResetClientPasswordWithOtpRequest(email: $email, otpCode: $otpCode)';
}
