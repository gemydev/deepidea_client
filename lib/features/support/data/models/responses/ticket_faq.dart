class TicketFaq {
  TicketFaq({
    this.autoId,
    this.question,
    this.answer,
    this.youtubeLink,
    this.pdfLink,
    this.details,
    this.createdDate,
  });

  factory TicketFaq.fromJson(dynamic json) {
    return TicketFaq(
      autoId: json['autoId'] as num?,
      question: json['question']?.toString(),
      answer: json['answer']?.toString(),
      youtubeLink: json['youtubeLink']?.toString(),
      pdfLink: json['pdfLink']?.toString(),
      details: json['details']?.toString(),
      createdDate: json['createdDate']?.toString(),
    );
  }

  final num? autoId;
  final String? question;
  final String? answer;
  final String? youtubeLink;
  final String? pdfLink;
  final String? details;
  final String? createdDate;
}

class TicketFaqCategory {
  TicketFaqCategory({
    this.categoryId,
    this.categoryName,
    this.faqs = const [],
  });

  factory TicketFaqCategory.fromJson(dynamic json) {
    final faqsList = <TicketFaq>[];
    final rawFaqs = json['faQs'];
    if (rawFaqs is List) {
      for (final item in rawFaqs) {
        faqsList.add(TicketFaq.fromJson(item));
      }
    }
    return TicketFaqCategory(
      categoryId: json['categoryId'] as num?,
      categoryName: json['categoryName']?.toString(),
      faqs: faqsList,
    );
  }

  final num? categoryId;
  final String? categoryName;
  final List<TicketFaq> faqs;
}
