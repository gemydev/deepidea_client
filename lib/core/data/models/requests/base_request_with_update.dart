import '../headers/base_header_with_update.dart';

/// userId : 23605

class BaseRequestWithUpdate {
  BaseRequestWithUpdate({
    this.userId,
    this.op,
    this.baseHeaderWithUpdate
  });

  BaseRequestWithUpdate.fromJson(dynamic json) {
    userId = json['userId'];
  }

  num? userId;
  int? op;
  BaseHeaderWithUpdate? baseHeaderWithUpdate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    return map;
  }
}
