import 'dart:convert';

import 'package:medi_source_apitest/models/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static Database? _database;

  static const String tableName = 'login';
  static const String columnId = 'id';
  static const String columnAccessToken = 'access_token';
  static const String cartTableName = 'cart';
  static const String cartId = 'id';
  static const String columnProductData = 'product_data';
  static const String columnQuantity = 'quantity';
  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    // If _database is null, initialize it
    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'your_database.db');

    return openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnAccessToken TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE $cartTableName (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnProductData TEXT,
            $columnQuantity INTEGER
          )
        ''');
      },
    );
  }

  static Future<void> insertLoginData(String accessToken) async {
    final db = await database;
    await db.insert(
      tableName,
      {columnAccessToken: accessToken},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> addToCart(ProductModel productModel, int quantity) async {
    final db = await database;
    await db.insert(
        cartTableName,
        {
          columnProductData: jsonEncode(productModel.toJson()),
          columnQuantity: quantity
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> removeFromCart(int id) async {
    final db = await database;
    db.delete(cartTableName, where: '$cartId=?', whereArgs: [id]);
  }

  static Future<void> updateCartQuantity(int id, int newQuantity) async {
    final db = await database;
    db.update(cartTableName, {columnQuantity: newQuantity},
        where: '$cartId=?', whereArgs: [id]);
  }

  static Future<String?> getAccessToken() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    if (maps.isNotEmpty) {
      return maps.first[columnAccessToken] as String?;
    }
    return null;
  }
  static Future<List<Map<String, dynamic>>> fetchCart() async {
    final db = await database;
    return db.query(cartTableName);
  }
}
