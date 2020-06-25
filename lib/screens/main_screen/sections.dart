import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clothes_map/screens/products_browser.dart';
import 'package:clothes_map/state_management/screens_controller.dart';
import 'package:clothes_map/utils/values.dart';
import 'package:clothes_map/utils/transitions.dart';

class Sections extends StatelessWidget {
  Widget buildSectionCard(String title, BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0),
      onPressed: () {
        Navigator.of(context).push(
          ScaleTransitionEffect(newScreen: ProductsBrowser(title)),
        );
      },
      child: Card(
        elevation: 3,
        child: Image.asset('assets/sections/$title.jpg'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Selector<ScreensController, int>(
        selector: (context, screensController) =>
            screensController.sectionIndex,
        builder: (context, sectionIndex, child) => GridView.count(
          primary: true,
          childAspectRatio: 1,
          crossAxisCount: 2,
          shrinkWrap: true,
          children: <Widget>[
            for (String section in sections[sectionIndex])
              buildSectionCard(section, context),
          ],
        ),
      ),
    );
  }
}
