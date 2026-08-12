import '../headers/base_header.dart';

/// inventoryId : 23605

class BaseRequestWithInvertoryId {
  BaseRequestWithInvertoryId({
    this.inventoryId,
  });

  BaseRequestWithInvertoryId.fromJson(dynamic json) {
    inventoryId = json['inventoryId'];
  }

  num? inventoryId;
  BaseHeader? baseHeader;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['inventoryId'] = inventoryId;
    return map;
  }
}
