import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failure.dart';
import '../../../data/models/responses/client_subscription_status_response.dart';
import '../../../domain/use_cases/get_client_subscription_status_use_case.dart';

part 'client_subscription_status_state.dart';

class ClientSubscriptionStatusCubit extends Cubit<ClientSubscriptionStatusState> {
  ClientSubscriptionStatusCubit({required this.getClientSubscriptionStatusUseCase})
    : super(const ClientSubscriptionStatusInitial());

  final GetClientSubscriptionStatusUseCase getClientSubscriptionStatusUseCase;

  Future<void> load(String clientId) async {
    if (clientId.isEmpty) {
      emit(const ClientSubscriptionStatusError(message: 'معرف العميل غير متوفر'));
      return;
    }

    emit(const ClientSubscriptionStatusLoading());

    final result = await getClientSubscriptionStatusUseCase(
      GetClientSubscriptionStatusParams(clientId: clientId),
    );

    if (isClosed) return;

    result.fold(
      (failure) {
        final message =
            failure is ServerFailure ? (failure.message ?? 'خطأ في الخادم') : 'خطأ في الخادم';
        emit(ClientSubscriptionStatusError(message: message));
      },
      (response) {
        if (response.statusCode != 200) {
          emit(
            ClientSubscriptionStatusError(
              message: response.statusMessage ?? 'تعذر تحميل حالة الاشتراك',
            ),
          );
          return;
        }
        emit(ClientSubscriptionStatusLoaded(response: response));
      },
    );
  }
}
