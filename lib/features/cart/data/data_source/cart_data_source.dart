import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/data/network/api.dart';
import '../../../../core/data/network/dio_client.dart';
import '../../../../core/error/exceptions.dart';
import '../models/requests/post_invoices_with_confirm_request.dart';
import '../models/responses/get_invoices_and_packages_response.dart';
import '../models/responses/post_invoices_with_confirm_response.dart';

abstract class CartDataSource {
  postInvoicesWithConfirm(
      PostInvoicesWithConfirmRequest postInvoicesWithConfirmRequest);

  getInvoicesAndPackages();
}

class CartDataSourceImp implements CartDataSource {
  final NetworkClient networkClient;
  final SharedPreferences prefs;

  CartDataSourceImp({required this.networkClient, required this.prefs});

  @override
  postInvoicesWithConfirm(
      PostInvoicesWithConfirmRequest postInvoicesWithConfirmRequest) async {
    // ListOfReceivedInvoices invoices = ListOfReceivedInvoices(invoices: []);
    // invoices.invoices.add(postInvoicesWithConfirmRequest);

    try {
      Map<String, dynamic> response = await networkClient.postData(
        endpoint: Api.postInvoicesWithConfirm(),
        query: [postInvoicesWithConfirmRequest.toJson()],
      );
      final PostInvoicesWithConfirmResponse postInvoicesWithConfirmResponse =
          PostInvoicesWithConfirmResponse.fromJson(response);

      return postInvoicesWithConfirmResponse;
    } on DioException catch (e) {
      throw ServerException(message: "Server Exception: ${e.toString()}");
    }
  }

  @override
  getInvoicesAndPackages() async {
    try {
      Map<String, dynamic> response = await networkClient.getData(
        endpoint: Api.getInvoicesAndPackages(),
      );
      final GetInvoicesAndPackagesResponse getInvoicesAndPackagesResponse =
          GetInvoicesAndPackagesResponse.fromJson(response);

      return getInvoicesAndPackagesResponse;
    } on DioException catch (e) {
      throw ServerException(message: "Server Exception: ${e.toString()}");
    }
  }
}
