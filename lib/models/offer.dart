import 'package:clothes_map/models/product.dart';
import 'package:clothes_map/utils/values.dart';

class Offer implements Product {
  @override
  int id;

  @override
  double price;

  @override
  String description;

  @override
  String imageUrl;

  final String ownerId;
  final double priceBeforeDiscount;

  Offer({
    this.id,
    this.ownerId,
    this.description,
    this.price,
    this.priceBeforeDiscount,
    this.imageUrl,
  });

  factory Offer.fromJson(Map<String, dynamic> json, bool hotOffer) {
    String imagesStorage =
        hotOffer ? hotOffersImagesStorage : offersImagesStorage;
    return Offer(
      id: int.parse(json['id']),
      ownerId: json['owner_id'],
      description: json['description'],
      price: double.parse(json['price']),
      priceBeforeDiscount: double.parse(json['priceBeforeDiscount']),
      imageUrl: imagesStorage + json['id'] + '.jpg',
    );
  }
}
