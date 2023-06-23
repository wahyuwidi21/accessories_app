import 'dart:collection';
import 'dart:math';

import 'package:accessories_app/data/model/product_model.dart';
import 'package:accessories_app/data/repository/cart_repository.dart';
import 'package:accessories_app/data/repository/category_repository.dart';
import 'package:accessories_app/data/repository/product_repository.dart';
import 'package:accessories_app/data/repository/transaction_repository.dart';

class RecommendedProductsDomain {
  RecommendedProductsDomain(
      {required this.productRepository,
      required this.transactionRepository,
      required this.categoryRepository});

  ProductRepository productRepository;
  TransactionRepository transactionRepository;
  CategoryRepository categoryRepository;

  Future<List<ProductModel>> getRecommendedProducts() async {
    final allProduct = await productRepository.fetchAllProducts();
    final transactions = await transactionRepository.fetchCartInTransaction();
    final HashMap<List<int>, double> arraySimilarity = HashMap();

    if (transactions.isEmpty) {
      return [];
    }

    for (var i = 0; i < allProduct.length; i++) {
      final all = allProduct[i];
      for (var j = 0; j < transactions.length; j++) {
        final cart = transactions[j];
        for (var k = 0; k < transactions[j].length; k++) {
          final item = cart[k];
          final dot = (item.price * all.price) +
              (item.categoryBinary[0] * all.categoryBinary[0]) +
              (item.categoryBinary[1] * all.categoryBinary[1]) +
              (item.categoryBinary[2] * all.categoryBinary[2]);
          final normCart = sqrt(pow(all.price, 2) +
              pow(all.categoryBinary[0], 2) +
              pow(all.categoryBinary[1], 2) +
              pow(all.categoryBinary[2], 2));

          final normProduct = sqrt(pow(item.price, 2) +
              pow(item.categoryBinary[0], 2) +
              pow(item.categoryBinary[1], 2) +
              pow(item.categoryBinary[2], 2));
          final similarity = dot / (normCart * normProduct);
          arraySimilarity
              .putIfAbsent([item.productId, all.productId], () => similarity);
        }
      }
    }
    var similarityList = arraySimilarity.entries.toList();
    similarityList.sort(((a, b) => b.value.compareTo(a.value)));
    similarityList = similarityList.take(5).toList();
    final List<ProductModel> result = [];
    similarityList.forEach((e) {
      final tobeAdded =
          allProduct.where((element) => element.productId == e.key[1]).first;
      if (!result.contains(tobeAdded)) {
        result.add(tobeAdded);
      }
    });
    // similarityList.map((e) {});

    return result;
  }
}
