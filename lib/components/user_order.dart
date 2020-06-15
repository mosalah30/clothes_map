//import 'package:flutter/material.dart';
//
//class UserOrder extends StatelessWidget {
//  final int id;
//  final String description;
//  final String status;
//  final String imageUrl;
//  final DateTime purchaseDate;
//
//  UserOrder({
//    this.id,
//    this.description,
//    this.status,
//    this.imageUrl,
//    this.purchaseDate,
//  });
//
//  @override
//  Widget build(BuildContext context) {
//    return Card(
//      elevation: 3,
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//        children: <Widget>[
//          Container(
//            width: 120,
//            height: 150,
//            child: Image.network(imageUrl),
//          ),
//          Column(
//            children: <Widget>[
//              Text(description),
//              SizedBox(height: 10),
//              Text(purchaseDate.toString()),
//              SizedBox(height: 20),
//              Text(status),
//            ],
//          ),
//        ],
//      ),
//    );
//  }
//}
