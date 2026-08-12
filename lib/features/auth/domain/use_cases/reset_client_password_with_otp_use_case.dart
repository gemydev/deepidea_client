import 'package:dartz/dartz.dart';
import 'package:remotely/features/auth/data/models/requests/reset_client_password_with_otp_request.dart';
import 'package:remotely/features/auth/data/models/responses/reset_client_password_with_otp_response.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../repository/auth_repository.dart';

class ResetClientPasswordWithOtpUseCase
    implements UseCase<ResetClientPasswordWithOtpResponse, ResetClientPasswordWithOtpRequest> {
  final AuthRepository authRepository;

  const ResetClientPasswordWithOtpUseCase({required this.authRepository});

  @override
  Future<Either<Failure, ResetClientPasswordWithOtpResponse>> call(
    ResetClientPasswordWithOtpRequest request,
  ) async {
    return authRepository.resetClientPasswordWithOtp(request);
  }
}
