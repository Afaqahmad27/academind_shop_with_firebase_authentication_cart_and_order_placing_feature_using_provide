import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_with_auth/Provider/cart.dart';
import 'package:shop_with_auth/Provider/orders.dart';
import 'package:shop_with_auth/screens/auth_screen.dart';
import 'package:shop_with_auth/screens/cart_screen.dart';
import 'package:shop_with_auth/screens/orders_screen.dart';
import 'package:shop_with_auth/screens/product_details_screen.dart';
import 'package:shop_with_auth/screens/product_overview_screen.dart';
import 'Provider/products.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) =>Cart(),
        ),
        ChangeNotifierProvider(create: (ctx)=>Orders())
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, userSnapshot) {
            if (userSnapshot.hasData) {
              return ProductsOverviewScreen();
            } else {
              return AuthScreen();
            }
          },
        ),
        routes: {
          ProductsOverviewScreen.routeName: (context)=>ProductsOverviewScreen(),
          ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),
          CartScreen.routeName: (context)=> CartScreen(),
          OrdersScreen.routeName: (context)=>OrdersScreen(),
        },
      ),
    );
  }
}
