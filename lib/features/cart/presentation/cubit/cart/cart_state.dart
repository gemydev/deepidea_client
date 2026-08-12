part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartEmpty extends CartState {}

class CartLoaded extends CartState {
  final Package? cartPackage;
  final List<ServiceItem> cartServices;
  final int itemCount;

  const CartLoaded({
    this.cartPackage,
    this.cartServices = const [],
    required this.itemCount,
  });

  @override
  List<Object?> get props => [cartPackage, cartServices, itemCount];
}
