import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clothes_map/components/colors_loader.dart';
import 'package:clothes_map/components/regular_product_card.dart';
import 'package:clothes_map/state_management/screens_controller.dart';
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
  ScreensController screensController;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    regularProductsNotifier = Provider.of<RegularProductsNotifier>(
      context,
      listen: false,
    );
    regularProductsNotifier.section = widget.section.split(" ")[0];
    regularProductsNotifier.category = widget.section.split(" ")[1];
    regularProductsClient = RegularProductsClient(regularProductsNotifier);
    screensController = Provider.of<ScreensController>(context, listen: false);
    scrollController = ScrollController();
    regularProductsClient.getRegularProducts();
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        screensController.changeRegularProductsLoaderState(true);
        regularProductsNotifier.nextPage++;
        await regularProductsClient.getRegularProducts();
        screensController.changeRegularProductsLoaderState(false);
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
                height: double.maxFinite,
                child: ColorsLoader(),
              );
            } else {
              final data = regularProductsNotifier.regularProducts;
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      controller: scrollController,
                      itemBuilder: (context, i) => ProductCard(
                        id: data[i].id,
                        price: data[i].price,
                        description: data[i].description,
                        imageUrl: data[i].imageUrl,
                      ),
                    ),
                  ),
                  Selector<ScreensController, bool>(
                    selector: (context, screensController) =>
                        screensController.regularProductsLoading,
                    builder: (context, isLoading, child) =>
                        isLoading && regularProductsNotifier.hasMore
                            ? Container(
                                height: 50,
                                child: Center(
                                  child: ColorsLoader(),
                                ),
                              )
                            : Container(height: 0),
                  )
                ],
              );
            }
          },
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
