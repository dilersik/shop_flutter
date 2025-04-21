import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/widgets/product_grid_item_widget.dart';

import '../models/product.dart';
import '../models/product_list.dart';

class ProductGridWidget extends StatelessWidget {

  final bool showFavoritesOnly;

  const ProductGridWidget({super.key, required this.showFavoritesOnly});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts = showFavoritesOnly ? provider.favorites : provider.items;

    return GridView.builder(
      padding: EdgeInsets.all(8),
      itemCount: loadedProducts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder:
          (ctx, index) => ChangeNotifierProvider.value(
            value: loadedProducts[index],
            child: ProductGridItemWidget(),
          ),
    );
  }
}
