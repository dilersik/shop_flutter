import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/pages/products_overview_page.dart';

import '../models/auth.dart';
import 'auth_page.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return auth.isAuth ? ProductsOverviewPage() : AuthPage();
  }

}