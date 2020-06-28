import 'package:clothes_map/models/product.dart';

enum OrderStatus { failed, ordered, delivering, received }

class Order implements Product {
  @override
  int id;

  @override
  double price;

  @override
  String description;

  @override
  String imageUrl;

  final OrderStatus orderStatus;
  final DateTime purchaseDate;

  Order({
    this.id,
    this.price,
    this.imageUrl,
    this.description,
    this.orderStatus,
    this.purchaseDate,
  });
}
