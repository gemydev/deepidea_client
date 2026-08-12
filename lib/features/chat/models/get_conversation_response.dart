class GetConversationResponse {
  GetConversationResponse({
      this.autoId, 
      this.lastMessageTime, 
      this.user1, 
      this.user2, 
      this.messages,});

  GetConversationResponse.fromJson(dynamic json) {
    autoId = json['autoId'];
    lastMessageTime = json['lastMessageTime'];
    user1 = json['user1'] != null ? User1.fromJson(json['user1']) : null;
    user2 = json['user2'] != null ? User2.fromJson(json['user2']) : null;
    if (json['messages'] != null) {
      messages = [];
      json['messages'].forEach((v) {
        messages?.add(Messages.fromJson(v));
      });
    }
  }
  num? autoId;
  String? lastMessageTime;
  User1? user1;
  User2? user2;
  List<Messages>? messages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['autoId'] = autoId;
    map['lastMessageTime'] = lastMessageTime;
    if (user1 != null) {
      map['user1'] = user1?.toJson();
    }
    if (user2 != null) {
      map['user2'] = user2?.toJson();
    }
    if (messages != null) {
      map['messages'] = messages?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Messages {
  Messages({
      this.autoId, 
      this.senderId, 
      this.receiverId, 
      this.content, 
      this.timestamp, 
      this.isRead, 
      this.sender, 
      this.receiver,});

  Messages.fromJson(dynamic json) {
    autoId = json['autoId'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    content = json['content'];
    timestamp = json['timestamp'];
    isRead = json['isRead'];
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    receiver = json['receiver'] != null ? Receiver.fromJson(json['receiver']) : null;
  }
  num? autoId;
  num? senderId;
  num? receiverId;
  String? content;
  String? timestamp;
  bool? isRead;
  Sender? sender;
  Receiver? receiver;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['autoId'] = autoId;
    map['senderId'] = senderId;
    map['receiverId'] = receiverId;
    map['content'] = content;
    map['timestamp'] = timestamp;
    map['isRead'] = isRead;
    if (sender != null) {
      map['sender'] = sender?.toJson();
    }
    if (receiver != null) {
      map['receiver'] = receiver?.toJson();
    }
    return map;
  }

}

class Receiver {
  Receiver({
      this.autoId, 
      this.name, 
      this.profilePicture,});

  Receiver.fromJson(dynamic json) {
    autoId = json['autoId'];
    name = json['name'];
    profilePicture = json['profilePicture'];
  }
  num? autoId;
  String? name;
  dynamic profilePicture;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['autoId'] = autoId;
    map['name'] = name;
    map['profilePicture'] = profilePicture;
    return map;
  }

}

class Sender {
  Sender({
      this.autoId, 
      this.name, 
      this.profilePicture,});

  Sender.fromJson(dynamic json) {
    autoId = json['autoId'];
    name = json['name'];
    profilePicture = json['profilePicture'];
  }
  num? autoId;
  String? name;
  dynamic profilePicture;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['autoId'] = autoId;
    map['name'] = name;
    map['profilePicture'] = profilePicture;
    return map;
  }

}

class User2 {
  User2({
      this.autoId, 
      this.name, 
      this.profilePicture,});

  User2.fromJson(dynamic json) {
    autoId = json['autoId'];
    name = json['name'];
    profilePicture = json['profilePicture'];
  }
  num? autoId;
  String? name;
  dynamic profilePicture;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['autoId'] = autoId;
    map['name'] = name;
    map['profilePicture'] = profilePicture;
    return map;
  }

}

class User1 {
  User1({
      this.autoId, 
      this.name, 
      this.profilePicture,});

  User1.fromJson(dynamic json) {
    autoId = json['autoId'];
    name = json['name'];
    profilePicture = json['profilePicture'];
  }
  num? autoId;
  String? name;
  dynamic profilePicture;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['autoId'] = autoId;
    map['name'] = name;
    map['profilePicture'] = profilePicture;
    return map;
  }

}