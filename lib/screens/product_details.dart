import 'package:flutter/material.dart';

import 'package:clothes_map/utils/status_bar_color.dart';
import 'package:clothes_map/utils/styles.dart';
import 'package:clothes_map/utils/custom_cached_image.dart';
import 'package:clothes_map/utils/screen_util.dart';

class ProductDetails extends StatelessWidget {
  final bool previousScreenIsHome;
  final int productId;
  final double productPrice;
  final String imageUrl, productDescription;
  ProductDetails(
    this.previousScreenIsHome, {
    this.productId,
    this.imageUrl,
    this.productDescription,
    this.productPrice,
  });

  final screenUtil = ScreenUtil.instance;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (previousScreenIsHome) {
          changeStatusBarColor(appPrimaryColor, false);
        }
        return Future(() => true);
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
                          child: Icon(
                            Icons.favorite,
                            size: 40,
                            color: Colors.red,
                          ),
                        ),
                        getCacheImage(imageUrl, 300),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              "$productDescription",
                              style: TextStyle(fontSize: screenUtil.setSp(25)),
                            ),
                            Text(
                              "$productPrice جنيه",
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
                              fontSize: 24,
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
