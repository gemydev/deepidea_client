import 'dart:convert';

GetPackagesFromPackageBundleResponse
getPackagesFromPackageBundleResponseFromJson(String str) =>
    GetPackagesFromPackageBundleResponse.fromJson(json.decode(str));

String getPackagesFromPackageBundleResponseToJson(
  GetPackagesFromPackageBundleResponse data,
) => json.encode(data.toJson());

class GetPackagesFromPackageBundleResponse {
  final int? statusCode;
  final String? message;
  final List<PackageBundleItem>? result;

  GetPackagesFromPackageBundleResponse({
    this.statusCode,
    this.message,
    this.result,
  });

  factory GetPackagesFromPackageBundleResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return GetPackagesFromPackageBundleResponse(
      statusCode: json["statusCode"] as int?,
      message: json["message"] as String?,
      result: json["result"] == null
          ? []
          : List<PackageBundleItem>.from(
              (json["result"] as List).map(
                (x) => PackageBundleItem.fromJson(x),
              ),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "result": result == null
        ? []
        : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class PackageBundleItem {
  final num? cost;
  final num? estimatedCost;
  final num? discount;
  final int? packageId;
  final String? packageName;
  final num? quantity;
  final num? taxRate;
  final num? unitPrice;
  final num? totalPrice;
  final int? executionTime;
  final List<String>? images;
  final String? unit;
  final num? usedQty;
  final num? availableQty;

  PackageBundleItem({
    this.cost,
    this.estimatedCost,
    this.discount,
    this.packageId,
    this.packageName,
    this.quantity,
    this.taxRate,
    this.unitPrice,
    this.totalPrice,
    this.executionTime,
    this.images,
    this.unit,
    this.usedQty,
    this.availableQty,
  });

  factory PackageBundleItem.fromJson(Map<String, dynamic> json) {
    return PackageBundleItem(
      cost: _toNum(json["cost"]),
      estimatedCost: _toNum(json["estimatedCost"]),
      discount: _toNum(json["discount"]),
      packageId: _toInt(json["packageID"]),
      packageName: json["packageName"] as String?,
      quantity: _toNum(json["quantity"]),
      taxRate: _toNum(json["taxRate"]),
      unitPrice: _toNum(json["unitPrice"]),
      totalPrice: _toNum(json["totalPrice"]),
      executionTime: _toInt(json["executionTime"]),
      images: json["images"] == null
          ? []
          : List<String>.from(
              (json["images"] as List)
                  .map((x) => x?.toString() ?? '')
                  .where((x) => x.isNotEmpty),
            ),
      unit: json["unit"] as String?,
      usedQty: _toNum(json["usedQty"]),
      availableQty: _toNum(json["availableQty"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "cost": cost,
    "estimatedCost": estimatedCost,
    "discount": discount,
    "packageID": packageId,
    "packageName": packageName,
    "quantity": quantity,
    "taxRate": taxRate,
    "unitPrice": unitPrice,
    "totalPrice": totalPrice,
    "executionTime": executionTime,
    "images": images == null ? [] : List<dynamic>.from(images!),
    "unit": unit,
    "usedQty": usedQty,
    "availableQty": availableQty,
  };

  static num? _toNum(dynamic value) {
    if (value == null) return null;
    if (value is num) return value;
    if (value is String) return num.tryParse(value);
    return null;
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }
}
