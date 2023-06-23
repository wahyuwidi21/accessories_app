import 'package:accessories_app/bloc/cart/cart_bloc.dart';
import 'package:accessories_app/bloc/transaction/transaction_bloc.dart';
import 'package:accessories_app/data/repository/transaction_repository.dart';
import 'package:accessories_app/ui/transaction/components/item_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<TransactionBody> {
  late TransactionBloc transactionBloc;

  @override
  void initState() {
    transactionBloc = TransactionBloc(context.read<TransactionRepository>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Used for removing back buttoon.
          centerTitle: true,
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
        body: BlocProvider(
            create: (context) => transactionBloc..add(FetchTransaction()),
            child: SingleChildScrollView(
              child: BlocBuilder<TransactionBloc, TransactionState>(
                  builder: ((context, state) {
                if (state is TransactionSuccess) {
                  if (state.transactions.isEmpty) {
                    return const Center(child: Text("Kamu belum berbelanja"));
                  }
                  return Column(
                    children: List.generate(
                        state.transactions.length,
                        (index) => ItemTransaction(
                              state.transactions[index],
                            )),
                  );
                } else if (state is CartLoading) {
                  return const CircularProgressIndicator();
                } else if (state is CartFailed) {
                  return const Text("Error");
                } else {
                  return const SizedBox();
                }
              })),
            )));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
