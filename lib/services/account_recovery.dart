import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

import 'package:clothes_map/utils/values.dart';

enum PhoneNumVerification {
  failed,
  verified,
  wrongInput,
  smsVerificationNeeded
}

enum AccountRecoveryResult { failed, recovered, wrongInput }

class AccountRecoveryAdmin {
  String verificationId;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<PhoneNumVerification> verifyUserPhoneNumber(String phoneNum) async {
    final verificationComplete = Completer<PhoneNumVerification>();
    if (phoneNum.isEmpty ||
        !phoneNum.startsWith('01') ||
        phoneNum.length != 11) {
      verificationComplete.complete(PhoneNumVerification.wrongInput);
    }
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+2$phoneNum',
        timeout: Duration(seconds: 30),
        verificationCompleted: (_) {
          verificationComplete.complete(PhoneNumVerification.verified);
        },
        verificationFailed: (exception) {
          verificationComplete.complete(PhoneNumVerification.failed);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          this.verificationId = verificationId;
          verificationComplete
              .complete(PhoneNumVerification.smsVerificationNeeded);
        },
        codeAutoRetrievalTimeout: null,
      );
    } catch (e) {
      verificationComplete.complete(PhoneNumVerification.failed);
    }
    return await verificationComplete.future;
  }

  bool confirmSentSmsCode(String smsCode) {
    AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    if (credential.providerId != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<AccountRecoveryResult> recoverUserAccount({
    String phoneNum,
    String newPassword,
    String userType,
  }) async {
    if (newPassword.isEmpty || newPassword == null || newPassword.length < 6) {
      return AccountRecoveryResult.wrongInput;
    }
    try {
      http.Response response = await http.post(
        accountRecoveryAPI,
        body: {
          'phoneNum': phoneNum,
          'newPassword': newPassword,
          'userType': userType,
        },
      );
      if (response.body == 'AccountRecovered') {
        return AccountRecoveryResult.recovered;
      }
      return AccountRecoveryResult.failed;
    } catch (e) {
      return AccountRecoveryResult.failed;
    }
  }
}
