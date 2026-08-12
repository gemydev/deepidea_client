import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../../data/models/responses/client_subscription_status_response.dart';
import '../repository/account_repository.dart';

class GetClientSubscriptionStatusUseCase
    implements UseCase<ClientSubscriptionStatusResponse, GetClientSubscriptionStatusParams> {
  const GetClientSubscriptionStatusUseCase({required this.accountRepository});

  final AccountRepository accountRepository;

  @override
  Future<Either<Failure, ClientSubscriptionStatusResponse>> call(
    GetClientSubscriptionStatusParams params,
  ) async {
    return accountRepository.getClientSubscriptionStatus(params.clientId);
  }
}

class GetClientSubscriptionStatusParams extends Equatable {
  const GetClientSubscriptionStatusParams({required this.clientId});

  final String clientId;

  @override
  List<Object?> get props => [clientId];
}
