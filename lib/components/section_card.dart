import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  final String imageAsset;
  final String title;

  SectionCard({this.imageAsset, this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 3,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imageAsset),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
