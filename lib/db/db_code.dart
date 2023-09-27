import 'package:ecommerce_app_bloc/Models/product.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProductDatabase {
  static final ProductDatabase instance = ProductDatabase._init();
  static Database? _database;

  ProductDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('products.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getExternalStorageDirectory();
    final path = join(dbPath!.path, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        quantity INTEGER NOT NULL
      )
    ''');
  }

  Future<int> createProduct(Product product) async {
    final db = await instance.database;
    return await db.insert('products', product.toMap());
  }

  Future<List<Product>> getAllProducts() async {
    final db = await instance.database;
    final products = await db.query('products');
    return products.map((e) => Product.fromMap(e)).toList();
  }

  Future<int> deleteProduct(int productId) async {
    final db = await instance.database;
    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [productId],
    );
  }

  Future<int> updateProduct(Product product) async {
    final db = await instance.database;
    return await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<Product?> getProductById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'products',
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
}

//THE CART DB IS HERER

class CartDatabase {
  static final CartDatabase instance = CartDatabase._init();

  static Database? _database;

  CartDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('cart.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getExternalStorageDirectory();
    final path = join(dbPath!.path, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        quantity INTEGER NOT NULL
      )
    ''');
  }

  Future<int> createProduct(Product product) async {
    final db = await instance.database;
    return await db.insert('products', product.toMap());
  }

  Future<List<Product>> getAllProducts() async {
    final db = await instance.database;
    final products = await db.query('products');
    return products.map((e) => Product.fromMap(e)).toList();
  }

  Future<int> deleteProduct(int productId) async {
    final db = await instance.database;
    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [productId],
    );
  }

  // Future<int> updateProduct(Product product) async {
  //   final db = await instance.database;
  //   return await db.update(
  //     'products',
  //     product.toMap(),
  //     where: 'id = ?',
  //     whereArgs: [product.id],
  //   );
  // }

  // Future<Product?> getProductById(int id) async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps = await db.query(
  //     'products',
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );
  //   if (maps.isNotEmpty) {
  //     final product = Product.fromMap(maps.first);
  //     return product;
  //   } else {
  //     return null;
  //   }
  // }
}
