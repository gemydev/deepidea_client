import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../data/models/responses/get_all_services_by_web_id_response.dart';
import '../../../domain/use_cases/get_all_services_by_web_id.dart';

part 'get_all_services_by_web_id_state.dart';

class GetAllServicesByWebIdCubit extends Cubit<GetAllServicesByWebIdState> {
  GetAllServicesByWebIdCubit({required this.getAllServicesByWebIdUseCase})
      : super(GetAllServicesByWebIdInitial());

  final GetAllServicesByWebIdUseCase getAllServicesByWebIdUseCase;

  Future<void> getAllServicesByWebId() async {
    emit(GetAllServicesByWebIdLoading());

    final eitherPackagesOrFailure = await getAllServicesByWebIdUseCase(unit);

    eitherPackagesOrFailure.fold((failure) {
      if (failure is ServerFailure) {
        emit(GetAllServicesByWebIdError(message: failure.message.toString()));
      } else {
        emit(const GetAllServicesByWebIdError(
            message: 'GetAllServicesByWebIdError'));
      }
    }, (response) async {
      if (response.statusCode != 200) {
        emit(const GetAllServicesByWebIdError(
            message: 'GetAllServicesByWebIdError'));
      } else {
        final getAllServicesByWebIdResponse =
            GetAllServicesByWebIdResponse.fromJson(response.toJson());
        emit(GetAllServicesByWebIdLoaded(
            response: getAllServicesByWebIdResponse));
      }
    });
  }
}
