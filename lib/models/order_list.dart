import 'package:flutter/material.dart';
import 'package:shop_flutter/models/order.dart';

import 'cart.dart';

class OrderList with ChangeNotifier {
  final List<Order> _items = [];

  List<Order> get items => [..._items]; // clone

  int get itemsCount => _items.length;

  void addOrder(Cart cart) {
    _items.insert(
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
