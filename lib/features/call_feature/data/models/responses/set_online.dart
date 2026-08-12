class SetOnlineResponse {
  final int employeeId;
  final bool isOnline;

  SetOnlineResponse({required this.employeeId, required this.isOnline});

  factory SetOnlineResponse.fromJson(Map<String, dynamic> json) {
    return SetOnlineResponse(
      employeeId: json['employeeId'] ?? 0,
      isOnline: json['isOnline'] ?? false,
    );
  }
}
