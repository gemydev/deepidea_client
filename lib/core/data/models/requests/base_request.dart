// userId : 0
// op : 0

class BaseRequestWithUserId {
  BaseRequestWithUserId({
      this.userId, 
      this.op,});

  BaseRequestWithUserId.fromJson(dynamic json) {
    userId = json['userId'];
    op = json['op'];
  }
  num? userId;
  num? op;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['op'] = op;
    return map;
  }

}