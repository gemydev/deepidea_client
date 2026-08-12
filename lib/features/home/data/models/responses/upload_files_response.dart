import 'dart:convert';

UploadFilesResponse uploadFilesResponseFromJson(String str) =>
    UploadFilesResponse.fromJson(json.decode(str));

String uploadFilesResponseToJson(UploadFilesResponse data) =>
    json.encode(data.toJson());

class UploadFilesResponse {
  UploadFilesResponse({
    this.statusCode,
    this.message,
    this.result,
  });

  UploadFilesResponse.fromJson(dynamic json) {
    statusCode = json['statusCode'];
    message = json['message'];
    result = json['result'] != null ? json['result'].cast<int>() : [];
  }

  int? statusCode;
  String? message;
  List<int>? result;

  UploadFilesResponse copyWith({
    int? statusCode,
    String? message,
    List<int>? result,
  }) =>
      UploadFilesResponse(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        result: result ?? this.result,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = statusCode;
    map['message'] = message;
    map['result'] = result;
    return map;
  }
}
