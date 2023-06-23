import 'dart:collection';
import 'dart:convert';

import 'package:accessories_app/data/model/cart_model.dart';
import 'package:accessories_app/data/model/transaction_model.dart';
import 'package:accessories_app/data/source/entity/product_entity.dart';
import 'package:accessories_app/data/source/entity/transaction_entity.dart';
import 'package:accessories_app/data/source/transaction_data_source.dart';

class TransactionRepository {
  TransactionRepository({required TransactionDataSource dataSource})
      : _dataSource = dataSource;

  final TransactionDataSource _dataSource;

  Future<void> addCartToTransaction(List<CartModel> listCart) async {
    try {
      await _dataSource.addCartToTransaction(
          jsonEncode(List<dynamic>.from(listCart.map((x) => x.toJson()))));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<TransactionModel>> fetchTransactions() async {
    List<TransactionModel> result = [];
    final data = await _dataSource.fetchCartInTransaction();
    for (var e in data) {
      List<CartModel> listCart = List<CartModel>.from(
          jsonDecode(e.listCart).map((x) => CartModel.fromJson(x)));
      var totalPrice = 0;
      var totalProduct = listCart.length;

      for (var f in listCart) {
        totalPrice += f.price * f.quantity;
      }

      result.add(TransactionModel(
          transactionId: e.key.toString(),
          totalPrice: totalPrice,
          totalProduct: totalProduct));
    }
    return result;
  }

  Future<List<List<CartModel>>> fetchCartInTransaction() async {
    final data = await _dataSource.fetchCartInTransaction();
    List<List<CartModel>> list = [];
    list = data.map((e) {
      return List<CartModel>.from(
          jsonDecode(e.listCart).map((x) => CartModel.fromJson(x)));
    }).toList();
    if (list.isEmpty) {
      return [];
    }
    return list;
  }
}
