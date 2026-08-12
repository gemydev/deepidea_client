import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/responses/client_subscription_status_response.dart';

abstract class AccountRepository {
  Future<Either<Failure, ClientSubscriptionStatusResponse>> getClientSubscriptionStatus(
    String clientId,
  );
}
