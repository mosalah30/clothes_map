import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:clothes_map/utils/screen_util.dart';

class RegularProductCard extends StatelessWidget {
  final int id;
  final String imageUrl, description;
  final double price;

  RegularProductCard({
    this.id,
    this.imageUrl,
    this.description,
    this.price,
  });

  final screenUtil = ScreenUtil.instance;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: FlatButton(
        onPressed: () {},
        padding: EdgeInsets.all(0),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.network(
                  imageUrl,
                  height: 100,
                  width: 100,
                ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
