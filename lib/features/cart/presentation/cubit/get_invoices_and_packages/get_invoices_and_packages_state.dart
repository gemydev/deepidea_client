part of 'get_invoices_and_packages_cubit.dart';

sealed class GetInvoicesAndPackagesState extends Equatable {
  const GetInvoicesAndPackagesState();
}

final class GetInvoicesAndPackagesInitial extends GetInvoicesAndPackagesState {
  @override
  List<Object> get props => [];
}

final class GetInvoicesAndPackagesLoading extends GetInvoicesAndPackagesState {
  @override
  List<Object> get props => [];
}

final class GetInvoicesAndPackagesLoaded extends GetInvoicesAndPackagesState {
  final GetInvoicesAndPackagesResponse getInvoicesAndPackagesResponse;

  const GetInvoicesAndPackagesLoaded(
      {required this.getInvoicesAndPackagesResponse});

  @override
  List<Object> get props => [getInvoicesAndPackagesResponse];
}

final class GetInvoicesAndPackagesError extends GetInvoicesAndPackagesState {
  final String message;

  const GetInvoicesAndPackagesError({required this.message});

  @override
  List<Object> get props => [message];
}
