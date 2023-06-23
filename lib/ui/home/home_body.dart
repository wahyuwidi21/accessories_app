import 'dart:async';

import 'package:accessories_app/bloc/cart/cart_bloc.dart';
import 'package:accessories_app/bloc/category/category_product_bloc.dart';
import 'package:accessories_app/bloc/product/all_product/all_product_bloc.dart';
import 'package:accessories_app/bloc/product/recommended_product/recommended_product_bloc.dart';
import 'package:accessories_app/data/model/cart_model.dart';
import 'package:accessories_app/data/repository/cart_repository.dart';
import 'package:accessories_app/data/repository/category_repository.dart';
import 'package:accessories_app/data/repository/product_repository.dart';
import 'package:accessories_app/data/repository/transaction_repository.dart';
import 'package:accessories_app/domain/recommended_products_domain.dart';
import 'package:accessories_app/ui/cart/cart_screen.dart';
import 'package:accessories_app/ui/home/components/item_horizontal.dart';
import 'package:accessories_app/ui/home/components/item_vertical.dart';
import 'package:accessories_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({
    Key? key,
  }) : super(key: key);
  @override
  State<HomeBody> createState() => _BodyState();
}

class _BodyState extends State<HomeBody> with WidgetsBindingObserver {
  late CategoryBloc categoryBloc;
  late AllProductBloc allProductBloc;
  late CartBloc cartBloc;
  late RecommendedProductBloc recommendedProductBloc;

  @override
  void initState() {
    categoryBloc = CategoryBloc(context.read<CategoryRepository>());
    allProductBloc = AllProductBloc(context.read<ProductRepository>());
    cartBloc = CartBloc(context.read<CartRepository>());
    recommendedProductBloc = RecommendedProductBloc(
        context.read<ProductRepository>(),
        RecommendedProductsDomain(
            productRepository: context.read<ProductRepository>(),
            transactionRepository: context.read<TransactionRepository>(),
            categoryRepository: context.read<CategoryRepository>()));
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      recommendedProductBloc.add(FetchRecommendedProducts());
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: ((context) => categoryBloc..add(FetchCategory()))),
              BlocProvider(
                  create: ((context) =>
                      allProductBloc..add(FetchAllProducts()))),
              BlocProvider(create: ((context) => cartBloc)),
              BlocProvider(
                  create: ((context) =>
                      recommendedProductBloc..add(FetchRecommendedProducts()))),
            ],
            child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  automaticallyImplyLeading:
                      false, // Used for removing back buttoon.
                  actions: [
                    IconButton(
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: kPrimaryColor,
                      ),
                      tooltip: 'Open shopping cart',
                      onPressed: () {
                        Navigator.pushNamed(context, CartScreen.routeName);
                      },
                    )
                  ],
                  title: const Text(
                    'WARPITONG',
                    style: TextStyle(
                      color: Color(0xff191A1A),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  backgroundColor: Colors.white,
                ),
                body: BlocListener<CartBloc, CartState>(
                    listener: (context, state) {
                      if (state is AddCartSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Barang telah dimasukkan ke keranjang")));
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Rekomendasi untuk kamu",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 5),
                              child: BlocBuilder<RecommendedProductBloc,
                                      RecommendedProductState>(
                                  builder: ((context, state) {
                                if (state is RecommendedProductSuccess) {
                                  return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.generate(
                                            state.products.length,
                                            (index) => ItemHorizontal(
                                                  state.products[index],
                                                  onItemAdded: () {
                                                    cartBloc.add(AddCart(
                                                        CartModel(
                                                            productId: state
                                                                .products[index]
                                                                .productId,
                                                            name: state
                                                                .products[index]
                                                                .name,
                                                            category: state
                                                                .products[index]
                                                                .category,
                                                            categoryBinary: state
                                                                .products[index]
                                                                .categoryBinary,
                                                            price: state
                                                                .products[index]
                                                                .price,
                                                            quantity: 0)));
                                                  },
                                                )),
                                      ));
                                } else if (state is RecommendedProductLoading) {
                                  return const CircularProgressIndicator();
                                } else if (state is RecommendedProductFailed) {
                                  return Container(
                                      padding: EdgeInsets.only(top: 20),
                                      alignment: Alignment.center,
                                      child: Text(state.message.toString()));
                                } else {
                                  return SizedBox();
                                }
                              })),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 16, right: 16, top: 30, bottom: 20),
                              child: Text(
                                "Semua Produk",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child:
                                  BlocBuilder<AllProductBloc, AllProductState>(
                                      builder: ((context, state) {
                                if (state is AllProductSuccess) {
                                  return SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        children: List.generate(
                                            state.products.length,
                                            (index) => ItemVertical(
                                                  state.products[index],
                                                  onItemAdded: () {
                                                    cartBloc.add(AddCart(
                                                        CartModel(
                                                            productId: state
                                                                .products[index]
                                                                .productId,
                                                            name: state
                                                                .products[index]
                                                                .name,
                                                            category: state
                                                                .products[index]
                                                                .category,
                                                            categoryBinary: state
                                                                .products[index]
                                                                .categoryBinary,
                                                            price: state
                                                                .products[index]
                                                                .price,
                                                            quantity: 0)));
                                                  },
                                                )),
                                      ));
                                } else if (state is AllProductLoading) {
                                  return const CircularProgressIndicator();
                                } else if (state is AllProductFailed) {
                                  return Text("Error");
                                } else {
                                  return SizedBox();
                                }
                              })),
                            ),
                          ],
                        ),
                      ),
                    )))),
        onWillPop: () {
          return Future.value(false);
        });
  }
}
