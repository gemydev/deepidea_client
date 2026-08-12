import 'package:remotely/features/auth/data/models/requests/send_otp_verification_request.dart';
import 'package:remotely/features/auth/data/models/responses/send_otp_verification.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';

import '../repository/auth_repository.dart';

class SendOtpVerificationUseCase
    implements UseCase<SendOtpVerificationResponse, SendOtpVerificationRequest> {
  final AuthRepository authRepository;

  const SendOtpVerificationUseCase({required this.authRepository});

  @override
  Future<Either<Failure, SendOtpVerificationResponse>> call(
    SendOtpVerificationRequest sendOtpVerificationRequest,
  ) async {
    return authRepository.sendOtpVerification(sendOtpVerificationRequest);
  }
}
