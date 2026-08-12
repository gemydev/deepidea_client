class ClientSubscriptionStatusResponse {
  ClientSubscriptionStatusResponse({
    this.statusCode,
    this.statusMessage,
    this.clientId,
    this.clientName,
    this.subscriptionStartDate,
    this.subscriptionEndDate,
    this.isSubscriptionActive = false,
    this.remainingDays,
  });

  ClientSubscriptionStatusResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage']?.toString();
    clientId = json['clientId'];
    clientName = json['clientName']?.toString();
    subscriptionStartDate = json['subscriptionStartDate']?.toString();
    subscriptionEndDate = json['subscriptionEndDate']?.toString();
    isSubscriptionActive = json['isSubscriptionActive'] == true;
    remainingDays = json['remainingDays'];
  }

  num? statusCode;
  String? statusMessage;
  num? clientId;
  String? clientName;
  String? subscriptionStartDate;
  String? subscriptionEndDate;
  bool isSubscriptionActive = false;
  num? remainingDays;

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'statusMessage': statusMessage,
      'clientId': clientId,
      'clientName': clientName,
      'subscriptionStartDate': subscriptionStartDate,
      'subscriptionEndDate': subscriptionEndDate,
      'isSubscriptionActive': isSubscriptionActive,
      'remainingDays': remainingDays,
    };
  }
}
