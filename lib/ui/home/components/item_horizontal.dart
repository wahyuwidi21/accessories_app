import 'package:accessories_app/data/model/product_model.dart';
import 'package:accessories_app/ui/global_component/add_button.dart';
import 'package:accessories_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemHorizontal extends StatelessWidget {
  ProductModel productModel;
  Function()? onItemAdded;
  var formatter = NumberFormat('###,000');

  ItemHorizontal(this.productModel, {super.key, this.onItemAdded});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
        child: Card(
          elevation: 3,
          child: Container(
              width: 220,
              height: 100,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Image.asset(
                      productModel.imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                      flex: 5,
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                productModel.category,
                                style: const TextStyle(
                                    fontSize: 10, color: kPrimaryColor),
                              ),
                              Text(
                                productModel.name,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Rp. ${formatter.format(productModel.price)}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ))),
                  Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [AddButton(onItemAdded)],
                      ))
                ],
              )),
        ));
  }
}
