import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_flutter/data/dummy_data.dart';
import 'package:shop_flutter/models/product.dart';

class ProductList with ChangeNotifier {
  final baseURL = 'https://shop-flutter-8d4e3-default-rtdb.firebaseio.com';

  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items]; // clone
  List<Product> get favorites => _items.where((product) => product.isFavorite).toList();

  void addProduct(Product product) {
    http
        .post(Uri.parse('$baseURL/products.json'), body: product.toJson())
        .then((response) {
          final id = jsonDecode(response.body)['name'];

          _items.add(Product(
            id: id,
            name: product.name,
            description: product.description,
            price: product.price,
            imageUrl: product.imageUrl,
          ));
          notifyListeners();
        })
        .catchError((error) {

        });
  }

  void updateProduct(Product product) {
    final index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(Product product) {
    final index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }

  int get itemsCount => _items.length;
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
