import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/db/database.dart';
import 'package:shop/models/product.dart'; // Модель Product

class ProductProvider extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService.instance;
  int? _userId;
  int? get userId => _userId;
  List<Product> _products = [];
  List<Product> _productsCart = [];
  List<Product> _productsHistory = [];

  List<Product> get products => _products;
  List<Product> get productsCart => _productsCart;
  List<Product> get productsHistory => _productsHistory;

  ProductProvider() {
    loadProducts();
    loadUserId();
  }

  Future<void> loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    _userId = prefs.getInt('userID');
    print(_userId);
    if (_userId != null) {
      await loadCart();
      await loadHistory();
    }
    notifyListeners();
  }

  Future<void> loadProducts() async {
    _products = await _databaseService.getProducts();
    notifyListeners();
  }

  Future<void> loadCart() async {
    if (userId != null) {
      _productsCart = await _databaseService.getProductsFromCart(userId!);
      notifyListeners();
    }
  }

  Future<void> loadHistory() async {
    if (userId != null) {
      _productsHistory = await _databaseService.getHistory(userId!);
      notifyListeners();
    }
  }

  Future<void> addProduct(String name, double price, String image) async {
    final newProduct = Product(name: name, price: price, image: image);
    await _databaseService.addProduct(newProduct, userId!);
    _productsCart.add(newProduct);
    await loadCart();
    notifyListeners();
  }

  Future<void> removeProduct(int id) async {
    if (userId != null) {
      await _databaseService.deleteProduct(id, userId!);
      _productsCart.removeWhere((product) => product.id == id);
      notifyListeners();
    }
  }

  Future<void> checkOut() async {
    if (userId != null) {
      final checkOutId = DateTime.now().toIso8601String();
      await _databaseService.checkOut(userId!);

      for (final product in productsCart) {
        await _databaseService.addToHistory(product, checkOutId, userId!);
        _productsHistory.add(product);
      }

      _productsCart.clear();
      await loadHistory();
      notifyListeners();
    }
  }

  double totalCost() {
    double totalSumm = 0.0;
    for (final product in _productsCart) {
      totalSumm += product.price;
    }
    return totalSumm;
  }

  Map<String, List<Product>> get groupedHistory {
    final Map<String, List<Product>> groupedMap = {};
    for (var product in _productsHistory) {
      // Перевіряємо чи checkoutId не є null, якщо так - використовуємо значення за замовчуванням
      final checkoutId = product.checkoutId ?? 'default_checkout_id';

      if (!groupedMap.containsKey(checkoutId)) {
        groupedMap[checkoutId] = [];
      }
      groupedMap[checkoutId]!.add(product);
    }
    return groupedMap;
  }
}
