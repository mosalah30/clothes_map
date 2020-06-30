import 'package:flutter/material.dart';

import 'package:clothes_map/screens/main_screen/main_widget.dart';
import 'package:clothes_map/models/favorite_product.dart';
import 'package:clothes_map/services/favorite_products_db_helper.dart';
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
  FavoriteProductsDbHelper _dbHelper;
  bool favorite = false;

  @override
  void initState() {
    super.initState();
    _dbHelper = FavoriteProductsDbHelper();
    getFavoriteBool();
  }

  void getFavoriteBool() async {
    bool newBool = await _dbHelper.favoriteProductExists(
      widget.productId,
      widget.productDescription,
    );
    setState(() {
      favorite = newBool ?? false;
    });
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
            body: Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 9,
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
                                await _dbHelper.delete(
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
                                await _dbHelper.add(newFavoriteProduct);
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
                          "لوريم إيبسوم هو ببساطة نص شكلي (بمعنى أن الغاية هي الشكل وليس المحتوى) ويُستخدم في صناعات المطابع ودور النشر. كان لوريم إيبسوم ولايزال المعيار للنص الشكلي منذ القرن الخامس عشر.",
                          style: TextStyle(
                            fontSize: 20,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
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
                            "إضافة لسلة المشتريات",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
