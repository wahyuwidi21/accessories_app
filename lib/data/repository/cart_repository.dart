import 'dart:collection';
import 'dart:convert';

import 'package:accessories_app/bloc/cart/cart_bloc.dart';
import 'package:accessories_app/data/model/cart_model.dart';
import 'package:accessories_app/data/model/product_model.dart';
import 'package:accessories_app/data/source/cart_data_source.dart';
import 'package:accessories_app/data/source/entity/product_entity.dart';

class CartRepository {
  CartRepository({required CartDataSource dataSource})
      : _dataSource = dataSource;

  final CartDataSource _dataSource;

  Future<void> addProductToCart(CartModel productModel) async {
    try {
      await _dataSource.addProductToCart(productModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> removeProductFromCart(CartModel productModel) async {
    try {
      await _dataSource.removeProductFromCart(productModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> removeAllCart() async {
    try {
      await _dataSource.removeAllProductFromCart();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<CartModel>> fetchProductsInCart() async {
    final HashMap<ProductEntity, int> value =
        await _dataSource.fetchProductsInCart();
    List<CartModel> result = [];

    value.forEach((key, value) {
      result.add(CartModel(
          productId: key.productId,
          name: key.name,
          category: key.category,
          categoryBinary: json.decode(key.categoryBinary).cast<int>(),
          price: key.price,
          quantity: value));
    });

    return result;
  }
}
