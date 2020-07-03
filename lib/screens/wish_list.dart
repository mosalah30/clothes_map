import 'package:flutter/material.dart';

import 'package:clothes_map/components/colors_loader.dart';
import 'package:clothes_map/components/favorite_product_card.dart';
import 'package:clothes_map/models/favorite_product.dart';
import 'package:clothes_map/services/favorite_products_db_helper.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  FavoriteProductsDbHelper dbHelper;
  Future<List<FavoriteProduct>> favoriteProducts;

  @override
  void initState() {
    dbHelper = FavoriteProductsDbHelper();
    refreshFavoriteProductsList();
    super.initState();
  }

  void refreshFavoriteProductsList() {
    setState(() {
      favoriteProducts = dbHelper.getFavoriteProducts();
    });
  }

  Widget generateFavoriteProductsList(List<FavoriteProduct> favoriteProducts) {
    return SingleChildScrollView(
      child: Column(
        children: favoriteProducts
            .map(
              (product) => FavoriteProductCard(
                id: product.id,
                description: product.description,
                price: product.price,
                imageUrl: product.imageUrl,
                onUnFavorite: () async {
                  await dbHelper.delete(product.id, product.description);
                  refreshFavoriteProductsList();
                },
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          centerTitle: true,
          title: Text(
            "قائمة الرغبات",
            style: TextStyle(
              fontSize: 25,
              fontFamily: "Cairo",
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: FutureBuilder(
            future: favoriteProducts,
            builder: (context, snapshot) {
              if (snapshot.data == null || snapshot.data.length == 0) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/icons/empty_favorites.png',
                        height: 100,
                        width: 100,
                      ),
                      Text(
                        'لا شيء هنا',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasData && snapshot.data.length > 0) {
                return generateFavoriteProductsList(snapshot.data);
              }
              return Expanded(
                child: ColorsLoader(),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    dbHelper.close();
    super.dispose();
  }
}
