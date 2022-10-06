import 'package:flutter/material.dart';
import 'package:shop_with_auth/Provider/products.dart';
import 'product_item.dart';
import 'package:provider/provider.dart';
class ProductsGrid extends StatelessWidget {
  bool? showFavs;
  ProductsGrid({this.showFavs});
  @override
  Widget build(BuildContext context) {
    final productData=Provider.of<Products>(context);
    final products=showFavs! ? productData.favItems: productData.item;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(),
      ),
    );
  }
}