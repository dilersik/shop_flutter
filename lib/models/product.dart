import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_flutter/utils/constants.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    bool hasId = json.containsKey('id');
    return Product(
      id: hasId ? json['id'] as String : DateTime.now().toString(),
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
    );
  }

  Future<void> toggleFavorite(String token, String userId) async {
    final response = await http.put(
      Uri.parse('${Constants.userFavoriteBaseUrl}/$userId/$id.json?auth=$token'),
      body: jsonEncode(!isFavorite),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load orders');
    }
    isFavorite = !isFavorite;
    notifyListeners();
  }

  toJson() {
    return jsonEncode({
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl
    });
  }
}
