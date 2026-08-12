import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/models/usecase.dart';
import '../../../data/models/responses/logout_response.dart';
import '../../../domain/use_cases/logout_use_case.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final LogoutUseCase logoutUseCase;

  LogoutCubit({required this.logoutUseCase}) : super(LogoutInitial());

  Future<bool> logout() async {
    var success = false;
    emit(LogoutLoading());

    final eitherPackagesOrFailure = await logoutUseCase(NoParams());

    eitherPackagesOrFailure.fold((failure) {
      emit(const LogoutError(message: 'LogoutError'));
      success = false;
    }, (response) async {
      success = true;
      LogoutResponse logoutResponse =
          LogoutResponse.fromJson(response.toJson());
      emit(LogoutLoaded(response: logoutResponse));
      return success;
    });

    return success;
  }
}
