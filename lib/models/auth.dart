import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Auth with ChangeNotifier {
  static const String signupUrl = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAGZvMYXrwQ8cQDfQ27LZdgMbsVk0Y43x8';

  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  bool get isAuth {
    return token != null;
  }

  get token {
    if (_expiryDate != null && _expiryDate?.isAfter(DateTime.now()) == true && _token != null) {
      return _token;
    }
    return null;
  }

  get userId {
    return _userId;
  }

  Future<void> signup(String email, String password) async {
    final response = await post(
      Uri.parse(signupUrl),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
  }

  Future<void> login(String email, String password) async {
    // Implement login logic
  }

  Future<void> logout() async {
    _token = null;
    _expiryDate = null;
    _userId = null;
    notifyListeners();
  }
}