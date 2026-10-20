class ReplyUserTicketRequest {
  final int ticketId;
  final String message;
  final List<int> fileIds;

  ReplyUserTicketRequest({
    required this.ticketId,
    required this.message,
    this.fileIds = const [],
  });

  factory ReplyUserTicketRequest.fromJson(Map<String, dynamic> json) {
    return ReplyUserTicketRequest(
      ticketId: json['TicketId'] as int,
      message: json['Msg'] as String,
      fileIds: (json['FileIds'] as List?)?.map((e) => int.tryParse(e.toString()) ?? 0).toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TicketId': ticketId,
      'Msg': message,
      if (fileIds.isNotEmpty) 'FileIds': fileIds,
    };
  }
}
