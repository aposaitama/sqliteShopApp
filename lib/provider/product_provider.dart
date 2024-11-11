import 'package:flutter/material.dart';
import 'package:shop/db/database.dart';
import 'package:shop/models/product.dart'; // Модель Product

class ProductProvider extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService.instance;
  List<Product> _products = [];
  List<Product> _productsCart = [];

  List<Product> get products => _products;
  List<Product> get productsCart => _productsCart;

  ProductProvider() {
    loadProducts();
    loadCart();
  }

  Future<void> loadProducts() async {
    _products = await _databaseService.getProducts();
    notifyListeners();
  }

  Future<void> loadCart() async {
    _productsCart = await _databaseService.getProductsFromCart();
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
    totalCost();
    notifyListeners(); // Update the UI
  }

  Future<void> checkOut() async {
    await _databaseService.checkOut();

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
