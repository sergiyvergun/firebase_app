import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_test_app/pages/home_page.dart';
import 'package:sign_in_test_app/pages/sign_up_sign_in_page.dart';
import 'package:sign_in_test_app/repositories/auth_repository.dart';

import 'blocs/auth_bloc/auth_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
      ],
      child: BlocProvider(
        create: (context) => AuthBloc(
            repository: RepositoryProvider.of<AuthRepository>(context)),
        child: MaterialApp(
          theme: ThemeData.dark().copyWith(),
          initialRoute: '/',
          routes: <String, Widget Function(BuildContext)>{
            '/': (context) => const SignUpSignInPage(),
            '/home':(context)=> const HomePage(),
          },
        ),
      ),
    );
  }
}
