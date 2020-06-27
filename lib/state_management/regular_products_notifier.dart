import 'package:flutter/foundation.dart';

import 'package:clothes_map/models/regular_product.dart';

class RegularProductsNotifier extends ChangeNotifier {
  String section;
  String category;
  int nextPage = 1;
  bool hasMore = true;

  List<RegularProduct> regularProducts = List<RegularProduct>();

  void changeRegularProductsState(List<dynamic> newRegularProducts) {
    for (var product in newRegularProducts) {
      regularProducts.add(RegularProduct.fromJson(product));
    }
    notifyListeners();
  }

  void noMoreProducts() {
    hasMore = false;
    notifyListeners();
  }

  void reset() {
    hasMore = true;
    nextPage = 1;
    regularProducts = List<RegularProduct>();
  }
}
