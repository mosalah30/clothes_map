import 'package:flutter/foundation.dart';

class ScreensController extends ChangeNotifier {
  int screenIndex = 0;
  int sectionIndex = 0;
  bool isSearching = false;
  bool offersLoading = false;
  bool regularProductsLoading = false;

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

  void changeOffersLoaderState(bool newBool) {
    offersLoading = newBool;
    notifyListeners();
  }

  void changeRegularProductsLoaderState(bool newBool) {
    regularProductsLoading = newBool;
    notifyListeners();
  }
}
