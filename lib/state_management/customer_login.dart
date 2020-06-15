import 'package:flutter/widgets.dart';

import 'package:clothes_map/utils/regex.dart';
import 'package:clothes_map/utils/password_validator.dart';

class CustomersLogin extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool emailVerified;
  bool passwordVerified;
  bool socialAuthLoading = false;

  void validateEmail() {
    String email = emailController.text;
    bool isValidEmail = RegExp(emailValidation).hasMatch(email);
    emailVerified = isValidEmail;
    notifyListeners();
  }

  void validatePassword() {
    String password = passwordController.text;
    bool isValid = validateUserPassword(password);
    passwordVerified = isValid;
    notifyListeners();
  }

  void changeSocialAuthLoadingState(bool newBool) {
    socialAuthLoading = newBool;
    notifyListeners();
  }

  void clearInputs() {
    emailController.clear();
    passwordController.clear();
    emailVerified = null;
    passwordVerified = null;
  }
}
