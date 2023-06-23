import 'package:accessories_app/data/model/transaction_model.dart';
import 'package:accessories_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ItemTransaction extends StatelessWidget {
  TransactionModel transactionModel;
  var formatter = NumberFormat('###,000');

  ItemTransaction(
    this.transactionModel, {
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Card(
          elevation: 3,
          child: Container(
              width: double.infinity,
              height: 110,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Expanded(
                      flex: 5,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  "Transaksi Selesai",
                                  style: TextStyle(
                                      fontSize: 10, color: kPrimaryColor),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  "TRX${transactionModel.transactionId}",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  "${transactionModel.totalProduct} Item",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ))),
                  Expanded(
                      flex: 5,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Rp. ${formatter.format(transactionModel.totalPrice)}",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ))
                ],
              )),
        ));
  }
}
