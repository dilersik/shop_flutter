import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/models/auth.dart';
import 'package:shop_flutter/models/cart.dart';
import 'package:shop_flutter/models/product.dart';
import 'package:shop_flutter/utils/app_pages.dart';

class ProductGridItemWidget extends StatelessWidget {
  const ProductGridItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder:
                (ctx, product, child) => IconButton(
                  icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
                  onPressed: () async {
                    try {
                      await product.toggleFavorite(auth.token, auth.userId);
                    } catch (error) {
                      if (context.mounted) return;
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: const Text('Error toggling favorite!'), duration: const Duration(seconds: 3)),
                      );
                    }
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
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder: AssetImage("assets/images/placeholder.jpeg"),
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(AppPages.productDetail, arguments: product);
          },
        ),
      ),
    );
  }
}
