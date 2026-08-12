class BaseHeader {
  BaseHeader({
    this.authKey,
  });

  BaseHeader.fromJson(dynamic json) {
    authKey = json['auth_key'];
  }

  String? authKey;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['auth_key'] = authKey;
    return map;
  }
}
