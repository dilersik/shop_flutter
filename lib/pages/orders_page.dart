import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/models/order_list.dart';
import 'package:shop_flutter/widgets/app_drawer_widget.dart';
import 'package:shop_flutter/widgets/order_widget.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  // requires StatefulWidget
  // bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    final OrderList orderList = Provider.of<OrderList>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text('Orders')),
      drawer: AppDrawerWidget(),
      body: FutureBuilder(
        future: orderList.loadOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load orders: ${snapshot.error}.'));
          } else {
            return Consumer<OrderList>(
              builder:
                  (ctx, orders, child) => ListView.builder(
                    itemBuilder: (ctx, i) => OrderWidget(order: orderList.items[i]),
                    itemCount: orderList.items.length,
                  ),
            );
          }
        },
      ),
      //     _isLoading
      //         ? Center(child: CircularProgressIndicator())
      //         : ListView.builder(
      //           itemBuilder: (ctx, i) => OrderWidget(order: orderList.items[i]),
      //           itemCount: orderList.items.length,
      //         ),
    );
  }
}
