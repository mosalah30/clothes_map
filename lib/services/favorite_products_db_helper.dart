import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:clothes_map/models/favorite_product.dart';

class FavoriteProductsDbHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  Future<Database> initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'favorite_products.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      """
        CREATE TABLE favorite_products (id INTEGER, description TEXT,
        price REAL, imageUrl TEXT, section TEXT, category TEXT)
     """,
    );
  }

  Future<List<FavoriteProduct>> getFavoriteProducts() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(
      'favorite_products',
      columns: [
        'id',
        'description',
        'price',
        'imageUrl',
        'category',
        'section'
      ],
    );
    List<FavoriteProduct> favoriteProducts = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        favoriteProducts.add(FavoriteProduct.fromMap(maps[i]));
      }
    }
    return favoriteProducts;
  }

  Future<FavoriteProduct> add(FavoriteProduct favoriteProduct) async {
    var dbClient = await db;
    favoriteProduct.id = await dbClient.insert(
      'favorite_products',
      favoriteProduct.toMap(),
    );
    return favoriteProduct;
  }

  Future<bool> favoriteProductExists(int id, String section) async {
    var dbClient = await db;
    var queryResult = await dbClient.rawQuery(
      "SELECT * FROM `favorite_products` WHERE `section` = '$section' AND `id` = '$id'",
    );
    bool recordExists = queryResult.isNotEmpty;
    return recordExists;
  }

  Future<int> delete(int id, String section) async {
    var dbClient = await db;
    return await dbClient.delete(
      'favorite_products',
      where: 'id = ? AND section = ?',
      whereArgs: [id, section],
    );
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
