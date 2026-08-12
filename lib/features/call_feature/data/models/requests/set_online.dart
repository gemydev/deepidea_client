class SetOnlineRequest {
  final int employeeId;
  final bool isOnline;

  SetOnlineRequest({required this.employeeId, required this.isOnline});

  Map<String, dynamic> toJson() {
    return {"EmployeeId": employeeId, "IsOnline": isOnline};
  }
}
