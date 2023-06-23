import 'package:accessories_app/data/repository/cart_repository.dart';
import 'package:accessories_app/data/repository/category_repository.dart';
import 'package:accessories_app/data/repository/product_repository.dart';
import 'package:accessories_app/data/repository/auth_repository.dart';
import 'package:accessories_app/data/repository/transaction_repository.dart';
import 'package:accessories_app/domain/recommended_products_domain.dart';
import 'package:accessories_app/ui/splash/splash_screen.dart';
import 'package:accessories_app/utils/routes.dart';
import 'package:accessories_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp(
      {Key? key,
      required AuthRepository profileRepository,
      required ProductRepository productRepository,
      required CategoryRepository categoryRepository,
      required CartRepository cartRepository,
      required TransactionRepository transactionRepository})
      : _profileRepository = profileRepository,
        _productRepository = productRepository,
        _categoryRepository = categoryRepository,
        _cartRepository = cartRepository,
        _transactionRepository = transactionRepository,
        super(key: key);
  final AuthRepository _profileRepository;
  final ProductRepository _productRepository;
  final CategoryRepository _categoryRepository;
  final CartRepository _cartRepository;
  final TransactionRepository _transactionRepository;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: _profileRepository),
          RepositoryProvider.value(value: _productRepository),
          RepositoryProvider.value(value: _categoryRepository),
          RepositoryProvider.value(value: _cartRepository),
          RepositoryProvider.value(value: _transactionRepository),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: theme(),
          // home: SplashScreen(),
          // We use routeName so that we dont need to remember the name
          initialRoute: SplashScreen.routeName,
          // SplashScreen.routeName,
          routes: routes,
        ));
  }
}
