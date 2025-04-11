import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/order.dart';

class OrderWidget extends StatefulWidget {
  final Order order;

  const OrderWidget({super.key, required this.order});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(
              '\$ ${widget.order.total.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              icon: Icon(Icons.expand_more),
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: widget.order.items.length * 30.0 + 10,
              child: ListView(
                children:
                    widget.order.items
                        .map(
                          (item) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              Text(
                                '${item.quantity} x \$ ${item.price}',
                                style: const TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                        .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
