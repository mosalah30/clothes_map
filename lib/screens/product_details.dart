import 'package:flutter/material.dart';

import 'package:clothes_map/utils/status_bar_color.dart';

class ProductDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        changeStatusBarColor(Theme.of(context).primaryColor, false);
        return Future(() => true);
      },
      child: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: Container(),
          ),
        ),
      ),
    );
  }
}
