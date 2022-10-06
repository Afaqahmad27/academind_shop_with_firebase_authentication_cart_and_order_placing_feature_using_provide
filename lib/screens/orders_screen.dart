import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';
import '../Provider/orders.dart' show Orders;

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData=Provider.of<Orders>(context);
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text('Your Orders'),
          elevation: 0,
          flexibleSpace: Container(
            decoration:const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.red,
                  Colors.pink,
                  Colors.purple,
                ])),
          ),
        ),
      body: ListView.builder(
itemCount: orderData.orders.length,
itemBuilder: (context, index) =>
OrderItem(orderData.orders[index]),
),
    );
  }
}
