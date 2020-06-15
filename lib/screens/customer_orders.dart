//import 'package:flutter/material.dart';
//
//import 'package:clothes_map/components/user_order.dart';
//import 'package:clothes_map/models/order.dart';
//
//class CustomerOrders extends StatefulWidget {
//  @override
//  _CustomerOrdersState createState() => _CustomerOrdersState();
//}
//
//class _CustomerOrdersState extends State<CustomerOrders> {
//  List<Order> userOrders = [];
//
//  @override
//  Widget build(BuildContext context) {
//    return SafeArea(
//      child: Directionality(
//        textDirection: TextDirection.rtl,
//        child: Scaffold(
//          body: SingleChildScrollView(
//            child: Container(
//              height: MediaQuery.of(context).size.height,
//              padding: EdgeInsets.all(10),
//              child: Column(
//                children: <Widget>[
//                  for (var order in userOrders) UserOrder(),
//                ],
//              ),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
