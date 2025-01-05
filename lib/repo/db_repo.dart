import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test/model/product_model.dart';

class DatabaseRepo {
  static final DatabaseRepo _instance = DatabaseRepo._internal();
  factory DatabaseRepo() => _instance;
  static Database? _database;

  DatabaseRepo._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'ecommerce.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE products (
            id INTEGER PRIMARY KEY,
            name TEXT,
            description TEXT,
            imageUrl TEXT,
            price REAL,
            isInCart INTEGER
          )''');
      },
    );
  }

  // Add a product to the database if it's not already there
  Future<void> addProduct(Product product) async {
    final db = await database;
    final existingProduct =
        await db.query('products', where: 'id = ?', whereArgs: [product.id]);
    if (existingProduct.isEmpty) {
      await db.insert('products', product.toMap());
    }
  }

  // Fetch all products from the database
  Future<List<Product>> fetchProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }

  // Update the `isInCart` flag in the database
  Future<void> updateIsInCart(int productId, bool isInCart) async {
    final db = await database;
    await db.update(
      'products',
      {'isInCart': isInCart ? 1 : 0},
      where: 'id = ?',
      whereArgs: [productId],
    );
  }
}
