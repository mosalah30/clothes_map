import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:clothes_map/screens/product_details.dart';
import 'package:clothes_map/utils/screen_util.dart';
import 'package:clothes_map/utils/custom_cached_image.dart';
import 'package:clothes_map/utils/transitions.dart';

class ProductCard extends StatelessWidget {
  final bool isInCart;
  final int id;
  final String imageUrl, description;
  final double price;
  final Function onCartRemove;

  ProductCard({
    this.isInCart = false,
    this.id,
    this.imageUrl,
    this.description,
    this.price,
    this.onCartRemove,
  });

  final screenUtil = ScreenUtil.instance;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: FlatButton(
        onPressed: () {
          if (!isInCart) {
            Navigator.of(context).push(
              FadeRoute(
                newScreen: ProductDetails(
                  false,
                  productsRefreshRequired: false,
                  productId: this.id,
                  imageUrl: this.imageUrl,
                  productDescription: this.description,
                  productPrice: this.price,
                ),
              ),
            );
          }
        },
        padding: EdgeInsets.all(0),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                getCacheImage(imageUrl, 100),
                SizedBox(width: 5),
                Expanded(
                  child: AutoSizeText(
                    description,
                    maxLines: 2,
                    style: TextStyle(fontSize: screenUtil.setSp(18)),
                  ),
                ),
                AutoSizeText(
                  '$price جنيه',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: screenUtil.setSp(18)),
                ),
                onCartRemove != null
                    ? IconButton(
                        icon: Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        onPressed: onCartRemove,
                      )
                    : Container(height: 0, width: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
