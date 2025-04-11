import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/models/product_list.dart';
import 'package:shop_flutter/pages/app_pages.dart';
import 'package:shop_flutter/widgets/app_drawer.dart';
import 'package:shop_flutter/widgets/product_manager_item_widget.dart';

class ProductManagerPage extends StatelessWidget {
  const ProductManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductList productList = Provider.of<ProductList>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Products"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppPages.productForm);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productList.productCount,
          itemBuilder:
              (ctx, i) => Column(
                children: [
                  ProductManagerItemWidget(product: productList.products[i]),
                  Divider(color: Theme.of(context).colorScheme.outline),
                ],
              ),
        ),
      ),
    );
  }
}
