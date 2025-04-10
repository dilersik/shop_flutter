import 'package:flutter/material.dart';

import '../models/cart_item.dart';

class CartItemWidget extends StatelessWidget {

  final CartItem cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        // Handle item removal
      },
      child: ListTile(
        leading: CircleAvatar(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: FittedBox(child: Text('\$${cartItem.price}')),
          ),
        ),
        title: Text(cartItem.name),
        subtitle: Text('Total: \$${(cartItem.price * cartItem.quantity)}'),
        trailing: Text('${cartItem.quantity} x'),
      ),
    );
  }

}