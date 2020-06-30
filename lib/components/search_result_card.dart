import 'package:clothes_map/screens/product_details.dart';
import 'package:clothes_map/utils/status_bar_color.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:clothes_map/utils/screen_util.dart';
import 'package:clothes_map/utils/custom_cached_image.dart';
import 'package:clothes_map/utils/transitions.dart';

class SearchResultCard extends StatelessWidget {
  final int id;
  final double price;
  final String imageUrl, description, section, category;

  SearchResultCard({
    this.id,
    this.imageUrl,
    this.description,
    this.price,
    this.section,
    this.category,
  });

  final screenUtil = ScreenUtil.instance;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0),
      onPressed: () {
        changeStatusBarColor(Colors.black, true);
        Navigator.of(context).push(
          FadeRoute(
            newScreen: ProductDetails(
              true,
              imageUrl: imageUrl,
              productDescription: description,
              productPrice: price,
              productId: id,
            ),
          ),
        );
      },
      child: Card(
        child: Row(
          children: <Widget>[
            getCacheImage(imageUrl, 100),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('$section $category'),
                  AutoSizeText(
                    description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: screenUtil.setSp(18)),
                  ),
                  Text(
                    '$price جنيه',
                    style: TextStyle(fontSize: screenUtil.setSp(18)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
