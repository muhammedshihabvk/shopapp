import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/colorTray.dart';
import 'package:shopapp/providers/cart_provider.dart';
import 'package:shopapp/providers/products_provider.dart';
import 'package:shopapp/screens/cartScreen.dart';
import 'package:shopapp/simple_log_printer.dart';
import 'package:shopapp/widgets/badge.dart';
import 'package:shopapp/widgets/productGridViewItem.dart';

import '../providers/product.dart';

class ProductListingScreen extends StatefulWidget {
  @override
  _ProductListingScreenState createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  final logger = getLogger("ProductListingScreen");
  bool loadingFlag = true;

  bool showFavItems = false;

  @override
  Widget build(BuildContext context) {
    logger.i("PLP build method executed");
    final productProvider = Provider.of<ProductsProvider>(context);
    final productList =
        showFavItems ? productProvider.getFavItems : productProvider.getItems;
    final cart = Provider.of<CartProvider>(context);
    logger.i(productList);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorTray.primaryColour,
          toolbarHeight: 55,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
          ),
          title: Text("MyShop"),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              child: Icon(Icons.search),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return CartScreen();
                    },
                  ));
                },
                child: Badge(
                  child: Icon(Icons.shopping_cart),
                  value: cart.getCartItemCount.toString(),
                  color: ColorTray.cartCountBgColor,
                )),
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              onSelected: (value) {
                logger.e("enter");
                setState(() {
                  logger.d("setstate method invoked ");
                  if (value == "only fav") {
                    logger.d("setstate called for fav");
                    showFavItems = true;
                  } else if (value == "show all") {
                    logger.i("setstate called for all items");
                    showFavItems = false;
                  }
                });
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text("Only favotites"),
                  value: "only fav", //you can use number/string etc
                ),
                PopupMenuItem(
                  child: Text("Show All"),
                  value: "show all",
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height * .9,
          child: GridView.builder(
            // shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            itemCount: productList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 3 / 2,
                crossAxisCount: 2),
            itemBuilder: (context, index) => ChangeNotifierProvider.value(
              value: productList[index],
              child: ProductGridViewItem(),
            ),
          ),
        )
    );
  }
}
