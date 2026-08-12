class SetBusyStateRequest {
  final int userId;
  final bool status; // true = Busy , false = Available

  SetBusyStateRequest({required this.userId, required this.status});

  /// Request → API
  Map<String, dynamic> toJson() {
    return {"EmployeeId": userId, "IsBusy": status};
  }

  /// Response ← Server
  factory SetBusyStateRequest.fromServer(Map<String, dynamic> json) {
    return SetBusyStateRequest(
      userId: json['EmployeeId'] ?? 0,
      status: json['IsBusy'] ?? false,
    );
  }
}
