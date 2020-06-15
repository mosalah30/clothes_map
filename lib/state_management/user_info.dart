import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo extends ChangeNotifier {
  static Map<String, String> info = {'type': 'guest'};

  Future<void> getInfo() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String encodedInfo = sharedPref.getString('user_info');
    if (encodedInfo != null) {
      info = Map<String, String>.from(json.decode(encodedInfo));
      notifyListeners();
    }
  }

  Future<void> setInfo(
    String userType,
    Map<String, String> receivedInfo,
  ) async {
    receivedInfo['type'] = userType;
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String encodedInfo = json.encode(receivedInfo);
    sharedPref.setString('user_info', encodedInfo);
  }

  Future<void> deleteUserInfo() async {
    info = {'type': 'guest'};
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString('user_info', null);
    notifyListeners();
  }
}
