import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/responses/ticket_faq.dart';
import '../../../domain/use_cases/get_all_ticket_faq_use_case.dart';
import '../../../domain/use_cases/get_faqs_by_category_use_case.dart';

part 'get_ticket_faq_state.dart';

class GetTicketFaqCubit extends Cubit<GetTicketFaqState> {
  GetTicketFaqCubit({
    required this.getAllTicketFaqUseCase,
    required this.getFaqsByCategoryUseCase,
  }) : super(GetTicketFaqInitial());

  final GetAllTicketFaqUseCase getAllTicketFaqUseCase;
  final GetFaqsByCategoryUseCase getFaqsByCategoryUseCase;

  Future<void> loadFaqs() async {
    emit(GetTicketFaqLoading());

    final eitherOrFailure = await getAllTicketFaqUseCase(unit);

    eitherOrFailure.fold(
      (_) => emit(const GetTicketFaqError(message: 'تعذر تحميل الأسئلة الشائعة')),
      (response) {
        if (response.statusCode != 200) {
          emit(
            GetTicketFaqError(
              message: response.message?.isNotEmpty == true
                  ? response.message!
                  : 'تعذر تحميل الأسئلة الشائعة',
            ),
          );
          return;
        }

        final categories = response.result ?? [];
        if (categories.isEmpty) {
          emit(
            const GetTicketFaqLoaded(
              categories: [],
              selectedCategoryId: null,
              faqs: [],
            ),
          );
          return;
        }

        final firstCategoryId = categories.first.categoryId?.toInt();
        emit(
          GetTicketFaqLoaded(
            categories: categories,
            selectedCategoryId: firstCategoryId,
            faqs: const [],
            isLoadingFaqs: true,
          ),
        );

        if (firstCategoryId != null) {
          selectCategory(firstCategoryId, categories: categories);
        }
      },
    );
  }

  Future<void> selectCategory(int categoryId, {List<TicketFaqCategory>? categories}) async {
    final current = state;
    final categoryList = categories ??
        (current is GetTicketFaqLoaded ? current.categories : const <TicketFaqCategory>[]);

    emit(
      GetTicketFaqLoaded(
        categories: categoryList,
        selectedCategoryId: categoryId,
        faqs: current is GetTicketFaqLoaded && current.selectedCategoryId == categoryId
            ? current.faqs
            : const [],
        isLoadingFaqs: true,
      ),
    );

    final eitherOrFailure = await getFaqsByCategoryUseCase(
      GetFaqsByCategoryParams(categoryId: categoryId),
    );

    eitherOrFailure.fold(
      (_) {
        final fallback = categoryList
            .where((c) => c.categoryId?.toInt() == categoryId)
            .expand((c) => c.faqs)
            .toList();
        emit(
          GetTicketFaqLoaded(
            categories: categoryList,
            selectedCategoryId: categoryId,
            faqs: fallback,
            isLoadingFaqs: false,
          ),
        );
      },
      (response) {
        if (response.statusCode != 200) {
          emit(const GetTicketFaqError(message: 'تعذر تحميل أسئلة التصنيف'));
          return;
        }
        emit(
          GetTicketFaqLoaded(
            categories: categoryList,
            selectedCategoryId: categoryId,
            faqs: response.result ?? [],
            isLoadingFaqs: false,
          ),
        );
      },
    );
  }
}
