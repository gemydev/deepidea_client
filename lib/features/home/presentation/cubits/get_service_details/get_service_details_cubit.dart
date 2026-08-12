import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/get_service_details_use_case.dart';
import '../../../domain/use_cases/get_service_details_web_id_use_case.dart';
import 'get_service_details_state.dart';

class GetServiceDetailsCubit extends Cubit<GetServiceDetailsState> {
  GetServiceDetailsCubit({
    required this.getServiceDetailsUseCase,
    required this.getServiceDetailsByWebIdUseCase,
  }) : super(GetServiceDetailsInitial());

  final GetServiceDetailsUseCase getServiceDetailsUseCase;
  final GetServiceDetailsByWebIdUseCase getServiceDetailsByWebIdUseCase;

  Future<void> getServiceDetails(String id) async {
    emit(GetServiceDetailsLoading());

    final eitherPackagesOrFailure = await getServiceDetailsUseCase(id);

    eitherPackagesOrFailure.fold(
      (failure) {
        emit(const GetServiceDetailsError(message: 'GetServiceDetailsError'));
      },
      (response) async {
        log(response.statusCode.toString());
        if (response.statusCode != 200) {
          emit(const GetServiceDetailsError(message: 'GetServiceDetailsError'));
          emit(GetServiceDetailsInitial());
        } else {
          emit(GetServiceDetailsLoaded(response: response));
        }
      },
    );
  }

  Future<void> getServiceDetailsByWebId(String webId) async {
    emit(GetServiceDetailsLoading());

    final eitherPackagesOrFailure =
        await getServiceDetailsByWebIdUseCase(webId);

    eitherPackagesOrFailure.fold(
      (failure) {
        emit(const GetServiceDetailsError(
            message: 'GetServiceDetailsByWebIdError'));
      },
      (response) async {
        log(response.statusCode.toString());
        if (response.statusCode != 200) {
          emit(const GetServiceDetailsError(
              message: 'GetServiceDetailsByWebIdError'));
          emit(GetServiceDetailsInitial());
        } else {
          emit(GetServiceDetailsLoaded(response: response));
        }
      },
    );
  }
}
