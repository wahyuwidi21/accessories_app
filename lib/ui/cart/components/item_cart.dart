import 'package:accessories_app/data/model/cart_model.dart';
import 'package:accessories_app/data/model/product_model.dart';
import 'package:accessories_app/ui/global_component/add_button.dart';
import 'package:accessories_app/ui/global_component/remove_button.dart';
import 'package:accessories_app/utils/colors.dart';
import 'package:flutter/material.dart';

class ItemCart extends StatelessWidget {
  CartModel carttModel;
  Function()? onItemAdded;
  Function()? onItemRemoved;

  ItemCart(this.carttModel, {super.key, this.onItemAdded, this.onItemRemoved});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Card(
          elevation: 3,
          child: Container(
              width: double.infinity,
              height: 80,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Expanded(
                      flex: 5,
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                carttModel.category,
                                style: const TextStyle(
                                    fontSize: 10, color: kPrimaryColor),
                              ),
                              Text(
                                carttModel.name,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Rp. ${carttModel.quantity * carttModel.price}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ))),
                  Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                              width: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RemoveButton(onItemRemoved),
                                  Text(
                                    "${carttModel.quantity}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  AddButton(onItemAdded),
                                ],
                              ))
                        ],
                      ))
                ],
              )),
        ));
  }
}
