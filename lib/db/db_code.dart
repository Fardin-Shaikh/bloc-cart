import 'dart:developer';

import 'package:ecommerce_app_bloc/Models/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

abstract class MainDatabase {
  final String tabelName;
  const MainDatabase(this.tabelName);
  // static final MainDatabase instance = MainDatabase._init();
  static Database? _database;

  // MainDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('maindb.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getExternalStorageDirectory();
    final path = join(dbPath!.path, filePath);

    // final bool databaseExists = File(path).existsSync();
    // final int databaseVersion = databaseExists ? 2 : 1;
    // log(databaseVersion.toString());
    return await openDatabase(path,
        version: 2, onCreate: _createDB, onUpgrade: _onUpgrade);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        quantity INTEGER NOT NULL,
        position INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE cart(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        quantity INTEGER NOT NULL,
        position INTEGER NOT NULL
      )
    ''');
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('Fardin $oldVersion');
    if (oldVersion < 2) {
      // Add the 'position' column to the 'products' table
      await db.execute(
          'ALTER TABLE products ADD COLUMN position INTEGER NOT NULL DEFAULT 0');
    }

    // if (oldVersion < 3) {
    //   // Add the 'position' column to the 'products' table
    //   await db.execute(
    //       'ALTER TABLE products ADD COLUMN position INTEGER NOT NULL DEFAULT 0');
    // }
  }
  // Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
  //   if (oldVersion < 2) {
  //     // Add the new table 'products' (if not already added)
  //     await db.execute('''
  //     CREATE TABLE IF NOT EXISTS products(
  //       id INTEGER PRIMARY KEY AUTOINCREMENT,
  //       name TEXT NOT NULL,
  //       price REAL NOT NULL,
  //       quantity INTEGER NOT NULL,
  //       position INTEGER NOT NULL
  //     )
  //   ''');

  //     // Add the 'position' column to the 'products' table (if not already added)
  //     await db.execute('''
  //     ALTER TABLE products
  //     ADD COLUMN position INTEGER NOT NULL DEFAULT 0
  //   ''');
  //   }
  // }

  Future<List<Product>> getAllProducts() async {
    final db = await database;
    final products = await db.query(tabelName);
    return products.map((e) => Product.fromMap(e)).toList();
  }

  Future<int> createProduct(
    Product product,
  ) async {
    final db = await database;
    return await db.insert(tabelName, product.toMap());
  }

  Future<int> deleteProduct(int productId) async {
    final db = await database;
    return await db.delete(
      tabelName,
      where: 'id = ?',
      whereArgs: [productId],
    );
  }

  Future<Product?> getProductById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tabelName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      final product = Product.fromMap(maps.first);
      return product;
    } else {
      return null;
    }
  }

  Future<int> updateProduct(Product product) async {
    final db = await database;
    return await db.update(
      tabelName,
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<void> updateProductPosition(int productId, int newPosition) async {
    final db = await database;
    await db.rawUpdate('UPDATE products SET position = ? WHERE id = ?',
        [newPosition, productId]);
    await db.rawUpdate(
        'UPDATE cart SET position = ? WHERE id = ?', [newPosition, productId]);
  }

  Future<void> checkDatabaseVersion() async {
    final db = await database;
    final version = await db.getVersion();
    print('Database Version: $version');
  }

  // Future<int> getHighestPosition() async {
  //   final db = await database;
  //   final result = await db.rawQuery('SELECT MAX(position) FROM products');
  //   int highestPosition =
  //       result.isNotEmpty ? result.first.values.first as int : 0;
  //   return highestPosition;
  // }
}

class ProductDatabase extends MainDatabase {
  ProductDatabase() : super('products');
}

class CartDatabase extends MainDatabase {
  CartDatabase() : super('cart');
}
