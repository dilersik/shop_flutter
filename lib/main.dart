import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/models/cart.dart';
import 'package:shop_flutter/models/order_list.dart';
import 'package:shop_flutter/pages/auth_page.dart';
import 'package:shop_flutter/pages/cart_page.dart';
import 'package:shop_flutter/pages/orders_page.dart';
import 'package:shop_flutter/pages/product_detail_page.dart';
import 'package:shop_flutter/pages/product_form_page.dart';
import 'package:shop_flutter/pages/product_manager_page.dart';
import 'package:shop_flutter/pages/products_overview_page.dart';
import 'package:shop_flutter/utils/app_pages.dart';

import 'models/product_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ProductList()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => OrderList()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.deepPurple,
          ).copyWith(secondary: Colors.deepOrange, outline: Colors.grey.shade300),
          fontFamily: 'Lato',
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontFamily: 'Lato',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            backgroundColor: Colors.purple,
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white, // text color
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              textStyle: const TextStyle(fontSize: 16, fontFamily: "Anton"),
            ),
          ),
        ),
        // home: ProductsOverviewPage(),
        routes: {
          AppPages.auth: (ctx) => AuthPage(),
          AppPages.home: (ctx) => ProductsOverviewPage(),
          AppPages.productDetail: (ctx) => ProductDetailPage(),
          AppPages.productManager: (ctx) => ProductManagerPage(),
          AppPages.productForm: (ctx) => ProductFormPage(),
          AppPages.cart: (ctx) => CartPage(),
          AppPages.orders: (ctx) => OrdersPage(),
        },
      ),
    );
  }
}
