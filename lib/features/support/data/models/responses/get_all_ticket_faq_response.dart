import 'ticket_faq.dart';

class GetAllTicketFaqResponse {
  GetAllTicketFaqResponse({this.statusCode, this.message, this.result});

  GetAllTicketFaqResponse.fromJson(dynamic json) {
    statusCode = json['statusCode'];
    message = json['message']?.toString();
    if (json['result'] != null) {
      result = [];
      for (final item in json['result'] as List) {
        result!.add(TicketFaqCategory.fromJson(item));
      }
    }
  }

  num? statusCode;
  String? message;
  List<TicketFaqCategory>? result;
}
