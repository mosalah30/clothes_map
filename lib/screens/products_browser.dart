import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clothes_map/components/colors_loader.dart';
import 'package:clothes_map/components/regular_product_card.dart';
import 'package:clothes_map/state_management/regular_products_notifier.dart';
import 'package:clothes_map/services/regular_products_client.dart';

class ProductsBrowser extends StatefulWidget {
  final String section;

  ProductsBrowser(this.section);

  @override
  _ProductsBrowserState createState() => _ProductsBrowserState();
}

class _ProductsBrowserState extends State<ProductsBrowser> {
  RegularProductsNotifier regularProductsNotifier;
  RegularProductsClient regularProductsClient;
  ScrollController scrollController;

  Future<void> showFilterBottomSheet() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height / 3,
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    regularProductsNotifier = Provider.of<RegularProductsNotifier>(
      context,
      listen: false,
    )..section = widget.section.split(" ")[0];
    regularProductsClient = RegularProductsClient(regularProductsNotifier);
    scrollController = ScrollController();
    regularProductsClient.getRegularProducts();
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
//        screensController.changeOffersLoaderState(true);
        regularProductsNotifier.nextPage++;
        await regularProductsClient.getRegularProducts();
//        screensController.changeOffersLoaderState(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          centerTitle: true,
          title: Text(
            widget.section,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Consumer<RegularProductsNotifier>(
          builder: (context, admin, child) {
            if (admin.regularProducts.isEmpty) {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: ColorsLoader(),
              );
            } else {
              final data = regularProductsNotifier.regularProducts;
              return ListView.builder(
                itemCount: data.length,
                controller: scrollController,
                itemBuilder: (context, i) => RegularProductCard(
                  id: data[i].id,
                  price: data[i].price,
                  description: data[i].description,
                  imageUrl: data[i].imageUrl,
                ),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.filter_list),
          onPressed: () => showFilterBottomSheet(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    regularProductsNotifier.reset();
  }
}
