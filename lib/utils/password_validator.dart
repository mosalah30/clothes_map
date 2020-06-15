bool validateUserPassword(String password) {
  RegExp passwordRegExp = RegExp(r'^.{6,32}$');
  bool isValidPassword = passwordRegExp.hasMatch(password);
  return isValidPassword;
}
