import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/models/product.dart';
import 'package:shop_flutter/widgets/product_item.dart';

import '../models/product_list.dart';

class ProductsOverviewPage extends StatelessWidget {

  const ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> loadedProducts = Provider.of<ProductList>(context).products;

    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: loadedProducts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) => ProductItem(product: loadedProducts[index]),
      ),
    );
  }
}
