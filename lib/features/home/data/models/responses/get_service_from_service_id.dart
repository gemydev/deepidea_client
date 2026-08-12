class GetServiceFromServiceIdResponse {
  GetServiceFromServiceIdResponse({this.statusCode, this.message, this.result});

  num? statusCode;
  String? message;
  ServiceResult? result;

  GetServiceFromServiceIdResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    result = json['result'] != null
        ? ServiceResult.fromJson(json['result'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = statusCode;
    map['message'] = message;
    map['result'] = result?.toJson();
    return map;
  }
}

class ServiceResult {
  ServiceResult({
    this.cost,
    this.estimatedCost,
    this.discount,
    this.packageID,
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

  num? cost;
  num? estimatedCost;
  num? discount;
  num? packageID;
  String? packageName;
  num? quantity;
  num? taxRate;
  num? unitPrice;
  num? totalPrice;
  num? executionTime;
  dynamic images;
  String? unit;
  num? usedQty;
  num? availableQty;

  ServiceResult.fromJson(Map<String, dynamic> json) {
    cost = json['cost'];
    estimatedCost = json['estimatedCost'];
    discount = json['discount'];
    packageID = json['packageID'];
    packageName = json['packageName'];
    quantity = json['quantity'];
    taxRate = json['taxRate'];
    unitPrice = json['unitPrice'];
    totalPrice = json['totalPrice'];
    executionTime = json['executionTime'];
    images = json['images'];
    unit = json['unit'];
    usedQty = json['usedQty'];
    availableQty = json['availableQty'];
  }

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
    map['executionTime'] = executionTime;
    map['images'] = images;
    map['unit'] = unit;
    map['usedQty'] = usedQty;
    map['availableQty'] = availableQty;
    return map;
  }
}
