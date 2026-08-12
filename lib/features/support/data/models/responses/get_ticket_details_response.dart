class GetTicketDetailsResponse {
  final int statusCode;
  final String message;
  final TicketDetails result;

  GetTicketDetailsResponse({
    required this.statusCode,
    required this.message,
    required this.result,
  });

  factory GetTicketDetailsResponse.fromJson(dynamic json) {
    return GetTicketDetailsResponse(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      result: TicketDetails.fromJson(json['result'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
      'result': result.toJson(),
    };
  }
}

class TicketDetails {
  final int ticketId;
  final String ticketCode;

  final int clientId;
  final String clientName;
  final int adminId;
  final String adminName;

  final String subject;
  final String message;
  final String briefMsg;

  final int statusId;
  final String statusName;

  final int importanceId;
  final String importanceName;

  final int websiteId;
  final String websiteName;

  final int levelId;
  final String levelName;

  final int createdBy;
  final String createdDate;
  final int updatedBy;
  final String updatedDate;

  // category fields
  final int categoryId;
  final String categoryName;
  final bool isMain;
  final bool isShow;
  final String parentCategory;
  final String details;

  final List<FileItem> files;

  TicketDetails({
    required this.ticketId,
    required this.ticketCode,
    required this.clientId,
    required this.clientName,
    required this.adminId,
    required this.adminName,
    required this.subject,
    required this.message,
    required this.briefMsg,
    required this.statusId,
    required this.statusName,
    required this.importanceId,
    required this.importanceName,
    required this.websiteId,
    required this.websiteName,
    required this.levelId,
    required this.levelName,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
    required this.categoryId,
    required this.categoryName,
    required this.isMain,
    required this.isShow,
    required this.parentCategory,
    required this.details,
    required this.files,
  });

  factory TicketDetails.fromJson(Map<String, dynamic> json) {
    return TicketDetails(
      ticketId: json['ticketId'] ?? 0,
      ticketCode: json['ticketCode'] ?? '',
      clientId: json['clientId'] ?? 0,
      clientName: json['clientName']?.toString() ?? '',
      adminId: json['adminId'] ?? 0,
      adminName: json['adminName']?.toString() ?? '',
      subject: json['subject'] ?? '',
      message: json['message'] ?? '',
      briefMsg: json['briefMsg'] ?? '',
      statusId: json['statusId'] ?? 0,
      statusName: json['statusName'] ?? '',
      importanceId: json['importanceId'] ?? 0,
      importanceName: json['importanceName'] ?? '',
      websiteId: json['websiteId'] ?? 0,
      websiteName: json['websiteName'] ?? '',
      levelId: json['levelId'] ?? 0,
      levelName: json['levelName'] ?? '',
      createdBy: json['createdBy'] ?? 0,
      createdDate: json['createdDate'] ?? '',
      updatedBy: json['updatedBy'] ?? 0,
      updatedDate: json['updatedDate'] ?? '',
      categoryId: json['categoryId'] ?? 0,
      categoryName: json['categoryName'] ?? '',
      isMain: json['isMain'] ?? false,
      isShow: json['isshow'] ?? false,
      parentCategory: json['parentCategory'] ?? '',
      details: json['details'] ?? '',
      files: (json['files'] as List<dynamic>? ?? [])
          .map((e) => FileItem.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'ticketCode': ticketCode,
      'clientId': clientId,
      'clientName': clientName,
      'adminId': adminId,
      'adminName': adminName,
      'subject': subject,
      'message': message,
      'briefMsg': briefMsg,
      'statusId': statusId,
      'statusName': statusName,
      'importanceId': importanceId,
      'importanceName': importanceName,
      'websiteId': websiteId,
      'websiteName': websiteName,
      'levelId': levelId,
      'levelName': levelName,
      'createdBy': createdBy,
      'createdDate': createdDate,
      'updatedBy': updatedBy,
      'updatedDate': updatedDate,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'isMain': isMain,
      'isshow': isShow,
      'parentCategory': parentCategory,
      'details': details,
      'files': files.map((e) => e.toJson()).toList(),
    };
  }
}

class FileItem {
  final int fileId;
  final int docId;
  final String fileUrl;

  FileItem({
    required this.fileId,
    required this.docId,
    required this.fileUrl,
  });

  factory FileItem.fromJson(Map<String, dynamic> json) {
    return FileItem(
      fileId: json['fileId'] ?? 0,
      docId: json['docId'] ?? 0,
      fileUrl: json['fileUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileId': fileId,
      'docId': docId,
      'fileUrl': fileUrl,
    };
  }
}
