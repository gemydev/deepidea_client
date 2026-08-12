part of 'submit_sales_delivery_cubit.dart';

sealed class SubmitSalesDeliveryState extends Equatable {
  const SubmitSalesDeliveryState();
}

final class SubmitSalesDeliveryInitial extends SubmitSalesDeliveryState {
  @override
  List<Object> get props => [];
}

final class SubmitSalesDeliveryLoading extends SubmitSalesDeliveryState {
  @override
  List<Object> get props => [];
}

class SubmitSalesDeliveryLoaded extends SubmitSalesDeliveryState {
  final SubmitSalesDeliveryResponse response;

  const SubmitSalesDeliveryLoaded({required this.response});

  @override
  List<Object> get props => [];
}

class SubmitSalesDeliveryError extends SubmitSalesDeliveryState {
  final String message;

  const SubmitSalesDeliveryError({required this.message});

  @override
  List<Object> get props => [];
}
