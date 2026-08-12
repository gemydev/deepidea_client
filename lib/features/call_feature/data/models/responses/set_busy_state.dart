class SetBusyStateResponse {
  final int userId;
  final String status;

  SetBusyStateResponse({required this.userId, required this.status});

  factory SetBusyStateResponse.fromJson(Map<String, dynamic> json) {
    return SetBusyStateResponse(
      userId: json['employeeId'] ?? 0,
      status: json['status'] ?? "",
    );
  }
}
