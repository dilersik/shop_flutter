import 'package:flutter/material.dart';
import 'package:shop_flutter/data/dummy_data.dart';
import 'package:shop_flutter/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _allItems = dummyProducts;

  List<Product> get items => [..._allItems]; // clone
  List<Product> get favorites => _allItems.where((product) => product.isFavorite).toList();

  void addProduct(Product product) {
    _allItems.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    final index = _allItems.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _allItems[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(Product product) {
    _allItems.remove(product);
    notifyListeners();
  }

  int get itemsCount => _allItems.length;
}

// List<Product> get products {
//   return _showFavoritesOnly ? _products.where((product) => product.isFavorite).toList() : [..._products]; // clone
// }
//
// bool _showFavoritesOnly = false;
//
// void addProduct(Product product) {
//   _products.add(product);
//   notifyListeners();
// }
//
// void removeProduct(Product product) {
//   _products.remove(product);
//   notifyListeners();
// }
//
// void clearProducts() {
//   _products.clear();
//   notifyListeners();
// }
//
// void showFavoritesOnly() {
//   _showFavoritesOnly = true;
//   notifyListeners();
// }
