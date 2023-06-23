import 'dart:async';
import 'dart:collection';

import 'package:accessories_app/data/model/cart_model.dart';
import 'package:accessories_app/data/model/product_model.dart';
import 'package:accessories_app/data/source/entity/cart_entity.dart';
import 'package:accessories_app/data/source/entity/product_entity.dart';
import 'package:accessories_app/data/source/prefs.dart';
import 'package:hive/hive.dart';

class CartDataSource {
  Box<CartEntity> cartBox = Hive.box<CartEntity>(CartEntity.boxName);
  Box<ProductEntity> productBox =
      Hive.box<ProductEntity>(ProductEntity.boxName);

  Future<void> addProductToCart(CartModel productModel) async {
    try {
      final cartById = cartBox.values
          .where((element) => element.productId == productModel.productId)
          .firstOrNull;
      if (cartById == null) {
        cartBox.add(CartEntity(
            productModel.productId, 1, await Preferences.getEmailActive()));
      } else {
        cartBox.put(
            cartById.key,
            CartEntity(productModel.productId, cartById.quantity + 1,
                await Preferences.getEmailActive()));
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> removeProductFromCart(CartModel productModel) async {
    try {
      final cartById = cartBox.values
          .where((element) => element.productId == productModel.productId)
          .first;
      if (cartById.quantity == 1) {
        cartBox.delete(cartById.key);
      } else {
        cartBox.put(
            cartById.key,
            CartEntity(productModel.productId, cartById.quantity - 1,
                await Preferences.getEmailActive()));
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> removeAllProductFromCart() async {
    try {
      final email = await Preferences.getEmailActive();
      final keys = cartBox.values
          .where((element) => element.email == email)
          .map((e) => e.key)
          .toList();
      cartBox.deleteAll(keys);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<HashMap<ProductEntity, int>> fetchProductsInCart() async {
    try {
      final email = await Preferences.getEmailActive();
      List<CartEntity> cart =
          cartBox.values.where((element) => element.email == email).toList();
      HashMap<ProductEntity, int> map = HashMap();

      for (var e in cart) {
        map.putIfAbsent(
            productBox.values
                .where((element) => element.productId == e.productId)
                .first,
            () => e.quantity);
      }

      return map;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
