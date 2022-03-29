import 'package:flutter/material.dart';
import 'package:sign_in_test_app/extensions/theme.dart';

class CustomTextButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CustomTextButton(
      {Key? key, required this.title, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          backgroundColor: context.theme.primaryColor,
          padding: const EdgeInsets.all(16),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ));
  }
}
