import 'package:clothes_map/models/product.dart';

class FavoriteProduct implements Product {
  @override
  int id;

  @override
  double price;

  @override
  String description;

  @override
  String imageUrl;

  FavoriteProduct({
    this.id,
    this.description,
    this.price,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
    return map;
  }

  FavoriteProduct.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    description = map['description'];
    price = map['price'];
    imageUrl = map['imageUrl'];
  }
}
