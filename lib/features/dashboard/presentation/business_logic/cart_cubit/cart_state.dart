part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartUpdated extends CartState {
  final List<CartProductsEntity> cart;

  const CartUpdated(this.cart);

  @override
  List<Object> get props => [cart];
}

final class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object> get props => [message];
}

final class CheckoutCartEditToggled extends CartState {
  final bool isEditing;
  const CheckoutCartEditToggled(this.isEditing);

  @override
  List<Object> get props => [isEditing];
}

final class CartCheckoutSuccess extends CartState {
  final String message;

  const CartCheckoutSuccess(this.message);

  @override
  List<Object> get props => [message];
}