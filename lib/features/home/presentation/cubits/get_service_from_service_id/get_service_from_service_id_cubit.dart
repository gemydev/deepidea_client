import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/requests/get_service_from_service_id.dart';
import '../../../data/models/responses/get_service_from_service_id.dart';
import '../../../domain/use_cases/get_service_from_service_id.dart';

part 'get_service_from_service_id_state.dart';

class GetServiceFromServiceIdCubit extends Cubit<GetServiceFromServiceIdState> {
  GetServiceFromServiceIdCubit({required this.getServiceFromServiceIdUseCase})
    : super(GetServiceFromServiceIdInitial());

  final GetServiceFromServiceIdUseCase getServiceFromServiceIdUseCase;

  Future<void> getServiceFromServiceId(
    GetServiceFromServiceIdRequest request,
  ) async {
    emit(GetServiceFromServiceIdLoading());

    final eitherPackagesOrFailure = await getServiceFromServiceIdUseCase(
      request,
    );

    eitherPackagesOrFailure.fold(
      (failure) {
        emit(
          const GetServiceFromServiceIdError(
            message: 'GetServiceFromServiceIdError',
          ),
        );
      },
      (response) async {
        log(response.statusCode.toString());
        if (response.statusCode != 200) {
          emit(
            const GetServiceFromServiceIdError(
              message: 'GetServiceFromServiceIdError',
            ),
          );
          emit(GetServiceFromServiceIdInitial());
        } else {
          final getServiceFromServiceIdResponse =
              GetServiceFromServiceIdResponse.fromJson(response.toJson());

          emit(
            GetServiceFromServiceIdLoaded(
              response: getServiceFromServiceIdResponse,
            ),
          );
        }
      },
    );
  }
}
