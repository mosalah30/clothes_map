import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
                Container(
                  height: 100,
                  width: 100,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: Container(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(
                          value: downloadProgress.progress,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error, color: Colors.red),
                  ),
                ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
