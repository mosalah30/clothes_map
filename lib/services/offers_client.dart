import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:clothes_map/utils/values.dart';

class OffersClient {
  final offersNotifier;

  OffersClient(this.offersNotifier);

  Future<void> getOffers(String tableName) async {
    int nextPage = tableName == 'hot_offers'
        ? offersNotifier.nextHotOffersPage
        : offersNotifier.nextOffersPage;
    try {
      http.Response response = await http.post(
        offersAPI,
        body: {'nextPage': '$nextPage', 'tableName': tableName},
      );

      List<dynamic> results = json.decode(response.body);

      if (results.isNotEmpty) {
        if (tableName == 'hot_offers') {
          offersNotifier.changeHotOffersState(results);
        } else if (tableName == 'offers') {
          offersNotifier.changeOffersState(results);
        }
      } else {
        offersNotifier.noMoreOffers();
      }
    } catch (e) {}
  }
}
