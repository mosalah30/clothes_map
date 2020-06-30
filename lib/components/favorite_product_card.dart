import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:clothes_map/utils/screen_util.dart';
import 'package:clothes_map/utils/custom_cached_image.dart';

class FavoriteProductCard extends StatelessWidget {
  final int id;
  final String description;
  final double price;
  final String imageUrl;
  final Function onUnFavorite;

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
                onPressed: () {},
              ),
              IconButton(
                icon: Image.asset(
                  'assets/icons/view_product.png',
                  height: 25,
                  width: 25,
                ),
                tooltip: 'عرض المنتج',
                onPressed: () {},
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
