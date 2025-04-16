import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_flutter/models/product.dart';

class ProductList with ChangeNotifier {
  final _baseUrl = 'https://shop-flutter-8d4e3-default-rtdb.firebaseio.com';

  final List<Product> _items = [];

  List<Product> get items => [..._items]; // clone
  List<Product> get favorites => _items.where((product) => product.isFavorite).toList();

  int get itemsCount => _items.length;

  Uri _parseUrlWith(Product product) => Uri.parse('$_baseUrl/products/${product.id}.json');
  Uri _parseUrl() => Uri.parse('$_baseUrl/products.json');

  Future<void> loadProducts() async {
    final response = await http.get(_parseUrl());
    if (response.body == 'null') return;

    final Map<String, dynamic> data = jsonDecode(response.body);

    if (data.isEmpty) return;

    _items.clear();
    data.forEach((id, productData) {
      _items.add(Product(
        id: id,
        name: productData['name'],
        description: productData['description'],
        price: productData['price'],
        imageUrl: productData['imageUrl'],
        isFavorite: productData['isFavorite'] ?? false,
      ));
    });
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(_parseUrl(), body: product.toJson());
    final id = jsonDecode(response.body)['name'];

    _items.add(Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    ));
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    final index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      await http.patch(
        _parseUrlWith(product),
        body: product.toJson(),
      );
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(Product product) async {
    final index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      final response = await http.delete(_parseUrlWith(product));
      if (response.statusCode < 400) {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }
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
