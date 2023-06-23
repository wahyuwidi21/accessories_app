part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final List<CartModel> products;

  CartSuccess(this.products);
}

class CartFailed extends CartState {
  final String message;

  CartFailed(this.message);
}

class AddCartSuccess extends CartState {
  AddCartSuccess();
}

class AddCartFailed extends CartState {
  AddCartFailed();
}

class RemoveCartSuccess extends CartState {
  RemoveCartSuccess();
}

class RemoveCartFailed extends CartState {
  RemoveCartFailed();
}

class RemoveAllCartSuccess extends CartState {
  RemoveAllCartSuccess();
}

class RemoveAllCartFailed extends CartState {
  RemoveAllCartFailed();
}
