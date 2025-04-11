import 'package:flutter/material.dart';
import 'package:shop_flutter/models/product.dart';

class ProductManagerItemWidget extends StatelessWidget {

  final Product product;

  const ProductManagerItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(product.imageUrl),),
      title: Text(product.name),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
            IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}