import 'package:flutter/material.dart';
import 'package:shop_flutter/models/product.dart';

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
            IconButton(icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
