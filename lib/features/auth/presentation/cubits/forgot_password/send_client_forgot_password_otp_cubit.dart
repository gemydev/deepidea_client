import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remotely/features/auth/data/models/requests/send_client_forgot_password_otp_request.dart';
import 'package:remotely/features/auth/data/models/responses/send_client_forgot_password_otp_response.dart';
import 'package:remotely/features/auth/domain/use_cases/send_client_forgot_password_otp_use_case.dart';

import '../../../../../core/error/failure.dart';

part 'send_client_forgot_password_otp_state.dart';

class SendClientForgotPasswordOtpCubit extends Cubit<SendClientForgotPasswordOtpState> {
  SendClientForgotPasswordOtpCubit({required this.useCase})
    : super(SendClientForgotPasswordOtpInitial());

  final SendClientForgotPasswordOtpUseCase useCase;

  Future<void> sendOtp(SendClientForgotPasswordOtpRequest request) async {
    emit(SendClientForgotPasswordOtpLoading());

    final result = await useCase(request);

    result.fold(
      (failure) => emit(
        SendClientForgotPasswordOtpError(
          message: failure is ServerFailure && failure.message?.isNotEmpty == true
              ? failure.message!
              : 'حدث خطأ أثناء إرسال رمز التحقق',
        ),
      ),
      (response) {
        if (response.statusCode != 200) {
          emit(
            SendClientForgotPasswordOtpError(
              message: response.message.isNotEmpty
                  ? response.message
                  : 'تعذر إرسال رمز التحقق',
            ),
          );
          return;
        }
        emit(SendClientForgotPasswordOtpLoaded(response: response));
      },
    );
  }
}
