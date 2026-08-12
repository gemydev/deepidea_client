import 'package:remotely/features/auth/data/models/requests/send_otp_verification_request.dart';
import 'package:remotely/features/auth/data/models/responses/send_otp_verification.dart';
import 'package:remotely/features/auth/domain/use_cases/send_otp_verification_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'send_otp_verification_state.dart';

class SendOtpVerificationCubit extends Cubit<SendOtpVerificationState> {
  SendOtpVerificationCubit({required this.sendOtpVerificationUseCase})
    : super(SendOtpVerificationInitial());

  final SendOtpVerificationUseCase sendOtpVerificationUseCase;

  Future<void> sendOtpVerification(SendOtpVerificationRequest request) async {
    emit(SendOtpVerificationLoading());

    final result = await sendOtpVerificationUseCase(request);

    result.fold(
      (failure) {
        emit(SendOtpVerificationError(message: 'حدث خطأ أثناء إرسال رمز التحقق'));
      },
      (response) {
        emit(SendOtpVerificationLoaded(response: response));
      },
    );
  }
}
