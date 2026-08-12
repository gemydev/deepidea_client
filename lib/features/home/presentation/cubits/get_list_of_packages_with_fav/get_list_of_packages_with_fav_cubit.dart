import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/responses/get_services_list_of_packages_with_fav_response.dart';
import '../../../domain/use_cases/get_list_of_packages_with_fav_use_case.dart';

part 'get_list_of_packages_with_fav_state.dart';

class GetServicesListOfPackagesWithFavCubit
    extends Cubit<GetServicesListOfPackagesWithFavState> {
  final GetServicesListOfPackagesWithFavUseCase
  getServicesListOfPackagesWithFavUseCase;

  GetServicesListOfPackagesWithFavCubit({
    required this.getServicesListOfPackagesWithFavUseCase,
  }) : super(GetServicesListOfPackagesWithFavInitial());

  /// 🔹 دالة لجلب الخطط الخاصة بخدمة واحدة
  Future<void> getServicesListOfPackagesWithFav(String id) async {
    emit(GetServicesListOfPackagesWithFavLoading());

    final eitherPackagesOrFailure =
        await getServicesListOfPackagesWithFavUseCase(id);

    eitherPackagesOrFailure.fold(
      (failure) {
        emit(
          const GetServicesListOfPackagesWithFavError(
            message: 'GetServicesListOfPackagesWithFavError',
          ),
        );
      },
      (response) async {
        log(response.statusCode.toString());
        if (response.statusCode != 200) {
          emit(
            const GetServicesListOfPackagesWithFavError(
              message: 'GetServicesListOfPackagesWithFavError',
            ),
          );
          emit(GetServicesListOfPackagesWithFavInitial());
        } else {
          emit(GetServicesListOfPackagesWithFavLoaded(response: response));
        }
      },
    );
  }

  /// 🔹 دالة جديدة لجلب أكثر من خدمة (مثلاً IDs: 4 و5)
  Future<void> getMultiplePackages(List<String> serviceIds) async {
    emit(GetServicesListOfPackagesWithFavLoading());

    try {
      final results = await Future.wait(
        serviceIds.map((id) => getServicesListOfPackagesWithFavUseCase(id)),
      );

      final allPackages = <Package>[];

      for (final either in results) {
        either.fold(
          (failure) {
            // لو فيه أي فشل نقدر نطبعه فقط بدون إيقاف الباقي
            log('❌ Failed to load for one of IDs');
          },
          (response) {
            if (response.statusCode == 200) {
              allPackages.addAll(response.result ?? []);
            }
          },
        );
      }

      if (allPackages.isEmpty) {
        emit(
          const GetServicesListOfPackagesWithFavError(
            message: 'لم يتم العثور على أي باقات.',
          ),
        );
        return;
      }

      // إنشاء Response جديد يحتوي على كل النتائج
      final mergedResponse = GetServicesListOfPackagesWithFavResponse(
        statusCode: 200,
        message: 'Combined Packages',
        result: allPackages,
      );

      emit(GetServicesListOfPackagesWithFavLoaded(response: mergedResponse));
    } catch (e, st) {
      log('❌ Error loading multiple packages: $e\n$st');
      emit(GetServicesListOfPackagesWithFavError(message: e.toString()));
    }
  }
}
