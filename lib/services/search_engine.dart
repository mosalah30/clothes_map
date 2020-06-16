import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:clothes_map/utils/values.dart';

class SearchEngine {
  final searchResultsNotifier;
  SearchEngine(this.searchResultsNotifier);

  Future<void> search(String keyword) async {
    try {
      http.Response response = await http.post(
        productsSearchAPI,
        body: {
          'search_keyword': keyword,
          'nextPage': '${searchResultsNotifier.nextSearchResultPage}',
        },
      );
      List<dynamic> results = json.decode(response.body);

      if (results.isNotEmpty) {
        searchResultsNotifier.changeSearchResultsState(results);
      } else {
        searchResultsNotifier.noMoreResults();
      }
    } catch (e) {}
  }
}
