import 'dart:developer';

import 'package:ecommerce_app_bloc/Models/product.dart';
import 'package:ecommerce_app_bloc/db/db_code.dart';

abstract class DatabaseRepository {
  DatabaseRepository();
  final insta = MainDatabase.instance;

  Future<List<Product>> getAllProducts() async {
    final db = await insta.database;
    final products = await db.query(getTableName());
    return products.map((e) => Product.fromMap(e)).toList();
  }

  Future<int> createProduct(
    Product product,
  ) async {
    final db = await insta.database;
    return await db.insert(getTableName(), product.toMap());
  }

  Future<int> deleteProduct(int productId) async {
    final db = await insta.database;
    return await db.delete(
      getTableName(),
      where: 'id = ?',
      whereArgs: [productId],
    );
  }

  Future<Product?> getProductById(int id) async {
    final db = await insta.database;
    final List<Map<String, dynamic>> maps = await db.query(
      getTableName(),
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
    final db = await insta.database;
    return await db.update(
      getTableName(),
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<void> updateProductPosition(int productId, int newPosition) async {
    final db = await insta.database;
    await db.rawUpdate('UPDATE products SET position = ? WHERE id = ?',
        [newPosition, productId]);
  }

  String getTableName();
}

class ProductDatabase extends DatabaseRepository {
  ProductDatabase() : super();
  @override
  String getTableName() {
    log("on override product ");
    return "products";
  }
}

class CartDatabase extends DatabaseRepository {
  CartDatabase() : super();
  @override
  String getTableName() => "cart";
}
