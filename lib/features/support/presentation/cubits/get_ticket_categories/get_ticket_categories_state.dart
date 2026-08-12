part of 'get_ticket_categories_cubit.dart';

abstract class GetTicketCategoriesState extends Equatable {
  const GetTicketCategoriesState();

  @override
  List<Object?> get props => [];
}

class GetTicketCategoriesInitial extends GetTicketCategoriesState {
  @override
  List<Object?> get props => [];
}

class GetTicketCategoriesLoading extends GetTicketCategoriesState {
  @override
  List<Object?> get props => [];
}

class GetTicketCategoriesLoaded extends GetTicketCategoriesState {
  const GetTicketCategoriesLoaded({
    required this.parentCategories,
    required this.subCategories,
    this.isLoadingSubCategories = false,
  });

  final List<Result> parentCategories;
  final List<Result> subCategories;
  final bool isLoadingSubCategories;

  GetTicketCategoriesLoaded copyWith({
    List<Result>? parentCategories,
    List<Result>? subCategories,
    bool? isLoadingSubCategories,
  }) {
    return GetTicketCategoriesLoaded(
      parentCategories: parentCategories ?? this.parentCategories,
      subCategories: subCategories ?? this.subCategories,
      isLoadingSubCategories: isLoadingSubCategories ?? this.isLoadingSubCategories,
    );
  }

  @override
  List<Object?> get props => [parentCategories, subCategories, isLoadingSubCategories];
}

class GetTicketCategoriesError extends GetTicketCategoriesState {
  const GetTicketCategoriesError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
