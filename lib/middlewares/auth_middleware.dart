import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_test_app/pages/sign_up_sign_in_page.dart';

import '../blocs/auth_bloc/auth_bloc.dart';
import '../common/routes/routes.dart';
import '../components/custom_dialog.dart';

class AuthMiddleware extends StatefulWidget {
  const AuthMiddleware({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<AuthMiddleware> createState() => _AuthMiddlewareState();
}

class _AuthMiddlewareState extends State<AuthMiddleware> {
   late AuthBloc bloc;

  @override
  void didChangeDependencies() {
    bloc = context.read<AuthBloc>();
    print(bloc.state);
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: bloc,
      listenWhen: (_,__)=>true,
      listener: (context, state) {
        print(state);

        if (state is UnAuthenticated) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Routes.signInSignUp, (route) => false);
        }


        if (state is Authenticated) {
          Navigator.of(context).pushReplacementNamed(Routes.home);
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
        print(state);
        return widget.child;
      },
    );
  }
}
