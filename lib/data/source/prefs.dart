import 'dart:convert';

import 'package:accessories_app/data/model/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static String emailModel = "emailActive";

  static Future setEmailActive(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(emailModel, data);
  }

  static Future<String> getEmailActive() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString(emailModel)!;

    return data;
  }

  static Future deleteData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
