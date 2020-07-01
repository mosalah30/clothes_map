import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:clothes_map/screens/product_details.dart';
import 'package:clothes_map/models/order.dart';
import 'package:clothes_map/services/orders_db_helper.dart';
import 'package:clothes_map/utils/screen_util.dart';
import 'package:clothes_map/utils/custom_cached_image.dart';
import 'package:clothes_map/utils/transitions.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FavoriteProductCard extends StatelessWidget {
  final int id;
  final String description;
  final double price;
  final String imageUrl;
  final Function onUnFavorite;

  final ordersDbHelper = OrdersDbHelper();

  FavoriteProductCard({
    this.id,
    this.description,
    this.price,
    this.imageUrl,
    this.onUnFavorite,
  });

  final screenUtil = ScreenUtil.instance;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              getCacheImage(imageUrl, 100),
            ],
          ),
          SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AutoSizeText(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: screenUtil.setSp(18)),
              ),
              AutoSizeText(
                '$price جنيه',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: screenUtil.setSp(18)),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: Image.asset(
                  'assets/icons/add_to_cart.png',
                  height: 25,
                  width: 25,
                ),
                tooltip: 'إضافة لسلة المشتريات',
                onPressed: () async {
                  Order newOrder = Order(
                    quantity: 1,
                    imageUrl: imageUrl,
                    description: description,
                    id: id,
                    price: price,
                  );
                  bool existsInCart =
                      await ordersDbHelper.orderExistsInCart(id);
                  if (!existsInCart) {
                    ordersDbHelper.addOrder(newOrder);
                    Fluttertoast.showToast(
                      msg: "تم إضافة طلبك إلى عربة التسوق",
                    );
                  } else {
                    Fluttertoast.showToast(
                      msg: "هذا المنتج موجود بالفعل في عربة التسوق",
                    );
                  }
                },
              ),
              IconButton(
                icon: Image.asset(
                  'assets/icons/view_product.png',
                  height: 25,
                  width: 25,
                ),
                tooltip: 'عرض المنتج',
                onPressed: () {
                  Navigator.of(context).push(
                    FadeRoute(
                      newScreen: ProductDetails(
                        false,
                        productsRefreshRequired: false,
                        productId: this.id,
                        productPrice: this.price,
                        productDescription: this.description,
                        imageUrl: this.imageUrl,
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Image.asset(
                  'assets/icons/unfavorite.png',
                  height: 25,
                  width: 25,
                ),
                tooltip: 'حذف',
                onPressed: onUnFavorite,
              )
            ],
          ),
        ],
      ),
    );
  }
}
