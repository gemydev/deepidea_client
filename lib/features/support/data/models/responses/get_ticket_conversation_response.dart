class GetTicketConversationResponse {
  final int? statusCode;
  final String? message;
  final Ticket? ticket;
  final List<Conversation>? conversation;
  final List<TicketStatusEntry>? statusHistory;

  GetTicketConversationResponse({
    this.statusCode,
    this.message,
    this.ticket,
    this.conversation,
    this.statusHistory,
  });

  factory GetTicketConversationResponse.fromJson(Map<String, dynamic> json) {
    return GetTicketConversationResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      ticket: json['ticket'] != null
          ? Ticket.fromJson(Map<String, dynamic>.from(json['ticket'] as Map))
          : null,
      conversation: (json['conversation'] as List?)
          ?.map((e) => Conversation.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      statusHistory: _parseStatusHistory(json['status']),
    );
  }

  static List<TicketStatusEntry>? _parseStatusHistory(dynamic raw) {
    if (raw is! List) return null;
    if (raw.isEmpty) return [];
    return raw.map((e) {
      if (e is Map) {
        return TicketStatusEntry.fromJson(Map<String, dynamic>.from(e));
      }
      if (e is String) {
        return TicketStatusEntry(statusName: e);
      }
      return TicketStatusEntry(statusName: e.toString());
    }).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
      'ticket': ticket?.toJson(),
      'conversation': conversation?.map((e) => e.toJson()).toList(),
      'status': statusHistory?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'GetTicketConversationResponse(statusCode: $statusCode, message: $message, ticket: $ticket, conversation: $conversation, statusHistory: $statusHistory)';
  }
}

class TicketStatusEntry {
  final int? statusId;
  final String? statusName;
  final DateTime? createdDate;

  TicketStatusEntry({
    this.statusId,
    this.statusName,
    this.createdDate,
  });

  factory TicketStatusEntry.fromJson(Map<String, dynamic> json) {
    return TicketStatusEntry(
      statusId: json['statusId'] is num ? (json['statusId'] as num).toInt() : null,
      statusName: json['statusName']?.toString(),
      createdDate: json['createdDate'] != null
          ? DateTime.tryParse(json['createdDate'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusId': statusId,
      'statusName': statusName,
      'createdDate': createdDate?.toIso8601String(),
    };
  }
}

class Ticket {
  final int? autoId;
  final String? name;
  final String? subject;
  final String? msg;
  final String? empName;
  final String? email;
  final String? mobile;
  final String? ticketCategory;
  final String? ticketStatus;
  final String? ticketWebsite;

  Ticket({
    this.autoId,
    this.name,
    this.subject,
    this.msg,
    this.empName,
    this.email,
    this.mobile,
    this.ticketCategory,
    this.ticketStatus,
    this.ticketWebsite,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      autoId: json['autoId'],
      name: json['name'],
      subject: json['subject'],
      msg: json['msg'],
      empName: json['empName'],
      email: json['email'],
      mobile: json['mobile'],
      ticketCategory: json['ticketCategory'],
      ticketStatus: json['ticketStatus'],
      ticketWebsite: json['ticketWebsite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'autoId': autoId,
      'name': name,
      'subject': subject,
      'msg': msg,
      'empName': empName,
      'email': email,
      'mobile': mobile,
      'ticketCategory': ticketCategory,
      'ticketStatus': ticketStatus,
      'ticketWebsite': ticketWebsite,
    };
  }

  @override
  String toString() {
    return 'Ticket(autoId: $autoId, name: $name, subject: $subject, msg: $msg, empName: $empName, email: $email, mobile: $mobile, ticketCategory: $ticketCategory, ticketStatus: $ticketStatus, ticketWebsite: $ticketWebsite)';
  }
}

class Conversation {
  final int? autoId;
  final String? msg;
  final String? briefMsg;
  final String? userFrom;
  final String? userTo;
  final DateTime? createdDate;
  final String? statusName;
  final bool? isClientToEmp;
  final List<String> filesList;

  Conversation({
    this.autoId,
    this.msg,
    this.briefMsg,
    this.userFrom,
    this.userTo,
    this.createdDate,
    this.statusName,
    this.isClientToEmp,
    this.filesList = const [],
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      autoId: json['autoId'],
      msg: json['msg'],
      briefMsg: json['briefMsg'],
      userFrom: json['userFrom'],
      userTo: json['userTo']?.toString(),
      createdDate: json['createdDate'] != null
          ? DateTime.tryParse(json['createdDate'])
          : null,
      statusName: json['statusName'],
      isClientToEmp: json['isClientToEmp'],
      filesList: (json['filesList'] as List?)
              ?.map((e) => e.toString())
              .where((url) => url.trim().isNotEmpty)
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'autoId': autoId,
      'msg': msg,
      'briefMsg': briefMsg,
      'userFrom': userFrom,
      'userTo': userTo,
      'createdDate': createdDate?.toIso8601String(),
      'statusName': statusName,
      'isClientToEmp': isClientToEmp,
      'filesList': filesList,
    };
  }

  @override
  String toString() {
    return 'Conversation(autoId: $autoId, msg: $msg, briefMsg: $briefMsg, userFrom: $userFrom, userTo: $userTo, createdDate: $createdDate, statusName: $statusName, isClientToEmp: $isClientToEmp, filesList: $filesList)';
  }
}
