class PostInvoicesWithConfirmRequest {
  String? invoiceCode;
  String? priceCode;
  String? businessName;
  String? taxNumber;
  String? commercialRegister;
  int? invoiceType;
  int? packageBundleId;
  int? salesmanId;
  dynamic supplierNumber;
  int? invoicesStatus;
  String? createdDate;
  String? deliveryTime;
  int? inventoryId;
  String? invoiceDetails;
  int? shippingStatus;
  int? paymentType;
  int? shippingPackageId;
  double? shippingPrice;
  int? userId;
  int? websiteId;
  dynamic shiftId;
  String? clientName;
  String? clientPhone;
  String? clientEmail;
  String? clientAccountNo;
  String? clientAddress;
  String? clientCode;
  List<dynamic>? recievedInvoiceSummary;
  List<RecievedInvoiceProduct>? recievedInvoiceProducts;
  List<RecievedInvoiceTax>? recievedInvoiceTax;
  List<dynamic>? recievedInvoiceServices;
  List<RecievedInvoicePaymentType>? recievedInvoicePaymentType;

  PostInvoicesWithConfirmRequest({
    this.invoiceCode,
    this.priceCode,
    this.businessName,
    this.taxNumber,
    this.commercialRegister,
    this.invoiceType,
    this.salesmanId,
    this.supplierNumber,
    this.invoicesStatus,
    this.createdDate,
    this.deliveryTime,
    this.inventoryId,
    this.invoiceDetails,
    this.shippingStatus,
    this.paymentType,
    this.shippingPackageId,
    this.shippingPrice,
    this.userId,
    this.websiteId,
    this.shiftId,
    this.clientName,
    this.clientPhone,
    this.clientEmail,
    this.clientAccountNo,
    this.clientAddress,
    this.clientCode,
    this.recievedInvoiceSummary,
    this.recievedInvoiceProducts,
    this.recievedInvoiceTax,
    this.recievedInvoiceServices,
    this.recievedInvoicePaymentType,
    this.packageBundleId
  });

  factory PostInvoicesWithConfirmRequest.fromJson(Map<String, dynamic> json) {
    return PostInvoicesWithConfirmRequest(
      invoiceCode: json['InvoiceCode'],
      priceCode: json['PriceCode'],
      businessName: json['BusinessName'],
      taxNumber: json['TaxNumber'],
      commercialRegister: json['CommercialRegister'],
      invoiceType: json['InvoiceType'],
      salesmanId: json['SalesmanID'],
      supplierNumber: json['SupplierNumber'],
      invoicesStatus: json['InvoicesStatus'],
      packageBundleId: json['PackageBundleId'],
      createdDate: json['CreatedDate'],
      deliveryTime: json['DeliveryTime'],
      inventoryId: json['InventoryId'],
      invoiceDetails: json['InvoiceDetails'],
      shippingStatus: json['ShippingStatus'],
      paymentType: json['PaymentType'],
      shippingPackageId: json['ShippingPackageId'],
      shippingPrice: (json['ShippingPrice'] as num?)?.toDouble(),
      userId: json['UserId'],
      websiteId: json['WebsiteId'],
      shiftId: json['ShiftId'],
      clientName: json['ClientName'],
      clientPhone: json['ClientPhone'],
      clientEmail: json['ClientEmail'],
      clientAccountNo: json['ClientAccountNo'],
      clientAddress: json['ClientAddress'],
      clientCode: json['ClientCode'],
      recievedInvoiceSummary: json['RecievedInvoiceSummary'],
      recievedInvoiceProducts: (json['RecievedInvoiceProducts'] as List?)
          ?.map((e) => RecievedInvoiceProduct.fromJson(e))
          .toList(),
      recievedInvoiceTax: (json['RecievedInvoiceTax'] as List?)
          ?.map((e) => RecievedInvoiceTax.fromJson(e))
          .toList(),
      recievedInvoiceServices: json['RecievedInvoiceServices'],
      recievedInvoicePaymentType: (json['RecievedInvoicePaymentType'] as List?)
          ?.map((e) => RecievedInvoicePaymentType.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'InvoiceCode': invoiceCode,
      'PriceCode': priceCode,
      'BusinessName': businessName,
      'TaxNumber': taxNumber,
      'CommercialRegister': commercialRegister,
      'InvoiceType': invoiceType,
      'SalesmanID': salesmanId,
      'SupplierNumber': supplierNumber,
      'InvoicesStatus': invoicesStatus,
      'CreatedDate': createdDate,
      'DeliveryTime': deliveryTime,
      'InventoryId': inventoryId,
      'InvoiceDetails': invoiceDetails,
      'ShippingStatus': shippingStatus,
      'PaymentType': paymentType,
      'ShippingPackageId': shippingPackageId,
      'ShippingPrice': shippingPrice,
      'UserId': userId,
      'WebsiteId': websiteId,
      'ShiftId': shiftId,
      'ClientName': clientName,
      'ClientPhone': clientPhone,
      'ClientEmail': clientEmail,
      'ClientAccountNo': clientAccountNo,
      'ClientAddress': clientAddress,
      'ClientCode': clientCode,
      'PackageBundleId': packageBundleId,
      'RecievedInvoiceSummary': recievedInvoiceSummary,
      'RecievedInvoiceProducts': recievedInvoiceProducts
          ?.map((e) => e.toJson())
          .toList(),
      'RecievedInvoiceTax': recievedInvoiceTax?.map((e) => e.toJson()).toList(),
      'RecievedInvoiceServices': recievedInvoiceServices,
      'RecievedInvoicePaymentType': recievedInvoicePaymentType
          ?.map((e) => e.toJson())
          .toList(),
    };
  }
}

class RecievedInvoiceProduct {
  int? id;
  int? productId;
  int? qnt;
  String? details;
  double? productPrice;
  double? productDiscount;
  double? productTax;
  double? totalPrice;
  dynamic excutionPeriod;
  String? sn;

