//Dependencies
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

//Screens
import 'package:shopapp/screens/cartScreen.dart';
import 'package:shopapp/screens/productDescriptionScreen.dart';
import 'package:shopapp/screens/productListingScreen.dart';

//Providers
import 'providers/cart_provider.dart';
import 'providers/products_provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductsProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.blue,
          fontFamily: 'Roboto',
        ),
        home: ProductListingScreen(),
        routes: {
          ProductDescriptionScreen.routeName:(ctx) => ProductDescriptionScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
        },
      ),
    );
  }
}
