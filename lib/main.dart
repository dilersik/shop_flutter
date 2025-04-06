import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/pages/app_pages.dart';
import 'package:shop_flutter/pages/product_detail_page.dart';
import 'package:shop_flutter/pages/products_overview_page.dart';

import 'models/product_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ProductList(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple).copyWith(secondary: Colors.deepOrange),
          fontFamily: 'Lato',
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(fontFamily: 'Lato', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            backgroundColor: Colors.purple,
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white),
          ),
        ),
        home: ProductsOverviewPage(),
        routes: {AppPages.PRODUCT_DETAIL: (ctx) => ProductDetailPage()},
      ),
    );
  }
}
