import 'package:flutter/material.dart';
import 'package:shop/db/database.dart';
import 'package:shop/models/product.dart'; // Модель Product

class ProductProvider extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService.instance;
  List<Product> _products = [];
  List<Product> _productsCart = [];
  List<Product> _productsHistory = [];

  List<Product> get products => _products;
  List<Product> get productsCart => _productsCart;
  List<Product> get productsHistory => _productsHistory;

  ProductProvider() {
    loadProducts();
    loadCart();
    loadHistory();
  }

  Future<void> loadProducts() async {
    _products = await _databaseService.getProducts();
    notifyListeners();
  }

  Future<void> loadCart() async {
    _productsCart = await _databaseService.getProductsFromCart();
  }

  Future<void> loadHistory() async {
    _productsHistory = await _databaseService.getHistory();
  }

  Future<void> addProduct(String name, double price, String image) async {
    final newProduct = Product(name: name, price: price, image: image);
    await _databaseService.addProduct(newProduct);
    _productsCart.add(newProduct);
    loadCart();
    notifyListeners();
  }

  Future<void> removeProduct(int id) async {
    await _databaseService.deleteProduct(id);
    _productsCart.removeWhere((product) => product.id == id);

    notifyListeners(); // Update the UI
  }

  Future<void> checkOut() async {
    final checkOutId = DateTime.now().toIso8601String();
    await _databaseService.checkOut();

    for (final product in productsCart) {
      await _databaseService.addToHistory(product, checkOutId);
      _productsHistory.add(product);
    }

    _productsCart.clear();

    notifyListeners();
  }

  double totalCost() {
    double totalSumm = 0.0;
    for (final product in _productsCart) {
      totalSumm += product.price;
    }
    return totalSumm;
  }
}
