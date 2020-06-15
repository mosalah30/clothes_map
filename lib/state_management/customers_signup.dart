import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:clothes_map/utils/password_validator.dart';
import 'package:clothes_map/utils/values.dart';
import 'package:clothes_map/utils/regex.dart';

class CustomersSignup extends ChangeNotifier {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordVerificationController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController()..text = '';

  bool fullNameValid;
  bool emailVerified;
  bool passwordVerified;
  bool passwordVerificationMatches;
  bool phoneNumberVerified;

  static String newUserAvatar = defaultUserAvatarAsset;

  void letUserChooseHisAvatar() {
    ImagePicker imagePicker = ImagePicker();
    imagePicker.getImage(source: ImageSource.gallery).then(
      (userPickedImage) async {
        newUserAvatar = userPickedImage.path;
        notifyListeners();
      },
    ).catchError(
      (e) => Fluttertoast.showToast(msg: 'حدث خطأ أثناء جلب الصورة'),
    );
  }

  void validateFullName() {
    String fullName = fullNameController.text;
    if (fullName != null) {
      bool isValidFullName = fullName.length >= 6 &&
          fullName.length <= 30 &&
          fullName.trim().contains(' ');
      fullNameValid = isValidFullName;
      notifyListeners();
    }
  }

  void validateEmail() {
    String email = emailController.text;
    if (email != null) {
      bool isValidEmail = RegExp(emailValidation).hasMatch(email);
      emailVerified = isValidEmail;
      notifyListeners();
    }
  }

  void validatePhoneNumber() {
    String phoneNum = phoneNumberController.text;
    if (phoneNum != null) {
      bool isValidNum = phoneNum.length == 11 && phoneNum.startsWith('01');
      phoneNumberVerified = isValidNum;
      notifyListeners();
    }
  }

  void validatePassword() {
    String password = passwordController.text;
    if (password != null) {
      bool isValidPassword = validateUserPassword(password);
      passwordVerified = isValidPassword;
      notifyListeners();
    }
  }

  void checkIfPasswordVerificationMatch() {
    String passwordVerification = passwordVerificationController.text;
    if (passwordVerification != null) {
      bool matches = passwordVerification == passwordController.text;
      passwordVerificationMatches = matches;
      notifyListeners();
    }
  }

  void clearInputs() {
    fullNameController.clear();
    emailController.clear();
    addressController.clear();
    passwordController.clear();
    passwordVerificationController.clear();
    phoneNumberController.clear();
    fullNameValid = null;
    emailVerified = null;
    phoneNumberVerified = null;
    passwordVerified = null;
    passwordVerificationMatches = null;
  }
}
