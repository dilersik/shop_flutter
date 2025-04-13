import 'package:flutter/material.dart';
import 'package:shop_flutter/models/order.dart';

import 'cart.dart';

class OrderList with ChangeNotifier {
  final List<Order> _allItems = [];

  List<Order> get items => [..._allItems]; // clone

  int get itemsCount => _allItems.length;

  void addOrder(Cart cart) {
    _allItems.insert(
      0,
      Order(
        id: DateTime.timestamp().toString(),
        total: cart.totalAmount,
        items: cart.items.values.toList(),
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
