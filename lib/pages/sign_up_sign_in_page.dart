import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_test_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:sign_in_test_app/components/custom_app_bar.dart';
import 'package:sign_in_test_app/components/custom_dialog.dart';
import 'package:sign_in_test_app/components/custom_text_button.dart';
import 'package:sign_in_test_app/components/custom_text_form_field.dart';
import 'package:sign_in_test_app/middlewares/auth_middleware.dart';
import 'package:sign_in_test_app/utils/validators.dart';

class SignUpSignInPage extends StatefulWidget {
  const SignUpSignInPage({Key? key}) : super(key: key);

  @override
  State<SignUpSignInPage> createState() => _SignUpSignInPageState();
}

class _SignUpSignInPageState extends State<SignUpSignInPage> {
  late TextEditingController _emailTextEditingController;
  late TextEditingController _passwordTextEditingController;
  late GlobalKey<FormState> _formKey;
  late AuthBloc bloc;

  bool _signIn = false;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    bloc = BlocProvider.of<AuthBloc>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  String get email => _emailTextEditingController.text;

  String get password => _passwordTextEditingController.text;

  void _onSignUpWithEmailAndPasswordPressed() {
    if (_formKey.currentState!.validate()) {
      bloc.add(SignUpRequested(email, password));
    }
  }

  void _onSignInWithEmailAndPasswordPressed() {
    if (_formKey.currentState!.validate()) {
      bloc.add(SignInRequested(email, password));
    }
  }

  void _onContinueWithGooglePressed() {
    bloc.add(GoogleSignInRequested());
  }

  void _onHaveAccountPressed() {
    setState(() {
      _signIn = true;
    });
  }

  void _onDontHaveAccountPressed() {
    setState(() {
      _signIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AuthMiddleware(
      child: Scaffold(
        appBar: const CustomAppBar(titleText: 'Register'),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                CustomTextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? email) {
                      return Validators.emailValidator(email);
                    },
                    labelText: 'E-mail',
                    controller: _emailTextEditingController),
                const SizedBox(height: 10),
                CustomTextFormField(
                  obscureText: !_isPasswordVisible,
                  labelText: 'Password',
                  validator: (String? password) {
                    return Validators.passwordValidator(password);
                  },
                  controller: _passwordTextEditingController,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextButton(
                    title: _signIn ? 'Sign in' : 'Sign up',
                    onPressed: () {
                      _signIn
                          ? _onSignInWithEmailAndPasswordPressed()
                          : _onSignUpWithEmailAndPasswordPressed();
                    }),
                const SizedBox(height: 8),
                CustomTextButton(
                    title: 'Continue with Google',
                    onPressed: _onContinueWithGooglePressed),
                const SizedBox(height: 2),
                !_signIn
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account?'),
                          TextButton(
                              onPressed: _onHaveAccountPressed,
                              child: Text('Sign in'))
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account?'),
                          TextButton(
                              onPressed: _onDontHaveAccountPressed,
                              child: Text('Sign up'))
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
