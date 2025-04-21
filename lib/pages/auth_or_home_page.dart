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
    // return auth.isAuth ? ProductsOverviewPage() : AuthPage();
    return FutureBuilder(future: auth.tryAutoLogin(), builder: (ctx, snapshot) {;
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return auth.isAuth ? const ProductsOverviewPage() : const AuthPage();
      }
    });
  }

}