import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/widgets/product_item_widget.dart';

import '../models/product.dart';
import '../models/product_list.dart';

class ProductGridWidget extends StatelessWidget {
  const ProductGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> loadedProducts = Provider.of<ProductList>(context).products;

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
          (ctx, index) => ChangeNotifierProvider(
            create: (_) => loadedProducts[index],
            child: ProductItemWidget(),
          ),
    );
  }
}
