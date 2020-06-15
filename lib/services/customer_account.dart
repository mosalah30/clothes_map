import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:clothes_map/state_management/user_info.dart';
import 'package:clothes_map/utils/json_cleaner.dart';
import 'package:clothes_map/utils/values.dart';

enum UpdateResponse { succeeded, failed, noChangeWasGiven, validationError }

class CustomerAccountAdmin {
  Future<UpdateResponse> updateCustomerInfo(
    String customerEmail,
    String newName,
    String newAddress,
    String newPhoneNum,
    String newPassword,
  ) async {
    try {
      if (newName != UserInfo.info['name'] ||
          newAddress != UserInfo.info['address'] ||
          newPhoneNum != UserInfo.info['phoneNumber'] ||
          newPassword != UserInfo.info['password']) {
        if (newName.length >= 6 &&
            newName.contains(' ') &&
            (newAddress.length >= 11 || newAddress.isEmpty) &&
            newPhoneNum.length == 11 &&
            newPhoneNum.startsWith('01') &&
            newPassword.length >= 6) {
          http.Response response = await http.post(
            customerInfoUpdateAPI,
            body: {
              'customerEmail': customerEmail,
              'newName': newName,
              'newAddress': newAddress,
              'newPhoneNum': newPhoneNum,
              'newPassword': newPassword,
            },
          );
          if (response.statusCode == 200) {
            UserInfo userInfo = UserInfo();
            Map<String, String> newInfo =
                cleanReceivedJson(jsonDecode(response.body));
            userInfo.setInfo('customer', newInfo);
            return UpdateResponse.succeeded;
          }
        } else {
          return UpdateResponse.validationError;
        }
      } else {
        return UpdateResponse.noChangeWasGiven;
      }
    } catch (e) {
      return UpdateResponse.failed;
    }
  }
}
