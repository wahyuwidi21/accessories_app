import 'dart:async';

import 'package:accessories_app/ui/home/home_body.dart';
import 'package:accessories_app/ui/transaction/transaction_body.dart';
import 'package:accessories_app/utils/colors.dart';
import 'package:accessories_app/ui/profile/profile_body.dart';
import 'package:accessories_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainScreen extends StatefulWidget {
  static String routeName = "/mainscreen";
  final HomeBody homeBody = HomeBody();
  final TransactionBody transactionBody = TransactionBody();
  final ProfileBody profileBody = ProfileBody(userName: "userName");
  @override
  State<StatefulWidget> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  final StreamController streamController = StreamController();
  static Color inActiveIconColor = const Color(0xFFAAACAF);
  int _index = 0;
  // LayerChanging _layerChanging = LayerChanging();
  bool poiShowed = false;
  bool buildingShowed = false;
  bool streetShowed = false;
  bool bpsShowed = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: _validateBody(),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed, // Fixed
            backgroundColor: Colors.white, // <-- This works for fixed
            selectedItemColor: Colors.black,
            selectedIconTheme: const IconThemeData(color: kPrimaryColor),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            unselectedFontSize: 0,
            selectedFontSize: 0,
            unselectedItemColor: inActiveIconColor,
            onTap: (index) {
              setState(() {
                _index = index;
              });
            },
            currentIndex: _index,
            items: [
              BottomNavigationBarItem(
                icon: SizedBox(
                    height: 48,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/ic_home.svg",
                          colorFilter: ColorFilter.mode(
                              _index == 0 ? kPrimaryColor : inActiveIconColor,
                              BlendMode.srcATop),
                          height: 18,
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text("Home",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: _index == 0
                                      ? Colors.black
                                      : inActiveIconColor,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ],
                    )),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                    height: 48,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/ic_transaction.svg",
                          colorFilter: ColorFilter.mode(
                              _index == 1 ? kPrimaryColor : inActiveIconColor,
                              BlendMode.srcATop),
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text("Transaksi",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: _index == 1
                                      ? Colors.black
                                      : inActiveIconColor,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ],
                    )),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                    height: 48,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/ic_profile.svg",
                          colorFilter: ColorFilter.mode(
                              _index == 2 ? kPrimaryColor : inActiveIconColor,
                              BlendMode.srcATop),
                          height: 18,
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text("Profile",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: _index == 2
                                      ? Colors.black
                                      : inActiveIconColor,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ],
                    )),
                label: '',
              ),
            ]));
  }

  Widget _validateBody() {
    if (_index == 0) {
      return widget.homeBody;
    }

    if (_index == 1) {
      return widget.transactionBody;
    }

    if (_index == 2) {
      return widget.profileBody;
    }

    return const SizedBox();
  }
}
