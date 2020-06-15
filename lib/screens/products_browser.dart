import 'package:flutter/material.dart';

class ProductsBrowser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Container(),
        ),
      ),
    );
  }
}
