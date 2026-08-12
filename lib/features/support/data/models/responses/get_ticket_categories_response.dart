class GetTicketCategoriesResponse {
  GetTicketCategoriesResponse({
      this.statusCode, 
      this.message, 
      this.result,});

  GetTicketCategoriesResponse.fromJson(dynamic json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(Result.fromJson(v));
      });
    }
  }
  num? statusCode;
  String? message;
  List<Result>? result;

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

class Result {
  Result({
      this.categoryId, 
      this.categoryName, 
      this.isMain, 
      this.parentId, 
      this.parentName, 
      this.details,});

  Result.fromJson(dynamic json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    isMain = json['isMain'];
    parentId = json['parentId'];
    code = json['code'];
    parentName = json['parentName'];
    details = json['details'];
  }
  num? categoryId;
  String? categoryName;
  bool? isMain;
  dynamic parentId;
  dynamic code;
  dynamic parentName;
  String? details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryId'] = categoryId;
    map['categoryName'] = categoryName;
    map['isMain'] = isMain;
    map['parentId'] = parentId;
    map['code'] = code;
    map['parentName'] = parentName;
    map['details'] = details;
    return map;
  }

}