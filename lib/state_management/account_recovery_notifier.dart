import 'package:flutter/foundation.dart';

class AccountRecoveryNotifier extends ChangeNotifier {
  bool phoneNumVerified = false;
  bool loading = false;

  void phoneNumVerificationCompleted() {
    phoneNumVerified = true;
    notifyListeners();
  }

  void changeLoadingState(bool newBool) {
    loading = newBool;
    notifyListeners();
  }
}
