import 'dart:async';
import 'dart:convert';

import 'package:accessories_app/data/model/product_model.dart';
import 'package:accessories_app/data/source/entity/product_entity.dart';
import 'package:accessories_app/data/source/entity/user_entity.dart';
import 'package:hive/hive.dart';

class ProductDataSource {
  Box<ProductEntity> productBox = Hive.box<ProductEntity>('productBox');

  Future<void> addProduct(ProductModel productModel) async {
    try {
      productBox.add(ProductEntity(
          productModel.productId,
          productModel.name,
          productModel.categoryId,
          productModel.category,
          jsonEncode(productModel.categoryBinary),
          productModel.imageUrl,
          productModel.price));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addAllProduct(List<ProductModel> listProductModel) async {
    try {
      final productEntities = listProductModel
          .map((productModel) => ProductEntity(
              productModel.productId,
              productModel.name,
              productModel.categoryId,
              productModel.category,
              jsonEncode(productModel.categoryBinary),
              productModel.imageUrl,
              productModel.price))
          .toList();
      productBox.addAll(productEntities);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ProductEntity>> fetchAllProducts() async {
    try {
      Iterable products = productBox.values;
      return products.toList() as FutureOr<List<ProductEntity>>;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ProductEntity> fetchProductsById(int id) async {
    try {
      Iterable products =
          productBox.values.where((element) => element.productId == id);
      return products.toList()[0] as FutureOr<ProductEntity>;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
