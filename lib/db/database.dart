import 'package:path/path.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/user.dart';
import 'package:sqflite/sqflite.dart';

//We use the singleton pattern to ensure that we have only one class
//instance and provide a global point access to it

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();
  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "shop_db5.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE Users (
          id INTEGER PRIMARY KEY,
          name TEXT NOT NULL
        )
      ''');

        await db.execute('''
        CREATE TABLE Products(
          id INTEGER PRIMARY KEY,
          name TEXT NOT NULL, 
          price REAL NOT NULL,
          image TEXT NOT NULL)
      ''');

        await db.execute('''
        CREATE TABLE Cart(
          id INTEGER PRIMARY KEY,
          name TEXT NOT NULL,
          price REAL NOT NULL,
          image TEXT NOT NULL)
      ''');

        await db.execute('''
        CREATE TABLE History (
          id INTEGER PRIMARY KEY,
          checkoutId TEXT NOT NULL,
          name TEXT NOT NULL,
          price REAL NOT NULL,
          image TEXT NOT NULL
        )
      ''');

        // Добавление начальных данных в таблицу Products
        // await db.insert('Products', {
        //   "name": "Парацетамол",
        //   "price": 45.50,
        //   "image":
        //       "https://root.tblcdn.com/img/goods/af45c99d-56c8-41d0-a9de-165885bad426/1/img_0.jpg?v=AAAAAAnhZ4I",
        // });
        // await db.insert('Products', {
        //   "name": "Нурофен",
        //   "price": 98.30,
        //   "image":
        //       "https://root.tblcdn.com/img/goods/42132f85-e8cb-4c49-b9b3-275cbc7770b0/1/img_0.jpg?v=AAAAAAl986U",
        // });
        // await db.insert('Products', {
        //   "name": "Парацетамол",
        //   "price": 50,
        //   "image":
        //       "https://root.tblcdn.com/img/goods/af45c99d-56c8-41d0-a9de-165885bad426/1/img_0.jpg?v=AAAAAAnhZ4I",
        // });
        // await db.insert('Products', {
        //   "name": "Нурофен",
        //   "price": 30,
        //   "image":
        //       "https://root.tblcdn.com/img/goods/42132f85-e8cb-4c49-b9b3-275cbc7770b0/1/img_0.jpg?v=AAAAAAl986U",
        // });
      },
    );
    return database;
  }

  //db methods for products

  Future<void> addProduct(Product product) async {
    final db = await database;
    await db.insert('Cart', product.toMap());
  }

  Future<List<Product>> getProducts() async {
    final db = await database;
    final data = await db.query('Products');
    List<Product> products = data
        .map((e) => Product(
            id: e['id'] as int,
            name: e['name'] as String,
            price: e['price'] as double,
            image: e['image'] as String))
        .toList();
    return products;
  }

  //db methods for users

  Future<void> addUser(String name) async {
    final db = await database;
    await db.insert('Users', {'name': name});
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    final data = await db.query('Users');
    List<User> users = data
        .map((e) => User(id: e['id'] as int, name: e['name'] as String))
        .toList();
    return users;
  }

  //db methods for cart
  Future<List<Product>> getProductsFromCart() async {
    final db = await database;
    final data = await db.query('Cart');
    List<Product> products = data
        .map((e) => Product(
            id: e['id'] as int,
            name: e['name'] as String,
            price: e['price'] as double,
            image: e['image'] as String))
        .toList();
    return products;
  }

  Future<List<Product>> getHistory() async {
    final db = await database;
    final data = await db.query('History');
    List<Product> products = data
        .map((e) => Product(
            id: e['id'] as int,
            name: e['name'] as String,
            price: e['price'] as double,
            image: e['image'] as String))
        .toList();
    return products;
  }

  Future<void> deleteProduct(int id) async {
    final db = await database;
    await db.delete(
      'Cart',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> checkOut() async {
    final db = await database;
    await db.delete('Cart');
  }

  Future<void> addToHistory(Product product, String checkOutId) async {
    final db = await database;
    final data = await db.query('History');
    await db.insert('History', {
      'checkoutId': checkOutId,
      'name': product.name,
      'price': product.price,
      'image': product.image
    });
  }
}
