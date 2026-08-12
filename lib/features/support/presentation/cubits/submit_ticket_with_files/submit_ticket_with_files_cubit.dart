import 'package:remotely/features/support/data/models/responses/submit_ticket_with_files_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;

import '../../../../../core/error/failure.dart';
import '../../../../../core/helpers/snakbar_manager.dart';
import '../../../data/models/requests/submit_ticket_with_files_request.dart';
import '../../../domain/use_cases/submit_ticket_with_files_use_case.dart';

part 'submit_ticket_with_files_state.dart';

class SubmitTicketWithFilesCubit extends Cubit<SubmitTicketWithFilesState> {
  final SubmitTicketWithFilesUseCase submitTicketWithFilesUseCase;

  SubmitTicketWithFilesCubit({required this.submitTicketWithFilesUseCase})
    : super(SubmitTicketWithFilesInitial());

  submitTicketWithFiles(TicketSubmissionRequest request) async {
    emit(SubmitTicketWithFilesLoading());

    final eitherPackagesOrFailure = await submitTicketWithFilesUseCase(request);

    eitherPackagesOrFailure.fold(
      (failure) {
        if (failure is ServerFailure) {
          AppSnackBar.error(failure.message.toString());
        }
        emit(const SubmitTicketWithFilesError(message: 'SubmitTicketWithFilesError'));
      },
      (response) async {
        if (response.statusCode != 200) {
          emit(const SubmitTicketWithFilesError(message: 'SubmitTicketWithFilesError'));
          emit(SubmitTicketWithFilesInitial());

          AppSnackBar.error(response.message.toString());
        } else {
          final submitTicketWithFilesResponse = SubmitTicketWithFilesResponse.fromJson(
            response.toJson(),
          );
          emit(SubmitTicketWithFilesLoaded(response: submitTicketWithFilesResponse));
        }
      },
    );
  }
}
