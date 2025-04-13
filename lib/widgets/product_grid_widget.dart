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
      padding: EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder:
          (ctx, index) => ChangeNotifierProvider.value(
            value: loadedProducts[index],
            child: ProductGridItemWidget(),
          ),
    );
  }
}
