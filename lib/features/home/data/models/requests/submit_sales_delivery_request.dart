class SubmitSalesDeliveryRequest {
  SubmitSalesDeliveryRequest({
    this.invoiceId,
    this.packageId,
    this.quantity,
    this.description,
    this.fileIds,
  });

  num? invoiceId;
  num? packageId;
  num? quantity;
  String? description;
  List<dynamic>? fileIds;

  SubmitSalesDeliveryRequest.fromJson(Map<String, dynamic> json) {
    invoiceId = json['InvoiceId'];
    packageId = json['PackageId'];
    quantity = json['Quantity'];
    description = json['Description'];
    fileIds =
        json['FileIds'] != null ? List<dynamic>.from(json['FileIds']) : [];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['InvoiceId'] = invoiceId;
    map['PackageId'] = packageId;
    map['Quantity'] = quantity;
    map['Description'] = description ?? "";
    map['FileIds'] = fileIds ?? [];
    return map;
  }
}
