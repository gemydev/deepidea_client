// username : 1556
// password : 1556

class LoginRequest {
  LoginRequest({
    this.username,
    this.password,
    this.lang,
    this.siteID,
  });

  LoginRequest.fromJson(dynamic json) {
    username = json['username'];
    password = json['password'];
  }

  @override
  String toString() {
    return 'LoginRequest{username: $username, password: $password, lang: $lang, siteID: $siteID,}';
  }

  String? username;
  String? password;
  String? lang;
  String? siteID;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['password'] = password;
    return map;
  }
}
