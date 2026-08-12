import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../data/models/responses/get_package_response.dart';
import '../../../domain/use_cases/get_packages.dart';

part 'get_packages_state.dart';

class GetPackagesCubit extends Cubit<GetPackagesState> {
  GetPackagesCubit({required this.getPackagesUseCase})
      : super(GetPackagesInitial());

  final GetPackagesUseCase getPackagesUseCase;

  Future<void> getPackages() async {
    emit(GetPackagesLoading());

    final eitherPackagesOrFailure = await getPackagesUseCase(unit);

    eitherPackagesOrFailure.fold((failure) {
      if (failure is ServerFailure) {
        emit(GetPackagesError(message: failure.message.toString()));
      } else {
        emit(const GetPackagesError(message: 'GetPackagesError'));
      }
    }, (response) async {
      if (response.statusCode != 200) {
        emit(const GetPackagesError(message: 'GetPackagesError'));
      } else {
        final getPackagesResponse =
            GetPackagesResponse.fromJson(response.toJson());
        emit(GetPackagesLoaded(response: getPackagesResponse));
      }
    });
  }
}
