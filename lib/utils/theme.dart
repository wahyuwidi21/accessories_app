import 'package:accessories_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Ubuntu",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: const BorderSide(color: kTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return const TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
    systemOverlayStyle: SystemUiOverlayStyle.light,
  );
}

InputDecoration decorateRouteTextForm(String label, Color color,
    {Widget? suffix, String? hint, Color? borderColor}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
    suffixIcon: suffix,

    hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
    hintText: hint ?? label,
    alignLabelWithHint: false,
    // border: OutlineInputBorder(
    //   borderRadius: BorderRadius.all(
    //     Radius.circular(8),
    //   ),
    //   borderSide: BorderSide(color: Color(0xffeeeeee), width: 1.2),
    // ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
      borderSide: BorderSide(color: Color(0xffF2F4F6), width: 1),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
      borderSide: BorderSide(color: Colors.red, width: 1),
    ),
  );
}
