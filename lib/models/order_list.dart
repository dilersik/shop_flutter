import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_flutter/models/order.dart';
import 'package:shop_flutter/utils/Constants.dart';

import 'cart.dart';

class OrderList with ChangeNotifier {
  final List<Order> _items = [];

  List<Order> get items => [..._items]; // clone

  int get itemsCount => _items.length;

  Future<void> addOrder(Cart cart) async {
    cart.datetime = DateTime.now();
    await http.post(
      Uri.parse('${Constants.ordersBaseUrl}.json'),
      body: cart.toJson(),
    );

    _items.insert(
      0,
      Order(
        id: DateTime.timestamp().toString(),
        total: cart.totalAmount,
        items: cart.items.values.toList(),
        dateTime: cart.datetime,
      ),
    );
    notifyListeners();
  }
}
