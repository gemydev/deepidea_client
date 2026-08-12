import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/responses/get_ticket_categories_response.dart';
import '../../../domain/use_cases/get_ticket_categories_use_case.dart';

part 'get_ticket_categories_state.dart';

class GetTicketCategoriesCubit extends Cubit<GetTicketCategoriesState> {
  GetTicketCategoriesCubit({required this.getTicketCategoriesUseCase})
    : super(GetTicketCategoriesInitial());

  final GetTicketCategoriesUseCase getTicketCategoriesUseCase;

  List<Result> _parentCategories = [];

  Future<void> loadParentCategories() async {
    emit(GetTicketCategoriesLoading());

    final eitherOrFailure = await getTicketCategoriesUseCase(const GetTicketCategoriesParams());

    eitherOrFailure.fold((failure) {
      emit(const GetTicketCategoriesError(message: 'GetTicketCategoriesError'));
    }, (response) {
      if (response.statusCode != 200) {
        emit(const GetTicketCategoriesError(message: 'GetTicketCategoriesError'));
        return;
      }
      _parentCategories = response.result ?? [];
      emit(
        GetTicketCategoriesLoaded(
          parentCategories: _parentCategories,
          subCategories: const [],
          isLoadingSubCategories: false,
        ),
      );
    });
  }

  Future<void> loadSubCategories(int parentId) async {
    final current = state;
    if (current is GetTicketCategoriesLoaded) {
      emit(current.copyWith(isLoadingSubCategories: true, subCategories: const []));
    } else {
      emit(GetTicketCategoriesLoading());
    }

    final eitherOrFailure = await getTicketCategoriesUseCase(
      GetTicketCategoriesParams(parentId: parentId),
    );

    eitherOrFailure.fold((failure) {
      emit(const GetTicketCategoriesError(message: 'GetTicketCategoriesError'));
    }, (response) {
      if (response.statusCode != 200) {
        emit(const GetTicketCategoriesError(message: 'GetTicketCategoriesError'));
        return;
      }
      emit(
        GetTicketCategoriesLoaded(
          parentCategories: _parentCategories,
          subCategories: response.result ?? [],
          isLoadingSubCategories: false,
        ),
      );
    });
  }

  /// Kept for backward compatibility — loads main categories only.
  Future<void> getTicketCategories() => loadParentCategories();
}
