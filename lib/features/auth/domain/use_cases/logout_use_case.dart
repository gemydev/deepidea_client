import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../../data/models/responses/logout_response.dart';
import '../repository/auth_repository.dart';

class LogoutUseCase implements UseCase<LogoutResponse, NoParams> {
  final AuthRepository authRepository;

  const LogoutUseCase({required this.authRepository});

  @override
  Future<Either<Failure, LogoutResponse>> call(NoParams noParams) async {
    return authRepository.logout();
  }
}
