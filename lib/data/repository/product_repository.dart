import 'dart:convert';

import 'package:accessories_app/data/model/product_model.dart';
import 'package:accessories_app/data/source/product_data_source.dart';

class ProductRepository {
  ProductRepository({required ProductDataSource dataSource})
      : _dataSource = dataSource;

  final ProductDataSource _dataSource;

  Future<void> addProduct(ProductModel productModel) async {
    try {
      await _dataSource.addProduct(productModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addAllProduct(List<ProductModel> listProductModel) async {
    try {
      await _dataSource.addAllProduct(listProductModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ProductModel>> fetchAllProducts() async {
    final value = await _dataSource.fetchAllProducts();
    return value
        .map((e) => ProductModel(
            productId: e.productId,
            name: e.name,
            categoryId: e.categoryId,
            category: e.category,
            categoryBinary: json.decode(e.categoryBinary).cast<int>(),
            price: e.price,
            imageUrl: e.imageUrl))
        .toList();
  }
}
