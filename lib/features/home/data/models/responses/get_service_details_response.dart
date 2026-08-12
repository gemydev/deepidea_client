class GetServiceDetailsResponse {
  GetServiceDetailsResponse({
    this.statusCode,
    this.message,
    this.result,
  });

  GetServiceDetailsResponse.fromJson(dynamic json) {
    statusCode = json['statusCode'];
    message = json['message'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  num? statusCode;
  String? message;
  Result? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = statusCode;
    map['message'] = message;
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }
}

class Result {
  Result({
    this.service,
    this.subProductPrices,
    this.packagesAttributes,
    this.images,
  });

  Result.fromJson(dynamic json) {
    service =
        json['service'] != null ? Service.fromJson(json['service']) : null;
    if (json['subProductPrices'] != null) {
      subProductPrices = [];
      json['subProductPrices'].forEach((v) {
        subProductPrices?.add(SubProductPrices.fromJson(v));
      });
    }
    if (json['packagesAttributes'] != null) {
      packagesAttributes = [];
      json['packagesAttributes'].forEach((v) {
        packagesAttributes?.add(PackagesAttributes.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
  }
  Service? service;
  List<SubProductPrices>? subProductPrices;
  List<PackagesAttributes>? packagesAttributes;
  List<Images>? images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (service != null) {
      map['service'] = service?.toJson();
    }
    if (subProductPrices != null) {
      map['subProductPrices'] =
          subProductPrices?.map((v) => v.toJson()).toList();
    }
    if (packagesAttributes != null) {
      map['packagesAttributes'] =
          packagesAttributes?.map((v) => v.toJson()).toList();
    }
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Images {
  Images({
    this.docId,
    this.fileLink,
  });

  Images.fromJson(dynamic json) {
    docId = json['docId'];
    fileLink = json['fileLink'];
  }
  num? docId;
  String? fileLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['docId'] = docId;
    map['fileLink'] = fileLink;
    return map;
  }
}

class PackagesAttributes {
  PackagesAttributes({
    this.autoId,
    this.attributeId,
    this.attributeName,
    this.typeId,
  });

  PackagesAttributes.fromJson(dynamic json) {
    autoId = json['autoId'];
    attributeId = json['attributeId'];
    attributeName = json['attributeName'];
    typeId = json['typeId'];
  }
  num? autoId;
  num? attributeId;
  String? attributeName;
  dynamic typeId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['autoId'] = autoId;
    map['attributeId'] = attributeId;
    map['attributeName'] = attributeName;
    map['typeId'] = typeId;
    return map;
  }
}

class SubProductPrices {
  SubProductPrices({
    this.autoId,
    this.name,
    this.price,
    this.details,
    this.priceLimit,
    this.priceType,
    this.priceCode,
    this.specialPrice,
  });

  SubProductPrices.fromJson(dynamic json) {
    autoId = json['autoId'];
    name = json['name'];
    price = json['price'];
    details = json['details'];
    priceLimit = json['priceLimit'];
    priceType = json['priceType'];
    priceCode = json['priceCode'];
    specialPrice = json['specialPrice'];
  }
  num? autoId;
  String? name;
  num? price;
  String? details;
  dynamic priceLimit;
  num? priceType;
  dynamic priceCode;
  dynamic specialPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['autoId'] = autoId;
    map['name'] = name;
    map['price'] = price;
    map['details'] = details;
    map['priceLimit'] = priceLimit;
    map['priceType'] = priceType;
    map['priceCode'] = priceCode;
    map['specialPrice'] = specialPrice;
    return map;
  }
}

class Service {
  Service({
    this.autoId,
    this.pkgName,
    this.engName,
    this.productId,
    this.productName,
    this.barCode,
    this.pkgNo,
    this.details,
    this.subPkgNo,
    this.subPkgName,
    this.height,
    this.weight,
    this.length,
    this.width,
    this.sku,
    this.upc,
    this.groupCode,
    this.guaranteePlan,
    this.guaranteePlaneName,
    this.metaWord,
    this.pointCategory,
    this.pointCategoryName,
    this.measureType,
    this.measureName,
    this.notifyQty,
    this.newPkg,
    this.specialPkg,
    this.isNew,
    this.isSale,
    this.isToInv,
    this.isPriceless,
    this.isMeasureMain,
    this.isShowInStore,
    this.notifyTime,
    this.notifySale,
    this.pic360,
    this.storeMetaData,
    this.filterValue,
    this.filterText,
    this.measureCount,
    this.mainPackageId,
    this.mainPackageName,
    this.code,
  });

  Service.fromJson(dynamic json) {
    autoId = json['autoId'];
    pkgName = json['pkgName'];
    engName = json['engName'];
    productId = json['productId'];
    productName = json['productName'];
    barCode = json['barCode'];
    pkgNo = json['pkgNo'];
    details = json['details'];
    subPkgNo = json['subPkgNo'];
    subPkgName = json['subPkgName'];
    height = json['height'];
    weight = json['weight'];
    length = json['length'];
    width = json['width'];
    sku = json['sku'];
    upc = json['upc'];
    groupCode = json['groupCode'];
    guaranteePlan = json['guaranteePlan'];
    guaranteePlaneName = json['guaranteePlaneName'];
    metaWord = json['metaWord'];
    pointCategory = json['pointCategory'];
    pointCategoryName = json['pointCategoryName'];
    measureType = json['measureType'];
    measureName = json['measureName'];
    notifyQty = json['notifyQty'];
    newPkg = json['newPkg'];
    specialPkg = json['specialPkg'];
    isNew = json['isNew'];
    isSale = json['isSale'];
    isToInv = json['isToInv'];
    isPriceless = json['isPriceless'];
    isMeasureMain = json['isMeasureMain'];
    isShowInStore = json['isShowInStore'];
    notifyTime = json['notifyTime'];
    notifySale = json['notifySale'];
    pic360 = json['pic360'];
    storeMetaData = json['storeMetaData'];
    filterValue = json['filterValue'];
    filterText = json['filterText'];
    measureCount = json['measureCount'];
    mainPackageId = json['mainPackageId'];
    mainPackageName = json['mainPackageName'];
    code = json['code'];
  }
  num? autoId;
  String? pkgName;
  String? engName;
  num? productId;
  String? productName;
  String? barCode;
  String? pkgNo;
  String? details;
  String? subPkgNo;
  String? subPkgName;
  dynamic height;
  dynamic weight;
  dynamic length;
  dynamic width;
  String? sku;
  String? upc;
  String? groupCode;
  dynamic guaranteePlan;
  dynamic guaranteePlaneName;
  String? metaWord;
  dynamic pointCategory;
  String? pointCategoryName;
  num? measureType;
  String? measureName;
  dynamic notifyQty;
  dynamic newPkg;
  dynamic specialPkg;
  dynamic isNew;
  bool? isSale;
  bool? isToInv;
  bool? isPriceless;
  bool? isMeasureMain;
  bool? isShowInStore;
  dynamic notifyTime;
  dynamic notifySale;
  String? pic360;
  String? storeMetaData;
  String? filterValue;
  String? filterText;
  num? measureCount;
  dynamic mainPackageId;
  dynamic mainPackageName;
  String? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['autoId'] = autoId;
    map['pkgName'] = pkgName;
    map['engName'] = engName;
    map['productId'] = productId;
    map['productName'] = productName;
    map['barCode'] = barCode;
    map['pkgNo'] = pkgNo;
    map['details'] = details;
    map['subPkgNo'] = subPkgNo;
    map['subPkgName'] = subPkgName;
    map['height'] = height;
    map['weight'] = weight;
    map['length'] = length;
    map['width'] = width;
    map['sku'] = sku;
    map['upc'] = upc;
    map['groupCode'] = groupCode;
    map['guaranteePlan'] = guaranteePlan;
    map['guaranteePlaneName'] = guaranteePlaneName;
    map['metaWord'] = metaWord;
    map['pointCategory'] = pointCategory;
    map['pointCategoryName'] = pointCategoryName;
    map['measureType'] = measureType;
    map['measureName'] = measureName;
    map['notifyQty'] = notifyQty;
    map['newPkg'] = newPkg;
    map['specialPkg'] = specialPkg;
    map['isNew'] = isNew;
    map['isSale'] = isSale;
    map['isToInv'] = isToInv;
    map['isPriceless'] = isPriceless;
    map['isMeasureMain'] = isMeasureMain;
    map['isShowInStore'] = isShowInStore;
    map['notifyTime'] = notifyTime;
    map['notifySale'] = notifySale;
    map['pic360'] = pic360;
    map['storeMetaData'] = storeMetaData;
    map['filterValue'] = filterValue;
    map['filterText'] = filterText;
    map['measureCount'] = measureCount;
    map['mainPackageId'] = mainPackageId;
    map['mainPackageName'] = mainPackageName;
    map['code'] = code;
    return map;
  }
}
