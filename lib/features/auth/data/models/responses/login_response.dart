class LoginResponse {
  LoginResponse({
    this.statusCode,
    this.statusMessage,
    this.storeName,
    this.authKey,
    this.logoLink,
    this.backgroundLink,
    this.invCode,
    this.userID,
    this.standardColor,
    this.websiteid,
    this.authkeyAdmin,
    this.clientName,
    this.clientEmail,
    this.clientPhoneNumber,
    this.clientAddress,
  });

  LoginResponse.fromJson(dynamic json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    storeName = json['storeName'];
    authKey = json['auth_key'];
    invCode = json['invCode'];
    userID = json['userID'];
    standardColor = json['standardColor'];
    websiteid = json['websiteid'];
    authkeyAdmin = json['authkeyAdmin'];
    clientName = json['clientName'];
    clientEmail = json['clientEmail'];
    clientPhoneNumber = json['clientPhoneNumber'];
    clientAddress = json['clientAddress'];
  }

  @override
  String toString() {
    return 'LoginResponse{statusCode: $statusCode, statusMessage: $statusMessage, storeName: $storeName, authKey: $authKey, logoLink: $logoLink, backgroundLink: $backgroundLink, invCode: $invCode, userID: $userID, standardColor: $standardColor, websiteid: $websiteid, authkeyAdmin: $authkeyAdmin, clientEmail: $clientEmail, clientPhoneNumber: $clientPhoneNumber, clientAddress: $clientAddress}';
  }

  num? statusCode;
  dynamic statusMessage;
  String? storeName;
  String? authKey;
  String? logoLink;
  String? backgroundLink;
  String? invCode;
  String? userID;
  String? standardColor;
  num? websiteid;
  String? authkeyAdmin;
  String? clientName;
  String? clientEmail;
  String? clientPhoneNumber;
  String? clientAddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = statusCode;
    map['statusMessage'] = statusMessage;
    map['storeName'] = storeName;
    map['auth_key'] = authKey;
    map['invCode'] = invCode;
    map['userID'] = userID;
    map['standardColor'] = standardColor;
    map['websiteid'] = websiteid;
    map['authkeyAdmin'] = authkeyAdmin;
    map['clientName'] = clientName;
    map['clientEmail'] = clientEmail;
    map['clientPhoneNumber'] = clientPhoneNumber;
    map['clientAddress'] = clientAddress;
    return map;
  }
}
