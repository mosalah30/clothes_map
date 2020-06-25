import 'package:flutter/foundation.dart';

class ScreensController extends ChangeNotifier {
  int screenIndex = 0;
  int sectionIndex = 0;
  bool isSearching = false;
  bool offersLoading = false;

  void changeScreenIndex(int newIndex) {
    screenIndex = newIndex;
    notifyListeners();
  }

  void changeSearchingState() {
    isSearching = !isSearching;
    notifyListeners();
  }

  void changeSectionIndex(int newIndex) {
    sectionIndex = newIndex;
    notifyListeners();
  }

  void changeOffersLoaderState(newBool) {
    offersLoading = newBool;
    notifyListeners();
  }
}
