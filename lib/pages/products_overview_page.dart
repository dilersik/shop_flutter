import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/pages/app_pages.dart';
import 'package:shop_flutter/widgets/app_drawer.dart';
import 'package:shop_flutter/widgets/badge_widget.dart';

import '../models/cart.dart';
import '../widgets/product_grid_widget.dart';

enum FilterOptions { favorites, all }

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({super.key});

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<ProductList>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder:
                (_) => [
                  PopupMenuItem(value: FilterOptions.favorites, child: Text("Favorites only")),
                  PopupMenuItem(value: FilterOptions.all, child: Text("Show all")),
                ],
            onSelected: (FilterOptions value) {
              setState(() {
                if (value == FilterOptions.favorites) {
                  _showFavoritesOnly = true;
                } else {
                  _showFavoritesOnly = false;
                }
              });
              // if (value == FilterOptions.favorites) {
              //   provider.showFavoritesOnly();
              // } else {
              //   provider.showAll();
              // }
            },
          ),
          Consumer<Cart>(
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(AppPages.cart);
              },
            ),
            builder: (context, cart, child) => BadgeWidget(value: cart.itemsCount.toString(), child: child!),
          ),
        ],
      ),
      body: ProductGridWidget(showFavoritesOnly: _showFavoritesOnly),
      drawer: AppDrawer(),
    );
  }
}
