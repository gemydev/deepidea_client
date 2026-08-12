import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/snakbar_manager.dart';
import '../../../data/models/responses/close_ticket.dart';
import '../../../domain/use_cases/close_ticket.dart';

part 'close_ticket_state.dart';

class CloseTicketCubit extends Cubit<CloseTicketState> {
  final CloseTicketUseCase closeTicketUseCase;

  CloseTicketCubit({required this.closeTicketUseCase})
      : super(CloseTicketInitial());

  closeTicket(String ticketId) async {
    emit(CloseTicketLoading());

    final eitherPackagesOrFailure = await closeTicketUseCase(ticketId);

    eitherPackagesOrFailure.fold((failure) {
      emit(const CloseTicketError(message: 'CloseTicketError'));
    }, (response) async {
      if (response.statusCode != 200) {
        emit(const CloseTicketError(message: 'CloseTicketError'));

        emit(CloseTicketInitial());
      } else {
        final closeTicketResponse =
            CloseTicketResponse.fromJson(response.toJson());

        emit(CloseTicketLoaded(response: closeTicketResponse));
        AppSnackBar.success(
          "تم إغلاق التذكرة بنجاح",
        );
      }
    });
  }
}
