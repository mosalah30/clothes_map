import 'package:flutter/material.dart';

import 'package:clothes_map/utils/screen_util.dart';
import 'package:clothes_map/utils/status_bar_color.dart';

class Shop extends StatefulWidget {
  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  Widget buildSection(BuildContext context, String sectionTitle) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      height: 40,
      color: Colors.blue,
      child: Center(
        child: Text(
          sectionTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  List<Widget> buildSectionSub(BuildContext context, List sourceList) {
    return [
      for (int i = 0; i < sourceList.length; i++)
        Container(
          width: MediaQuery.of(context).size.width / 3,
          height: 40,
          child: FlatButton(
            padding: EdgeInsets.all(0),
            child: Text(
              sourceList[i],
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            onPressed: () {},
          ),
        )
    ];
  }

  @override
  Widget build(BuildContext context) {
    changeStatusBarColor(Colors.black, true);
    final deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.all(1),
            child: Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                  ),
                  width: deviceWidth / 3,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        child: Text(
                          'الصالون الأبيض',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(20),
                            fontFamily: 'Amiri',
                          ),
                        ),
                        padding: EdgeInsets.all(7),
                      ),
                      Divider(
                        color: Colors.black,
                        height: 0,
                        thickness: 2,
                      ),
                      Column(
                        children: <Widget>[],
                      ),
                    ],
                  ),
                ),
                Column(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    changeStatusBarColor(Theme.of(context).primaryColor, false);
  }
}