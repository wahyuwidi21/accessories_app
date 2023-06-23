import 'package:accessories_app/utils/size_config.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class OnBoardingScreen extends StatelessWidget {
  static String routeName = "/onboarding";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: const Body(),
    );
  }
}
