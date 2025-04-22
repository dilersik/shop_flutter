import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop_flutter/data/storage.dart';
import 'package:shop_flutter/exceptions/auth_exception.dart';

import '../utils/constants.dart';

class Auth with ChangeNotifier {
  static const String _key = 'AIzaSyAGZvMYXrwQ8cQDfQ27LZdgMbsVk0Y43x8';
  static const String _baseUrl = 'https://identitytoolkit.googleapis.com/v1/accounts:';

  String? _token;
  String? _email;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _logoutTimer;

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

    Storage.saveMap(Constants.userDataPreference, {
      'token': _token,
      'email': _email,
      'userId': _userId,
      'expiryDate': _expiryDate?.toIso8601String(),
    });

    _autoLogout();
    notifyListeners();
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }

  Future<void> tryAutoLogin() async {
    if (isAuth) return;

    final userData = await Storage.getMap(Constants.userDataPreference);
    if (userData.isEmpty) return;

    final expiryDate = DateTime.parse(userData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) return;

    _token = userData['token'];
    _email = userData['email'];
    _userId = userData['userId'];
    _expiryDate = expiryDate;

    _autoLogout();
    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    _email = null;
    _expiryDate = null;
    _userId = null;
    _clearLogoutTimer();
    Storage.removeData(Constants.userDataPreference).then((_) {
      notifyListeners();
    });
  }

  void _clearLogoutTimer() {
    _logoutTimer?.cancel();
    _logoutTimer = null;
  }

  void _autoLogout() {
    _clearLogoutTimer();

    final timeToExpiry = _expiryDate?.difference(DateTime.now()).inSeconds;
    _logoutTimer = Timer(Duration(seconds: timeToExpiry ?? 0), logout);
  }
}