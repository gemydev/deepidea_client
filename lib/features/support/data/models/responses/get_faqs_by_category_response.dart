import 'ticket_faq.dart';

class GetFaqsByCategoryResponse {
  GetFaqsByCategoryResponse({this.statusCode, this.message, this.result});

  GetFaqsByCategoryResponse.fromJson(dynamic json) {
    statusCode = json['statusCode'];
    message = json['message']?.toString();
    if (json['result'] != null) {
      result = [];
      for (final item in json['result'] as List) {
        result!.add(TicketFaq.fromJson(item));
      }
    }
  }

  num? statusCode;
  String? message;
  List<TicketFaq>? result;
}
