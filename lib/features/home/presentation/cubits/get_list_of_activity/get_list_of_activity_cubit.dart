import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/responses/get_list_of_activity_response.dart';
import '../../../domain/use_cases/get_list_of_activity_use_case.dart';

part 'get_list_of_activity_state.dart';

class GetListOfActivityCubit extends Cubit<GetListOfActivityState> {
  GetListOfActivityCubit({required this.getListOfActivityUseCase})
      : super(GetListOfActivityInitial());

  final GetListOfActivityUseCase getListOfActivityUseCase;

  Future<void> getListOfActivity() async {
    emit(GetListOfActivityLoading());

    final eitherPackagesOrFailure = await getListOfActivityUseCase(unit);

    eitherPackagesOrFailure.fold((failure) {
      emit(const GetListOfActivityError(message: 'GetListOfActivityError'));
    }, (response) async {
      if (response.statusCode != 200) {
        emit(const GetListOfActivityError(message: 'GetListOfActivityError'));
        emit(GetListOfActivityInitial());
      } else {
        final getListOfActivityResponse =
            GetListOfActivityResponse.fromJson(response);

        emit(GetListOfActivityLoaded(response: getListOfActivityResponse));
      }
    });
  }
}
