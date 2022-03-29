import 'package:flutter/material.dart';

extension GetTheme on BuildContext{
  ThemeData get theme{
    return Theme.of(this);
  }
}