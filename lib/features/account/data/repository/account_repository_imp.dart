import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repository/account_repository.dart';
import '../data_source/account_data_source.dart';
import '../models/responses/client_subscription_status_response.dart';

class AccountRepositoryImp implements AccountRepository {
  AccountRepositoryImp({required this.accountDataSource});

  final AccountDataSource accountDataSource;

  @override
  Future<Either<Failure, ClientSubscriptionStatusResponse>> getClientSubscriptionStatus(
    String clientId,
  ) async {
    try {
      final data = await accountDataSource.getClientSubscriptionStatus(clientId);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
