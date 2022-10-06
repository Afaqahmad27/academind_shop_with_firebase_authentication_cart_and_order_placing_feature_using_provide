// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_with_auth/screens/product_details_screen.dart';
import 'package:shop_with_auth/utils/colors.dart';
import '../Provider/cart.dart';
import '../Provider/product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product=Provider.of<Product>(context,listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed(ProductDetailsScreen.routeName, arguments: product.id);
        },
        child:GridTile(
        child:  Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        footer: GridTileBar(
          leading: Consumer<Product>(
            builder: (ctx, product,child)=>IconButton(
              icon: Icon(product.isFavorite ? Icons.favorite: Icons.favorite_border,color: MyColors.secondaryClr,),
              onPressed: () {
                product.toggleFavoriteStatus();
              },
              constraints: BoxConstraints(
                minWidth: 2,
                minHeight: 2,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
          backgroundColor: Colors.black87,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(
              minWidth: 2,
              minHeight: 2,
            ),
            icon: Icon(Icons.shopping_cart,color: MyColors.secondaryClr,),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
            },
          ),
        ),
      ),
      ),
    );
  }
}
