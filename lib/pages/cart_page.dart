import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/models/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

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
              itemCount: 5, // Replace with your cart item count
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage('https://example.com/image.jpg'), // Replace with your image URL
                  ),
                  title: const Text('Product Name'), // Replace with your product name
                  subtitle: const Text('\$19.99'), // Replace with your product price
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: () {
                      // Remove item from cart action
                    },
                  ),
                );
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
                // Checkout action
              },
              child: const Text('Checkout'),
            ),
          ),
        ],
      ),
    );
  }
}
