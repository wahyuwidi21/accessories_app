import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:accessories_app/data/model/cart_model.dart';
import 'package:accessories_app/data/model/product_model.dart';
import 'package:accessories_app/data/source/entity/cart_entity.dart';
import 'package:accessories_app/data/source/entity/product_entity.dart';
import 'package:accessories_app/data/source/entity/transaction_entity.dart';
import 'package:accessories_app/data/source/prefs.dart';
import 'package:hive/hive.dart';

class TransactionDataSource {
  Box<TransactionEntity> transactionBox =
      Hive.box<TransactionEntity>(TransactionEntity.boxName);
  Box<ProductEntity> productBox =
      Hive.box<ProductEntity>(ProductEntity.boxName);

  Future<void> addCartToTransaction(String list) async {
    try {
      transactionBox
          .add(TransactionEntity(list, await Preferences.getEmailActive()));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<TransactionEntity>> fetchCartInTransaction() async {
    try {
      final email = await Preferences.getEmailActive();

      List<TransactionEntity> transactions = transactionBox.values
          .where((element) => element.email == email)
          .toList();

      return transactions;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
