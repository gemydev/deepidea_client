// auth_key : "GOOOBIG-5cce7357-7d94-4601-b6e6-551a8ffb0d58-TP-2022-43-04-16-22-59"
// latestUpdate : "6/28/2000 9:00 PM"
// invertoryId : 5220

class BaseHeaderWithInventoryId {
  BaseHeaderWithInventoryId({
      this.authKey, 
      this.latestUpdate, 
      this.invertoryId,});

  BaseHeaderWithInventoryId.fromJson(dynamic json) {
    authKey = json['auth_key'];
    latestUpdate = json['latestUpdate'];
    invertoryId = json['invertoryId'];
  }
  String? authKey;
  String? latestUpdate;
  num? invertoryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['auth_key'] = authKey;
    map['latestUpdate'] = latestUpdate;
    map['invertoryId'] = invertoryId;
    return map;
  }

}