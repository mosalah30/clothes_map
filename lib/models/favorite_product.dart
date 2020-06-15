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

  @override
  String section;

  @override
  String category;

  FavoriteProduct({
    this.id,
    this.description,
    this.price,
    this.imageUrl,
    this.category,
    this.section,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category.toString(),
      'section': section,
    };
    return map;
  }

  FavoriteProduct.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    description = map['description'];
    price = map['price'];
    imageUrl = map['imageUrl'];
    category = map['category'];
    section = map['section'];
  }
}
