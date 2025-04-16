import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/models/order_list.dart';
import 'package:shop_flutter/widgets/app_drawer.dart';
import 'package:shop_flutter/widgets/order_widget.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    final OrderList orderList = Provider.of<OrderList>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Orders')),
      drawer: AppDrawer(),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemBuilder: (ctx, i) => OrderWidget(order: orderList.items[i]),
                itemCount: orderList.items.length,
              ),
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<OrderList>(context, listen: false).loadOrders().then((_) {
      setState(() => _isLoading = false);
    }).catchError((error) {
      setState(() => _isLoading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load orders: $error.'),
          duration: Duration(seconds: 5),
        ),
      );
    });
  }
}
