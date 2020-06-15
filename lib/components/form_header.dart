import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  final String title;
  FormHeader({this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 40),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.blueGrey,
          fontSize: 17,
        ),
      ),
    );
  }
}
