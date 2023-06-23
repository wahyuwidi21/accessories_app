import 'package:accessories_app/app.dart';
import 'package:accessories_app/data/repository/cart_repository.dart';
import 'package:accessories_app/data/repository/category_repository.dart';
import 'package:accessories_app/data/repository/product_repository.dart';
import 'package:accessories_app/data/repository/auth_repository.dart';
import 'package:accessories_app/data/repository/transaction_repository.dart';
import 'package:accessories_app/data/source/cart_data_source.dart';
import 'package:accessories_app/data/source/category_data_source.dart';
import 'package:accessories_app/data/source/entity/cart_entity.dart';
import 'package:accessories_app/data/source/entity/category_entity.dart';
import 'package:accessories_app/data/source/entity/product_entity.dart';
import 'package:accessories_app/data/source/entity/transaction_entity.dart';
import 'package:accessories_app/data/source/product_data_source.dart';
import 'package:accessories_app/data/source/auth_data_source.dart';
import 'package:accessories_app/data/source/entity/user_entity.dart';
import 'package:accessories_app/data/source/transaction_data_source.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  Hive.registerAdapter<UserEntity>(UserEntityAdapter());
  Hive.registerAdapter<ProductEntity>(ProductEntityAdapter());
  Hive.registerAdapter<CategoryEntity>(CategoryEntityAdapter());
  Hive.registerAdapter<CartEntity>(CartEntityAdapter());
  Hive.registerAdapter<TransactionEntity>(TransactionEntityAdapter());

  await Hive.openBox<UserEntity>(UserEntity.boxName);
  await Hive.openBox<ProductEntity>(ProductEntity.boxName);
  await Hive.openBox<CategoryEntity>(CategoryEntity.boxName);
  await Hive.openBox<CartEntity>(CartEntity.boxName);
  await Hive.openBox<TransactionEntity>(TransactionEntity.boxName);

  AuthDataSource profileDataSource = AuthDataSource();
  AuthRepository profileRepository =
      AuthRepository(dataSource: profileDataSource);

  ProductDataSource productDataSource = ProductDataSource();
  ProductRepository productRepository =
      ProductRepository(dataSource: productDataSource);

  CategoryDataSource categoryDataSource = CategoryDataSource();
  CategoryRepository categoryRepository =
      CategoryRepository(dataSource: categoryDataSource);

  CartDataSource cartDataSource = CartDataSource();
  CartRepository cartRepository = CartRepository(dataSource: cartDataSource);

  TransactionDataSource transactionDataSource = TransactionDataSource();
  TransactionRepository transactionRepository =
      TransactionRepository(dataSource: transactionDataSource);
  runApp(MyApp(
    profileRepository: profileRepository,
    productRepository: productRepository,
    categoryRepository: categoryRepository,
    cartRepository: cartRepository,
    transactionRepository: transactionRepository,
  ));
}
