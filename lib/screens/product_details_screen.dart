import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_with_auth/Provider/products.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product-details';


  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct=Provider.of<Products>(context,listen: false).findById(productId);
    return Scaffold(
        appBar: AppBar(
        title: Text(loadedProduct.title),
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '\$${loadedProduct.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
