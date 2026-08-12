import 'package:remotely/core/helpers/snakbar_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/requests/re_open_ticket_request.dart';
import '../../../data/models/responses/re_open_ticket_response.dart';
import '../../../domain/use_cases/re_open_ticket.dart';

part 're_open_ticket_state.dart';

class ReOpenTicketCubit extends Cubit<ReOpenTicketState> {
  final ReOpenTicketUseCase reOpenTicketUseCase;

  ReOpenTicketCubit({required this.reOpenTicketUseCase}) : super(ReOpenTicketInitial());

  Future<void> reOpenTicket(ReOpenTicketRequest request) async {
    emit(ReOpenTicketLoading());

    final eitherPackagesOrFailure = await reOpenTicketUseCase(request);

    eitherPackagesOrFailure.fold(
      (failure) {
        emit(const ReOpenTicketError(message: 'ReOpenTicketError'));
      },
      (response) async {
        if (response.statusCode != 200) {
          emit(const ReOpenTicketError(message: 'ReOpenTicketError'));
          emit(ReOpenTicketInitial());
        } else {
          final reOpenTicketResponse = ReOpenTicketResponse.fromJson(response.toJson());
          AppSnackBar.success(reOpenTicketResponse.message.toString());
          emit(ReOpenTicketLoaded(response: reOpenTicketResponse));
        }
      },
    );
  }
}
