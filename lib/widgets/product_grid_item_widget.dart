import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/models/cart.dart';
import 'package:shop_flutter/models/product.dart';
import 'package:shop_flutter/pages/app_pages.dart';

class ProductGridItemWidget extends StatelessWidget {
  const ProductGridItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

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
              cart.addItem(product);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Added item to cart!'),
                  duration: const Duration(seconds: 3),
                  action: SnackBarAction(
                    label: 'UNDO',
                    textColor: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Icon(Icons.broken_image, size: 40, color: Colors.grey));
            },
          ),
          onTap: () {
            Navigator.of(context).pushNamed(AppPages.productDetail, arguments: product);
          },
        ),
      ),
    );
  }
}
