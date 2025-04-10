import 'package:flutter/material.dart';
import 'package:shop_flutter/models/order.dart';

import 'cart.dart';

class OrderList with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => [..._orders]; // clone

  int get orderCount => _orders.length;

  void addOrder(Cart cart) {
    _orders.insert(
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
