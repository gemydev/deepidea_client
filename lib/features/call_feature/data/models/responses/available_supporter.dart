class AvailableSupportResponse {
  final int autoId;
  final String fullName;
  final String mobileNo;
  final String email;

  AvailableSupportResponse({
    required this.autoId,
    required this.fullName,
    required this.mobileNo,
    required this.email,
  });

  factory AvailableSupportResponse.fromJson(Map<String, dynamic> json) {
    return AvailableSupportResponse(
      autoId: json['autoId'] ?? 0,
      fullName: json['fullName'] ?? '',
      mobileNo: json['mobileNo']?.toString() ?? '',
      email: json['email'] ?? '',
    );
  }
}