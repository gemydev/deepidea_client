import 'package:remotely/core/error/failure.dart';
import 'package:remotely/core/helpers/snakbar_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/requests/submit_sales_delivery_request.dart';
import '../../../data/models/responses/submit_sales_delivery_response.dart';
import '../../../domain/use_cases/submit_sales_delivery.dart';

part 'submit_sales_delivery_state.dart';

class SubmitSalesDeliveryCubit extends Cubit<SubmitSalesDeliveryState> {
  SubmitSalesDeliveryCubit({required this.submitSalesDeliveryUseCase})
    : super(SubmitSalesDeliveryInitial());

  final SubmitSalesDeliveryUseCase submitSalesDeliveryUseCase;

  Future<void> submitSalesDelivery(SubmitSalesDeliveryRequest request) async {
    emit(SubmitSalesDeliveryLoading());

    final eitherPackagesOrFailure = await submitSalesDeliveryUseCase(request);

    eitherPackagesOrFailure.fold(
      (failure) {
        if (failure is ServerFailure) {
          AppSnackBar.error(failure.message.toString());
        }
        emit(const SubmitSalesDeliveryError(message: 'SubmitSalesDeliveryError'));
      },
      (response) async {
        if (response.statusCode != 200) {
          emit(const SubmitSalesDeliveryError(message: 'SubmitSalesDeliveryError'));
          AppSnackBar.success(response.message);
          emit(SubmitSalesDeliveryInitial());
        } else {
          final submitSalesDeliveryResponse = SubmitSalesDeliveryResponse.fromJson(
            response.toJson(),
          );

          emit(SubmitSalesDeliveryLoaded(response: submitSalesDeliveryResponse));
        }
      },
    );
  }
}
