import 'package:accessories_app/main_screen.dart';
import 'package:accessories_app/ui/cart/cart_screen.dart';
import 'package:accessories_app/ui/login/login_screen.dart';
import 'package:accessories_app/ui/onboarding/onboarding_screen.dart';
import 'package:accessories_app/ui/register/register_screen.dart';
import 'package:accessories_app/ui/splash/splash_screen.dart';
import 'package:flutter/widgets.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  OnBoardingScreen.routeName: (context) => OnBoardingScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  MainScreen.routeName: (context) => MainScreen(),
  CartScreen.routeName: (context) => CartScreen()
};
