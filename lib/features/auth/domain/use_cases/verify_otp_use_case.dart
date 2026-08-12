import 'package:remotely/features/auth/data/models/requests/verify_otp.dart';
import 'package:remotely/features/auth/data/models/responses/verify_otp.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../repository/auth_repository.dart';

class VerifyOtpUseCase implements UseCase<VerifyOtpResponse, VerifyOtpRequest> {
  final AuthRepository authRepository;

  const VerifyOtpUseCase({required this.authRepository});

  @override
  Future<Either<Failure, VerifyOtpResponse>> call(VerifyOtpRequest verifyOtpRequest) async {
    return authRepository.verifyOtp(verifyOtpRequest);
  }
}
