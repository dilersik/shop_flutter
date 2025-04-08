import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_list.dart';
import '../widgets/product_grid_widget.dart';

enum FilterOptions {
  favorites,
  all,
}

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);

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
              if (value == FilterOptions.favorites) {
                provider.showFavoritesOnly();
              } else {
                provider.showAll();
              }
            }
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to cart
            },
          ),
        ],
      ),
      body: ProductGridWidget(),
    );
  }
}
