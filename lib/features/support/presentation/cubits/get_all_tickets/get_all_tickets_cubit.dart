import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/responses/get_all_tickets_response.dart';
import '../../../domain/use_cases/get_all_tickets_use_case.dart';

part 'get_all_tickets_state.dart';

class GetAllTicketsCubit extends Cubit<GetAllTicketsState> {
  final GetAllTicketsUseCase getAllTicketsUseCase;

  GetAllTicketsCubit({required this.getAllTicketsUseCase})
    : super(GetAllTicketsInitial());

  getAllTickets() async {
    emit(GetAllTicketsLoading());

    final eitherPackagesOrFailure = await getAllTicketsUseCase(unit);

    eitherPackagesOrFailure.fold(
      (failure) {
        if (isClosed) return;
        emit(const GetAllTicketsError(message: 'GetAllTicketsError'));
      },
      (response) async {
        if (isClosed) return;

        if (response.statusCode != 200) {
          if (isClosed) return;
          emit(const GetAllTicketsError(message: 'GetAllTicketsError'));
          if (isClosed) return;
          emit(GetAllTicketsInitial());
        } else {
          final getAllTicketsResponse = GetAllTicketsResponse.fromJson(
            response.toJson(),
          );

          final currentTickets =
              getAllTicketsResponse.result
                  ?.where((ticket) => ticket.statusId == 6)
                  .toList() ??
              [];

          final underProgressTickets =
              getAllTicketsResponse.result
                  ?.where((ticket) => ticket.statusId == 8)
                  .toList() ??
              [];

          final closedTickets =
              getAllTicketsResponse.result
                  ?.where((ticket) => ticket.statusId == 4)
                  .toList() ??
              [];

          if (isClosed) return;
          emit(
            GetAllTicketsLoaded(
              response: getAllTicketsResponse,
              currentTickets: currentTickets,
              closedTickets: closedTickets,
              underProgressTickets: underProgressTickets,
            ),
          );
        }
      },
    );
  }
}
