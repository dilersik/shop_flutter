import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/models/cart.dart';
import 'package:shop_flutter/models/order_list.dart';

import '../widgets/cart_item_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final orderList = Provider.of<OrderList>(context, listen: false);
    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Clear cart action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length, // Replace with your cart item count
              itemBuilder: (context, index) {
                return CartItemWidget(cartItem: items[index]);
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Total'),
            trailing: Chip(
              label: Text("R\$ ${cart.totalAmount}", style: TextStyle(color: Colors.white)),
              backgroundColor: Theme.of(context).primaryColor,
            ), // Replace with your total price
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                orderList.addOrder(cart);
                cart.clear();
              },
              child: const Text('Checkout'),
            ),
          ),
        ],
      ),
    );
  }
}
