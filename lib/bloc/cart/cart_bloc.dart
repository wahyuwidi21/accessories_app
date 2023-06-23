import 'dart:async';
import 'dart:io';

import 'package:accessories_app/data/model/cart_model.dart';
import 'package:accessories_app/data/model/product_model.dart';
import 'package:accessories_app/data/repository/cart_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this.cartRepository) : super(CartInitial()) {
    on<FetchCart>((event, emit) => _mapFetchCart(emit, event));
    on<AddCart>((event, emit) => _mapAddCart(emit, event));
    on<RemoveCart>((event, emit) => _mapRemoveCart(emit, event));
    on<RemoveAllCart>((event, emit) => _mapRemoveAllCart(emit));
  }
  final CartRepository cartRepository;

  Future<void> _mapFetchCart(Emitter<CartState> emit, FetchCart event) async {
    emit(CartLoading());
    try {
      emit(CartSuccess(await cartRepository.fetchProductsInCart()));
    } on HttpException catch (e) {
      emit(CartFailed(e.message));
    } on Exception catch (e) {
      emit(CartFailed(e.toString()));
    }
  }

  Future<void> _mapAddCart(Emitter<CartState> emit, AddCart event) async {
    try {
      await cartRepository.addProductToCart(event.productModel);
      emit(AddCartSuccess());
    } on Exception catch (e) {
      emit(AddCartFailed());
    }
  }

  Future<void> _mapRemoveCart(Emitter<CartState> emit, RemoveCart event) async {
    try {
      await cartRepository.removeProductFromCart(event.productModel);
      emit(RemoveCartSuccess());
    } on Exception catch (e) {
      emit(RemoveCartFailed());
    }
  }

  Future<void> _mapRemoveAllCart(Emitter<CartState> emit) async {
    try {
      await cartRepository.removeAllCart();
      emit(RemoveAllCartSuccess());
    } on Exception catch (e) {
      emit(RemoveAllCartFailed());
    }
  }
}
