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

  @override
  String section;

  @override
  String category;

  final int quantity;
  final String ownerId;

  RegularProduct({
    this.id,
    this.ownerId,
    this.description,
    this.price,
    this.imageUrl,
    this.category,
    this.section,
    this.quantity,
  });

  factory RegularProduct.fromJson(Map<String, dynamic> json) {
    return RegularProduct(
      id: int.parse(json['id']),
      ownerId: json['owner_id'],
      description: json['description'],
      price: double.parse(json['price']),
      imageUrl: regularProductsImagesStorage +
          json['id'] +
          '.' +
          json['imageExtension'],
      category: json['category'],
      section: json['section'],
      quantity: int.parse(json['quantity']),
    );
  }
}
