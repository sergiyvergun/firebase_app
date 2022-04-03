import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_test_app/common/routes/route_generator.dart';
import 'package:sign_in_test_app/pages/home_page.dart';
import 'package:sign_in_test_app/pages/sign_up_sign_in_page.dart';
import 'package:sign_in_test_app/repositories/auth_repository.dart';

import 'blocs/auth_bloc/auth_bloc.dart';
import 'common/routes/routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository()),
      ],
      child: BlocProvider(
        create: (context) => AuthBloc(
            repository: RepositoryProvider.of<AuthRepository>(context)),
        child: MaterialApp(
          theme: ThemeData.dark().copyWith(),
          onGenerateRoute: RouteGenerator.generateRoute,
          home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                // If the snapshot has user data, then they're already signed in. So Navigating to the Dashboard.
                if (snapshot.hasData) {
                  return const HomePage();
                }
                // Otherwise, they're not signed in. Show the sign in page.
                return const SignUpSignInPage();
              }),
        ),
        ),
      );

  }
}
