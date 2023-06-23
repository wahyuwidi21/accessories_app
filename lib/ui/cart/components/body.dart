import 'package:accessories_app/bloc/cart/cart_bloc.dart';
import 'package:accessories_app/bloc/transaction/transaction_bloc.dart';
import 'package:accessories_app/data/repository/cart_repository.dart';
import 'package:accessories_app/data/repository/transaction_repository.dart';
import 'package:accessories_app/ui/cart/components/item_cart.dart';
import 'package:accessories_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late CartBloc cartBloc;
  late TransactionBloc transactionBloc;
  @override
  void initState() {
    cartBloc = CartBloc(context.read<CartRepository>());
    transactionBloc = TransactionBloc(context.read<TransactionRepository>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => cartBloc..add(FetchCart()),
          ),
          BlocProvider(
            create: (context) => transactionBloc,
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<CartBloc, CartState>(
              listener: (context, state) {
                if (state is AddCartSuccess) {
                  cartBloc.add(FetchCart());
                }

                if (state is RemoveCartSuccess) {
                  cartBloc.add(FetchCart());
                }

                if (state is RemoveAllCartSuccess) {
                  cartBloc.add(FetchCart());
                }
              },
            ),
            BlocListener<TransactionBloc, TransactionState>(
              listener: (context, state) {
                if (state is AddTransactionSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Transaksi sukses")));
                  cartBloc.add(RemoveAllCart());
                }
              },
            )
          ],
          child: BlocBuilder<CartBloc, CartState>(builder: ((context, state) {
            if (state is CartSuccess) {
              if (state.products.isEmpty) {
                return const Center(child: Text("Kamu belum berbelanja"));
              }
              return Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                          state.products.length,
                          (index) => ItemCart(
                                state.products[index],
                                onItemAdded: () {
                                  cartBloc.add(AddCart(state.products[index]));
                                },
                                onItemRemoved: () {
                                  cartBloc
                                      .add(RemoveCart(state.products[index]));
                                },
                              )),
                    ),
                  )),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  side: const BorderSide(
                                      width: 1, color: kPrimaryColor),
                                ),
                              ),
                              onPressed: () async {
                                transactionBloc
                                    .add(AddTransaction(state.products));
                              },
                              child: Container(
                                height: 40,
                                alignment: Alignment.center,
                                child: const Text("Proses",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else if (state is CartLoading) {
              return const CircularProgressIndicator();
            } else if (state is CartFailed) {
              return Text("Error");
            } else {
              return SizedBox();
            }
          })),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
