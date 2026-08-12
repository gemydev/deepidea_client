part of 'client_subscription_status_cubit.dart';

sealed class ClientSubscriptionStatusState extends Equatable {
  const ClientSubscriptionStatusState();

  @override
  List<Object?> get props => [];
}

final class ClientSubscriptionStatusInitial extends ClientSubscriptionStatusState {
  const ClientSubscriptionStatusInitial();
}

final class ClientSubscriptionStatusLoading extends ClientSubscriptionStatusState {
  const ClientSubscriptionStatusLoading();
}

final class ClientSubscriptionStatusLoaded extends ClientSubscriptionStatusState {
  const ClientSubscriptionStatusLoaded({required this.response});

  final ClientSubscriptionStatusResponse response;

  @override
  List<Object?> get props => [response];
}

final class ClientSubscriptionStatusError extends ClientSubscriptionStatusState {
  const ClientSubscriptionStatusError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
