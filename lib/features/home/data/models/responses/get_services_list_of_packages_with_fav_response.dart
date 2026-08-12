class GetServicesListOfPackagesWithFavResponse {
  GetServicesListOfPackagesWithFavResponse({
    this.statusCode,
    this.message,
    this.result,
  });

  GetServicesListOfPackagesWithFavResponse.fromJson(dynamic json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(Package.fromJson(v));
      });
    }
  }

  num? statusCode;
  String? message;
  List<Package>? result;

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

class Package {
  Package({
    this.packageId,
    this.packageName,
    this.packageDetails,
    this.priceDetails,
    this.isFavorite,
    this.subFeatures,
    this.subPackages,
    this.images,
  });

  Package.fromJson(dynamic json) {
    packageId = json['packageId'];
    packageName = json['packageName'];
    packageDetails = json['packageDetails'];
    priceDetails = json['priceDetails'] != null
        ? PriceDetails.fromJson(json['priceDetails'])
        : null;
    isFavorite = json['isFavorite'];
    if (json['subFeatures'] != null) {
      subFeatures = [];
      json['subFeatures'].forEach((v) {
        subFeatures?.add(SubFeature.fromJson(v));
      });
    }
    if (json['subPackages'] != null) {
      subPackages = [];
      json['subPackages'].forEach((v) {
        subPackages?.add(SubPackage.fromJson(v));
      });
    }
    images = json['images'] != null ? List<String>.from(json['images']) : [];
  }

  int? packageId;
  String? packageName;
  String? packageDetails;
  PriceDetails? priceDetails;
  bool? isFavorite;
  List<SubFeature>? subFeatures;
  List<SubPackage>? subPackages;
  List<String>? images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['packageId'] = packageId;
    map['packageName'] = packageName;
    map['packageDetails'] = packageDetails;
    if (priceDetails != null) {
      map['priceDetails'] = priceDetails?.toJson();
    }
    map['isFavorite'] = isFavorite;
    if (subFeatures != null) {
      map['subFeatures'] = subFeatures?.map((v) => v.toJson()).toList();
    }
    if (subPackages != null) {
      map['subPackages'] = subPackages?.map((v) => v.toJson()).toList();
    }
    if (images != null) {
      map['images'] = images;
    }
    return map;
  }
}

class SubFeature {
  SubFeature({
    this.autoId,
    this.features,
    this.qnt,
    this.details,
  });

  SubFeature.fromJson(dynamic json) {
    autoId = json['autoId'];
    features = json['features'];
    qnt = json['qnt'];
    details = json['details'];
  }

  num? autoId;
  String? features;
  num? qnt;
  String? details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['autoId'] = autoId;
    map['features'] = features;
    map['qnt'] = qnt;
    map['details'] = details;
    return map;
  }
}

class SubPackage {
  SubPackage({
    this.packageId,
    this.unitPrice,
    this.quantity,
    this.totalPrice,
    this.discount,
    this.taxRate,
    this.cost,
    this.packageName,
    this.executionPeriod,
    this.images,
  });

  SubPackage.fromJson(dynamic json) {
    packageId = json['packageId'];
    unitPrice = json['unitPrice'];
    quantity = json['quantity'];
    totalPrice = json['totalPrice'];
    discount = json['discount'];
    taxRate = json['taxRate'];
    cost = json['cost'];
    packageName = json['packageName'];
    executionPeriod = json['executionPeriod'];
    images = json['images'] != null ? List<String>.from(json['images']) : [];
  }

  num? packageId;
  num? unitPrice;
  num? quantity;
  num? totalPrice;
  num? discount;
  num? taxRate;
  num? cost;
  String? packageName;
  num? executionPeriod;
  List<String>? images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['packageId'] = packageId;
    map['unitPrice'] = unitPrice;
    map['quantity'] = quantity;
    map['totalPrice'] = totalPrice;
    map['discount'] = discount;
    map['taxRate'] = taxRate;
    map['cost'] = cost;
    map['packageName'] = packageName;
    map['executionPeriod'] = executionPeriod;
    if (images != null) {
      map['images'] = images;
    }
    return map;
  }
}

class PriceDetails {
  PriceDetails({
    this.cost,
    this.estimatedCost,
    this.discount,
    this.packageID,
    this.packageName,
    this.quantity,
    this.taxRate,
    this.unitPrice,
    this.totalPrice,
  });

  PriceDetails.fromJson(dynamic json) {
    cost = json['cost'];
    estimatedCost = json['estimatedCost'];
    discount = json['discount'];
    packageID = json['packageID'];
    packageName = json['packageName'];
    quantity = json['quantity'];
    taxRate = json['taxRate'];
    unitPrice = json['unitPrice'];
    totalPrice = json['totalPrice'];
  }

  num? cost;
  num? estimatedCost;
  num? discount;
  num? packageID;
  String? packageName;
  num? quantity;
  num? taxRate;
  num? unitPrice;
  num? totalPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cost'] = cost;
    map['estimatedCost'] = estimatedCost;
    map['discount'] = discount;
    map['packageID'] = packageID;
    map['packageName'] = packageName;
    map['quantity'] = quantity;
    map['taxRate'] = taxRate;
    map['unitPrice'] = unitPrice;
    map['totalPrice'] = totalPrice;
    return map;
  }
}
