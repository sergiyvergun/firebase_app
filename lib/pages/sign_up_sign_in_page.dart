import 'package:flutter/material.dart';
import 'package:sign_in_test_app/components/custom_app_bar.dart';
import 'package:sign_in_test_app/components/custom_text_button.dart';
import 'package:sign_in_test_app/components/custom_text_form_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController _emailTextEditingController;
  late TextEditingController _passwordTextEditingController;
  late GlobalKey<FormState> _formKey;

  bool _signIn = false;

  @override
  void initState() {
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  void _onSignUpWithEmailAndPasswordPressed() {}

  void _onSignInWithEmailAndPasswordPressed() {}

  void _onContinueWithGooglePressed() {}

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
    return Scaffold(
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
                  labelText: 'E-mail', controller: _emailTextEditingController),
              const SizedBox(height: 10),
              CustomTextFormField(
                  labelText: 'Password',
                  controller: _passwordTextEditingController),
              const SizedBox(height: 10),
              CustomTextButton(
                  title: _signIn ? 'Sign in' : 'Sign up',
                  onPressed: _signIn
                      ? _onSignInWithEmailAndPasswordPressed
                      : _onSignUpWithEmailAndPasswordPressed),
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
    );
  }
}
