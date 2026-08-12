class SendClientForgotPasswordOtpRequest {
  final String email;

  const SendClientForgotPasswordOtpRequest({required this.email});

  Map<String, dynamic> toJson() => {'email': email};

  @override
  String toString() => 'SendClientForgotPasswordOtpRequest(email: $email)';
}
