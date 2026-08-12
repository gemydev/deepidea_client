class GetRegisteredServicesAndPackagesResponse {
  final int? statusCode;
  final String? message;
  final RegisteredResult? result;

  GetRegisteredServicesAndPackagesResponse({
    this.statusCode,
    this.message,
    this.result,
  });

  factory GetRegisteredServicesAndPackagesResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return GetRegisteredServicesAndPackagesResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      result: json['result'] != null
          ? RegisteredResult.fromJson(json['result'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'message': message,
    'result': result?.toJson(),
  };
}

class RegisteredResult {
  final List<ServiceOrPackage> bundles;
  final List<ServiceOrPackage> services;

  RegisteredResult({required this.bundles, required this.services});

  factory RegisteredResult.fromJson(Map<String, dynamic> json) {
    return RegisteredResult(
      bundles: json['bundles'] != null
          ? List<ServiceOrPackage>.from(
              json['bundles'].map(
                (x) => ServiceOrPackage.fromJson(x, isBundle: true),
              ),
            )
          : [],
      services: json['services'] != null
          ? List<ServiceOrPackage>.from(
              json['services'].map(
                (x) => ServiceOrPackage.fromJson(x, isBundle: false),
              ),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
    'bundles': bundles.map((x) => x.toJson()).toList(),
    'services': services.map((x) => x.toJson()).toList(),
  };
}

class ServiceOrPackage {
  final int? id;
  final String? name;
  final List<String> images;
  final int? invoiceId;
  final bool isBundle;

  ServiceOrPackage({
    this.id,
    this.name,
    required this.images,
    this.invoiceId,
    required this.isBundle,
  });

  factory ServiceOrPackage.fromJson(
    Map<String, dynamic> json, {
    required bool isBundle,
  }) {
    return ServiceOrPackage(
      id: json['id'],
      name: json['name'],
      invoiceId: json['invoiceId'],
      isBundle: isBundle,
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : <String>[],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'images': images,
    'invoiceId': invoiceId,
    'isBundle': isBundle,
  };
}
