import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:clothes_map/models/order.dart';

class OrdersDbHelper {
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
    String path = join(documentDirectory.path, 'orders.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      """
        CREATE TABLE orders (id INTEGER, description TEXT,
        price REAL, imageUrl TEXT, quantity INTEGER)
     """,
    );
  }

  Future<List<Order>> getOrders() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(
      'orders',
      columns: ["id", "description", "price", "imageUrl", "quantity"],
    );
    List<Order> orders = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        orders.add(Order.fromMap(maps[i]));
      }
    }
    return orders;
  }

  Future<Order> addOrder(Order order) async {
    var dbClient = await db;
    order.id = await dbClient.insert(
      'orders',
      order.toMap(),
    );
    return order;
  }

  Future<bool> ordersNotEmpty() async {
    var dbClient = await db;
    var queryResult = await dbClient.rawQuery(
      "SELECT * FROM `orders`",
    );
    bool notEmpty = queryResult.isNotEmpty;
    return notEmpty;
  }

  Future<bool> orderExistsInCart(int id) async {
    var dbClient = await db;
    var queryResult = await dbClient.rawQuery(
      "SELECT * FROM `orders` WHERE `id` = '$id'",
    );
    bool recordExists = queryResult.isNotEmpty;
    return recordExists;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'orders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> removeAllOrders() async {
    var dbClient = await db;
    await dbClient.rawQuery("DELETE FROM `orders`");
  }

  Future<void> close() async {
    var dbClient = await db;
    dbClient.close();
    _db = null;
  }
}
