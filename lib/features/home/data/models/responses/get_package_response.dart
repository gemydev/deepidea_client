class GetPackagesResponse {
  GetPackagesResponse({
    this.statusCode,
    this.msg,
    this.info,
  });

  int? statusCode;
  String? msg;
  List<ServicePackage>? info;

  GetPackagesResponse.fromJson(Map<String, dynamic> json) {
    // ✅ Ensure statusCode is always int
    final code = json['statusCode'];
    statusCode = code is int ? code : int.tryParse(code.toString());

    msg = json['msg'];

    if (json['info'] != null) {
      info = (json['info'] as List)
          .map((v) => ServicePackage.fromJson(v))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = statusCode;
    map['msg'] = msg;
    if (info != null) {
      map['info'] = info!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ServicePackage {
  ServicePackage({
    this.invoiceId,
    this.packageId,
    this.packageName,
    this.packageDetails,
    this.availableQty,
    this.executionPeriod,
    this.unitPrice,
    this.packageQty,
    this.usedQty,
    this.unit,
    this.imageLinks,
  });

  num? invoiceId;
  num? packageId;
  String? packageName;
  String? packageDetails;
  num? availableQty;
  num? executionPeriod;
  num? unitPrice;
  num? packageQty;
  num? usedQty;
  String? unit;
  List<String>? imageLinks;

  ServicePackage.fromJson(Map<String, dynamic> json) {
    invoiceId = json['invoiceId'];
    packageId = json['packageId'];
    packageName = json['packageName'];
    packageDetails = json['packageDetails'];
    availableQty = json['availableQty'];
    executionPeriod = json['executionPeriod'];
    unitPrice = json['unitPrice'];
    packageQty = json['packageQty'];
    usedQty = json['usedQty'];
    unit = json['unit'];

    // ✅ Safe parsing for imageLinks
    if (json['imageLinks'] != null) {
      final dynamic links = json['imageLinks'];
      if (links is List) {
        imageLinks = links.map((e) => e.toString()).toList();
      }
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['invoiceId'] = invoiceId;
    map['packageId'] = packageId;
    map['packageName'] = packageName;
    map['packageDetails'] = packageDetails;
    map['availableQty'] = availableQty;
    map['executionPeriod'] = executionPeriod;
    map['unitPrice'] = unitPrice;
    map['packageQty'] = packageQty;
    map['usedQty'] = usedQty;
    map['unit'] = unit;
    if (imageLinks != null) {
      map['imageLinks'] = imageLinks;
    }
    return map;
  }
}