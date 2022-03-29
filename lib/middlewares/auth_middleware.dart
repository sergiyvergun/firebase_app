import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_test_app/pages/sign_up_sign_in_page.dart';

import '../blocs/auth_bloc/auth_bloc.dart';
import '../components/custom_dialog.dart';

class AuthMiddleware extends StatelessWidget {
  const AuthMiddleware({Key? key,required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {

        if(state is Authenticated){
          Navigator.of(context).pushReplacementNamed('/home');
        }

        if (state is AuthError) {
          showDialog(
              context: context,
              builder: (context) {
                return CustomDialog(
                    headerText: '',
                    text: state.error.toString().replaceAll('Exception:', ''),
                    actions: [
                      DialogAction(
                          titleText: 'Ok',
                          onPressed: () {
                            Navigator.of(context).pop();
                          })
                    ]);
              });
        }
      },
      builder: (context, state) {
        if(state is UnAuthenticated){
          return child;
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
