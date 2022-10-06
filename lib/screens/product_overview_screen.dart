import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_with_auth/widgets/app_drawer.dart';
import '../Provider/cart.dart';
import '../widgets/badge.dart';
import '../widgets/product_grid.dart';
import 'cart_screen.dart';

class ProductsOverviewScreen extends StatefulWidget {
  ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();

  static const routeName = '/PrdouctsOverviewScreen';
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool showFavoriteOnly=false;

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title:const Text('MY SHOP'),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration:const BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.red,
            Colors.pink,
            Colors.purple,
          ])),
        ),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).primaryIconTheme.color,
                ),
                isDense: true,
                elevation: 1,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(10)),
                items: [
                  DropdownMenuItem(
                      value: 'favorite',
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Favorite',
                              style: TextStyle(fontSize: 13),
                            ),
                            Icon(
                              Icons.favorite_outlined,
                              color: Colors.pink,
                              size: 20,
                            ),
                          ],
                        ),
                      )),
                  DropdownMenuItem(
                      value: 'show all',
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Show All',
                              style: TextStyle(fontSize: 13),
                            ),
                            Icon(
                              Icons.library_add_check_rounded,
                              color: Colors.pink,
                              size: 20,
                            ),
                          ],
                        ),
                      )),
                  DropdownMenuItem(
                      value: 'logout',
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Logout',
                              style: TextStyle(fontSize: 13),
                            ),
                            Icon(
                              Icons.exit_to_app,
                              color: Colors.pink,
                              size: 20,
                            ),
                          ],
                        ),
                      )),
                ],
                onChanged: (value) {
                 setState((){
                   if(value =='favorite'){
                     showFavoriteOnly=true;
                   }
                   else if(value =='show all'){
                     showFavoriteOnly=false;
                   }
                 });
                  if (value == 'logout') {
                    FirebaseAuth.instance.signOut();
                  }
                }),
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch!,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(showFavs: showFavoriteOnly,),
    );
  }
}


