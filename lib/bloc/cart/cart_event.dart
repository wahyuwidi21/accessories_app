part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class FetchCart extends CartEvent {}

class AddCart extends CartEvent {
  CartModel productModel;
  AddCart(this.productModel);
}

class RemoveCart extends CartEvent {
  CartModel productModel;
  RemoveCart(this.productModel);
}

class RemoveAllCart extends CartEvent {
  RemoveAllCart();
}
