import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/models/usecase.dart';
import '../../../data/models/responses/get_invoices_and_packages_response.dart';
import '../../../domain/use_cases/get_invoices_and_packages_use_case.dart';

part 'get_invoices_and_packages_state.dart';

class GetInvoicesAndPackagesCubit extends Cubit<GetInvoicesAndPackagesState> {
  GetInvoicesAndPackagesCubit({required this.getInvoicesAndPackagesUseCase})
      : super(GetInvoicesAndPackagesInitial());
  final GetInvoicesAndPackagesUseCase getInvoicesAndPackagesUseCase;

  Future<bool> getInvoicesAndPackages() async {
    bool success = false;
    emit(GetInvoicesAndPackagesLoading());

    final eitherPackagesOrFailure =
        await getInvoicesAndPackagesUseCase(NoParams());

    eitherPackagesOrFailure.fold((failure) {
      emit(GetInvoicesAndPackagesError(message: 'GetInvoicesAndPackagesError'));
      success = false;
    }, (response) async {
      if (response.statusCode != 200) {
        success = false;
        emit(GetInvoicesAndPackagesError(
            message: 'GetInvoicesAndPackagesError'));
        emit(GetInvoicesAndPackagesInitial());
      } else {
        success = true;
        GetInvoicesAndPackagesResponse getInvoicesAndPackagesResponse =
            GetInvoicesAndPackagesResponse.fromJson(response.toJson());
        emit(GetInvoicesAndPackagesLoaded(
            getInvoicesAndPackagesResponse: getInvoicesAndPackagesResponse));
        return success;
      }
    });

    return success;
  }
}
