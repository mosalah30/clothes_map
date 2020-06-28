import 'package:clothes_map/models/product.dart';
import 'package:clothes_map/utils/values.dart';

class RegularProduct implements Product {
  @override
  int id;

  @override
  double price;

  @override
  String description;

  @override
  String imageUrl;

  final String section;
  final String category;
  final String ownerId;

  RegularProduct({
    this.id,
    this.ownerId,
    this.description,
    this.price,
    this.imageUrl,
    this.category,
    this.section,
  });

  factory RegularProduct.fromJson(Map<String, dynamic> json) {
    return RegularProduct(
      id: int.parse(json['id']),
      ownerId: json['owner_id'],
      description: json['description'],
      price: double.parse(json['price']),
      imageUrl: regularProductsImagesStorage + json['id'] + '.jpg',
      category: json['category'],
      section: json['section'],
    );
  }
}
