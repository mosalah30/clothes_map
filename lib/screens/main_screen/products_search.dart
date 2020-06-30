import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clothes_map/components/colors_loader.dart';
import 'package:clothes_map/components/search_result_card.dart';
import 'package:clothes_map/models/regular_product.dart';
import 'package:clothes_map/state_management/search_results_notifier.dart';
import 'package:clothes_map/services/search_engine.dart';

class ProductsSearch extends StatefulWidget {
  final String keyword;
  ProductsSearch(this.keyword);

  @override
  _ProductsSearchState createState() => _ProductsSearchState();
}

class _ProductsSearchState extends State<ProductsSearch> {
  ScrollController scrollController;
  SearchResultsNotifier searchResultsNotifier;
  SearchEngine searchEngine;

  @override
  void initState() {
    super.initState();
    searchResultsNotifier = Provider.of<SearchResultsNotifier>(
      context,
      listen: false,
    );
    searchEngine = SearchEngine(searchResultsNotifier);
    scrollController = ScrollController();
    searchEngine.search(widget.keyword);
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        searchResultsNotifier.nextSearchResultPage++;
        await searchEngine.search(widget.keyword);
      }
    });
  }

  Widget generateResultsList(List<RegularProduct> results) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          for (var product in results)
            SearchResultCard(
              id: product.id,
              imageUrl: product.imageUrl,
              price: product.price,
              description: product.description,
              section: product.section,
              category: product.category,
            ),
          Selector<SearchResultsNotifier, bool>(
            selector: (context, searchResultsNotifier) =>
                searchResultsNotifier.isLoading,
            builder: (context, loading, child) =>
                loading && searchResultsNotifier.hasMore
                    ? Container(
                        height: 50,
                        child: Center(
                          child: ColorsLoader(),
                        ),
                      )
                    : Container(height: 0),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<SearchResultsNotifier>(
        builder: (context, admin, child) {
          if (admin.isLoading) {
            return ColorsLoader();
          } else {
            if (admin.searchResults.isNotEmpty) {
              return generateResultsList(admin.searchResults);
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/icons/no_results.png',
                    height: 100,
                    width: 100,
                  ),
                  Text(
                    'لا توجد نتائج',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    searchResultsNotifier.close();
  }
}
