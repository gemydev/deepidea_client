import 'package:remotely/features/auth/data/models/requests/verify_otp.dart';
import 'package:remotely/features/auth/data/models/responses/verify_otp.dart';
import 'package:remotely/features/auth/domain/use_cases/verify_otp_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/preferences_manager.dart';

part 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  VerifyOtpCubit({required this.verifyOtpUseCase}) : super(VerifyOtpInitial());

  final VerifyOtpUseCase verifyOtpUseCase;

  Future<void> verifyOtp(VerifyOtpRequest request) async {
    if (isClosed) return;
    debugPrint('mmmmm $request');
    emit(VerifyOtpLoading());

    final eitherPackagesOrFailure = await verifyOtpUseCase(request);

    if (isClosed) return;
    eitherPackagesOrFailure.fold(
      (failure) {
        if (!isClosed) emit(const VerifyOtpError(message: 'VerifyOtpError'));
      },
      (response) async {
        await TpPreferencesManager.saveString(
          TpPreferencesManager.savedEmail,
          request.email!.trim(),
        );
        await TpPreferencesManager.saveString(
          TpPreferencesManager.savedPass,
          request.password!.trim(),
        );
        if (!isClosed) emit(VerifyOtpLoaded(response: response));
      },
    );
  }
}
