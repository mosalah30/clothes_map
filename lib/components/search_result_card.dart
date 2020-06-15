import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:clothes_map/utils/screen_util.dart';

class SearchResultCard extends StatelessWidget {
  final String imageUrl;
  final description;
  final double price;
  final String section;
  final String category;
  final Function onTap;

  SearchResultCard({
    this.imageUrl,
    this.description,
    this.price,
    this.section,
    this.category,
    this.onTap,
  });

  final screenUtil = ScreenUtil.instance;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0),
      onPressed: onTap,
      child: Card(
        child: Row(
          children: <Widget>[
            Image.network(
              imageUrl,
              height: 100,
              width: 100,
            ),
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
