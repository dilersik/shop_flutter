import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/models/product.dart';
import 'package:shop_flutter/pages/app_pages.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder:
                (ctx, product, child) => IconButton(
                  icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
                  onPressed: () {
                    product.toggleFavorite();
                  },
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
          title: Text(product.name, textAlign: TextAlign.center),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Add to cart functionality
            },
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: GestureDetector(
          child: Image.network(product.imageUrl, fit: BoxFit.cover),
          onTap: () {
            Navigator.of(context).pushNamed(AppPages.productDetail, arguments: product);
          },
        ),
      ),
    );
  }
}
