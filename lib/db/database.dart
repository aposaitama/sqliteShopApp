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
          login TEXT NOT NULL UNIQUE,
          password TEXT NOT NULL
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
  image TEXT NOT NULL,
  userId INTEGER,
  productId INTEGER,
  FOREIGN KEY (userId) REFERENCES Users(id),
  FOREIGN KEY (productId) REFERENCES Products(id)
)
''');

        await db.execute('''
        CREATE TABLE History (
          id INTEGER PRIMARY KEY,
          checkoutId TEXT NOT NULL,
          name TEXT NOT NULL,
          price REAL NOT NULL,
          image TEXT NOT NULL,
          userId INTEGER,
          FOREIGN KEY (userId) REFERENCES Users(id)
        )
      ''');

        await db.insert('Products', {
          "name": "Парацетамол",
          "price": 45.50,
          "image":
              "https://root.tblcdn.com/img/goods/af45c99d-56c8-41d0-a9de-165885bad426/1/img_0.jpg?v=AAAAAAnhZ4I",
        });
        await db.insert('Products', {
          "name": "Нурофен",
          "price": 98.30,
          "image":
              "https://root.tblcdn.com/img/goods/42132f85-e8cb-4c49-b9b3-275cbc7770b0/1/img_0.jpg?v=AAAAAAl986U",
        });
        await db.insert('Products', {
          "name": "Парацетамол",
          "price": 50,
          "image":
              "https://root.tblcdn.com/img/goods/af45c99d-56c8-41d0-a9de-165885bad426/1/img_0.jpg?v=AAAAAAnhZ4I",
        });
        await db.insert('Products', {
          "name": "Нурофен",
          "price": 30,
          "image":
              "https://root.tblcdn.com/img/goods/42132f85-e8cb-4c49-b9b3-275cbc7770b0/1/img_0.jpg?v=AAAAAAl986U",
        });
      },
    );
    return database;
  }

  //db methods for products

  Future<void> addProduct(Product product, int userId) async {
    final db = await database;
    await db.insert('Cart', {
      'id': product.id,
      'name': product.name,
      'price': product.price,
      'image': product.image,
      'userId': userId,
      'productId': product.id,
    });
    // product.toMap());
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

  Future<int> addUser(String login, String password) async {
    final db = await database;
    final userId =
        await db.insert('Users', {'login': login, 'password': password});
    return userId;
  }

  Future<int?> loginUser(String login, String password) async {
    final db = await database;
    final userId = await db.query('Users',
        where: 'login = ? AND password = ?', whereArgs: [login, password]);
    if (userId.isNotEmpty) {
      return userId.first['id'] as int;
    }
    return null;
  }

  //db methods for cart
  Future<List<Product>> getProductsFromCart(int userId) async {
    final db = await database;
    final data =
        await db.query('Cart', where: 'userId = ?', whereArgs: [userId]);
    List<Product> products = data
        .map((e) => Product(
            id: e['id'] as int,
            name: e['name'] as String,
            price: e['price'] as double,
            image: e['image'] as String))
        .toList();
    return products;
  }

  Future<List<Product>> getHistory(int userId) async {
    final db = await database;
    final data =
        await db.query('History', where: 'userId = ?', whereArgs: [userId]);
    List<Product> products = data
        .map((e) => Product(
            id: e['id'] as int,
            name: e['name'] as String,
            price: e['price'] as double,
            image: e['image'] as String,
            checkoutId: e['checkoutId'] as String))
        .toList();
    return products;
  }

  Future<void> deleteProduct(int id, int userId) async {
    final db = await database;
    await db.delete(
      'Cart',
      where: 'id = ? AND userId = ?',
      whereArgs: [id, userId],
    );
  }

  Future<void> checkOut(int userId) async {
    final db = await database;
    await db.delete('Cart', where: 'userId = ?', whereArgs: [userId]);
  }

  Future<void> addToHistory(
      Product product, String checkOutId, int userId) async {
    final db = await database;
    await db.insert('History', {
      'userId': userId,
      'checkoutId': checkOutId,
      'name': product.name,
      'price': product.price,
      'image': product.image
    });
  }
}
