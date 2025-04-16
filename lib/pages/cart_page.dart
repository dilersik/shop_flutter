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
          Padding(padding: const EdgeInsets.all(8.0), child: _CartButton(cart: cart, orderList: orderList)),
        ],
      ),
    );
  }
}

class _CartButton extends StatefulWidget {
  const _CartButton({super.key, required this.cart, required this.orderList});

  final Cart cart;
  final OrderList orderList;

  @override
  State<_CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<_CartButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator()
        : ElevatedButton(
          onPressed:
              widget.cart.itemsCount == 0
                  ? null
                  : () async {
                    setState(() => _isLoading = true);
                    await widget.orderList.addOrder(widget.cart);
                    widget.cart.clear();
                    setState(() => _isLoading = false);
                  },
          child: const Text('Checkout'),
        );
  }
}
