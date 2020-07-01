import 'package:flutter/material.dart';

import 'package:clothes_map/components/regular_product_card.dart';
import 'package:clothes_map/components/colors_loader.dart';
import 'package:clothes_map/models/order.dart';
import 'package:clothes_map/services/orders_db_helper.dart';
import 'package:clothes_map/utils/status_bar_color.dart';
import 'package:clothes_map/utils/styles.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  OrdersDbHelper dbHelper;
  Future<List<Order>> orders;

  @override
  void initState() {
    dbHelper = OrdersDbHelper();
    refreshOrdersList();
    super.initState();
  }

  void refreshOrdersList() {
    setState(() {
      orders = dbHelper.getOrders();
    });
  }

  Widget generateFavoriteProductsList(List<Order> orders) {
    return SingleChildScrollView(
      child: Column(
        children: orders
            .map(
              (product) => ProductCard(
                id: product.id,
                description: product.description,
                price: product.price,
                imageUrl: product.imageUrl,
                isInCart: true,
                onCartRemove: () async {
                  await dbHelper.delete(product.id);
                  refreshOrdersList();
                },
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          changeStatusBarColor(appPrimaryColor, false);
          return Future(() => true);
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "عربة التسوق",
              style: TextStyle(fontSize: 25, fontFamily: "Cairo"),
            ),
            leading: Container(),
          ),
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: FutureBuilder(
              future: orders,
              builder: (context, snapshot) {
                if (snapshot.data == null || snapshot.data.length == 0) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/icons/no_results.png',
                          height: 100,
                          width: 100,
                        ),
                        Text(
                          'لا شيء هنا',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data.length > 0) {
                  return generateFavoriteProductsList(snapshot.data);
                }
                return Expanded(
                  child: ColorsLoader(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
