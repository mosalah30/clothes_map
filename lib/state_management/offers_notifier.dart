import 'package:flutter/foundation.dart';

import 'package:clothes_map/models/offer.dart';

class OffersNotifier extends ChangeNotifier {
  int nextOffersPage = 1;
  int nextHotOffersPage = 1;
  bool hasMore = true;

  List<Offer> hotOffers = List<Offer>();
  List<Offer> offers = List<Offer>();

  void changeHotOffersState(List<dynamic> newHotOffers) {
    for (var hotOffer in newHotOffers) {
      hotOffers.add(Offer.fromJson(hotOffer, true));
    }
    notifyListeners();
  }

  void changeOffersState(List<dynamic> newOffers) {
    for (var offer in newOffers) {
      offers.add(Offer.fromJson(offer, false));
    }
    notifyListeners();
  }

  void noMoreOffers() {
    hasMore = false;
    notifyListeners();
  }

  void reset() {
    nextOffersPage = 1;
    nextHotOffersPage = 1;
    hasMore = true;
    hotOffers = List<Offer>();
    offers = List<Offer>();
  }
}
