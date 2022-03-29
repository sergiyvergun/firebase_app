import 'package:flutter/material.dart';
import 'package:sign_in_test_app/pages/sign_up_sign_in_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(),
      initialRoute: '/',
      routes: <String,Widget Function(BuildContext)>{
        '/':(context)=> const SignUpPage(),
      },
    );
  }
}
