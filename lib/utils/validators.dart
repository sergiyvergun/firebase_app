import 'package:email_validator/email_validator.dart';

class Validators {
  static String? emailValidator(String? email) {
    if (email==null||!EmailValidator.validate(email)) {
      return 'Incorrect e-mail';
    }
    return null;
  }
  static String? passwordValidator(String? password) {
    if (password==null||password.isEmpty) {
      return 'Provide password';
    }
    return null;
  }

}
