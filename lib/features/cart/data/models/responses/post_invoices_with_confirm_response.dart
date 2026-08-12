class PostInvoicesWithConfirmResponse {
  PostInvoicesWithConfirmResponse({
    this.statusCode,
    this.invoiceNames,
    this.pdfBase64,
    this.pdfFileName,
    this.message,
  });

  String? statusCode;
  List<InvoiceNames>? invoiceNames;
  String? pdfBase64;
  String? pdfFileName;
  String? message;

  PostInvoicesWithConfirmResponse.fromJson(dynamic json) {
    statusCode = json['statusCode'];
    pdfBase64 = json['pdfBase64'];
    pdfFileName = json['pdfFileName'];
    message = json['message'];

    if (json['invoiceNames'] != null) {
      invoiceNames = [];
      json['invoiceNames'].forEach((v) {
        invoiceNames?.add(InvoiceNames.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = statusCode;
    map['pdfBase64'] = pdfBase64;
    map['pdfFileName'] = pdfFileName;
    map['message'] = message;

    if (invoiceNames != null) {
      map['invoiceNames'] = invoiceNames?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class InvoiceNames {
  InvoiceNames({
    this.invoiceId,
    this.onlineName,
    this.offlineName,
    this.clientEmail,
    this.clientPassword,
  });

  int? invoiceId;
  String? onlineName;
  String? offlineName;
  String? clientEmail;
  String? clientPassword;

  InvoiceNames.fromJson(dynamic json) {
    invoiceId = json['invoiceId'];
    onlineName = json['onlineName'];
    offlineName = json['offlineName'];
    clientEmail = json['clientEmail'];
    clientPassword = json['clientPassword'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['invoiceId'] = invoiceId;
    map['onlineName'] = onlineName;
    map['offlineName'] = offlineName;
    map['clientEmail'] = clientEmail;
    map['clientPassword'] = clientPassword;
    return map;
  }
}
