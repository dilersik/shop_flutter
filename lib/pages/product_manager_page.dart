import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/models/product_list.dart';
import 'package:shop_flutter/utils/app_pages.dart';
import 'package:shop_flutter/widgets/app_drawer_widget.dart';
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
      drawer: AppDrawerWidget(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productList.itemsCount,
            itemBuilder:
                (ctx, i) => Column(
                  children: [
                    ProductManagerItemWidget(product: productList.items[i]),
                    Divider(color: Theme.of(context).colorScheme.outline),
                  ],
                ),
          ),
        ),
      ),
    );
  }

  Future<void> _refreshProducts(BuildContext context) async {
    try {
      await Provider.of<ProductList>(context, listen: false).loadProducts();
    } catch (error) {
      if (!context.mounted) return;
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("An error occurred!"),
          content: const Text("Something went wrong!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text("Okay"),
            ),
          ],
        ),
      );
    }
  }
}
