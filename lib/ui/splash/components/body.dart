import 'package:accessories_app/bloc/category/category_product_bloc.dart';
import 'package:accessories_app/bloc/product/all_product/all_product_bloc.dart';
import 'package:accessories_app/data/repository/category_repository.dart';
import 'package:accessories_app/data/repository/product_repository.dart';
import 'package:accessories_app/ui/onboarding/onboarding_screen.dart';
import 'package:accessories_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late CategoryBloc categoryBloc;
  late AllProductBloc recommendedProductBloc;
  var insertingFinished = 0;
  @override
  void initState() {
    categoryBloc = CategoryBloc(context.read<CategoryRepository>());
    recommendedProductBloc = AllProductBloc(context.read<ProductRepository>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: ((context) => categoryBloc..add(AddAllCategory()))),
          BlocProvider(
              create: ((context) =>
                  recommendedProductBloc..add(AddAllProduct())))
        ],
        child: MultiBlocListener(
            listeners: [
              BlocListener<CategoryBloc, CategoryState>(
                listener: (context, state) {
                  if (state is AddAllCategorySuccess) {
                    insertingFinished += 1;
                    if (insertingFinished == 2) {
                      Navigator.popAndPushNamed(
                          context, OnBoardingScreen.routeName);
                    }
                  }
                },
              ),
              BlocListener<AllProductBloc, AllProductState>(
                listener: (context, state) {
                  if (state is AddAllProductSuccess) {
                    insertingFinished += 1;
                    if (insertingFinished == 2) {
                      Navigator.popAndPushNamed(
                          context, OnBoardingScreen.routeName);
                    }
                  }
                },
              ),
            ],
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                ),
                Container(
                  decoration: const BoxDecoration(
                      backgroundBlendMode: BlendMode.multiply,
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [kPrimaryColor, kPrimaryColor])),
                  width: double.infinity,
                  height: double.infinity,
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: SvgPicture.asset(
                            "assets/icons/ic_app.svg",
                          ),
                        ),
                      ],
                    )),
                  ],
                )
              ],
            )));
  }
}
