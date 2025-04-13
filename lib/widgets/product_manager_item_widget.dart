import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/models/product.dart';

import '../models/product_list.dart';
import '../pages/app_pages.dart';

class ProductManagerItemWidget extends StatelessWidget {
  final Product product;

  const ProductManagerItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(product.imageUrl)),
      title: Text(product.name),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
              onPressed: () {
                Navigator.of(context).pushNamed(AppPages.productForm, arguments: product);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (ctx) => AlertDialog(
                        title: const Text('Are you sure?'),
                        content: const Text('Do you want to delete this product?'),
                        actions: [
                          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('No')),
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop(true);
                              Provider.of<ProductList>(context, listen: false).removeProduct(product);
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
