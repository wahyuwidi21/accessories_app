import 'package:accessories_app/data/source/prefs.dart';
import 'package:accessories_app/ui/login/login_screen.dart';
import 'package:accessories_app/utils/colors.dart';
import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 34),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 19),
            height: 134,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Card(
                elevation: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Apakah anda yakin ingin keluar?",
                      style: TextStyle(color: Color(0xff333333), fontSize: 14),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.only(
                                    top: 13.8, bottom: 12.8),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                                side: const BorderSide(
                                    color: kPrimaryColor, width: 1)),
                            child: const Text(
                              "BATAL",
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.only(
                                  top: 13.8, bottom: 12.8),
                              backgroundColor: kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              side: const BorderSide(
                                  color: kPrimaryColor, width: 1)),
                          child: const Text(
                            "KELUAR",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 11),
                          ),
                          onPressed: () {
                            Preferences.deleteData();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              LoginScreen.routeName,
                              (Route<dynamic> route) => false,
                            );
                          },
                        ))
                      ],
                    ),
                  ],
                ))));
  }
}
