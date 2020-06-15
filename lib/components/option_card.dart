import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final String leadingIconAsset;
  final Function onTap;
  final String title;

  OptionCard({
    this.leadingIconAsset,
    this.onTap,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0),
      splashColor: Colors.lightBlueAccent,
      onPressed: onTap,
      child: ListTile(
        leading: Image.asset(
          'assets/icons/$leadingIconAsset',
          height: 25,
          width: 25,
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
