import 'get_ticket_details_response.dart';

class GetAllTicketsResponse {
  GetAllTicketsResponse({
    this.statusCode,
    this.message,
    this.result,
  });

  GetAllTicketsResponse.fromJson(dynamic json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(Ticket.fromJson(v));
      });
    }
  }

  num? statusCode;
  String? message;
  List<Ticket>? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = statusCode;
    map['message'] = message;
    if (result != null) {
      map['result'] = result?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Ticket {
  Ticket({
    this.ticketId,
    this.ticketCode,
    this.subject,
    this.msg,
    this.statusId,
    this.statusName,
    this.startDate,
    this.clientName,
    this.clientId,
    this.adminName,
    this.adminId,
    this.websiteId,
    this.websiteName,
    this.category,
  });

  Ticket.fromJson(dynamic json) {
    ticketId = json['ticketId'];
    ticketCode = json['ticketCode'];
    subject = json['subject'];
    msg = json['msg'];
    statusId = json['statusId'];
    statusName = json['statusName'];
    startDate = json['startDate'];
    clientName = json['clientName'];
    clientId = json['clientId'];
    adminName = json['adminName'];
    adminId = json['adminId'];
    websiteId = json['websiteId'];
    websiteName = json['websiteName'];
    category =
    json['category'] != null ? Category.fromJson(json['category']) : null;
  }

  factory Ticket.fromTicketDetails(TicketDetails d) {
    return Ticket(
      ticketId: d.ticketId,
      ticketCode: d.ticketCode,
      subject: d.subject,
      msg: d.message,
      statusId: d.statusId,
      statusName: d.statusName,
      startDate: d.createdDate,
      clientName: d.clientName.isEmpty ? null : d.clientName,
      clientId: d.clientId,
      adminName: d.adminName.isEmpty ? null : d.adminName,
      adminId: d.adminId,
      websiteId: d.websiteId,
      websiteName: d.websiteName,
      category: Category(id: d.categoryId, name: d.categoryName),
    );
  }

  num? ticketId;
  String? ticketCode;
  String? subject;
  String? msg;
  num? statusId;
  String? statusName;
  String? startDate;

  String? clientName;
  num? clientId;
  String? adminName;
  num? adminId;
  num? websiteId;
  String? websiteName;

  Category? category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ticketId'] = ticketId;
    map['ticketCode'] = ticketCode;
    map['subject'] = subject;
    map['msg'] = msg;
    map['statusId'] = statusId;
    map['statusName'] = statusName;
    map['startDate'] = startDate;
    map['clientName'] = clientName;
    map['clientId'] = clientId;
    map['adminName'] = adminName;
    map['adminId'] = adminId;
    map['websiteId'] = websiteId;
    map['websiteName'] = websiteName;
    if (category != null) {
      map['category'] = category?.toJson();
    }
    return map;
  }
}

class Category {
  Category({
    this.id,
    this.name,
  });

  Category.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  num? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}
