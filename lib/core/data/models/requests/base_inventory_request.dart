// userId : 0
// op : 0

class BaseRequestWithInventoryId {
  BaseRequestWithInventoryId({
    this.inventoryId,
    this.op,
  });

  BaseRequestWithInventoryId.fromJson(dynamic json) {
    inventoryId = json['userId'];
    op = json['op'];
  }
  num? inventoryId;
  num? op;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = inventoryId;
    map['op'] = op;
    return map;
  }
}
