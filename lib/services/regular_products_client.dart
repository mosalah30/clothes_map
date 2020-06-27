import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:clothes_map/state_management/regular_products_notifier.dart';
import 'package:clothes_map/utils/values.dart';

class RegularProductsClient {
  final RegularProductsNotifier regularProductsNotifier;

  RegularProductsClient(this.regularProductsNotifier);

  Future<void> getRegularProducts() async {
    try {
      http.Response response = await http.post(
        regularProductsAPI,
        body: {
          'nextPage': '${regularProductsNotifier.nextPage}',
          'section': regularProductsNotifier.section,
          'category': regularProductsNotifier.category,
        },
      );

      List<dynamic> results = json.decode(response.body);

      if (results.isNotEmpty) {
        regularProductsNotifier.changeRegularProductsState(results);
      } else {
        regularProductsNotifier.noMoreProducts();
      }
    } catch (e) {}
  }
}
