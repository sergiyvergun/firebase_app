import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_test_app/common/routes/routes.dart';
import 'package:sign_in_test_app/pages/home_page.dart';
import 'package:sign_in_test_app/pages/sign_up_sign_in_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.signInSignUp:
        return MaterialPageRoute(builder: (context) => const SignUpSignInPage());
      case Routes.home:
        return MaterialPageRoute(builder: (context) => const HomePage());
      default:
        return MaterialPageRoute(builder: (context) => const SignUpSignInPage());
    }
  }
}
