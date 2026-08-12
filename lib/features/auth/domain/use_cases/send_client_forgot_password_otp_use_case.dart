import 'package:dartz/dartz.dart';
import 'package:remotely/features/auth/data/models/requests/send_client_forgot_password_otp_request.dart';
import 'package:remotely/features/auth/data/models/responses/send_client_forgot_password_otp_response.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../repository/auth_repository.dart';

class SendClientForgotPasswordOtpUseCase
    implements UseCase<SendClientForgotPasswordOtpResponse, SendClientForgotPasswordOtpRequest> {
  final AuthRepository authRepository;

  const SendClientForgotPasswordOtpUseCase({required this.authRepository});

  @override
  Future<Either<Failure, SendClientForgotPasswordOtpResponse>> call(
    SendClientForgotPasswordOtpRequest request,
  ) async {
    return authRepository.sendClientForgotPasswordOtp(request);
  }
}
