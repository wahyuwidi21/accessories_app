import 'package:accessories_app/utils/size_config.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class RegisterScreen extends StatelessWidget {
  static String routeName = "/register";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Body(),
    );
  }
}
