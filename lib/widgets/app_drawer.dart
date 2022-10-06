import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_with_auth/screens/product_overview_screen.dart';

import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('AppBar drawer'),
            elevation: 0,
            flexibleSpace: Container(
              decoration:const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.red,
                    Colors.pink,
                    Colors.purple,
                  ])),
            ),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(ProductsOverviewScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}