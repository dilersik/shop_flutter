import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_flutter/models/order.dart';
import 'package:shop_flutter/utils/constants.dart';

import 'cart.dart';
import 'cart_item.dart';

class OrderList with ChangeNotifier {
  final String _authToken;
  final String _userId;
  List<Order> _items = [];

  List<Order> get items => [..._items]; // clone

  int get itemsCount => _items.length;

  OrderList([this._authToken = '', this._userId = '', this._items = const []]);

  Uri parseUrl() => Uri.parse('${Constants.ordersBaseUrl}/$_userId.json?auth=$_authToken');

  Future<void> addOrder(Cart cart) async {
    cart.datetime = DateTime.now();
    await http.post(parseUrl(), body: cart.toJson());

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
    List<Order> items = [];
    final response = await http.get(parseUrl());
    if (response.statusCode != 200) {
      throw Exception('Failed to load orders');
    }
    if (response.body == 'null') {
      throw Exception('No orders found');
    }
    final Map<String, dynamic> data = jsonDecode(response.body);
    items.clear();
    data.forEach((orderId, orderData) {
      items.add(
        Order(
          id: orderId,
          total: orderData['total'],
          items: (orderData['items'] as List<dynamic>).map((item) => CartItem.fromJson(item)).toList(),
          dateTime: DateTime.parse(orderData['datetime']),
        ),
      );
    });

    _items = items.reversed.toList();
    notifyListeners();
  }
}
