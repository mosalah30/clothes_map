import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:clothes_map/screens/main_screen/main_widget.dart';
import 'package:clothes_map/models/favorite_product.dart';
import 'package:clothes_map/models/order.dart';
import 'package:clothes_map/services/favorite_products_db_helper.dart';
import 'package:clothes_map/services/orders_db_helper.dart';
import 'package:clothes_map/utils/status_bar_color.dart';
import 'package:clothes_map/utils/styles.dart';
import 'package:clothes_map/utils/custom_cached_image.dart';
import 'package:clothes_map/utils/screen_util.dart';
import 'package:clothes_map/utils/transitions.dart';

class ProductDetails extends StatefulWidget {
  final bool previousScreenIsHome, productsRefreshRequired;
  final int productId;
  final double productPrice;
  final String imageUrl, productDescription;
  ProductDetails(
    this.previousScreenIsHome, {
    this.productsRefreshRequired = true,
    this.productId,
    this.imageUrl,
    this.productDescription,
    this.productPrice,
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final screenUtil = ScreenUtil.instance;
  OrdersDbHelper ordersDbHelper;
  FavoriteProductsDbHelper favoriteProductsDbHelper;
  bool favorite = false;
  bool existsInCart = false;
  int quantity = 1;

  Future<void> addedToCartAlert() async {
    await AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.TOPSLIDE,
      padding: EdgeInsets.all(0),
      title: "!تم الإضافة بنجاح",
      desc: "يمكنك شراء هذا المنتج من عربة التسوق",
      dismissOnTouchOutside: true,
      headerAnimationLoop: false,
    ).show();
  }

  Future<void> getFavoriteBool() async {
    bool favorite = await favoriteProductsDbHelper.favoriteProductExists(
      widget.productId,
      widget.productDescription,
    );
    setState(() {
      this.favorite = favorite ?? false;
    });
  }

  Future<void> getExistsInCartBool() async {
    bool existsInCart =
        await ordersDbHelper.orderExistsInCart(widget.productId);
    setState(() {
      this.existsInCart = existsInCart ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    favoriteProductsDbHelper = FavoriteProductsDbHelper();
    ordersDbHelper = OrdersDbHelper();
    getFavoriteBool();
    getExistsInCartBool();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        bool canPop = true;
        if (widget.previousScreenIsHome) {
          changeStatusBarColor(appPrimaryColor, false);
        }
        if (widget.productsRefreshRequired) {
          canPop = false;
          Navigator.pushReplacement(
            context,
            FadeRoute(newScreen: MainWidget()),
          );
        }
        return Future(() => canPop);
      },
      child: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: <Widget>[
                Expanded(
                  flex: 9,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 40,
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            iconSize: 40,
                            icon: favorite
                                ? Icon(Icons.favorite)
                                : Icon(Icons.favorite_border),
                            color: favorite ? Colors.red : Colors.black,
                            onPressed: () async {
                              if (favorite) {
                                await favoriteProductsDbHelper.delete(
                                  widget.productId,
                                  widget.productDescription,
                                );
                              } else {
                                FavoriteProduct newFavoriteProduct =
                                    FavoriteProduct(
                                  id: widget.productId,
                                  description: widget.productDescription,
                                  price: widget.productPrice,
                                  imageUrl: widget.imageUrl,
                                );
                                await favoriteProductsDbHelper
                                    .add(newFavoriteProduct);
                              }
                              setState(() {
                                favorite = !favorite;
                              });
                            },
                          ),
                        ),
                        getCacheImage(widget.imageUrl, 300),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              "${widget.productDescription}",
                              style: TextStyle(fontSize: screenUtil.setSp(25)),
                            ),
                            Text(
                              "${widget.productPrice} جنيه",
                              style: TextStyle(
                                fontSize: screenUtil.setSp(20),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        Text(
                          "لوريم إيبسوم هو ببساطة نص شكلي (بمعنى أن الغاية هي الشكل وليس المحتوى) ويُستخدم في صناعات المطابع ودور النشر.",
                          style: TextStyle(
                            fontSize: 20,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 25),
                        Text(
                          "أدخل الكمية",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Cairo",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("1"),
                              Flexible(
                                child: Slider(
                                  min: 1,
                                  max: 10,
                                  divisions: 10,
                                  value: quantity.toDouble(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      quantity = newValue.toInt();
                                    });
                                  },
                                ),
                              ),
                              Text("10"),
                            ],
                          ),
                        ),
                        Text(
                          "$quantity",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IgnorePointer(
                    ignoring: existsInCart,
                    child: FlatButton(
                      color: existsInCart ? Colors.grey : Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            existsInCart
                                ? "تم إضافته بالفعل"
                                : "إضافة لسلة المشتريات",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Order newOrder = Order(
                          id: widget.productId,
                          description: widget.productDescription,
                          price: widget.productPrice,
                          imageUrl: widget.imageUrl,
                          quantity: quantity,
                        );
                        ordersDbHelper.addOrder(newOrder);
                        changeStatusBarColor(appPrimaryColor, false);
                        Navigator.pop(context);
                        addedToCartAlert();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
