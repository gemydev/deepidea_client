part of 'post_invoices_cubit.dart';

sealed class PostInvoicesState extends Equatable {
  const PostInvoicesState();
}

final class PostInvoicesInitial extends PostInvoicesState {
  @override
  List<Object> get props => [];
}

final class PostInvoicesLoading extends PostInvoicesState {
  @override
  List<Object> get props => [];
}

final class PostInvoicesLoaded extends PostInvoicesState {
  final PostInvoicesWithConfirmResponse postInvoicesWithConfirmResponse;

  const PostInvoicesLoaded({required this.postInvoicesWithConfirmResponse});

  @override
  List<Object> get props => [postInvoicesWithConfirmResponse];
}

final class PostInvoicesError extends PostInvoicesState {
  final String message;

  const PostInvoicesError({required this.message});

  @override
  List<Object> get props => [message];
}