  RecievedInvoiceProduct({
    this.id,
    this.productId,
    this.qnt,
    this.details,
    this.productPrice,
    this.productDiscount,
    this.productTax,
    this.totalPrice,
    this.excutionPeriod,
    this.sn,
  });

  factory RecievedInvoiceProduct.fromJson(Map<String, dynamic> json) {
    return RecievedInvoiceProduct(
      id: json['Id'],
      productId: json['ProductId'],
      qnt: json['Qnt'],
      details: json['Details'],
      productPrice: (json['ProductPrice'] as num?)?.toDouble(),
      productDiscount: (json['ProductDiscount'] as num?)?.toDouble(),
      productTax: (json['ProductTax'] as num?)?.toDouble(),
      totalPrice: (json['TotalPrice'] as num?)?.toDouble(),
      excutionPeriod: json['ExcutionPeriod'],
      sn: json['SN'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'ProductId': productId,
      'Qnt': qnt,
      'Details': details,
      'ProductPrice': productPrice,
      'ProductDiscount': productDiscount,
      'ProductTax': productTax,
      'TotalPrice': totalPrice,
      'ExcutionPeriod': excutionPeriod,
      'SN': sn,
    };
  }
}

class RecievedInvoiceTax {
  int? id;
  int? invoiceId;
  int? taxTypeId;
  double? amount;
  double? taxPrecentage;
  String? details;

  RecievedInvoiceTax({
    this.id,
    this.invoiceId,
    this.taxTypeId,
    this.amount,
    this.taxPrecentage,
    this.details,
  });

  factory RecievedInvoiceTax.fromJson(Map<String, dynamic> json) {
    return RecievedInvoiceTax(
      id: json['Id'],
      invoiceId: json['InvoiceId'],
      taxTypeId: json['TaxTypeID'],
      amount: (json['Amount'] as num?)?.toDouble(),
      taxPrecentage: (json['TaxPrecentage'] as num?)?.toDouble(),
      details: json['Details'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'InvoiceId': invoiceId,
      'TaxTypeID': taxTypeId,
      'Amount': amount,
      'TaxPrecentage': taxPrecentage,
      'Details': details,
    };
  }
}

class RecievedInvoicePaymentType {
  int? paymentType;
  double? amount;
  String? details;

  RecievedInvoicePaymentType({this.paymentType, this.amount, this.details});

  factory RecievedInvoicePaymentType.fromJson(Map<String, dynamic> json) {
    return RecievedInvoicePaymentType(
      paymentType: json['PaymentType'],
      amount: (json['Amount'] as num?)?.toDouble(),
      details: json['Details'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'PaymentType': paymentType, 'Amount': amount, 'Details': details};
  }
}
