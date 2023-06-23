import 'package:accessories_app/ui/cart/components/body.dart';
import 'package:accessories_app/utils/colors.dart';
import 'package:accessories_app/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: kPrimaryColor),
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
        body: Body());
  }
}
