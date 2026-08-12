part of 'get_ticket_faq_cubit.dart';

abstract class GetTicketFaqState extends Equatable {
  const GetTicketFaqState();

  @override
  List<Object?> get props => [];
}

class GetTicketFaqInitial extends GetTicketFaqState {}

class GetTicketFaqLoading extends GetTicketFaqState {}

class GetTicketFaqError extends GetTicketFaqState {
  const GetTicketFaqError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class GetTicketFaqLoaded extends GetTicketFaqState {
  const GetTicketFaqLoaded({
    required this.categories,
    required this.selectedCategoryId,
    required this.faqs,
    this.isLoadingFaqs = false,
  });

  final List<TicketFaqCategory> categories;
  final int? selectedCategoryId;
  final List<TicketFaq> faqs;
  final bool isLoadingFaqs;

  GetTicketFaqLoaded copyWith({
    List<TicketFaqCategory>? categories,
    int? selectedCategoryId,
    List<TicketFaq>? faqs,
    bool? isLoadingFaqs,
  }) {
    return GetTicketFaqLoaded(
      categories: categories ?? this.categories,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      faqs: faqs ?? this.faqs,
      isLoadingFaqs: isLoadingFaqs ?? this.isLoadingFaqs,
    );
  }

  @override
  List<Object?> get props => [categories, selectedCategoryId, faqs, isLoadingFaqs];
}
