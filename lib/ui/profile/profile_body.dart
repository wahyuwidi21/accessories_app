import 'dart:io';

import 'package:accessories_app/ui/profile/components/header_profile.dart';
import 'package:accessories_app/ui/profile/components/logout_dialog.dart';
import 'package:accessories_app/ui/profile/components/menu_item.dart';
import 'package:flutter/material.dart';

class ProfileBody extends StatelessWidget {
  ProfileBody({Key? key, required this.userName}) : super(key: key);

  String userName;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(alignment: Alignment.topCenter, children: [
        Container(
          decoration: const BoxDecoration(
            color: Color(0xffe5e5e5),
          ),
          width: double.infinity,
          height: double.infinity,
        ),
        SingleChildScrollView(
            child: Column(
          children: [
            HeaderProfile(),
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              child: Column(
                children: [
                  ProfileMenuItem(
                      onMenuClicked: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return LogoutDialog();
                            });
                      },
                      menuIconUri: "assets/icons/ic_logout.svg",
                      menuName: "Keluar"),
                ],
              ),
            )
          ],
        ))
      ]),
    );
  }
}
