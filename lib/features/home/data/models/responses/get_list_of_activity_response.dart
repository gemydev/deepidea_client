class GetListOfActivityResponse {
  GetListOfActivityResponse({
      this.statusCode, 
      this.message, 
      this.result,});

  GetListOfActivityResponse.fromJson(dynamic json) {
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
      this.autoId, 
      this.name, 
      this.webId, 
      this.favoritePackageId, 
      this.activityIcons, 
      this.activityLink, 
      this.details, 
      this.isTrash, 
      this.isActive, 
      this.createdBy, 
      this.createdDate, 
      this.updatedBy, 
      this.updatedDate, 
      this.orderBy, 
      this.websiteId,});

  Result.fromJson(dynamic json) {
    autoId = json['autoId'];
    name = json['name'];
    webId = json['webId'];
    favoritePackageId = json['favoritePackageId'];
    activityIcons = json['activityIcons'];
    activityLink = json['activityLink'];
    details = json['details'];
    isTrash = json['isTrash'];
    isActive = json['isActive'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'];
    orderBy = json['orderBy'];
    websiteId = json['websiteId'];
  }
  num? autoId;
  String? name;
  num? webId;
  num? favoritePackageId;
  String? activityIcons;
  String? activityLink;
  String? details;
  bool? isTrash;
  bool? isActive;
  num? createdBy;
  String? createdDate;
  num? updatedBy;
  String? updatedDate;
  dynamic orderBy;
  num? websiteId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['autoId'] = autoId;
    map['name'] = name;
    map['webId'] = webId;
    map['favoritePackageId'] = favoritePackageId;
    map['activityIcons'] = activityIcons;
    map['activityLink'] = activityLink;
    map['details'] = details;
    map['isTrash'] = isTrash;
    map['isActive'] = isActive;
    map['createdBy'] = createdBy;
    map['createdDate'] = createdDate;
    map['updatedBy'] = updatedBy;
    map['updatedDate'] = updatedDate;
    map['orderBy'] = orderBy;
    map['websiteId'] = websiteId;
    return map;
  }

}