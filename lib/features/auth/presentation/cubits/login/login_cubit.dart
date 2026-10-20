import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/preferences_manager.dart';
import '../../../../../core/helpers/snakbar_manager.dart';
import '../../../../call_feature/call_manager.dart';
import '../../../data/models/requests/login_request.dart';
import '../../../data/models/responses/login_response.dart';
import '../../../domain/use_cases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit({required this.loginUseCase}) : super(LoginInitial());

  Future<bool> login({required LoginRequest loginRequest}) async {
    bool success = false;
    emit(LoginLoading());

    final eitherPackagesOrFailure = await loginUseCase(loginRequest);

    eitherPackagesOrFailure.fold(
      (failure) {
        AppSnackBar.error("حدث خطأ، يرجى المحاولة مرة أخرى");
        emit(const LoginError(message: 'LoginError'));
        success = false;
      },
      (response) async {
        log(response.statusCode.toString());
        if (response.statusCode != 200) {
          success = false;
          final message = response.statusMessage?.toString();
          AppSnackBar.error(
            (message != null && message.isNotEmpty)
                ? message
                : "من فضلك تحقق من صحة المدخلات",
          );
          emit(const LoginError(message: 'LoginError'));
          emit(LoginInitial());
        } else {
          success = true;
          final loginResponse = LoginResponse.fromJson(response.toJson());
          await TpPreferencesManager.saveString(
            TpPreferencesManager.authKey,
            loginResponse.authKey ?? "",
          );
          await TpPreferencesManager.saveString(
            TpPreferencesManager.userId,
            loginResponse.userID ?? "",
          );
          await TpPreferencesManager.saveString(
            TpPreferencesManager.websiteId,
            loginResponse.websiteid.toString(),
          );
          await TpPreferencesManager.saveString(
            TpPreferencesManager.clientName,
            loginResponse.clientName ?? '',
          );
          await TpPreferencesManager.saveString(
            TpPreferencesManager.clientAddress,
            loginResponse.clientAddress ?? '',
          );
          await TpPreferencesManager.saveString(
            TpPreferencesManager.clientEmail,
            loginResponse.clientEmail ?? '',
          );
          await TpPreferencesManager.saveString(
            TpPreferencesManager.clientPhone,
            loginResponse.clientPhoneNumber ?? '',
          );
          await TpPreferencesManager.saveString(
            TpPreferencesManager.storeName,
            loginResponse.storeName ?? '',
          );

          await TpPreferencesManager.saveBool(
            TpPreferencesManager.isLoggedIn,
            true,
          );

          // Zego: init after credentials are stored (also restored on cold start via main).
          final userID = loginResponse.userID ?? "0";
          final userName = loginResponse.clientName ?? "User";
          await CallManager.init(userID: userID, userName: userName);

          emit(LoginLoaded(response: loginResponse));
          return success;
        }
      },
    );
    log("success $success");

    return success;
  }
}
