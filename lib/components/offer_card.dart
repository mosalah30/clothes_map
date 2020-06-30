import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:clothes_map/screens/product_details.dart';
import 'package:clothes_map/services/favorite_products_db_helper.dart';
import 'package:clothes_map/models/favorite_product.dart';
import 'package:clothes_map/utils/transitions.dart';
import 'package:clothes_map/utils/status_bar_color.dart';
import 'package:clothes_map/utils/screen_util.dart';
import 'package:clothes_map/utils/custom_cached_image.dart';

class OfferCard extends StatefulWidget {
  final bool isHotOffer;
  final int id;
  final double price;
  final double priceBeforeDiscount;
  final String imageUrl;
  final String description;

  OfferCard({
    this.isHotOffer = false,
    this.id,
    this.imageUrl,
    this.price,
    this.priceBeforeDiscount,
    this.description,
  });

  @override
  _OfferCardState createState() => _OfferCardState();
}

class _OfferCardState extends State<OfferCard> {
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
      widget.id,
      widget.description,
    );
    setState(() {
      favorite = newBool ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final discountRate =
        ((1 - (widget.price / widget.priceBeforeDiscount)) * 100).round();
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: FlatButton(
        padding: EdgeInsets.all(0),
        child: Card(
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: Container(
                      width: screenUtil.setSp(50),
                      color: Colors.red,
                      child: Text(
                        '$discountRate%-',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Amiri',
                          fontSize: screenUtil.setSp(20),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      favorite ? Icons.favorite : Icons.favorite_border,
                      color: favorite ? Color(0xffbc1e1b) : Colors.black,
                    ),
                    onPressed: () async {
                      if (favorite) {
                        await _dbHelper.delete(widget.id, widget.description);
                      } else {
                        FavoriteProduct newFavoriteProduct = FavoriteProduct(
                          id: widget.id,
                          description: widget.description,
                          price: widget.price,
                          imageUrl: widget.imageUrl,
                        );
                        await _dbHelper.add(newFavoriteProduct);
                      }
                      setState(() {
                        favorite = !favorite;
                      });
                    },
                  ),
                ],
              ),
              getCacheImage(widget.imageUrl, 200),
              AutoSizeText(
                widget.description,
                maxLines: 1,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: screenUtil.setSp(16),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: <Widget>[
                  Text(
                    '${widget.priceBeforeDiscount} LE',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: screenUtil.setSp(20),
                      fontFamily: 'Amiri',
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Text(
                    '${widget.price} LE ',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: screenUtil.setSp(20),
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w900,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        onPressed: () {
          changeStatusBarColor(Colors.black, true);
          Navigator.of(context).push(
            FadeRoute(
              newScreen: ProductDetails(
                widget.isHotOffer,
                productId: widget.id,
                productPrice: widget.price,
                productDescription: widget.description,
                imageUrl: widget.imageUrl,
              ),
            ),
          );
        },
      ),
    );
  }
}
