import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../../data/models/requests/login_request.dart';
import '../../data/models/responses/login_response.dart';
import '../repository/auth_repository.dart';

class LoginUseCase implements UseCase<LoginResponse, LoginRequest> {
  final AuthRepository authRepository;

  const LoginUseCase({required this.authRepository});

  @override
  Future<Either<Failure, LoginResponse>> call(LoginRequest loginRequest) async {
    return authRepository.login(loginRequest);
  }
}
