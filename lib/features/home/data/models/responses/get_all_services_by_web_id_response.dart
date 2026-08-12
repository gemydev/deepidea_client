import 'dart:convert';

GetAllServicesByWebIdResponse getAllServicesByWebIdResponseFromJson(
        String str) =>
    GetAllServicesByWebIdResponse.fromJson(json.decode(str));

String getAllServicesByWebIdResponseToJson(
        GetAllServicesByWebIdResponse data) =>
    json.encode(data.toJson());

class GetAllServicesByWebIdResponse {
  final int? statusCode;
  final String? message;
  final List<ServiceItem>? result;

  GetAllServicesByWebIdResponse({
    this.statusCode,
    this.message,
    this.result,
  });

  factory GetAllServicesByWebIdResponse.fromJson(Map<String, dynamic> json) =>
      GetAllServicesByWebIdResponse(
        statusCode: json["statusCode"],
        message: json["message"],
        result: json["result"] == null
            ? []
            : List<ServiceItem>.from(
                json["result"].map((x) => ServiceItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };

  GetAllServicesByWebIdResponse copyWith({
    int? statusCode,
    String? message,
    List<ServiceItem>? result,
  }) {
    return GetAllServicesByWebIdResponse(
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      result: result ?? this.result,
    );
  }
}

// ----------------------------------------------------------------------
// 📦 ServiceItem
// ----------------------------------------------------------------------

class ServiceItem {
  final Service? service;
  final List<dynamic>? packagesAttributes;
  final List<SubProductPrice>? subProductPrices;
  final List<ImageItem>? images;
  final int quantity;

  ServiceItem({
    this.service,
    this.packagesAttributes,
    this.subProductPrices,
    this.images,
    this.quantity = 1,
  });

  factory ServiceItem.fromJson(Map<String, dynamic> json) => ServiceItem(
        service:
            json["service"] == null ? null : Service.fromJson(json["service"]),
        packagesAttributes: json["packagesAttributes"] == null
            ? []
            : List<dynamic>.from(json["packagesAttributes"].map((x) => x)),
        subProductPrices: json["subProductPrices"] == null
            ? []
            : List<SubProductPrice>.from(json["subProductPrices"]
                .map((x) => SubProductPrice.fromJson(x))),
        images: json["images"] == null
            ? []
            : List<ImageItem>.from(
                json["images"].map((x) => ImageItem.fromJson(x))),
        quantity: json["quantity"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
        "service": service?.toJson(),
        "packagesAttributes": packagesAttributes == null
            ? []
            : List<dynamic>.from(packagesAttributes!.map((x) => x)),
        "subProductPrices": subProductPrices == null
            ? []
            : List<dynamic>.from(subProductPrices!.map((x) => x.toJson())),
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "quantity": quantity,
      };

  ServiceItem copyWith({
    Service? service,
    List<dynamic>? packagesAttributes,
    List<SubProductPrice>? subProductPrices,
    List<ImageItem>? images,
    int? quantity,
  }) {
    return ServiceItem(
      service: service ?? this.service,
      packagesAttributes: packagesAttributes ?? this.packagesAttributes,
      subProductPrices: subProductPrices ?? this.subProductPrices,
      images: images ?? this.images,
      quantity: quantity ?? this.quantity,
    );
  }
}

// ----------------------------------------------------------------------
// 🧩 Service
// ----------------------------------------------------------------------

class Service {
  final int? autoId;
  final String? pkgName;
  final String? engName;
  final int? productId;
  final String? productName;
  final String? details;
  final String? subPkgNo;
  final String? subPkgName;
  final int? measureType;
  final String? measureName;
  final bool? isSale;
  final bool? isToInv;
  final bool? isPriceless;
  final bool? isMeasureMain;
  final bool? isShowInStore;
  final int? measureCount;
  final bool? specialPkg;
  final int? notifyQty;
  final String? pointCategoryName;

  Service({
    this.autoId,
    this.pkgName,
    this.engName,
    this.productId,
    this.productName,
    this.details,
    this.subPkgNo,
    this.subPkgName,
    this.measureType,
    this.measureName,
    this.isSale,
    this.isToInv,
    this.isPriceless,
    this.isMeasureMain,
    this.isShowInStore,
    this.measureCount,
    this.specialPkg,
    this.notifyQty,
    this.pointCategoryName,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        autoId: json["autoId"],
        pkgName: json["pkgName"],
        engName: json["engName"],
        productId: json["productId"],
        productName: json["productName"],
        details: json["details"],
        subPkgNo: json["subPkgNo"],
        subPkgName: json["subPkgName"],
        measureType: json["measureType"],
        measureName: json["measureName"],
        isSale: json["isSale"],
        isToInv: json["isToInv"],
        isPriceless: json["isPriceless"],
        isMeasureMain: json["isMeasureMain"],
        isShowInStore: json["isShowInStore"],
        measureCount: json["measureCount"],
        specialPkg: json["specialPkg"],
        notifyQty: json["notifyQty"],
        pointCategoryName: json["pointCategoryName"],
      );

  Map<String, dynamic> toJson() => {
        "autoId": autoId,
        "pkgName": pkgName,
        "engName": engName,
        "productId": productId,
        "productName": productName,
        "details": details,
        "subPkgNo": subPkgNo,
        "subPkgName": subPkgName,
        "measureType": measureType,
        "measureName": measureName,
        "isSale": isSale,
        "isToInv": isToInv,
        "isPriceless": isPriceless,
        "isMeasureMain": isMeasureMain,
        "isShowInStore": isShowInStore,
        "measureCount": measureCount,
        "specialPkg": specialPkg,
        "notifyQty": notifyQty,
        "pointCategoryName": pointCategoryName,
      };

  Service copyWith({
    int? autoId,
    String? pkgName,
    String? engName,
    int? productId,
    String? productName,
    String? details,
    String? subPkgNo,
    String? subPkgName,
    int? measureType,
    String? measureName,
    bool? isSale,
    bool? isToInv,
    bool? isPriceless,
    bool? isMeasureMain,
    bool? isShowInStore,
    int? measureCount,
    bool? specialPkg,
    int? notifyQty,
    String? pointCategoryName,
  }) {
    return Service(
      autoId: autoId ?? this.autoId,
      pkgName: pkgName ?? this.pkgName,
      engName: engName ?? this.engName,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      details: details ?? this.details,
      subPkgNo: subPkgNo ?? this.subPkgNo,
      subPkgName: subPkgName ?? this.subPkgName,
      measureType: measureType ?? this.measureType,
      measureName: measureName ?? this.measureName,
      isSale: isSale ?? this.isSale,
      isToInv: isToInv ?? this.isToInv,
      isPriceless: isPriceless ?? this.isPriceless,
      isMeasureMain: isMeasureMain ?? this.isMeasureMain,
      isShowInStore: isShowInStore ?? this.isShowInStore,
      measureCount: measureCount ?? this.measureCount,
      specialPkg: specialPkg ?? this.specialPkg,
      notifyQty: notifyQty ?? this.notifyQty,
      pointCategoryName: pointCategoryName ?? this.pointCategoryName,
    );
  }
}

// ----------------------------------------------------------------------
// 💰 SubProductPrice
// ----------------------------------------------------------------------

class SubProductPrice {
  final int? autoId;
  final String? name;
  final double? price;
  final String? details;

  SubProductPrice({
    this.autoId,
    this.name,
    this.price,
    this.details,
  });

  factory SubProductPrice.fromJson(Map<String, dynamic> json) =>
      SubProductPrice(
        autoId: json["autoId"],
        name: json["name"],
        price: (json["price"] as num?)?.toDouble(),
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "autoId": autoId,
        "name": name,
        "price": price,
        "details": details,
      };

  SubProductPrice copyWith({
    int? autoId,
    String? name,
    double? price,
    String? details,
  }) {
    return SubProductPrice(
      autoId: autoId ?? this.autoId,
      name: name ?? this.name,
      price: price ?? this.price,
      details: details ?? this.details,
    );
  }
}

// ----------------------------------------------------------------------
// 🖼️ ImageItem
// ----------------------------------------------------------------------

class ImageItem {
  final int? docId;
  final String? fileLink;

  ImageItem({
    this.docId,
    this.fileLink,
  });

  factory ImageItem.fromJson(Map<String, dynamic> json) => ImageItem(
        docId: json["docId"],
        fileLink: json["fileLink"],
      );

  Map<String, dynamic> toJson() => {
        "docId": docId,
        "fileLink": fileLink,
      };

  ImageItem copyWith({
    int? docId,
    String? fileLink,
  }) {
    return ImageItem(
      docId: docId ?? this.docId,
      fileLink: fileLink ?? this.fileLink,
    );
  }
}
