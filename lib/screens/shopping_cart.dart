import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

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
  Future<List<Order>> _orders;
  bool canProcessPayment = false;

  Future<void> getOrdersLength() async {
    bool canProcessPayment = await dbHelper.ordersNotEmpty();
    setState(() {
      this.canProcessPayment = canProcessPayment;
    });
  }

  void refreshOrdersList() {
    setState(() {
      _orders = dbHelper.getOrders();
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
                  await getOrdersLength();
                  refreshOrdersList();
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Future<void> paymentSuccess() async {
    await AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.TOPSLIDE,
      padding: EdgeInsets.all(0),
      title: "!تم الشراء",
      desc: "",
      dismissOnTouchOutside: true,
      headerAnimationLoop: false,
    ).show();
  }

  @override
  void initState() {
    dbHelper = OrdersDbHelper();
    refreshOrdersList();
    getOrdersLength();
    super.initState();
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
              style: TextStyle(
                fontSize: 25,
                fontFamily: "Cairo",
              ),
            ),
            leading: Container(),
          ),
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 9,
                  child: FutureBuilder(
                    initialData: [],
                    future: _orders,
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
                Expanded(
                  flex: 1,
                  child: FlatButton(
                      color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "إتمام عملية الدفع",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      onPressed: canProcessPayment
                          ? () {
                              dbHelper.removeAllOrders();
                              Navigator.pop(context);
                              paymentSuccess();
                              changeStatusBarColor(appPrimaryColor, false);
                            }
                          : null),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
