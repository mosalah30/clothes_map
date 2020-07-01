import 'package:clothes_map/models/product.dart';

class Order implements Product {
  @override
  int id;

  @override
  double price;

  @override
  String description;

  @override
  String imageUrl;

  int quantity;

  Order({
    this.id,
    this.price,
    this.imageUrl,
    this.description,
    this.quantity,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
    return map;
  }

  Order.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    description = map['description'];
    price = map['price'];
    imageUrl = map['imageUrl'];
    quantity = map['quantity'];
  }
}
