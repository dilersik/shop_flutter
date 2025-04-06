
import 'package:flutter/material.dart';
import 'package:shop_flutter/data/dummy_data.dart';
import 'package:shop_flutter/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _products = dummyProducts;

  List<Product> get products => [..._products]; // clone

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _products.remove(product);
    notifyListeners();
  }

  void clearProducts() {
    _products.clear();
    notifyListeners();
  }
}