import 'package:flutter/foundation.dart';

import 'package:clothes_map/models/regular_product.dart';

class SearchResultsNotifier extends ChangeNotifier {
  int nextSearchResultPage = 1;
  bool isLoading = true;
  bool hasMore;

  List<RegularProduct> searchResults = List<RegularProduct>();

  void changeSearchResultsState(List<dynamic> newResults) {
    for (var result in newResults) {
      searchResults.add(RegularProduct.fromJson(result));
    }
    isLoading = false;
    hasMore = true;
    notifyListeners();
  }

  void noMoreResults() {
    isLoading = false;
    hasMore = false;
    notifyListeners();
  }

  void close() {
    nextSearchResultPage = 1;
    isLoading = true;
    hasMore = null;
    searchResults = List<RegularProduct>();
  }
}
