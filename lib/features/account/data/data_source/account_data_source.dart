import 'package:dio/dio.dart';

import '../../../../core/data/network/api.dart';
import '../../../../core/data/network/dio_client.dart';
import '../../../../core/error/exceptions.dart';
import '../models/responses/client_subscription_status_response.dart';

abstract class AccountDataSource {
  Future<ClientSubscriptionStatusResponse> getClientSubscriptionStatus(String clientId);
}

class AccountDataSourceImp implements AccountDataSource {
  AccountDataSourceImp({required this.networkClient});

  final NetworkClient networkClient;

  @override
  Future<ClientSubscriptionStatusResponse> getClientSubscriptionStatus(String clientId) async {
    try {
      final Map<String, dynamic> response = await networkClient.getData(
        endpoint: Api.getClientSubscriptionStatus(clientId),
      );
      return ClientSubscriptionStatusResponse.fromJson(response);
    } on DioException catch (e) {
      final message = e.response?.data?.toString() ?? e.message ?? 'Server error';
      throw ServerException(message: message);
    }
  }
}
