import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop_flutter/exceptions/auth_exception.dart';

class Auth with ChangeNotifier {
  static const String _key = 'AIzaSyAGZvMYXrwQ8cQDfQ27LZdgMbsVk0Y43x8';
  static const String _baseUrl = 'https://identitytoolkit.googleapis.com/v1/accounts:';

  String? _token;
  String? _email;
  DateTime? _expiryDate;
  String? _userId;

  get token => isAuth ? _token : null;
  get email => isAuth ? _email : null;
  get userId => isAuth ? _userId : null;
  bool get isAuth => _token != null && _expiryDate?.isAfter(DateTime.now()) == true ? true : false;

  Future<void> _authenticate(String email, String password, String urlSegment) async {
    final response = await post(
      Uri.parse('$_baseUrl$urlSegment?key=$_key'),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    final responseData = jsonDecode(response.body);
    if (responseData['error'] != null) {
      throw AuthException(responseData['error']['message']);
    }

    _token = responseData['idToken'];
    _email = responseData['email'];
    _userId = responseData['localId'];
    _expiryDate = DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn'])));
    notifyListeners();
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }

  Future<void> logout() async {
    _token = null;
    _expiryDate = null;
    _userId = null;
    notifyListeners();
  }
}