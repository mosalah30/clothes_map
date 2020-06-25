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

class ColorFullWidget extends InheritedWidget {
  final Color color;

  const ColorFullWidget(
      {Key key, @required Widget child, this.color = Colors.white})
      : assert(child != null, "Child can't be null!"),
        super(key: key, child: child);

  static ColorFullWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ColorFullWidget>();
  }

  @override
  bool updateShouldNotify(ColorFullWidget oldWidget) {
    return color != oldWidget.color;
  }
}
