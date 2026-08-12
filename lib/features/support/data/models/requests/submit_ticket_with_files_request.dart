class TicketSubmissionRequest {
  final String subject;
  final String msg;
  final String userId;
  final int? categoryId;
  final List<int>? fileIds;

  TicketSubmissionRequest({
    required this.userId,
    required this.subject,
    required this.msg,
    this.categoryId,
    this.fileIds,
  });

  factory TicketSubmissionRequest.fromJson(Map<String, dynamic> json) {
    return TicketSubmissionRequest(
      subject: json['Subject'] ?? '',
      msg: json['Msg'] ?? '',
      userId: json['UserId']?.toString() ?? '',
      categoryId: json['CategoryId'],
      fileIds:
          (json['FileIds'] as List<dynamic>?)
              ?.map((e) => int.tryParse(e.toString()) ?? 0)
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Subject'] = subject;
    map['Msg'] = msg;
    map['UserId'] = userId;
    map['CategoryId'] = categoryId;
    if (fileIds != null && fileIds!.isNotEmpty) {
      map['FileIds'] = fileIds;
    }
    return map;
  }
}
