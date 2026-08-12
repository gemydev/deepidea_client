// auth_key : "GOOOBIG-5cce7357-7d94-4601-b6e6-551a8ffb0d58-TP-2022-43-04-16-22-59"
// latestUpdate : "6/28/2020 9:00 PM"

class BaseHeaderWithUpdate {
  BaseHeaderWithUpdate({
    this.authKey,
    this.latestUpdate,
  });

  BaseHeaderWithUpdate.fromJson(dynamic json) {
    authKey = json['auth_key'];
    latestUpdate = json['latestUpdate'];
  }

  String? authKey;
  String? latestUpdate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['auth_key'] = authKey;
    map['latestUpdate'] = latestUpdate;
    return map;
  }
}
