import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'package:clothes_map/state_management/user_info.dart';
import 'package:clothes_map/state_management/customers_signup.dart';
import 'package:clothes_map/utils/json_cleaner.dart';
import 'package:clothes_map/utils/values.dart';

enum EmailCreation { succeeded, failed, alreadyExists }
enum EPLogin {
  succeeded,
  failed,
  signedInWithGoogle,
  signedInWithFacebook,
  wrongPassword,
  emailNotFound
}
enum SLogin { succeeded, failed, hasDifferentCredentials }

class CustomerAuth {
  void addCustomerAvatarToServer(
    String userEmail,
    String avatarExtension,
  ) async {
    if (CustomersSignup.newUserAvatar != defaultUserAvatarAsset) {
      String base64Image =
          base64Encode(File(CustomersSignup.newUserAvatar).readAsBytesSync());
      String fileName = userEmail + '.' + avatarExtension;
      await http.post(
        customersAvatarsAPI,
        body: {'image': base64Image, 'fileName': fileName},
      );
    }
  }

  Future<bool> checkIfEmailAlreadyExists(String email) async {
    http.Response response = await http.post(
      accountsDuplicateValidatorAPI,
      body: {'email': email},
    );
    bool alreadyExists = response.body == 'true' ? true : false;
    return alreadyExists;
  }

  Future<http.Response> addCustomerToDb(
    String name,
    String email,
    String phoneNumber,
    String address,
    String password,
    String avatarExtension,
  ) async {
    http.Response response = await http.post(
      customersSignupAPI,
      body: {
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'address': address,
        'password': password,
        'avatarExtension': avatarExtension,
      },
    );
    return response;
  }

  Future<EmailCreation> createNewUser(
    String name,
    String email,
    String phoneNumber,
    String address,
    String password,
    String avatarExtension,
  ) async {
    try {
      bool emailAlreadyExists = await checkIfEmailAlreadyExists(email);
      if (!emailAlreadyExists) {
        try {
          addCustomerAvatarToServer(email, avatarExtension);
        } catch (e) {
          Fluttertoast.showToast(msg: 'حدث خطأ أثناء رفع الصورة');
          avatarExtension = '';
        }

        http.Response response = await addCustomerToDb(
          name,
          email,
          phoneNumber,
          address,
          password,
          avatarExtension,
        );
        if (response.body.contains('Error')) {
          return EmailCreation.failed;
        }
      } else {
        return EmailCreation.alreadyExists;
      }
      return EmailCreation.succeeded;
    } catch (e) {
      return EmailCreation.failed;
    }
  }

  Future<EPLogin> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        return EPLogin.failed;
      }
      http.Response response = await http.post(customersLoginAPI, body: {
        'email': email,
        'password': password,
      });
      switch (response.body) {
        case "SignedInWithGoogle":
          return EPLogin.signedInWithGoogle;
        case "SignedInWithFacebook":
          return EPLogin.signedInWithFacebook;
        case "WrongPassword":
          return EPLogin.wrongPassword;
        case "EmailNotFound":
          return EPLogin.emailNotFound;
        default:
          {
            var result = response.body;
            var userInfo = json.decode(result);
            UserInfo userInfoClient = UserInfo();
            userInfoClient.setInfo(
              'customer',
              cleanReceivedJson(userInfo),
            );
            return EPLogin.succeeded;
          }
      }
    } catch (e) {
      return EPLogin.failed;
    }
  }

  Future<String> addCustomerSocialPhotoToServer(
    String url,
    String email,
  ) async {
    try {
      http.Response response = await http.get(url);
      Directory tempDirectory = await getTemporaryDirectory();
      String filePathAndName = tempDirectory.path + '/temp.jpg';
      File customerImage = File(filePathAndName);
      await customerImage.writeAsBytes(response.bodyBytes);
      String base64Image = base64Encode(await customerImage.readAsBytes());
      String fileName = email + '.jpg';
      await http.post(
        customersAvatarsAPI,
        body: {'image': base64Image, 'fileName': fileName},
      );
      return 'jpg';
    } catch (e) {
      return '';
    }
  }

  Future<SLogin> googleSignIn() async {
    try {
      var customerGoogleAccount = await GoogleSignIn().signIn();

      String email = customerGoogleAccount.email;
      String password = '%google%heda7';
      String name = customerGoogleAccount.displayName;
      String avatarUrl = customerGoogleAccount.photoUrl;

      bool emailAlreadyExists = await checkIfEmailAlreadyExists(email);

      if (!emailAlreadyExists) {
        String avatarExtension = await addCustomerSocialPhotoToServer(
          avatarUrl,
          email,
        );
        await addCustomerToDb(name, email, '', '', password, avatarExtension);
        await loginWithEmailAndPassword(email, password);
        return SLogin.succeeded;
      } else {
        EPLogin login = await loginWithEmailAndPassword(email, password);
        if (login == EPLogin.wrongPassword) {
          return SLogin.hasDifferentCredentials;
        }
        return SLogin.succeeded;
      }
    } catch (e) {
      return SLogin.failed;
    }
  }

  Future<SLogin> facebookSignIn() async {
    try {
      FacebookLogin facebookLogin = FacebookLogin();
      FacebookLoginResult result = await facebookLogin.logIn(['email']);

      if (result.status == FacebookLoginStatus.loggedIn) {
        String token = result.accessToken.token;
        http.Response graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,email&access_token=$token',
        );
        var profile = json.decode(graphResponse.body);
        String email = profile['id'];
        String password = '%facebook%heda7';
        String name = profile['name'];
        String avatarUrl =
            'http://graph.facebook.com/${profile['id']}/picture?type=large';

        bool emailAlreadyExists = await checkIfEmailAlreadyExists(email);

        if (!emailAlreadyExists) {
          String avatarExtension = await addCustomerSocialPhotoToServer(
            avatarUrl,
            email,
          );
          await addCustomerToDb(name, email, '', '', password, avatarExtension);
          await loginWithEmailAndPassword(email, password);
          return SLogin.succeeded;
        } else {
          EPLogin login = await loginWithEmailAndPassword(email, password);
          if (login == EPLogin.wrongPassword) {
            return SLogin.hasDifferentCredentials;
          }
          return SLogin.succeeded;
        }
      } else {
        return SLogin.failed;
      }
    } catch (e) {
      return SLogin.failed;
    }
  }
}
