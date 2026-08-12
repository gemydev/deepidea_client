import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../data/models/responses/get_registered_services_and_packages_response.dart';
import '../../../domain/use_cases/get_registered_services_and_packages_use_case.dart';

part 'get_registered_services_and_packages_state.dart';

class GetRegisteredServicesAndPackagesCubit
    extends Cubit<GetRegisteredServicesAndPackagesState> {
  GetRegisteredServicesAndPackagesCubit({
    required this.getRegisteredServicesAndPackagesUseCase,
  }) : super(GetRegisteredServicesAndPackagesInitial());

  final GetRegisteredServicesAndPackagesUseCase
  getRegisteredServicesAndPackagesUseCase;

  Future<void> getRegisteredServicesAndPackages() async {
    emit(GetRegisteredServicesAndPackagesLoading());

    final eitherPackagesOrFailure =
        await getRegisteredServicesAndPackagesUseCase(unit);

    eitherPackagesOrFailure.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(
            GetRegisteredServicesAndPackagesError(
              message: failure.message.toString(),
            ),
          );
        } else {
          emit(
            const GetRegisteredServicesAndPackagesError(
              message: 'GetRegisteredServicesAndPackagesError',
            ),
          );
        }
      },
      (response) async {
        if (response.statusCode != 200) {
          emit(
            const GetRegisteredServicesAndPackagesError(
              message: 'GetRegisteredServicesAndPackagesError',
            ),
          );
        } else {
          final getRegisteredServicesAndPackagesResponse =
              GetRegisteredServicesAndPackagesResponse.fromJson(
                response.toJson(),
              );
          emit(
            GetRegisteredServicesAndPackagesLoaded(
              response: getRegisteredServicesAndPackagesResponse,
            ),
          );
        }
      },
    );
  }
}
