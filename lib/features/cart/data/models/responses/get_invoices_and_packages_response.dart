class GetInvoicesAndPackagesResponse {
  GetInvoicesAndPackagesResponse({
    this.statusCode,
    this.info,
  });

  GetInvoicesAndPackagesResponse.fromJson(dynamic json) {
    statusCode = json['statusCode'];
    if (json['info'] != null) {
      info = [];
      json['info'].forEach((v) {
        info?.add(Info.fromJson(v));
      });
    }
  }
  num? statusCode;
  List<Info>? info;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = statusCode;
    if (info != null) {
      map['info'] = info?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Info {
  Info({
    this.invoiceId,
    this.name,
    this.packages,
  });

  Info.fromJson(dynamic json) {
    invoiceId = json['invoiceId'];
    name = json['name'];
    if (json['packages'] != null) {
      packages = [];
      json['packages'].forEach((v) {
        packages?.add(Packages.fromJson(v));
      });
    }
  }
  num? invoiceId;
  String? name;
  List<Packages>? packages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['invoiceId'] = invoiceId;
    map['name'] = name;
    if (packages != null) {
      map['packages'] = packages?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Packages {
  Packages({
    this.packageId,
    this.packageName,
    this.packageQty,
    this.usedQty,
    this.availableQty,
    this.packageDetails,
  });

  Packages.fromJson(dynamic json) {
    packageId = json['packageId'];
    packageName = json['packageName'];
    packageQty = json['packageQty'];
    usedQty = json['usedQty'];
    availableQty = json['availableQty'];
    packageDetails = json['packageDetails'];
  }
  num? packageId;
  String? packageName;
  num? packageQty;
  num? usedQty;
  num? availableQty;
  String? packageDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['packageId'] = packageId;
    map['packageName'] = packageName;
    map['packageQty'] = packageQty;
    map['usedQty'] = usedQty;
    map['availableQty'] = availableQty;
    map['packageDetails'] = packageDetails;
    return map;
  }
}
