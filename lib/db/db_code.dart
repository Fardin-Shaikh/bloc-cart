import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class MainDatabase {
  const MainDatabase();
  static final MainDatabase instance = MainDatabase._init();
  static Database? _database;

  MainDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('maindb.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getExternalStorageDirectory();
    final path = join(dbPath!.path, filePath);
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
    log('Fardin $oldVersion');
    if (oldVersion < 2) {
      await db.execute(
          'ALTER TABLE products ADD COLUMN position INTEGER NOT NULL DEFAULT 0');
    }
  }
}
