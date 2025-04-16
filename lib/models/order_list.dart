import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_flutter/models/order.dart';
import 'package:shop_flutter/utils/Constants.dart';

import 'cart.dart';
import 'cart_item.dart';

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
        total: cart.total,
        items: cart.items.values.toList(),
        dateTime: cart.datetime,
      ),
    );
    notifyListeners();
  }

  Future<void> loadOrders() async {
    final response = await http.get(Uri.parse('${Constants.ordersBaseUrl}.json'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load orders');
    }
    if (response.body == 'null') {
      throw Exception('No orders found');
    }
    final Map<String, dynamic> data = jsonDecode(response.body);
    _items.clear();
    data.forEach((orderId, orderData) {
      _items.add(Order(
        id: orderId,
        total: orderData['total'],
        items: (orderData['items'] as List<dynamic>).map((item) => CartItem.fromJson(item)).toList(),
        dateTime: DateTime.parse(orderData['datetime']),
      ));
    });
    notifyListeners();
  }
}
