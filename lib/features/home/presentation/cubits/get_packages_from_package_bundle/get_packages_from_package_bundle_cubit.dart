import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/requests/get_packages_from_backage_bundel.dart';
import '../../../data/models/responses/get_packages_from_package_bundle_response.dart';
import '../../../domain/use_cases/get_packages_from_package_bundle.dart';

part 'get_packages_from_package_bundle_state.dart';

class GetPackagesFromPackageBundleCubit
    extends Cubit<GetPackagesFromPackageBundleState> {
  GetPackagesFromPackageBundleCubit({
    required this.getPackagesFromPackageBundleUseCase,
  }) : super(GetPackagesFromPackageBundleInitial());

  final GetPackagesFromPackageBundleUseCase getPackagesFromPackageBundleUseCase;

  Future<void> getPackagesFromPackageBundle(
    GetPackagesFromPackageBundleRequest request,
  ) async {
    emit(GetPackagesFromPackageBundleLoading());

    final eitherPackagesOrFailure = await getPackagesFromPackageBundleUseCase(
      request,
    );

    eitherPackagesOrFailure.fold(
      (failure) {
        emit(
          const GetPackagesFromPackageBundleError(
            message: 'GetPackagesFromPackageBundleError',
          ),
        );
      },
      (response) async {
        log(response.statusCode.toString());
        if (response.statusCode != 200) {
          emit(
            const GetPackagesFromPackageBundleError(
              message: 'GetPackagesFromPackageBundleError',
            ),
          );
          emit(GetPackagesFromPackageBundleInitial());
        } else {
          final getPackagesFromPackageBundleResponse =
              GetPackagesFromPackageBundleResponse.fromJson(response.toJson());

          emit(
            GetPackagesFromPackageBundleLoaded(
              response: getPackagesFromPackageBundleResponse,
            ),
          );
        }
      },
    );
  }
}
