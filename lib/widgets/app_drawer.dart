import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/utils/app_pages.dart';

import '../models/auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);

    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(AppPages.authOrHome);
            },
          ),
          Divider(color: Theme.of(context).colorScheme.outline),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(AppPages.orders);
            },
          ),
          Divider(color: Theme.of(context).colorScheme.outline),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage Products'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(AppPages.productManager);
            },
          ),
          Divider(color: Theme.of(context).colorScheme.outline),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              auth.logout();
              Navigator.of(context).pushReplacementNamed(AppPages.authOrHome);
            },
          ),
        ],
      ),
    );
  }
}