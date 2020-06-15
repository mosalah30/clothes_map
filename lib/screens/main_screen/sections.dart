import 'package:flutter/material.dart';

import 'package:clothes_map/components/section_card.dart';

class Sections extends StatefulWidget {
  @override
  _SectionsState createState() => _SectionsState();
}

class _SectionsState extends State<Sections> {
//  static final sections = [
//    [
//      Section(text: 'ملابس'),
//      Section(text: 'أحذية'),
//      Section(text: 'شنط'),
//      Section(text: 'إكسسوارات'),
//      Section(text: 'رياضة'),
//    ],
//    [
//      Section(text: 'بنات'),
//      Section(text: 'أولاد'),
//    ],
//  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: GridView.count(
        primary: true,
        physics: BouncingScrollPhysics(),
        childAspectRatio: 1,
        crossAxisCount: 2,
        children: <Widget>[
          SectionCard(imageAsset: 'assets/images/1.jpg'),
          SectionCard(imageAsset: 'assets/images/2.jpg'),
          SectionCard(imageAsset: 'assets/images/3.jpg'),
        ],
      ),
    );
  }
}
