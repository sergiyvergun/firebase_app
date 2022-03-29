import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String labelText;
  final bool obscureText;
  final IconData? iconData;

  const CustomTextFormField(
      {Key? key,
      this.controller,
      required this.labelText,
      this.validator,
      this.obscureText = false,
      this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          label: Text(labelText),
          icon: iconData != null ? Icon(iconData) : null),
    );
  }
}
