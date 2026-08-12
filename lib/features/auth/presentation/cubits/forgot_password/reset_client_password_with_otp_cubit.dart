import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remotely/features/auth/data/models/requests/reset_client_password_with_otp_request.dart';
import 'package:remotely/features/auth/data/models/responses/reset_client_password_with_otp_response.dart';
import 'package:remotely/features/auth/domain/use_cases/reset_client_password_with_otp_use_case.dart';

part 'reset_client_password_with_otp_state.dart';

class ResetClientPasswordWithOtpCubit extends Cubit<ResetClientPasswordWithOtpState> {
  ResetClientPasswordWithOtpCubit({required this.useCase})
    : super(ResetClientPasswordWithOtpInitial());

  final ResetClientPasswordWithOtpUseCase useCase;

  Future<void> resetPassword(ResetClientPasswordWithOtpRequest request) async {
    emit(ResetClientPasswordWithOtpLoading());

    final result = await useCase(request);

    result.fold(
      (failure) => emit(
        ResetClientPasswordWithOtpError(message: 'حدث خطأ أثناء إعادة تعيين كلمة المرور'),
      ),
      (response) {
        if (response.statusCode != 200) {
          emit(
            ResetClientPasswordWithOtpError(
              message: response.message.isNotEmpty
                  ? response.message
                  : 'تعذر إعادة تعيين كلمة المرور',
            ),
          );
          return;
        }
        emit(ResetClientPasswordWithOtpLoaded(response: response));
      },
    );
  }
}
