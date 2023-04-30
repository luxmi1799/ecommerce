import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/Database/product_db.dart';
import 'package:flutter_ecommerce/bloc/ecommerce/ecommerce_model.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart' as path;

class DatabaseHelper {
  static const productTable = "producttable";
  static const dbVersion = 2;

  static const idProductColumn = "id";
  static const productnameColumn = "title";
  static const productpriceColumn = "price";
  static const image64bitColumn = "featured_image";

  static Future _onCreate(Database db, int version) {
    return db.execute("""
    CREATE TABLE $productTable(
    $idProductColumn INTEGER PRIMARY KEY AUTOINCREMENT,
    $productnameColumn TEXT,
    $image64bitColumn TEXT,
    $productpriceColumn TEXT
    )    
    """);
  }

  static open() async {
    final rootPath = await getDatabasesPath();

    print("DB OPENED");
    final dbPath = path.join(rootPath, "ProductDb.db");

    return openDatabase(dbPath, onCreate: _onCreate, version: dbVersion);
  }

  static Future insertProfile(Map<String, dynamic> row) async {
    final db = await DatabaseHelper.open();
    print("ROW INSERTED");
    return await db.insert(productTable, row);
  }

  static getAllProduct() async {
    final db = await DatabaseHelper.open();

    List<Map<String, dynamic>> mapList = await db.query(productTable);
    debugPrint("mapList $mapList");
    return List.generate(
        mapList.length, (index) => Products_DB.fromJson(mapList[index]));
  }
}
