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

  @override
  String section;

  @override
  String category;

  final OrderStatus orderStatus;
  final DateTime purchaseDate;

  Order({
    this.id,
    this.price,
    this.imageUrl,
    this.section,
    this.description,
    this.category,
    this.orderStatus,
    this.purchaseDate,
  });
}
